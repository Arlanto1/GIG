import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/models/occ_ui_labels.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/models/requestModel/general_info_request.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/services/occurrences_services.dart';
import 'package:intl/intl.dart';

part 'occurrence_general_info_state.dart';

class OccurrenceGeneralInfoCubit extends Cubit<OccurrenceGeneralInfoState> {
  final OccurrenceDetailsServices services;
  final String id;
  final CommonServices commonServices;
  final OccurrenceModel? model;

  OccurrenceGeneralInfoCubit({
    required this.services,
    required this.commonServices,
    required this.id,
    this.model,
  }) : super(
          OccurrenceGeneralInfoState.initial(
            model: OccurrenceModel(),
            locations: Locations(),
            users: const [],
            shiftTakenOverBy: const [],
            errorMessage: '',
            loadAttachments: const [],
            eventId: null,
            listOfEntities: const [],
            getEntitiesResponse: null,
            departments: const [],
            loggedInUserDetails: null,
          ),
        );

  void onModelValueChange(OccurrenceModel occurrence) {
    emit(state.copyWith(model: occurrence, status: FormStatus.initial));
  }

  Future<void> isFormReadable() async {
    emit(state.copyWith(status: FormStatus.loading));
    if (state.model.status != ConstantsIntValue.submitted) {
      emit(state.copyWith(
        status: FormStatus.initial,
      ));
      return;
    }
    bool isReadOnly;
    if (state.model.handoverSecurity!.userName
        .equalsIgnoreCase(state.loggedInUserDetails?.userName)) {
      isReadOnly = false;
    } else {
      isReadOnly = true;
    }

    emit(state.copyWith(
      isReadOnly: isReadOnly,
      status: FormStatus.initial,
    ));
  }

  void onCheckBoxChange(OccurrenceModel occurrence) {
    emit(state.copyWith(model: occurrence, status: FormStatus.loading));

    emit(state.copyWith(model: occurrence, status: FormStatus.initial));
  }

  Future<void> refreshList() async {
    emit(state.copyWith(status: FormStatus.loading));
    List<BaseUser>? shiftTakenOverBy = await commonServices.getBaseUsersByRoles(
        roleNames: ConstantUserRoles.atomGuardingStaffUser,
        locationId: model!.location!.id!);

    emit(
      state.copyWith(
        status: FormStatus.initial,
        shiftTakenOverBy: shiftTakenOverBy,
      ),
    );
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
      OccurrenceModel model = OccurrenceModel();
      if (!id.isEmptyOrNull) {
        model = await OccurrenceDetailsServices().getOccurrence(id);
      }

      log('--model.status--11111-${model.status}-');

      Locations getLocationsData =
          await commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS');

      User loggedInUserDetails =
          await commonServices.getUserDetails(userId: userId);

      ///Get Date of Creation
      model.inputDate = model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);

      AddEntities entities =
          await commonServices.getEntities(name: 'ATOM_ENTITIES');

      // List<User> entrySecurities = await commonServices.getUsers();
      bool isOnGoingPowerFailure = false;

      if (model.location == null) {
        Organisation? defaultLocation = await SharedPrefs.getDefaultLocation();
        if (defaultLocation != null) {
          SerialNumberModel slNo = await commonServices.getSlNo(
            locationId: defaultLocation.id.toString(),
            moduleCode: Constants.occurrenceModule,
          );
          model.location = defaultLocation;
          model.slNo = slNo.serialNo;

          PowerFailureModel powerFailureModel =
              await services.getOccPowerFailure(
                  locationId: model.location?.id.toString() ?? '');

          StringResponse followUp = await services.getOccFollowUp(
              locationId: model.location?.id.toString() ?? '');

          if (!followUp.comments.isEmptyOrNull) {
            model.comments = followUp.comments;
          }
          log('-powerFailureModel.powerFailureStartDate--${powerFailureModel.powerFailureStartDate}-');
          if (powerFailureModel.powerFailureStartDate != null) {
            model.powerFailure = true;
            PowerFailureModel powerFailure = PowerFailureModel();
            powerFailure.powerFailureStartDate =
                Utils.timestampToDateConversion(
                    int.tryParse(powerFailureModel.powerFailureStartDate ?? ''),
                    Constants.fulldateFormat);

            isOnGoingPowerFailure = true;
            if (model.powerFailures.isEmptyOrNull) {
              model.powerFailures = [];
            }

            model.powerFailures?.add(powerFailure);
          }
        }
      }
      model.entrySecurity ??= loggedInUserDetails;
      List<BaseUser>? shiftTakenOverBy =
          await commonServices.getBaseUsersByRoles(
              roleNames: ConstantUserRoles.atomGuardingStaffUser,
              locationId: model.location!.id!);
      EmployeeDepartments departments =
          await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');
      model.status ?? 0;

