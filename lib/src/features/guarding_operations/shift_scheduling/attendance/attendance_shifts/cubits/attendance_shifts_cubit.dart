// //
// // // // import 'dart:developer';
// // // //
// // // // import 'package:db_atom/index.dart';
// // // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// // // // import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';
// // // //
// // // // part 'attendance_shifts_state.dart';
// // // //
// // // // class AttendanceShiftsCubit extends Cubit<AttendanceShiftsState> {
// // // //   final AttendanceServices services;
// // // //   final int attInfoId;
// // // //   final int selectedDutyPostNameId;
// // // //   final CommonServices commonServices;
// // // //   final SLAViolationPenaltyServices slaServices;
// // // //   final DutyPostModel parentModel;
// // // //
// // // //   AttendanceShiftsCubit({
// // // //     required this.services,
// // // //     required this.commonServices,
// // // //     required this.attInfoId,
// // // //     required this.selectedDutyPostNameId,
// // // //     required this.slaServices,
// // // //     required this.parentModel,
// // // //   }) : super(
// // // //     AttendanceShiftsState.initial(
// // // //       model: ShiftModel(),
// // // //       errorMessage: '',
// // // //     ),
// // // //   );
// // // //
// // // //   Future<void> initializeValues() async {
// // // //     log('--initializeValues-@@@-');
// // // //     emit(state.copyWith(status: FormStatus.loading));
// // // //
// // // //     await SharedPrefs.getUserId();
// // // //     try {
// // // //       Organisation selectedRank;
// // // //       List<Organisation> ranks =
// // // //       await services.getAttendanceRanksByDutyPostId(
// // // //           dutyPostId: selectedDutyPostNameId, attendanceId: attInfoId);
// // // //
// // // //       selectedRank = state.selectedRank ?? ranks.first;
// // // //
// // // //       List<Organisation> shifts =
// // // //       await services.getAttendanceShiftByByDutyPostIdAndRankId(
// // // //           dutyPostId: selectedDutyPostNameId,
// // // //           attendanceId: attInfoId,
// // // //           rankId: selectedRank.id!);
// // // //       Organisation selectedShift = state.selectedShift ?? shifts.first;
// // // //
// // // //       ShiftModel model = await services.getDutyPostById(
// // // //         shiftId: selectedShift.id!,
// // // //         dutyPostNameId: selectedDutyPostNameId,
// // // //         rankId: selectedRank.id!,
// // // //         attInfoId: attInfoId,
// // // //       );
// // // //
// // // //       List<SlaList> slaList = [];
// // // //
// // // //       SLAViolationPenaltyResponseModel list =
// // // //       await SLAViolationPenaltyServices().getSvpList(
// // // //         startPosition: '0',
// // // //         maximumRecords: '100',
// // // //         attdInfoId: model.attendanceShiftId!,
// // // //       );
// // // //
// // // //       slaList.add(
// // // //           SlaList(attInfoId: model.attendanceShiftId!, items: list.items));
// // // //
// // // //       List<String> briefingPoints = await services.getBriefingPoints();
// // // //
// // // //       emit(
// // // //         state.copyWith(
// // // //           model: model,
// // // //           ranks: ranks,
// // // //           selectedRank: state.selectedRank ?? selectedRank,
// // // //           selectedShift: state.selectedShift ?? selectedShift,
// // // //           shifts: shifts,
// // // //           status: FormStatus.initial,
// // // //           briefingPoints: briefingPoints,
// // // //           shiftSlaList: slaList,
// // // //         ),
// // // //       );
// // // //     } catch (e) {
// // // //       log('Initialization issue', error: e, name: 'Attendance Details Cubit');
// // // //       emit(state.copyWith(message: Constants.errorText));
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> getShifts({required Organisation rank}) async {
// // // //     emit(
// // // //       state.copyWith(
// // // //         status: FormStatus.loading,
// // // //         shifts: null,
// // // //         selectedShift: null,
// // // //       ),
// // // //     );
// // // //
// // // //     List<Organisation> shifts =
// // // //     await services.getAttendanceShiftByByDutyPostIdAndRankId(
// // // //         dutyPostId: selectedDutyPostNameId,
// // // //         attendanceId: attInfoId,
// // // //         rankId: rank.id!);
// // // //
// // // //     emit(state.copyWith(
// // // //       shifts: shifts,
// // // //       selectedRank: rank,
// // // //       status: FormStatus.initial,
// // // //       selectedShift: null,
// // // //     ));
// // // //   }
// // // //
// // // //   Future<void> getAvailableSelectedGuardsByShift({
// // // //     required Organisation shift,
// // // //   }) async {
// // // //     emit(state.copyWith(status: FormStatus.loading));
// // // //
// // // //     ShiftModel model = await services.getDutyPostById(
// // // //       shiftId: shift.id!,
// // // //       dutyPostNameId: selectedDutyPostNameId,
// // // //       rankId: state.selectedRank!.id!,
// // // //       attInfoId: attInfoId,
// // // //     );
// // // //
// // // //     List<SlaList> slaList = [];
// // // //
// // // //     SLAViolationPenaltyResponseModel list =
// // // //     await SLAViolationPenaltyServices().getSvpList(
// // // //       startPosition: '0',
// // // //       maximumRecords: '100',
// // // //       attdInfoId: model.attendanceShiftId!,
// // // //     );
// // // //     slaList.add(SlaList(attInfoId: attInfoId, items: list.items));
// // // //
// // // //     emit(state.copyWith(
// // // //       model: model,
// // // //       status: FormStatus.initial,
// // // //       selectedShift: shift,
// // // //       shiftSlaList: slaList,
// // // //     ));
// // // //   }
// // // //
// // // //   Future<void> getNextAvailableReplacementDates(
// // // //       {required int userId}) async {
// // // //     emit(state.copyWith(status: FormStatus.loading));
// // // //
// // // //     NextAvailableDateRange replacementDateRange =
// // // //     await services.getNextAvailableReplacementDates(
// // // //       dutyPostId: parentModel.id!,
// // // //       rankId: state.selectedRank!.id!,
// // // //       userId: userId,
// // // //       shiftId: state.selectedShift!.id!,
// // // //       attendanceId: attInfoId,
// // // //     );
// // // //
// // // //     emit(state.copyWith(
// // // //       status: FormStatus.initial,
// // // //       replacementDates: replacementDateRange,
// // // //     ));
// // // //   }
// // // //
// // // //   void onModelValueChange(ShiftModel model) {
// // // //     emit(state.copyWith(model: model, status: FormStatus.initial));
// // // //   }
// // // //
// // // //   void onCheckBoxChange(ShiftModel model) {
// // // //     emit(state.copyWith(model: model, status: FormStatus.loading));
// // // //     emit(state.copyWith(model: model, status: FormStatus.initial));
// // // //   }
// // // //   Future<bool> _persistOnly({required bool isRemove}) async {
// // // //     await submitForm(
// // // //       isSaveOnly: true,
// // // //       isSubmit: false,
// // // //       isRemove: isRemove,
// // // //       status: FormStatus.initial,
// // // //     );
// // // //     return state.status != FormStatus.formError &&
// // // //         state.status != FormStatus.error;
// // // //   }
// // // //
// // // //   /// Right-arrow: move a guard into "attended".
// // // //   Future<void> markGuardAttended(BaseUser guard) async {
// // // //     final previousAttended = {...?state.model.attended};
// // // //     final previousSelect = {...?state.model.selectForAttendance};
// // // //
// // // //     state.model.attended = {...previousAttended, guard};
// // // //     state.model.selectForAttendance = {...previousSelect}..remove(guard);
// // // //     emit(state.copyWith(model: state.model, status: FormStatus.initial));
// // // //
// // // //     final ok = await _persistOnly(isRemove: false);
// // // //     if (!ok) {
// // // //       state.model.attended = previousAttended;
// // // //       state.model.selectForAttendance = previousSelect;
// // // //       emit(state.copyWith(model: state.model, status: FormStatus.initial));
// // // //     }
// // // //   }
// // // //
// // // //   /// Left-arrow: move a guard back out of "attended".
// // // //   Future<void> unmarkGuardAttended(BaseUser guard) async {
// // // //     final previousAttended = {...?state.model.attended};
// // // //     final previousSelect = {...?state.model.selectForAttendance};
// // // //
// // // //     state.model.selectForAttendance = {...previousSelect, guard};
// // // //     state.model.attended = {...previousAttended}..remove(guard);
// // // //     emit(state.copyWith(model: state.model, status: FormStatus.initial));
// // // //
// // // //     final ok = await _persistOnly(isRemove: true);
// // // //     if (!ok) {
// // // //       state.model.attended = previousAttended;
// // // //       state.model.selectForAttendance = previousSelect;
// // // //       emit(state.copyWith(model: state.model, status: FormStatus.initial));
// // // //     }
// // // //   }
// // //  Future<void> removeReplacement(
// // //       Replacement replacement, {
// // //         BuildContext? context,
// // //       }) async {
// // //     log('--removeReplacement--${replacement.id ?? replacement.tempId}--');
// // //
// // //     final previous = {...?state.model.replacements};
// // //
// // //     // Match by id when it exists (persisted record), otherwise fall
// // //     // back to tempId (a record created locally but not yet saved).
// // //     final updated = previous.where((r) {
// // //       final isTarget = replacement.id != null
// // //           ? r.id == replacement.id
// // //           : r.tempId == replacement.tempId;
// // //       return !isTarget; // keep everything that is NOT the target
// // //     }).toSet();
// // //
// // //     state.model.replacements = updated;
// // //     emit(state.copyWith(model: state.model, status: FormStatus.initial));
// // //
// // //     final ok = await _persistOnly(isRemove: true);
// // //     if (!ok) {
// // //       // Roll back so the UI doesn't lie about what's actually saved.
// // //       state.model.replacements = previous;
// // //       emit(state.copyWith(model: state.model, status: FormStatus.initial));
// // //     }
// // //   }
// // // //
// // // //   Future<void> updateReplacement(
// // // //       BuildContext context,
// // // //       Replacement updatedReplacement,
// // // //       bool isRemove,
// // // //       bool isSubmit,
// // // //       bool isSaveOnly,
// // // //       ) async {
// // // //     emit(state.copyWith(status: FormStatus.loading));
// // // //
// // // //     if (updatedReplacement.id != null) {
// // // //       state.model.replacements = state.model.replacements
// // // //           ?.map((existing) => existing.id == updatedReplacement.id
// // // //           ? updatedReplacement
// // // //           : existing)
// // // //           .toSet();
// // // //     } else {
// // // //       state.model.replacements ??= {};
// // // //       if (updatedReplacement.tempId != null) {
// // // //         state.model.replacements!.removeWhere((existingReplacement) =>
// // // //         existingReplacement.tempId == updatedReplacement.tempId);
// // // //       }
// // // //       state.model.replacements!.add(updatedReplacement);
// // // //     }
// // // //
// // // //     emit(state.copyWith(model: state.model, status: FormStatus.initial));
// // // //
// // // //     await submitForm(
// // // //       isSaveOnly: isSaveOnly,
// // // //       isSubmit: isSubmit,
// // // //       isRemove: isRemove,
// // // //       status: FormStatus.initial,
// // // //     );
// // // //
// // // //     if (state.status != FormStatus.formError && context.mounted) {
// // // //       Navigator.pop(context);
// // // //     }
// // // //
// // // //     if (state.status != FormStatus.formError) {
// // // //       await Future.delayed(const Duration(milliseconds: 700));
// // // //       if (!isClosed) {
// // // //         await initializeValues();
// // // //       }
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> submitAndRefreshScreen({
// // // //     BuildContext? context,
// // // //     bool? checkValidations,
// // // //     required bool isRemove,
// // // //     required bool isSaveOnly,
// // // //     required bool isSubmit,
// // // //   }) async {
// // // //     await submitForm(
// // // //       isSaveOnly: isSaveOnly,
// // // //       isSubmit: isSubmit,
// // // //       status: FormStatus.initial,
// // // //       isRemove: isRemove,
// // // //     );
// // // //
// // // //     if (state.status != FormStatus.formError &&
// // // //         context != null &&
// // // //         context.mounted) {
// // // //       Navigator.pop(context);
// // // //     }
// // // //
// // // //     if (state.status != FormStatus.formError) {
// // // //       await Future.delayed(const Duration(milliseconds: 700));
// // // //       if (!isClosed) {
// // // //         await initializeValues();
// // // //       }
// // // //     }
// // // //   }
// // // //
// // // //   Future<void> submitForm({
// // // //     bool isSaveOnly = false,
// // // //     FormStatus? status,
// // // //     required bool isRemove,
// // // //     required bool isSubmit,
// // // //   }) async {
// // // //     emit(state.copyWith(status: FormStatus.loading));
// // // //
// // // //     AttendanceShiftDutyPostRequest request =
// // // //     AttendanceShiftDutyPostRequest(requestModel: ShiftModel());
// // // //     request.requestModel = state.model;
// // // //     GenericResponse response = GenericResponse();
// // // //
// // // //     try {
// // // //       if (isSaveOnly) {
// // // //         if (!state.isValidDraft.status) {
// // // //           emit(state.copyWith(
// // // //             status: FormStatus.formError,
// // // //             message: state.isValidDraft.message,
// // // //           ));
// // // //           return;
// // // //         }
// // // //         response = await services.createAttendanceShiftDutyPost(
// // // //             body: request, isSubmit: false, isRemove: isRemove);
// // // //       }
// // // //       if (isSubmit) {
// // // //         if (!state.isValid.status) {
// // // //           emit(state.copyWith(
// // // //             status: FormStatus.formError,
// // // //             message: state.isValid.message,
// // // //           ));
// // // //           return;
// // // //         }
// // // //         response = await services.createAttendanceShiftDutyPost(
// // // //             body: request, isSubmit: true, isRemove: isRemove);
// // // //       }
// // // //     } on GenericResponse catch (e) {
// // // //       Utils().emitErrorState(e, emit, state);
// // // //       return;
// // // //     } on Exception catch (e) {
// // // //       emit(state.copyWith(message: e.toString(), status: FormStatus.error));
// // // //       return;
// // // //     }
// // // //
// // // //     log('---response--msg--${response.message}---');
// // // //
// // // //     emit(
// // // //       state.copyWith(
// // // //         message: response.message,
// // // //         status: status == null ? FormStatus.success : FormStatus.initial,
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // //
// // // // class SlaList {
// // // //   final int? attInfoId;
// // // //   final List<SLAViolationPenaltyModel>? items;
// // // //
// // // //   SlaList({this.attInfoId, this.items});
// // // // }
// // //
// // //
// // // import 'dart:developer';
// // //
// // // import 'package:db_atom/index.dart';
// // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/models/requestModel/adhoc_attendance_request.dart';
// // // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// // //
// // // import '../../models/adhoc_attendance_model.dart';
// // // import '../../models/dutyPost_attendance_model.dart';
// // //
// // // part 'attendance_shifts_state.dart';
// // //
// // // class AttendanceShiftsCubit extends Cubit<AttendanceShiftsState> {
// // //   final AttendanceServices services;
// // //   final int attInfoId;
// // //   final CommonServices commonServices;
// // //
// // //   AttendanceShiftsCubit({
// // //     required this.services,
// // //     required this.commonServices,
// // //     required this.attInfoId,
// // //   }) : super(
// // //     AttendanceShiftsState.initial(
// // //       model: AttendanceModel(),
// // //       locations: Locations(),
// // //       loggedInUserDetails: User(),
// // //       users: const [],
// // //       emailUsers: const [],
// // //       errorMessage: '',
// // //       departments: const [],
// // //     ),
// // //   );
// // //
// // //   Future<dynamic> _safeCall(Future Function() call, String label) async {
// // //     try {
// // //       return await call();
// // //     } catch (e) {
// // //       log('Optional call failed: $label -> $e',
// // //           name: 'Additional Deployments Cubit');
// // //       return null;
// // //     }
// // //   }
// // //
// // //   List<Organisation> _parseOrgList(dynamic raw) {
// // //     if (raw == null) return const [];
// // //
// // //     if (raw is List<Organisation>) return raw;
// // //
// // //     if (raw is List) {
// // //       return raw
// // //           .whereType<Object>()
// // //           .map<Organisation>((e) {
// // //         if (e is Organisation) return e;
// // //         if (e is Map) {
// // //           return Organisation.fromJson(Map<String, dynamic>.from(e));
// // //         }
// // //         // Unknown shape - skip rather than crash.
// // //         return Organisation();
// // //       })
// // //           .toList();
// // //     }
// // //
// // //     if (raw is Map) {
// // //       // API returned a single object instead of a list.
// // //       return [Organisation.fromJson(Map<String, dynamic>.from(raw))];
// // //     }
// // //
// // //     // Unknown/unexpected shape - degrade gracefully instead of crashing.
// // //     return const [];
// // //   }
// // //
// // //   Future<void> initializeValues() async {
// // //     emit(
// // //       state.copyWith(
// // //         status: FormStatus.loading,
// // //       ),
// // //     );
// // //
// // //     AttendanceModel model = AttendanceModel();
// // //
// // //     try {
// // //       model = await services.getById(attInfoId);
// // //
// // //       final futures = await Future.wait([
// // //         _safeCall(() => services.getAdhocDesignation(), 'getAdhocDesignation'), // 0
// // //         _safeCall(() => services.getAdhocDutyHourList(), 'getAdhocDutyHourList'), // 1
// // //         _safeCall(() => services.getAdhocShiftList(), 'getAdhocShiftList'), // 2
// // //         _safeCall(() => services.getAdhocDutyPost(id: model.id), 'getAdhocShiftList'), // 3
// // //
// // //         commonServices.getUiLabels(
// // //             language: await SharedPrefs.getLanguageCode(),
// // //             moduleCode: Constants.attendanceModule), // 4
// // //         // services.getAdhocAttendanceById(attInfoId: model.id), // 5
// // //         _safeCall(() {
// // //           final int? locId = model.location?.id;
// // //           final int? vendorId = model.vendor?.id;
// // //           if (locId == null || vendorId == null) {
// // //             log(
// // //               'Skipping getAdhocAvailableGuards: locId=$locId vendorId=$vendorId',
// // //               name: 'Additional Deployments Cubit',
// // //             );
// // //             return Future.value(null);
// // //           }
// // //           return services.getAdhocAvailableGuards(
// // //             locId: locId,
// // //             vendorId: vendorId,
// // //           );
// // //         }, 'getAdhocAvailableGuards'), // 6
// // //       ]);
// // //
// // //       final List<Organisation> designations = _parseOrgList(futures[0]);
// // //       final List<Organisation> dutyHoursList = _parseOrgList(futures[1]);
// // //       final List<Organisation> shifts = _parseOrgList(futures[2]);
// // //       final List<Organisation> dutyPost = _parseOrgList(futures[3]);
// // //       final dynamic responseLabels = futures[4];
// // //       // final DutyPostAttendanceModel dutyPostAttendanceModel =
// // //       // futures[5] as DutyPostAttendanceModel;
// // //       final List<Organisation> guards = _parseOrgList(futures[5]);
// // //
// // //
// // //       model.inputDate = model.inputDate == null
// // //           ? Utils().getCurrentDate()
// // //           : Utils.timestampToDateConversion(
// // //           int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);
// // //
// // //       model.modifiedDate = model.modifiedDate == null
// // //           ? Utils().getCurrentDate()
// // //           : Utils.timestampToDateConversion(
// // //           int.tryParse(model.modifiedDate ?? '0'),
// // //           Constants.fulldateFormat);
// // //
// // //       final GmUiLabels labels = GmUiLabels.fromJson(responseLabels);
// // //
// // //       emit(
// // //         state.copyWith(
// // //           status: FormStatus.initial,
// // //           model: model,
// // //           labels: labels,
// // //           // dutyPostAttendanceModel: dutyPostAttendanceModel,
// // //           designations: designations,
// // //           shifts: shifts,
// // //           dutyHoursList: dutyHoursList,
// // //           guardsList:guards,
// // //           dutyPostList:dutyPost,
// // //         ),
// // //       );
// // //     } catch (e, st) {
// // //       log('Initialization issue',
// // //           error: e, stackTrace: st, name: 'Attendance Details Cubit');
// // //       emit(
// // //         state.copyWith(
// // //           model: model,
// // //           status: FormStatus.error,
// // //           message: Constants.errorText,
// // //         ),
// // //       );
// // //     }
// // //   }
// // //
// // //   void onModelValueChange(AttendanceModel model) {
// // //     log('-onModelValueChange---');
// // //     emit(state.copyWith(model: model, status: FormStatus.initial));
// // //   }
// // //
// // //   void onCheckBoxChange(AttendanceModel model) {
// // //     emit(state.copyWith(model: model, status: FormStatus.loading));
// // //     emit(state.copyWith(model: model, status: FormStatus.initial));
// // //   }
// // //
// // //   // additional_deployments_cubit.dart
// // //
// // //   // void mergeDraftDeployments(List<Deployments> newDeployments) {
// // //   //   if (newDeployments.isEmpty) return;
// // //   //
// // //   //   final current = state.dutyPostAttendanceModel;
// // //   //   if (current == null) return;
// // //   //
// // //   //   final updatedDeployments = <Deployments>[
// // //   //     ...?current.deployments,
// // //   //     ...newDeployments,
// // //   //   ];
// // //   //
// // //   //   final updatedAdhocModel = current.copyWith(deployments: updatedDeployments);
// // //   //
// // //   //   emit(state.copyWith(dutyPostAttendanceModel: updatedAdhocModel));
// // //   // }
// // //
// // //   Future<bool> submitForm({
// // //     bool isSaveOnly = false,
// // //     bool? isApprovedStatus,
// // //   }) async {
// // //     emit(
// // //       state.copyWith(
// // //         status: FormStatus.loading,
// // //       ),
// // //     );
// // //
// // //     AttendanceShiftDutyPostRequest request =
// // //     AttendanceShiftDutyPostRequest(requestModel: state.dutyPostAttendanceModel);
// // //
// // //     try {
// // //       final GenericResponse response = await services.createDutyPostAttendance(
// // //         body: request,
// // //         isSubmit: !isSaveOnly, // <-- was hardcoded `true`; now derives from isSaveOnly
// // //         isApprovedStatus: isApprovedStatus,
// // //         // comment: comment,
// // //       );
// // //
// // //       log('---response--msg--${response.message}---');
// // //
// // //       if (response.id != null) {
// // //         int? id = int.tryParse(response.id!);
// // //         if (id != null) {
// // //           state.model.id = id;
// // //         }
// // //       }
// // //
// // //       emit(
// // //         state.copyWith(
// // //           model: state.model,
// // //           message: response.message,
// // //           status: FormStatus.success,
// // //         ),
// // //       );
// // //       return true;
// // //     } on GenericResponse catch (e) {
// // //       Utils().emitErrorState(e, emit, state);
// // //       return false;
// // //     } on Exception catch (e) {
// // //       emit(
// // //         state.copyWith(
// // //           message: e.toString(),
// // //           status: FormStatus.error,
// // //         ),
// // //       );
// // //       return false;
// // //     }
// // //   }
// // // }
// //
// // import 'dart:developer';
// //
// // import 'package:db_atom/index.dart';
// // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/models/requestModel/adhoc_attendance_request.dart';
// // import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
// //
// // import '../../models/adhoc_attendance_model.dart';
// // import '../../models/dutyPost_attendance_model.dart';
// //
// // part 'attendance_shifts_state.dart';
// //
// // class AttendanceShiftsCubit extends Cubit<AttendanceShiftsState> {
// //   final AttendanceServices services;
// //   final int attInfoId;
// //   final CommonServices commonServices;
// //
// //   AttendanceShiftsCubit({
// //     required this.services,
// //     required this.commonServices,
// //     required this.attInfoId,
// //   }) : super(
// //     AttendanceShiftsState.initial(
// //       model: AttendanceModel(),
// //       locations: Locations(),
// //       loggedInUserDetails: User(),
// //       users: const [],
// //       emailUsers: const [],
// //       errorMessage: '',
// //       departments: const [],
// //     ),
// //   );
// //
// //   Future<dynamic> _safeCall(Future Function() call, String label) async {
// //     try {
// //       return await call();
// //     } catch (e) {
// //       log('Optional call failed: $label -> $e',
// //           name: 'Additional Deployments Cubit');
// //       return null;
// //     }
// //   }
// //
// //   List<Organisation> _parseOrgList(dynamic raw) {
// //     if (raw == null) return const [];
// //
// //     if (raw is List<Organisation>) return raw;
// //
// //     if (raw is List) {
// //       return raw
// //           .whereType<Object>()
// //           .map<Organisation>((e) {
// //         if (e is Organisation) return e;
// //         if (e is Map) {
// //           return Organisation.fromJson(Map<String, dynamic>.from(e));
// //         }
// //         // Unknown shape - skip rather than crash.
// //         return Organisation();
// //       })
// //           .toList();
// //     }
// //
// //     if (raw is Map) {
// //       // API returned a single object instead of a list.
// //       return [Organisation.fromJson(Map<String, dynamic>.from(raw))];
// //     }
// //
// //     // Unknown/unexpected shape - degrade gracefully instead of crashing.
// //     return const [];
// //   }
// //
// //   // FIX: getDutyPostAttendanceById() -> /getAttendanceDutyPosts/{id} was
// //   // being fetched but never surfaced into state (the call was commented
// //   // out below), so AttendanceShiftsView's "Basement" duty-post accordion
// //   // had nothing to render. This wraps the response defensively so a
// //   // shape mismatch degrades to an empty model instead of crashing
// //   // initializeValues() the way the earlier adhoc-model cast did.
// //   DutyPostAttendanceModel _toDutyPostAttendanceModel(dynamic raw) {
// //     if (raw is DutyPostAttendanceModel) {
// //       return raw;
// //     }
// //     if (raw is Map) {
// //       try {
// //         return DutyPostAttendanceModel.fromJson(
// //             Map<String, dynamic>.from(raw));
// //       } catch (e, st) {
// //         log(
// //           'Failed to parse DutyPostAttendanceModel: $e',
// //           error: e,
// //           stackTrace: st,
// //           name: 'Attendance Shifts Cubit',
// //         );
// //         return DutyPostAttendanceModel();
// //       }
// //     }
// //     if (raw != null) {
// //       log(
// //         'Unexpected type for getAttendanceDutyPosts response: ${raw.runtimeType}',
// //         name: 'Attendance Shifts Cubit',
// //       );
// //     }
// //     return DutyPostAttendanceModel();
// //   }
// //
// //   Future<void> initializeValues() async {
// //     emit(
// //       state.copyWith(
// //         status: FormStatus.loading,
// //       ),
// //     );
// //
// //     AttendanceModel model = AttendanceModel();
// //
// //     try {
// //       model = await services.getById(attInfoId);
// //
// //       final futures = await Future.wait([
// //         _safeCall(() => services.getAdhocDesignation(), 'getAdhocDesignation'), // 0
// //         _safeCall(() => services.getAdhocDutyHourList(), 'getAdhocDutyHourList'), // 1
// //         _safeCall(() => services.getAdhocShiftList(), 'getAdhocShiftList'), // 2
// //         _safeCall(() => services.getAdhocDutyPost(id: model.id), 'getAdhocDutyPost'), // 3
// //
// //         commonServices.getUiLabels(
// //             language: await SharedPrefs.getLanguageCode(),
// //             moduleCode: Constants.attendanceModule), // 4
// //         // FIX: re-enabled — this is the "Basement" duty-post-tree call
// //         // (getAttendanceDutyPosts), distinct from the adhoc endpoint that
// //         // was crashing earlier. Wrapped in _safeCall + parsed defensively
// //         // via _toDutyPostAttendanceModel so a bad response can't take
// //         // down the whole screen.
// //         _safeCall(
// //               () => services.getDutyPostAttendanceById(attInfoId: attInfoId),
// //           'getDutyPostAttendanceById',
// //         ), // 5
// //         _safeCall(() {
// //           final int? locId = model.location?.id;
// //           final int? vendorId = model.vendor?.id;
// //           if (locId == null || vendorId == null) {
// //             log(
// //               'Skipping getAdhocAvailableGuards: locId=$locId vendorId=$vendorId',
// //               name: 'Additional Deployments Cubit',
// //             );
// //             return Future.value(null);
// //           }
// //           return services.getAdhocAvailableGuards(
// //             locId: locId,
// //             vendorId: vendorId,
// //           );
// //         }, 'getAdhocAvailableGuards'), // 6
// //       ]);
// //
// //       final List<Organisation> designations = _parseOrgList(futures[0]);
// //       final List<Organisation> dutyHoursList = _parseOrgList(futures[1]);
// //       final List<Organisation> shifts = _parseOrgList(futures[2]);
// //       final List<Organisation> dutyPost = _parseOrgList(futures[3]);
// //       final dynamic responseLabels = futures[4];
// //       final DutyPostAttendanceModel dutyPostAttendanceModel =
// //       _toDutyPostAttendanceModel(futures[5]);
// //       final List<Organisation> guards = _parseOrgList(futures[6]);
// //
// //       model.inputDate = model.inputDate == null
// //           ? Utils().getCurrentDate()
// //           : Utils.timestampToDateConversion(
// //           int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);
// //
// //       model.modifiedDate = model.modifiedDate == null
// //           ? Utils().getCurrentDate()
// //           : Utils.timestampToDateConversion(
// //           int.tryParse(model.modifiedDate ?? '0'),
// //           Constants.fulldateFormat);
// //
// //       final GmUiLabels labels = GmUiLabels.fromJson(responseLabels);
// //
// //       emit(
// //         state.copyWith(
// //           status: FormStatus.initial,
// //           model: model,
// //           labels: labels,
// //           // FIX: this is what feeds AttendanceShiftsView's duty-post /
// //           // rank / shift accordion — was never emitted before.
// //           dutyPostAttendanceModel: dutyPostAttendanceModel,
// //           designations: designations,
// //           shifts: shifts,
// //           dutyHoursList: dutyHoursList,
// //           guardsList: guards,
// //           dutyPostList: dutyPost,
// //         ),
// //       );
// //     } catch (e, st) {
// //       log('Initialization issue',
// //           error: e, stackTrace: st, name: 'Attendance Details Cubit');
// //       emit(
// //         state.copyWith(
// //           model: model,
// //           status: FormStatus.error,
// //           message: Constants.errorText,
// //         ),
// //       );
// //     }
// //   }
// //
// //   void onModelValueChange(AttendanceModel model) {
// //     log('-onModelValueChange---');
// //     emit(state.copyWith(model: model, status: FormStatus.initial));
// //   }
// //
// //   void onCheckBoxChange(AttendanceModel model) {
// //     emit(state.copyWith(model: model, status: FormStatus.loading));
// //     emit(state.copyWith(model: model, status: FormStatus.initial));
// //   }
// //
// //
// //   // Future<void> removeReplacement(
// //   //     Replacement replacement, {
// //   //       BuildContext? context,
// //   //     }) async {
// //   //   log('--removeReplacement--${replacement.id ?? replacement.tempId}--');
// //   //
// //   //   final previous = {...?state.model.replacements};
// //   //
// //   //   // Match by id when it exists (persisted record), otherwise fall
// //   //   // back to tempId (a record created locally but not yet saved).
// //   //   final updated = previous.where((r) {
// //   //     final isTarget = replacement.id != null
// //   //         ? r.id == replacement.id
// //   //         : r.tempId == replacement.tempId;
// //   //     return !isTarget; // keep everything that is NOT the target
// //   //   }).toSet();
// //   //
// //   //   state.model.replacements = updated;
// //   //   emit(state.copyWith(model: state.model, status: FormStatus.initial));
// //   //
// //   //   final ok = await _persistOnly(isRemove: true);
// //   //   if (!ok) {
// //   //     // Roll back so the UI doesn't lie about what's actually saved.
// //   //     state.model.replacements = previous;
// //   //     emit(state.copyWith(model: state.model, status: FormStatus.initial));
// //   //   }
// //   // }
// //
// //   Future<bool> submitForm({
// //     bool isSaveOnly = false,
// //     bool? isApprovedStatus,
// //   }) async {
// //     emit(
// //       state.copyWith(
// //         status: FormStatus.loading,
// //       ),
// //     );
// //
// //     AttendanceShiftDutyPostRequest request =
// //     AttendanceShiftDutyPostRequest(requestModel: state.dutyPostAttendanceModel);
// //
// //     try {
// //       final GenericResponse response = await services.createDutyPostAttendance(
// //         body: request,
// //         isSubmit: !isSaveOnly,
// //         isApprovedStatus: isApprovedStatus,
// //       );
// //
// //       log('---response--msg--${response.message}---');
// //
// //       if (response.id != null) {
// //         int? id = int.tryParse(response.id!);
// //         if (id != null) {
// //           state.model.id = id;
// //         }
// //       }
// //
// //       emit(
// //         state.copyWith(
// //           model: state.model,
// //           message: response.message,
// //           status: FormStatus.success,
// //         ),
// //       );
// //       return true;
// //     } on GenericResponse catch (e) {
// //       Utils().emitErrorState(e, emit, state);
// //       return false;
// //     } on Exception catch (e) {
// //       emit(
// //         state.copyWith(
// //           message: e.toString(),
// //           status: FormStatus.error,
// //         ),
// //       );
// //       return false;
// //     }
// //   }
// // }
//
// import 'dart:developer';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/models/requestModel/adhoc_attendance_request.dart';
// import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';
//
// import '../../models/adhoc_attendance_model.dart';
// import '../../models/dutyPost_attendance_model.dart';
//
// part 'attendance_shifts_state.dart';
//
// class AttendanceShiftsCubit extends Cubit<AttendanceShiftsState> {
//   final AttendanceServices services;
//   final int attInfoId;
//   final CommonServices commonServices;
//
//   // FIX: this was only ever declared on the old, commented-out cubit.
//   // The view (`_resolveDutyPostId`) reads it directly off the cubit, so
//   // it has to live here on the active cubit too.
//   final int? selectedDutyPostNameId;
//
//   AttendanceShiftsCubit({
//     required this.services,
//     required this.commonServices,
//     required this.attInfoId,
//     this.selectedDutyPostNameId,
//   }) : super(
//     AttendanceShiftsState.initial(
//       model: AttendanceModel(),
//       locations: Locations(),
//       loggedInUserDetails: User(),
//       users: const [],
//       emailUsers: const [],
//       errorMessage: '',
//       departments: const [],
//     ),
//   );
//
//   Future<dynamic> _safeCall(Future Function() call, String label) async {
//     try {
//       return await call();
//     } catch (e) {
//       log('Optional call failed: $label -> $e',
//           name: 'Additional Deployments Cubit');
//       return null;
//     }
//   }
//
//   List<Organisation> _parseOrgList(dynamic raw) {
//     if (raw == null) return const [];
//
//     if (raw is List<Organisation>) return raw;
//
//     if (raw is List) {
//       return raw
//           .whereType<Object>()
//           .map<Organisation>((e) {
//         if (e is Organisation) return e;
//         if (e is Map) {
//           return Organisation.fromJson(Map<String, dynamic>.from(e));
//         }
//         // Unknown shape - skip rather than crash.
//         return Organisation();
//       })
//           .toList();
//     }
//
//     if (raw is Map) {
//       // API returned a single object instead of a list.
//       return [Organisation.fromJson(Map<String, dynamic>.from(raw))];
//     }
//
//     // Unknown/unexpected shape - degrade gracefully instead of crashing.
//     return const [];
//   }
//
//   // FIX: getDutyPostAttendanceById() -> /getAttendanceDutyPosts/{id} was
//   // being fetched but never surfaced into state, so
//   // AttendanceShiftsView's duty-post accordion had nothing to render.
//   // This wraps the response defensively so a shape mismatch degrades to
//   // an empty model instead of crashing initializeValues().
//   DutyPostAttendanceModel _toDutyPostAttendanceModel(dynamic raw) {
//     if (raw is DutyPostAttendanceModel) {
//       return raw;
//     }
//     if (raw is Map) {
//       try {
//         return DutyPostAttendanceModel.fromJson(
//             Map<String, dynamic>.from(raw));
//       } catch (e, st) {
//         log(
//           'Failed to parse DutyPostAttendanceModel: $e',
//           error: e,
//           stackTrace: st,
//           name: 'Attendance Shifts Cubit',
//         );
//         return DutyPostAttendanceModel();
//       }
//     }
//     if (raw != null) {
//       log(
//         'Unexpected type for getAttendanceDutyPosts response: ${raw.runtimeType}',
//         name: 'Attendance Shifts Cubit',
//       );
//     }
//     return DutyPostAttendanceModel();
//   }
//
//   Future<void> initializeValues() async {
//     emit(
//       state.copyWith(
//         status: FormStatus.loading,
//       ),
//     );
//
//     AttendanceModel model = AttendanceModel();
//
//     try {
//       model = await services.getById(attInfoId);
//
//       final futures = await Future.wait([
//         _safeCall(() => services.getAdhocDesignation(), 'getAdhocDesignation'), // 0
//         _safeCall(() => services.getAdhocDutyHourList(), 'getAdhocDutyHourList'), // 1
//         _safeCall(() => services.getAdhocShiftList(), 'getAdhocShiftList'), // 2
//         _safeCall(() => services.getAdhocDutyPost(id: model.id), 'getAdhocDutyPost'), // 3
//
//         commonServices.getUiLabels(
//             language: await SharedPrefs.getLanguageCode(),
//             moduleCode: Constants.attendanceModule), // 4
//         _safeCall(
//               () => services.getDutyPostAttendanceById(attInfoId: attInfoId),
//           'getDutyPostAttendanceById',
//         ), // 5
//         _safeCall(() {
//           final int? locId = model.location?.id;
//           final int? vendorId = model.vendor?.id;
//           if (locId == null || vendorId == null) {
//             log(
//               'Skipping getAdhocAvailableGuards: locId=$locId vendorId=$vendorId',
//               name: 'Additional Deployments Cubit',
//             );
//             return Future.value(null);
//           }
//           return services.getAdhocAvailableGuards(
//             locId: locId,
//             vendorId: vendorId,
//           );
//         }, 'getAdhocAvailableGuards'), // 6
//       ]);
//
//       final List<Organisation> designations = _parseOrgList(futures[0]);
//       final List<Organisation> dutyHoursList = _parseOrgList(futures[1]);
//       final List<Organisation> shifts = _parseOrgList(futures[2]);
//       final List<Organisation> dutyPost = _parseOrgList(futures[3]);
//       final dynamic responseLabels = futures[4];
//       final DutyPostAttendanceModel dutyPostAttendanceModel =
//       _toDutyPostAttendanceModel(futures[5]);
//       final List<Organisation> guards = _parseOrgList(futures[6]);
//
//       model.inputDate = model.inputDate == null
//           ? Utils().getCurrentDate()
//           : Utils.timestampToDateConversion(
//           int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);
//
//       model.modifiedDate = model.modifiedDate == null
//           ? Utils().getCurrentDate()
//           : Utils.timestampToDateConversion(
//           int.tryParse(model.modifiedDate ?? '0'),
//           Constants.fulldateFormat);
//
//       final GmUiLabels labels = GmUiLabels.fromJson(responseLabels);
//
//       emit(
//         state.copyWith(
//           status: FormStatus.initial,
//           model: model,
//           labels: labels,
//           dutyPostAttendanceModel: dutyPostAttendanceModel,
//           designations: designations,
//           shifts: shifts,
//           dutyHoursList: dutyHoursList,
//           guardsList: guards,
//           dutyPostList: dutyPost,
//         ),
//       );
//     } catch (e, st) {
//       log('Initialization issue',
//           error: e, stackTrace: st, name: 'Attendance Details Cubit');
//       emit(
//         state.copyWith(
//           model: model,
//           status: FormStatus.error,
//           message: Constants.errorText,
//         ),
//       );
//     }
//   }
//
//   void onModelValueChange(AttendanceModel model) {
//     log('-onModelValueChange---');
//     emit(state.copyWith(model: model, status: FormStatus.initial));
//   }
//
//   void onCheckBoxChange(AttendanceModel model) {
//     emit(state.copyWith(model: model, status: FormStatus.loading));
//     emit(state.copyWith(model: model, status: FormStatus.initial));
//   }
//
//   Future<void> removeReplacement(
//       Replacement replacement, {
//         required int? rankId,
//         required int? shiftId,
//         BuildContext? context,
//       }) async {
//     log('--removeReplacement--${replacement.id}--');
//
//     final current = state.dutyPostAttendanceModel;
//     if (current == null || rankId == null || shiftId == null) {
//       return;
//     }
//
//     // Snapshot for rollback if the persist call fails.
//     final snapshot = DutyPostAttendanceModel.fromJson(current.toJson());
//
//     Shifts? targetShift;
//     for (final dutyPost in current.dutyPosts ?? const <DutyPosts>[]) {
//       for (final rank in dutyPost.ranks ?? const <Ranks>[]) {
//         if (rank.rankId != rankId) continue;
//         for (final shift in rank.shifts ?? const <Shifts>[]) {
//           final id = shift.attendanceShiftId ?? shift.shiftId;
//           if (id == shiftId) {
//             targetShift = shift;
//             break;
//           }
//         }
//       }
//     }
//
//     if (targetShift == null) {
//       log('removeReplacement: could not locate shift $shiftId under rank $rankId',
//           name: 'Attendance Shifts Cubit');
//       return;
//     }
//
//     targetShift.replacements?.removeWhere((r) => r.id == replacement.id);
//
//     emit(state.copyWith(
//       dutyPostAttendanceModel: current,
//       status: FormStatus.initial,
//     ));
//
//     final ok = await submitForm(isSaveOnly: true);
//     if (!ok) {
//       // Roll back so the UI doesn't lie about what's actually saved.
//       emit(state.copyWith(
//         dutyPostAttendanceModel: snapshot,
//         status: FormStatus.initial,
//       ));
//     }
//   }
//
//   Future<bool> submitForm({
//     bool isSaveOnly = false,
//     bool? isApprovedStatus,
//   }) async {
//     emit(
//       state.copyWith(
//         status: FormStatus.loading,
//       ),
//     );
//
//     AttendanceShiftDutyPostRequest request =
//     AttendanceShiftDutyPostRequest(requestModel: state.dutyPostAttendanceModel);
//
//     try {
//       final GenericResponse response = await services.createDutyPostAttendance(
//         body: request,
//         isSubmit: !isSaveOnly,
//         isApprovedStatus: isApprovedStatus,
//       );
//
//       log('---response--msg--${response.message}---');
//
//       if (response.id != null) {
//         int? id = int.tryParse(response.id!);
//         if (id != null) {
//           state.model.id = id;
//         }
//       }
//
//       emit(
//         state.copyWith(
//           model: state.model,
//           message: response.message,
//           status: FormStatus.success,
//         ),
//       );
//       return true;
//     } on GenericResponse catch (e) {
//       Utils().emitErrorState(e, emit, state);
//       return false;
//     } on Exception catch (e) {
//       emit(
//         state.copyWith(
//           message: e.toString(),
//           status: FormStatus.error,
//         ),
//       );
//       return false;
//     }
//   }
// }
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/models/requestModel/adhoc_attendance_request.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/services/attendance_service.dart';

import '../../models/adhoc_attendance_model.dart';
import '../../models/dutyPost_attendance_model.dart';

part 'attendance_shifts_state.dart';

class AttendanceShiftsCubit extends Cubit<AttendanceShiftsState> {
  final AttendanceServices services;
  final int attInfoId;
  final CommonServices commonServices;

  final int? selectedDutyPostNameId;

  AttendanceShiftsCubit({
    required this.services,
    required this.commonServices,
    required this.attInfoId,
    this.selectedDutyPostNameId,
  }) : super(
    AttendanceShiftsState.initial(
      model: AttendanceModel(),
      locations: Locations(),
      loggedInUserDetails: User(),
      users: const [],
      emailUsers: const [],
      errorMessage: '',
      departments: const [],
    ),
  );

  // ---------------------------------------------------------------------
  // Active replacement context.
  //
  // AddReplacementPopUp's Save button calls
  // `updateReplacement(context, widget.model, false, false, true)` with
  // no rank/shift id of its own (that call site isn't being touched), so
  // this cubit has no way to know, from that call alone, which `Shifts`
  // the replacement belongs to. The view already knows rankId/shiftId
  // when it opens the popup (they're passed into AddReplacementPopUp's
  // constructor), so it calls `setActiveReplacementContext(...)` right
  // before showDialog(...) to stash them here.
  // ---------------------------------------------------------------------
  int? _activeRankId;
  int? _activeShiftId;

  void setActiveReplacementContext({
    required int rankId,
    required int shiftId,
  }) {
    _activeRankId = rankId;
    _activeShiftId = shiftId;
  }

  void clearActiveReplacementContext() {
    _activeRankId = null;
    _activeShiftId = null;
  }

  Future<dynamic> _safeCall(Future Function() call, String label) async {
    try {
      return await call();
    } catch (e) {
      log('Optional call failed: $label -> $e',
          name: 'Additional Deployments Cubit');
      return null;
    }
  }

  List<Organisation> _parseOrgList(dynamic raw) {
    if (raw == null) return const [];

    if (raw is List<Organisation>) return raw;

    if (raw is List) {
      return raw.whereType<Object>().map<Organisation>((e) {
        if (e is Organisation) return e;
        if (e is Map) {
          return Organisation.fromJson(Map<String, dynamic>.from(e));
        }
        // Unknown shape - skip rather than crash.
        return Organisation();
      }).toList();
    }

    if (raw is Map) {
      // API returned a single object instead of a list.
      return [Organisation.fromJson(Map<String, dynamic>.from(raw))];
    }

    // Unknown/unexpected shape - degrade gracefully instead of crashing.
    return const [];
  }

  // FIX: getDutyPostAttendanceById() -> /getAttendanceDutyPosts/{id} was
  // being fetched but never surfaced into state, so
  // AttendanceShiftsView's duty-post accordion had nothing to render.
  // This wraps the response defensively so a shape mismatch degrades to
  // an empty model instead of crashing initializeValues().
  DutyPostAttendanceModel _toDutyPostAttendanceModel(dynamic raw) {
    if (raw is DutyPostAttendanceModel) {
      return raw;
    }
    if (raw is Map) {
      try {
        return DutyPostAttendanceModel.fromJson(
            Map<String, dynamic>.from(raw));
      } catch (e, st) {
        log(
          'Failed to parse DutyPostAttendanceModel: $e',
          error: e,
          stackTrace: st,
          name: 'Attendance Shifts Cubit',
        );
        return DutyPostAttendanceModel();
      }
    }
    if (raw != null) {
      log(
        'Unexpected type for getAttendanceDutyPosts response: ${raw.runtimeType}',
        name: 'Attendance Shifts Cubit',
      );
    }
    return DutyPostAttendanceModel();
  }

  // Walks the duty-post/rank/shift tree to find the exact Shifts object
  // for a given rankId/shiftId pair. Shared by updateReplacement and
  // removeReplacement so both locate the target shift the same way.
  //
  // IMPORTANT: match on `shift.shiftId` only — NOT
  // `shift.attendanceShiftId`. The `shiftId` passed in here is always the
  // generic shift-type id (e.g. 1), the same value threaded through as
  // `widget.shiftId` in AddReplacementPopUp and used for its `?shiftId=`
  // query params. `attendanceShiftId` is a different, unrelated id (e.g.
  // 2390) used only as the path segment for getAttAvailableGuardsByDate
  // (see _shiftModelFor in the view). Falling back to it here (as an
  // earlier version of this method did) compared the wrong numbers and
  // meant the shift could never be found.
  Shifts? _findShift(
      DutyPostAttendanceModel model, {
        required int rankId,
        required int shiftId,
      }) {
    for (final dutyPost in model.dutyPosts ?? const <DutyPosts>[]) {
      for (final rank in dutyPost.ranks ?? const <Ranks>[]) {
        if (rank.rankId != rankId) continue;
        for (final shift in rank.shifts ?? const <Shifts>[]) {
          if (shift.shiftId == shiftId) {
            return shift;
          }
        }
      }
    }
    return null;
  }

  Future<void> initializeValues() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    AttendanceModel model = AttendanceModel();

    try {
      model = await services.getById(attInfoId);

      final futures = await Future.wait([
        _safeCall(() => services.getAdhocDesignation(), 'getAdhocDesignation'), // 0
        _safeCall(() => services.getAdhocDutyHourList(), 'getAdhocDutyHourList'), // 1
        _safeCall(() => services.getAdhocShiftList(), 'getAdhocShiftList'), // 2
        _safeCall(() => services.getAdhocDutyPost(id: model.id), 'getAdhocDutyPost'), // 3

        commonServices.getUiLabels(
            language: await SharedPrefs.getLanguageCode(),
            moduleCode: Constants.attendanceModule), // 4
        _safeCall(
              () => services.getDutyPostAttendanceById(attInfoId: attInfoId),
          'getDutyPostAttendanceById',
        ), // 5
        _safeCall(() {
          final int? locId = model.location?.id;
          final int? vendorId = model.vendor?.id;
          if (locId == null || vendorId == null) {
            log(
              'Skipping getAdhocAvailableGuards: locId=$locId vendorId=$vendorId',
              name: 'Additional Deployments Cubit',
            );
            return Future.value(null);
          }
          return services.getAdhocAvailableGuards(
            locId: locId,
            vendorId: vendorId,
          );
        }, 'getAdhocAvailableGuards'), // 6
      ]);

      final List<Organisation> designations = _parseOrgList(futures[0]);
      final List<Organisation> dutyHoursList = _parseOrgList(futures[1]);
      final List<Organisation> shifts = _parseOrgList(futures[2]);
      final List<Organisation> dutyPost = _parseOrgList(futures[3]);
      final dynamic responseLabels = futures[4];
      final DutyPostAttendanceModel dutyPostAttendanceModel =
      _toDutyPostAttendanceModel(futures[5]);
      final List<Organisation> guards = _parseOrgList(futures[6]);

      model.inputDate = model.inputDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(model.inputDate ?? '0'), Constants.fulldateFormat);

      model.modifiedDate = model.modifiedDate == null
          ? Utils().getCurrentDate()
          : Utils.timestampToDateConversion(
          int.tryParse(model.modifiedDate ?? '0'),
          Constants.fulldateFormat);

      final GmUiLabels labels = GmUiLabels.fromJson(responseLabels);

      emit(
        state.copyWith(
          status: FormStatus.initial,
          model: model,
          labels: labels,
          dutyPostAttendanceModel: dutyPostAttendanceModel,
          designations: designations,
          shifts: shifts,
          dutyHoursList: dutyHoursList,
          guardsList: guards,
          dutyPostList: dutyPost,
        ),
      );
    } catch (e, st) {
      log('Initialization issue',
          error: e, stackTrace: st, name: 'Attendance Details Cubit');
      emit(
        state.copyWith(
          model: model,
          status: FormStatus.error,
          message: Constants.errorText,
        ),
      );
    }
  }

  void onModelValueChange(AttendanceModel model) {
    log('-onModelValueChange---');
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  void onCheckBoxChange(AttendanceModel model) {
    emit(state.copyWith(model: model, status: FormStatus.loading));
    emit(state.copyWith(model: model, status: FormStatus.initial));
  }

  // ---------------------------------------------------------------------
  // Called from AddReplacementPopUp.saveButton() (viaAttendance branch):
  //   BlocProvider.of<AttendanceShiftsCubit>(widget.mainContext)
  //       .updateReplacement(context, widget.model, false, false, true);
  //
  // That call site is fixed (not being changed), so this method's
  // signature has to match it exactly: (context, replacement, isRemove,
  // isSubmit, isSaveOnly) with no rank/shift id. The rank/shift to attach
  // the replacement to comes from `_activeRankId`/`_activeShiftId`, set
  // by the view via setActiveReplacementContext(...) right before it
  // opened this popup.
  //
  // This persists directly (rather than going through submitForm, which
  // emits FormStatus.success and triggers this screen's "Attendance"
  // success dialog + navigate-away-from-screen listener) so saving a
  // replacement just closes the popup and refreshes this screen — it
  // doesn't kick the user back to the attendance list.
  // ---------------------------------------------------------------------
  Future<void> updateReplacement(
      BuildContext context,
      Replacement updatedReplacement,
      bool isRemove,
      bool isSubmit,
      bool isSaveOnly,
      ) async {
    final current = state.dutyPostAttendanceModel;
    final rankId = _activeRankId;
    final shiftId = _activeShiftId;

    if (current == null || rankId == null || shiftId == null) {
      log(
        'updateReplacement: missing active shift context (rankId=$rankId, shiftId=$shiftId)',
        name: 'Attendance Shifts Cubit',
      );
      if (context.mounted) {
        Validator().showToast(
          context,
          'Could not determine which shift this replacement belongs to.',
        );
      }
      return;
    }

    final targetShift = _findShift(current, rankId: rankId, shiftId: shiftId);
    if (targetShift == null) {
      log(
        'updateReplacement: could not locate shift $shiftId under rank $rankId',
        name: 'Attendance Shifts Cubit',
      );
      if (context.mounted) {
        Validator().showToast(context, 'Could not find the selected shift.');
      }
      return;
    }

    if (isRemove) {
      targetShift.replacements?.removeWhere((r) =>
      (updatedReplacement.id != null && r.id == updatedReplacement.id) ||
          (updatedReplacement.id == null &&
              updatedReplacement.tempId != null &&
              r.tempId == updatedReplacement.tempId));
    } else {
      targetShift.replacements ??= [];
      final idx = updatedReplacement.id != null
          ? targetShift.replacements!
          .indexWhere((r) => r.id == updatedReplacement.id)
          : targetShift.replacements!
          .indexWhere((r) => r.tempId == updatedReplacement.tempId);

      if (idx != -1) {
        targetShift.replacements![idx] = updatedReplacement;
      } else {
        targetShift.replacements!.add(updatedReplacement);
      }
    }

    emit(state.copyWith(
      dutyPostAttendanceModel: current,
      status: FormStatus.loading,
    ));

    final request = AttendanceShiftDutyPostRequest(requestModel: current);

    try {
      final response = await services.createDutyPostAttendance(
        body: request,
        isSubmit: false,
      );
      log('---updateReplacement response--msg--${response.message}---',
          name: 'Attendance Shifts Cubit');

      emit(state.copyWith(
        dutyPostAttendanceModel: current,
        status: FormStatus.initial,
      ));
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      return; // keep the popup open so the user can retry
    } on Exception catch (e) {
      emit(state.copyWith(message: e.toString(), status: FormStatus.error));
      return;
    }

    if (context.mounted) {
      Navigator.pop(context);
    }

    clearActiveReplacementContext();
    await initializeValues();
  }

  Future<void> removeReplacement(
      Replacement replacement, {
        required int? rankId,
        required int? shiftId,
        BuildContext? context,
      }) async {
    log('--removeReplacement--${replacement.id}--');

    final current = state.dutyPostAttendanceModel;
    if (current == null || rankId == null || shiftId == null) {
      return;
    }

    // Snapshot for rollback if the persist call fails.
    final snapshot = DutyPostAttendanceModel.fromJson(current.toJson());

    final targetShift = _findShift(current, rankId: rankId, shiftId: shiftId);
    if (targetShift == null) {
      log(
        'removeReplacement: could not locate shift $shiftId under rank $rankId',
        name: 'Attendance Shifts Cubit',
      );
      return;
    }

    targetShift.replacements?.removeWhere((r) => r.id == replacement.id);

    emit(state.copyWith(
      dutyPostAttendanceModel: current,
      status: FormStatus.initial,
    ));

    final ok = await submitForm(isSaveOnly: true);
    if (!ok) {
      // Roll back so the UI doesn't lie about what's actually saved.
      emit(state.copyWith(
        dutyPostAttendanceModel: snapshot,
        status: FormStatus.initial,
      ));
    }
  }

  Future<bool> submitForm({
    bool isSaveOnly = false,
    bool? isApprovedStatus,
  }) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
      ),
    );

    AttendanceShiftDutyPostRequest request = AttendanceShiftDutyPostRequest(
        requestModel: state.dutyPostAttendanceModel);

    try {
      final GenericResponse response =
      await services.createDutyPostAttendance(
        body: request,
        isSubmit: !isSaveOnly,
        isApprovedStatus: isApprovedStatus,
      );

      log('---response--msg--${response.message}---');

      if (response.id != null) {
        int? id = int.tryParse(response.id!);
        if (id != null) {
          state.model.id = id;
        }
      }

      emit(
        state.copyWith(
          model: state.model,
          message: response.message,
          status: FormStatus.success,
        ),
      );
      return true;
    } on GenericResponse catch (e) {
      Utils().emitErrorState(e, emit, state);
      return false;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          message: e.toString(),
          status: FormStatus.error,
        ),
      );
      return false;
    }
  }
}