// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/common_widgets/base_widget/opacity_absorb_widget.dart';
// import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';
//
// import '../../attendance_details/views/attendance_details_view.dart';
//
// class AttendanceShiftsView extends StatefulWidget {
//   const AttendanceShiftsView({
//     super.key,
//     required this.location,
//     required this.locationRegion,
//     required this.vendor,
//     required this.attInfoId,
//     required this.selectedDutyPostModel,
//     required this.isReadOnly,
//     required this.isEligibleToEdit,
//   });
//
//   final Organisation location;
//   final Organisation locationRegion;
//   final Organisation vendor;
//   final int attInfoId;
//   final DutyPostModel selectedDutyPostModel;
//   final bool isReadOnly;
//   final bool isEligibleToEdit;
//
//   @override
//   AttendanceShiftsViewState createState() => AttendanceShiftsViewState();
// }
//
// class AttendanceShiftsViewState extends State<AttendanceShiftsView> {
//   bool isReadOnly = false;
//
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final height = size.height;
//
//     return BlocConsumer<AttendanceShiftsCubit, AttendanceShiftsState>(
//       listener: (context, state) {
//         Utils().formError(state, context);
//         Utils().errorAndLogout(state, context);
//
//         if (state.status == FormStatus.success) {
//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (_) => CustomAlertDialog(
//               title: 'Attendance',
//               message: state.message ?? '',
//               positiveBtnText: Constants.ok,
//               // onPositivePressed: () {
//               //   Navigator.pop(context);
//               //   Navigator.pop(context);
//               //   Navigator.pop(context);
//               //   Navigator.popAndPushNamed(
//               //     context,
//               //     attendanceListRoute,
//               //   );
//               // },
//               onPositivePressed: () {
//                 Navigator.pop(context); // close the success dialog
//
//                 int flag = AttendanceDetailsView.flag;
//                 if (flag == 1) {
//                   Navigator.pop(context); // back to Attendance Details
//                 } else {
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                 }
//               },
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (!state.model.lock.isEmptyOrNull) isReadOnly = true;
//         if (state.model.attdStatus != 1) isReadOnly = true;
//         if (!widget.isEligibleToEdit) isReadOnly = true;
//         if (state.model.attdStatus == 1 && widget.isEligibleToEdit) {
//           isReadOnly = false;
//         }
//
//         return Scaffold(
//           backgroundColor: Colors.transparent,
//           extendBodyBehindAppBar: true,
//           appBar: BaseAppBar().buildAppHeader(
//             context: context,
//             title: widget.selectedDutyPostModel.name ?? '',
//             showPopUp: false,
//             showSaveButton: false,
//             showSubmitButton:
//             state.model.activeShift && state.status != FormStatus.loading,
//             showDisLikeButton: false,
//             showLikeButton: false,
//             popAndReplace: () {
//               int flag = AttendanceDetailsView.flag;
//               if (flag == 1) {
//                 Navigator.pop(context);
//               } else {
//                 Navigator.pop(context);
//                 // Navigator.pop(context);
//                 // Navigator.pop(context);
//               }
//             },
//             // onTapSubmit: () {
//             //   showDialog(
//             //     context: context,
//             //     builder: (_) => AlertDialog(
//             //       title: const Text(Constants.attendanceMessage),
//             //       content: const Text(Constants.attendanceSubmissionMessage),
//             //       actions: [
//             //         TextButton(
//             //           child: const Text(Constants.cancel),
//             //           onPressed: () => Navigator.pop(context),
//             //         ),
//             //         TextButton(
//             //           child: const Text(Constants.ok),
//             //           onPressed: () {
//             //             FocusScope.of(context).unfocus();
//             //             Navigator.pop(context);
//             //             BlocProvider.of<AttendanceShiftsCubit>(context)
//             //                 .submitAndRefreshScreen(
//             //                 isSubmit: true,
//             //                 isSaveOnly: false,
//             //                 isRemove: false);
//             //           },
//             //         ),
//             //       ],
//             //     ),
//             //   );
//             // },
//             onTapSubmit: () {
//               showDialog(
//                 context: context,
//                 builder: (_) => AlertDialog(
//                   title: const Text(Constants.attendanceMessage),
//                   content: const Text(Constants.attendanceSubmissionMessage),
//                   actions: [
//                     TextButton(
//                       child: const Text(Constants.cancel),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     TextButton(
//                       child: const Text(Constants.ok),
//                       onPressed: () async {
//                         FocusScope.of(context).unfocus();
//                         Navigator.pop(context); // close confirmation dialog
//
//                         showDialog(
//                           context: context,
//                           barrierDismissible: false,
//                           builder: (_) => const Center(child: CircularProgressIndicator()),
//                         );
//
//                         try {
//                           await BlocProvider.of<AttendanceShiftsCubit>(context)
//                               .submitAndRefreshScreen(
//                             isSubmit: true,
//                             isSaveOnly: false,
//                             isRemove: false,
//                           );
//                         } finally {
//                           if (context.mounted) {
//                             Navigator.pop(context); // always close loader, success or failure
//                           }
//                         }
//
//                         if (context.mounted) {
//                           int flag = AttendanceDetailsView.flag;
//                           if (flag == 1) {
//                             Navigator.pop(context);
//                           } else {
//                             Navigator.pop(context);
//                             Navigator.pop(context);
//                             Navigator.pop(context);
//                           }
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//
//           // ================= BODY WITH BACKGROUND =================
//           body: Stack(
//             children: [
//               // Background image
//               Positioned.fill(
//                 child: Image.asset(
//                   'assets/images/bg2.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//
//               // Blur overlay
//               Positioned.fill(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
//                   child: Container(
//                     color: Colors.black.withValues(alpha: 0.15),
//                   ),
//                 ),
//               ),
//
//               // Page content
//               Positioned.fill(
//                 child: MediaQuery.removePadding(
//                   context: context,
//                   removeTop: true,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: kToolbarHeight +
//                                 MediaQuery.of(context).padding.top,
//                           ),
//                           getBody(state, height, state.model),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void submitDutyPost(BuildContext context,
//       {required bool isSaveOnly,
//         required bool isRemove,
//         required bool isSubmit}) {
//     FocusScope.of(context).unfocus();
//     log('----onTap${isSaveOnly ? 'Save' : 'Submit'}--');
//     BlocProvider.of<AttendanceShiftsCubit>(context).submitForm(
//         isSaveOnly: isSaveOnly,
//         status: isSaveOnly ? FormStatus.initial : null,
//         isRemove: isRemove,
//         isSubmit: isSubmit);
//   }
//
//   Widget getBody(
//       AttendanceShiftsState state,
//       double height,
//       ShiftModel model,
//       ) {
//
//     if (state.status == FormStatus.loading) {
//       return const BaseLoader();
//     }
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         IntrinsicHeight(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CommonWidgets.verticalSpacerWidget(height * 0.01),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: IntrinsicHeight(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: buildDutyPostSelectionWidget(
//                         state: state,
//                         height: height,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Organisation? selectedRank;
//   Organisation? selectedShift;
//
//   List<Widget> buildDutyPostSelectionWidget({
//     required AttendanceShiftsState state,
//     required double height,
//   }) {
//     return [
//       if (!state.model.lock.isEmptyOrNull) ...[
//         RecordLockedWidget(text: '${state.model.lock}'),
//       ],
//
//       /// Rank Dropdown
//       CommonWidgets.textDisplay(
//         state.labels?.locale.rank ??
//             state.labels?.defaultLocale.rank ??
//             Constants.rank,
//         Styles.textStyleWhite16,
//         isMandatory: true,
//       ),
//
//       DropdownWidget(
//         label: 'Select Rank',
//         items: state.ranks ?? [],
//         isInitial: false,
//         initialValue: selectedRank,
//         onChange: (Organisation? value) async {
//           setState(() {
//             selectedRank = value;
//             selectedShift = null;
//             state.model.selectForAttendance = null;
//             state.model.shift = null;
//           });
//           log('---onChange-region-----');
//
//           BlocProvider.of<AttendanceShiftsCubit>(context)
//               .getShifts(rank: value!);
//         },
//       ),
//       CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//       /// Select For Shift Dropdown
//       CommonWidgets.textDisplay(
//         state.labels?.locale.rank ??
//             state.labels?.defaultLocale.rank ??
//             Constants.selectForShift,
//         Styles.textStyleWhite16,
//         isMandatory: true,
//       ),
//       DropdownWidget(
//         label: 'Select Shift',
//         items: state.shifts ?? [],
//         isInitial:
//         selectedRank != null && selectedShift == null ? true : false,
//         initialValue: selectedShift,
//         onChange: (Organisation? value) {
//           setState(() {
//             selectedShift = value;
//           });
//
//           BlocProvider.of<AttendanceShiftsCubit>(context)
//               .getAvailableSelectedGuardsByShift(
//             shift: value!,
//           );
//         },
//       ),
//       CommonWidgets.verticalSpacerWidget(
//           MediaQuery.of(context).size.height * 0.02),
//       buildTextWithLabel(
//           'Attendance Status:',
//           Utils().buildAttendanceShiftStatusRow(
//               status: state.model.attdStatus ?? 0, returnTextOnly: true)),
//       CommonWidgets.verticalSpacerWidget(
//           MediaQuery.of(context).size.height * 0.01),
//       OpacityAbsorbInkWellWidget(
//         absorbing: false,
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Opacity(
//                   opacity: state.model.attdStatus != 1 ? 0.5 : 1.0,
//                   child: AbsorbPointer(
//                     absorbing: state.model.attdStatus != 1,
//                     child: buildShiftColumn(
//                       shift: state.model,
//                       guards: state.model.attended ?? {},
//                       destinationList: state.model.attended ?? {},
//                       isSourceList: false,
//                       label: 'Attended Marking\n',
//                       // Only the attended list gets a remove (✕) button.
//                       showRemoveButton: true,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             CommonWidgets.verticalSpacerWidget(
//                 MediaQuery.of(context).size.height * 0.01),
//             AbsorbPointer(
//               absorbing: state.model.activeShift == false,
//               child: buildReplacementColumn(state),
//             ),
//             CommonWidgets.verticalSpacerWidget(
//                 MediaQuery.of(context).size.height * 0.01),
//             AbsorbPointer(
//               absorbing: state.model.activeShift == false,
//               child: buildSlaListColumn(
//                 state: state,
//                 shift: state.model,
//               ),
//             ),
//             CommonWidgets.verticalSpacerWidget(
//                 MediaQuery.of(context).size.height * 0.02),
//           ],
//         ),
//       ),
//     ];
//   }
//
//   Widget buildArrowButton({
//     required AttendanceShiftsState state,
//     required IconData icon,
//     required Set<BaseUser> destinationList,
//     required bool isRemove,
//   }) {
//     return IconButton(
//       iconSize: 30,
//       color: Colors.white,
//       onPressed: () {
//         if (selectedGuard == null ||
//             destinationList.contains(selectedGuard)) {
//           return;
//         }
//         final cubit = BlocProvider.of<AttendanceShiftsCubit>(context);
//         if (isRemove) {
//           cubit.unmarkGuardAttended(selectedGuard!);
//         } else {
//           cubit.markGuardAttended(selectedGuard!);
//         }
//       },
//       icon: Icon(icon),
//     );
//   }
//
//   BaseUser? selectedGuard;
//
//   Widget buildShiftColumn({
//     required ShiftModel shift,
//     required Set<BaseUser> guards,
//     required bool isSourceList,
//     required String label,
//     required Set<BaseUser> destinationList,
//     bool showRemoveButton = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         CommonWidgets.textDisplay(
//           label,
//           isMandatory: false,
//           Styles.textStyleWhite17,
//         ),
//         // CommonWidgets.verticalSpacerWidget(
//         //     MediaQuery.of(context).size.height * 0.01),
//         AbsorbPointer(
//           absorbing: false,
//           child: buildUserList(
//             availableGuards: guards,
//             showRemoveButton: showRemoveButton,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Column buildSlaListColumn({
//     required AttendanceShiftsState state,
//     required ShiftModel shift,
//   }) {
//     List<SLAViolationPenaltyModel> slaList = [];
//
//     log('----state.shiftSlaList--${state.shiftSlaList?.length}-');
//
//     if (!state.shiftSlaList.isEmptyOrNull) {
//       SlaList? sla = state.shiftSlaList?.firstWhere(
//             (element) => element.attInfoId == shift.attendanceShiftId,
//         orElse: () => SlaList(),
//       );
//
//       slaList = sla?.items ?? [];
//     }
//     slaList = state.shiftSlaList?.first.items ?? [];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         InkWell(
//           onTap: () {
//             Navigator.pushNamed(
//               context,
//               slaViolationPenaltyDetailsRoute,
//               arguments: {
//                 ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
//                 ConstantsArgument.attdInfoId: state.model.attendanceShiftId,
//                 ConstantsArgument.location: widget.location,
//                 ConstantsArgument.locationRegion: widget.locationRegion,
//               },
//             ).then((_) => BlocProvider.of<AttendanceShiftsCubit>(context)
//                 .submitAndRefreshScreen(
//                 isRemove: false, isSubmit: false, isSaveOnly: true));
//           },
//           child: Row(
//             children: <Widget>[
//               const SizedBox(width: 14),
//               SvgPicture.asset(
//                 AppIcon.plusCircle,
//                 colorFilter: const ColorFilter.mode(
//                   AppColors.white,
//                   BlendMode.srcIn,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               const Text(
//                 'Add SLA Violation',
//                 style: TextStyle(
//                   color: AppColors.white,
//                   decoration: TextDecoration.underline,
//                   decorationColor: AppColors.white,
//                 ),
//               ),
//               CommonWidgets.verticalSpacerWidget(
//                   MediaQuery.of(context).size.height * 0.08),
//             ],
//           ),
//         ),
//         if (!slaList.isEmptyOrNull) ...[
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.094,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: slaList.length,
//               itemBuilder: (context, index) {
//                 return buildSlaCard(slaList[index]);
//               },
//             ),
//           ),
//           CommonWidgets.verticalSpacerWidget(
//               MediaQuery.of(context).size.height * 0.02),
//         ],
//       ],
//     );
//   }
//
//   Widget buildSlaCard(SLAViolationPenaltyModel models) {
//     return InkWell(
//       onTap: () async {
//         var nav = Navigator.of(context);
//         SLAViolationPenaltyModel model =
//         await SLAViolationPenaltyServices().getGvpById(models.id ?? 0);
//         nav.pushNamed(
//           slaViolationPenaltyDetailsRoute,
//           arguments: {
//             "model": model,
//             "title": Constants.slaViolationPenaltyTitle,
//           },
//         );
//       },
//       child: IntrinsicHeight(
//         child: Card(
//           elevation: 0,
//           color: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//             side: const BorderSide(
//               color: Colors.white,
//               width: 0.5,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 buildTextWithLabel('Id:', models.id.toString()),
//                 buildTextWithLabel('Region:', models.locationRegion?.name),
//                 buildTextWithLabel('Location:', models.location?.name),
//                 buildTextWithLabel('Created By:', models.entrySecurity?.name),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   int? _resolveRankId(AttendanceShiftsState state) =>
//       state.selectedRank?.id ?? selectedRank?.id;
//
//   int? _resolveShiftId(AttendanceShiftsState state) =>
//       state.selectedShift?.id ?? selectedShift?.id;
//
//   int _resolveDutyPostId(BuildContext context) =>
//       BlocProvider.of<AttendanceShiftsCubit>(context).selectedDutyPostNameId;
//
//   int _resolveAttendanceId() => widget.attInfoId;
//
//   Column buildReplacementColumn(AttendanceShiftsState state) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: () {
//             final rankId = _resolveRankId(state);
//             final shiftId = _resolveShiftId(state);
//
//             if (rankId == null || shiftId == null) {
//               Validator().showToast(
//                 context,
//                 'Please select Rank and Shift before adding a replacement',
//               );
//               return;
//             }
//
//             showReplacementPopUp(
//               context: context,
//               model: Replacement(),
//               selectedGuards: state.model.selectForReplacements ?? {},
//               state: state,
//               rankId: rankId,
//               shiftId: shiftId,
//               dutyPostId: _resolveDutyPostId(context),
//               attendanceId: _resolveAttendanceId(),
//             );
//           },
//           child: Row(
//             children: <Widget>[
//               const SizedBox(width: 14),
//               SvgPicture.asset(
//                 AppIcon.plusCircle,
//                 colorFilter: const ColorFilter.mode(
//                   AppColors.white,
//                   BlendMode.srcIn,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               const Text(
//                 Constants.addReplacement,
//                 style: TextStyle(
//                   color: AppColors.white,
//                   decoration: TextDecoration.underline,
//                 ),
//               ),
//               CommonWidgets.verticalSpacerWidget(
//                   MediaQuery.of(context).size.height * 0.08),
//             ],
//           ),
//         ),
//         if (_activeReplacements(state).isNotEmpty) ...[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: buildReplacements(state),
//             ),
//           ),
//           CommonWidgets.verticalSpacerWidget(
//               MediaQuery.of(context).size.height * 0.01),
//         ],
//       ],
//     );
//   }
//
//   List<Replacement> _activeReplacements(AttendanceShiftsState state) {
//     // return (state.model.replacements ?? {})
//     //     .where((r) => r.statusActive != true)
//     //     .toList();
//     return (state.model.replacements ?? {}).toList();
//   }
//
//   List<Widget> buildReplacements(AttendanceShiftsState state) {
//     log('selectForReplacements${state.model.selectForReplacements}');
//
//     List<Widget> rows = [];
//
//     // ------------------------------
//     // Header row (added once)
//     // ------------------------------
//     rows.add(
//       Container(
//         decoration: BoxDecoration(
//           color: AppColors.newColor,
//           borderRadius: BorderRadius.circular(6),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Table(
//           border: TableBorder.symmetric(
//             inside: BorderSide(color: Colors.grey.shade300),
//           ),
//           columnWidths: const {
//             0: FlexColumnWidth(2),
//             1: FlexColumnWidth(2),
//             2: FlexColumnWidth(2),
//             3: FlexColumnWidth(2),
//             4: FlexColumnWidth(2),
//             5: FlexColumnWidth(2),
//             6: FlexColumnWidth(1),
//           },
//           children: [
//             TableRow(
//               children: [
//                 tableHeader("Replacement For"),
//                 tableHeader("From Date"),
//                 tableHeader("To Date"),
//                 tableHeader("Reason"),
//                 tableHeader("Replacement By"),
//                 tableHeader("Replacement Type"),
//                 tableHeader(""),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//
//     for (Replacement replacement in _activeReplacements(state)) {
//       rows.add(
//         InkWell(
//           onTap: () {
//             final canEdit = (state.model.attdStatus == 1 &&
//                 replacement.statusActive == true) ||
//                 (state.model.attdStatus == 2 &&
//                     replacement.statusActive == true);
//             if (!canEdit) return;
//
//             final rankId = _resolveRankId(state);
//             final shiftId = _resolveShiftId(state);
//
//             if (rankId == null || shiftId == null) {
//               Validator().showToast(
//                 context,
//                 'Please select Rank and Shift before editing a replacement',
//               );
//               return;
//             }
//
//             showReplacementPopUp(
//               context: context,
//               model: replacement,
//               selectedGuards: state.model.selectForReplacements ?? {},
//               state: state,
//               rankId: rankId,
//               shiftId: shiftId,
//               dutyPostId: _resolveDutyPostId(context),
//               attendanceId: _resolveAttendanceId(),
//             );
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(6),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: Table(
//               border: TableBorder.symmetric(
//                 inside: BorderSide(color: Colors.grey.shade300),
//               ),
//               columnWidths: const {
//                 0: FlexColumnWidth(2),
//                 1: FlexColumnWidth(2),
//                 2: FlexColumnWidth(2),
//                 3: FlexColumnWidth(2),
//                 4: FlexColumnWidth(2),
//                 5: FlexColumnWidth(2),
//                 6: FlexColumnWidth(1),
//               },
//               children: [
//                 TableRow(
//                   children: [
//                     tableCell(replacement.replacedFor?.name ?? ""),
//                     tableCell(
//                       replacement.fromDate != null
//                           ? Utils.timestampToDateConversion(
//                         int.tryParse(replacement.fromDate ?? '0') ?? 0,
//                         Constants.dateFormat,
//                       )
//                           : '',
//                     ),
//                     tableCell(
//                       replacement.toDate != null
//                           ? Utils.timestampToDateConversion(
//                         int.tryParse(replacement.toDate ?? '0') ?? 0,
//                         Constants.dateFormat,
//                       )
//                           : '',
//                     ),
//                     tableCell(
//                       (Utils().getKeyFromValue(
//                         value: replacement.status!,
//                         dropdownValues: shiftScheduleReasonDropDownValues,
//                       ) ??
//                           ''),
//                     ),
//                     tableCell(replacement.replacementBy?.name ?? ""),
//                     tableCell(
//                       (Utils().getKeyFromValue(
//                         value: replacement.status!,
//                         dropdownValues: replacementTypeDropDownValues,
//                       ) ??
//                           ''),
//                     ),
//                     Center(
//                       child: state.model.attdStatus != 2
//                           ? IconButton(
//                         icon: const Icon(
//                           Icons.close,
//                           size: 18,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {
//                           BlocProvider.of<AttendanceShiftsCubit>(
//                               context)
//                               .removeReplacement(
//                             replacement,
//                             context: context,
//                           );
//                         },
//                       )
//                           : const SizedBox.shrink(),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }
//
//     return rows;
//   }
//
//   Widget tableHeader(String label) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         label,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 8,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   Widget tableCell(String value) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         value,
//         style: const TextStyle(
//           fontSize: 8,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
//
//   Widget buildTextWithLabel(String label, String? value) {
//     return RichText(
//       text: TextSpan(
//         children: [
//           TextSpan(
//             text: '$label ',
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           TextSpan(
//             text: value,
//             style: const TextStyle(
//               color: AppColors.white,
//               fontSize: 14,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void handleUserTap(BaseUser element) {
//     log('---handleUserTap---');
//     setState(() {
//       selectedGuard = element;
//     });
//   }
//  void removeAttendedGuard(BaseUser element) {
//     log('---removeAttendedGuard---${element.name}');
//     final cubit = BlocProvider.of<AttendanceShiftsCubit>(context);
//     cubit.unmarkGuardAttended(element);
//
//     if (selectedGuard == element) {
//       setState(() {
//         selectedGuard = null;
//       });
//     }
//   }
//
//   Widget buildUserList({
//     required Set<BaseUser> availableGuards,
//     bool showRemoveButton = false,
//   }) {
//     double width = MediaQuery.of(context).size.width;
//     double columnWidth;
//     if (width > Constants.tabletScreenWidth) {
//       columnWidth = width / 2.6;
//     } else {
//       columnWidth = width / 1.2;
//     }
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Colors.white.withValues(alpha: 0.09),
//             Colors.transparent,
//             Colors.white.withValues(alpha: 0.09),
//           ],
//           stops: const [0.02, 0.35, 1],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//         borderRadius: BorderRadius.circular(27),
//         border: Border.all(
//           color: Colors.white.withValues(alpha: 1),
//           width: 0.7,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.white.withValues(alpha: 0.0),
//             blurRadius: 12,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       height: MediaQuery.of(context).size.height / 8.5,
//       width: columnWidth,
//       child: ListView.builder(
//         itemCount: availableGuards.length,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           final element = availableGuards.toList()[index];
//           final bool isSelected = selectedGuard == element;
//
//           return GestureDetector(
//             onTap: () => handleUserTap(element),
//             child: Card(
//               color: isSelected ? AppColors.navigationSkyBlueColor : AppColors.navigationSkyBlueColor,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 8.0,
//                   vertical: 4.0,
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Tooltip(
//                         preferBelow: false,
//                         message: isSelected ? element.name ?? '' : '',
//                         child: Text(
//                           element.name ?? '',
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: isSelected
//                                 ? AppColors.white
//                                 : AppColors.white,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                     if (showRemoveButton)
//                       IconButton(
//                         icon: Icon(
//                           Icons.close,
//                           size: 18,
//                           color: isSelected
//                               ? AppColors.white
//                               : AppColors.white,
//                         ),
//                         tooltip: 'Remove',
//                         splashRadius: 18,
//                         onPressed: () => removeAttendedGuard(element),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void showReplacementPopUp({
//     required BuildContext context,
//     required Replacement model,
//     required Set<BaseUser> selectedGuards,
//     required AttendanceShiftsState state,
//     required int rankId,
//     required int shiftId,
//     required int dutyPostId,
//     required int attendanceId,
//   }) {
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AddReplacementPopUp(
//           viaAttendance: true,
//           model: model,
//           mainContext: context,
//           selectedGuards: selectedGuards,
//           shiftModel: state.model,
//           shiftId: shiftId,
//           rankId: rankId,
//           dutyPostId: dutyPostId,
//           attendanceId: attendanceId,
//         );
//       },
//     );
//   }
// }

import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/opacity_absorb_widget.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';

import '../../attendance_details/views/attendance_details_view.dart';

class AttendanceShiftsView extends StatefulWidget {
  const AttendanceShiftsView({
    super.key,
    required this.location,
    required this.locationRegion,
    required this.vendor,
    required this.attInfoId,
    required this.selectedDutyPostModel,
    required this.isReadOnly,
    required this.isEligibleToEdit,
  });

  final Organisation location;
  final Organisation locationRegion;
  final Organisation vendor;
  final int attInfoId;
  final DutyPostModel selectedDutyPostModel;
  final bool isReadOnly;
  final bool isEligibleToEdit;

  @override
  AttendanceShiftsViewState createState() => AttendanceShiftsViewState();
}

class AttendanceShiftsViewState extends State<AttendanceShiftsView> {
  bool isReadOnly = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return BlocConsumer<AttendanceShiftsCubit, AttendanceShiftsState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => CustomAlertDialog(
              title: 'Attendance',
              message: state.message ?? '',
              positiveBtnText: Constants.ok,
              onPositivePressed: () {
                Navigator.pop(context); // close the success dialog

                int flag = AttendanceDetailsView.flag;
                if (flag == 1) {
                  Navigator.pop(context); // back to Attendance Details
                } else {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
            ),
          );
        }
      },
      builder: (context, state) {
        if (!state.model.lock.isEmptyOrNull) isReadOnly = true;
        if (state.model.attdStatus != 1) isReadOnly = true;
        if (!widget.isEligibleToEdit) isReadOnly = true;
        if (state.model.attdStatus == 1 && widget.isEligibleToEdit) {
          isReadOnly = false;
        }
        if (state.model.activeShift) isReadOnly = false;

        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.selectedDutyPostModel.name ?? '',
            showPopUp: false,
            showSaveButton: false,
            showSubmitButton:
            state.model.activeShift && !isReadOnly,
            showDisLikeButton: false,
            showLikeButton: false,
            popAndReplace: () {
              int flag = AttendanceDetailsView.flag;
              if (flag == 1) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            // onTapSubmit: () {
            //   showDialog(
            //     context: context,
            //     builder: (_) => AlertDialog(
            //       title: const Text(Constants.attendanceMessage),
            //       content: const Text(Constants.attendanceSubmissionMessage),
            //       actions: [
            //         TextButton(
            //           child: const Text(Constants.cancel),
            //           onPressed: () => Navigator.pop(context),
            //         ),
            //         TextButton(
            //           child: const Text(Constants.ok),
            //           onPressed: () async {
            //             FocusScope.of(context).unfocus();
            //             Navigator.pop(context); // close confirmation dialog
            //
            //             showDialog(
            //               context: context,
            //               barrierDismissible: false,
            //               builder: (_) => const Center(child: CircularProgressIndicator()),
            //             );
            //
            //             try {
            //               await BlocProvider.of<AttendanceShiftsCubit>(context)
            //                   .submitAndRefreshScreen(
            //                 isSubmit: true,
            //                 isSaveOnly: false,
            //                 isRemove: false,
            //               );
            //             } finally {
            //               if (context.mounted) {
            //                 Navigator.pop(context); // always close loader, success or failure
            //               }
            //             }
            //
            //             if (context.mounted) {
            //               int flag = AttendanceDetailsView.flag;
            //               if (flag == 1) {
            //                 Navigator.pop(context);
            //               } else {
            //                 Navigator.pop(context);
            //                 Navigator.pop(context);
            //                 Navigator.pop(context);
            //               }
            //             }
            //           },
            //         ),
            //       ],
            //     ),
            //   );
            // },
            onTapSubmit: () {
              showDialog(
                context: context,
                barrierColor: Colors.black.withValues(alpha: 0.4),
                builder: (_) => _buildGlassDialog(
                  title: Constants.attendanceMessage,
                  message: Constants.attendanceSubmissionMessage,
                  onCancel: () => Navigator.pop(context),
                  onConfirm: () async {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context); // close confirmation dialog

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const Center(child: CircularProgressIndicator()),
                    );

                    try {
                      await BlocProvider.of<AttendanceShiftsCubit>(context)
                          .submitAndRefreshScreen(
                        isSubmit: true,
                        isSaveOnly: false,
                        isRemove: false,
                      );
                    } finally {
                      if (context.mounted) {
                        Navigator.pop(context); // always close loader, success or failure
                      }
                    }

                    if (context.mounted) {
                      int flag = AttendanceDetailsView.flag;
                      if (flag == 1) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              );
            },
          ),

          // ================= BODY WITH BACKGROUND =================
          body: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/bg2.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Blur overlay
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.15),
                  ),
                ),
              ),

              // Page content
              Positioned.fill(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: kToolbarHeight +
                                MediaQuery.of(context).padding.top,
                          ),
                          getBody(state, height, state.model),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void submitDutyPost(BuildContext context,
      {required bool isSaveOnly,
        required bool isRemove,
        required bool isSubmit}) {
    FocusScope.of(context).unfocus();
    log('----onTap${isSaveOnly ? 'Save' : 'Submit'}--');
    BlocProvider.of<AttendanceShiftsCubit>(context).submitForm(
        isSaveOnly: isSaveOnly,
        status: isSaveOnly ? FormStatus.initial : null,
        isRemove: isRemove,
        isSubmit: isSubmit);
  }

  Widget getBody(
      AttendanceShiftsState state,
      double height,
      ShiftModel model,
      ) {

    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.verticalSpacerWidget(height * 0.01),
              Expanded(
                child: SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: buildDutyPostSelectionWidget(
                        state: state,
                        height: height,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Organisation? selectedRank;
  Organisation? selectedShift;

  List<Widget> buildDutyPostSelectionWidget({
    required AttendanceShiftsState state,
    required double height,
  }) {
    return [
      if (!state.model.lock.isEmptyOrNull) ...[
        RecordLockedWidget(text: '${state.model.lock}'),
      ],

      /// Rank Dropdown
      CommonWidgets.textDisplay(
        state.labels?.locale.rank ??
            state.labels?.defaultLocale.rank ??
            Constants.rank,
        Styles.textStyleWhite16,
        isMandatory: true,
      ),

      DropdownWidget(
        label: 'Select Rank',
        items: state.ranks ?? [],
        isInitial: false,
        initialValue: selectedRank,
        onChange: (Organisation? value) async {
          setState(() {
            selectedRank = value;
            selectedShift = null;
            state.model.selectForAttendance = null;
            state.model.shift = null;
          });
          log('---onChange-region-----');

          BlocProvider.of<AttendanceShiftsCubit>(context)
              .getShifts(rank: value!);
        },
      ),
      CommonWidgets.verticalSpacerWidget(height * 0.02),

      /// Select For Shift Dropdown
      CommonWidgets.textDisplay(
        state.labels?.locale.rank ??
            state.labels?.defaultLocale.rank ??
            Constants.selectForShift,
        Styles.textStyleWhite16,
        isMandatory: true,
      ),
      DropdownWidget(
        label: 'Select Shift',
        items: state.shifts ?? [],
        isInitial:
        selectedRank != null && selectedShift == null ? true : false,
        initialValue: selectedShift,
        onChange: (Organisation? value) {
          setState(() {
            selectedShift = value;
          });

          BlocProvider.of<AttendanceShiftsCubit>(context)
              .getAvailableSelectedGuardsByShift(
            shift: value!,
          );
        },
      ),
      CommonWidgets.verticalSpacerWidget(
          MediaQuery.of(context).size.height * 0.02),
      buildTextWithLabel(
          'Attendance Status:',
          Utils().buildAttendanceShiftStatusRow(
              status: state.model.attdStatus ?? 0, returnTextOnly: true)),
      CommonWidgets.verticalSpacerWidget(
          MediaQuery.of(context).size.height * 0.01),

      /// Planned / Present row
      buildPlannedPresentRow(
        planned: state.model.allowed ?? 0,
        present: state.model.attended?.length ?? 0,
      ),
      CommonWidgets.verticalSpacerWidget(
          MediaQuery.of(context).size.height * 0.01),

      OpacityAbsorbInkWellWidget(
        absorbing: false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Opacity(
                  opacity: state.model.attdStatus != 1 ? 0.5 : 1.0,
                  child: AbsorbPointer(
                    absorbing: state.model.attdStatus != 1,
                    child: buildShiftColumn(
                      shift: state.model,
                      guards: state.model.attended ?? {},
                      destinationList: state.model.attended ?? {},
                      isSourceList: false,
                      label: 'Attended Marking\n',
                      // Only the attended list gets a remove (✕) button.
                      showRemoveButton: true,
                    ),
                  ),
                ),
              ],
            ),
            CommonWidgets.verticalSpacerWidget(
                MediaQuery.of(context).size.height * 0.01),
            AbsorbPointer(
              absorbing: state.model.activeShift == false,
              child: buildReplacementColumn(state),
            ),
            CommonWidgets.verticalSpacerWidget(
                MediaQuery.of(context).size.height * 0.01),
            AbsorbPointer(
              absorbing: state.model.activeShift == false,
              child: buildSlaListColumn(
                state: state,
                shift: state.model,
              ),
            ),
            CommonWidgets.verticalSpacerWidget(
                MediaQuery.of(context).size.height * 0.02),
          ],
        ),
      ),
    ];
  }

  /// Builds a single row that displays "Planned: X   Present: Y"
  /// planned  -> comes from `allowed` in the JSON model
  /// present  -> comes from the length of the `attended` set in the JSON model
  Widget buildPlannedPresentRow({
    required int planned,
    required int present,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextWithLabel('Planned:', '$planned'),
        const SizedBox(width: 20),
        buildTextWithLabel('Present:', '$present'),
      ],
    );
  }

  Widget buildArrowButton({
    required AttendanceShiftsState state,
    required IconData icon,
    required Set<BaseUser> destinationList,
    required bool isRemove,
  }) {
    return IconButton(
      iconSize: 30,
      color: Colors.white,
      onPressed: () {
        if (selectedGuard == null ||
            destinationList.contains(selectedGuard)) {
          return;
        }
        final cubit = BlocProvider.of<AttendanceShiftsCubit>(context);
        if (isRemove) {
          cubit.unmarkGuardAttended(selectedGuard!);
        } else {
          cubit.markGuardAttended(selectedGuard!);
        }
      },
      icon: Icon(icon),
    );
  }

  BaseUser? selectedGuard;

  Widget buildShiftColumn({
    required ShiftModel shift,
    required Set<BaseUser> guards,
    required bool isSourceList,
    required String label,
    required Set<BaseUser> destinationList,
    bool showRemoveButton = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonWidgets.textDisplay(
          label,
          isMandatory: false,
          Styles.textStyleWhite17,
        ),
        AbsorbPointer(
          absorbing: false,
          child: buildUserList(
            availableGuards: guards,
            showRemoveButton: showRemoveButton,
          ),
        ),
      ],
    );
  }

  Column buildSlaListColumn({
    required AttendanceShiftsState state,
    required ShiftModel shift,
  }) {
    List<SLAViolationPenaltyModel> slaList = [];

    log('----state.shiftSlaList--${state.shiftSlaList?.length}-');

    if (!state.shiftSlaList.isEmptyOrNull) {
      SlaList? sla = state.shiftSlaList?.firstWhere(
            (element) => element.attInfoId == shift.attendanceShiftId,
        orElse: () => SlaList(),
      );

      slaList = sla?.items ?? [];
    }
    slaList = state.shiftSlaList?.first.items ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (!isReadOnly) {
              Navigator.pushNamed(
                context,
                slaViolationPenaltyDetailsRoute,
                arguments: {
                  ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
                  ConstantsArgument.attdInfoId: state.model.attendanceShiftId,
                  ConstantsArgument.location: widget.location,
                  ConstantsArgument.locationRegion: widget.locationRegion,
                },
              ).then((_) =>
                  BlocProvider.of<AttendanceShiftsCubit>(context)
                      .submitAndRefreshScreen(
                      isRemove: false, isSubmit: false, isSaveOnly: true));
            }
          },
          child: Row(
            children: <Widget>[
              const SizedBox(width: 14),
              SvgPicture.asset(
                AppIcon.plusCircle,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Add SLA Violation',
                style: TextStyle(
                  color: AppColors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.white,
                ),
              ),
              CommonWidgets.verticalSpacerWidget(
                  MediaQuery.of(context).size.height * 0.08),
            ],
          ),
        ),
        if (!slaList.isEmptyOrNull) ...[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.094,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: slaList.length,
              itemBuilder: (context, index) {
                return buildSlaCard(slaList[index]);
              },
            ),
          ),
          CommonWidgets.verticalSpacerWidget(
              MediaQuery.of(context).size.height * 0.02),
        ],
      ],
    );
  }

  Widget buildSlaCard(SLAViolationPenaltyModel models) {
    return InkWell(
      onTap: () async {
        var nav = Navigator.of(context);
        SLAViolationPenaltyModel model =
        await SLAViolationPenaltyServices().getGvpById(models.id ?? 0);
        nav.pushNamed(
          slaViolationPenaltyDetailsRoute,
          arguments: {
            "model": model,
            "title": Constants.slaViolationPenaltyTitle,
          },
        );
      },
      child: IntrinsicHeight(
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: Colors.white,
              width: 0.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextWithLabel('Id:', models.id.toString()),
                buildTextWithLabel('Region:', models.locationRegion?.name),
                buildTextWithLabel('Location:', models.location?.name),
                buildTextWithLabel('Created By:', models.entrySecurity?.name),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int? _resolveRankId(AttendanceShiftsState state) =>
      state.selectedRank?.id ?? selectedRank?.id;

  int? _resolveShiftId(AttendanceShiftsState state) =>
      state.selectedShift?.id ?? selectedShift?.id;

  int _resolveDutyPostId(BuildContext context) =>
      BlocProvider.of<AttendanceShiftsCubit>(context).selectedDutyPostNameId;

  int _resolveAttendanceId() => widget.attInfoId;

  Column buildReplacementColumn(AttendanceShiftsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if(!isReadOnly) {
              final rankId = _resolveRankId(state);
              final shiftId = _resolveShiftId(state);

              if (rankId == null || shiftId == null) {
                Validator().showToast(
                  context,
                  'Please select Rank and Shift before adding a replacement',
                );
                return;
              }

              showReplacementPopUp(
                context: context,
                model: Replacement(),
                selectedGuards: state.model.selectForReplacements ?? {},
                state: state,
                rankId: rankId,
                shiftId: shiftId,
                dutyPostId: _resolveDutyPostId(context),
                attendanceId: _resolveAttendanceId(),
              );
            }
          },
          child: Row(
            children: <Widget>[
              const SizedBox(width: 14),
              SvgPicture.asset(
                AppIcon.plusCircle,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                Constants.addReplacement,
                style: TextStyle(
                  color: AppColors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
              CommonWidgets.verticalSpacerWidget(
                  MediaQuery.of(context).size.height * 0.08),
            ],
          ),
        ),
        if (_activeReplacements(state).isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: buildReplacements(state),
            ),
          ),
          CommonWidgets.verticalSpacerWidget(
              MediaQuery.of(context).size.height * 0.01),
        ],
      ],
    );
  }

  List<Replacement> _activeReplacements(AttendanceShiftsState state) {
    return (state.model.replacements ?? {}).toList();
  }

  List<Widget> buildReplacements(AttendanceShiftsState state) {
    log('selectForReplacements${state.model.selectForReplacements}');

    List<Widget> rows = [];

    rows.add(
      Container(
        decoration: BoxDecoration(
          color: AppColors.newColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Table(
          border: TableBorder.symmetric(
            inside: BorderSide(color: Colors.grey.shade300),
          ),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(2),
            5: FlexColumnWidth(2),
            6: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: [
                tableHeader("Replacement For"),
                tableHeader("From Date"),
                tableHeader("To Date"),
                tableHeader("Reason"),
                tableHeader("Replacement By"),
                tableHeader("Replacement Type"),
                tableHeader(""),
              ],
            )
          ],
        ),
      ),
    );

    for (Replacement replacement in _activeReplacements(state)) {
      rows.add(
        InkWell(
          onTap: () {
            final canEdit = (state.model.attdStatus == 1 &&
                replacement.statusActive == true) ||
                (state.model.attdStatus == 2 &&
                    replacement.statusActive == true);
            if (!canEdit) return;

            final rankId = _resolveRankId(state);
            final shiftId = _resolveShiftId(state);

            if (rankId == null || shiftId == null) {
              Validator().showToast(
                context,
                'Please select Rank and Shift before editing a replacement',
              );
              return;
            }

            showReplacementPopUp(
              context: context,
              model: replacement,
              selectedGuards: state.model.selectForReplacements ?? {},
              state: state,
              rankId: rankId,
              shiftId: shiftId,
              dutyPostId: _resolveDutyPostId(context),
              attendanceId: _resolveAttendanceId(),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Table(
              border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey.shade300),
              ),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
                3: FlexColumnWidth(2),
                4: FlexColumnWidth(2),
                5: FlexColumnWidth(2),
                6: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    tableCell(replacement.replacedFor?.name ?? ""),
                    tableCell(
                      replacement.fromDate != null
                          ? Utils.timestampToDateConversion(
                        int.tryParse(replacement.fromDate ?? '0') ?? 0,
                        Constants.dateFormat,
                      )
                          : '',
                    ),
                    tableCell(
                      replacement.toDate != null
                          ? Utils.timestampToDateConversion(
                        int.tryParse(replacement.toDate ?? '0') ?? 0,
                        Constants.dateFormat,
                      )
                          : '',
                    ),
                    tableCell(
                      (Utils().getKeyFromValue(
                        value: replacement.status!,
                        dropdownValues: shiftScheduleReasonDropDownValues,
                      ) ??
                          ''),
                    ),
                    tableCell(replacement.replacementBy?.name ?? ""),
                    tableCell(
                      (Utils().getKeyFromValue(
                        value: replacement.status!,
                        dropdownValues: replacementTypeDropDownValues,
                      ) ??
                          ''),
                    ),
                    Center(
                      child: state.model.attdStatus != 2
                          ? IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          BlocProvider.of<AttendanceShiftsCubit>(
                              context)
                              .removeReplacement(
                            replacement,
                            context: context,
                          );
                        },
                      )
                          : const SizedBox.shrink(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return rows;
  }

  Widget tableHeader(String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 8,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget tableCell(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 8,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildTextWithLabel(String label, String? value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void handleUserTap(BaseUser element) {
    log('---handleUserTap---');
    setState(() {
      selectedGuard = element;
    });
  }

  void removeAttendedGuard(BaseUser element) {
    log('---removeAttendedGuard---${element.name}');
    final cubit = BlocProvider.of<AttendanceShiftsCubit>(context);
    cubit.unmarkGuardAttended(element);

    if (selectedGuard == element) {
      setState(() {
        selectedGuard = null;
      });
    }
  }

  Widget buildUserList({
    required Set<BaseUser> availableGuards,
    bool showRemoveButton = false,
  }) {
    double width = MediaQuery.of(context).size.width;
    double columnWidth;
    if (width > Constants.tabletScreenWidth) {
      columnWidth = width / 2.6;
    } else {
      columnWidth = width / 1.2;
    }
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.09),
            Colors.transparent,
            Colors.white.withValues(alpha: 0.09),
          ],
          stops: const [0.02, 0.35, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(27),
        border: Border.all(
          color: Colors.white.withValues(alpha: 1),
          width: 0.7,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.0),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height / 8.5,
      width: columnWidth,
      child: ListView.builder(
        itemCount: availableGuards.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final element = availableGuards.toList()[index];
          final bool isSelected = selectedGuard == element;

          return GestureDetector(
            onTap: () => handleUserTap(element),
            child: Card(
              color: isSelected ? AppColors.navigationSkyBlueColor : AppColors.navigationSkyBlueColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Tooltip(
                        preferBelow: false,
                        message: isSelected ? element.name ?? '' : '',
                        child: Text(
                          element.name ?? '',
                          style: TextStyle(
                            fontSize: 15,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    if (showRemoveButton)
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 18,
                          color: isSelected
                              ? AppColors.white
                              : AppColors.white,
                        ),
                        tooltip: 'Remove',
                        splashRadius: 18,
                        onPressed: () => removeAttendedGuard(element),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGlassDialog({
    required String title,
    required String message,
    required VoidCallback onCancel,
    required Future<void> Function() onConfirm,
  }) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.02),
                  Colors.white.withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.55),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: onCancel,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white.withValues(alpha: 0.8),
                      ),
                      child: const Text(Constants.cancel),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: onConfirm,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white.withValues(alpha: 0.12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      child: const Text(Constants.ok),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void showReplacementPopUp({
    required BuildContext context,
    required Replacement model,
    required Set<BaseUser> selectedGuards,
    required AttendanceShiftsState state,
    required int rankId,
    required int shiftId,
    required int dutyPostId,
    required int attendanceId,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddReplacementPopUp(
          viaAttendance: true,
          model: model,
          mainContext: context,
          selectedGuards: selectedGuards,
          shiftModel: state.model,
          shiftId: shiftId,
          rankId: rankId,
          dutyPostId: dutyPostId,
          attendanceId: attendanceId,
        );
      },
    );
  }
}