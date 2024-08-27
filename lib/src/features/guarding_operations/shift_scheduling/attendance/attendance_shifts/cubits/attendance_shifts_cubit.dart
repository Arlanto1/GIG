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
            model: ShiftModel(),
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
              dutyPostId: selectedDutyPostNameId,
              attendanceId: attInfoId,
              rankId: selectedRank.id!);
      Organisation selectedShift = state.selectedShift ?? shifts.first;

      ShiftModel model = await services.getDutyPostById(
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
      slaList
          .add(SlaList(attInfoId: model.attendanceShiftId!, items: list.items));
      // }
      // }
      // dynamic responseLabels = commonServices.getUiLabels(
      //     language: await SharedPrefs.getLanguageCode(),
      //     moduleCode: Constants.attendanceModule);
      List<String> briefingPoints = await services.getBriefingPoints();
      // briefingPoints.add('');

      // CdUiLabels labels = CdUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
          model: model,
          ranks: ranks,
          selectedRank: state.selectedRank ?? selectedRank,
          selectedShift: state.selectedShift ?? selectedShift,
          shifts: shifts,
          status: FormStatus.initial,
          briefingPoints: briefingPoints,
          shiftSlaList: slaList,
          // labels: CdUiLabels,
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

  /// Shift Dropdown Value
  Future<void> getShifts({
    required Organisation rank,
  }) async {
    // Set selectedShift to null while loading new shifts
    emit(
      state.copyWith(
        status: FormStatus.loading,
        shifts: null,
        selectedShift: null, // Set selectedShift to null
      ),
    );

    List<Organisation> shifts =
        await services.getAttendanceShiftByByDutyPostIdAndRankId(
            dutyPostId: selectedDutyPostNameId,
            attendanceId: attInfoId,
            rankId: rank.id!);

    Organisation? selectedShift;

    emit(state.copyWith(
      shifts: shifts,
      selectedRank: rank,
      status: FormStatus.initial,
      selectedShift: selectedShift,
    ));

    // getAvailableSelectedGuardsByShift(shift: selectedShift);
  }

  Future<void> getAvailableSelectedGuardsByShift({
    required Organisation shift,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    ShiftModel model = await services.getDutyPostById(
      shiftId: shift.id!,
      dutyPostNameId: selectedDutyPostNameId,
      rankId: state.selectedRank!.id!,
      attInfoId: attInfoId,
    );

    List<SlaList> slaList = [];

    SLAViolationPenaltyResponseModel list =
        await SLAViolationPenaltyServices().getSvpList(
      startPosition: '0',
      maximumRecords: '100',
      attInfoId: model.attendanceShiftId!,
    );
    log('---list.items-${list.items?.length}--');
    slaList.add(SlaList(attInfoId: attInfoId, items: list.items));

    log('---slaList-${slaList.length}--');

    emit(state.copyWith(
      model: model,
      status: FormStatus.initial,
      selectedShift: shift,
      shiftSlaList: slaList,
    ));
  }

  void onModelValueChange(ShiftModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(ShiftModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));

    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  Future<void> submitAndRefreshScreen(
      {BuildContext? context, bool? checkValidations}) async {
    /// Saving the record
    await submitForm(
      isSaveOnly: true,
      // model: state.model,
      status: FormStatus.initial,
      // newSelectedShift: state.selectedShift!,
      // checkValidations: checkValidations,
    );

    /// For Adding Replacement
    log('--state.status--context-${state.status}--');
    if (state.status != FormStatus.formError &&
        context != null &&
        context.mounted) {
      Navigator.pop(context);
    }

    /// refreshing the list so that we can refresh the validation for creating new replacements.
    if (state.status != FormStatus.formError) {
      initializeValues();
    }
  }

  Future<void> updateReplacement(
    BuildContext context,
    Replacement updatedReplacement,
  ) async {
    emit(state.copyWith(status: FormStatus.loading));

    if (updatedReplacement.id != null) {
      log('Updating Existing Replacement');
      state.model.replacements = state.model.replacements
          ?.map((existing) => existing.id == updatedReplacement.id
              ? updatedReplacement
              : existing)
          .toSet();
    } else {
      /// Handle new replacements
      state.model.replacements ??= {};
      if (updatedReplacement.tempId != null) {
        log('Creating/Updating new Replacement with tempId: ${updatedReplacement.tempId}');
        // Remove any existing replacement with the same tempId before adding
        state.model.replacements!.removeWhere((existingReplacement) =>
            existingReplacement.tempId == updatedReplacement.tempId);
      }
      state.model.replacements!.add(updatedReplacement);
    }

    emit(state.copyWith(
      model: state.model,
      status: FormStatus.initial,
    ));

    /// Saving and Refresh the record
    await submitAndRefreshScreen(context: context, checkValidations: false);
  }

  Future<void> submitForm({bool isSaveOnly = false, FormStatus? status}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    // Create/Update API Call
    AttendanceShiftDutyPostRequest request =
        AttendanceShiftDutyPostRequest(requestModel: ShiftModel());

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
  final int? attInfoId;
  final List<SLAViolationPenaltyModel>? items;

  SlaList({this.attInfoId, this.items});
}
