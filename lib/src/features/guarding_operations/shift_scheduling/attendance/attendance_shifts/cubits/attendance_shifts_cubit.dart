import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';

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
            model: Shift(),
            errorMessage: '',
          ),
        );

  Future<void> initializeValues() async {
    log('--initializeValues-@@@-');
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // DutyPostModel model = DutyPostModel();
    // model = await services.getDutyPostById(
    //   attInfoId: attInfoId,
    //   dutyPostNameId: 832,
    //   // dutyPostNameId: selectedDutyPostNameId,
    //   rankId: 1,
    //   shiftId: 1,
    // );

    // model = DutyPostModel.fromJson(json.decode(jsonStringold));

    var userId = await SharedPrefs.getUserId();
    try {
      Organisation selectedRank;
      List<Organisation> ranks = await services.getAttendanceRanksByDutyPostId(
          dutyPostId: selectedDutyPostNameId, attendanceId: attInfoId);

      selectedRank = state.selectedRank ?? ranks.first;

      List<Organisation> shifts =
          await services.getAttendanceShiftByByDutyPostIdAndRankId(
              dutyPostId: selectedDutyPostNameId, attendanceId: attInfoId, rankId: selectedRank.id!);
      Organisation selectedShift = state.selectedShift ?? shifts.first;

      Shift model = await services.getDutyPostById(
        shiftId: selectedShift.id!,
        dutyPostNameId: selectedDutyPostNameId,
        rankId: selectedRank.id!,
        attInfoId: attInfoId,
      );
      // DutyPostModel model = DutyPostModel();
      // model = await services.getDutyPostById(
      //   attInfoId: attInfoId,
      //   dutyPostNameId: 832,
      //   // dutyPostNameId: selectedDutyPostNameId,
      //   rankId: 1,
      //   shiftId: 1,
      // );

      // Use Future.wait to call API functions concurrently
      // final futures = await Future.wait([
      //   commonServices.getUiLabels(
      //       language: await SharedPrefs.getLanguageCode(),
      //       moduleCode: Constants.attendanceModule), // 6
      //   services.getBriefingPoints(), // 8
      // ]);
      List<SlaList> slaList = [];

      SLAViolationPenaltyResponseModel list =
      await SLAViolationPenaltyServices().getSvpList(
        startPosition: '0',
        maximumRecords: '100',
        attInfoId: model.attendanceShiftId!,
      );

      // for (Rank rank in model.ranks ?? []) {
      //   for (Shift shift in rank.attendanceShift ?? []) {
      //
      //     slaList.add(
      //         SlaList(attInfoId: shift.attendanceShiftId!, items: list.items));
      //   }
      // }
      // dynamic responseLabels = futures[6];
      // List<String> briefingPoints = futures[8];
      // briefingPoints.add('');

      // GmUiLabels labels = GmUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
          model: model,
          // loggedInUserDetails: loggedInUserDetails,
          status: FormStatus.initial,
          // vendors: vendors.items,
          // users: users.t1Analyst,
          // entrySecurities: entrySecurities,
          // emailUsers: emailUsers.atomStaticUser,
          briefingPoints: [],
          shiftSlaList: slaList,
          // labels: labels,
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

  void onModelValueChange(Shift model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(Shift model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void submitForm({bool isSaveOnly = false, FormStatus? status}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // Create/Update API Call
    AttendanceShiftDutyPostRequest request =
        AttendanceShiftDutyPostRequest(requestModel: Shift());

    request.requestModel = state.model;
    GenericResponse response = GenericResponse();
    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          emit(
            state.copyWith(
              status: FormStatus.formError,
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
              status: FormStatus.formError,
              message: state.isValid.message,
            ),
          );
          return;
        }
        response = (await services.createAttendanceShiftDutyPost(
            body: request, isSubmit: true));
      }
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
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
        status: status == null ? FormStatus.success : FormStatus.initial,
      ),
    );
  }
}

class SlaList {
  final int attInfoId;
  final List<SLAViolationPenaltyModel>? items;

  SlaList({required this.attInfoId, required this.items});
}