      log('--model.status---${model.status}-');

      emit(
        state.copyWith(
          model: model,
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          shiftTakenOverBy: shiftTakenOverBy,
          departments: departments.employeeDepartments,
          // entrySecurities: entrySecurities,
          listOfEntities: entities.atomEntities,
          getEntitiesResponse: entities,
          isOnGoingPowerFailure: isOnGoingPowerFailure,
        ),
      );
      isFormReadable();
    } catch (e) {
      log('initialization issue', error: e, name: 'General Information Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
          // TODO: error message should be dynamic
          status: FormStatus.error,
        ),
      );
    }
  }

  Future<void> updateLocationDropdownValue({
    Organisation? location,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    List<BaseUser>? shiftTakenOverBy = [];

    /// Get Sl No from API
    if (location != null) {
      log('Update Location');
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.occurrenceModule,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';
      shiftTakenOverBy = await commonServices.getBaseUsers(
          roleName: ConstantUserRoles.atomGuardingStaffUser,
          locationId: location.id!);
    }
    state.model.handoverSecurity = null;

    emit(state.copyWith(
      model: state.model,
      shiftTakenOverBy: shiftTakenOverBy,
      status: FormStatus.initial,
    ));
  }

  Future<void> updateDropdownValues({
    List<Organisation>? entities,
    Organisation? location,
    BaseUser? shiftTakenOverBy,
    int? status,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // Get Sl No from API
    if (location != null) {
      SerialNumberModel slNo = await commonServices.getSlNo(
        locationId: location.id.toString(),
        moduleCode: Constants.occurrenceModule,
      );

      state.model.location = location;
      state.model.slNo = slNo.serialNo ?? '';
    }

    if (status != null) {
      state.model.status = status;
    }
    if (shiftTakenOverBy != null) {
      User userDetails = User(
        name: shiftTakenOverBy.name,
        userId: shiftTakenOverBy.id,
        userName: shiftTakenOverBy.name,
        email: shiftTakenOverBy.email,
      );
      state.model.handoverSecurity = userDetails;
    }
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  void addAttachment({
    List<ImageContent>? data,
    List<ImageContent>? guardImages,
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
          status: FormStatus.initial,
        ),
      );
    }

    emit(
      state.copyWith(
        eventId: eventIds,
        model: state.model,
        status: FormStatus.initial,
      ),
    );

    log('--state.status--3--${state.status}----');
  }

  void showFields({
    bool? shiftBrfngAttnded,
    bool? premisesRoundTkn,
    bool? medicalEmrgncy,
    bool? materialMovement,
    bool? leoVisit,
    bool? socialEnggIncdnt,
    bool? foundArticleTrnsctn,
    bool? processBreachIncdnt,
    bool? infraIssue,
    bool? suspiciousActivity,
    bool? fireAlarmEmrgncy,
    bool? landlordIssue,
    bool? secSysFailureIncdnt,
    bool? sysAlarmRcvd,
    bool? transportIncdnt,
    bool? anyEvent,
    bool? powerFailure,
    bool? atmVendorVisit,
    bool? cwmVisit,
    bool? dgWrking,
    bool? followedUp,
  }) {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    if (shiftBrfngAttnded != null) {
      state.model.shiftBrfngAttnded = shiftBrfngAttnded;
    }
    if (premisesRoundTkn != null) {
      state.model.premisesRoundTkn = premisesRoundTkn;
    }
    if (medicalEmrgncy != null) {
      state.model.medicalEmrgncy = medicalEmrgncy;
    }
    if (materialMovement != null) {
      state.model.materialMovement = materialMovement;
    }
    if (leoVisit != null) {
      state.model.leoVisit = leoVisit;
    }
    if (socialEnggIncdnt != null) {
      state.model.socialEnggIncdnt = socialEnggIncdnt;
    }
    if (foundArticleTrnsctn != null) {
      state.model.foundArticleTrnsctn = foundArticleTrnsctn;
    }
    if (processBreachIncdnt != null) {
      state.model.processBreachIncdnt = processBreachIncdnt;
    }
    if (infraIssue != null) {
      state.model.infraIssue = infraIssue;
    }
    if (suspiciousActivity != null) {
      state.model.suspiciousActivity = suspiciousActivity;
    }
    if (fireAlarmEmrgncy != null) {
      state.model.fireAlarmEmrgncy = fireAlarmEmrgncy;
    }
    if (landlordIssue != null) {
      state.model.landlordIssue = landlordIssue;
    }
    if (secSysFailureIncdnt != null) {
      state.model.secSysFailureIncdnt = secSysFailureIncdnt;
    }
    if (sysAlarmRcvd != null) {
      state.model.sysAlarmRcvd = sysAlarmRcvd;
    }
    if (transportIncdnt != null) {
      state.model.transportIncdnt = transportIncdnt;
    }
    if (anyEvent != null) {
      state.model.anyEvent = anyEvent;
    }
    if (powerFailure != null) {
      state.model.powerFailure = powerFailure;
    }

    if (atmVendorVisit != null) {
      state.model.atmVendorVisit = atmVendorVisit;
    }
    if (cwmVisit != null) {
      state.model.cwmVisit = cwmVisit;
    }
    if (dgWrking != null) {
      state.model.dgWrking = dgWrking;
    }
    if (followedUp != null) {
      state.model.followedUp = followedUp;
    }
    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));
  }

  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool navigateToNextScreen = false,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );
    DateTime dateTime;
    if (!Utils().isTimestamp(state.model.inputDate!)) {
      dateTime =
          DateFormat("dd/MM/yyyy HH:mm:ss").parse(state.model.inputDate!);
      int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
      state.model.inputDate = inputDate.toString();
    }

    for (PowerFailureModel powerFailureModel
        in state.model.powerFailures ?? []) {
      if (!powerFailureModel.powerFailureStartDate.isEmptyOrNull &&
          !Utils().isTimestamp(powerFailureModel.powerFailureStartDate!)) {
        dateTime = DateFormat("dd/MM/yyyy HH:mm:ss")
            .parse(powerFailureModel.powerFailureStartDate!);
        int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
        powerFailureModel.powerFailureStartDate = inputDate.toString();
      }

      if (!powerFailureModel.powerFailureEndDate.isEmptyOrNull &&
          !Utils().isTimestamp(powerFailureModel.powerFailureEndDate!)) {
        dateTime = DateFormat("dd/MM/yyyy HH:mm:ss")
            .parse(powerFailureModel.powerFailureEndDate!);
        int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
        powerFailureModel.powerFailureEndDate = inputDate.toString();
      }
    }

    /// Create/Update API Call
    OccurrenceGeneralInfoRequest request =
        OccurrenceGeneralInfoRequest(occurrence: state.model);

    log('--isSaveOnly----$isSaveOnly--');
    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          log('--isSaveOnly--else--if$isSaveOnly--');
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValidDraft.message,
            ),
          );
          return false;
        }
        response = (await services.create(
          body: request,
          isSubmit: false,
        ));
      } else {
        if (!state.isValid.status) {
          log('--isSaveOnly--else--if$isSaveOnly--');
          state.model.inputDate = state.model.inputDate == null
              ? Utils().getCurrentDate()
              : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
          emit(
            state.copyWith(
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return false;
        }

        response = (await services.create(
          body: request,
          isSubmit: true,
        ));
      }
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      state.model.inputDate = state.model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
              int.tryParse(state.model.inputDate ?? '0'),
              Constants.fulldateFormat);
      return false;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }

    if (response.id != null) {
      int? id = int.tryParse(response.id!);
      if (id != null) {
        state.model.id = id;
      }
    }

    emit(
      state.copyWith(
        message: response.message,
        status: navigateToNextScreen
            ? FormStatus.navigateToNextScreen
            : FormStatus.success,
      ),
    );
    return true;
  }

  void updateStatus({required String id}) {
    commonServices.updateRecordStatus(
        id: id, module: Constants.occurrenceModule);
  }

  void deletePowerFailure(PowerFailureModel powerFailure) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    state.model.powerFailures?.remove(powerFailure);

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }
}
