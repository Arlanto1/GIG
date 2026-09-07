// // // import 'dart:developer';
// // //
// // // import 'package:db_atom/index.dart';
// // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// // // import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';
// // //
// // // part 'attendance_shifts_state.dart';
// // //
// // // class AttendanceShiftsCubit extends Cubit<AttendanceShiftsState> {
// // //   final AttendanceServices services;
// // //   final int attInfoId;
// // //   final int selectedDutyPostNameId;
// // //   final CommonServices commonServices;
// // //   final SLAViolationPenaltyServices slaServices;
// // //   final DutyPostModel parentModel;
// // //
// // //   AttendanceShiftsCubit({
// // //     required this.services,
// // //     required this.commonServices,
// // //     required this.attInfoId,
// // //     required this.selectedDutyPostNameId,
// // //     required this.slaServices,
// // //     required this.parentModel,
// // //   }) : super(
// // //           AttendanceShiftsState.initial(
// // //             model: ShiftModel(),
// // //             errorMessage: '',
// // //           ),
// // //         );
// // //
// // //   Future<void> initializeValues() async {
// // //     log('--initializeValues-@@@-');
// // //     emit(
// // //       state.copyWith(
// // //         status: FormStatus.loading,
// // //       ),
// // //     );
// // //
// // //     // DutyPostModel model = DutyPostModel();
// // //     // model = await services.getDutyPostById(
// // //     //   attInfoId: attInfoId,
// // //     //   dutyPostNameId: 832,
// // //     //   // dutyPostNameId: selectedDutyPostNameId,
// // //     //   rankId: 1,
// // //     //   shiftId: 1,
// // //     // );
// // //
// // //     // model = DutyPostModel.fromJson(json.decode(jsonStringold));
// // //
// // //     await SharedPrefs.getUserId();
// // //     try {
// // //       Organisation selectedRank;
// // //       List<Organisation> ranks = await services.getAttendanceRanksByDutyPostId(
// // //           dutyPostId: selectedDutyPostNameId, attendanceId: attInfoId);
// // //
// // //       selectedRank = state.selectedRank ?? ranks.first;
// // //
// // //       List<Organisation> shifts =
// // //           await services.getAttendanceShiftByByDutyPostIdAndRankId(
// // //               dutyPostId: selectedDutyPostNameId,
// // //               attendanceId: attInfoId,
// // //               rankId: selectedRank.id!);
// // //       Organisation selectedShift = state.selectedShift ?? shifts.first;
// // //
// // //       ShiftModel model = await services.getDutyPostById(
// // //         shiftId: selectedShift.id!,
// // //         dutyPostNameId: selectedDutyPostNameId,
// // //         rankId: selectedRank.id!,
// // //         attInfoId: attInfoId,
// // //       );
// // //       // DutyPostModel model = DutyPostModel();
// // //       // model = await services.getDutyPostById(
// // //       //   attInfoId: attInfoId,
// // //       //   dutyPostNameId: 832,
// // //       //   // dutyPostNameId: selectedDutyPostNameId,
// // //       //   rankId: 1,
// // //       //   shiftId: 1,
// // //       // );
// // //
// // //       // Use Future.wait to call API functions concurrently
// // //       // final futures = await Future.wait([
// // //       //   commonServices.getUiLabels(
// // //       //       language: await SharedPrefs.getLanguageCode(),
// // //       //       moduleCode: Constants.attendanceModule), // 6
// // //       //   services.getBriefingPoints(), // 8
// // //       // ]);
// // //       List<SlaList> slaList = [];
// // //
// // //       SLAViolationPenaltyResponseModel list =
// // //           await SLAViolationPenaltyServices().getSvpList(
// // //         startPosition: '0',
// // //         maximumRecords: '100',
// // //         attdInfoId: model.attendanceShiftId!,
// // //       );
// // //
// // //       // for (Rank rank in model.ranks ?? []) {
// // //       //   for (Shift shift in rank.attendanceShift ?? []) {
// // //       //
// // //       slaList
// // //           .add(SlaList(attInfoId: model.attendanceShiftId!, items: list.items));
// // //       // }
// // //       // }
// // //       // dynamic responseLabels = commonServices.getUiLabels(
// // //       //     language: await SharedPrefs.getLanguageCode(),
// // //       //     moduleCode: Constants.attendanceModule);
// // //       List<String> briefingPoints = await services.getBriefingPoints();
// // //       // briefingPoints.add('');
// // //
// // //       // CdUiLabels labels = CdUiLabels.fromJson(responseLabels);
// // //
// // //       emit(
// // //         state.copyWith(
// // //           model: model,
// // //           ranks: ranks,
// // //           selectedRank: state.selectedRank ?? selectedRank,
// // //           selectedShift: state.selectedShift ?? selectedShift,
// // //           shifts: shifts,
// // //           status: FormStatus.initial,
// // //           briefingPoints: briefingPoints,
// // //           shiftSlaList: slaList,
// // //           // labels: CdUiLabels,
// // //         ),
// // //       );
// // //     } catch (e) {
// // //       log('Initialization issue', error: e, name: 'Attendance Details Cubit');
// // //       emit(
// // //         state.copyWith(
// // //           message: Constants.errorText,
// // //         ),
// // //       );
// // //     }
// // //   }
// // //
// // //   /// Shift Dropdown Value
// // //   Future<void> getShifts({
// // //     required Organisation rank,
// // //   }) async {
// // //     // Set selectedShift to null while loading new shifts
// // //     emit(
// // //       state.copyWith(
// // //         status: FormStatus.loading,
// // //         shifts: null,
// // //         selectedShift: null, // Set selectedShift to null
// // //       ),
// // //     );
// // //
// // //     List<Organisation> shifts =
// // //         await services.getAttendanceShiftByByDutyPostIdAndRankId(
// // //             dutyPostId: selectedDutyPostNameId,
// // //             attendanceId: attInfoId,
// // //             rankId: rank.id!);
// // //
// // //     Organisation? selectedShift;
// // //
// // //     emit(state.copyWith(
// // //       shifts: shifts,
// // //       selectedRank: rank,
// // //       status: FormStatus.initial,
// // //       selectedShift: selectedShift,
// // //     ));
// // //
// // //     // getAvailableSelectedGuardsByShift(shift: selectedShift);
// // //   }
// // //
// // //   // Add this method inside AttendanceShiftsCubit (attendance_shifts_cubit.dart)
// // // // Place it near updateReplacement().
// // //
// // //   /// Removes a single replacement, persists the change to the backend via
// // //   /// submitAndRefreshScreen(isRemove: true), and lets the subsequent
// // //   /// initializeValues() refresh confirm the deletion actually stuck server-side.
// // //   ///
// // //   /// IMPORTANT: This assumes services.createAttendanceShiftDutyPost replaces
// // //   /// the server's replacement collection with whatever is present in
// // //   /// `request.requestModel.replacements` (i.e. "absent from the list" == delete).
// // //   /// If your backend instead requires an explicit delete-by-id call, this
// // //   /// needs to call that endpoint instead/additionally — see note at bottom.
// // //   Future<void> removeReplacement(
// // //       Replacement replacement, {
// // //         BuildContext? context,
// // //       }) async {
// // //     log('--removeReplacement--${replacement.id ?? replacement.tempId}--');
// // //
// // //     // Mutate the cubit's own state (not the widget's local `state` reference)
// // //     final updatedReplacements = {...?state.model.replacements}
// // //       ..remove(replacement);
// // //     state.model.replacements = updatedReplacements;
// // //
// // //     emit(state.copyWith(model: state.model, status: FormStatus.initial));
// // //
// // //     // Persist the removal, then re-fetch to confirm.
// // //     await submitAndRefreshScreen(
// // //       context: context,
// // //       checkValidations: false,
// // //       isRemove: true,
// // //       isSaveOnly: true,
// // //       isSubmit: false,
// // //     );
// // //   }
// // //
// // // // -----------------------------------------------------------------------
// // // // If, after wiring this up, the replacement STILL comes back after the
// // // // refresh, it means services.createAttendanceShiftDutyPost does not delete
// // // // missing items server-side (e.g. it only appends/upserts). In that case
// // // // you need a dedicated delete call, something like:
// // // //
// // // //   await services.deleteReplacement(
// // // //     attendanceId: attInfoId,
// // // //     replacementId: replacement.id!,
// // // //   );
// // // //
// // // // ...called instead of (or in addition to) submitAndRefreshScreen above.
// // // // I don't have AttendanceServices' source, so I can't confirm which case
// // // // applies — check createAttendanceShiftDutyPost's implementation or your
// // // // backend API docs for a DELETE /replacement/{id} style endpoint.
// // // // -----------------------------------------------------------------------
// // //
// // //   Future<void> getAvailableSelectedGuardsByShift({
// // //     required Organisation shift,
// // //   }) async {
// // //     emit(
// // //       state.copyWith(
// // //         status: FormStatus.loading,
// // //       ),
// // //     );
// // //
// // //     ShiftModel model = await services.getDutyPostById(
// // //       shiftId: shift.id!,
// // //       dutyPostNameId: selectedDutyPostNameId,
// // //       rankId: state.selectedRank!.id!,
// // //       attInfoId: attInfoId,
// // //     );
// // //
// // //     List<SlaList> slaList = [];
// // //
// // //     SLAViolationPenaltyResponseModel list =
// // //         await SLAViolationPenaltyServices().getSvpList(
// // //       startPosition: '0',
// // //       maximumRecords: '100',
// // //       attdInfoId: model.attendanceShiftId!,
// // //     );
// // //     log('---list.items-${list.items?.length}--');
// // //     slaList.add(SlaList(attInfoId: attInfoId, items: list.items));
// // //
// // //     log('---slaList-${slaList.length}--');
// // //
// // //     emit(state.copyWith(
// // //       model: model,
// // //       status: FormStatus.initial,
// // //       selectedShift: shift,
// // //       shiftSlaList: slaList,
// // //     ));
// // //   }
// // //
// // //   Future<void> getNextAvailableReplacementDates({required int userId}) async {
// // //     emit(
// // //       state.copyWith(
// // //         status: FormStatus.loading,
// // //       ),
// // //     );
// // //
// // //     NextAvailableDateRange replacementDateRange =
// // //     await services.getNextAvailableReplacementDates(
// // //       dutyPostId: parentModel.id!,
// // //       rankId: state.selectedRank!.id!,
// // //       userId: userId,
// // //       shiftId: state.selectedShift!.id!, attendanceId: attInfoId,
// // //
// // //     );
// // //
// // //     emit(state.copyWith(
// // //       status: FormStatus.initial,
// // //       replacementDates: replacementDateRange,
// // //     ));
// // //   }
// // //
// // //
// // //   void onModelValueChange(ShiftModel model) {
// // //     log('-onModelValueChange---');
// // //     emit(state.copyWith(model: model, status: FormStatus.initial));
// // //   }
// // //
// // //   void onCheckBoxChange(ShiftModel model) {
// // //     emit(state.copyWith(model: model, status: FormStatus.loading));
// // //
// // //     emit(state.copyWith(model: model, status: FormStatus.initial));
// // //   }
// // //
// // //   Future<void> submitAndRefreshScreen(
// // //       {BuildContext? context, bool? checkValidations, required bool isRemove,required bool isSaveOnly,required bool isSubmit}) async {
// // //     /// Saving the record
// // //     await submitForm(
// // //       isSaveOnly: isSaveOnly,
// // //       isSubmit: isSubmit,
// // //       // model: state.model,
// // //       status: FormStatus.initial,
// // //       // newSelectedShift: state.selectedShift!,
// // //       // checkValidations: checkValidations,
// // //       isRemove: isRemove,
// // //     );
// // //
// // //     /// For Adding Replacement
// // //     log('--state.status--context-${state.status}--');
// // //     if (state.status != FormStatus.formError &&
// // //         context != null &&
// // //         context.mounted) {
// // //       Navigator.pop(context);
// // //     }
// // //
// // //     /// refreshing the list so that we can refresh the validation for creating new replacements.
// // //     if (state.status != FormStatus.formError) {
// // //       initializeValues();
// // //     }
// // //   }
// // //
// // //   Future<void> updateReplacement(
// // //     BuildContext context,
// // //     Replacement updatedReplacement,
// // //       bool isRemove,
// // //       bool isSubmit,
// // //       bool isSaveOnly,
// // //       ) async {
// // //     emit(state.copyWith(status: FormStatus.loading));
// // //
// // //     if (updatedReplacement.id != null) {
// // //       log('Updating Existing Replacement');
// // //       state.model.replacements = state.model.replacements
// // //           ?.map((existing) => existing.id == updatedReplacement.id
// // //               ? updatedReplacement
// // //               : existing)
// // //           .toSet();
// // //     } else {
// // //       /// Handle new replacements
// // //       state.model.replacements ??= {};
// // //       if (updatedReplacement.tempId != null) {
// // //         log('Creating/Updating new Replacement with tempId: ${updatedReplacement.tempId}');
// // //         // Remove any existing replacement with the same tempId before adding
// // //         state.model.replacements!.removeWhere((existingReplacement) =>
// // //             existingReplacement.tempId == updatedReplacement.tempId);
// // //       }
// // //       state.model.replacements!.add(updatedReplacement);
// // //     }
// // //
// // //     emit(state.copyWith(
// // //       model: state.model,
// // //       status: FormStatus.initial,
// // //     ));
// // //
// // //     /// Saving and Refresh the record
// // //     await submitAndRefreshScreen(context: context, checkValidations: false, isRemove: isRemove,isSaveOnly:isSaveOnly,isSubmit:isSubmit);
// // //   }
// // //
// // //   Future<void> submitForm({bool isSaveOnly = false, FormStatus? status, required bool isRemove,required bool isSubmit}) async {
// // //     emit(
// // //       state.copyWith(
// // //         status: FormStatus.loading,
// // //       ),
// // //     );
// // //
// // //     // Create/Update API Call
// // //     AttendanceShiftDutyPostRequest request =
// // //         AttendanceShiftDutyPostRequest(requestModel: ShiftModel());
// // //
// // //     request.requestModel = state.model;
// // //     GenericResponse response = GenericResponse();
// // //     try {
// // //       if (isSaveOnly) {
// // //         if (!state.isValidDraft.status) {
// // //           emit(
// // //             state.copyWith(
// // //               status: FormStatus.formError,
// // //               message: state.isValidDraft.message,
// // //             ),
// // //           );
// // //           return;
// // //         }
// // //         response = (await services.createAttendanceShiftDutyPost(
// // //             body: request, isSubmit: false, isRemove: isRemove));
// // //       }
// // //       if(isSubmit) {
// // //         //Validating Fields
// // //         if (!state.isValid.status) {
// // //           emit(
// // //             state.copyWith(
// // //               status: FormStatus.formError,
// // //               message: state.isValid.message,
// // //             ),
// // //           );
// // //           return;
// // //         }
// // //         response = (await services.createAttendanceShiftDutyPost(
// // //             body: request, isSubmit: true, isRemove: isRemove));
// // //       }
// // //     } on GenericResponse catch (e) {
// // //       Utils().emitErrorState(e, emit, state);
// // //       return;
// // //     } on Exception catch (e) {
// // //       emit(
// // //         state.copyWith(
// // //           message: e.toString(),
// // //           status: FormStatus.error,
// // //         ),
// // //       );
// // //     }
// // //
// // //     log('---response--msg--${response.message}---');
// // //
// // //     emit(
// // //       state.copyWith(
// // //         message: response.message,
// // //         status: status == null ? FormStatus.success : FormStatus.initial,
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // // class SlaList {
// // //   final int? attInfoId;
// // //   final List<SLAViolationPenaltyModel>? items;
// // //
// // //   SlaList({this.attInfoId, this.items});
// // // }
// //
// // import 'dart:developer';
// //
// // import 'package:db_atom/index.dart';
// // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// // import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';
// //
// // part 'attendance_shifts_state.dart';
// //
// // class AttendanceShiftsCubit extends Cubit<AttendanceShiftsState> {
// //   final AttendanceServices services;
// //   final int attInfoId;
// //   final int selectedDutyPostNameId;
// //   final CommonServices commonServices;
// //   final SLAViolationPenaltyServices slaServices;
// //   final DutyPostModel parentModel;
// //
// //   AttendanceShiftsCubit({
// //     required this.services,
// //     required this.commonServices,
// //     required this.attInfoId,
// //     required this.selectedDutyPostNameId,
// //     required this.slaServices,
// //     required this.parentModel,
// //   }) : super(
// //     AttendanceShiftsState.initial(
// //       model: ShiftModel(),
// //       errorMessage: '',
// //     ),
// //   );
// //
// //   Future<void> initializeValues() async {
// //     log('--initializeValues-@@@-');
// //     emit(state.copyWith(status: FormStatus.loading));
// //
// //     await SharedPrefs.getUserId();
// //     try {
// //       Organisation selectedRank;
// //       List<Organisation> ranks =
// //       await services.getAttendanceRanksByDutyPostId(
// //           dutyPostId: selectedDutyPostNameId, attendanceId: attInfoId);
// //
// //       selectedRank = state.selectedRank ?? ranks.first;
// //
// //       List<Organisation> shifts =
// //       await services.getAttendanceShiftByByDutyPostIdAndRankId(
// //           dutyPostId: selectedDutyPostNameId,
// //           attendanceId: attInfoId,
// //           rankId: selectedRank.id!);
// //       Organisation selectedShift = state.selectedShift ?? shifts.first;
// //
// //       ShiftModel model = await services.getDutyPostById(
// //         shiftId: selectedShift.id!,
// //         dutyPostNameId: selectedDutyPostNameId,
// //         rankId: selectedRank.id!,
// //         attInfoId: attInfoId,
// //       );
// //
// //       List<SlaList> slaList = [];
// //
// //       SLAViolationPenaltyResponseModel list =
// //       await SLAViolationPenaltyServices().getSvpList(
// //         startPosition: '0',
// //         maximumRecords: '100',
// //         attdInfoId: model.attendanceShiftId!,
// //       );
// //
// //       slaList.add(
// //           SlaList(attInfoId: model.attendanceShiftId!, items: list.items));
// //
// //       List<String> briefingPoints = await services.getBriefingPoints();
// //
// //       emit(
// //         state.copyWith(
// //           model: model,
// //           ranks: ranks,
// //           selectedRank: state.selectedRank ?? selectedRank,
// //           selectedShift: state.selectedShift ?? selectedShift,
// //           shifts: shifts,
// //           status: FormStatus.initial,
// //           briefingPoints: briefingPoints,
// //           shiftSlaList: slaList,
// //         ),
// //       );
// //     } catch (e) {
// //       log('Initialization issue', error: e, name: 'Attendance Details Cubit');
// //       emit(state.copyWith(message: Constants.errorText));
// //     }
// //   }
// //
// //   /// Shift Dropdown Value
// //   Future<void> getShifts({required Organisation rank}) async {
// //     emit(
// //       state.copyWith(
// //         status: FormStatus.loading,
// //         shifts: null,
// //         selectedShift: null,
// //       ),
// //     );
// //
// //     List<Organisation> shifts =
// //     await services.getAttendanceShiftByByDutyPostIdAndRankId(
// //         dutyPostId: selectedDutyPostNameId,
// //         attendanceId: attInfoId,
// //         rankId: rank.id!);
// //
// //     emit(state.copyWith(
// //       shifts: shifts,
// //       selectedRank: rank,
// //       status: FormStatus.initial,
// //       selectedShift: null,
// //     ));
// //   }
// //
// //   Future<void> getAvailableSelectedGuardsByShift({
// //     required Organisation shift,
// //   }) async {
// //     emit(state.copyWith(status: FormStatus.loading));
// //
// //     ShiftModel model = await services.getDutyPostById(
// //       shiftId: shift.id!,
// //       dutyPostNameId: selectedDutyPostNameId,
// //       rankId: state.selectedRank!.id!,
// //       attInfoId: attInfoId,
// //     );
// //
// //     List<SlaList> slaList = [];
// //
// //     SLAViolationPenaltyResponseModel list =
// //     await SLAViolationPenaltyServices().getSvpList(
// //       startPosition: '0',
// //       maximumRecords: '100',
// //       attdInfoId: model.attendanceShiftId!,
// //     );
// //     slaList.add(SlaList(attInfoId: attInfoId, items: list.items));
// //
// //     emit(state.copyWith(
// //       model: model,
// //       status: FormStatus.initial,
// //       selectedShift: shift,
// //       shiftSlaList: slaList,
// //     ));
// //   }
// //
// //   Future<void> getNextAvailableReplacementDates(
// //       {required int userId}) async {
// //     emit(state.copyWith(status: FormStatus.loading));
// //
// //     NextAvailableDateRange replacementDateRange =
// //     await services.getNextAvailableReplacementDates(
// //       dutyPostId: parentModel.id!,
// //       rankId: state.selectedRank!.id!,
// //       userId: userId,
// //       shiftId: state.selectedShift!.id!,
// //       attendanceId: attInfoId,
// //     );
// //
// //     emit(state.copyWith(
// //       status: FormStatus.initial,
// //       replacementDates: replacementDateRange,
// //     ));
// //   }
// //
// //   void onModelValueChange(ShiftModel model) {
// //     emit(state.copyWith(model: model, status: FormStatus.initial));
// //   }
// //
// //   void onCheckBoxChange(ShiftModel model) {
// //     emit(state.copyWith(model: model, status: FormStatus.loading));
// //     emit(state.copyWith(model: model, status: FormStatus.initial));
// //   }
// //
// //   // ---------------------------------------------------------------------
// //   // FIX: Root cause of "data comes back after a few seconds":
// //   //
// //   // Every quick action (move a guard, delete a replacement) was calling
// //   // submitAndRefreshScreen() -> submitForm() (persist) -> initializeValues()
// //   // (a full GET from the server), unconditionally and immediately.
// //   //
// //   // If the backend hasn't fully committed/indexed the write by the time
// //   // that GET lands (very common — async persistence, caching, read
// //   // replicas), the GET returns the OLD data and silently overwrites your
// //   // correct local state. A few seconds later the backend has caught up,
// //   // but the UI has already been clobbered — which is exactly the visible
// //   // symptom: "it works, then a few seconds later the old data is back".
// //   //
// //   // Fix: for simple optimistic actions (guard move, replacement delete)
// //   // we mutate local state, persist it, and STOP — we do not immediately
// //   // re-fetch and let a stale read stomp on it. If the persist call fails,
// //   // we roll the local state back. Only actions that need a server-
// //   // generated value back (new replacement -> real id) still refresh, and
// //   // even then we give the backend a moment to settle first.
// //   // ---------------------------------------------------------------------
// //
// //   /// Persists the current `state.model` to the backend without doing a
// //   /// full re-fetch afterwards. Returns true on success.
// //   Future<bool> _persistOnly({required bool isRemove}) async {
// //     await submitForm(
// //       isSaveOnly: true,
// //       isSubmit: false,
// //       isRemove: isRemove,
// //       status: FormStatus.initial,
// //     );
// //     return state.status != FormStatus.formError &&
// //         state.status != FormStatus.error;
// //   }
// //
// //   /// Right-arrow: move a guard from "select for attendance" into "attended".
// //   Future<void> markGuardAttended(BaseUser guard) async {
// //     final previousAttended = {...?state.model.attended};
// //     final previousSelect = {...?state.model.selectForAttendance};
// //
// //     state.model.attended = {...previousAttended, guard};
// //     state.model.selectForAttendance = {...previousSelect}..remove(guard);
// //     emit(state.copyWith(model: state.model, status: FormStatus.initial));
// //
// //     final ok = await _persistOnly(isRemove: false);
// //     if (!ok) {
// //       state.model.attended = previousAttended;
// //       state.model.selectForAttendance = previousSelect;
// //       emit(state.copyWith(model: state.model, status: FormStatus.initial));
// //     }
// //   }
// //
// //   /// Left-arrow: move a guard back from "attended" into "select for attendance".
// //   Future<void> unmarkGuardAttended(BaseUser guard) async {
// //     final previousAttended = {...?state.model.attended};
// //     final previousSelect = {...?state.model.selectForAttendance};
// //
// //     state.model.selectForAttendance = {...previousSelect, guard};
// //     state.model.attended = {...previousAttended}..remove(guard);
// //     emit(state.copyWith(model: state.model, status: FormStatus.initial));
// //
// //     final ok = await _persistOnly(isRemove: true);
// //     if (!ok) {
// //       state.model.attended = previousAttended;
// //       state.model.selectForAttendance = previousSelect;
// //       emit(state.copyWith(model: state.model, status: FormStatus.initial));
// //     }
// //   }
// //
// //   /// Removes a single replacement, persists it, and does NOT trigger an
// //   /// immediate full refresh (see note above on stale reads).
// //   Future<void> removeReplacement(
// //       Replacement replacement, {
// //         BuildContext? context,
// //       }) async {
// //     log('--removeReplacement--${replacement.id ?? replacement.tempId}--');
// //
// //     final previous = {...?state.model.replacements};
// //     state.model.replacements = {...previous}..remove(replacement);
// //     emit(state.copyWith(model: state.model, status: FormStatus.initial));
// //
// //     final ok = await _persistOnly(isRemove: true);
// //     if (!ok) {
// //       // Roll back so the UI doesn't lie about what's actually saved.
// //       state.model.replacements = previous;
// //       emit(state.copyWith(model: state.model, status: FormStatus.initial));
// //     }
// //     // NOTE: if the item still reappears after this, it means
// //     // createAttendanceShiftDutyPost does not delete missing items
// //     // server-side (it only upserts/appends). In that case you need a
// //     // dedicated delete endpoint, e.g.:
// //     //   await services.deleteReplacement(attendanceId: attInfoId, replacementId: replacement.id!);
// //     // called instead of/alongside _persistOnly above.
// //   }
// //
// //   /// Adding/editing a replacement via the popup DOES need a refresh,
// //   /// because a newly created replacement only gets its real backend `id`
// //   /// after the round trip (it's created locally with a tempId). We give
// //   /// the backend a brief moment to settle before re-fetching, to avoid
// //   /// grabbing a stale read.
// //   Future<void> updateReplacement(
// //       BuildContext context,
// //       Replacement updatedReplacement,
// //       bool isRemove,
// //       bool isSubmit,
// //       bool isSaveOnly,
// //       ) async {
// //     emit(state.copyWith(status: FormStatus.loading));
// //
// //     if (updatedReplacement.id != null) {
// //       state.model.replacements = state.model.replacements
// //           ?.map((existing) => existing.id == updatedReplacement.id
// //           ? updatedReplacement
// //           : existing)
// //           .toSet();
// //     } else {
// //       state.model.replacements ??= {};
// //       if (updatedReplacement.tempId != null) {
// //         state.model.replacements!.removeWhere((existingReplacement) =>
// //         existingReplacement.tempId == updatedReplacement.tempId);
// //       }
// //       state.model.replacements!.add(updatedReplacement);
// //     }
// //
// //     emit(state.copyWith(model: state.model, status: FormStatus.initial));
// //
// //     await submitForm(
// //       isSaveOnly: isSaveOnly,
// //       isSubmit: isSubmit,
// //       isRemove: isRemove,
// //       status: FormStatus.initial,
// //     );
// //
// //     if (state.status != FormStatus.formError && context.mounted) {
// //       Navigator.pop(context);
// //     }
// //
// //     if (state.status != FormStatus.formError) {
// //       // Give the backend a moment to finish committing before we pull the
// //       // "source of truth" copy back down — this is what was missing before.
// //       await Future.delayed(const Duration(milliseconds: 700));
// //       if (!isClosed) {
// //         await initializeValues();
// //       }
// //     }
// //   }
// //
// //   /// Kept for the final "Submit" action, which should always reflect the
// //   /// true server state once submitted. Still delayed slightly for the
// //   /// same eventual-consistency reason as above.
// //   Future<void> submitAndRefreshScreen({
// //     BuildContext? context,
// //     bool? checkValidations,
// //     required bool isRemove,
// //     required bool isSaveOnly,
// //     required bool isSubmit,
// //   }) async {
// //     await submitForm(
// //       isSaveOnly: isSaveOnly,
// //       isSubmit: isSubmit,
// //       status: FormStatus.initial,
// //       isRemove: isRemove,
// //     );
// //
// //     if (state.status != FormStatus.formError &&
// //         context != null &&
// //         context.mounted) {
// //       Navigator.pop(context);
// //     }
// //
// //     if (state.status != FormStatus.formError) {
// //       await Future.delayed(const Duration(milliseconds: 700));
// //       if (!isClosed) {
// //         await initializeValues();
// //       }
// //     }
// //   }
// //
// //   Future<void> submitForm({
// //     bool isSaveOnly = false,
// //     FormStatus? status,
// //     required bool isRemove,
// //     required bool isSubmit,
// //   }) async {
// //     emit(state.copyWith(status: FormStatus.loading));
// //
// //     AttendanceShiftDutyPostRequest request =
// //     AttendanceShiftDutyPostRequest(requestModel: ShiftModel());
// //     request.requestModel = state.model;
// //     GenericResponse response = GenericResponse();
// //
// //     try {
// //       if (isSaveOnly) {
// //         if (!state.isValidDraft.status) {
// //           emit(state.copyWith(
// //             status: FormStatus.formError,
// //             message: state.isValidDraft.message,
// //           ));
// //           return;
// //         }
// //         response = await services.createAttendanceShiftDutyPost(
// //             body: request, isSubmit: false, isRemove: isRemove);
// //       }
// //       if (isSubmit) {
// //         if (!state.isValid.status) {
// //           emit(state.copyWith(
// //             status: FormStatus.formError,
// //             message: state.isValid.message,
// //           ));
// //           return;
// //         }
// //         response = await services.createAttendanceShiftDutyPost(
// //             body: request, isSubmit: true, isRemove: isRemove);
// //       }
// //     } on GenericResponse catch (e) {
// //       Utils().emitErrorState(e, emit, state);
// //       return;
// //     } on Exception catch (e) {
// //       emit(state.copyWith(message: e.toString(), status: FormStatus.error));
// //       return;
// //     }
// //
// //     log('---response--msg--${response.message}---');
// //
// //     emit(
// //       state.copyWith(
// //         message: response.message,
// //         status: status == null ? FormStatus.success : FormStatus.initial,
// //       ),
// //     );
// //   }
// // }
// //
// // class SlaList {
// //   final int? attInfoId;
// //   final List<SLAViolationPenaltyModel>? items;
// //
// //   SlaList({this.attInfoId, this.items});
// // }
//
// import 'dart:developer';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';
//
// part 'attendance_shifts_state.dart';
//
// class AttendanceShiftsCubit extends Cubit<AttendanceShiftsState> {
//   final AttendanceServices services;
//   final int attInfoId;
//   final int selectedDutyPostNameId;
//   final CommonServices commonServices;
//   final SLAViolationPenaltyServices slaServices;
//   final DutyPostModel parentModel;
//
//   AttendanceShiftsCubit({
//     required this.services,
//     required this.commonServices,
//     required this.attInfoId,
//     required this.selectedDutyPostNameId,
//     required this.slaServices,
//     required this.parentModel,
//   }) : super(
//     AttendanceShiftsState.initial(
//       model: ShiftModel(),
//       errorMessage: '',
//     ),
//   );
//
//   Future<void> initializeValues() async {
//     log('--initializeValues-@@@-');
//     emit(state.copyWith(status: FormStatus.loading));
//
//     await SharedPrefs.getUserId();
//     try {
//       Organisation selectedRank;
//       List<Organisation> ranks =
//       await services.getAttendanceRanksByDutyPostId(
//           dutyPostId: selectedDutyPostNameId, attendanceId: attInfoId);
//
//       selectedRank = state.selectedRank ?? ranks.first;
//
//       List<Organisation> shifts =
//       await services.getAttendanceShiftByByDutyPostIdAndRankId(
//           dutyPostId: selectedDutyPostNameId,
//           attendanceId: attInfoId,
//           rankId: selectedRank.id!);
//       Organisation selectedShift = state.selectedShift ?? shifts.first;
//
//       ShiftModel model = await services.getDutyPostById(
//         shiftId: selectedShift.id!,
//         dutyPostNameId: selectedDutyPostNameId,
//         rankId: selectedRank.id!,
//         attInfoId: attInfoId,
//       );
//
//       List<SlaList> slaList = [];
//
//       SLAViolationPenaltyResponseModel list =
//       await SLAViolationPenaltyServices().getSvpList(
//         startPosition: '0',
//         maximumRecords: '100',
//         attdInfoId: model.attendanceShiftId!,
//       );
//
//       slaList.add(
//           SlaList(attInfoId: model.attendanceShiftId!, items: list.items));
//
//       List<String> briefingPoints = await services.getBriefingPoints();
//
//       emit(
//         state.copyWith(
//           model: model,
//           ranks: ranks,
//           selectedRank: state.selectedRank ?? selectedRank,
//           selectedShift: state.selectedShift ?? selectedShift,
//           shifts: shifts,
//           status: FormStatus.initial,
//           briefingPoints: briefingPoints,
//           shiftSlaList: slaList,
//         ),
//       );
//     } catch (e) {
//       log('Initialization issue', error: e, name: 'Attendance Details Cubit');
//       emit(state.copyWith(message: Constants.errorText));
//     }
//   }
//
//   Future<void> getShifts({required Organisation rank}) async {
//     emit(
//       state.copyWith(
//         status: FormStatus.loading,
//         shifts: null,
//         selectedShift: null,
//       ),
//     );
//
//     List<Organisation> shifts =
//     await services.getAttendanceShiftByByDutyPostIdAndRankId(
//         dutyPostId: selectedDutyPostNameId,
//         attendanceId: attInfoId,
//         rankId: rank.id!);
//
//     emit(state.copyWith(
//       shifts: shifts,
//       selectedRank: rank,
//       status: FormStatus.initial,
//       selectedShift: null,
//     ));
//   }
//
//   Future<void> getAvailableSelectedGuardsByShift({
//     required Organisation shift,
//   }) async {
//     emit(state.copyWith(status: FormStatus.loading));
//
//     ShiftModel model = await services.getDutyPostById(
//       shiftId: shift.id!,
//       dutyPostNameId: selectedDutyPostNameId,
//       rankId: state.selectedRank!.id!,
//       attInfoId: attInfoId,
//     );
//
//     List<SlaList> slaList = [];
//
//     SLAViolationPenaltyResponseModel list =
//     await SLAViolationPenaltyServices().getSvpList(
//       startPosition: '0',
//       maximumRecords: '100',
//       attdInfoId: model.attendanceShiftId!,
//     );
//     slaList.add(SlaList(attInfoId: attInfoId, items: list.items));
//
//     emit(state.copyWith(
//       model: model,
//       status: FormStatus.initial,
//       selectedShift: shift,
//       shiftSlaList: slaList,
//     ));
//   }
//
//   Future<void> getNextAvailableReplacementDates(
//       {required int userId}) async {
//     emit(state.copyWith(status: FormStatus.loading));
//
//     NextAvailableDateRange replacementDateRange =
//     await services.getNextAvailableReplacementDates(
//       dutyPostId: parentModel.id!,
//       rankId: state.selectedRank!.id!,
//       userId: userId,
//       shiftId: state.selectedShift!.id!,
//       attendanceId: attInfoId,
//     );
//
//     emit(state.copyWith(
//       status: FormStatus.initial,
//       replacementDates: replacementDateRange,
//     ));
//   }
//
//   void onModelValueChange(ShiftModel model) {
//     emit(state.copyWith(model: model, status: FormStatus.initial));
//   }
//
//   void onCheckBoxChange(ShiftModel model) {
//     emit(state.copyWith(model: model, status: FormStatus.loading));
//     emit(state.copyWith(model: model, status: FormStatus.initial));
//   }
//
//   // -----------------------------------------------------------------
//   // Persist current state.model without doing an immediate re-fetch
//   // (avoids the stale-read race where an eventual-consistency GET
//   // overwrites a just-made local change with old server data).
//   // -----------------------------------------------------------------
//   Future<bool> _persistOnly({required bool isRemove}) async {
//     await submitForm(
//       isSaveOnly: true,
//       isSubmit: false,
//       isRemove: isRemove,
//       status: FormStatus.initial,
//     );
//     return state.status != FormStatus.formError &&
//         state.status != FormStatus.error;
//   }
//
//   /// Right-arrow: move a guard into "attended".
//   Future<void> markGuardAttended(BaseUser guard) async {
//     final previousAttended = {...?state.model.attended};
//     final previousSelect = {...?state.model.selectForAttendance};
//
//     state.model.attended = {...previousAttended, guard};
//     state.model.selectForAttendance = {...previousSelect}..remove(guard);
//     emit(state.copyWith(model: state.model, status: FormStatus.initial));
//
//     final ok = await _persistOnly(isRemove: false);
//     if (!ok) {
//       state.model.attended = previousAttended;
//       state.model.selectForAttendance = previousSelect;
//       emit(state.copyWith(model: state.model, status: FormStatus.initial));
//     }
//   }
//
//   /// Left-arrow: move a guard back out of "attended".
//   Future<void> unmarkGuardAttended(BaseUser guard) async {
//     final previousAttended = {...?state.model.attended};
//     final previousSelect = {...?state.model.selectForAttendance};
//
//     state.model.selectForAttendance = {...previousSelect, guard};
//     state.model.attended = {...previousAttended}..remove(guard);
//     emit(state.copyWith(model: state.model, status: FormStatus.initial));
//
//     final ok = await _persistOnly(isRemove: true);
//     if (!ok) {
//       state.model.attended = previousAttended;
//       state.model.selectForAttendance = previousSelect;
//       emit(state.copyWith(model: state.model, status: FormStatus.initial));
//     }
//   }
//
//   // -----------------------------------------------------------------
//   // FIX: your network log showed the "deleted" replacement (id 28)
//   // still going out in the request body with statusActive:true. The
//   // UI already treats statusActive as the live/dead flag (the close
//   // button and edit-ability both gate on it), which means this API's
//   // delete contract is a SOFT delete: the item must stay in the
//   // array with statusActive flipped to false, not be stripped out of
//   // the set. Removing it from the Set entirely left the record
//   // untouched server-side (still statusActive:true), so it kept
//   // reappearing on every subsequent fetch/submit — exactly what you
//   // captured in the log.
//   //
//   // Fix: keep the replacement in the set, just flip statusActive.
//   // -----------------------------------------------------------------
//   Future<void> removeReplacement(
//       Replacement replacement, {
//         BuildContext? context,
//       }) async {
//     log('--removeReplacement--${replacement.id ?? replacement.tempId}--');
//
//     final previous = {...?state.model.replacements};
//
//     final updated = <Replacement>{};
//     for (final r in previous) {
//       final isTarget = replacement.id != null
//           ? r.id == replacement.id
//           : r.tempId == replacement.tempId;
//       if (isTarget) {
//         updated.add(
//           Replacement(
//             id: r.id,
//             replacedFor: r.replacedFor,
//             replacementBy: r.replacementBy,
//             fromDate: r.fromDate,
//             toDate: r.toDate,
//             status: r.status,
//             statusActive: false, // <-- soft delete, not removal
//             replacementType: r.replacementType,
//             tempId: r.tempId,
//           ),
//         );
//       } else {
//         updated.add(r);
//       }
//     }
//
//     state.model.replacements = updated;
//     emit(state.copyWith(model: state.model, status: FormStatus.initial));
//
//     final ok = await _persistOnly(isRemove: true);
//     if (!ok) {
//       // Roll back so the UI doesn't lie about what's actually saved.
//       state.model.replacements = previous;
//       emit(state.copyWith(model: state.model, status: FormStatus.initial));
//     }
//   }
//
//   /// Adding/editing via the popup needs a real refresh afterwards
//   /// (new items only get a server-assigned id after the round trip).
//   /// A short delay avoids grabbing a stale read before the backend
//   /// has committed.
//   Future<void> updateReplacement(
//       BuildContext context,
//       Replacement updatedReplacement,
//       bool isRemove,
//       bool isSubmit,
//       bool isSaveOnly,
//       ) async {
//     emit(state.copyWith(status: FormStatus.loading));
//
//     if (updatedReplacement.id != null) {
//       state.model.replacements = state.model.replacements
//           ?.map((existing) => existing.id == updatedReplacement.id
//           ? updatedReplacement
//           : existing)
//           .toSet();
//     } else {
//       state.model.replacements ??= {};
//       if (updatedReplacement.tempId != null) {
//         state.model.replacements!.removeWhere((existingReplacement) =>
//         existingReplacement.tempId == updatedReplacement.tempId);
//       }
//       state.model.replacements!.add(updatedReplacement);
//     }
//
//     emit(state.copyWith(model: state.model, status: FormStatus.initial));
//
//     await submitForm(
//       isSaveOnly: isSaveOnly,
//       isSubmit: isSubmit,
//       isRemove: isRemove,
//       status: FormStatus.initial,
//     );
//
//     if (state.status != FormStatus.formError && context.mounted) {
//       Navigator.pop(context);
//     }
//
//     if (state.status != FormStatus.formError) {
//       await Future.delayed(const Duration(milliseconds: 700));
//       if (!isClosed) {
//         await initializeValues();
//       }
//     }
//   }
//
//   /// Kept for the final "Submit" action, which should reflect the true
//   /// server state once submitted.
//   Future<void> submitAndRefreshScreen({
//     BuildContext? context,
//     bool? checkValidations,
//     required bool isRemove,
//     required bool isSaveOnly,
//     required bool isSubmit,
//   }) async {
//     await submitForm(
//       isSaveOnly: isSaveOnly,
//       isSubmit: isSubmit,
//       status: FormStatus.initial,
//       isRemove: isRemove,
//     );
//
//     if (state.status != FormStatus.formError &&
//         context != null &&
//         context.mounted) {
//       Navigator.pop(context);
//     }
//
//     if (state.status != FormStatus.formError) {
//       await Future.delayed(const Duration(milliseconds: 700));
//       if (!isClosed) {
//         await initializeValues();
//       }
//     }
//   }
//
//   Future<void> submitForm({
//     bool isSaveOnly = false,
//     FormStatus? status,
//     required bool isRemove,
//     required bool isSubmit,
//   }) async {
//     emit(state.copyWith(status: FormStatus.loading));
//
//     AttendanceShiftDutyPostRequest request =
//     AttendanceShiftDutyPostRequest(requestModel: ShiftModel());
//     request.requestModel = state.model;
//     GenericResponse response = GenericResponse();
//
//     try {
//       if (isSaveOnly) {
//         if (!state.isValidDraft.status) {
//           emit(state.copyWith(
//             status: FormStatus.formError,
//             message: state.isValidDraft.message,
//           ));
//           return;
//         }
//         response = await services.createAttendanceShiftDutyPost(
//             body: request, isSubmit: false, isRemove: isRemove);
//       }
//       if (isSubmit) {
//         if (!state.isValid.status) {
//           emit(state.copyWith(
//             status: FormStatus.formError,
//             message: state.isValid.message,
//           ));
//           return;
//         }
//         response = await services.createAttendanceShiftDutyPost(
//             body: request, isSubmit: true, isRemove: isRemove);
//       }
//     } on GenericResponse catch (e) {
//       Utils().emitErrorState(e, emit, state);
//       return;
//     } on Exception catch (e) {
//       emit(state.copyWith(message: e.toString(), status: FormStatus.error));
//       return;
//     }
//
//     log('---response--msg--${response.message}---');
//
//     emit(
//       state.copyWith(
//         message: response.message,
//         status: status == null ? FormStatus.success : FormStatus.initial,
//       ),
//     );
//   }
// }
//
// class SlaList {
//   final int? attInfoId;
//   final List<SLAViolationPenaltyModel>? items;
//
//   SlaList({this.attInfoId, this.items});
// }

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
  final DutyPostModel parentModel;

  AttendanceShiftsCubit({
    required this.services,
    required this.commonServices,
    required this.attInfoId,
    required this.selectedDutyPostNameId,
    required this.slaServices,
    required this.parentModel,
  }) : super(
    AttendanceShiftsState.initial(
      model: ShiftModel(),
      errorMessage: '',
    ),
  );

  Future<void> initializeValues() async {
    log('--initializeValues-@@@-');
    emit(state.copyWith(status: FormStatus.loading));

    await SharedPrefs.getUserId();
    try {
      Organisation selectedRank;
      List<Organisation> ranks =
      await services.getAttendanceRanksByDutyPostId(
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

      List<SlaList> slaList = [];

      SLAViolationPenaltyResponseModel list =
      await SLAViolationPenaltyServices().getSvpList(
        startPosition: '0',
        maximumRecords: '100',
        attdInfoId: model.attendanceShiftId!,
      );

      slaList.add(
          SlaList(attInfoId: model.attendanceShiftId!, items: list.items));

      List<String> briefingPoints = await services.getBriefingPoints();

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
        ),
      );
    } catch (e) {
      log('Initialization issue', error: e, name: 'Attendance Details Cubit');
      emit(state.copyWith(message: Constants.errorText));
    }
  }

  Future<void> getShifts({required Organisation rank}) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        shifts: null,
        selectedShift: null,
      ),
    );

    List<Organisation> shifts =
    await services.getAttendanceShiftByByDutyPostIdAndRankId(
        dutyPostId: selectedDutyPostNameId,
        attendanceId: attInfoId,
        rankId: rank.id!);

    emit(state.copyWith(
      shifts: shifts,
      selectedRank: rank,
      status: FormStatus.initial,
      selectedShift: null,
    ));
  }

  Future<void> getAvailableSelectedGuardsByShift({
    required Organisation shift,
  }) async {
    emit(state.copyWith(status: FormStatus.loading));

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
      attdInfoId: model.attendanceShiftId!,
    );
    slaList.add(SlaList(attInfoId: attInfoId, items: list.items));

    emit(state.copyWith(
      model: model,
      status: FormStatus.initial,
      selectedShift: shift,
      shiftSlaList: slaList,
    ));
  }

  Future<void> getNextAvailableReplacementDates(
      {required int userId}) async {
    emit(state.copyWith(status: FormStatus.loading));

    NextAvailableDateRange replacementDateRange =
    await services.getNextAvailableReplacementDates(
      dutyPostId: parentModel.id!,
      rankId: state.selectedRank!.id!,
      userId: userId,
      shiftId: state.selectedShift!.id!,
      attendanceId: attInfoId,
    );

    emit(state.copyWith(
      status: FormStatus.initial,
      replacementDates: replacementDateRange,
    ));
  }

  void onModelValueChange(ShiftModel model) {
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(ShiftModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }
  Future<bool> _persistOnly({required bool isRemove}) async {
    await submitForm(
      isSaveOnly: true,
      isSubmit: false,
      isRemove: isRemove,
      status: FormStatus.initial,
    );
    return state.status != FormStatus.formError &&
        state.status != FormStatus.error;
  }

  /// Right-arrow: move a guard into "attended".
  Future<void> markGuardAttended(BaseUser guard) async {
    final previousAttended = {...?state.model.attended};
    final previousSelect = {...?state.model.selectForAttendance};

    state.model.attended = {...previousAttended, guard};
    state.model.selectForAttendance = {...previousSelect}..remove(guard);
    emit(state.copyWith(model: state.model, status: FormStatus.initial));

    final ok = await _persistOnly(isRemove: false);
    if (!ok) {
      state.model.attended = previousAttended;
      state.model.selectForAttendance = previousSelect;
      emit(state.copyWith(model: state.model, status: FormStatus.initial));
    }
  }

  /// Left-arrow: move a guard back out of "attended".
  Future<void> unmarkGuardAttended(BaseUser guard) async {
    final previousAttended = {...?state.model.attended};
    final previousSelect = {...?state.model.selectForAttendance};

    state.model.selectForAttendance = {...previousSelect, guard};
    state.model.attended = {...previousAttended}..remove(guard);
    emit(state.copyWith(model: state.model, status: FormStatus.initial));

    final ok = await _persistOnly(isRemove: true);
    if (!ok) {
      state.model.attended = previousAttended;
      state.model.selectForAttendance = previousSelect;
      emit(state.copyWith(model: state.model, status: FormStatus.initial));
    }
  }
 Future<void> removeReplacement(
      Replacement replacement, {
        BuildContext? context,
      }) async {
    log('--removeReplacement--${replacement.id ?? replacement.tempId}--');

    final previous = {...?state.model.replacements};

    // Match by id when it exists (persisted record), otherwise fall
    // back to tempId (a record created locally but not yet saved).
    final updated = previous.where((r) {
      final isTarget = replacement.id != null
          ? r.id == replacement.id
          : r.tempId == replacement.tempId;
      return !isTarget; // keep everything that is NOT the target
    }).toSet();

    state.model.replacements = updated;
    emit(state.copyWith(model: state.model, status: FormStatus.initial));

    final ok = await _persistOnly(isRemove: true);
    if (!ok) {
      // Roll back so the UI doesn't lie about what's actually saved.
      state.model.replacements = previous;
      emit(state.copyWith(model: state.model, status: FormStatus.initial));
    }
  }

  Future<void> updateReplacement(
      BuildContext context,
      Replacement updatedReplacement,
      bool isRemove,
      bool isSubmit,
      bool isSaveOnly,
      ) async {
    emit(state.copyWith(status: FormStatus.loading));

    if (updatedReplacement.id != null) {
      state.model.replacements = state.model.replacements
          ?.map((existing) => existing.id == updatedReplacement.id
          ? updatedReplacement
          : existing)
          .toSet();
    } else {
      state.model.replacements ??= {};
      if (updatedReplacement.tempId != null) {
        state.model.replacements!.removeWhere((existingReplacement) =>
        existingReplacement.tempId == updatedReplacement.tempId);
      }
      state.model.replacements!.add(updatedReplacement);
    }

    emit(state.copyWith(model: state.model, status: FormStatus.initial));

    await submitForm(
      isSaveOnly: isSaveOnly,
      isSubmit: isSubmit,
      isRemove: isRemove,
      status: FormStatus.initial,
    );

    if (state.status != FormStatus.formError && context.mounted) {
      Navigator.pop(context);
    }

    if (state.status != FormStatus.formError) {
      await Future.delayed(const Duration(milliseconds: 700));
      if (!isClosed) {
        await initializeValues();
      }
    }
  }

  /// Kept for the final "Submit" action, which should reflect the true
  /// server state once submitted.
  Future<void> submitAndRefreshScreen({
    BuildContext? context,
    bool? checkValidations,
    required bool isRemove,
    required bool isSaveOnly,
    required bool isSubmit,
  }) async {
    await submitForm(
      isSaveOnly: isSaveOnly,
      isSubmit: isSubmit,
      status: FormStatus.initial,
      isRemove: isRemove,
    );

    if (state.status != FormStatus.formError &&
        context != null &&
        context.mounted) {
      Navigator.pop(context);
    }

    if (state.status != FormStatus.formError) {
      await Future.delayed(const Duration(milliseconds: 700));
      if (!isClosed) {
        await initializeValues();
      }
    }
  }

  Future<void> submitForm({
    bool isSaveOnly = false,
    FormStatus? status,
    required bool isRemove,
    required bool isSubmit,
  }) async {
    emit(state.copyWith(status: FormStatus.loading));

    AttendanceShiftDutyPostRequest request =
    AttendanceShiftDutyPostRequest(requestModel: ShiftModel());
    request.requestModel = state.model;
    GenericResponse response = GenericResponse();

    try {
      if (isSaveOnly) {
        if (!state.isValidDraft.status) {
          emit(state.copyWith(
            status: FormStatus.formError,
            message: state.isValidDraft.message,
          ));
          return;
        }
        response = await services.createAttendanceShiftDutyPost(
            body: request, isSubmit: false, isRemove: isRemove);
      }
      if (isSubmit) {
        if (!state.isValid.status) {
          emit(state.copyWith(
            status: FormStatus.formError,
            message: state.isValid.message,
          ));
          return;
        }
        response = await services.createAttendanceShiftDutyPost(
            body: request, isSubmit: true, isRemove: isRemove);
      }
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      return;
    } on Exception catch (e) {
      emit(state.copyWith(message: e.toString(), status: FormStatus.error));
      return;
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