import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/models/general_info_model.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/models/requestModel/general_info_request.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/services/occurrences_services.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/models/responseModels/generic_creat_response.dart';
import 'package:db_atom/src/services/CommonServices.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import '../../../../../constants/constants.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../models/responseModels/error_response_validation.dart';
import '../../../../../utils/util.dart';
import '../../../../createfound/models/create_found_request.dart';
import '../../../../createfound/models/get_depositor_model.dart';

part 'general_info_state.dart';

class OccurrenceGeneralInfoCubit extends Cubit<GeneralInfoState> {
  final OccurrenceDetailsServices services;
  final Occurrence? occurrence;
  final CommonServices commonServices;

  OccurrenceGeneralInfoCubit({
    required this.services,
    required this.commonServices,
    required this.occurrence,

  }) : super(
    GeneralInfoState.initial(
      occurrence: Occurrence(),
      locations: GetLocations(),
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

  void onModelValueChange(Occurrence occurrence) {
    log('-onModelValueChange---');
    emit(state.copyWith(occurrence: occurrence, status: FormStatus.initial));
  }

  void onCheckBoxChange(Occurrence occurrence) {
    emit(state.copyWith(occurrence: occurrence, status: FormStatus.loading));

    emit(state.copyWith(occurrence: occurrence, status: FormStatus.initial));
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
      Occurrence occurrence = Occurrence();

      GetLocations getLocationsData =
      await commonServices.getLocations(name: 'ATOM_LOCATIONS');

      User loggedInUserDetails =
      await commonServices.getUserDetails(userId: userId);

      Analyst users =
      await commonServices.getUsersByRole(roleName: 'T1_Analyst');

      GetDepositor emailUsers =
      await commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER');

      // Get Date of Creation
       occurrence.inputDate = Utils().getCurrentDate();

      AddEntities entities =
      await commonServices.getEntities(name: 'ATOM_ENTITIES');

      List<User> entrySecurities = await commonServices.getUsers();

      EmployeeDepartments departments =
      await commonServices.getDepartments(name: 'EMPLOYEE_DEPARTMENTS');

      emit(
        state.copyWith(
          occurrence: occurrence,
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
    List<Entity>? entities,
    Organisation? location,
    // BaseUser? user,
    Organisation? vendor,
    Entity? entity,
    int? status,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );


  }

    void addAttachment({
      List<CreateImage>? data,
      List<CreateImage>? guardImages,
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
            occurrence: state.occurrence,
            status: FormStatus.initial,
          ),
        );
      }

      emit(
        state.copyWith(
          eventId: eventIds,
          occurrence: state.occurrence,
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
      state.occurrence.shiftBrfngAttnded =
          shiftBrfngAttnded;
    }
    if (premisesRoundTkn != null) {
      state.occurrence.premisesRoundTkn =
          premisesRoundTkn;
    }
    if (medicalEmrgncy != null) {
      state.occurrence.medicalEmrgncy = medicalEmrgncy;
    }
    if (materialMovement != null) {
      state.occurrence.materialMovement = materialMovement;
    }
    if (leoVisit != null) {
      state.occurrence.leoVisit = leoVisit;
    }
    if (socialEnggIncdnt != null) {
      state.occurrence.socialEnggIncdnt = socialEnggIncdnt;
    }
    if (foundArticleTrnsctn != null) {
      state.occurrence.foundArticleTrnsctn = foundArticleTrnsctn;
    }if (processBreachIncdnt != null) {
      state.occurrence.processBreachIncdnt = processBreachIncdnt;
    }if (infraIssue != null) {
      state.occurrence.infraIssue = infraIssue;
    }
    if (suspiciousActivity != null) {
      state.occurrence.suspiciousActivity = suspiciousActivity;
    }
    if (fireAlarmEmrgncy != null) {
      state.occurrence.fireAlarmEmrgncy = fireAlarmEmrgncy;
    }
    if (landlordIssue != null) {
      state.occurrence.landlordIssue = landlordIssue;
    }
    if (secSysFailureIncdnt != null) {
      state.occurrence.secSysFailureIncdnt = secSysFailureIncdnt;
    }
    if (sysAlarmRcvd != null) {
      state.occurrence.sysAlarmRcvd = sysAlarmRcvd;
    } if (transportIncdnt != null) {
      state.occurrence.transportIncdnt = transportIncdnt;
    }
    if (anyEvent != null) {
      state.occurrence.anyEvent = anyEvent;
    }
    if (powerFailure != null) {
      state.occurrence.powerFailure = powerFailure;
    }

    if (atmVendorVisit != null) {
      state.occurrence.atmVendorVisit = atmVendorVisit;
    }
    if (cwmVisit != null) {
      state.occurrence.cwmVisit = cwmVisit;
    }
    if (dgWrking != null) {
      state.occurrence.dgWrking = dgWrking;
    }
    if (followedUp != null) {
      state.occurrence.followedUp = followedUp;
    }
    emit(state.copyWith(
      occurrence: state.occurrence,
      status: FormStatus.initial,
    ));
  }
    void submitForm({bool isSaveOnly = false}) async {
      emit(
        state.copyWith(
          status: FormStatus.loading,
        ),
      );
      /// Create/Update API Call
      OccurrenceGeneralInfoRequest request =
      OccurrenceGeneralInfoRequest(occurrence: state.occurrence);

      log('--isSaveOnly----$isSaveOnly--');
      GenericCreateResponse response = GenericCreateResponse();
      try {
        if (isSaveOnly) {
          response = (await services.createOccurrence(
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
            return;
          }
          response = (await services.createOccurrence(
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

      // log('---response--msg--${response.message}---');

      emit(
        state.copyWith(
          message: response.message,
          status: FormStatus.success,
        ),
      );
    }

}
