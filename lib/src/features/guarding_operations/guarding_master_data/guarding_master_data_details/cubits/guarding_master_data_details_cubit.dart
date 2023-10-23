import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/models/requestModels/guarding_master_data_request.dart';
import 'package:db_atom/src/features/lawenforcement/models/addQualifications.dart';
import 'package:db_atom/src/models/entity.dart';
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
    emit(state.copyWith(guardingMasterData: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(GuardingMastersDataModel model) {
    emit(state.copyWith(guardingMasterData: model, status: FormStatus.loading));

    emit(state.copyWith(guardingMasterData: model, status: FormStatus.initial));
  }

  void onAddParticipationDate(String participationDate) {
    log('-participationDate---$participationDate-');

    emit(state.copyWith(guardingMasterData: model, status: FormStatus.loading));
    log('-state.participationDates---before---${state.participationDates}----');
    List<String>? dates = state.participationDates ?? [];
    dates.add(participationDate);

    state.copyWith(
      participationDates: dates,
    );

    log('-state.participationDates---after---${state.participationDates}----');
    state.guardingMasterData.csrParticipationDates =
        Utils().joinListWithComma(dates);

    log('-state.guardingMasterData.csrParticipationDates---final---${state.guardingMasterData.csrParticipationDates}----');

    emit(state.copyWith(guardingMasterData: model, status: FormStatus.initial));
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
      state.guardingMasterData.inputDate = _getCurrentDate();

      AddEntities entities =
          await commonServices.getEntities(name: 'ATOM_ENTITIES');

      List<User> entrySecurities = await commonServices.getUsers();
      AddQualifications qualifications =
          await commonServices.getQualification(name: 'GUARD_QUALIFICATIONS');

      GetDepositor emailUsers =
          await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      EmployeeDepartments departments =
          await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');
      state.guardingMasterData.entrySecurity = loggedInUserDetails;

      log('-departments-length-----${departments.employeeDepartments?.length}--');
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
          departments: departments.employeeDepartments,
          entrySecurities: entrySecurities,
          emailUsers: emailUsers.atomStaticUser,
          listOfEntities: entities.atomEntities,
          getEntitiesResponse: entities,
          listOfQualifications: qualifications.guardQualifications,
          getQualificationsResponse: qualifications,
          participationDates: participationDates,
          localAddressAttachments: state.guardingMasterData.localAddressProof !=
                  null
              ? [state.guardingMasterData.localAddressProof ?? CreateImage()]
              : null,

          bioDataAttachments: state.guardingMasterData.bopData != null
              ? [state.guardingMasterData.bopData ?? CreateImage()]
              : null,

          // guardAttachments: state.guardingMasterData.pho !=
          //     null
          //     ? [state.guardingMasterData.bopData ?? CreateImage()]
          //     : null,

          deploymentAttachments: state.guardingMasterData.deploymentOrders,

          permanentAddressAttachments:
              state.guardingMasterData.permanentAddressProof != null
                  ? [
                      state.guardingMasterData.permanentAddressProof ??
                          CreateImage()
                    ]
                  : null,

          pVCAttachments: state.guardingMasterData.pvc,

          trainingAttachments: state.guardingMasterData.trainingCertificates,

          // mSGBAttachments: state.guardingMasterData.m

          medicalAttachments: state.guardingMasterData.medicalCertificates,
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
    Entity? entity,
    List<Entity>? qualifications,
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

      state.guardingMasterData.location = location;
      state.guardingMasterData.slNo = slNo.serialNo;
    }

    state.guardingMasterData.entity = entity ?? state.guardingMasterData.entity;
    state.guardingMasterData.qualifications =
        qualifications ?? state.guardingMasterData.qualifications;
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
    state.guardingMasterData.status = status ?? state.guardingMasterData.status;
    state.guardingMasterData.typeOfDeployment =
        typeOfDeployment ?? state.guardingMasterData.typeOfDeployment;
    state.guardingMasterData.msgbFormBSubmitted =
        msgbFormBSubmitted ?? state.guardingMasterData.msgbFormBSubmitted;

    // TODO: Object issue
    if (guard != null) {
      User userDetails = User(
          name: guard.name, userId: guard.id, userName: guard.name);
      state.guardingMasterData.guard = userDetails;
    }
    emit(state.copyWith(
      guardingMasterData: state.guardingMasterData,
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
          guardingMasterData: state.guardingMasterData,
          guardAttachments: guardImages,
          status: FormStatus.initial,
        ),
      );
    }

    if (deploymentFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.guardingMasterData,
          deploymentAttachments: deploymentFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (bioDataFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.guardingMasterData,
          bioDataAttachments: bioDataFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (permanentAddressFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.guardingMasterData,
          permanentAddressAttachments: permanentAddressFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (localAddressFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.guardingMasterData,
          localAddressAttachments: localAddressFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (pVCFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.guardingMasterData,
          pVCAttachments: pVCFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (trainingFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.guardingMasterData,
          trainingAttachments: trainingFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (mSGBExemptionFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.guardingMasterData,
          mSGBAttachments: mSGBExemptionFiles,
          status: FormStatus.initial,
        ),
      );
    }

    if (medicalFiles != null) {
      emit(
        state.copyWith(
          eventId: eventIds,
          guardingMasterData: state.guardingMasterData,
          medicalAttachments: medicalFiles,
          status: FormStatus.initial,
        ),
      );
    }

    emit(
      state.copyWith(
        eventId: eventIds,
        guardingMasterData: state.guardingMasterData,
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
    if (msgbExempted != null) {
      state.guardingMasterData.msgbExempted = msgbExempted;
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

    if (state.guardingMasterData.status == 0 ||
        state.guardingMasterData.status == null) {
      state.guardingMasterData.status = 1;
    }
    // Setting time in milliseconds
    state.guardingMasterData.inputDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // Create/Update API Call
    GuardingMasterDataRequest request =
        GuardingMasterDataRequest(guardingMasterData: state.guardingMasterData);

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
