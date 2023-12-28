import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/vendors_model.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/models/gm_ui_labels.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/key_management_master_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/requestModels/key_management_master_request.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/models/duty_post_master_model.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/models/requestModel/duty_post_master_request.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/services/duty_post_master_services.dart';
import 'package:db_atom/src/features/lawenforcement/models/addQualifications.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:intl/intl.dart';

import '../../../../../../../index.dart';
import '../../../../../createfound/models/emplyee_departments_model.dart';
import '../../../../../passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';

part 'duty_post_master_details_state.dart';

class DutyPostMasterDetailsCubit extends Cubit<DutyPostMasterDetailsState> {
  final DutyPostMasterServices services;
  final DutyPostMasterModel? model;
  final CommonServices commonServices;

  DutyPostMasterDetailsCubit({
    required this.services,
    required this.commonServices,
    required this.model,
  }) : super(
          DutyPostMasterDetailsState.initial(
              model: model ?? DutyPostMasterModel(),
              locations: Locations(),
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

  void onModelValueChange(DutyPostMasterModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(DutyPostMasterModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onAddParticipationDate(String participationDate) {
    emit(state.copyWith(model: model, status: FormStatus.loading));
    List<String>? dates = state.participationDates ?? [];
    dates.add(participationDate);

    state.copyWith(
      participationDates: dates,
    );

    state.model.csrParticipationDates = Utils().joinListWithComma(dates);
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  String _getCurrentDate() {
    return DateFormat(Constants.fulldateFormat).format(DateTime.now());
  }

  Future<void> initializeValues() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    var userId = await SharedPrefs.getUserId();
    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getLocations(name: 'ATOM_LOCATIONS'),
        commonServices.getUserDetails(userId: userId),
        commonServices.getUsersByRole(roleName: 'T1_Analyst'),
        commonServices.getEntities(name: 'ATOM_ENTITIES'),
        commonServices.getUsers(),
        commonServices.getQualification(name: 'GUARD_QUALIFICATIONS'),
        commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER'),
        commonServices.getDepartments(name: 'ATOM_VENDORS'),
        commonServices.getVendors(name: 'ATOM_VENDORS'),
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.guardingMasterModuleCode),
        SharedPrefs.getDefaultLocation(),
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      Analyst users = futures[2];
      AddEntities entities = futures[3];
      List<User> entrySecurities = futures[4];
      AddQualifications qualifications = futures[5];
      GetDepositor emailUsers = futures[6];
      EmployeeDepartments departments = futures[7];
      Vendors vendors = futures[8];
      dynamic responseLabels = futures[9];
      Organisation? defaultLocation = futures[10];
      if (state.model.location == null && defaultLocation != null) {
        SerialNumberModel slNo = await commonServices.getSlNo(
          locationId: defaultLocation.id.toString(),
          moduleCode: Constants.contactDetailsModule,
        );
        state.model.location = defaultLocation;
        state.model.slNo = slNo.serialNo;
      }
      state.model.entrySecurity = loggedInUserDetails;
      // Get Date of Creation
      state.model.inputDate = _getCurrentDate();

      dynamic participationDates = Utils()
          .splitStringAfterComma(state.model.csrParticipationDates ?? '');

      log('-participationDates---${participationDates.toString()}---');

      GmUiLabels labels = GmUiLabels.fromJson(responseLabels);

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
          localAddressAttachments: state.model.localAddressProof != null
              ? [state.model.localAddressProof ?? ImageContent()]
              : null,
          bioDataAttachments: state.model.bopData != null
              ? [state.model.bopData ?? ImageContent()]
              : null,
          deploymentAttachments: state.model.deploymentOrders,
          permanentAddressAttachments: state.model.permanentAddressProof != null
              ? [state.model.permanentAddressProof ?? ImageContent()]
              : null,
          pVCAttachments: state.model.pvc,
          trainingAttachments: state.model.trainingCertificates,
          medicalAttachments: state.model.medicalCertificates,
          labels: labels,
        ),
      );
    } catch (e) {
      log('Initialization issue',
          error: e, name: 'Guarding Master Data Details Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
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
    state.model.qualifications = qualifications ?? state.model.qualifications;
    state.model.vendor = vendor ?? state.model.vendor;
    state.model.guardRank = guardRank ?? state.model.guardRank;
    state.model.dutyType = dutyType ?? state.model.dutyType;
    state.model.gender = gender ?? state.model.gender;
    state.model.maritalStatus = maritalStatus ?? state.model.maritalStatus;
    state.model.systemAccess = systemAccess ?? state.model.systemAccess;
    state.model.status = status ?? state.model.status;
    state.model.typeOfDeployment =
        typeOfDeployment ?? state.model.typeOfDeployment;
    state.model.msgbFormBSubmitted =
        msgbFormBSubmitted ?? state.model.msgbFormBSubmitted;

    // TODO: Object issue
    if (guard != null) {
      User userDetails =
          User(name: guard.name, userId: guard.id, userName: guard.name);
      state.model.guard = userDetails;
    }
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void addAttachment({
    List<ImageContent>? data,
    List<ImageContent>? guardImages,
    List<ImageContent>? deploymentFiles,
    List<ImageContent>? bioDataFiles,
    List<ImageContent>? permanentAddressFiles,
    List<ImageContent>? localAddressFiles,
    List<ImageContent>? pVCFiles,
    List<ImageContent>? trainingFiles,
    List<ImageContent>? mSGBExemptionFiles,
    List<ImageContent>? medicalFiles,
    List<ImageContent>? mSGBAttachments,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    int eventIds = math.Random.secure().nextInt(5);

    log('--guardImages---${guardImages?.length}----');
    if (guardImages != null) {
      state.model.photoGraph = guardImages.first;
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
      state.model.deploymentOrders = deploymentFiles;
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
      state.model.bopData = bioDataFiles.first;
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
      state.model.permanentAddressProof = permanentAddressFiles.first;
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
      state.model.localAddressProof = localAddressFiles.first;
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
      state.model.pvc = pVCFiles;
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
      state.model.trainingCertificates = trainingFiles;

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
      log('---medicalFiles---------${medicalFiles.length}---');
      state.model.medicalCertificates = medicalFiles;
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
      state.model.deploymentOrderSubmitted = deploymentOrderSubmitted;
    }
    if (trainingCertificateProvided != null) {
      state.model.trainingCertificateProvided = trainingCertificateProvided;
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

    if (state.model.status == 0 || state.model.status == null) {
      state.model.status = 1;
    }
    // Setting time in milliseconds
    state.model.inputDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    // Create/Update API Call
    DutyPostMasterRequest request =
        DutyPostMasterRequest(dutyPostMaster: state.model);

    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.error,
              message: state.isValidDraft.message,
            ),
          );
          return;
        }
        response = (await services.createDutyPostMaster(
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
        response = (await services.createDutyPostMaster(
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
