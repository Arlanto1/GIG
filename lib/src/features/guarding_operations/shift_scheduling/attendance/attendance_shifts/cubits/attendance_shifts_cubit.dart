import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/models/requestModel/attendance_duty_post_request.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';
import 'package:db_atom/src/services/common_services.dart';
import 'package:intl/intl.dart';

part 'attendance_shifts_state.dart';

class AttendanceShiftsCubit extends Cubit<AttendanceShiftsState> {
  final AttendanceServices services;
  final int attInfoId;
  final int selectedDutyPostNameId;
  final CommonServices commonServices;
  final SLAViolationPenaltyServices slaServices;

  AttendanceShiftsCubit({
    required this.services,
    required this.commonServices,
    required this.attInfoId,
    required this.selectedDutyPostNameId,
    required this.slaServices,
  }) : super(
          AttendanceShiftsState.initial(
            model: DutyPostModel(),
            locations: Locations(),
            loggedInUserDetails: User(),
            users: const [],
            emailUsers: const [],
            errorMessage: '',
            departments: const [],
          ),
        );

  Future<void> initializeValues() async {
    log('--initializeValues--');
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    DutyPostModel model = DutyPostModel();
    model = await services.getDutyPostById(
      attInfoId: attInfoId,
      dutyPostNameId: selectedDutyPostNameId,
    );

    log('--model----${model.name}--');
    // model = DutyPostModel.fromJson(json.decode(jsonStringold));

    var userId = await SharedPrefs.getUserId();
    try {
      // Use Future.wait to call API functions concurrently
      final futures = await Future.wait([
        commonServices.getRegionsWithLocations(name: 'ATOM_LOCATIONS'), // 0
        commonServices.getUserDetails(userId: userId), // 1
        commonServices.getUsersByRole(roleName: 'T1_Analyst'), // 2
        commonServices.getUsers(), // 3
        commonServices.getAtomStaticUsers(roleName: 'ATOM_STATIC_USER'), // 4
        commonServices.getVendors(name: 'ATOM_VENDORS'), // 5
        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.attendanceModule), // 6
        SharedPrefs.getDefaultLocation(), // 7
        services.getBriefingPoints(), // 8
        slaServices.getGSvp(
            startPosition: '0',
            maximumRecords: '100',
            attInfoId: attInfoId,
            filters: BaseFilterModel()), // 9
      ]);

      Locations getLocationsData = futures[0];
      User loggedInUserDetails = futures[1];
      Analyst users = futures[2];
      List<User> entrySecurities = futures[3];
      GetDepositor emailUsers = futures[4];
      Vendors vendors = futures[5];
      dynamic responseLabels = futures[6];
      Organisation? defaultLocation = futures[7];
      List<String> briefingPoints = futures[8];
      briefingPoints.add('');
      SLAViolationPenaltyResponseModel slaResponse = futures[9];

      // model.entrySecurity = loggedInUserDetails;
      // Get Date of Creation

      // dynamic participationDates = Utils()
      //     .splitStringAfterComma(state.model.csrParticipationDates ?? '');

      GmUiLabels labels = GmUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
          model: model,
          locations: getLocationsData,
          loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          vendors: vendors.items,
          users: users.t1Analyst,
          entrySecurities: entrySecurities,
          emailUsers: emailUsers.atomStaticUser,
          briefingPoints: briefingPoints,
          slaList: slaResponse.items,
          labels: labels,
        ),
      );
    } catch (e) {
      log('Initialization issue', error: e, name: 'Attendance Details Cubit');
      emit(
        state.copyWith(
          message: Constants.errorText,
        ),
      );
    }
  }

  void onModelValueChange(DutyPostModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(DutyPostModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void updateBriefingPoints(DutyPostModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void submitForm({bool isSaveOnly = false}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // Create/Update API Call
    AttendanceShiftDutyPostRequest request =
        AttendanceShiftDutyPostRequest(requestModel: DutyPostModel());

    request.requestModel = state.model;
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
        response = (await services.createAttendanceShiftDutyPost(
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
        response = (await services.createAttendanceShiftDutyPost(
            body: request, isSubmit: true));
      }
    } on GenericResponse catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: FormStatus.error,
        ),
      );
      return;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
    }

    log('---response--msg--${response.message}---');

    emit(
      state.copyWith(
        message: response.message,
        status: FormStatus.success,
      ),
    );
  }
}
