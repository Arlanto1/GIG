import 'dart:developer';
import 'dart:math' as math;

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/models/requestModel/general_info_request.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/services/occurrences_services.dart';
import 'package:db_atom/src/services/common_services.dart';

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
            emailUsers: const [],
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
    
    emit(state.copyWith( status: FormStatus.loading));
    log('---1-----');

    if (state.model.status != ConstantsIntValue.submitted) {
      emit(state.copyWith(
        status: FormStatus.initial,
      ));
      return;
    }
log('-----2---');
    bool isReadOnly;
    if (state.model.handoverSecurity!.userName
        .equalsIgnoreCase(state.loggedInUserDetails?.userName)) {
      isReadOnly = false;
    } else {
      isReadOnly = true;
    }
    log('------3--');

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
    Analyst users = await commonServices.getUsersByRole(roleName: 'T1_Analyst');
    GetDepositor emailUsers =
        await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

    emit(
      state.copyWith(
        status: FormStatus.initial,
        users: users.t1Analyst,
        emailUsers: emailUsers.atomStaticUser,
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

      Analyst users =
          await commonServices.getUsersByRole(roleName: 'T1_Analyst');

      GetDepositor emailUsers =
          await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      // Get Date of Creation
      model.inputDate = Utils().getCurrentDate();

      AddEntities entities =
          await commonServices.getEntities(name: 'ATOM_ENTITIES');

      List<User> entrySecurities = await commonServices.getUsers();

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

          log('-powerFailureModel.powerFailureStartDate--${powerFailureModel.powerFailureStartDate}-');
          if (powerFailureModel.powerFailureStartDate != null) {
            PowerFailure powerFailure = PowerFailure();
            powerFailure.powerFailureStartDate =
                Utils.timestamptoDateConversion(
                    int.tryParse(powerFailureModel.powerFailureStartDate),
                    Constants.fulldateFormat);

            model.powerFailures ?? [].add(powerFailure);
          }
        }
      }
      model.entrySecurity ??= loggedInUserDetails;
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
          users: users.t1Analyst,
          emailUsers: emailUsers.atomStaticUser,
          departments: departments.employeeDepartments,
          entrySecurities: entrySecurities,
          listOfEntities: entities.atomEntities,
          getEntitiesResponse: entities,
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
    state.model.inputDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    /// Create/Update API Call
    OccurrenceGeneralInfoRequest request =
        OccurrenceGeneralInfoRequest(occurrence: state.model);

    log('--isSaveOnly----$isSaveOnly--');
    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          log('--isSaveOnly--else--if$isSaveOnly--');
          emit(
            state.copyWith(
              status: FormStatus.error,
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
          emit(
            state.copyWith(
              status: FormStatus.error,
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
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
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

  void deletePowerFailure(PowerFailure powerFailure) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    state.model.powerFailures?.remove(powerFailure);

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }
}
