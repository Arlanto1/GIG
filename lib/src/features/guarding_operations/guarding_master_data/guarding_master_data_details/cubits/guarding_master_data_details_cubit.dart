import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/vendors_model.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/models/requestModels/guarding_master_data_request.dart';
import 'package:db_atom/src/features/lawenforcement/models/addQualifications.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/constants.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../models/base_user.dart';
import '../../../../../models/responseModels/error_response_validation.dart';
import '../../../../../models/responseModels/generic_create_response.dart';
import '../../../../../utils/util.dart';
import '../../../../createfound/models/emplyee_departments_model.dart';
import '../../../../createfound/models/serial_number_model.dart';
import '../../../../createfound/models/user.dart';
import '../../../../lawenforcement/models/addentities.dart';
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
              loggedInUserDetails: User(),
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

  void onModelValueChange(GuardingMastersDataModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(GuardingMastersDataModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onAddParticipationDate(String participationDate) {
    log('-participationDate---$participationDate-');

    emit(state.copyWith(model: model, status: FormStatus.loading));
    log('-state.participationDates---before---${state.participationDates}----');
    List<String>? dates = state.participationDates ?? [];
    dates.add(participationDate);

    state.copyWith(
      participationDates: dates,
    );

    log('-state.participationDates---after---${state.participationDates}----');
    state.model.csrParticipationDates =
        Utils().joinListWithComma(dates);

    log('-state.guardingMasterData.csrParticipationDates---final---${state.model.csrParticipationDates}----');

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  String _getCurrentDate() {
    return DateFormat(Constants.fulldateFormat).format(DateTime.now());
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

      User loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);

      Analyst users =
          await commonServices.getUsersByRole(roleName: 'T1_Analyst');

      // Get Date of Creation
      state.model.inputDate = _getCurrentDate();

      AddEntities entities =
          await commonServices.getEntities(name: 'ATOM_ENTITIES');

      List<User> entrySecurities = await commonServices.getUsers();
      AddQualifications qualifications =
          await commonServices.getQualification(name: 'GUARD_QUALIFICATIONS');

      GetDepositor emailUsers =
          await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      EmployeeDepartments departments =
          await commonServices.getDepartments(name: 'ATOM_VENDORS');
      Vendors vendors =
      await commonServices.getVendors(name: 'ATOM_VENDORS');
      state.model.entrySecurity = loggedInUserDetails;

      log('-departments-length-----${departments.employeeDepartments?.length}--');
      log('-guardRank--${state.model.guardRank}----');

      List<String> participationDates = Utils().splitStringAfterComma(
          state.model.csrParticipationDates ?? '');
      log('-participationDates---${participationDates.toString()}---');

      emit(
        state.copyWith(
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          model: state.model,
          users: users.t1Analyst,
          vendors: vendors.items,
          entrySecurities: entrySecurities,
          emailUsers: emailUsers.atomStaticUser,
          listOfEntities: entities.atomEntities,
          getEntitiesResponse: entities,
          listOfQualifications: qualifications.guardQualifications,
          getQualificationsResponse: qualifications,
          participationDates: participationDates,
          localAddressAttachments: state.model.localAddressProof !=
                  null
              ? [state.model.localAddressProof ?? CreateImage()]
              : null,

          bioDataAttachments: state.model.bopData != null
              ? [state.model.bopData ?? CreateImage()]
              : null,

          // guardAttachments: state.guardingMasterData.pho !=
          //     null
          //     ? [state.guardingMasterData.bopData ?? CreateImage()]
          //     : null,

          deploymentAttachments: state.model.deploymentOrders,

          permanentAddressAttachments:
              state.model.permanentAddressProof != null
                  ? [
                      state.model.permanentAddressProof ??
                          CreateImage()
                    ]
                  : null,

          pVCAttachments: state.model.pvc,

          trainingAttachments: state.model.trainingCertificates,

          // mSGBAttachments: state.guardingMasterData.m

          medicalAttachments: state.model.medicalCertificates,
        ),
      );
    } catch (e) {
      log('initialization issue',
          error: e, name: 'Guarding Master Data Details Cubit');
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
    Organisation? location,
    BaseUser? user,
    Organisation? vendor,
    BaseUser? guard,
    Organisation? entity,
    List<Organisation>? qualifications,
    int? status,
    int? systemAccess,
    int? guardRank,
    int? dutyType,
    int? gender,
    int? maritalStatus,
    int? typeOfDeployment,
    int? msgbFormBSubmitted,
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

    state.model.entity = entity ?? state.model.entity;
    state.model.qualifications =
        qualifications ?? state.model.qualifications;
    state.model.vendor = vendor ?? state.model.vendor;
    state.model.guardRank =
        guardRank ?? state.model.guardRank;
    state.model.dutyType =
        dutyType ?? state.model.dutyType;
    state.model.gender = gender ?? state.model.gender;
    state.model.maritalStatus =
        maritalStatus ?? state.model.maritalStatus;
    state.model.systemAccess =
        systemAccess ?? state.model.systemAccess;
    state.model.status = status ?? state.model.status;
    state.model.typeOfDeployment =
        typeOfDeployment ?? state.model.typeOfDeployment;
    state.model.msgbFormBSubmitted =
        msgbFormBSubmitted ?? state.model.msgbFormBSubmitted;

    // TODO: Object issue
    if (guard != null) {
      User userDetails = User(
          name: guard.name, userId: guard.id, userName: guard.name);
      state.model.guard = userDetails;
    }
    emit(state.copyWith(
      model: state.model,
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
          model: state.model,
          guardAttachments: guardImages,
          status: FormStatus.initial,
        ),
      );
    }

    if (deploymentFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          deploymentAttachments: deploymentFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (bioDataFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          bioDataAttachments: bioDataFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (permanentAddressFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          permanentAddressAttachments: permanentAddressFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (localAddressFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          localAddressAttachments: localAddressFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (pVCFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          pVCAttachments: pVCFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (trainingFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          trainingAttachments: trainingFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (mSGBExemptionFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          mSGBAttachments: mSGBExemptionFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (medicalFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          model: state.model,
          medicalAttachments: medicalFiles,
          status: FormStatus.initial,
        ),
      );
    }

    emit(
      state.copyWith(
        eventId: eventIds,
        model: state.model,
        loadAttachments: data,
        guardAttachments: guardImages,
        status: FormStatus.initial,
      ),
    );

    log('--state.status--3--${state.status}----');
  }

  void showFields({
    bool? deploymentOrderSubmitted,
    bool? trainingCertificateProvided,
    bool? csrParticipation,
    bool? specialAchievement,
    bool? msgbExempted,
  }) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    if (deploymentOrderSubmitted != null) {
      state.model.deploymentOrderSubmitted =
          deploymentOrderSubmitted;
    }
    if (trainingCertificateProvided != null) {
      state.model.trainingCertificateProvided =
          trainingCertificateProvided;
    }
    if (csrParticipation != null) {
      state.model.csrParticipation = csrParticipation;
    }
    if (specialAchievement != null) {
      state.model.specialAchievement = specialAchievement;
    }
    if (msgbExempted != null) {
      state.model.msgbExempted = msgbExempted;
    }
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    if (state.model.status == 0 ||
        state.model.status == null) {
      state.model.status = 1;
    }
    // Setting time in milliseconds
    state.model.inputDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // Create/Update API Call
    GuardingMasterDataRequest request =
        GuardingMasterDataRequest(guardingMasterData: state.model);

    GenericCreateResponse response = GenericCreateResponse();
    try {
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
            body: request, isSubmit: true));
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
