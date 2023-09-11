import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/event_protection/models/event_protection_model.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:db_atom/src/features/lawenforcement/models/addQualifications.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/models/department.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/models/location.dart';
import 'package:db_atom/src/models/responseModels/generic_creat_response.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/constants.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../models/entry_security.dart';
import '../../../../../utils/util.dart';

part 'general_info_state.dart';

class GeneralInfoCubit extends Cubit<GeneralInfoState> {
  final EventProtectionServices services;
  final EventProtectionModel? model;
  final CommonServices commonServices;

  GeneralInfoCubit({
    required this.services,
    required this.commonServices,
    required this.model,
  }) : super(
          GeneralInfoState.initial(
              model: model ?? EventProtectionModel(),
              locations: GetLocations(),
              loggedInUserDetails: EntrySecurity(),
              users: const [],
              emailUsers: const [],
              errorMessage: '',
              loadAttachments: const [],
              eventId: null,
              listOfEntities: const [],
              getEntitiesResponse: null,
              departments: const [],
              listOfQualifications: const [],
              getQualificationsResponse: null),
        );

  void onModelValueChange(EventProtectionModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(guardingMasterData: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(EventProtectionModel model) {
    emit(state.copyWith(guardingMasterData: model, status: FormStatus.loading));

    emit(state.copyWith(guardingMasterData: model, status: FormStatus.initial));
  }

  Future<void> initializeValues() async {
    log('-status-1-${state.status}--');
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
      state.model.inputDate = Utils().getCurrentDate();

      AddEntities entities =
          await commonServices.getEntities(name: 'ATOM_ENTITIES');

      List<GetUserDetails> entrySecurities = await commonServices.getUsers();
      AddQualifications qualifications =
          await commonServices.getQualification(name: 'GUARD_QUALIFICATIONS');

      GetDepositor emailUsers =
          await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      EmployeeDepartments departments =
          await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          guardingMasterData: state.model,
          users: users.t1Analyst,
          departments: departments.employeeDepartments,
          entrySecurities: entrySecurities,
          emailUsers: emailUsers.atomStaticUser,
          listOfEntities: entities.atomEntities,
          getEntitiesResponse: entities,
          listOfQualifications: qualifications.guardQualifications,
          getQualificationsResponse: qualifications,
        ),
      );
    } catch (e) {
      log('initialization issue', error: e, name: 'Guarding Master Data Cubit');
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
    List<Entity>? entities,
    Location? location,
    BaseUser? user,
    Department? vendor,
    BaseUser? guard,
    Entity? entity,
    List<Entity>? qualifications,
    int? status,
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
        moduleCode: Constants.guardingMasterDataModule,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo;
    }
    state.model.status = status ?? state.model.status;

    if (entities != null) {
      state.model.entities = entities;
    }


    emit(state.copyWith(
      guardingMasterData: state.model,
      status: FormStatus.initial,
    ));
  }

  void addAttachment({
    List<CreateImage>? data,
    List<CreateImage>? guardImages,
    List<CreateImage>? deploymentFiles,
    List<CreateImage>? bioDataFiles,
    List<CreateImage>? permanentAddressFiles,
    List<CreateImage>? localAddressFiles,
    List<CreateImage>? pVCFiles,
    List<CreateImage>? trainingFiles,
    List<CreateImage>? mSGBExemptionFiles,
    List<CreateImage>? medicalFiles,
    List<CreateImage>? mSGBAttachments,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);

    log('--guardImages---${guardImages?.length}----');
    if (guardImages != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.model,
          guardAttachments: guardImages,
          status: FormStatus.initial,
        ),
      );
    }

    if (deploymentFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.model,
          deploymentAttachments: deploymentFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (bioDataFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.model,
          bioDataAttachments: bioDataFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (permanentAddressFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.model,
          permanentAddressAttachments: permanentAddressFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (localAddressFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.model,
          localAddressAttachments: localAddressFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (pVCFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.model,
          pVCAttachments: pVCFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (trainingFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.model,
          trainingAttachments: trainingFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (mSGBExemptionFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.model,
          mSGBAttachments: mSGBExemptionFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (medicalFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.model,
          medicalAttachments: medicalFiles,
          status: FormStatus.initial,
        ),
      );
    }

    emit(
      state.copyWith(
        eventId: eventIds,
        guardingMasterData: state.model,
        loadAttachments: data,
        guardAttachments: guardImages,
        status: FormStatus.initial,
      ),
    );

    log('--state.status--3--${state.status}----');
  }

  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 1;
    }
    // Setting time in milliseconds
    state.model.inputDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // Create/Update API Call
    // GuardingMasterDataRequest request =
    //     GuardingMasterDataRequest(guardingMasterData: state.model);

    GenericCreateResponse response = GenericCreateResponse();
    try {
      if (isSaveOnly) {
        // response = (await services.createGuardingMasterData(
        //     body: request, isSubmit: false));
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
        // response = (await services.createGuardingMasterData(
        //     body: request, isSubmit: true));
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }

    print('---response--msg--${response.message}---');

    emit(
      state.copyWith(
        message: response.message,
        status: FormStatus.success,
      ),
    );
  }
}
