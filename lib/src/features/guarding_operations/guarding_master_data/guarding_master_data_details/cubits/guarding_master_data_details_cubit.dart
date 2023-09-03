import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/models/requestModels/guarding_master_data_request.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/models/location.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/constants.dart';
import '../../../../../models/base_user.dart';
import '../../../../../models/department.dart';
import '../../../../../models/entry_security.dart';
import '../../../../../models/responseModels/generic_creat_response.dart';
import '../../../../createfound/models/serial_number_model.dart';
import '../../../../lawenforcement/models/addentities.dart';
import '../../../../material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import '../../../../passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import '../../models/guarding_master_data_model.dart';
import '../../services/guarding_master_data_services.dart';

part 'guarding_master_data_details_state.dart';

class GuardingMasterDataDetailsCubit
    extends Cubit<GuardingMasterDataDetailsState> {
  final GuardingMasterDataServices services;
  final GuardingMastersDataModel? model;
  final CommonServices commonServices;

  GuardingMasterDataDetailsCubit({
    required this.services,
    required this.commonServices,
    required this.model,
  }) : super(
          GuardingMasterDataDetailsState.initial(
              model: model ?? GuardingMastersDataModel(),
              locations: GetLocations(),
              loggedInUserDetails: EntrySecurity(),
              users: const [],
              emailUsers: const [],
              errorMessage: '',
              loadAttachments: const [],
              eventId: null,
              listOfEntities: const [],
              getEntitiesResponse: null,
              departments: const []),
        );

  void onModelValueChange(GuardingMastersDataModel model) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    emit(state.copyWith(guardingMasterData: model, status: FormStatus.initial));
  }

  String _getCurrentDate() {
    return DateFormat(Constants.fulldateFormat).format(DateTime.now());
  }

  Future<void> initializeValues() async {
    print('-status-1-${state.status}--');
    //Show Loader and emit loading state
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    var userId = await SharedPrefs.getUserId();
    try {
      GetLocations getLocationsData =
          await commonServices.getLocations(name: 'ATOM_LOCATIONS');

      EntrySecurity loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);

      Analyst users =
          await commonServices.getUsersByRole(roleName: 'T1_Analyst');

      // Get Date of Creation
      state.guardingMasterData.inputDate = _getCurrentDate();

      AddEntities entities =
          await commonServices.getEntities(name: 'ATOM_ENTITIES');

      GetDepositor emailUsers =
          await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      state.guardingMasterData.entrySecurity = loggedInUserDetails;

      log('-guardRank--${state.guardingMasterData.guardRank}----');

      List<String> participationDates = Utils().splitStringAfterComma(
          state.guardingMasterData.csrParticipationDates ?? '');
      log('-participationDates---${participationDates.toString()}---');

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          guardingMasterData: state.guardingMasterData,
          users: users.t1Analyst,
          emailUsers: emailUsers.atomStaticUser,
          listOfEntities: entities.atomEntities,
          getEntitiesResponse: entities,
          participationDates: participationDates,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          message: Constants.errorText,
          // TODO: error message should be dynamic
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> updateDropdownValues({
    Location? location,
    BaseUser? user,
    Department? vendor,
    List<Entity>? entities,
    int? systemAccess,
    int? guardRank,
    int? dutyType,
    int? gender,
    int? maritalStatus,
    int? typeOfDeployment,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    ////Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.materialMovementInwardNonReturnableModule,
      );

      state.guardingMasterData.location = location;
      state.guardingMasterData.slNo = slNo.serialNo;
    }

    state.guardingMasterData.entities =
        entities ?? state.guardingMasterData.entities;
    state.guardingMasterData.vendor = vendor ?? state.guardingMasterData.vendor;
    state.guardingMasterData.guardRank =
        guardRank ?? state.guardingMasterData.guardRank;
    state.guardingMasterData.dutyType =
        dutyType ?? state.guardingMasterData.dutyType;
    state.guardingMasterData.gender = gender ?? state.guardingMasterData.gender;
    state.guardingMasterData.maritalStatus =
        maritalStatus ?? state.guardingMasterData.maritalStatus;
    state.guardingMasterData.systemAccess =
        systemAccess ?? state.guardingMasterData.systemAccess;
    state.guardingMasterData.typeOfDeployment =
        typeOfDeployment ?? state.guardingMasterData.typeOfDeployment;

    emit(state.copyWith(
      guardingMasterData: state.guardingMasterData,
      status: FormStatus.initial,
    ));
  }

  void addAttchment(List<CreateImage>? data) async {
    print('--state.status-1---${state.status}----');

    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);

    print('--data----${data?.length}----');
    print('--state.status-2---${state.status}----');

    emit(state.copyWith(
      eventId: eventIds,
      guardingMasterData: state.guardingMasterData,
      loadAttachments: data,
      status: FormStatus.initial,
    ));

    print('--state.status--3--${state.status}----');
  }

  void showFields(
      {bool? deploymentOrderSubmitted,
      bool? trainingCertificateProvided,
      bool? csrParticipation,
      bool? specialAchievement}) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    if (deploymentOrderSubmitted != null) {
      state.guardingMasterData.deploymentOrderSubmitted =
          deploymentOrderSubmitted;
    }
    if (trainingCertificateProvided != null) {
      state.guardingMasterData.trainingCertificateProvided =
          trainingCertificateProvided;
    }
    if (csrParticipation != null) {
      state.guardingMasterData.csrParticipation = csrParticipation;
    }
    if (specialAchievement != null) {
      state.guardingMasterData.specialAchievement = specialAchievement;
    }
    emit(state.copyWith(
      guardingMasterData: state.guardingMasterData,
      status: FormStatus.initial,
    ));
  }

  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // Setting time in milliseconds
    state.guardingMasterData.inputDate =
        (DateTime.now().millisecondsSinceEpoch / 1000).toString();

    // Create/Update API Call
    GuardingMasterDataRequest request =
        GuardingMasterDataRequest(guardingMasterData: state.guardingMasterData);

    try {
      GenericCreateResponse response = GenericCreateResponse();
      if (isSaveOnly) {
        response = (await services.createGuardingMasterData(
            body: request, isSubmit: false));
      } else {
        //Validating Fields
        if (!state.isValid.status) {
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await services.createGuardingMasterData(
            body: request, isSubmit: true)) as GenericCreateResponse;
      }

      print('---response--msg--${response.message}---');

      emit(
        state.copyWith(
          message: response.message,
          status: FormStatus.success,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }
  }
}
