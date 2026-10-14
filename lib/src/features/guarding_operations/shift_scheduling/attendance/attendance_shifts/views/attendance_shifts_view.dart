// // // // // //
// // // // // // // import 'dart:developer';
// // // // // // // import 'dart:ui';
// // // // // // //
// // // // // // // import 'package:db_atom/index.dart';
// // // // // // // import 'package:db_atom/src/common_widgets/base_widget/opacity_absorb_widget.dart';
// // // // // // // import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';
// // // // // // //
// // // // // // // import '../../attendance_details/views/attendance_details_view.dart';
// // // // // // //
// // // // // // // class AttendanceShiftsView extends StatefulWidget {
// // // // // // //   const AttendanceShiftsView({
// // // // // // //     super.key,
// // // // // // //     required this.location,
// // // // // // //     required this.locationRegion,
// // // // // // //     required this.vendor,
// // // // // // //     required this.attInfoId,
// // // // // // //     required this.selectedDutyPostModel,
// // // // // // //     required this.isReadOnly,
// // // // // // //     required this.isEligibleToEdit,
// // // // // // //   });
// // // // // // //
// // // // // // //   final Organisation location;
// // // // // // //   final Organisation locationRegion;
// // // // // // //   final Organisation vendor;
// // // // // // //   final int attInfoId;
// // // // // // //   final DutyPostModel selectedDutyPostModel;
// // // // // // //   final bool isReadOnly;
// // // // // // //   final bool isEligibleToEdit;
// // // // // // //
// // // // // // //   @override
// // // // // // //   AttendanceShiftsViewState createState() => AttendanceShiftsViewState();
// // // // // // // }
// // // // // // //
// // // // // // // class AttendanceShiftsViewState extends State<AttendanceShiftsView> {
// // // // // // //   bool isReadOnly = false;
// // // // // // //
// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //     BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// // // // // // //   }
// // // // // // //
// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     final size = MediaQuery.of(context).size;
// // // // // // //     final height = size.height;
// // // // // // //
// // // // // // //     return BlocConsumer<AttendanceShiftsCubit, AttendanceShiftsState>(
// // // // // // //       listener: (context, state) {
// // // // // // //         Utils().formError(state, context);
// // // // // // //         Utils().errorAndLogout(state, context);
// // // // // // //
// // // // // // //         if (state.status == FormStatus.success) {
// // // // // // //           showDialog(
// // // // // // //             context: context,
// // // // // // //             barrierDismissible: false,
// // // // // // //             builder: (_) => CustomAlertDialog(
// // // // // // //               title: 'Attendance',
// // // // // // //               message: state.message ?? '',
// // // // // // //               positiveBtnText: Constants.ok,
// // // // // // //               onPositivePressed: () {
// // // // // // //                 Navigator.pop(context); // close the success dialog
// // // // // // //
// // // // // // //                 int flag = AttendanceDetailsView.flag;
// // // // // // //                 if (flag == 1) {
// // // // // // //                   Navigator.pop(context); // back to Attendance Details
// // // // // // //                 } else {
// // // // // // //                   Navigator.pop(context);
// // // // // // //                   Navigator.pop(context);
// // // // // // //                   Navigator.pop(context);
// // // // // // //                 }
// // // // // // //               },
// // // // // // //             ),
// // // // // // //           );
// // // // // // //         }
// // // // // // //       },
// // // // // // //       builder: (context, state) {
// // // // // // //         if (!state.model.lock.isEmptyOrNull) isReadOnly = true;
// // // // // // //         if (state.model.attdStatus != 1) isReadOnly = true;
// // // // // // //         if (!widget.isEligibleToEdit) isReadOnly = true;
// // // // // // //         if (state.model.attdStatus == 1 && widget.isEligibleToEdit) {
// // // // // // //           isReadOnly = false;
// // // // // // //         }
// // // // // // //         if (state.model.activeShift) isReadOnly = false;
// // // // // // //
// // // // // // //         return Scaffold(
// // // // // // //           backgroundColor: Colors.transparent,
// // // // // // //           extendBodyBehindAppBar: true,
// // // // // // //           appBar: BaseAppBar().buildAppHeader(
// // // // // // //             context: context,
// // // // // // //             title: widget.selectedDutyPostModel.name ?? '',
// // // // // // //             showPopUp: false,
// // // // // // //             showSaveButton: false,
// // // // // // //             showSubmitButton:
// // // // // // //             state.model.activeShift && !isReadOnly,
// // // // // // //             showDisLikeButton: false,
// // // // // // //             showLikeButton: false,
// // // // // // //             popAndReplace: () {
// // // // // // //               int flag = AttendanceDetailsView.flag;
// // // // // // //               if (flag == 1) {
// // // // // // //                 Navigator.pop(context);
// // // // // // //               } else {
// // // // // // //                 Navigator.pop(context);
// // // // // // //                 Navigator.pop(context);
// // // // // // //                 Navigator.pop(context);
// // // // // // //               }
// // // // // // //             },
// // // // // // //             // onTapSubmit: () {
// // // // // // //             //   showDialog(
// // // // // // //             //     context: context,
// // // // // // //             //     builder: (_) => AlertDialog(
// // // // // // //             //       title: const Text(Constants.attendanceMessage),
// // // // // // //             //       content: const Text(Constants.attendanceSubmissionMessage),
// // // // // // //             //       actions: [
// // // // // // //             //         TextButton(
// // // // // // //             //           child: const Text(Constants.cancel),
// // // // // // //             //           onPressed: () => Navigator.pop(context),
// // // // // // //             //         ),
// // // // // // //             //         TextButton(
// // // // // // //             //           child: const Text(Constants.ok),
// // // // // // //             //           onPressed: () async {
// // // // // // //             //             FocusScope.of(context).unfocus();
// // // // // // //             //             Navigator.pop(context); // close confirmation dialog
// // // // // // //             //
// // // // // // //             //             showDialog(
// // // // // // //             //               context: context,
// // // // // // //             //               barrierDismissible: false,
// // // // // // //             //               builder: (_) => const Center(child: CircularProgressIndicator()),
// // // // // // //             //             );
// // // // // // //             //
// // // // // // //             //             try {
// // // // // // //             //               await BlocProvider.of<AttendanceShiftsCubit>(context)
// // // // // // //             //                   .submitAndRefreshScreen(
// // // // // // //             //                 isSubmit: true,
// // // // // // //             //                 isSaveOnly: false,
// // // // // // //             //                 isRemove: false,
// // // // // // //             //               );
// // // // // // //             //             } finally {
// // // // // // //             //               if (context.mounted) {
// // // // // // //             //                 Navigator.pop(context); // always close loader, success or failure
// // // // // // //             //               }
// // // // // // //             //             }
// // // // // // //             //
// // // // // // //             //             if (context.mounted) {
// // // // // // //             //               int flag = AttendanceDetailsView.flag;
// // // // // // //             //               if (flag == 1) {
// // // // // // //             //                 Navigator.pop(context);
// // // // // // //             //               } else {
// // // // // // //             //                 Navigator.pop(context);
// // // // // // //             //                 Navigator.pop(context);
// // // // // // //             //                 Navigator.pop(context);
// // // // // // //             //               }
// // // // // // //             //             }
// // // // // // //             //           },
// // // // // // //             //         ),
// // // // // // //             //       ],
// // // // // // //             //     ),
// // // // // // //             //   );
// // // // // // //             // },
// // // // // // //             onTapSubmit: () {
// // // // // // //               showDialog(
// // // // // // //                 context: context,
// // // // // // //                 barrierColor: Colors.black.withValues(alpha: 0.4),
// // // // // // //                 builder: (_) => _buildGlassDialog(
// // // // // // //                   title: Constants.attendanceMessage,
// // // // // // //                   message: Constants.attendanceSubmissionMessage,
// // // // // // //                   onCancel: () => Navigator.pop(context),
// // // // // // //                   onConfirm: () async {
// // // // // // //                     FocusScope.of(context).unfocus();
// // // // // // //                     Navigator.pop(context); // close confirmation dialog
// // // // // // //
// // // // // // //                     showDialog(
// // // // // // //                       context: context,
// // // // // // //                       barrierDismissible: false,
// // // // // // //                       builder: (_) => const Center(child: CircularProgressIndicator()),
// // // // // // //                     );
// // // // // // //
// // // // // // //                     try {
// // // // // // //                       await BlocProvider.of<AttendanceShiftsCubit>(context)
// // // // // // //                           .submitAndRefreshScreen(
// // // // // // //                         isSubmit: true,
// // // // // // //                         isSaveOnly: false,
// // // // // // //                         isRemove: false,
// // // // // // //                       );
// // // // // // //                     } finally {
// // // // // // //                       if (context.mounted) {
// // // // // // //                         Navigator.pop(context); // always close loader, success or failure
// // // // // // //                       }
// // // // // // //                     }
// // // // // // //
// // // // // // //                     if (context.mounted) {
// // // // // // //                       int flag = AttendanceDetailsView.flag;
// // // // // // //                       if (flag == 1) {
// // // // // // //                         Navigator.pop(context);
// // // // // // //                       } else {
// // // // // // //                         Navigator.pop(context);
// // // // // // //                         Navigator.pop(context);
// // // // // // //                         Navigator.pop(context);
// // // // // // //                       }
// // // // // // //                     }
// // // // // // //                   },
// // // // // // //                 ),
// // // // // // //               );
// // // // // // //             },
// // // // // // //           ),
// // // // // // //
// // // // // // //           // ================= BODY WITH BACKGROUND =================
// // // // // // //           body: Stack(
// // // // // // //             children: [
// // // // // // //               // Background image
// // // // // // //               Positioned.fill(
// // // // // // //                 child: Image.asset(
// // // // // // //                   'assets/images/bg2.png',
// // // // // // //                   fit: BoxFit.cover,
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //
// // // // // // //               // Blur overlay
// // // // // // //               Positioned.fill(
// // // // // // //                 child: BackdropFilter(
// // // // // // //                   filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
// // // // // // //                   child: Container(
// // // // // // //                     color: Colors.black.withValues(alpha: 0.15),
// // // // // // //                   ),
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //
// // // // // // //               // Page content
// // // // // // //               Positioned.fill(
// // // // // // //                 child: MediaQuery.removePadding(
// // // // // // //                   context: context,
// // // // // // //                   removeTop: true,
// // // // // // //                   child: Padding(
// // // // // // //                     padding: const EdgeInsets.all(20),
// // // // // // //                     child: SingleChildScrollView(
// // // // // // //                       child: Column(
// // // // // // //                         children: [
// // // // // // //                           SizedBox(
// // // // // // //                             height: kToolbarHeight +
// // // // // // //                                 MediaQuery.of(context).padding.top,
// // // // // // //                           ),
// // // // // // //                           getBody(state, height, state.model),
// // // // // // //                         ],
// // // // // // //                       ),
// // // // // // //                     ),
// // // // // // //                   ),
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //             ],
// // // // // // //           ),
// // // // // // //         );
// // // // // // //       },
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   void submitDutyPost(BuildContext context,
// // // // // // //       {required bool isSaveOnly,
// // // // // // //         required bool isRemove,
// // // // // // //         required bool isSubmit}) {
// // // // // // //     FocusScope.of(context).unfocus();
// // // // // // //     log('----onTap${isSaveOnly ? 'Save' : 'Submit'}--');
// // // // // // //     BlocProvider.of<AttendanceShiftsCubit>(context).submitForm(
// // // // // // //         isSaveOnly: isSaveOnly,
// // // // // // //         status: isSaveOnly ? FormStatus.initial : null,
// // // // // // //         isRemove: isRemove,
// // // // // // //         isSubmit: isSubmit);
// // // // // // //   }
// // // // // // //
// // // // // // //   Widget getBody(
// // // // // // //       AttendanceShiftsState state,
// // // // // // //       double height,
// // // // // // //       ShiftModel model,
// // // // // // //       ) {
// // // // // // //
// // // // // // //     if (state.status == FormStatus.loading) {
// // // // // // //       return const BaseLoader();
// // // // // // //     }
// // // // // // //     return Column(
// // // // // // //       mainAxisSize: MainAxisSize.min,
// // // // // // //       children: [
// // // // // // //         IntrinsicHeight(
// // // // // // //           child: Column(
// // // // // // //             mainAxisAlignment: MainAxisAlignment.start,
// // // // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //             children: [
// // // // // // //               CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // // // // //               Expanded(
// // // // // // //                 child: SingleChildScrollView(
// // // // // // //                   child: IntrinsicHeight(
// // // // // // //                     child: Column(
// // // // // // //                       mainAxisAlignment: MainAxisAlignment.start,
// // // // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //                       children: buildDutyPostSelectionWidget(
// // // // // // //                         state: state,
// // // // // // //                         height: height,
// // // // // // //                       ),
// // // // // // //                     ),
// // // // // // //                   ),
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //             ],
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //       ],
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   Organisation? selectedRank;
// // // // // // //   Organisation? selectedShift;
// // // // // // //
// // // // // // //   List<Widget> buildDutyPostSelectionWidget({
// // // // // // //     required AttendanceShiftsState state,
// // // // // // //     required double height,
// // // // // // //   }) {
// // // // // // //     return [
// // // // // // //       if (!state.model.lock.isEmptyOrNull) ...[
// // // // // // //         RecordLockedWidget(text: '${state.model.lock}'),
// // // // // // //       ],
// // // // // // //
// // // // // // //       /// Rank Dropdown
// // // // // // //       CommonWidgets.textDisplay(
// // // // // // //         state.labels?.locale.rank ??
// // // // // // //             state.labels?.defaultLocale.rank ??
// // // // // // //             Constants.rank,
// // // // // // //         Styles.textStyleWhite16,
// // // // // // //         isMandatory: true,
// // // // // // //       ),
// // // // // // //
// // // // // // //       DropdownWidget(
// // // // // // //         label: 'Select Rank',
// // // // // // //         items: state.ranks ?? [],
// // // // // // //         isInitial: false,
// // // // // // //         initialValue: selectedRank,
// // // // // // //         onChange: (Organisation? value) async {
// // // // // // //           setState(() {
// // // // // // //             selectedRank = value;
// // // // // // //             selectedShift = null;
// // // // // // //             state.model.selectForAttendance = null;
// // // // // // //             state.model.shift = null;
// // // // // // //           });
// // // // // // //           log('---onChange-region-----');
// // // // // // //
// // // // // // //           BlocProvider.of<AttendanceShiftsCubit>(context)
// // // // // // //               .getShifts(rank: value!);
// // // // // // //         },
// // // // // // //       ),
// // // // // // //       CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // // // //
// // // // // // //       /// Select For Shift Dropdown
// // // // // // //       CommonWidgets.textDisplay(
// // // // // // //         state.labels?.locale.rank ??
// // // // // // //             state.labels?.defaultLocale.rank ??
// // // // // // //             Constants.selectForShift,
// // // // // // //         Styles.textStyleWhite16,
// // // // // // //         isMandatory: true,
// // // // // // //       ),
// // // // // // //       DropdownWidget(
// // // // // // //         label: 'Select Shift',
// // // // // // //         items: state.shifts ?? [],
// // // // // // //         isInitial:
// // // // // // //         selectedRank != null && selectedShift == null ? true : false,
// // // // // // //         initialValue: selectedShift,
// // // // // // //         onChange: (Organisation? value) {
// // // // // // //           setState(() {
// // // // // // //             selectedShift = value;
// // // // // // //           });
// // // // // // //
// // // // // // //           BlocProvider.of<AttendanceShiftsCubit>(context)
// // // // // // //               .getAvailableSelectedGuardsByShift(
// // // // // // //             shift: value!,
// // // // // // //           );
// // // // // // //         },
// // // // // // //       ),
// // // // // // //       CommonWidgets.verticalSpacerWidget(
// // // // // // //           MediaQuery.of(context).size.height * 0.02),
// // // // // // //       buildTextWithLabel(
// // // // // // //           'Attendance Status:',
// // // // // // //           Utils().buildAttendanceShiftStatusRow(
// // // // // // //               status: state.model.attdStatus ?? 0, returnTextOnly: true)),
// // // // // // //       CommonWidgets.verticalSpacerWidget(
// // // // // // //           MediaQuery.of(context).size.height * 0.01),
// // // // // // //
// // // // // // //       /// Planned / Present row
// // // // // // //       buildPlannedPresentRow(
// // // // // // //         planned: state.model.allowed ?? 0,
// // // // // // //         present: state.model.attended?.length ?? 0,
// // // // // // //       ),
// // // // // // //       CommonWidgets.verticalSpacerWidget(
// // // // // // //           MediaQuery.of(context).size.height * 0.01),
// // // // // // //
// // // // // // //       OpacityAbsorbInkWellWidget(
// // // // // // //         absorbing: false,
// // // // // // //         child: Column(
// // // // // // //           children: [
// // // // // // //             Row(
// // // // // // //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // // // //               children: [
// // // // // // //                 Opacity(
// // // // // // //                   opacity: state.model.attdStatus != 1 ? 0.5 : 1.0,
// // // // // // //                   child: AbsorbPointer(
// // // // // // //                     absorbing: state.model.attdStatus != 1,
// // // // // // //                     child: buildShiftColumn(
// // // // // // //                       shift: state.model,
// // // // // // //                       guards: state.model.attended ?? {},
// // // // // // //                       destinationList: state.model.attended ?? {},
// // // // // // //                       isSourceList: false,
// // // // // // //                       label: 'Attended Marking\n',
// // // // // // //                       // Only the attended list gets a remove (✕) button.
// // // // // // //                       showRemoveButton: true,
// // // // // // //                     ),
// // // // // // //                   ),
// // // // // // //                 ),
// // // // // // //               ],
// // // // // // //             ),
// // // // // // //             CommonWidgets.verticalSpacerWidget(
// // // // // // //                 MediaQuery.of(context).size.height * 0.01),
// // // // // // //             AbsorbPointer(
// // // // // // //               absorbing: state.model.activeShift == false,
// // // // // // //               child: buildReplacementColumn(state),
// // // // // // //             ),
// // // // // // //             CommonWidgets.verticalSpacerWidget(
// // // // // // //                 MediaQuery.of(context).size.height * 0.01),
// // // // // // //             AbsorbPointer(
// // // // // // //               absorbing: state.model.activeShift == false,
// // // // // // //               child: buildSlaListColumn(
// // // // // // //                 state: state,
// // // // // // //                 shift: state.model,
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //             CommonWidgets.verticalSpacerWidget(
// // // // // // //                 MediaQuery.of(context).size.height * 0.02),
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     ];
// // // // // // //   }
// // // // // // //
// // // // // // //   /// Builds a single row that displays "Planned: X   Present: Y"
// // // // // // //   /// planned  -> comes from `allowed` in the JSON model
// // // // // // //   /// present  -> comes from the length of the `attended` set in the JSON model
// // // // // // //   Widget buildPlannedPresentRow({
// // // // // // //     required int planned,
// // // // // // //     required int present,
// // // // // // //   }) {
// // // // // // //     return Row(
// // // // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //       children: [
// // // // // // //         buildTextWithLabel('Planned:', '$planned'),
// // // // // // //         const SizedBox(width: 20),
// // // // // // //         buildTextWithLabel('Present:', '$present'),
// // // // // // //       ],
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   Widget buildArrowButton({
// // // // // // //     required AttendanceShiftsState state,
// // // // // // //     required IconData icon,
// // // // // // //     required Set<BaseUser> destinationList,
// // // // // // //     required bool isRemove,
// // // // // // //   }) {
// // // // // // //     return IconButton(
// // // // // // //       iconSize: 30,
// // // // // // //       color: Colors.white,
// // // // // // //       onPressed: () {
// // // // // // //         if (selectedGuard == null ||
// // // // // // //             destinationList.contains(selectedGuard)) {
// // // // // // //           return;
// // // // // // //         }
// // // // // // //         final cubit = BlocProvider.of<AttendanceShiftsCubit>(context);
// // // // // // //         if (isRemove) {
// // // // // // //           cubit.unmarkGuardAttended(selectedGuard!);
// // // // // // //         } else {
// // // // // // //           cubit.markGuardAttended(selectedGuard!);
// // // // // // //         }
// // // // // // //       },
// // // // // // //       icon: Icon(icon),
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   BaseUser? selectedGuard;
// // // // // // //
// // // // // // //   Widget buildShiftColumn({
// // // // // // //     required ShiftModel shift,
// // // // // // //     required Set<BaseUser> guards,
// // // // // // //     required bool isSourceList,
// // // // // // //     required String label,
// // // // // // //     required Set<BaseUser> destinationList,
// // // // // // //     bool showRemoveButton = false,
// // // // // // //   }) {
// // // // // // //     return Column(
// // // // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //       mainAxisSize: MainAxisSize.min,
// // // // // // //       children: [
// // // // // // //         CommonWidgets.textDisplay(
// // // // // // //           label,
// // // // // // //           isMandatory: false,
// // // // // // //           Styles.textStyleWhite17,
// // // // // // //         ),
// // // // // // //         AbsorbPointer(
// // // // // // //           absorbing: false,
// // // // // // //           child: buildUserList(
// // // // // // //             availableGuards: guards,
// // // // // // //             showRemoveButton: showRemoveButton,
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //       ],
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   Column buildSlaListColumn({
// // // // // // //     required AttendanceShiftsState state,
// // // // // // //     required ShiftModel shift,
// // // // // // //   }) {
// // // // // // //     List<SLAViolationPenaltyModel> slaList = [];
// // // // // // //
// // // // // // //     log('----state.shiftSlaList--${state.shiftSlaList?.length}-');
// // // // // // //
// // // // // // //     if (!state.shiftSlaList.isEmptyOrNull) {
// // // // // // //       SlaList? sla = state.shiftSlaList?.firstWhere(
// // // // // // //             (element) => element.attInfoId == shift.attendanceShiftId,
// // // // // // //         orElse: () => SlaList(),
// // // // // // //       );
// // // // // // //
// // // // // // //       slaList = sla?.items ?? [];
// // // // // // //     }
// // // // // // //     slaList = state.shiftSlaList?.first.items ?? [];
// // // // // // //
// // // // // // //     return Column(
// // // // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //       children: [
// // // // // // //         InkWell(
// // // // // // //           onTap: () {
// // // // // // //             if (!isReadOnly) {
// // // // // // //               Navigator.pushNamed(
// // // // // // //                 context,
// // // // // // //                 slaViolationPenaltyDetailsRoute,
// // // // // // //                 arguments: {
// // // // // // //                   ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
// // // // // // //                   ConstantsArgument.attdInfoId: state.model.attendanceShiftId,
// // // // // // //                   ConstantsArgument.location: widget.location,
// // // // // // //                   ConstantsArgument.locationRegion: widget.locationRegion,
// // // // // // //                 },
// // // // // // //               ).then((_) =>
// // // // // // //                   BlocProvider.of<AttendanceShiftsCubit>(context)
// // // // // // //                       .submitAndRefreshScreen(
// // // // // // //                       isRemove: false, isSubmit: false, isSaveOnly: true));
// // // // // // //             }
// // // // // // //           },
// // // // // // //           child: Row(
// // // // // // //             children: <Widget>[
// // // // // // //               const SizedBox(width: 14),
// // // // // // //               SvgPicture.asset(
// // // // // // //                 AppIcon.plusCircle,
// // // // // // //                 colorFilter: const ColorFilter.mode(
// // // // // // //                   AppColors.white,
// // // // // // //                   BlendMode.srcIn,
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //               const SizedBox(width: 10),
// // // // // // //               const Text(
// // // // // // //                 'Add SLA Violation',
// // // // // // //                 style: TextStyle(
// // // // // // //                   color: AppColors.white,
// // // // // // //                   decoration: TextDecoration.underline,
// // // // // // //                   decorationColor: AppColors.white,
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //               CommonWidgets.verticalSpacerWidget(
// // // // // // //                   MediaQuery.of(context).size.height * 0.08),
// // // // // // //             ],
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //         if (!slaList.isEmptyOrNull) ...[
// // // // // // //           SizedBox(
// // // // // // //             height: MediaQuery.of(context).size.height * 0.094,
// // // // // // //             child: ListView.builder(
// // // // // // //               scrollDirection: Axis.horizontal,
// // // // // // //               itemCount: slaList.length,
// // // // // // //               itemBuilder: (context, index) {
// // // // // // //                 return buildSlaCard(slaList[index]);
// // // // // // //               },
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //           CommonWidgets.verticalSpacerWidget(
// // // // // // //               MediaQuery.of(context).size.height * 0.02),
// // // // // // //         ],
// // // // // // //       ],
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   Widget buildSlaCard(SLAViolationPenaltyModel models) {
// // // // // // //     return InkWell(
// // // // // // //       onTap: () async {
// // // // // // //         var nav = Navigator.of(context);
// // // // // // //         SLAViolationPenaltyModel model =
// // // // // // //         await SLAViolationPenaltyServices().getGvpById(models.id ?? 0);
// // // // // // //         nav.pushNamed(
// // // // // // //           slaViolationPenaltyDetailsRoute,
// // // // // // //           arguments: {
// // // // // // //             "model": model,
// // // // // // //             "title": Constants.slaViolationPenaltyTitle,
// // // // // // //           },
// // // // // // //         );
// // // // // // //       },
// // // // // // //       child: IntrinsicHeight(
// // // // // // //         child: Card(
// // // // // // //           elevation: 0,
// // // // // // //           color: Colors.transparent,
// // // // // // //           shape: RoundedRectangleBorder(
// // // // // // //             borderRadius: BorderRadius.circular(12),
// // // // // // //             side: const BorderSide(
// // // // // // //               color: Colors.white,
// // // // // // //               width: 0.5,
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //           child: Padding(
// // // // // // //             padding: const EdgeInsets.all(5.0),
// // // // // // //             child: Column(
// // // // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //               children: [
// // // // // // //                 buildTextWithLabel('Id:', models.id.toString()),
// // // // // // //                 buildTextWithLabel('Region:', models.locationRegion?.name),
// // // // // // //                 buildTextWithLabel('Location:', models.location?.name),
// // // // // // //                 buildTextWithLabel('Created By:', models.entrySecurity?.name),
// // // // // // //               ],
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   int? _resolveRankId(AttendanceShiftsState state) =>
// // // // // // //       state.selectedRank?.id ?? selectedRank?.id;
// // // // // // //
// // // // // // //   int? _resolveShiftId(AttendanceShiftsState state) =>
// // // // // // //       state.selectedShift?.id ?? selectedShift?.id;
// // // // // // //
// // // // // // //   int _resolveDutyPostId(BuildContext context) =>
// // // // // // //       BlocProvider.of<AttendanceShiftsCubit>(context).selectedDutyPostNameId;
// // // // // // //
// // // // // // //   int _resolveAttendanceId() => widget.attInfoId;
// // // // // // //
// // // // // // //   Column buildReplacementColumn(AttendanceShiftsState state) {
// // // // // // //     return Column(
// // // // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //       children: [
// // // // // // //         GestureDetector(
// // // // // // //           onTap: () {
// // // // // // //             if (!isReadOnly) {
// // // // // // //               final rankId = _resolveRankId(state);
// // // // // // //               final shiftId = _resolveShiftId(state);
// // // // // // //
// // // // // // //               if (rankId == null || shiftId == null) {
// // // // // // //                 Validator().showToast(
// // // // // // //                   context,
// // // // // // //                   'Please select Rank and Shift before adding a replacement',
// // // // // // //                 );
// // // // // // //                 return;
// // // // // // //               }
// // // // // // //
// // // // // // //               showReplacementPopUp(
// // // // // // //                 context: context,
// // // // // // //                 model: Replacement(),
// // // // // // //                 selectedGuards: state.model.selectForReplacements ?? {},
// // // // // // //                 state: state,
// // // // // // //                 rankId: rankId,
// // // // // // //                 shiftId: shiftId,
// // // // // // //                 dutyPostId: _resolveDutyPostId(context),
// // // // // // //                 attendanceId: _resolveAttendanceId(),
// // // // // // //               );
// // // // // // //             }},
// // // // // // //           child: Row(
// // // // // // //             children: <Widget>[
// // // // // // //               const SizedBox(width: 14),
// // // // // // //               SvgPicture.asset(
// // // // // // //                 AppIcon.plusCircle,
// // // // // // //                 colorFilter: const ColorFilter.mode(
// // // // // // //                   AppColors.white,
// // // // // // //                   BlendMode.srcIn,
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //               const SizedBox(width: 10),
// // // // // // //               const Text(
// // // // // // //                 Constants.addReplacement,
// // // // // // //                 style: TextStyle(
// // // // // // //                   color: AppColors.white,
// // // // // // //                   decoration: TextDecoration.underline,
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //               CommonWidgets.verticalSpacerWidget(
// // // // // // //                   MediaQuery.of(context).size.height * 0.08),
// // // // // // //             ],
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //         if (_activeReplacements(state).isNotEmpty) ...[
// // // // // // //           Padding(
// // // // // // //             padding: const EdgeInsets.all(8.0),
// // // // // // //             child: Column(
// // // // // // //               children: buildReplacements(state),
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //           CommonWidgets.verticalSpacerWidget(
// // // // // // //               MediaQuery.of(context).size.height * 0.01),
// // // // // // //         ],
// // // // // // //       ],
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   List<Replacement> _activeReplacements(AttendanceShiftsState state) {
// // // // // // //     return (state.model.replacements ?? {}).toList();
// // // // // // //   }
// // // // // // //
// // // // // // //   List<Widget> buildReplacements(AttendanceShiftsState state) {
// // // // // // //     log('selectForReplacements${state.model.selectForReplacements}');
// // // // // // //
// // // // // // //     List<Widget> rows = [];
// // // // // // //
// // // // // // //     rows.add(
// // // // // // //       Container(
// // // // // // //         decoration: BoxDecoration(
// // // // // // //           color: AppColors.newColor,
// // // // // // //           borderRadius: BorderRadius.circular(6),
// // // // // // //           border: Border.all(color: Colors.grey.shade300),
// // // // // // //         ),
// // // // // // //         child: Table(
// // // // // // //           border: TableBorder.symmetric(
// // // // // // //             inside: BorderSide(color: Colors.grey.shade300),
// // // // // // //           ),
// // // // // // //           columnWidths: const {
// // // // // // //             0: FlexColumnWidth(2),
// // // // // // //             1: FlexColumnWidth(2),
// // // // // // //             2: FlexColumnWidth(2),
// // // // // // //             3: FlexColumnWidth(2),
// // // // // // //             4: FlexColumnWidth(2),
// // // // // // //             5: FlexColumnWidth(2),
// // // // // // //             6: FlexColumnWidth(1),
// // // // // // //           },
// // // // // // //           children: [
// // // // // // //             TableRow(
// // // // // // //               children: [
// // // // // // //                 tableHeader("Replacement For"),
// // // // // // //                 tableHeader("From Date"),
// // // // // // //                 tableHeader("To Date"),
// // // // // // //                 tableHeader("Reason"),
// // // // // // //                 tableHeader("Replacement By"),
// // // // // // //                 tableHeader("Replacement Type"),
// // // // // // //                 tableHeader(""),
// // // // // // //               ],
// // // // // // //             )
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //
// // // // // // //     for (Replacement replacement in _activeReplacements(state)) {
// // // // // // //       rows.add(
// // // // // // //         InkWell(
// // // // // // //           onTap: () {
// // // // // // //             final canEdit = (state.model.attdStatus == 1 &&
// // // // // // //                 replacement.statusActive == true) ||
// // // // // // //                 (state.model.attdStatus == 2 &&
// // // // // // //                     replacement.statusActive == true);
// // // // // // //             if (!canEdit) return;
// // // // // // //
// // // // // // //             final rankId = _resolveRankId(state);
// // // // // // //             final shiftId = _resolveShiftId(state);
// // // // // // //
// // // // // // //             if (rankId == null || shiftId == null) {
// // // // // // //               Validator().showToast(
// // // // // // //                 context,
// // // // // // //                 'Please select Rank and Shift before editing a replacement',
// // // // // // //               );
// // // // // // //               return;
// // // // // // //             }
// // // // // // //
// // // // // // //             showReplacementPopUp(
// // // // // // //               context: context,
// // // // // // //               model: replacement,
// // // // // // //               selectedGuards: state.model.selectForReplacements ?? {},
// // // // // // //               state: state,
// // // // // // //               rankId: rankId,
// // // // // // //               shiftId: shiftId,
// // // // // // //               dutyPostId: _resolveDutyPostId(context),
// // // // // // //               attendanceId: _resolveAttendanceId(),
// // // // // // //             );
// // // // // // //           },
// // // // // // //           child: Container(
// // // // // // //             decoration: BoxDecoration(
// // // // // // //               color: Colors.transparent,
// // // // // // //               borderRadius: BorderRadius.circular(6),
// // // // // // //               border: Border.all(color: Colors.grey.shade300),
// // // // // // //             ),
// // // // // // //             child: Table(
// // // // // // //               border: TableBorder.symmetric(
// // // // // // //                 inside: BorderSide(color: Colors.grey.shade300),
// // // // // // //               ),
// // // // // // //               columnWidths: const {
// // // // // // //                 0: FlexColumnWidth(2),
// // // // // // //                 1: FlexColumnWidth(2),
// // // // // // //                 2: FlexColumnWidth(2),
// // // // // // //                 3: FlexColumnWidth(2),
// // // // // // //                 4: FlexColumnWidth(2),
// // // // // // //                 5: FlexColumnWidth(2),
// // // // // // //                 6: FlexColumnWidth(1),
// // // // // // //               },
// // // // // // //               children: [
// // // // // // //                 TableRow(
// // // // // // //                   children: [
// // // // // // //                     tableCell(replacement.replacedFor?.name ?? ""),
// // // // // // //                     tableCell(
// // // // // // //                       replacement.fromDate != null
// // // // // // //                           ? Utils.timestampToDateConversion(
// // // // // // //                         int.tryParse(replacement.fromDate ?? '0') ?? 0,
// // // // // // //                         Constants.dateFormat,
// // // // // // //                       )
// // // // // // //                           : '',
// // // // // // //                     ),
// // // // // // //                     tableCell(
// // // // // // //                       replacement.toDate != null
// // // // // // //                           ? Utils.timestampToDateConversion(
// // // // // // //                         int.tryParse(replacement.toDate ?? '0') ?? 0,
// // // // // // //                         Constants.dateFormat,
// // // // // // //                       )
// // // // // // //                           : '',
// // // // // // //                     ),
// // // // // // //                     tableCell(
// // // // // // //                       (Utils().getKeyFromValue(
// // // // // // //                         value: replacement.status!,
// // // // // // //                         dropdownValues: shiftScheduleReasonDropDownValues,
// // // // // // //                       ) ??
// // // // // // //                           ''),
// // // // // // //                     ),
// // // // // // //                     tableCell(replacement.replacementBy?.name ?? ""),
// // // // // // //                     tableCell(
// // // // // // //                       (Utils().getKeyFromValue(
// // // // // // //                         value: replacement.status!,
// // // // // // //                         dropdownValues: replacementTypeDropDownValues,
// // // // // // //                       ) ??
// // // // // // //                           ''),
// // // // // // //                     ),
// // // // // // //                     Center(
// // // // // // //                       child: state.model.attdStatus != 2
// // // // // // //                           ? IconButton(
// // // // // // //                         icon: const Icon(
// // // // // // //                           Icons.close,
// // // // // // //                           size: 18,
// // // // // // //                           color: Colors.white,
// // // // // // //                         ),
// // // // // // //                         onPressed: () {
// // // // // // //                           BlocProvider.of<AttendanceShiftsCubit>(
// // // // // // //                               context)
// // // // // // //                               .removeReplacement(
// // // // // // //                             replacement,
// // // // // // //                             context: context,
// // // // // // //                           );
// // // // // // //                         },
// // // // // // //                       )
// // // // // // //                           : const SizedBox.shrink(),
// // // // // // //                     )
// // // // // // //                   ],
// // // // // // //                 ),
// // // // // // //               ],
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //       );
// // // // // // //     }
// // // // // // //
// // // // // // //     return rows;
// // // // // // //   }
// // // // // // //
// // // // // // //   Widget tableHeader(String label) {
// // // // // // //     return Padding(
// // // // // // //       padding: const EdgeInsets.all(8.0),
// // // // // // //       child: Text(
// // // // // // //         label,
// // // // // // //         style: const TextStyle(
// // // // // // //           fontWeight: FontWeight.bold,
// // // // // // //           fontSize: 8,
// // // // // // //           color: Colors.white,
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   Widget tableCell(String value) {
// // // // // // //     return Padding(
// // // // // // //       padding: const EdgeInsets.all(8.0),
// // // // // // //       child: Text(
// // // // // // //         value,
// // // // // // //         style: const TextStyle(
// // // // // // //           fontSize: 8,
// // // // // // //           color: Colors.white,
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   Widget buildTextWithLabel(String label, String? value) {
// // // // // // //     return RichText(
// // // // // // //       text: TextSpan(
// // // // // // //         children: [
// // // // // // //           TextSpan(
// // // // // // //             text: '$label ',
// // // // // // //             style: const TextStyle(
// // // // // // //               fontSize: 14,
// // // // // // //               fontWeight: FontWeight.bold,
// // // // // // //               color: Colors.white,
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //           TextSpan(
// // // // // // //             text: value,
// // // // // // //             style: const TextStyle(
// // // // // // //               color: AppColors.white,
// // // // // // //               fontSize: 14,
// // // // // // //               fontWeight: FontWeight.bold,
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //         ],
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   void handleUserTap(BaseUser element) {
// // // // // // //     log('---handleUserTap---');
// // // // // // //     setState(() {
// // // // // // //       selectedGuard = element;
// // // // // // //     });
// // // // // // //   }
// // // // // // //
// // // // // // //   void removeAttendedGuard(BaseUser element) {
// // // // // // //     log('---removeAttendedGuard---${element.name}');
// // // // // // //     final cubit = BlocProvider.of<AttendanceShiftsCubit>(context);
// // // // // // //     cubit.unmarkGuardAttended(element);
// // // // // // //
// // // // // // //     if (selectedGuard == element) {
// // // // // // //       setState(() {
// // // // // // //         selectedGuard = null;
// // // // // // //       });
// // // // // // //     }
// // // // // // //   }
// // // // // // //
// // // // // // //   Widget buildUserList({
// // // // // // //     required Set<BaseUser> availableGuards,
// // // // // // //     bool showRemoveButton = false,
// // // // // // //   }) {
// // // // // // //     double width = MediaQuery.of(context).size.width;
// // // // // // //     double columnWidth;
// // // // // // //     if (width > Constants.tabletScreenWidth) {
// // // // // // //       columnWidth = width / 2.6;
// // // // // // //     } else {
// // // // // // //       columnWidth = width / 1.2;
// // // // // // //     }
// // // // // // //     return Container(
// // // // // // //       decoration: BoxDecoration(
// // // // // // //         gradient: LinearGradient(
// // // // // // //           colors: [
// // // // // // //             Colors.white.withValues(alpha: 0.09),
// // // // // // //             Colors.transparent,
// // // // // // //             Colors.white.withValues(alpha: 0.09),
// // // // // // //           ],
// // // // // // //           stops: const [0.02, 0.35, 1],
// // // // // // //           begin: Alignment.topCenter,
// // // // // // //           end: Alignment.bottomCenter,
// // // // // // //         ),
// // // // // // //         borderRadius: BorderRadius.circular(27),
// // // // // // //         border: Border.all(
// // // // // // //           color: Colors.white.withValues(alpha: 1),
// // // // // // //           width: 0.7,
// // // // // // //         ),
// // // // // // //         boxShadow: [
// // // // // // //           BoxShadow(
// // // // // // //             color: Colors.white.withValues(alpha: 0.0),
// // // // // // //             blurRadius: 12,
// // // // // // //             offset: const Offset(0, 2),
// // // // // // //           ),
// // // // // // //         ],
// // // // // // //       ),
// // // // // // //       height: MediaQuery.of(context).size.height / 8.5,
// // // // // // //       width: columnWidth,
// // // // // // //       child: ListView.builder(
// // // // // // //         itemCount: availableGuards.length,
// // // // // // //         shrinkWrap: true,
// // // // // // //         itemBuilder: (context, index) {
// // // // // // //           final element = availableGuards.toList()[index];
// // // // // // //           final bool isSelected = selectedGuard == element;
// // // // // // //
// // // // // // //           return GestureDetector(
// // // // // // //             onTap: () => handleUserTap(element),
// // // // // // //             child: Card(
// // // // // // //               color: isSelected ? AppColors.navigationSkyBlueColor : AppColors.navigationSkyBlueColor,
// // // // // // //               child: Padding(
// // // // // // //                 padding: const EdgeInsets.symmetric(
// // // // // // //                   horizontal: 8.0,
// // // // // // //                   vertical: 4.0,
// // // // // // //                 ),
// // // // // // //                 child: Row(
// // // // // // //                   children: [
// // // // // // //                     Expanded(
// // // // // // //                       child: Tooltip(
// // // // // // //                         preferBelow: false,
// // // // // // //                         message: isSelected ? element.name ?? '' : '',
// // // // // // //                         child: Text(
// // // // // // //                           element.name ?? '',
// // // // // // //                           style: TextStyle(
// // // // // // //                             fontSize: 15,
// // // // // // //                             color: isSelected
// // // // // // //                                 ? AppColors.white
// // // // // // //                                 : AppColors.white,
// // // // // // //                           ),
// // // // // // //                           overflow: TextOverflow.ellipsis,
// // // // // // //                         ),
// // // // // // //                       ),
// // // // // // //                     ),
// // // // // // //                     if (showRemoveButton)
// // // // // // //                       IconButton(
// // // // // // //                         icon: Icon(
// // // // // // //                           Icons.close,
// // // // // // //                           size: 18,
// // // // // // //                           color: isSelected
// // // // // // //                               ? AppColors.white
// // // // // // //                               : AppColors.white,
// // // // // // //                         ),
// // // // // // //                         tooltip: 'Remove',
// // // // // // //                         splashRadius: 18,
// // // // // // //                         onPressed: () => removeAttendedGuard(element),
// // // // // // //                       ),
// // // // // // //                   ],
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //           );
// // // // // // //         },
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // //
// // // // // // //   Widget _buildGlassDialog({
// // // // // // //     required String title,
// // // // // // //     required String message,
// // // // // // //     required VoidCallback onCancel,
// // // // // // //     required Future<void> Function() onConfirm,
// // // // // // //   }) {
// // // // // // //     return Dialog(
// // // // // // //       backgroundColor: Colors.transparent,
// // // // // // //       insetPadding: const EdgeInsets.symmetric(horizontal: 24),
// // // // // // //       child: ClipRRect(
// // // // // // //         borderRadius: BorderRadius.circular(20),
// // // // // // //         child: BackdropFilter(
// // // // // // //           filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
// // // // // // //           child: Container(
// // // // // // //             padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
// // // // // // //             decoration: BoxDecoration(
// // // // // // //               gradient: LinearGradient(
// // // // // // //                 colors: [
// // // // // // //                   Colors.white.withValues(alpha: 0.02),
// // // // // // //                   Colors.white.withValues(alpha: 0.04),
// // // // // // //                 ],
// // // // // // //                 begin: Alignment.topLeft,
// // // // // // //                 end: Alignment.bottomRight,
// // // // // // //               ),
// // // // // // //               borderRadius: BorderRadius.circular(20),
// // // // // // //               border: Border.all(
// // // // // // //                 color: Colors.white.withValues(alpha: 0.55),
// // // // // // //                 width: 1,
// // // // // // //               ),
// // // // // // //               boxShadow: [
// // // // // // //                 BoxShadow(
// // // // // // //                   color: Colors.black.withValues(alpha: 0.04),
// // // // // // //                   blurRadius: 20,
// // // // // // //                   offset: const Offset(0, 8),
// // // // // // //                 ),
// // // // // // //               ],
// // // // // // //             ),
// // // // // // //             child: Column(
// // // // // // //               mainAxisSize: MainAxisSize.min,
// // // // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //               children: [
// // // // // // //                 Text(
// // // // // // //                   title,
// // // // // // //                   style: const TextStyle(
// // // // // // //                     color: Colors.white,
// // // // // // //                     fontSize: 17,
// // // // // // //                     fontWeight: FontWeight.w700,
// // // // // // //                   ),
// // // // // // //                 ),
// // // // // // //                 const SizedBox(height: 12),
// // // // // // //                 Text(
// // // // // // //                   message,
// // // // // // //                   style: TextStyle(
// // // // // // //                     color: Colors.white.withValues(alpha: 0.85),
// // // // // // //                     fontSize: 14,
// // // // // // //                     height: 1.4,
// // // // // // //                   ),
// // // // // // //                 ),
// // // // // // //                 const SizedBox(height: 20),
// // // // // // //                 Row(
// // // // // // //                   mainAxisAlignment: MainAxisAlignment.end,
// // // // // // //                   children: [
// // // // // // //                     TextButton(
// // // // // // //                       onPressed: onCancel,
// // // // // // //                       style: TextButton.styleFrom(
// // // // // // //                         foregroundColor: Colors.white.withValues(alpha: 0.8),
// // // // // // //                       ),
// // // // // // //                       child: const Text(Constants.cancel),
// // // // // // //                     ),
// // // // // // //                     const SizedBox(width: 8),
// // // // // // //                     TextButton(
// // // // // // //                       onPressed: onConfirm,
// // // // // // //                       style: TextButton.styleFrom(
// // // // // // //                         foregroundColor: Colors.white,
// // // // // // //                         backgroundColor: Colors.white.withValues(alpha: 0.12),
// // // // // // //                         shape: RoundedRectangleBorder(
// // // // // // //                           borderRadius: BorderRadius.circular(10),
// // // // // // //                         ),
// // // // // // //                         padding: const EdgeInsets.symmetric(
// // // // // // //                           horizontal: 16,
// // // // // // //                           vertical: 10,
// // // // // // //                         ),
// // // // // // //                       ),
// // // // // // //                       child: const Text(Constants.ok),
// // // // // // //                     ),
// // // // // // //                   ],
// // // // // // //                 ),
// // // // // // //               ],
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // //   void showReplacementPopUp({
// // // // // // //     required BuildContext context,
// // // // // // //     required Replacement model,
// // // // // // //     required Set<BaseUser> selectedGuards,
// // // // // // //     required AttendanceShiftsState state,
// // // // // // //     required int rankId,
// // // // // // //     required int shiftId,
// // // // // // //     required int dutyPostId,
// // // // // // //     required int attendanceId,
// // // // // // //   }) {
// // // // // // //     showDialog(
// // // // // // //       context: context,
// // // // // // //       builder: (BuildContext dialogContext) {
// // // // // // //         return AddReplacementPopUp(
// // // // // // //           viaAttendance: true,
// // // // // // //           model: model,
// // // // // // //           mainContext: context,
// // // // // // //           selectedGuards: selectedGuards,
// // // // // // //           shiftModel: state.model,
// // // // // // //           shiftId: shiftId,
// // // // // // //           rankId: rankId,
// // // // // // //           dutyPostId: dutyPostId,
// // // // // // //           attendanceId: attendanceId,
// // // // // // //         );
// // // // // // //       },
// // // // // // //     );
// // // // // // //   }
// // // // // // // }
// // // // // //
// // // // // //
// // // // // // import 'dart:ui';
// // // // // //
// // // // // // import 'package:db_atom/index.dart';
// // // // // //
// // // // // // import '../../attendance_details/views/attendance_details_view.dart';
// // // // // // import '../../models/dutyPost_attendance_model.dart';
// // // // // //
// // // // // // class AttendanceShiftsView extends StatefulWidget {
// // // // // //   const AttendanceShiftsView({
// // // // // //     super.key,
// // // // // //     required this.location,
// // // // // //     required this.locationRegion,
// // // // // //     required this.vendor,
// // // // // //     required this.attInfoId,
// // // // // //     required this.selectedDutyPostModel,
// // // // // //     required this.isReadOnly,
// // // // // //     required this.isEligibleToEdit,
// // // // // //   });
// // // // // //
// // // // // //   final Organisation location;
// // // // // //   final Organisation locationRegion;
// // // // // //   final Organisation vendor;
// // // // // //   final int attInfoId;
// // // // // //   final DutyPostModel selectedDutyPostModel;
// // // // // //   final bool isReadOnly;
// // // // // //   final bool isEligibleToEdit;
// // // // // //
// // // // // //   @override
// // // // // //   AttendanceShiftsViewState createState() => AttendanceShiftsViewState();
// // // // // // }
// // // // // //
// // // // // // /// Minimal local-only stand-in for a shift-level replacement until the
// // // // // // /// real `Replacement` model / service is wired to this screen.
// // // // // // class _LocalReplacementDraft {
// // // // // //   _LocalReplacementDraft({required this.replacedFor, required this.reason});
// // // // // //
// // // // // //   final String replacedFor;
// // // // // //   final String reason;
// // // // // // }
// // // // // //
// // // // // // class ShiftSlaViolation {
// // // // // //   final String id;
// // // // // //   final String region;
// // // // // //   final String location;
// // // // // //   final String dateOfCreation;
// // // // // //   final String createdBy;
// // // // // //   final String asl;
// // // // // //   final String typeOfService;
// // // // // //   final String status;
// // // // // //
// // // // // //   ShiftSlaViolation({
// // // // // //     required this.id,
// // // // // //     required this.region,
// // // // // //     required this.location,
// // // // // //     required this.dateOfCreation,
// // // // // //     required this.createdBy,
// // // // // //     required this.asl,
// // // // // //     required this.typeOfService,
// // // // // //     required this.status,
// // // // // //   });
// // // // // // }
// // // // // //
// // // // // // Widget _readOnlyField({required String label, required String value}) {
// // // // // //   return Column(
// // // // // //     crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //     children: [
// // // // // //       Text(
// // // // // //         label,
// // // // // //         style: const TextStyle(
// // // // // //           color: Colors.black,
// // // // // //           fontSize: 11,
// // // // // //           fontWeight: FontWeight.w700,
// // // // // //           letterSpacing: 0.5,
// // // // // //         ),
// // // // // //       ),
// // // // // //       const SizedBox(height: 6),
// // // // // //       Container(
// // // // // //         width: double.infinity,
// // // // // //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
// // // // // //         decoration: BoxDecoration(
// // // // // //           color: Colors.white.withValues(alpha: 0.9),
// // // // // //           borderRadius: BorderRadius.circular(6),
// // // // // //           border: Border.all(color: const Color(0xFF3D6DB0)),
// // // // // //         ),
// // // // // //         child: Text(
// // // // // //           value,
// // // // // //           style: const TextStyle(color: Colors.black87),
// // // // // //         ),
// // // // // //       ),
// // // // // //     ],
// // // // // //   );
// // // // // // }
// // // // // //
// // // // // // class AttendanceShiftsViewState extends State<AttendanceShiftsView> {
// // // // // //   bool isReadOnly = false;
// // // // // //
// // // // // //   // Accordion expand/collapse state — duty posts & ranks start expanded;
// // // // // //   // a key only ever lands in these sets once the user *collapses* it.
// // // // // //   final Set<String> _collapsedDutyPostKeys = {};
// // // // // //   final Set<String> _collapsedRankKeys = {};
// // // // // //
// // // // // //   // Tracks which guard ids were added to a shift's attendance *in this
// // // // // //   // session*, so only those rows show a "Remove" button — guards already
// // // // // //   // attended before the screen opened stay locked. Keyed by `_shiftKey`.
// // // // // //   final Map<String, Set<int>> _newlyAddedGuardIdsByShift = {};
// // // // // //
// // // // // //   // Local-only placeholder — see TODO at the top of this file.
// // // // // //   final Map<String, List<_LocalReplacementDraft>> _replacementsByShift = {};
// // // // // //
// // // // // //   // ---------------------------------------------------------------
// // // // // //   // Tracks whether the LAST submitForm(...) call we made was a
// // // // // //   // save-only call (isSaveOnly: true) — mirrors the same flag in
// // // // // //   // AdditionalDeploymentsView. The BlocConsumer listener below shows a
// // // // // //   // generic "Attendance" success dialog whenever state.status ==
// // // // // //   // FormStatus.success, but that dialog should only appear for the real
// // // // // //   // Submit action, not for the background auto-save that now runs
// // // // // //   // before opening the SLA Violation screen.
// // // // // //   // ---------------------------------------------------------------
// // // // // //   bool _lastSubmitWasSaveOnly = false;
// // // // // //
// // // // // //   // Card accent palette cycled per shift position within a rank, matching
// // // // // //   // the orange / blue / red / green top borders in the reference design.
// // // // // //   static const List<Color> _shiftAccentColors = [
// // // // // //     Color(0xFFF5A623), // orange
// // // // // //     Color(0xFF3D6DB0), // blue
// // // // // //     Color(0xFFD64545), // red
// // // // // //     Color(0xFF3FB65D), // green
// // // // // //   ];
// // // // // //
// // // // // //   final Set<String> _collapsedSlaIds = {};
// // // // // //
// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// // // // // //   }
// // // // // //
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     final size = MediaQuery.of(context).size;
// // // // // //     final height = size.height;
// // // // // //
// // // // // //     return BlocConsumer<AttendanceShiftsCubit, AttendanceShiftsState>(
// // // // // //       listener: (context, state) {
// // // // // //         Utils().formError(state, context);
// // // // // //         Utils().errorAndLogout(state, context);
// // // // // //
// // // // // //         if (state.status == FormStatus.success) {
// // // // // //           var dialog = CustomAlertDialog(
// // // // // //             title: 'Attendance',
// // // // // //             message: state.message ?? '',
// // // // // //             positiveBtnText: Constants.ok,
// // // // // //             onPositivePressed: () {
// // // // // //               Navigator.pop(context);
// // // // // //               Navigator.pop(context);
// // // // // //               Navigator.popAndPushNamed(
// // // // // //                 context,
// // // // // //                 attendanceListRoute,
// // // // // //                 arguments: {},
// // // // // //               );
// // // // // //             },
// // // // // //           );
// // // // // //           showDialog(
// // // // // //               context: context,
// // // // // //               barrierDismissible: false,
// // // // // //               builder: (BuildContext context) => dialog);
// // // // // //
// // // // // //           // Utils.dynamicAlert(
// // // // // //           //     context, state.message ?? '', 'Material Movement', '');
// // // // // //         }
// // // // // //       },
// // // // // //       builder: (context, state) {
// // // // // //         isReadOnly = widget.isReadOnly ||
// // // // // //             !widget.isEligibleToEdit ||
// // // // // //             !state.model.lock.isEmptyOrNull;
// // // // // //
// // // // // //         return Scaffold(
// // // // // //           backgroundColor: Colors.transparent,
// // // // // //           extendBodyBehindAppBar: true,
// // // // // //           appBar: BaseAppBar().buildAppHeader(
// // // // // //             context: context,
// // // // // //             title: 'Attendance',
// // // // // //             showPopUp: false,
// // // // // //             showSaveButton: false,
// // // // // //             showSubmitButton: !isReadOnly && state.status != FormStatus.loading,
// // // // // //             showDisLikeButton: false,
// // // // // //             showLikeButton: false,
// // // // // //             popAndReplace: () {
// // // // // //               int flag = AttendanceDetailsView.flag;
// // // // // //               if (flag == 1) {
// // // // // //                 Navigator.pop(context);
// // // // // //               } else {
// // // // // //                 Navigator.pop(context);
// // // // // //                 // Navigator.pop(context);
// // // // // //                 // Navigator.pop(context);
// // // // // //               }
// // // // // //             },
// // // // // //             onTapSubmit: () {
// // // // // //               FocusScope.of(context).unfocus();
// // // // // //               BlocProvider.of<AttendanceShiftsCubit>(context)
// // // // // //                   .submitForm(isSaveOnly: false);
// // // // // //             },
// // // // // //           ),
// // // // // //
// // // // // //           // ================= BODY WITH BACKGROUND =================
// // // // // //           body: Stack(
// // // // // //             children: [
// // // // // //               Positioned.fill(
// // // // // //                 child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
// // // // // //               ),
// // // // // //               Positioned.fill(
// // // // // //                 child: BackdropFilter(
// // // // // //                   filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
// // // // // //                   child: Container(color: Colors.black.withValues(alpha: 0.15)),
// // // // // //                 ),
// // // // // //               ),
// // // // // //               Positioned.fill(
// // // // // //                 child: MediaQuery.removePadding(
// // // // // //                   context: context,
// // // // // //                   removeTop: true,
// // // // // //                   child: Padding(
// // // // // //                     padding: const EdgeInsets.all(20),
// // // // // //                     child: SingleChildScrollView(
// // // // // //                       child: Column(
// // // // // //                         children: [
// // // // // //                           SizedBox(
// // // // // //                             height: kToolbarHeight +
// // // // // //                                 MediaQuery.of(context).padding.top,
// // // // // //                           ),
// // // // // //                           getBody(state, height),
// // // // // //                         ],
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         );
// // // // // //       },
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   // BODY
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   Widget getBody(AttendanceShiftsState state, double height) {
// // // // // //     if (state.status == FormStatus.loading) {
// // // // // //       return const BaseLoader();
// // // // // //     }
// // // // // //
// // // // // //     final dutyPosts = state.dutyPostAttendanceModel?.dutyPosts ?? const <DutyPosts>[];
// // // // // //
// // // // // //     return Column(
// // // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //       children: [
// // // // // //         if (!state.model.lock.isEmptyOrNull) ...[
// // // // // //           RecordLockedWidget(text: '${state.model.lock}'),
// // // // // //           CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // // //         ],
// // // // // //         if (dutyPosts.isEmpty)
// // // // // //           const Padding(
// // // // // //             padding: EdgeInsets.symmetric(vertical: 24),
// // // // // //             child: Text(
// // // // // //               'No duty posts found for this attendance record.',
// // // // // //               style: Styles.textStyleWhite16,
// // // // // //             ),
// // // // // //           )
// // // // // //         else
// // // // // //           for (final dutyPost in dutyPosts) ...[
// // // // // //             _buildDutyPostAccordion(dutyPost, height, state),
// // // // // //             CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // // //           ],
// // // // // //       ],
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   // DUTY POST ACCORDION  (e.g. "Basement")
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   Widget _buildDutyPostAccordion(
// // // // // //       DutyPosts dutyPost, double height, AttendanceShiftsState state) {
// // // // // //     final key = 'dutypost_${dutyPost.dutyPostNameId}_${dutyPost.dutyPostName}';
// // // // // //     final isExpanded = !_collapsedDutyPostKeys.contains(key);
// // // // // //     final label = dutyPost.dutyPostName ?? '-';
// // // // // //
// // // // // //     return Container(
// // // // // //       width: double.infinity,
// // // // // //       decoration: BoxDecoration(
// // // // // //         border: Border.all(color: const Color(0xFF5B4FCF)),
// // // // // //         borderRadius: BorderRadius.circular(8),
// // // // // //         color: Colors.white.withValues(alpha: 0.04),
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           _accordionHeader(
// // // // // //             avatarText: label.isNotEmpty ? label[0].toUpperCase() : '?',
// // // // // //             title: label,
// // // // // //             isExpanded: isExpanded,
// // // // // //             onTap: () => setState(() {
// // // // // //               if (isExpanded) {
// // // // // //                 _collapsedDutyPostKeys.add(key);
// // // // // //               } else {
// // // // // //                 _collapsedDutyPostKeys.remove(key);
// // // // // //               }
// // // // // //             }),
// // // // // //           ),
// // // // // //           if (isExpanded)
// // // // // //             Padding(
// // // // // //               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
// // // // // //               child: Column(
// // // // // //                 children: [
// // // // // //                   for (final rank in dutyPost.ranks ?? const <Ranks>[]) ...[
// // // // // //                     _buildRankAccordion(rank, height, state),
// // // // // //                     const SizedBox(height: 10),
// // // // // //                   ],
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   // RANK ACCORDION  (e.g. "RANK: SECURITY GUARD/LADY SECURITY GUARD")
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   Widget _buildRankAccordion(
// // // // // //       Ranks rank, double height, AttendanceShiftsState state) {
// // // // // //     final key = 'rank_${rank.rankId}_${rank.rankName}';
// // // // // //     final isExpanded = !_collapsedRankKeys.contains(key);
// // // // // //     final title = 'RANK: ${(rank.rankName ?? '-').toUpperCase()}';
// // // // // //
// // // // // //     return Container(
// // // // // //       width: double.infinity,
// // // // // //       decoration: BoxDecoration(
// // // // // //         border: Border.all(color: const Color(0xFF5B4FCF)),
// // // // // //         borderRadius: BorderRadius.circular(8),
// // // // // //         color: Colors.white.withValues(alpha: 0.01),
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           _accordionHeader(
// // // // // //             avatarText: _initialsFor(rank.rankName ?? ''),
// // // // // //             title: title,
// // // // // //             isExpanded: isExpanded,
// // // // // //             onTap: () => setState(() {
// // // // // //               if (isExpanded) {
// // // // // //                 _collapsedRankKeys.add(key);
// // // // // //               } else {
// // // // // //                 _collapsedRankKeys.remove(key);
// // // // // //               }
// // // // // //             }),
// // // // // //           ),
// // // // // //           if (isExpanded)
// // // // // //             Padding(
// // // // // //               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
// // // // // //               child: _buildShiftCardsGrid(
// // // // // //                   rank.shifts ?? const <Shifts>[], height, state),
// // // // // //             ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   String _initialsFor(String label) {
// // // // // //     final words = label.trim().split(RegExp(r'\s+'));
// // // // // //     if (words.isEmpty || words.first.isEmpty) return '?';
// // // // // //     return words
// // // // // //         .take(2)
// // // // // //         .map((w) => w.isNotEmpty ? w[0] : '')
// // // // // //         .join()
// // // // // //         .toUpperCase();
// // // // // //   }
// // // // // //
// // // // // //   Widget _accordionHeader({
// // // // // //     required String avatarText,
// // // // // //     required String title,
// // // // // //     required bool isExpanded,
// // // // // //     required VoidCallback onTap,
// // // // // //   }) {
// // // // // //     return InkWell(
// // // // // //       onTap: onTap,
// // // // // //       child: Container(
// // // // // //         width: double.infinity,
// // // // // //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// // // // // //         child: Row(
// // // // // //           children: [
// // // // // //             CircleAvatar(
// // // // // //               radius: 12,
// // // // // //               backgroundColor: Colors.white24,
// // // // // //               child: Text(
// // // // // //                 avatarText,
// // // // // //                 style: const TextStyle(color: Colors.white, fontSize: 10),
// // // // // //               ),
// // // // // //             ),
// // // // // //             const SizedBox(width: 8),
// // // // // //             Expanded(
// // // // // //               child: Text(
// // // // // //                 title,
// // // // // //                 style: const TextStyle(
// // // // // //                   color: Colors.white,
// // // // // //                   fontWeight: FontWeight.w700,
// // // // // //                   fontSize: 13,
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ),
// // // // // //             Icon(
// // // // // //               isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
// // // // // //               color: Colors.white70,
// // // // // //             ),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   // SHIFT CARDS GRID  (Shift A / B / C / G laid out 2-up, like the ref)
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   Widget _buildShiftCardsGrid(
// // // // // //       List<Shifts> shifts, double height, AttendanceShiftsState state) {
// // // // // //     if (shifts.isEmpty) {
// // // // // //       return const Padding(
// // // // // //         padding: EdgeInsets.symmetric(vertical: 12),
// // // // // //         child: Text(
// // // // // //           'No shifts under this rank.',
// // // // // //           style: Styles.textStyleWhite16,
// // // // // //         ),
// // // // // //       );
// // // // // //     }
// // // // // //
// // // // // //     final width = MediaQuery.of(context).size.width;
// // // // // //     final isTablet = width > Constants.tabletScreenWidth;
// // // // // //     // Two columns on tablet/desktop widths, single column on phones —
// // // // // //     // matches the 2-up grid in the reference screenshot.
// // // // // //     final cardWidth = isTablet ? (width - 60) / 2 : width - 40;
// // // // // //
// // // // // //     return Wrap(
// // // // // //       spacing: 12,
// // // // // //       runSpacing: 12,
// // // // // //       children: [
// // // // // //         for (var i = 0; i < shifts.length; i++)
// // // // // //           SizedBox(
// // // // // //             width: cardWidth,
// // // // // //             child: _buildShiftCard(shifts[i], i, height, state),
// // // // // //           ),
// // // // // //       ],
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   String _shiftKey(Shifts shift) =>
// // // // // //       'shift_${shift.attendanceShiftId ?? shift.shiftId}';
// // // // // //
// // // // // //   String _timeRangeForShift(String? shiftLabel) {
// // // // // //     final normalized = (shiftLabel ?? '').toLowerCase().trim();
// // // // // //     if (normalized == 'a') return '7AM - 3PM';
// // // // // //     if (normalized == 'b') return '3PM - 11PM';
// // // // // //     if (normalized == 'c') return '11PM - 7AM';
// // // // // //     if (normalized == 'g') return '9AM - 6PM';
// // // // // //     return '-';
// // // // // //   }
// // // // // //
// // // // // //   // -----------------------------------------------------------------
// // // // // //   // Turns the raw violation payload attached to a shift into display
// // // // // //   // model objects, mirroring the exact parsing logic used for
// // // // // //   // `adhoc.Deployments.violations` in AdditionalDeploymentsView so the
// // // // // //   // two screens show SLA data identically.
// // // // // //   //
// // // // // //   // CAVEAT — I don't have `dutyPost_attendance_model.dart`'s source, so
// // // // // //   // this assumes `Shifts` exposes a raw `violations` field (List<dynamic>?)
// // // // // //   // shaped the same way as `adhoc.Deployments.violations`: a list of Maps
// // // // // //   // with `location`, `locationRegion`, `entrySecurity`, `approver`,
// // // // // //   // `typeOfService`, `inputDate`, `statusLabel`, and `id`/`slNo` keys. If
// // // // // //   // the real field is named or shaped differently, share that model and
// // // // // //   // this method can be pointed at it precisely — nothing else here
// // // // // //   // depends on that detail.
// // // // // //   // -----------------------------------------------------------------
// // // // // //   List<ShiftSlaViolation> _parseSlaViolations(
// // // // // //       List<dynamic>? violations, String fallbackStatus) {
// // // // // //     return (violations ?? const []).map((v) {
// // // // // //       if (v is Map) {
// // // // // //         final location = v['location'] as Map?;
// // // // // //         final locationRegion = v['locationRegion'] as Map?;
// // // // // //         final entrySecurity = v['entrySecurity'] as Map?;
// // // // // //         final approver = v['approver'] as Map?;
// // // // // //         final typeOfServiceList = v['typeOfService'] as List?;
// // // // // //
// // // // // //         String fullName(Map? user) {
// // // // // //           if (user == null) return '-';
// // // // // //           final userInfo = user['userInfo'] as String?;
// // // // // //           if (userInfo != null && userInfo.isNotEmpty) return userInfo;
// // // // // //           final first = user['firstName'] as String? ?? '';
// // // // // //           final last = user['lastName'] as String? ?? '';
// // // // // //           final combined = '$first $last'.trim();
// // // // // //           return combined.isNotEmpty ? combined : '-';
// // // // // //         }
// // // // // //
// // // // // //         String formatEpochMs(dynamic epochMs) {
// // // // // //           if (epochMs == null) return '-';
// // // // // //           final millis = epochMs is int ? epochMs : int.tryParse('$epochMs');
// // // // // //           if (millis == null) return '-';
// // // // // //           final date = DateTime.fromMillisecondsSinceEpoch(millis);
// // // // // //           return '${date.day.toString().padLeft(2, '0')}/'
// // // // // //               '${date.month.toString().padLeft(2, '0')}/'
// // // // // //               '${date.year} ${date.hour.toString().padLeft(2, '0')}:'
// // // // // //               '${date.minute.toString().padLeft(2, '0')}';
// // // // // //         }
// // // // // //
// // // // // //         return ShiftSlaViolation(
// // // // // //           id: '${v['id'] ?? v['slNo'] ?? '-'}',
// // // // // //           region: locationRegion?['name'] as String? ?? '-',
// // // // // //           location: location?['name'] as String? ?? '-',
// // // // // //           dateOfCreation: formatEpochMs(v['inputDate']),
// // // // // //           createdBy: fullName(entrySecurity),
// // // // // //           asl: fullName(approver),
// // // // // //           typeOfService: (typeOfServiceList ?? const [])
// // // // // //               .map((t) => (t as Map?)?['name'] as String? ?? '')
// // // // // //               .where((s) => s.isNotEmpty)
// // // // // //               .join(', '),
// // // // // //           status: v['statusLabel'] as String? ?? fallbackStatus,
// // // // // //         );
// // // // // //       }
// // // // // //       return ShiftSlaViolation(
// // // // // //         id: '-',
// // // // // //         region: '-',
// // // // // //         location: '-',
// // // // // //         dateOfCreation: '-',
// // // // // //         createdBy: '-',
// // // // // //         asl: '-',
// // // // // //         typeOfService: '',
// // // // // //         status: fallbackStatus,
// // // // // //       );
// // // // // //     }).toList();
// // // // // //   }
// // // // // //
// // // // // //   Widget _buildShiftCard(
// // // // // //       Shifts shift, int index, double height, AttendanceShiftsState state) {
// // // // // //     final accent = _shiftAccentColors[index % _shiftAccentColors.length];
// // // // // //     final isActive = shift.activeShift == true;
// // // // // //     final statusLabel = isActive ? 'Active' : 'Draft';
// // // // // //     final statusColor =
// // // // // //     isActive ? const Color(0xFF3FB65D) : const Color(0xFFF5A623);
// // // // // //
// // // // // //     final planned = shift.allowed ?? 0;
// // // // // //     final present = shift.attended?.length ?? 0;
// // // // // //
// // // // // //     final shiftKey = _shiftKey(shift);
// // // // // //     final editable = !isReadOnly;
// // // // // //
// // // // // //     // See CAVEAT on `_parseSlaViolations` re: the assumed `violations` field.
// // // // // //     final slaViolations = _parseSlaViolations(shift.slaViolations, statusLabel);
// // // // // //
// // // // // //     return Container(
// // // // // //       decoration: BoxDecoration(
// // // // // //         border: Border(top: BorderSide(color: accent, width: 3)),
// // // // // //         color: Colors.white.withValues(alpha: 0.92),
// // // // // //         borderRadius: BorderRadius.circular(10),
// // // // // //         boxShadow: [
// // // // // //           BoxShadow(
// // // // // //             color: Colors.black.withValues(alpha: 0.06),
// // // // // //             blurRadius: 8,
// // // // // //             offset: const Offset(0, 3),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //       padding: const EdgeInsets.all(14),
// // // // // //       child: Column(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           // Header: avatar + "SHIFT X / time range" + status badge
// // // // // //           Row(
// // // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //             children: [
// // // // // //               Container(
// // // // // //                 width: 26,
// // // // // //                 height: 26,
// // // // // //                 alignment: Alignment.center,
// // // // // //                 decoration: BoxDecoration(
// // // // // //                   color: accent.withValues(alpha: 0.15),
// // // // // //                   borderRadius: BorderRadius.circular(6),
// // // // // //                 ),
// // // // // //                 child: Text(
// // // // // //                   (shift.shift ?? '?').toUpperCase(),
// // // // // //                   style: TextStyle(
// // // // // //                     color: accent,
// // // // // //                     fontWeight: FontWeight.w700,
// // // // // //                     fontSize: 12,
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ),
// // // // // //               const SizedBox(width: 10),
// // // // // //               Expanded(
// // // // // //                 child: Column(
// // // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                   children: [
// // // // // //                     Text(
// // // // // //                       'SHIFT ${(shift.shift ?? '-').toUpperCase()}',
// // // // // //                       style: const TextStyle(
// // // // // //                         color: Colors.black45,
// // // // // //                         fontWeight: FontWeight.w700,
// // // // // //                         fontSize: 11,
// // // // // //                         letterSpacing: 0.5,
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                     Text(
// // // // // //                       _timeRangeForShift(shift.shift),
// // // // // //                       style: const TextStyle(
// // // // // //                         color: Colors.black87,
// // // // // //                         fontWeight: FontWeight.w700,
// // // // // //                         fontSize: 14,
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   ],
// // // // // //                 ),
// // // // // //               ),
// // // // // //               Row(
// // // // // //                 children: [
// // // // // //                   Container(
// // // // // //                     width: 8,
// // // // // //                     height: 8,
// // // // // //                     decoration:
// // // // // //                     BoxDecoration(color: statusColor, shape: BoxShape.circle),
// // // // // //                   ),
// // // // // //                   const SizedBox(width: 4),
// // // // // //                   Text(
// // // // // //                     statusLabel,
// // // // // //                     style: const TextStyle(
// // // // // //                       color: Colors.black87,
// // // // // //                       fontWeight: FontWeight.w600,
// // // // // //                       fontSize: 12,
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //           CommonWidgets.verticalSpacerWidget(height * 0.012),
// // // // // //
// // // // // //           _plannedPresentRow(planned, present),
// // // // // //           CommonWidgets.verticalSpacerWidget(height * 0.012),
// // // // // //
// // // // // //           // ATTENDANCE MARKING
// // // // // //           _sectionHeader(
// // // // // //             'ATTENDANCE MARKING',
// // // // // //             trailing:  null,
// // // // // //           ),
// // // // // //           const SizedBox(height: 6),
// // // // // //           _attendanceMarkingBox(shift, shiftKey, editable),
// // // // // //           const SizedBox(height: 12),
// // // // // //
// // // // // //           // REPLACEMENTS — only shown for active shifts, matching Shift A
// // // // // //           // / Shift G in the reference (Shift B / C don't show it).
// // // // // //           if (isActive) ...[
// // // // // //             _sectionHeader(
// // // // // //               'REPLACEMENTS',
// // // // // //               trailing: editable
// // // // // //                   ? _addIconButton(() =>    showReplacementPopUp(
// // // // // //                 context: context,
// // // // // //                 model: replacement,
// // // // // //                 selectedGuards: state.model.selectForReplacements ?? {},
// // // // // //                 state: state,
// // // // // //                 rankId: rankId,
// // // // // //                 shiftId: shiftId,
// // // // // //                 dutyPostId: _resolveDutyPostId(context),
// // // // // //                 attendanceId: _resolveAttendanceId(),
// // // // // //               ))
// // // // // //                   : null,
// // // // // //             ),
// // // // // //             const SizedBox(height: 6),
// // // // // //             _replacementsBox(shiftKey),
// // // // // //             const SizedBox(height: 12),
// // // // // //           ],
// // // // // //
// // // // // //           // SLA VIOLATION LIST
// // // // // //           _sectionHeader(
// // // // // //             'SLA VIOLATION LIST',
// // // // // //             trailing: editable
// // // // // //                 ? _addIconButton(() => _onAddSlaViolation(shift, state))
// // // // // //                 : null,
// // // // // //           ),
// // // // // //           const SizedBox(height: 6),
// // // // // //           if (slaViolations.isEmpty)
// // // // // //             _emptyStateBox('No SLA violations added yet')
// // // // // //           else
// // // // // //             Column(
// // // // // //               children: slaViolations
// // // // // //                   .map((sla) => _slaViolationCard(sla))
// // // // // //                   .toList(),
// // // // // //             ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   // SLA VIOLATION LIST
// // // // // //   // ---------------------------------------------------------------------
// // // // // //
// // // // // //   Widget _slaViolationCard(ShiftSlaViolation sla) {
// // // // // //     final isCollapsed = _collapsedSlaIds.contains(sla.id);
// // // // // //     return Container(
// // // // // //       width: double.infinity,
// // // // // //       margin: const EdgeInsets.only(bottom: 10),
// // // // // //       decoration: BoxDecoration(
// // // // // //         borderRadius: BorderRadius.circular(8),
// // // // // //         border: Border.all(color: Colors.black12),
// // // // // //       ),
// // // // // //       clipBehavior: Clip.antiAlias,
// // // // // //       child: Column(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           InkWell(
// // // // // //             onTap: () {
// // // // // //               setState(() {
// // // // // //                 if (isCollapsed) {
// // // // // //                   _collapsedSlaIds.remove(sla.id);
// // // // // //                 } else {
// // // // // //                   _collapsedSlaIds.add(sla.id);
// // // // // //                 }
// // // // // //               });
// // // // // //             },
// // // // // //             child: Container(
// // // // // //               width: double.infinity,
// // // // // //               color: const Color(0xFF3D6DB0),
// // // // // //               padding:
// // // // // //               const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// // // // // //               child: Row(
// // // // // //                 children: [
// // // // // //                   Expanded(
// // // // // //                     child: Text.rich(
// // // // // //                       TextSpan(
// // // // // //                         children: [
// // // // // //                           TextSpan(
// // // // // //                             text: sla.typeOfService,
// // // // // //                             style: const TextStyle(
// // // // // //                               color: Colors.white,
// // // // // //                               fontWeight: FontWeight.w700,
// // // // // //                               fontSize: 13,
// // // // // //                             ),
// // // // // //                           ),
// // // // // //                           TextSpan(
// // // // // //                             text: '   ${sla.status}   ${sla.dateOfCreation}',
// // // // // //                             style: const TextStyle(
// // // // // //                               color: Colors.white70,
// // // // // //                               fontWeight: FontWeight.w400,
// // // // // //                               fontSize: 12,
// // // // // //                             ),
// // // // // //                           ),
// // // // // //                         ],
// // // // // //                       ),
// // // // // //                       overflow: TextOverflow.ellipsis,
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                   Icon(
// // // // // //                     isCollapsed
// // // // // //                         ? Icons.keyboard_arrow_down
// // // // // //                         : Icons.keyboard_arrow_up,
// // // // // //                     color: Colors.white,
// // // // // //                     size: 18,
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //           if (!isCollapsed)
// // // // // //             Padding(
// // // // // //               padding: const EdgeInsets.all(12),
// // // // // //               child: Column(
// // // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                 children: [
// // // // // //                   Row(
// // // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                     children: [
// // // // // //                       Expanded(
// // // // // //                           child: _readOnlyField(label: 'ID', value: sla.id)),
// // // // // //                       const SizedBox(width: 12),
// // // // // //                       Expanded(
// // // // // //                           child: _readOnlyField(
// // // // // //                               label: 'REGION', value: sla.region)),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                   const SizedBox(height: 12),
// // // // // //                   Row(
// // // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                     children: [
// // // // // //                       Expanded(
// // // // // //                           child: _readOnlyField(
// // // // // //                               label: 'LOCATION', value: sla.location)),
// // // // // //                       const SizedBox(width: 12),
// // // // // //                       Expanded(
// // // // // //                           child: _readOnlyField(
// // // // // //                               label: 'DATE OF CREATION',
// // // // // //                               value: sla.dateOfCreation)),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                   const SizedBox(height: 12),
// // // // // //                   Row(
// // // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                     children: [
// // // // // //                       Expanded(
// // // // // //                           child: _readOnlyField(
// // // // // //                               label: 'CREATED BY', value: sla.createdBy)),
// // // // // //                       const SizedBox(width: 12),
// // // // // //                       Expanded(
// // // // // //                           child: _readOnlyField(label: 'ASL', value: sla.asl)),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                   const SizedBox(height: 12),
// // // // // //                   Row(
// // // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                     children: [
// // // // // //                       Expanded(
// // // // // //                           child: _readOnlyField(
// // // // // //                               label: 'TYPE OF SERVICE',
// // // // // //                               value: sla.typeOfService)),
// // // // // //                       const SizedBox(width: 12),
// // // // // //                       Expanded(
// // // // // //                           child: _readOnlyField(
// // // // // //                               label: 'STATUS', value: sla.status)),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //             ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   Widget _sectionHeader(String title, {Widget? trailing}) {
// // // // // //     return Row(
// // // // // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // //       children: [
// // // // // //         Text(
// // // // // //           title,
// // // // // //           style: const TextStyle(
// // // // // //             color: Colors.black87,
// // // // // //             fontWeight: FontWeight.w700,
// // // // // //             fontSize: 12,
// // // // // //             letterSpacing: 0.4,
// // // // // //           ),
// // // // // //         ),
// // // // // //         if (trailing != null) trailing,
// // // // // //       ],
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   Widget _addIconButton(VoidCallback onTap) {
// // // // // //     return InkWell(
// // // // // //       onTap: onTap,
// // // // // //       borderRadius: BorderRadius.circular(20),
// // // // // //       child: Container(
// // // // // //         width: 26,
// // // // // //         height: 26,
// // // // // //         decoration: const BoxDecoration(
// // // // // //           color: Color(0xFF5B4FCF),
// // // // // //           shape: BoxShape.circle,
// // // // // //         ),
// // // // // //         child: const Icon(Icons.add, color: Colors.white, size: 16),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   Widget _emptyStateBox(String message) {
// // // // // //     return Container(
// // // // // //       width: double.infinity,
// // // // // //       padding: const EdgeInsets.symmetric(vertical: 16),
// // // // // //       decoration: BoxDecoration(
// // // // // //         color: Colors.grey.shade50,
// // // // // //         border: Border.all(color: Colors.grey.shade300),
// // // // // //         borderRadius: BorderRadius.circular(8),
// // // // // //       ),
// // // // // //       alignment: Alignment.center,
// // // // // //       child: Text(
// // // // // //         message,
// // // // // //         style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   Widget _plannedPresentRow(int planned, int present) {
// // // // // //     return Text.rich(
// // // // // //       TextSpan(
// // // // // //         children: [
// // // // // //           const TextSpan(
// // // // // //             text: 'Planned: ',
// // // // // //             style: TextStyle(
// // // // // //                 color: Colors.black87,
// // // // // //                 fontWeight: FontWeight.w700,
// // // // // //                 fontSize: 13),
// // // // // //           ),
// // // // // //           TextSpan(
// // // // // //             text: '$planned  ',
// // // // // //             style: const TextStyle(
// // // // // //                 color: Colors.black87,
// // // // // //                 fontWeight: FontWeight.w700,
// // // // // //                 fontSize: 13),
// // // // // //           ),
// // // // // //           const TextSpan(
// // // // // //             text: 'Present: ',
// // // // // //             style: TextStyle(
// // // // // //                 color: Colors.black87,
// // // // // //                 fontWeight: FontWeight.w700,
// // // // // //                 fontSize: 13),
// // // // // //           ),
// // // // // //           TextSpan(
// // // // // //             text: '$present',
// // // // // //             style: const TextStyle(
// // // // // //                 color: Colors.black87,
// // // // // //                 fontWeight: FontWeight.w700,
// // // // // //                 fontSize: 13),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   // ATTENDANCE MARKING
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   Widget _attendanceMarkingBox(Shifts shift, String shiftKey, bool editable) {
// // // // // //     final attended = shift.attended ?? const <Attended>[];
// // // // // //     if (attended.isEmpty) {
// // // // // //       return _emptyStateBox('No guards marked attended yet');
// // // // // //     }
// // // // // //
// // // // // //     final newlyAdded = _newlyAddedGuardIdsByShift[shiftKey] ?? const <int>{};
// // // // // //
// // // // // //     return Container(
// // // // // //       width: double.infinity,
// // // // // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// // // // // //       decoration: BoxDecoration(
// // // // // //         color: Colors.grey.shade50,
// // // // // //         border: Border.all(color: Colors.grey.shade300),
// // // // // //         borderRadius: BorderRadius.circular(8),
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         children: attended.map((guard) {
// // // // // //           final canRemove =
// // // // // //               editable && guard.id != null && newlyAdded.contains(guard.id);
// // // // // //           return Padding(
// // // // // //             padding: const EdgeInsets.symmetric(vertical: 6),
// // // // // //             child: Row(
// // // // // //               children: [
// // // // // //                 CircleAvatar(
// // // // // //                   radius: 12,
// // // // // //                   backgroundColor: const Color(0xFFEDE9FE),
// // // // // //                   child: Text(
// // // // // //                     (guard.name?.isNotEmpty == true)
// // // // // //                         ? guard.name![0].toUpperCase()
// // // // // //                         : '?',
// // // // // //                     style: const TextStyle(
// // // // // //                       color: Color(0xFF5B4FCF),
// // // // // //                       fontWeight: FontWeight.w700,
// // // // // //                       fontSize: 11,
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 const SizedBox(width: 8),
// // // // // //                 Expanded(
// // // // // //                   child: Text(
// // // // // //                     guard.name ?? '-',
// // // // // //                     style: const TextStyle(
// // // // // //                         color: Colors.black87, fontWeight: FontWeight.w600),
// // // // // //                     overflow: TextOverflow.ellipsis,
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 if (canRemove)
// // // // // //                   OutlinedButton(
// // // // // //                     onPressed: () =>
// // // // // //                         _removeAttendedGuard(shift, shiftKey, guard),
// // // // // //                     style: OutlinedButton.styleFrom(
// // // // // //                       foregroundColor: Colors.red,
// // // // // //                       side: const BorderSide(color: Colors.red),
// // // // // //                       shape: RoundedRectangleBorder(
// // // // // //                         borderRadius: BorderRadius.circular(20),
// // // // // //                       ),
// // // // // //                       padding: const EdgeInsets.symmetric(
// // // // // //                           horizontal: 12, vertical: 2),
// // // // // //                       minimumSize: const Size(0, 30),
// // // // // //                     ),
// // // // // //                     child: const Text('Remove',
// // // // // //                         style: TextStyle(fontWeight: FontWeight.w600)),
// // // // // //                   ),
// // // // // //               ],
// // // // // //             ),
// // // // // //           );
// // // // // //         }).toList(),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   // BlocProvider.of<AttendanceShiftsCubit>(context).unmarkGuardAttended(guard);
// // // // // //   void _removeAttendedGuard(Shifts shift, String shiftKey, Attended guard) {
// // // // // //     setState(() {
// // // // // //       shift.attended?.removeWhere((a) => a.id == guard.id);
// // // // // //       if (guard.id != null) {
// // // // // //         _newlyAddedGuardIdsByShift[shiftKey]?.remove(guard.id);
// // // // // //       }
// // // // // //     });
// // // // // //   }
// // // // // //
// // // // // //   // TODO: replace direct field mutation with a real cubit call, e.g.
// // // // // //   // BlocProvider.of<AttendanceShiftsCubit>(context).markGuardAttended(guard);
// // // // // //   void _addGuardToAttendance(
// // // // // //       Shifts shift, String shiftKey, AvailableGuards guard) {
// // // // // //     setState(() {
// // // // // //       shift.attended ??= [];
// // // // // //       shift.attended!.add(Attended(id: guard.id, name: guard.name));
// // // // // //       if (guard.id != null) {
// // // // // //         _newlyAddedGuardIdsByShift
// // // // // //             .putIfAbsent(shiftKey, () => <int>{})
// // // // // //             .add(guard.id!);
// // // // // //       }
// // // // // //     });
// // // // // //   }
// // // // // //
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   // REPLACEMENTS (local-only placeholder — see TODO at top of file)
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   Widget _replacementsBox(String shiftKey) {
// // // // // //     final replacements = _replacementsByShift[shiftKey] ?? const [];
// // // // // //     if (replacements.isEmpty) {
// // // // // //       return _emptyStateBox('No replacements added yet');
// // // // // //     }
// // // // // //
// // // // // //     return Container(
// // // // // //       width: double.infinity,
// // // // // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// // // // // //       decoration: BoxDecoration(
// // // // // //         color: Colors.grey.shade50,
// // // // // //         border: Border.all(color: Colors.grey.shade300),
// // // // // //         borderRadius: BorderRadius.circular(8),
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         children: replacements
// // // // // //             .map(
// // // // // //               (r) => Padding(
// // // // // //             padding: const EdgeInsets.symmetric(vertical: 6),
// // // // // //             child: Row(
// // // // // //               children: [
// // // // // //                 Expanded(
// // // // // //                   child: Text(
// // // // // //                     r.replacedFor,
// // // // // //                     style: const TextStyle(
// // // // // //                         color: Colors.black87, fontWeight: FontWeight.w600),
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 Expanded(
// // // // // //                   child: Text(
// // // // // //                     r.reason,
// // // // // //                     style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
// // // // // //                     overflow: TextOverflow.ellipsis,
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ],
// // // // // //             ),
// // // // // //           ),
// // // // // //         )
// // // // // //             .toList(),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // void _onAddSlaViolation(Shifts shift, AttendanceShiftsState state) {
// // // // // //     FocusScope.of(context).unfocus();
// // // // // //     _lastSubmitWasSaveOnly = true;
// // // // // //     BlocProvider.of<AttendanceShiftsCubit>(context).submitForm(isSaveOnly: true);
// // // // // //
// // // // // //     Navigator.pushNamed(
// // // // // //       context,
// // // // // //       slaViolationPenaltyDetailsRoute,
// // // // // //       arguments: {
// // // // // //         ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
// // // // // //         ConstantsArgument.attdId: state.model.id,
// // // // // //         ConstantsArgument.location: widget.location,
// // // // // //         ConstantsArgument.locationRegion: widget.locationRegion,
// // // // // //         ConstantsArgument.vendor: widget.vendor,
// // // // // //       },
// // // // // //     ).then((_) {
// // // // // //       if (!mounted) return;
// // // // // //       BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// // // // // //     });
// // // // // //   }
// // // // // //
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   // Frosted confirmation dialog for Submit
// // // // // //   // ---------------------------------------------------------------------
// // // // // //   Widget _buildGlassDialog({
// // // // // //     required String title,
// // // // // //     required String message,
// // // // // //     required VoidCallback onCancel,
// // // // // //     required Future<void> Function() onConfirm,
// // // // // //   }) {
// // // // // //     return Dialog(
// // // // // //       backgroundColor: Colors.transparent,
// // // // // //       insetPadding: const EdgeInsets.symmetric(horizontal: 24),
// // // // // //       child: ClipRRect(
// // // // // //         borderRadius: BorderRadius.circular(20),
// // // // // //         child: BackdropFilter(
// // // // // //           filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
// // // // // //           child: Container(
// // // // // //             padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
// // // // // //             decoration: BoxDecoration(
// // // // // //               gradient: LinearGradient(
// // // // // //                 colors: [
// // // // // //                   Colors.white.withValues(alpha: 0.02),
// // // // // //                   Colors.white.withValues(alpha: 0.04),
// // // // // //                 ],
// // // // // //                 begin: Alignment.topLeft,
// // // // // //                 end: Alignment.bottomRight,
// // // // // //               ),
// // // // // //               borderRadius: BorderRadius.circular(20),
// // // // // //               border: Border.all(
// // // // // //                 color: Colors.white.withValues(alpha: 0.55),
// // // // // //                 width: 1,
// // // // // //               ),
// // // // // //               boxShadow: [
// // // // // //                 BoxShadow(
// // // // // //                   color: Colors.black.withValues(alpha: 0.04),
// // // // // //                   blurRadius: 20,
// // // // // //                   offset: const Offset(0, 8),
// // // // // //                 ),
// // // // // //               ],
// // // // // //             ),
// // // // // //             child: Column(
// // // // // //               mainAxisSize: MainAxisSize.min,
// // // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //               children: [
// // // // // //                 Text(
// // // // // //                   title,
// // // // // //                   style: const TextStyle(
// // // // // //                     color: Colors.white,
// // // // // //                     fontSize: 17,
// // // // // //                     fontWeight: FontWeight.w700,
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 const SizedBox(height: 12),
// // // // // //                 Text(
// // // // // //                   message,
// // // // // //                   style: TextStyle(
// // // // // //                     color: Colors.white.withValues(alpha: 0.85),
// // // // // //                     fontSize: 14,
// // // // // //                     height: 1.4,
// // // // // //                   ),
// // // // // //                 ),
// // // // // //                 const SizedBox(height: 20),
// // // // // //                 Row(
// // // // // //                   mainAxisAlignment: MainAxisAlignment.end,
// // // // // //                   children: [
// // // // // //                     TextButton(
// // // // // //                       onPressed: onCancel,
// // // // // //                       style: TextButton.styleFrom(
// // // // // //                         foregroundColor: Colors.white.withValues(alpha: 0.8),
// // // // // //                       ),
// // // // // //                       child: const Text(Constants.cancel),
// // // // // //                     ),
// // // // // //                     const SizedBox(width: 8),
// // // // // //                     TextButton(
// // // // // //                       onPressed: onConfirm,
// // // // // //                       style: TextButton.styleFrom(
// // // // // //                         foregroundColor: Colors.white,
// // // // // //                         backgroundColor: Colors.white.withValues(alpha: 0.12),
// // // // // //                         shape: RoundedRectangleBorder(
// // // // // //                           borderRadius: BorderRadius.circular(10),
// // // // // //                         ),
// // // // // //                         padding: const EdgeInsets.symmetric(
// // // // // //                           horizontal: 16,
// // // // // //                           vertical: 10,
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                       child: const Text(Constants.ok),
// // // // // //                     ),
// // // // // //                   ],
// // // // // //                 ),
// // // // // //               ],
// // // // // //             ),
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   void showReplacementPopUp({
// // // // // //     required BuildContext context,
// // // // // //     required Replacement model,
// // // // // //     required Set<BaseUser> selectedGuards,
// // // // // //     required AttendanceShiftsState state,
// // // // // //     required int rankId,
// // // // // //     required int shiftId,
// // // // // //     required int dutyPostId,
// // // // // //     required int attendanceId,
// // // // // //   }) {
// // // // // //     showDialog(
// // // // // //       context: context,
// // // // // //       builder: (BuildContext dialogContext) {
// // // // // //         return AddReplacementPopUp(
// // // // // //           viaAttendance: true,
// // // // // //           model: model,
// // // // // //           mainContext: context,
// // // // // //           selectedGuards: selectedGuards,
// // // // // //           attendanceModel: state.model,
// // // // // //           shiftId: shiftId,
// // // // // //           rankId: rankId,
// // // // // //           dutyPostId: dutyPostId,
// // // // // //           attendanceId: attendanceId,
// // // // // //         );
// // // // // //       },
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // //
// // // // // // NOTE: the large commented-out block that used to sit above this class
// // // // // // (the old ShiftModel/rank-shift-dropdown version of this screen) has been
// // // // // // removed for clarity — it is not compiled and was not touched by this fix.
// // // // // // If you need it back, restore it from your previous version of this file.
// // // // //
// // // // // import 'dart:ui';
// // // // //
// // // // // import 'package:db_atom/index.dart';
// // // // //
// // // // // import '../../attendance_details/views/attendance_details_view.dart';
// // // // // import '../../models/dutyPost_attendance_model.dart';
// // // // //
// // // // // class AttendanceShiftsView extends StatefulWidget {
// // // // //   const AttendanceShiftsView({
// // // // //     super.key,
// // // // //     required this.location,
// // // // //     required this.locationRegion,
// // // // //     required this.vendor,
// // // // //     required this.attInfoId,
// // // // //     required this.selectedDutyPostModel,
// // // // //     required this.isReadOnly,
// // // // //     required this.isEligibleToEdit,
// // // // //   });
// // // // //
// // // // //   final Organisation location;
// // // // //   final Organisation locationRegion;
// // // // //   final Organisation vendor;
// // // // //   final int attInfoId;
// // // // //   final DutyPostModel selectedDutyPostModel;
// // // // //   final bool isReadOnly;
// // // // //   final bool isEligibleToEdit;
// // // // //
// // // // //   @override
// // // // //   AttendanceShiftsViewState createState() => AttendanceShiftsViewState();
// // // // // }
// // // // //
// // // // // /// Minimal local-only stand-in for a shift-level replacement until the
// // // // // /// real `Replacement` model / service is wired to this screen.
// // // // // class _LocalReplacementDraft {
// // // // //   _LocalReplacementDraft({required this.replacedFor, required this.reason});
// // // // //
// // // // //   final String replacedFor;
// // // // //   final String reason;
// // // // // }
// // // // //
// // // // // class ShiftSlaViolation {
// // // // //   final String id;
// // // // //   final String region;
// // // // //   final String location;
// // // // //   final String dateOfCreation;
// // // // //   final String createdBy;
// // // // //   final String asl;
// // // // //   final String typeOfService;
// // // // //   final String status;
// // // // //
// // // // //   ShiftSlaViolation({
// // // // //     required this.id,
// // // // //     required this.region,
// // // // //     required this.location,
// // // // //     required this.dateOfCreation,
// // // // //     required this.createdBy,
// // // // //     required this.asl,
// // // // //     required this.typeOfService,
// // // // //     required this.status,
// // // // //   });
// // // // // }
// // // // //
// // // // // Widget _readOnlyField({required String label, required String value}) {
// // // // //   return Column(
// // // // //     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //     children: [
// // // // //       Text(
// // // // //         label,
// // // // //         style: const TextStyle(
// // // // //           color: Colors.black,
// // // // //           fontSize: 11,
// // // // //           fontWeight: FontWeight.w700,
// // // // //           letterSpacing: 0.5,
// // // // //         ),
// // // // //       ),
// // // // //       const SizedBox(height: 6),
// // // // //       Container(
// // // // //         width: double.infinity,
// // // // //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
// // // // //         decoration: BoxDecoration(
// // // // //           color: Colors.white.withValues(alpha: 0.9),
// // // // //           borderRadius: BorderRadius.circular(6),
// // // // //           border: Border.all(color: const Color(0xFF3D6DB0)),
// // // // //         ),
// // // // //         child: Text(
// // // // //           value,
// // // // //           style: const TextStyle(color: Colors.black87),
// // // // //         ),
// // // // //       ),
// // // // //     ],
// // // // //   );
// // // // // }
// // // // //
// // // // // class AttendanceShiftsViewState extends State<AttendanceShiftsView> {
// // // // //   bool isReadOnly = false;
// // // // //
// // // // //   // Accordion expand/collapse state — duty posts & ranks start expanded;
// // // // //   // a key only ever lands in these sets once the user *collapses* it.
// // // // //   final Set<String> _collapsedDutyPostKeys = {};
// // // // //   final Set<String> _collapsedRankKeys = {};
// // // // //
// // // // //   // Tracks which guard ids were added to a shift's attendance *in this
// // // // //   // session*, so only those rows show a "Remove" button — guards already
// // // // //   // attended before the screen opened stay locked. Keyed by `_shiftKey`.
// // // // //   final Map<String, Set<int>> _newlyAddedGuardIdsByShift = {};
// // // // //
// // // // //   // Local-only placeholder — see TODO at the top of this file.
// // // // //   final Map<String, List<_LocalReplacementDraft>> _replacementsByShift = {};
// // // // //
// // // // //   // ---------------------------------------------------------------
// // // // //   // Tracks whether the LAST submitForm(...) call we made was a
// // // // //   // save-only call (isSaveOnly: true) — mirrors the same flag in
// // // // //   // AdditionalDeploymentsView. The BlocConsumer listener below shows a
// // // // //   // generic "Attendance" success dialog whenever state.status ==
// // // // //   // FormStatus.success, but that dialog should only appear for the real
// // // // //   // Submit action, not for the background auto-save that now runs
// // // // //   // before opening the SLA Violation screen.
// // // // //   // ---------------------------------------------------------------
// // // // //   bool _lastSubmitWasSaveOnly = false;
// // // // //
// // // // //   // Card accent palette cycled per shift position within a rank, matching
// // // // //   // the orange / blue / red / green top borders in the reference design.
// // // // //   static const List<Color> _shiftAccentColors = [
// // // // //     Color(0xFFF5A623), // orange
// // // // //     Color(0xFF3D6DB0), // blue
// // // // //     Color(0xFFD64545), // red
// // // // //     Color(0xFF3FB65D), // green
// // // // //   ];
// // // // //
// // // // //   final Set<String> _collapsedSlaIds = {};
// // // // //
// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final size = MediaQuery.of(context).size;
// // // // //     final height = size.height;
// // // // //
// // // // //     return BlocConsumer<AttendanceShiftsCubit, AttendanceShiftsState>(
// // // // //       listener: (context, state) {
// // // // //         Utils().formError(state, context);
// // // // //         Utils().errorAndLogout(state, context);
// // // // //
// // // // //         if (state.status == FormStatus.success) {
// // // // //           var dialog = CustomAlertDialog(
// // // // //             title: 'Attendance',
// // // // //             message: state.message ?? '',
// // // // //             positiveBtnText: Constants.ok,
// // // // //             onPositivePressed: () {
// // // // //               Navigator.pop(context);
// // // // //               Navigator.pop(context);
// // // // //               Navigator.popAndPushNamed(
// // // // //                 context,
// // // // //                 attendanceListRoute,
// // // // //                 arguments: {},
// // // // //               );
// // // // //             },
// // // // //           );
// // // // //           showDialog(
// // // // //               context: context,
// // // // //               barrierDismissible: false,
// // // // //               builder: (BuildContext context) => dialog);
// // // // //
// // // // //           // Utils.dynamicAlert(
// // // // //           //     context, state.message ?? '', 'Material Movement', '');
// // // // //         }
// // // // //       },
// // // // //       builder: (context, state) {
// // // // //         isReadOnly = widget.isReadOnly ||
// // // // //             !widget.isEligibleToEdit ||
// // // // //             !state.model.lock.isEmptyOrNull;
// // // // //
// // // // //         return Scaffold(
// // // // //           backgroundColor: Colors.transparent,
// // // // //           extendBodyBehindAppBar: true,
// // // // //           appBar: BaseAppBar().buildAppHeader(
// // // // //             context: context,
// // // // //             title: 'Attendance',
// // // // //             showPopUp: false,
// // // // //             showSaveButton: false,
// // // // //             showSubmitButton: !isReadOnly && state.status != FormStatus.loading,
// // // // //             showDisLikeButton: false,
// // // // //             showLikeButton: false,
// // // // //             popAndReplace: () {
// // // // //               int flag = AttendanceDetailsView.flag;
// // // // //               if (flag == 1) {
// // // // //                 Navigator.pop(context);
// // // // //               } else {
// // // // //                 Navigator.pop(context);
// // // // //                 // Navigator.pop(context);
// // // // //                 // Navigator.pop(context);
// // // // //               }
// // // // //             },
// // // // //             onTapSubmit: () {
// // // // //               FocusScope.of(context).unfocus();
// // // // //               BlocProvider.of<AttendanceShiftsCubit>(context)
// // // // //                   .submitForm(isSaveOnly: false);
// // // // //             },
// // // // //           ),
// // // // //
// // // // //           // ================= BODY WITH BACKGROUND =================
// // // // //           body: Stack(
// // // // //             children: [
// // // // //               Positioned.fill(
// // // // //                 child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
// // // // //               ),
// // // // //               Positioned.fill(
// // // // //                 child: BackdropFilter(
// // // // //                   filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
// // // // //                   child: Container(color: Colors.black.withValues(alpha: 0.15)),
// // // // //                 ),
// // // // //               ),
// // // // //               Positioned.fill(
// // // // //                 child: MediaQuery.removePadding(
// // // // //                   context: context,
// // // // //                   removeTop: true,
// // // // //                   child: Padding(
// // // // //                     padding: const EdgeInsets.all(20),
// // // // //                     child: SingleChildScrollView(
// // // // //                       child: Column(
// // // // //                         children: [
// // // // //                           SizedBox(
// // // // //                             height: kToolbarHeight +
// // // // //                                 MediaQuery.of(context).padding.top,
// // // // //                           ),
// // // // //                           getBody(state, height),
// // // // //                         ],
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }
// // // // //
// // // // //   // ---------------------------------------------------------------------
// // // // //   // BODY
// // // // //   // ---------------------------------------------------------------------
// // // // //   Widget getBody(AttendanceShiftsState state, double height) {
// // // // //     if (state.status == FormStatus.loading) {
// // // // //       return const BaseLoader();
// // // // //     }
// // // // //
// // // // //     final dutyPosts = state.dutyPostAttendanceModel?.dutyPosts ?? const <DutyPosts>[];
// // // // //
// // // // //     return Column(
// // // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // // //       children: [
// // // // //         if (!state.model.lock.isEmptyOrNull) ...[
// // // // //           RecordLockedWidget(text: '${state.model.lock}'),
// // // // //           CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //         ],
// // // // //         if (dutyPosts.isEmpty)
// // // // //           const Padding(
// // // // //             padding: EdgeInsets.symmetric(vertical: 24),
// // // // //             child: Text(
// // // // //               'No duty posts found for this attendance record.',
// // // // //               style: Styles.textStyleWhite16,
// // // // //             ),
// // // // //           )
// // // // //         else
// // // // //           for (final dutyPost in dutyPosts) ...[
// // // // //             _buildDutyPostAccordion(dutyPost, height, state),
// // // // //             CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //           ],
// // // // //       ],
// // // // //     );
// // // // //   }
// // // // //
// // // // //   // ---------------------------------------------------------------------
// // // // //   // DUTY POST ACCORDION  (e.g. "Basement")
// // // // //   // ---------------------------------------------------------------------
// // // // //   Widget _buildDutyPostAccordion(
// // // // //       DutyPosts dutyPost, double height, AttendanceShiftsState state) {
// // // // //     final key = 'dutypost_${dutyPost.dutyPostNameId}_${dutyPost.dutyPostName}';
// // // // //     final isExpanded = !_collapsedDutyPostKeys.contains(key);
// // // // //     final label = dutyPost.dutyPostName ?? '-';
// // // // //
// // // // //     return Container(
// // // // //       width: double.infinity,
// // // // //       decoration: BoxDecoration(
// // // // //         border: Border.all(color: const Color(0xFF5B4FCF)),
// // // // //         borderRadius: BorderRadius.circular(8),
// // // // //         color: Colors.white.withValues(alpha: 0.04),
// // // // //       ),
// // // // //       child: Column(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           _accordionHeader(
// // // // //             avatarText: label.isNotEmpty ? label[0].toUpperCase() : '?',
// // // // //             title: label,
// // // // //             isExpanded: isExpanded,
// // // // //             onTap: () => setState(() {
// // // // //               if (isExpanded) {
// // // // //                 _collapsedDutyPostKeys.add(key);
// // // // //               } else {
// // // // //                 _collapsedDutyPostKeys.remove(key);
// // // // //               }
// // // // //             }),
// // // // //           ),
// // // // //           if (isExpanded)
// // // // //             Padding(
// // // // //               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
// // // // //               child: Column(
// // // // //                 children: [
// // // // //                   for (final rank in dutyPost.ranks ?? const <Ranks>[]) ...[
// // // // //                     // FIX: dutyPostNameId is only known at this level of
// // // // //                     // the tree, so it now gets threaded down through
// // // // //                     // rank -> shift-grid -> shift-card, all the way to
// // // // //                     // where the "Add Replacement" button needs it.
// // // // //                     _buildRankAccordion(
// // // // //                       rank,
// // // // //                       height,
// // // // //                       state,
// // // // //                       dutyPost.dutyPostNameId,
// // // // //                     ),
// // // // //                     const SizedBox(height: 10),
// // // // //                   ],
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   // ---------------------------------------------------------------------
// // // // //   // RANK ACCORDION  (e.g. "RANK: SECURITY GUARD/LADY SECURITY GUARD")
// // // // //   // ---------------------------------------------------------------------
// // // // //   Widget _buildRankAccordion(Ranks rank, double height,
// // // // //       AttendanceShiftsState state, int? dutyPostId) {
// // // // //     final key = 'rank_${rank.rankId}_${rank.rankName}';
// // // // //     final isExpanded = !_collapsedRankKeys.contains(key);
// // // // //     final title = 'RANK: ${(rank.rankName ?? '-').toUpperCase()}';
// // // // //
// // // // //     return Container(
// // // // //       width: double.infinity,
// // // // //       decoration: BoxDecoration(
// // // // //         border: Border.all(color: const Color(0xFF5B4FCF)),
// // // // //         borderRadius: BorderRadius.circular(8),
// // // // //         color: Colors.white.withValues(alpha: 0.01),
// // // // //       ),
// // // // //       child: Column(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           _accordionHeader(
// // // // //             avatarText: _initialsFor(rank.rankName ?? ''),
// // // // //             title: title,
// // // // //             isExpanded: isExpanded,
// // // // //             onTap: () => setState(() {
// // // // //               if (isExpanded) {
// // // // //                 _collapsedRankKeys.add(key);
// // // // //               } else {
// // // // //                 _collapsedRankKeys.remove(key);
// // // // //               }
// // // // //             }),
// // // // //           ),
// // // // //           if (isExpanded)
// // // // //             Padding(
// // // // //               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
// // // // //               child: _buildShiftCardsGrid(
// // // // //                 rank.shifts ?? const <Shifts>[],
// // // // //                 height,
// // // // //                 state,
// // // // //                 dutyPostId,
// // // // //                 rank.rankId,
// // // // //               ),
// // // // //             ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   String _initialsFor(String label) {
// // // // //     final words = label.trim().split(RegExp(r'\s+'));
// // // // //     if (words.isEmpty || words.first.isEmpty) return '?';
// // // // //     return words
// // // // //         .take(2)
// // // // //         .map((w) => w.isNotEmpty ? w[0] : '')
// // // // //         .join()
// // // // //         .toUpperCase();
// // // // //   }
// // // // //
// // // // //   Widget _accordionHeader({
// // // // //     required String avatarText,
// // // // //     required String title,
// // // // //     required bool isExpanded,
// // // // //     required VoidCallback onTap,
// // // // //   }) {
// // // // //     return InkWell(
// // // // //       onTap: onTap,
// // // // //       child: Container(
// // // // //         width: double.infinity,
// // // // //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// // // // //         child: Row(
// // // // //           children: [
// // // // //             CircleAvatar(
// // // // //               radius: 12,
// // // // //               backgroundColor: Colors.white24,
// // // // //               child: Text(
// // // // //                 avatarText,
// // // // //                 style: const TextStyle(color: Colors.white, fontSize: 10),
// // // // //               ),
// // // // //             ),
// // // // //             const SizedBox(width: 8),
// // // // //             Expanded(
// // // // //               child: Text(
// // // // //                 title,
// // // // //                 style: const TextStyle(
// // // // //                   color: Colors.white,
// // // // //                   fontWeight: FontWeight.w700,
// // // // //                   fontSize: 13,
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //             Icon(
// // // // //               isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
// // // // //               color: Colors.white70,
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   // ---------------------------------------------------------------------
// // // // //   // SHIFT CARDS GRID  (Shift A / B / C / G laid out 2-up, like the ref)
// // // // //   // ---------------------------------------------------------------------
// // // // //   Widget _buildShiftCardsGrid(
// // // // //       List<Shifts> shifts,
// // // // //       double height,
// // // // //       AttendanceShiftsState state,
// // // // //       int? dutyPostId,
// // // // //       int? rankId,
// // // // //       ) {
// // // // //     if (shifts.isEmpty) {
// // // // //       return const Padding(
// // // // //         padding: EdgeInsets.symmetric(vertical: 12),
// // // // //         child: Text(
// // // // //           'No shifts under this rank.',
// // // // //           style: Styles.textStyleWhite16,
// // // // //         ),
// // // // //       );
// // // // //     }
// // // // //
// // // // //     final width = MediaQuery.of(context).size.width;
// // // // //     final isTablet = width > Constants.tabletScreenWidth;
// // // // //     // Two columns on tablet/desktop widths, single column on phones —
// // // // //     // matches the 2-up grid in the reference screenshot.
// // // // //     final cardWidth = isTablet ? (width - 60) / 2 : width - 40;
// // // // //
// // // // //     return Wrap(
// // // // //       spacing: 12,
// // // // //       runSpacing: 12,
// // // // //       children: [
// // // // //         for (var i = 0; i < shifts.length; i++)
// // // // //           SizedBox(
// // // // //             width: cardWidth,
// // // // //             child: _buildShiftCard(
// // // // //               shifts[i],
// // // // //               i,
// // // // //               height,
// // // // //               state,
// // // // //               dutyPostId,
// // // // //               rankId,
// // // // //             ),
// // // // //           ),
// // // // //       ],
// // // // //     );
// // // // //   }
// // // // //
// // // // //   String _shiftKey(Shifts shift) =>
// // // // //       'shift_${shift.attendanceShiftId ?? shift.shiftId}';
// // // // //
// // // // //   String _timeRangeForShift(String? shiftLabel) {
// // // // //     final normalized = (shiftLabel ?? '').toLowerCase().trim();
// // // // //     if (normalized == 'a') return '7AM - 3PM';
// // // // //     if (normalized == 'b') return '3PM - 11PM';
// // // // //     if (normalized == 'c') return '11PM - 7AM';
// // // // //     if (normalized == 'g') return '9AM - 6PM';
// // // // //     return '-';
// // // // //   }
// // // // //
// // // // //   // FIX: `Shifts.selectForReplacements` (from dutyPost_attendance_model.dart)
// // // // //   // is a list of `{id, name}` records — the same shape as `Attended` and
// // // // //   // `AvailableGuards` elsewhere in that model. `showReplacementPopUp` /
// // // // //   // `AddReplacementPopUp` expect a `Set<BaseUser>`, and every other
// // // // //   // `{id, name}` DTO in this codebase is treated as interchangeable with
// // // // //   // `BaseUser` at the UI boundary, so this maps it the same way. If
// // // // //   // `BaseUser`'s constructor differs from `BaseUser({id, name})`, adjust
// // // // //   // this one mapping accordingly — nothing else depends on it.
// // // // //   Set<BaseUser> _selectableReplacementGuards(Shifts shift) {
// // // // //     return (shift.selectForReplacements ?? const <SelectForReplacements>[])
// // // // //         .map((g) => BaseUser(id: g.id, name: g.name))
// // // // //         .toSet();
// // // // //   }
// // // // //
// // // // //   // -----------------------------------------------------------------
// // // // //   // Turns the raw violation payload attached to a shift into display
// // // // //   // model objects, mirroring the exact parsing logic used for
// // // // //   // `adhoc.Deployments.violations` in AdditionalDeploymentsView so the
// // // // //   // two screens show SLA data identically.
// // // // //   //
// // // // //   // CAVEAT — I don't have `dutyPost_attendance_model.dart`'s source, so
// // // // //   // this assumes `Shifts` exposes a raw `violations` field (List<dynamic>?)
// // // // //   // shaped the same way as `adhoc.Deployments.violations`: a list of Maps
// // // // //   // with `location`, `locationRegion`, `entrySecurity`, `approver`,
// // // // //   // `typeOfService`, `inputDate`, `statusLabel`, and `id`/`slNo` keys. If
// // // // //   // the real field is named or shaped differently, share that model and
// // // // //   // this method can be pointed at it precisely — nothing else here
// // // // //   // depends on that detail.
// // // // //   // -----------------------------------------------------------------
// // // // //   List<ShiftSlaViolation> _parseSlaViolations(
// // // // //       List<dynamic>? violations, String fallbackStatus) {
// // // // //     return (violations ?? const []).map((v) {
// // // // //       if (v is Map) {
// // // // //         final location = v['location'] as Map?;
// // // // //         final locationRegion = v['locationRegion'] as Map?;
// // // // //         final entrySecurity = v['entrySecurity'] as Map?;
// // // // //         final approver = v['approver'] as Map?;
// // // // //         final typeOfServiceList = v['typeOfService'] as List?;
// // // // //
// // // // //         String fullName(Map? user) {
// // // // //           if (user == null) return '-';
// // // // //           final userInfo = user['userInfo'] as String?;
// // // // //           if (userInfo != null && userInfo.isNotEmpty) return userInfo;
// // // // //           final first = user['firstName'] as String? ?? '';
// // // // //           final last = user['lastName'] as String? ?? '';
// // // // //           final combined = '$first $last'.trim();
// // // // //           return combined.isNotEmpty ? combined : '-';
// // // // //         }
// // // // //
// // // // //         String formatEpochMs(dynamic epochMs) {
// // // // //           if (epochMs == null) return '-';
// // // // //           final millis = epochMs is int ? epochMs : int.tryParse('$epochMs');
// // // // //           if (millis == null) return '-';
// // // // //           final date = DateTime.fromMillisecondsSinceEpoch(millis);
// // // // //           return '${date.day.toString().padLeft(2, '0')}/'
// // // // //               '${date.month.toString().padLeft(2, '0')}/'
// // // // //               '${date.year} ${date.hour.toString().padLeft(2, '0')}:'
// // // // //               '${date.minute.toString().padLeft(2, '0')}';
// // // // //         }
// // // // //
// // // // //         return ShiftSlaViolation(
// // // // //           id: '${v['id'] ?? v['slNo'] ?? '-'}',
// // // // //           region: locationRegion?['name'] as String? ?? '-',
// // // // //           location: location?['name'] as String? ?? '-',
// // // // //           dateOfCreation: formatEpochMs(v['inputDate']),
// // // // //           createdBy: fullName(entrySecurity),
// // // // //           asl: fullName(approver),
// // // // //           typeOfService: (typeOfServiceList ?? const [])
// // // // //               .map((t) => (t as Map?)?['name'] as String? ?? '')
// // // // //               .where((s) => s.isNotEmpty)
// // // // //               .join(', '),
// // // // //           status: v['statusLabel'] as String? ?? fallbackStatus,
// // // // //         );
// // // // //       }
// // // // //       return ShiftSlaViolation(
// // // // //         id: '-',
// // // // //         region: '-',
// // // // //         location: '-',
// // // // //         dateOfCreation: '-',
// // // // //         createdBy: '-',
// // // // //         asl: '-',
// // // // //         typeOfService: '',
// // // // //         status: fallbackStatus,
// // // // //       );
// // // // //     }).toList();
// // // // //   }
// // // // //
// // // // //   Widget _buildShiftCard(
// // // // //       Shifts shift,
// // // // //       int index,
// // // // //       double height,
// // // // //       AttendanceShiftsState state,
// // // // //       int? dutyPostId,
// // // // //       int? rankId,
// // // // //       ) {
// // // // //     final accent = _shiftAccentColors[index % _shiftAccentColors.length];
// // // // //     final isActive = shift.activeShift == true;
// // // // //     final statusLabel = isActive ? 'Active' : 'Draft';
// // // // //     final statusColor =
// // // // //     isActive ? const Color(0xFF3FB65D) : const Color(0xFFF5A623);
// // // // //
// // // // //     final planned = shift.allowed ?? 0;
// // // // //     final present = shift.attended?.length ?? 0;
// // // // //
// // // // //     final shiftKey = _shiftKey(shift);
// // // // //     // FIX: this is the id `showReplacementPopUp` needs — previously the
// // // // //     // call site referenced an undefined `shiftId` variable. It's the
// // // // //     // same id `_shiftKey` already derives the shift from.
// // // // //     final shiftId = shift.attendanceShiftId ?? shift.shiftId;
// // // // //     final editable = !isReadOnly;
// // // // //
// // // // //     // See CAVEAT on `_parseSlaViolations` re: the assumed `violations` field.
// // // // //     final slaViolations = _parseSlaViolations(shift.slaViolations, statusLabel);
// // // // //
// // // // //     return Container(
// // // // //       decoration: BoxDecoration(
// // // // //         border: Border(top: BorderSide(color: accent, width: 3)),
// // // // //         color: Colors.white.withValues(alpha: 0.92),
// // // // //         borderRadius: BorderRadius.circular(10),
// // // // //         boxShadow: [
// // // // //           BoxShadow(
// // // // //             color: Colors.black.withValues(alpha: 0.06),
// // // // //             blurRadius: 8,
// // // // //             offset: const Offset(0, 3),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //       padding: const EdgeInsets.all(14),
// // // // //       child: Column(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           // Header: avatar + "SHIFT X / time range" + status badge
// // // // //           Row(
// // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // //             children: [
// // // // //               Container(
// // // // //                 width: 26,
// // // // //                 height: 26,
// // // // //                 alignment: Alignment.center,
// // // // //                 decoration: BoxDecoration(
// // // // //                   color: accent.withValues(alpha: 0.15),
// // // // //                   borderRadius: BorderRadius.circular(6),
// // // // //                 ),
// // // // //                 child: Text(
// // // // //                   (shift.shift ?? '?').toUpperCase(),
// // // // //                   style: TextStyle(
// // // // //                     color: accent,
// // // // //                     fontWeight: FontWeight.w700,
// // // // //                     fontSize: 12,
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //               const SizedBox(width: 10),
// // // // //               Expanded(
// // // // //                 child: Column(
// // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                   children: [
// // // // //                     Text(
// // // // //                       'SHIFT ${(shift.shift ?? '-').toUpperCase()}',
// // // // //                       style: const TextStyle(
// // // // //                         color: Colors.black45,
// // // // //                         fontWeight: FontWeight.w700,
// // // // //                         fontSize: 11,
// // // // //                         letterSpacing: 0.5,
// // // // //                       ),
// // // // //                     ),
// // // // //                     Text(
// // // // //                       _timeRangeForShift(shift.shift),
// // // // //                       style: const TextStyle(
// // // // //                         color: Colors.black87,
// // // // //                         fontWeight: FontWeight.w700,
// // // // //                         fontSize: 14,
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //               Row(
// // // // //                 children: [
// // // // //                   Container(
// // // // //                     width: 8,
// // // // //                     height: 8,
// // // // //                     decoration:
// // // // //                     BoxDecoration(color: statusColor, shape: BoxShape.circle),
// // // // //                   ),
// // // // //                   const SizedBox(width: 4),
// // // // //                   Text(
// // // // //                     statusLabel,
// // // // //                     style: const TextStyle(
// // // // //                       color: Colors.black87,
// // // // //                       fontWeight: FontWeight.w600,
// // // // //                       fontSize: 12,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //           CommonWidgets.verticalSpacerWidget(height * 0.012),
// // // // //
// // // // //           _plannedPresentRow(planned, present),
// // // // //           CommonWidgets.verticalSpacerWidget(height * 0.012),
// // // // //
// // // // //           // ATTENDANCE MARKING
// // // // //           _sectionHeader(
// // // // //             'ATTENDANCE MARKING',
// // // // //             trailing: null,
// // // // //           ),
// // // // //           const SizedBox(height: 6),
// // // // //           _attendanceMarkingBox(shift, shiftKey, editable),
// // // // //           const SizedBox(height: 12),
// // // // //
// // // // //           // REPLACEMENTS — only shown for active shifts, matching Shift A
// // // // //           // / Shift G in the reference (Shift B / C don't show it).
// // // // //           if (isActive) ...[
// // // // //             _sectionHeader(
// // // // //               'REPLACEMENTS',
// // // // //               // FIX: this whole callback was broken — `replacement`,
// // // // //               // `rankId`, and `shiftId` referenced undefined names, and
// // // // //               // `state.model.selectForReplacements` doesn't exist on
// // // // //               // `AttendanceModel` (that field lives on `Shifts`, per
// // // // //               // dutyPost_attendance_model.dart). `_resolveDutyPostId` /
// // // // //               // `_resolveAttendanceId` were also leftovers from the old
// // // // //               // ShiftModel-based view and no longer exist on this class.
// // // // //               trailing: editable
// // // // //                   ? _addIconButton(() {
// // // // //                 if (dutyPostId == null || rankId == null || shiftId == null) {
// // // // //                   Validator().showToast(
// // // // //                     context,
// // // // //                     'Please select a valid duty post, rank and shift '
// // // // //                         'before adding a replacement.',
// // // // //                   );
// // // // //                   return;
// // // // //                 }
// // // // //
// // // // //                 showReplacementPopUp(
// // // // //                   context: context,
// // // // //                   model: Replacement(),
// // // // //                   selectedGuards: _selectableReplacementGuards(shift),
// // // // //                   state: state,
// // // // //                   rankId: rankId,
// // // // //                   shiftId: shiftId,
// // // // //                   dutyPostId: dutyPostId,
// // // // //                   attendanceId: widget.attInfoId,
// // // // //                 );
// // // // //               })
// // // // //                   : null,
// // // // //             ),
// // // // //             const SizedBox(height: 6),
// // // // //             _replacementsBox(shiftKey),
// // // // //             const SizedBox(height: 12),
// // // // //           ],
// // // // //
// // // // //           // SLA VIOLATION LIST
// // // // //           _sectionHeader(
// // // // //             'SLA VIOLATION LIST',
// // // // //             trailing: editable
// // // // //                 ? _addIconButton(() => _onAddSlaViolation(shift, state))
// // // // //                 : null,
// // // // //           ),
// // // // //           const SizedBox(height: 6),
// // // // //           if (slaViolations.isEmpty)
// // // // //             _emptyStateBox('No SLA violations added yet')
// // // // //           else
// // // // //             Column(
// // // // //               children: slaViolations
// // // // //                   .map((sla) => _slaViolationCard(sla))
// // // // //                   .toList(),
// // // // //             ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   // ---------------------------------------------------------------------
// // // // //   // SLA VIOLATION LIST
// // // // //   // ---------------------------------------------------------------------
// // // // //
// // // // //   Widget _slaViolationCard(ShiftSlaViolation sla) {
// // // // //     final isCollapsed = _collapsedSlaIds.contains(sla.id);
// // // // //     return Container(
// // // // //       width: double.infinity,
// // // // //       margin: const EdgeInsets.only(bottom: 10),
// // // // //       decoration: BoxDecoration(
// // // // //         borderRadius: BorderRadius.circular(8),
// // // // //         border: Border.all(color: Colors.black12),
// // // // //       ),
// // // // //       clipBehavior: Clip.antiAlias,
// // // // //       child: Column(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           InkWell(
// // // // //             onTap: () {
// // // // //               setState(() {
// // // // //                 if (isCollapsed) {
// // // // //                   _collapsedSlaIds.remove(sla.id);
// // // // //                 } else {
// // // // //                   _collapsedSlaIds.add(sla.id);
// // // // //                 }
// // // // //               });
// // // // //             },
// // // // //             child: Container(
// // // // //               width: double.infinity,
// // // // //               color: const Color(0xFF3D6DB0),
// // // // //               padding:
// // // // //               const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// // // // //               child: Row(
// // // // //                 children: [
// // // // //                   Expanded(
// // // // //                     child: Text.rich(
// // // // //                       TextSpan(
// // // // //                         children: [
// // // // //                           TextSpan(
// // // // //                             text: sla.typeOfService,
// // // // //                             style: const TextStyle(
// // // // //                               color: Colors.white,
// // // // //                               fontWeight: FontWeight.w700,
// // // // //                               fontSize: 13,
// // // // //                             ),
// // // // //                           ),
// // // // //                           TextSpan(
// // // // //                             text: '   ${sla.status}   ${sla.dateOfCreation}',
// // // // //                             style: const TextStyle(
// // // // //                               color: Colors.white70,
// // // // //                               fontWeight: FontWeight.w400,
// // // // //                               fontSize: 12,
// // // // //                             ),
// // // // //                           ),
// // // // //                         ],
// // // // //                       ),
// // // // //                       overflow: TextOverflow.ellipsis,
// // // // //                     ),
// // // // //                   ),
// // // // //                   Icon(
// // // // //                     isCollapsed
// // // // //                         ? Icons.keyboard_arrow_down
// // // // //                         : Icons.keyboard_arrow_up,
// // // // //                     color: Colors.white,
// // // // //                     size: 18,
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           if (!isCollapsed)
// // // // //             Padding(
// // // // //               padding: const EdgeInsets.all(12),
// // // // //               child: Column(
// // // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                 children: [
// // // // //                   Row(
// // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                     children: [
// // // // //                       Expanded(
// // // // //                           child: _readOnlyField(label: 'ID', value: sla.id)),
// // // // //                       const SizedBox(width: 12),
// // // // //                       Expanded(
// // // // //                           child: _readOnlyField(
// // // // //                               label: 'REGION', value: sla.region)),
// // // // //                     ],
// // // // //                   ),
// // // // //                   const SizedBox(height: 12),
// // // // //                   Row(
// // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                     children: [
// // // // //                       Expanded(
// // // // //                           child: _readOnlyField(
// // // // //                               label: 'LOCATION', value: sla.location)),
// // // // //                       const SizedBox(width: 12),
// // // // //                       Expanded(
// // // // //                           child: _readOnlyField(
// // // // //                               label: 'DATE OF CREATION',
// // // // //                               value: sla.dateOfCreation)),
// // // // //                     ],
// // // // //                   ),
// // // // //                   const SizedBox(height: 12),
// // // // //                   Row(
// // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                     children: [
// // // // //                       Expanded(
// // // // //                           child: _readOnlyField(
// // // // //                               label: 'CREATED BY', value: sla.createdBy)),
// // // // //                       const SizedBox(width: 12),
// // // // //                       Expanded(
// // // // //                           child: _readOnlyField(label: 'ASL', value: sla.asl)),
// // // // //                     ],
// // // // //                   ),
// // // // //                   const SizedBox(height: 12),
// // // // //                   Row(
// // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                     children: [
// // // // //                       Expanded(
// // // // //                           child: _readOnlyField(
// // // // //                               label: 'TYPE OF SERVICE',
// // // // //                               value: sla.typeOfService)),
// // // // //                       const SizedBox(width: 12),
// // // // //                       Expanded(
// // // // //                           child: _readOnlyField(
// // // // //                               label: 'STATUS', value: sla.status)),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget _sectionHeader(String title, {Widget? trailing}) {
// // // // //     return Row(
// // // // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //       children: [
// // // // //         Text(
// // // // //           title,
// // // // //           style: const TextStyle(
// // // // //             color: Colors.black87,
// // // // //             fontWeight: FontWeight.w700,
// // // // //             fontSize: 12,
// // // // //             letterSpacing: 0.4,
// // // // //           ),
// // // // //         ),
// // // // //         if (trailing != null) trailing,
// // // // //       ],
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget _addIconButton(VoidCallback onTap) {
// // // // //     return InkWell(
// // // // //       onTap: onTap,
// // // // //       borderRadius: BorderRadius.circular(20),
// // // // //       child: Container(
// // // // //         width: 26,
// // // // //         height: 26,
// // // // //         decoration: const BoxDecoration(
// // // // //           color: Color(0xFF5B4FCF),
// // // // //           shape: BoxShape.circle,
// // // // //         ),
// // // // //         child: const Icon(Icons.add, color: Colors.white, size: 16),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget _emptyStateBox(String message) {
// // // // //     return Container(
// // // // //       width: double.infinity,
// // // // //       padding: const EdgeInsets.symmetric(vertical: 16),
// // // // //       decoration: BoxDecoration(
// // // // //         color: Colors.grey.shade50,
// // // // //         border: Border.all(color: Colors.grey.shade300),
// // // // //         borderRadius: BorderRadius.circular(8),
// // // // //       ),
// // // // //       alignment: Alignment.center,
// // // // //       child: Text(
// // // // //         message,
// // // // //         style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget _plannedPresentRow(int planned, int present) {
// // // // //     return Text.rich(
// // // // //       TextSpan(
// // // // //         children: [
// // // // //           const TextSpan(
// // // // //             text: 'Planned: ',
// // // // //             style: TextStyle(
// // // // //                 color: Colors.black87,
// // // // //                 fontWeight: FontWeight.w700,
// // // // //                 fontSize: 13),
// // // // //           ),
// // // // //           TextSpan(
// // // // //             text: '$planned  ',
// // // // //             style: const TextStyle(
// // // // //                 color: Colors.black87,
// // // // //                 fontWeight: FontWeight.w700,
// // // // //                 fontSize: 13),
// // // // //           ),
// // // // //           const TextSpan(
// // // // //             text: 'Present: ',
// // // // //             style: TextStyle(
// // // // //                 color: Colors.black87,
// // // // //                 fontWeight: FontWeight.w700,
// // // // //                 fontSize: 13),
// // // // //           ),
// // // // //           TextSpan(
// // // // //             text: '$present',
// // // // //             style: const TextStyle(
// // // // //                 color: Colors.black87,
// // // // //                 fontWeight: FontWeight.w700,
// // // // //                 fontSize: 13),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   // ---------------------------------------------------------------------
// // // // //   // ATTENDANCE MARKING
// // // // //   // ---------------------------------------------------------------------
// // // // //   Widget _attendanceMarkingBox(Shifts shift, String shiftKey, bool editable) {
// // // // //     final attended = shift.attended ?? const <Attended>[];
// // // // //     if (attended.isEmpty) {
// // // // //       return _emptyStateBox('No guards marked attended yet');
// // // // //     }
// // // // //
// // // // //     final newlyAdded = _newlyAddedGuardIdsByShift[shiftKey] ?? const <int>{};
// // // // //
// // // // //     return Container(
// // // // //       width: double.infinity,
// // // // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// // // // //       decoration: BoxDecoration(
// // // // //         color: Colors.grey.shade50,
// // // // //         border: Border.all(color: Colors.grey.shade300),
// // // // //         borderRadius: BorderRadius.circular(8),
// // // // //       ),
// // // // //       child: Column(
// // // // //         children: attended.map((guard) {
// // // // //           final canRemove =
// // // // //               editable && guard.id != null && newlyAdded.contains(guard.id);
// // // // //           return Padding(
// // // // //             padding: const EdgeInsets.symmetric(vertical: 6),
// // // // //             child: Row(
// // // // //               children: [
// // // // //                 CircleAvatar(
// // // // //                   radius: 12,
// // // // //                   backgroundColor: const Color(0xFFEDE9FE),
// // // // //                   child: Text(
// // // // //                     (guard.name?.isNotEmpty == true)
// // // // //                         ? guard.name![0].toUpperCase()
// // // // //                         : '?',
// // // // //                     style: const TextStyle(
// // // // //                       color: Color(0xFF5B4FCF),
// // // // //                       fontWeight: FontWeight.w700,
// // // // //                       fontSize: 11,
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(width: 8),
// // // // //                 Expanded(
// // // // //                   child: Text(
// // // // //                     guard.name ?? '-',
// // // // //                     style: const TextStyle(
// // // // //                         color: Colors.black87, fontWeight: FontWeight.w600),
// // // // //                     overflow: TextOverflow.ellipsis,
// // // // //                   ),
// // // // //                 ),
// // // // //                 if (canRemove)
// // // // //                   OutlinedButton(
// // // // //                     onPressed: () =>
// // // // //                         _removeAttendedGuard(shift, shiftKey, guard),
// // // // //                     style: OutlinedButton.styleFrom(
// // // // //                       foregroundColor: Colors.red,
// // // // //                       side: const BorderSide(color: Colors.red),
// // // // //                       shape: RoundedRectangleBorder(
// // // // //                         borderRadius: BorderRadius.circular(20),
// // // // //                       ),
// // // // //                       padding: const EdgeInsets.symmetric(
// // // // //                           horizontal: 12, vertical: 2),
// // // // //                       minimumSize: const Size(0, 30),
// // // // //                     ),
// // // // //                     child: const Text('Remove',
// // // // //                         style: TextStyle(fontWeight: FontWeight.w600)),
// // // // //                   ),
// // // // //               ],
// // // // //             ),
// // // // //           );
// // // // //         }).toList(),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   // TODO: replace direct field mutation with a real cubit call, e.g.
// // // // //   // BlocProvider.of<AttendanceShiftsCubit>(context).unmarkGuardAttended(guard);
// // // // //   void _removeAttendedGuard(Shifts shift, String shiftKey, Attended guard) {
// // // // //     setState(() {
// // // // //       shift.attended?.removeWhere((a) => a.id == guard.id);
// // // // //       if (guard.id != null) {
// // // // //         _newlyAddedGuardIdsByShift[shiftKey]?.remove(guard.id);
// // // // //       }
// // // // //     });
// // // // //   }
// // // // //
// // // // //   // TODO: replace direct field mutation with a real cubit call, e.g.
// // // // //   // BlocProvider.of<AttendanceShiftsCubit>(context).markGuardAttended(guard);
// // // // //   void _addGuardToAttendance(
// // // // //       Shifts shift, String shiftKey, AvailableGuards guard) {
// // // // //     setState(() {
// // // // //       shift.attended ??= [];
// // // // //       shift.attended!.add(Attended(id: guard.id, name: guard.name));
// // // // //       if (guard.id != null) {
// // // // //         _newlyAddedGuardIdsByShift
// // // // //             .putIfAbsent(shiftKey, () => <int>{})
// // // // //             .add(guard.id!);
// // // // //       }
// // // // //     });
// // // // //   }
// // // // //
// // // // //   // ---------------------------------------------------------------------
// // // // //   // REPLACEMENTS (local-only placeholder — see TODO at top of file)
// // // // //   // ---------------------------------------------------------------------
// // // // //   Widget _replacementsBox(String shiftKey) {
// // // // //     final replacements = _replacementsByShift[shiftKey] ?? const [];
// // // // //     if (replacements.isEmpty) {
// // // // //       return _emptyStateBox('No replacements added yet');
// // // // //     }
// // // // //
// // // // //     return Container(
// // // // //       width: double.infinity,
// // // // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// // // // //       decoration: BoxDecoration(
// // // // //         color: Colors.grey.shade50,
// // // // //         border: Border.all(color: Colors.grey.shade300),
// // // // //         borderRadius: BorderRadius.circular(8),
// // // // //       ),
// // // // //       child: Column(
// // // // //         children: replacements
// // // // //             .map(
// // // // //               (r) => Padding(
// // // // //             padding: const EdgeInsets.symmetric(vertical: 6),
// // // // //             child: Row(
// // // // //               children: [
// // // // //                 Expanded(
// // // // //                   child: Text(
// // // // //                     r.replacedFor,
// // // // //                     style: const TextStyle(
// // // // //                         color: Colors.black87, fontWeight: FontWeight.w600),
// // // // //                   ),
// // // // //                 ),
// // // // //                 Expanded(
// // // // //                   child: Text(
// // // // //                     r.reason,
// // // // //                     style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
// // // // //                     overflow: TextOverflow.ellipsis,
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         )
// // // // //             .toList(),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   void _onAddSlaViolation(Shifts shift, AttendanceShiftsState state) {
// // // // //     FocusScope.of(context).unfocus();
// // // // //     _lastSubmitWasSaveOnly = true;
// // // // //     BlocProvider.of<AttendanceShiftsCubit>(context).submitForm(isSaveOnly: true);
// // // // //
// // // // //     Navigator.pushNamed(
// // // // //       context,
// // // // //       slaViolationPenaltyDetailsRoute,
// // // // //       arguments: {
// // // // //         ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
// // // // //         ConstantsArgument.attdId: state.model.id,
// // // // //         ConstantsArgument.location: widget.location,
// // // // //         ConstantsArgument.locationRegion: widget.locationRegion,
// // // // //         ConstantsArgument.vendor: widget.vendor,
// // // // //       },
// // // // //     ).then((_) {
// // // // //       if (!mounted) return;
// // // // //       BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// // // // //     });
// // // // //   }
// // // // //
// // // // //   // ---------------------------------------------------------------------
// // // // //   // Frosted confirmation dialog for Submit
// // // // //   // ---------------------------------------------------------------------
// // // // //   Widget _buildGlassDialog({
// // // // //     required String title,
// // // // //     required String message,
// // // // //     required VoidCallback onCancel,
// // // // //     required Future<void> Function() onConfirm,
// // // // //   }) {
// // // // //     return Dialog(
// // // // //       backgroundColor: Colors.transparent,
// // // // //       insetPadding: const EdgeInsets.symmetric(horizontal: 24),
// // // // //       child: ClipRRect(
// // // // //         borderRadius: BorderRadius.circular(20),
// // // // //         child: BackdropFilter(
// // // // //           filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
// // // // //           child: Container(
// // // // //             padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
// // // // //             decoration: BoxDecoration(
// // // // //               gradient: LinearGradient(
// // // // //                 colors: [
// // // // //                   Colors.white.withValues(alpha: 0.02),
// // // // //                   Colors.white.withValues(alpha: 0.04),
// // // // //                 ],
// // // // //                 begin: Alignment.topLeft,
// // // // //                 end: Alignment.bottomRight,
// // // // //               ),
// // // // //               borderRadius: BorderRadius.circular(20),
// // // // //               border: Border.all(
// // // // //                 color: Colors.white.withValues(alpha: 0.55),
// // // // //                 width: 1,
// // // // //               ),
// // // // //               boxShadow: [
// // // // //                 BoxShadow(
// // // // //                   color: Colors.black.withValues(alpha: 0.04),
// // // // //                   blurRadius: 20,
// // // // //                   offset: const Offset(0, 8),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //             child: Column(
// // // // //               mainAxisSize: MainAxisSize.min,
// // // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // // //               children: [
// // // // //                 Text(
// // // // //                   title,
// // // // //                   style: const TextStyle(
// // // // //                     color: Colors.white,
// // // // //                     fontSize: 17,
// // // // //                     fontWeight: FontWeight.w700,
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(height: 12),
// // // // //                 Text(
// // // // //                   message,
// // // // //                   style: TextStyle(
// // // // //                     color: Colors.white.withValues(alpha: 0.85),
// // // // //                     fontSize: 14,
// // // // //                     height: 1.4,
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(height: 20),
// // // // //                 Row(
// // // // //                   mainAxisAlignment: MainAxisAlignment.end,
// // // // //                   children: [
// // // // //                     TextButton(
// // // // //                       onPressed: onCancel,
// // // // //                       style: TextButton.styleFrom(
// // // // //                         foregroundColor: Colors.white.withValues(alpha: 0.8),
// // // // //                       ),
// // // // //                       child: const Text(Constants.cancel),
// // // // //                     ),
// // // // //                     const SizedBox(width: 8),
// // // // //                     TextButton(
// // // // //                       onPressed: onConfirm,
// // // // //                       style: TextButton.styleFrom(
// // // // //                         foregroundColor: Colors.white,
// // // // //                         backgroundColor: Colors.white.withValues(alpha: 0.12),
// // // // //                         shape: RoundedRectangleBorder(
// // // // //                           borderRadius: BorderRadius.circular(10),
// // // // //                         ),
// // // // //                         padding: const EdgeInsets.symmetric(
// // // // //                           horizontal: 16,
// // // // //                           vertical: 10,
// // // // //                         ),
// // // // //                       ),
// // // // //                       child: const Text(Constants.ok),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   void showReplacementPopUp({
// // // // //     required BuildContext context,
// // // // //     required Replacement model,
// // // // //     required Set<BaseUser> selectedGuards,
// // // // //     required AttendanceShiftsState state,
// // // // //     required int rankId,
// // // // //     required int shiftId,
// // // // //     required int dutyPostId,
// // // // //     required int attendanceId,
// // // // //   }) {
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (BuildContext dialogContext) {
// // // // //         return AddReplacementPopUp(
// // // // //           viaAttendance: true,
// // // // //           model: model,
// // // // //           mainContext: context,
// // // // //           selectedGuards: selectedGuards,
// // // // //           attendanceModel: state.model,
// // // // //           shiftId: shiftId,
// // // // //           rankId: rankId,
// // // // //           dutyPostId: dutyPostId,
// // // // //           attendanceId: attendanceId,
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }
// // // // // }
// // // // // NOTE: the large commented-out block that used to sit above this class
// // // // // (the old ShiftModel/rank-shift-dropdown version of this screen) has been
// // // // // removed for clarity — it is not compiled and was not touched by this fix.
// // // // // If you need it back, restore it from your previous version of this file.
// // // //
// // // // import 'dart:ui';
// // // //
// // // // import 'package:db_atom/index.dart';
// // // //
// // // // import '../../attendance_details/views/attendance_details_view.dart';
// // // // import '../../models/dutyPost_attendance_model.dart';
// // // //
// // // // class AttendanceShiftsView extends StatefulWidget {
// // // //   const AttendanceShiftsView({
// // // //     super.key,
// // // //     required this.location,
// // // //     required this.locationRegion,
// // // //     required this.vendor,
// // // //     required this.attInfoId,
// // // //     required this.selectedDutyPostModel,
// // // //     required this.isReadOnly,
// // // //     required this.isEligibleToEdit,
// // // //   });
// // // //
// // // //   final Organisation location;
// // // //   final Organisation locationRegion;
// // // //   final Organisation vendor;
// // // //   final int attInfoId;
// // // //   final DutyPostModel selectedDutyPostModel;
// // // //   final bool isReadOnly;
// // // //   final bool isEligibleToEdit;
// // // //
// // // //   @override
// // // //   AttendanceShiftsViewState createState() => AttendanceShiftsViewState();
// // // // }
// // // //
// // // // /// Minimal local-only stand-in for a shift-level replacement until the
// // // // /// real `Replacement` model / service is wired to this screen.
// // // // class _LocalReplacementDraft {
// // // //   _LocalReplacementDraft({required this.replacedFor, required this.reason});
// // // //
// // // //   final String replacedFor;
// // // //   final String reason;
// // // // }
// // // //
// // // // class ShiftSlaViolation {
// // // //   final String id;
// // // //   final String region;
// // // //   final String location;
// // // //   final String dateOfCreation;
// // // //   final String createdBy;
// // // //   final String asl;
// // // //   final String typeOfService;
// // // //   final String status;
// // // //
// // // //   ShiftSlaViolation({
// // // //     required this.id,
// // // //     required this.region,
// // // //     required this.location,
// // // //     required this.dateOfCreation,
// // // //     required this.createdBy,
// // // //     required this.asl,
// // // //     required this.typeOfService,
// // // //     required this.status,
// // // //   });
// // // // }
// // // //
// // // // Widget _readOnlyField({required String label, required String value}) {
// // // //   return Column(
// // // //     crossAxisAlignment: CrossAxisAlignment.start,
// // // //     children: [
// // // //       Text(
// // // //         label,
// // // //         style: const TextStyle(
// // // //           color: Colors.black,
// // // //           fontSize: 11,
// // // //           fontWeight: FontWeight.w700,
// // // //           letterSpacing: 0.5,
// // // //         ),
// // // //       ),
// // // //       const SizedBox(height: 6),
// // // //       Container(
// // // //         width: double.infinity,
// // // //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
// // // //         decoration: BoxDecoration(
// // // //           color: Colors.white.withValues(alpha: 0.9),
// // // //           borderRadius: BorderRadius.circular(6),
// // // //           border: Border.all(color: const Color(0xFF3D6DB0)),
// // // //         ),
// // // //         child: Text(
// // // //           value,
// // // //           style: const TextStyle(color: Colors.black87),
// // // //         ),
// // // //       ),
// // // //     ],
// // // //   );
// // // // }
// // // //
// // // // class AttendanceShiftsViewState extends State<AttendanceShiftsView> {
// // // //   bool isReadOnly = false;
// // // //
// // // //   // Accordion expand/collapse state — duty posts & ranks start expanded;
// // // //   // a key only ever lands in these sets once the user *collapses* it.
// // // //   final Set<String> _collapsedDutyPostKeys = {};
// // // //   final Set<String> _collapsedRankKeys = {};
// // // //
// // // //   // Tracks which guard ids were added to a shift's attendance *in this
// // // //   // session*, so only those rows show a "Remove" button — guards already
// // // //   // attended before the screen opened stay locked. Keyed by `_shiftKey`.
// // // //   final Map<String, Set<int>> _newlyAddedGuardIdsByShift = {};
// // // //
// // // //   // Local-only placeholder — see TODO at the top of this file.
// // // //   final Map<String, List<_LocalReplacementDraft>> _replacementsByShift = {};
// // // //
// // // //
// // // //   bool _lastSubmitWasSaveOnly = false;
// // // //
// // // //   // Card accent palette cycled per shift position within a rank, matching
// // // //   // the orange / blue / red / green top borders in the reference design.
// // // //   static const List<Color> _shiftAccentColors = [
// // // //     Color(0xFFF5A623), // orange
// // // //     Color(0xFF3D6DB0), // blue
// // // //     Color(0xFFD64545), // red
// // // //     Color(0xFF3FB65D), // green
// // // //   ];
// // // //
// // // //   final Set<String> _collapsedSlaIds = {};
// // // //
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final size = MediaQuery.of(context).size;
// // // //     final height = size.height;
// // // //
// // // //     return BlocConsumer<AttendanceShiftsCubit, AttendanceShiftsState>(
// // // //       listener: (context, state) {
// // // //         Utils().formError(state, context);
// // // //         Utils().errorAndLogout(state, context);
// // // //
// // // //         if (state.status == FormStatus.success) {
// // // //           var dialog = CustomAlertDialog(
// // // //             title: 'Attendance',
// // // //             message: state.message ?? '',
// // // //             positiveBtnText: Constants.ok,
// // // //             onPositivePressed: () {
// // // //               Navigator.pop(context);
// // // //               Navigator.pop(context);
// // // //               Navigator.popAndPushNamed(
// // // //                 context,
// // // //                 attendanceListRoute,
// // // //                 arguments: {},
// // // //               );
// // // //             },
// // // //           );
// // // //           showDialog(
// // // //               context: context,
// // // //               barrierDismissible: false,
// // // //               builder: (BuildContext context) => dialog);
// // // //
// // // //           // Utils.dynamicAlert(
// // // //           //     context, state.message ?? '', 'Material Movement', '');
// // // //         }
// // // //       },
// // // //       builder: (context, state) {
// // // //         isReadOnly = widget.isReadOnly ||
// // // //             !widget.isEligibleToEdit ||
// // // //             !state.model.lock.isEmptyOrNull;
// // // //
// // // //         return Scaffold(
// // // //           backgroundColor: Colors.transparent,
// // // //           extendBodyBehindAppBar: true,
// // // //           appBar: BaseAppBar().buildAppHeader(
// // // //             context: context,
// // // //             title: 'Attendance',
// // // //             showPopUp: false,
// // // //             showSaveButton: false,
// // // //             showSubmitButton: !isReadOnly && state.status != FormStatus.loading,
// // // //             showDisLikeButton: false,
// // // //             showLikeButton: false,
// // // //             popAndReplace: () {
// // // //               int flag = AttendanceDetailsView.flag;
// // // //               if (flag == 1) {
// // // //                 Navigator.pop(context);
// // // //               } else {
// // // //                 Navigator.pop(context);
// // // //                 // Navigator.pop(context);
// // // //                 // Navigator.pop(context);
// // // //               }
// // // //             },
// // // //             onTapSubmit: () {
// // // //               FocusScope.of(context).unfocus();
// // // //               BlocProvider.of<AttendanceShiftsCubit>(context)
// // // //                   .submitForm(isSaveOnly: false);
// // // //             },
// // // //           ),
// // // //
// // // //           // ================= BODY WITH BACKGROUND =================
// // // //           body: Stack(
// // // //             children: [
// // // //               Positioned.fill(
// // // //                 child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
// // // //               ),
// // // //               Positioned.fill(
// // // //                 child: BackdropFilter(
// // // //                   filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
// // // //                   child: Container(color: Colors.black.withValues(alpha: 0.15)),
// // // //                 ),
// // // //               ),
// // // //               Positioned.fill(
// // // //                 child: MediaQuery.removePadding(
// // // //                   context: context,
// // // //                   removeTop: true,
// // // //                   child: Padding(
// // // //                     padding: const EdgeInsets.all(20),
// // // //                     child: SingleChildScrollView(
// // // //                       child: Column(
// // // //                         children: [
// // // //                           SizedBox(
// // // //                             height: kToolbarHeight +
// // // //                                 MediaQuery.of(context).padding.top,
// // // //                           ),
// // // //                           getBody(state, height),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------
// // // //   // BODY
// // // //   // ---------------------------------------------------------------------
// // // //   Widget getBody(AttendanceShiftsState state, double height) {
// // // //     if (state.status == FormStatus.loading) {
// // // //       return const BaseLoader();
// // // //     }
// // // //
// // // //     final dutyPosts = state.dutyPostAttendanceModel?.dutyPosts ?? const <DutyPosts>[];
// // // //
// // // //     return Column(
// // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // //       children: [
// // // //         if (!state.model.lock.isEmptyOrNull) ...[
// // // //           RecordLockedWidget(text: '${state.model.lock}'),
// // // //           CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //         ],
// // // //         if (dutyPosts.isEmpty)
// // // //           const Padding(
// // // //             padding: EdgeInsets.symmetric(vertical: 24),
// // // //             child: Text(
// // // //               'No duty posts found for this attendance record.',
// // // //               style: Styles.textStyleWhite16,
// // // //             ),
// // // //           )
// // // //         else
// // // //           for (final dutyPost in dutyPosts) ...[
// // // //             _buildDutyPostAccordion(dutyPost, height, state),
// // // //             CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //           ],
// // // //       ],
// // // //     );
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------
// // // //   // DUTY POST ACCORDION  (e.g. "Basement")
// // // //   // ---------------------------------------------------------------------
// // // //   Widget _buildDutyPostAccordion(
// // // //       DutyPosts dutyPost, double height, AttendanceShiftsState state) {
// // // //     final key = 'dutypost_${dutyPost.dutyPostNameId}_${dutyPost.dutyPostName}';
// // // //     final isExpanded = !_collapsedDutyPostKeys.contains(key);
// // // //     final label = dutyPost.dutyPostName ?? '-';
// // // //
// // // //     return Container(
// // // //       width: double.infinity,
// // // //       decoration: BoxDecoration(
// // // //         border: Border.all(color: const Color(0xFF5B4FCF)),
// // // //         borderRadius: BorderRadius.circular(8),
// // // //         color: Colors.white.withValues(alpha: 0.04),
// // // //       ),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           _accordionHeader(
// // // //             avatarText: label.isNotEmpty ? label[0].toUpperCase() : '?',
// // // //             title: label,
// // // //             isExpanded: isExpanded,
// // // //             onTap: () => setState(() {
// // // //               if (isExpanded) {
// // // //                 _collapsedDutyPostKeys.add(key);
// // // //               } else {
// // // //                 _collapsedDutyPostKeys.remove(key);
// // // //               }
// // // //             }),
// // // //           ),
// // // //           if (isExpanded)
// // // //             Padding(
// // // //               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
// // // //               child: Column(
// // // //                 children: [
// // // //                   for (final rank in dutyPost.ranks ?? const <Ranks>[]) ...[
// // // //                     // FIX: dutyPostNameId is only known at this level of
// // // //                     // the tree, so it now gets threaded down through
// // // //                     // rank -> shift-grid -> shift-card, all the way to
// // // //                     // where the "Add Replacement" button needs it.
// // // //                     _buildRankAccordion(
// // // //                       rank,
// // // //                       height,
// // // //                       state,
// // // //                       dutyPost.dutyPostNameId,
// // // //                     ),
// // // //                     const SizedBox(height: 10),
// // // //                   ],
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------
// // // //   // RANK ACCORDION  (e.g. "RANK: SECURITY GUARD/LADY SECURITY GUARD")
// // // //   // ---------------------------------------------------------------------
// // // //   Widget _buildRankAccordion(Ranks rank, double height,
// // // //       AttendanceShiftsState state, int? dutyPostId) {
// // // //     final key = 'rank_${rank.rankId}_${rank.rankName}';
// // // //     final isExpanded = !_collapsedRankKeys.contains(key);
// // // //     final title = 'RANK: ${(rank.rankName ?? '-').toUpperCase()}';
// // // //
// // // //     return Container(
// // // //       width: double.infinity,
// // // //       decoration: BoxDecoration(
// // // //         border: Border.all(color: const Color(0xFF5B4FCF)),
// // // //         borderRadius: BorderRadius.circular(8),
// // // //         color: Colors.white.withValues(alpha: 0.01),
// // // //       ),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           _accordionHeader(
// // // //             avatarText: _initialsFor(rank.rankName ?? ''),
// // // //             title: title,
// // // //             isExpanded: isExpanded,
// // // //             onTap: () => setState(() {
// // // //               if (isExpanded) {
// // // //                 _collapsedRankKeys.add(key);
// // // //               } else {
// // // //                 _collapsedRankKeys.remove(key);
// // // //               }
// // // //             }),
// // // //           ),
// // // //           if (isExpanded)
// // // //             Padding(
// // // //               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
// // // //               child: _buildShiftCardsGrid(
// // // //                 rank.shifts ?? const <Shifts>[],
// // // //                 height,
// // // //                 state,
// // // //                 dutyPostId,
// // // //                 rank.rankId,
// // // //               ),
// // // //             ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   String _initialsFor(String label) {
// // // //     final words = label.trim().split(RegExp(r'\s+'));
// // // //     if (words.isEmpty || words.first.isEmpty) return '?';
// // // //     return words
// // // //         .take(2)
// // // //         .map((w) => w.isNotEmpty ? w[0] : '')
// // // //         .join()
// // // //         .toUpperCase();
// // // //   }
// // // //
// // // //   Widget _accordionHeader({
// // // //     required String avatarText,
// // // //     required String title,
// // // //     required bool isExpanded,
// // // //     required VoidCallback onTap,
// // // //   }) {
// // // //     return InkWell(
// // // //       onTap: onTap,
// // // //       child: Container(
// // // //         width: double.infinity,
// // // //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// // // //         child: Row(
// // // //           children: [
// // // //             CircleAvatar(
// // // //               radius: 12,
// // // //               backgroundColor: Colors.white24,
// // // //               child: Text(
// // // //                 avatarText,
// // // //                 style: const TextStyle(color: Colors.white, fontSize: 10),
// // // //               ),
// // // //             ),
// // // //             const SizedBox(width: 8),
// // // //             Expanded(
// // // //               child: Text(
// // // //                 title,
// // // //                 style: const TextStyle(
// // // //                   color: Colors.white,
// // // //                   fontWeight: FontWeight.w700,
// // // //                   fontSize: 13,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             Icon(
// // // //               isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
// // // //               color: Colors.white70,
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------
// // // //   // SHIFT CARDS GRID  (Shift A / B / C / G laid out 2-up, like the ref)
// // // //   // ---------------------------------------------------------------------
// // // //   Widget _buildShiftCardsGrid(
// // // //       List<Shifts> shifts,
// // // //       double height,
// // // //       AttendanceShiftsState state,
// // // //       int? dutyPostId,
// // // //       int? rankId,
// // // //       ) {
// // // //     if (shifts.isEmpty) {
// // // //       return const Padding(
// // // //         padding: EdgeInsets.symmetric(vertical: 12),
// // // //         child: Text(
// // // //           'No shifts under this rank.',
// // // //           style: Styles.textStyleWhite16,
// // // //         ),
// // // //       );
// // // //     }
// // // //
// // // //     final width = MediaQuery.of(context).size.width;
// // // //     final isTablet = width > Constants.tabletScreenWidth;
// // // //     // Two columns on tablet/desktop widths, single column on phones —
// // // //     // matches the 2-up grid in the reference screenshot.
// // // //     final cardWidth = isTablet ? (width - 60) / 2 : width - 40;
// // // //
// // // //     return Wrap(
// // // //       spacing: 12,
// // // //       runSpacing: 12,
// // // //       children: [
// // // //         for (var i = 0; i < shifts.length; i++)
// // // //           SizedBox(
// // // //             width: cardWidth,
// // // //             child: _buildShiftCard(
// // // //               shifts[i],
// // // //               i,
// // // //               height,
// // // //               state,
// // // //               dutyPostId,
// // // //               rankId,
// // // //             ),
// // // //           ),
// // // //       ],
// // // //     );
// // // //   }
// // // //
// // // //   String _shiftKey(Shifts shift) =>
// // // //       'shift_${shift.attendanceShiftId ?? shift.shiftId}';
// // // //
// // // //   String _timeRangeForShift(String? shiftLabel) {
// // // //     final normalized = (shiftLabel ?? '').toLowerCase().trim();
// // // //     if (normalized == 'a') return '7AM - 3PM';
// // // //     if (normalized == 'b') return '3PM - 11PM';
// // // //     if (normalized == 'c') return '11PM - 7AM';
// // // //     if (normalized == 'g') return '9AM - 6PM';
// // // //     return '-';
// // // //   }
// // // //
// // // //   Set<BaseUser> _selectableReplacementGuards(Shifts shift) {
// // // //     return (shift.selectForReplacements ?? const <SelectForReplacements>[])
// // // //         .map((g) => BaseUser(id: g.id, name: g.name))
// // // //         .toSet();
// // // //   }
// // // //
// // // //    List<ShiftSlaViolation> _parseSlaViolations(
// // // //       List<dynamic>? violations, String fallbackStatus) {
// // // //     return (violations ?? const []).map((v) {
// // // //       if (v is Map) {
// // // //         final location = v['location'] as Map?;
// // // //         final locationRegion = v['locationRegion'] as Map?;
// // // //         final entrySecurity = v['entrySecurity'] as Map?;
// // // //         final approver = v['approver'] as Map?;
// // // //         final typeOfServiceList = v['typeOfService'] as List?;
// // // //
// // // //         String fullName(Map? user) {
// // // //           if (user == null) return '-';
// // // //           final userInfo = user['userInfo'] as String?;
// // // //           if (userInfo != null && userInfo.isNotEmpty) return userInfo;
// // // //           final first = user['firstName'] as String? ?? '';
// // // //           final last = user['lastName'] as String? ?? '';
// // // //           final combined = '$first $last'.trim();
// // // //           return combined.isNotEmpty ? combined : '-';
// // // //         }
// // // //
// // // //         String formatEpochMs(dynamic epochMs) {
// // // //           if (epochMs == null) return '-';
// // // //           final millis = epochMs is int ? epochMs : int.tryParse('$epochMs');
// // // //           if (millis == null) return '-';
// // // //           final date = DateTime.fromMillisecondsSinceEpoch(millis);
// // // //           return '${date.day.toString().padLeft(2, '0')}/'
// // // //               '${date.month.toString().padLeft(2, '0')}/'
// // // //               '${date.year} ${date.hour.toString().padLeft(2, '0')}:'
// // // //               '${date.minute.toString().padLeft(2, '0')}';
// // // //         }
// // // //
// // // //         return ShiftSlaViolation(
// // // //           id: '${v['id'] ?? v['slNo'] ?? '-'}',
// // // //           region: locationRegion?['name'] as String? ?? '-',
// // // //           location: location?['name'] as String? ?? '-',
// // // //           dateOfCreation: formatEpochMs(v['inputDate']),
// // // //           createdBy: fullName(entrySecurity),
// // // //           asl: fullName(approver),
// // // //           typeOfService: (typeOfServiceList ?? const [])
// // // //               .map((t) => (t as Map?)?['name'] as String? ?? '')
// // // //               .where((s) => s.isNotEmpty)
// // // //               .join(', '),
// // // //           status: v['statusLabel'] as String? ?? fallbackStatus,
// // // //         );
// // // //       }
// // // //       return ShiftSlaViolation(
// // // //         id: '-',
// // // //         region: '-',
// // // //         location: '-',
// // // //         dateOfCreation: '-',
// // // //         createdBy: '-',
// // // //         asl: '-',
// // // //         typeOfService: '',
// // // //         status: fallbackStatus,
// // // //       );
// // // //     }).toList();
// // // //   }
// // // //
// // // //   Widget _buildShiftCard(
// // // //       Shifts shift,
// // // //       int index,
// // // //       double height,
// // // //       AttendanceShiftsState state,
// // // //       int? dutyPostId,
// // // //       int? rankId,
// // // //       ) {
// // // //     final accent = _shiftAccentColors[index % _shiftAccentColors.length];
// // // //     final isActive = shift.activeShift == true;
// // // //     final statusLabel = isActive ? 'Active' : 'Draft';
// // // //     final statusColor =
// // // //     isActive ? const Color(0xFF3FB65D) : const Color(0xFFF5A623);
// // // //
// // // //     final planned = shift.allowed ?? 0;
// // // //     final present = shift.attended?.length ?? 0;
// // // //
// // // //     final shiftKey = _shiftKey(shift);
// // // //     // FIX: this is the id `showReplacementPopUp` needs — previously the
// // // //     // call site referenced an undefined `shiftId` variable. It's the
// // // //     // same id `_shiftKey` already derives the shift from.
// // // //     final shiftId = shift.attendanceShiftId ?? shift.shiftId;
// // // //     final editable = !isReadOnly;
// // // //
// // // //     // See CAVEAT on `_parseSlaViolations` re: the assumed `violations` field.
// // // //     final slaViolations = _parseSlaViolations(shift.slaViolations, statusLabel);
// // // //
// // // //     return Container(
// // // //       decoration: BoxDecoration(
// // // //         border: Border(top: BorderSide(color: accent, width: 3)),
// // // //         color: Colors.white.withValues(alpha: 0.92),
// // // //         borderRadius: BorderRadius.circular(10),
// // // //         boxShadow: [
// // // //           BoxShadow(
// // // //             color: Colors.black.withValues(alpha: 0.06),
// // // //             blurRadius: 8,
// // // //             offset: const Offset(0, 3),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       padding: const EdgeInsets.all(14),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           // Header: avatar + "SHIFT X / time range" + status badge
// // // //           Row(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             children: [
// // // //               Container(
// // // //                 width: 26,
// // // //                 height: 26,
// // // //                 alignment: Alignment.center,
// // // //                 decoration: BoxDecoration(
// // // //                   color: accent.withValues(alpha: 0.15),
// // // //                   borderRadius: BorderRadius.circular(6),
// // // //                 ),
// // // //                 child: Text(
// // // //                   (shift.shift ?? '?').toUpperCase(),
// // // //                   style: TextStyle(
// // // //                     color: accent,
// // // //                     fontWeight: FontWeight.w700,
// // // //                     fontSize: 12,
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(width: 10),
// // // //               Expanded(
// // // //                 child: Column(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     Text(
// // // //                       'SHIFT ${(shift.shift ?? '-').toUpperCase()}',
// // // //                       style: const TextStyle(
// // // //                         color: Colors.black45,
// // // //                         fontWeight: FontWeight.w700,
// // // //                         fontSize: 11,
// // // //                         letterSpacing: 0.5,
// // // //                       ),
// // // //                     ),
// // // //                     Text(
// // // //                       _timeRangeForShift(shift.shift),
// // // //                       style: const TextStyle(
// // // //                         color: Colors.black87,
// // // //                         fontWeight: FontWeight.w700,
// // // //                         fontSize: 14,
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               Row(
// // // //                 children: [
// // // //                   Container(
// // // //                     width: 8,
// // // //                     height: 8,
// // // //                     decoration:
// // // //                     BoxDecoration(color: statusColor, shape: BoxShape.circle),
// // // //                   ),
// // // //                   const SizedBox(width: 4),
// // // //                   Text(
// // // //                     statusLabel,
// // // //                     style: const TextStyle(
// // // //                       color: Colors.black87,
// // // //                       fontWeight: FontWeight.w600,
// // // //                       fontSize: 12,
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           CommonWidgets.verticalSpacerWidget(height * 0.012),
// // // //
// // // //           _plannedPresentRow(planned, present),
// // // //           CommonWidgets.verticalSpacerWidget(height * 0.012),
// // // //
// // // //           // ATTENDANCE MARKING
// // // //           _sectionHeader(
// // // //             'ATTENDANCE MARKING',
// // // //             trailing: null,
// // // //           ),
// // // //           const SizedBox(height: 6),
// // // //           _attendanceMarkingBox(shift, shiftKey, editable),
// // // //           const SizedBox(height: 12),
// // // //
// // // //           // REPLACEMENTS — only shown for active shifts, matching Shift A
// // // //           // / Shift G in the reference (Shift B / C don't show it).
// // // //           if (isActive) ...[
// // // //             _sectionHeader(
// // // //               'REPLACEMENTS',
// // // //                trailing: editable
// // // //                   ? _addIconButton(() {
// // // //                 if (dutyPostId == null || rankId == null || shiftId == null) {
// // // //                   Validator().showToast(
// // // //                     context,
// // // //                     'Please select a valid duty post, rank and shift '
// // // //                         'before adding a replacement.',
// // // //                   );
// // // //                   return;
// // // //                 }
// // // //
// // // //                 showReplacementPopUp(
// // // //                   context: context,
// // // //                   model: Replacement(),
// // // //                   selectedGuards: _selectableReplacementGuards(shift),
// // // //                   state: state,
// // // //                   rankId: rankId,
// // // //                   shiftId: shiftId,
// // // //                   dutyPostId: dutyPostId,
// // // //                   attendanceId: widget.attInfoId,
// // // //                 );
// // // //               })
// // // //                   : null,
// // // //             ),
// // // //             const SizedBox(height: 6),
// // // //             _replacementsBox(shiftKey),
// // // //             const SizedBox(height: 12),
// // // //           ],
// // // //
// // // //           // SLA VIOLATION LIST
// // // //           _sectionHeader(
// // // //             'SLA VIOLATION LIST',
// // // //             trailing: editable
// // // //                 ? _addIconButton(() => _onAddSlaViolation(shift, state))
// // // //                 : null,
// // // //           ),
// // // //           const SizedBox(height: 6),
// // // //           if (slaViolations.isEmpty)
// // // //             _emptyStateBox('No SLA violations added yet')
// // // //           else
// // // //             Column(
// // // //               children: slaViolations
// // // //                   .map((sla) => _slaViolationCard(sla))
// // // //                   .toList(),
// // // //             ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------
// // // //   // SLA VIOLATION LIST
// // // //   // ---------------------------------------------------------------------
// // // //
// // // //   Widget _slaViolationCard(ShiftSlaViolation sla) {
// // // //     final isCollapsed = _collapsedSlaIds.contains(sla.id);
// // // //     return Container(
// // // //       width: double.infinity,
// // // //       margin: const EdgeInsets.only(bottom: 10),
// // // //       decoration: BoxDecoration(
// // // //         borderRadius: BorderRadius.circular(8),
// // // //         border: Border.all(color: Colors.black12),
// // // //       ),
// // // //       clipBehavior: Clip.antiAlias,
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           InkWell(
// // // //             onTap: () {
// // // //               setState(() {
// // // //                 if (isCollapsed) {
// // // //                   _collapsedSlaIds.remove(sla.id);
// // // //                 } else {
// // // //                   _collapsedSlaIds.add(sla.id);
// // // //                 }
// // // //               });
// // // //             },
// // // //             child: Container(
// // // //               width: double.infinity,
// // // //               color: const Color(0xFF3D6DB0),
// // // //               padding:
// // // //               const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// // // //               child: Row(
// // // //                 children: [
// // // //                   Expanded(
// // // //                     child: Text.rich(
// // // //                       TextSpan(
// // // //                         children: [
// // // //                           TextSpan(
// // // //                             text: sla.typeOfService,
// // // //                             style: const TextStyle(
// // // //                               color: Colors.white,
// // // //                               fontWeight: FontWeight.w700,
// // // //                               fontSize: 13,
// // // //                             ),
// // // //                           ),
// // // //                           TextSpan(
// // // //                             text: '   ${sla.status}   ${sla.dateOfCreation}',
// // // //                             style: const TextStyle(
// // // //                               color: Colors.white70,
// // // //                               fontWeight: FontWeight.w400,
// // // //                               fontSize: 12,
// // // //                             ),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                       overflow: TextOverflow.ellipsis,
// // // //                     ),
// // // //                   ),
// // // //                   Icon(
// // // //                     isCollapsed
// // // //                         ? Icons.keyboard_arrow_down
// // // //                         : Icons.keyboard_arrow_up,
// // // //                     color: Colors.white,
// // // //                     size: 18,
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           if (!isCollapsed)
// // // //             Padding(
// // // //               padding: const EdgeInsets.all(12),
// // // //               child: Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // // //                 children: [
// // // //                   Row(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       Expanded(
// // // //                           child: _readOnlyField(label: 'ID', value: sla.id)),
// // // //                       const SizedBox(width: 12),
// // // //                       Expanded(
// // // //                           child: _readOnlyField(
// // // //                               label: 'REGION', value: sla.region)),
// // // //                     ],
// // // //                   ),
// // // //                   const SizedBox(height: 12),
// // // //                   Row(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       Expanded(
// // // //                           child: _readOnlyField(
// // // //                               label: 'LOCATION', value: sla.location)),
// // // //                       const SizedBox(width: 12),
// // // //                       Expanded(
// // // //                           child: _readOnlyField(
// // // //                               label: 'DATE OF CREATION',
// // // //                               value: sla.dateOfCreation)),
// // // //                     ],
// // // //                   ),
// // // //                   const SizedBox(height: 12),
// // // //                   Row(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       Expanded(
// // // //                           child: _readOnlyField(
// // // //                               label: 'CREATED BY', value: sla.createdBy)),
// // // //                       const SizedBox(width: 12),
// // // //                       Expanded(
// // // //                           child: _readOnlyField(label: 'ASL', value: sla.asl)),
// // // //                     ],
// // // //                   ),
// // // //                   const SizedBox(height: 12),
// // // //                   Row(
// // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                     children: [
// // // //                       Expanded(
// // // //                           child: _readOnlyField(
// // // //                               label: 'TYPE OF SERVICE',
// // // //                               value: sla.typeOfService)),
// // // //                       const SizedBox(width: 12),
// // // //                       Expanded(
// // // //                           child: _readOnlyField(
// // // //                               label: 'STATUS', value: sla.status)),
// // // //                     ],
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _sectionHeader(String title, {Widget? trailing}) {
// // // //     return Row(
// // // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //       children: [
// // // //         Text(
// // // //           title,
// // // //           style: const TextStyle(
// // // //             color: Colors.black87,
// // // //             fontWeight: FontWeight.w700,
// // // //             fontSize: 12,
// // // //             letterSpacing: 0.4,
// // // //           ),
// // // //         ),
// // // //         if (trailing != null) trailing,
// // // //       ],
// // // //     );
// // // //   }
// // // //
// // // //   Widget _addIconButton(VoidCallback onTap) {
// // // //     return InkWell(
// // // //       onTap: onTap,
// // // //       borderRadius: BorderRadius.circular(20),
// // // //       child: Container(
// // // //         width: 26,
// // // //         height: 26,
// // // //         decoration: const BoxDecoration(
// // // //           color: Color(0xFF5B4FCF),
// // // //           shape: BoxShape.circle,
// // // //         ),
// // // //         child: const Icon(Icons.add, color: Colors.white, size: 16),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _emptyStateBox(String message) {
// // // //     return Container(
// // // //       width: double.infinity,
// // // //       padding: const EdgeInsets.symmetric(vertical: 16),
// // // //       decoration: BoxDecoration(
// // // //         color: Colors.grey.shade50,
// // // //         border: Border.all(color: Colors.grey.shade300),
// // // //         borderRadius: BorderRadius.circular(8),
// // // //       ),
// // // //       alignment: Alignment.center,
// // // //       child: Text(
// // // //         message,
// // // //         style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _plannedPresentRow(int planned, int present) {
// // // //     return Text.rich(
// // // //       TextSpan(
// // // //         children: [
// // // //           const TextSpan(
// // // //             text: 'Planned: ',
// // // //             style: TextStyle(
// // // //                 color: Colors.black87,
// // // //                 fontWeight: FontWeight.w700,
// // // //                 fontSize: 13),
// // // //           ),
// // // //           TextSpan(
// // // //             text: '$planned  ',
// // // //             style: const TextStyle(
// // // //                 color: Colors.black87,
// // // //                 fontWeight: FontWeight.w700,
// // // //                 fontSize: 13),
// // // //           ),
// // // //           const TextSpan(
// // // //             text: 'Present: ',
// // // //             style: TextStyle(
// // // //                 color: Colors.black87,
// // // //                 fontWeight: FontWeight.w700,
// // // //                 fontSize: 13),
// // // //           ),
// // // //           TextSpan(
// // // //             text: '$present',
// // // //             style: const TextStyle(
// // // //                 color: Colors.black87,
// // // //                 fontWeight: FontWeight.w700,
// // // //                 fontSize: 13),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------
// // // //   // ATTENDANCE MARKING
// // // //   // ---------------------------------------------------------------------
// // // //   Widget _attendanceMarkingBox(Shifts shift, String shiftKey, bool editable) {
// // // //     final attended = shift.attended ?? const <Attended>[];
// // // //     if (attended.isEmpty) {
// // // //       return _emptyStateBox('No guards marked attended yet');
// // // //     }
// // // //
// // // //     final newlyAdded = _newlyAddedGuardIdsByShift[shiftKey] ?? const <int>{};
// // // //
// // // //     return Container(
// // // //       width: double.infinity,
// // // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// // // //       decoration: BoxDecoration(
// // // //         color: Colors.grey.shade50,
// // // //         border: Border.all(color: Colors.grey.shade300),
// // // //         borderRadius: BorderRadius.circular(8),
// // // //       ),
// // // //       child: Column(
// // // //         children: attended.map((guard) {
// // // //           final canRemove =
// // // //               editable && guard.id != null && newlyAdded.contains(guard.id);
// // // //           return Padding(
// // // //             padding: const EdgeInsets.symmetric(vertical: 6),
// // // //             child: Row(
// // // //               children: [
// // // //                 CircleAvatar(
// // // //                   radius: 12,
// // // //                   backgroundColor: const Color(0xFFEDE9FE),
// // // //                   child: Text(
// // // //                     (guard.name?.isNotEmpty == true)
// // // //                         ? guard.name![0].toUpperCase()
// // // //                         : '?',
// // // //                     style: const TextStyle(
// // // //                       color: Color(0xFF5B4FCF),
// // // //                       fontWeight: FontWeight.w700,
// // // //                       fontSize: 11,
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //                 const SizedBox(width: 8),
// // // //                 Expanded(
// // // //                   child: Text(
// // // //                     guard.name ?? '-',
// // // //                     style: const TextStyle(
// // // //                         color: Colors.black87, fontWeight: FontWeight.w600),
// // // //                     overflow: TextOverflow.ellipsis,
// // // //                   ),
// // // //                 ),
// // // //                 if (canRemove)
// // // //                   OutlinedButton(
// // // //                     onPressed: () =>
// // // //                         _removeAttendedGuard(shift, shiftKey, guard),
// // // //                     style: OutlinedButton.styleFrom(
// // // //                       foregroundColor: Colors.red,
// // // //                       side: const BorderSide(color: Colors.red),
// // // //                       shape: RoundedRectangleBorder(
// // // //                         borderRadius: BorderRadius.circular(20),
// // // //                       ),
// // // //                       padding: const EdgeInsets.symmetric(
// // // //                           horizontal: 12, vertical: 2),
// // // //                       minimumSize: const Size(0, 30),
// // // //                     ),
// // // //                     child: const Text('Remove',
// // // //                         style: TextStyle(fontWeight: FontWeight.w600)),
// // // //                   ),
// // // //               ],
// // // //             ),
// // // //           );
// // // //         }).toList(),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // TODO: replace direct field mutation with a real cubit call, e.g.
// // // //   // BlocProvider.of<AttendanceShiftsCubit>(context).unmarkGuardAttended(guard);
// // // //   void _removeAttendedGuard(Shifts shift, String shiftKey, Attended guard) {
// // // //     setState(() {
// // // //       shift.attended?.removeWhere((a) => a.id == guard.id);
// // // //       if (guard.id != null) {
// // // //         _newlyAddedGuardIdsByShift[shiftKey]?.remove(guard.id);
// // // //       }
// // // //     });
// // // //   }
// // // //
// // // //   // TODO: replace direct field mutation with a real cubit call, e.g.
// // // //   // BlocProvider.of<AttendanceShiftsCubit>(context).markGuardAttended(guard);
// // // //   void _addGuardToAttendance(
// // // //       Shifts shift, String shiftKey, AvailableGuards guard) {
// // // //     setState(() {
// // // //       shift.attended ??= [];
// // // //       shift.attended!.add(Attended(id: guard.id, name: guard.name));
// // // //       if (guard.id != null) {
// // // //         _newlyAddedGuardIdsByShift
// // // //             .putIfAbsent(shiftKey, () => <int>{})
// // // //             .add(guard.id!);
// // // //       }
// // // //     });
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------
// // // //   // REPLACEMENTS (local-only placeholder — see TODO at top of file)
// // // //   // ---------------------------------------------------------------------
// // // //   Widget _replacementsBox(String shiftKey) {
// // // //     final replacements = _replacementsByShift[shiftKey] ?? const [];
// // // //     if (replacements.isEmpty) {
// // // //       return _emptyStateBox('No replacements added yet');
// // // //     }
// // // //
// // // //     return Container(
// // // //       width: double.infinity,
// // // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// // // //       decoration: BoxDecoration(
// // // //         color: Colors.grey.shade50,
// // // //         border: Border.all(color: Colors.grey.shade300),
// // // //         borderRadius: BorderRadius.circular(8),
// // // //       ),
// // // //       child: Column(
// // // //         children: replacements
// // // //             .map(
// // // //               (r) => Padding(
// // // //             padding: const EdgeInsets.symmetric(vertical: 6),
// // // //             child: Row(
// // // //               children: [
// // // //                 Expanded(
// // // //                   child: Text(
// // // //                     r.replacedFor,
// // // //                     style: const TextStyle(
// // // //                         color: Colors.black87, fontWeight: FontWeight.w600),
// // // //                   ),
// // // //                 ),
// // // //                 Expanded(
// // // //                   child: Text(
// // // //                     r.reason,
// // // //                     style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
// // // //                     overflow: TextOverflow.ellipsis,
// // // //                   ),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //         )
// // // //             .toList(),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   void _onAddSlaViolation(Shifts shift, AttendanceShiftsState state) {
// // // //     FocusScope.of(context).unfocus();
// // // //     _lastSubmitWasSaveOnly = true;
// // // //     BlocProvider.of<AttendanceShiftsCubit>(context).submitForm(isSaveOnly: true);
// // // //
// // // //     Navigator.pushNamed(
// // // //       context,
// // // //       slaViolationPenaltyDetailsRoute,
// // // //       arguments: {
// // // //         ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
// // // //         ConstantsArgument.attdId: state.model.id,
// // // //         ConstantsArgument.location: widget.location,
// // // //         ConstantsArgument.locationRegion: widget.locationRegion,
// // // //         ConstantsArgument.vendor: widget.vendor,
// // // //       },
// // // //     ).then((_) {
// // // //       if (!mounted) return;
// // // //       BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// // // //     });
// // // //   }
// // // //
// // // //   // ---------------------------------------------------------------------
// // // //   // Frosted confirmation dialog for Submit
// // // //   // ---------------------------------------------------------------------
// // // //   Widget _buildGlassDialog({
// // // //     required String title,
// // // //     required String message,
// // // //     required VoidCallback onCancel,
// // // //     required Future<void> Function() onConfirm,
// // // //   }) {
// // // //     return Dialog(
// // // //       backgroundColor: Colors.transparent,
// // // //       insetPadding: const EdgeInsets.symmetric(horizontal: 24),
// // // //       child: ClipRRect(
// // // //         borderRadius: BorderRadius.circular(20),
// // // //         child: BackdropFilter(
// // // //           filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
// // // //           child: Container(
// // // //             padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
// // // //             decoration: BoxDecoration(
// // // //               gradient: LinearGradient(
// // // //                 colors: [
// // // //                   Colors.white.withValues(alpha: 0.02),
// // // //                   Colors.white.withValues(alpha: 0.04),
// // // //                 ],
// // // //                 begin: Alignment.topLeft,
// // // //                 end: Alignment.bottomRight,
// // // //               ),
// // // //               borderRadius: BorderRadius.circular(20),
// // // //               border: Border.all(
// // // //                 color: Colors.white.withValues(alpha: 0.55),
// // // //                 width: 1,
// // // //               ),
// // // //               boxShadow: [
// // // //                 BoxShadow(
// // // //                   color: Colors.black.withValues(alpha: 0.04),
// // // //                   blurRadius: 20,
// // // //                   offset: const Offset(0, 8),
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //             child: Column(
// // // //               mainAxisSize: MainAxisSize.min,
// // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // //               children: [
// // // //                 Text(
// // // //                   title,
// // // //                   style: const TextStyle(
// // // //                     color: Colors.white,
// // // //                     fontSize: 17,
// // // //                     fontWeight: FontWeight.w700,
// // // //                   ),
// // // //                 ),
// // // //                 const SizedBox(height: 12),
// // // //                 Text(
// // // //                   message,
// // // //                   style: TextStyle(
// // // //                     color: Colors.white.withValues(alpha: 0.85),
// // // //                     fontSize: 14,
// // // //                     height: 1.4,
// // // //                   ),
// // // //                 ),
// // // //                 const SizedBox(height: 20),
// // // //                 Row(
// // // //                   mainAxisAlignment: MainAxisAlignment.end,
// // // //                   children: [
// // // //                     TextButton(
// // // //                       onPressed: onCancel,
// // // //                       style: TextButton.styleFrom(
// // // //                         foregroundColor: Colors.white.withValues(alpha: 0.8),
// // // //                       ),
// // // //                       child: const Text(Constants.cancel),
// // // //                     ),
// // // //                     const SizedBox(width: 8),
// // // //                     TextButton(
// // // //                       onPressed: onConfirm,
// // // //                       style: TextButton.styleFrom(
// // // //                         foregroundColor: Colors.white,
// // // //                         backgroundColor: Colors.white.withValues(alpha: 0.12),
// // // //                         shape: RoundedRectangleBorder(
// // // //                           borderRadius: BorderRadius.circular(10),
// // // //                         ),
// // // //                         padding: const EdgeInsets.symmetric(
// // // //                           horizontal: 16,
// // // //                           vertical: 10,
// // // //                         ),
// // // //                       ),
// // // //                       child: const Text(Constants.ok),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   void showReplacementPopUp({
// // // //     required BuildContext context,
// // // //     required Replacement model,
// // // //     required Set<BaseUser> selectedGuards,
// // // //     required AttendanceShiftsState state,
// // // //     required int rankId,
// // // //     required int shiftId,
// // // //     required int dutyPostId,
// // // //     required int attendanceId,
// // // //   }) {
// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (BuildContext dialogContext) {
// // // //         return AddReplacementPopUp(
// // // //           viaAttendance: true,
// // // //           model: model,
// // // //           mainContext: context,
// // // //           selectedGuards: selectedGuards,
// // // //           attendanceModel: state.model,
// // // //           shiftId: shiftId,
// // // //           rankId: rankId,
// // // //           dutyPostId: dutyPostId,
// // // //           attendanceId: attendanceId,
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // // }
// // // import 'dart:ui';
// // //
// // // import 'package:db_atom/index.dart';
// // //
// // // import '../../attendance_details/views/attendance_details_view.dart';
// // // import '../../models/dutyPost_attendance_model.dart';
// // //
// // // class AttendanceShiftsView extends StatefulWidget {
// // //   const AttendanceShiftsView({
// // //     super.key,
// // //     required this.location,
// // //     required this.locationRegion,
// // //     required this.vendor,
// // //     required this.attInfoId,
// // //     required this.selectedDutyPostModel,
// // //     required this.isReadOnly,
// // //     required this.isEligibleToEdit,
// // //   });
// // //
// // //   final Organisation location;
// // //   final Organisation locationRegion;
// // //   final Organisation vendor;
// // //   final int attInfoId;
// // //   final DutyPostModel selectedDutyPostModel;
// // //   final bool isReadOnly;
// // //   final bool isEligibleToEdit;
// // //
// // //   @override
// // //   AttendanceShiftsViewState createState() => AttendanceShiftsViewState();
// // // }
// // //
// // // class ShiftSlaViolation {
// // //   final String id;
// // //   final String region;
// // //   final String location;
// // //   final String dateOfCreation;
// // //   final String createdBy;
// // //   final String asl;
// // //   final String typeOfService;
// // //   final String status;
// // //
// // //   ShiftSlaViolation({
// // //     required this.id,
// // //     required this.region,
// // //     required this.location,
// // //     required this.dateOfCreation,
// // //     required this.createdBy,
// // //     required this.asl,
// // //     required this.typeOfService,
// // //     required this.status,
// // //   });
// // // }
// // //
// // // Widget _readOnlyField({required String label, required String value}) {
// // //   return Column(
// // //     crossAxisAlignment: CrossAxisAlignment.start,
// // //     children: [
// // //       Text(
// // //         label,
// // //         style: const TextStyle(
// // //           color: Colors.black,
// // //           fontSize: 11,
// // //           fontWeight: FontWeight.w700,
// // //           letterSpacing: 0.5,
// // //         ),
// // //       ),
// // //       const SizedBox(height: 6),
// // //       Container(
// // //         width: double.infinity,
// // //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
// // //         decoration: BoxDecoration(
// // //           color: Colors.white.withValues(alpha: 0.9),
// // //           borderRadius: BorderRadius.circular(6),
// // //           border: Border.all(color: const Color(0xFF3D6DB0)),
// // //         ),
// // //         child: Text(
// // //           value,
// // //           style: const TextStyle(color: Colors.black87),
// // //         ),
// // //       ),
// // //     ],
// // //   );
// // // }
// // //
// // // class AttendanceShiftsViewState extends State<AttendanceShiftsView> {
// // //   bool isReadOnly = false;
// // //
// // //   // Accordion expand/collapse state — duty posts & ranks start expanded;
// // //   // a key only ever lands in these sets once the user *collapses* it.
// // //   final Set<String> _collapsedDutyPostKeys = {};
// // //   final Set<String> _collapsedRankKeys = {};
// // //
// // //   // Tracks which guard ids were added to a shift's attendance *in this
// // //   // session*, so only those rows show a "Remove" button — guards already
// // //   // attended before the screen opened stay locked. Keyed by `_shiftKey`.
// // //   final Map<String, Set<int>> _newlyAddedGuardIdsByShift = {};
// // //
// // //   // Card accent palette cycled per shift position within a rank, matching
// // //   // the orange / blue / red / green top borders in the reference design.
// // //   static const List<Color> _shiftAccentColors = [
// // //     Color(0xFFF5A623), // orange
// // //     Color(0xFF3D6DB0), // blue
// // //     Color(0xFFD64545), // red
// // //     Color(0xFF3FB65D), // green
// // //   ];
// // //
// // //   final Set<String> _collapsedSlaIds = {};
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final size = MediaQuery.of(context).size;
// // //     final height = size.height;
// // //
// // //     return BlocConsumer<AttendanceShiftsCubit, AttendanceShiftsState>(
// // //       listener: (context, state) {
// // //         Utils().formError(state, context);
// // //         Utils().errorAndLogout(state, context);
// // //
// // //         if (state.status == FormStatus.success) {
// // //           var dialog = CustomAlertDialog(
// // //             title: 'Attendance',
// // //             message: state.message ?? '',
// // //             positiveBtnText: Constants.ok,
// // //             onPositivePressed: () {
// // //               Navigator.pop(context);
// // //               Navigator.pop(context);
// // //               Navigator.popAndPushNamed(
// // //                 context,
// // //                 attendanceListRoute,
// // //                 arguments: {},
// // //               );
// // //             },
// // //           );
// // //           showDialog(
// // //               context: context,
// // //               barrierDismissible: false,
// // //               builder: (BuildContext context) => dialog);
// // //         }
// // //       },
// // //       builder: (context, state) {
// // //         isReadOnly = widget.isReadOnly ||
// // //             !widget.isEligibleToEdit ||
// // //             !state.model.lock.isEmptyOrNull;
// // //
// // //         return Scaffold(
// // //           backgroundColor: Colors.transparent,
// // //           extendBodyBehindAppBar: true,
// // //           appBar: BaseAppBar().buildAppHeader(
// // //             context: context,
// // //             title: 'Attendance',
// // //             showPopUp: false,
// // //             showSaveButton: false,
// // //             showSubmitButton: !isReadOnly && state.status != FormStatus.loading,
// // //             showDisLikeButton: false,
// // //             showLikeButton: false,
// // //             popAndReplace: () {
// // //               int flag = AttendanceDetailsView.flag;
// // //               if (flag == 1) {
// // //                 Navigator.pop(context);
// // //               } else {
// // //                 Navigator.pop(context);
// // //               }
// // //             },
// // //             onTapSubmit: () {
// // //               FocusScope.of(context).unfocus();
// // //               BlocProvider.of<AttendanceShiftsCubit>(context)
// // //                   .submitForm(isSaveOnly: false);
// // //             },
// // //           ),
// // //
// // //           // ================= BODY WITH BACKGROUND =================
// // //           body: Stack(
// // //             children: [
// // //               Positioned.fill(
// // //                 child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
// // //               ),
// // //               Positioned.fill(
// // //                 child: BackdropFilter(
// // //                   filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
// // //                   child: Container(color: Colors.black.withValues(alpha: 0.15)),
// // //                 ),
// // //               ),
// // //               Positioned.fill(
// // //                 child: MediaQuery.removePadding(
// // //                   context: context,
// // //                   removeTop: true,
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.all(20),
// // //                     child: SingleChildScrollView(
// // //                       child: Column(
// // //                         children: [
// // //                           SizedBox(
// // //                             height: kToolbarHeight +
// // //                                 MediaQuery.of(context).padding.top,
// // //                           ),
// // //                           getBody(state, height),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   // ---------------------------------------------------------------------
// // //   // BODY
// // //   // ---------------------------------------------------------------------
// // //   Widget getBody(AttendanceShiftsState state, double height) {
// // //     if (state.status == FormStatus.loading) {
// // //       return const BaseLoader();
// // //     }
// // //
// // //     final dutyPosts =
// // //         state.dutyPostAttendanceModel?.dutyPosts ?? const <DutyPosts>[];
// // //
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         if (!state.model.lock.isEmptyOrNull) ...[
// // //           RecordLockedWidget(text: '${state.model.lock}'),
// // //           CommonWidgets.verticalSpacerWidget(height * 0.02),
// // //         ],
// // //         if (dutyPosts.isEmpty)
// // //           const Padding(
// // //             padding: EdgeInsets.symmetric(vertical: 24),
// // //             child: Text(
// // //               'No duty posts found for this attendance record.',
// // //               style: Styles.textStyleWhite16,
// // //             ),
// // //           )
// // //         else
// // //           for (final dutyPost in dutyPosts) ...[
// // //             _buildDutyPostAccordion(dutyPost, height, state),
// // //             CommonWidgets.verticalSpacerWidget(height * 0.02),
// // //           ],
// // //       ],
// // //     );
// // //   }
// // //
// // //   // ---------------------------------------------------------------------
// // //   // DUTY POST ACCORDION  (e.g. "Basement")
// // //   // ---------------------------------------------------------------------
// // //   Widget _buildDutyPostAccordion(
// // //       DutyPosts dutyPost, double height, AttendanceShiftsState state) {
// // //     final key = 'dutypost_${dutyPost.dutyPostNameId}_${dutyPost.dutyPostName}';
// // //     final isExpanded = !_collapsedDutyPostKeys.contains(key);
// // //     final label = dutyPost.dutyPostName ?? '-';
// // //
// // //     return Container(
// // //       width: double.infinity,
// // //       decoration: BoxDecoration(
// // //         border: Border.all(color: const Color(0xFF5B4FCF)),
// // //         borderRadius: BorderRadius.circular(8),
// // //         color: Colors.white.withValues(alpha: 0.04),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           _accordionHeader(
// // //             avatarText: label.isNotEmpty ? label[0].toUpperCase() : '?',
// // //             title: label,
// // //             isExpanded: isExpanded,
// // //             onTap: () => setState(() {
// // //               if (isExpanded) {
// // //                 _collapsedDutyPostKeys.add(key);
// // //               } else {
// // //                 _collapsedDutyPostKeys.remove(key);
// // //               }
// // //             }),
// // //           ),
// // //           if (isExpanded)
// // //             Padding(
// // //               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
// // //               child: Column(
// // //                 children: [
// // //                   for (final rank in dutyPost.ranks ?? const <Ranks>[]) ...[
// // //                     // dutyPostNameId is only known at this level of the
// // //                     // tree, so it gets threaded down through
// // //                     // rank -> shift-grid -> shift-card, all the way to
// // //                     // where the "Add Replacement" button needs it.
// // //                     _buildRankAccordion(
// // //                       rank,
// // //                       height,
// // //                       state,
// // //                       dutyPost.dutyPostNameId,
// // //                     ),
// // //                     const SizedBox(height: 10),
// // //                   ],
// // //                 ],
// // //               ),
// // //             ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // ---------------------------------------------------------------------
// // //   // RANK ACCORDION  (e.g. "RANK: SECURITY GUARD/LADY SECURITY GUARD")
// // //   // ---------------------------------------------------------------------
// // //   Widget _buildRankAccordion(Ranks rank, double height,
// // //       AttendanceShiftsState state, int? dutyPostId) {
// // //     final key = 'rank_${rank.rankId}_${rank.rankName}';
// // //     final isExpanded = !_collapsedRankKeys.contains(key);
// // //     final title = 'RANK: ${(rank.rankName ?? '-').toUpperCase()}';
// // //
// // //     return Container(
// // //       width: double.infinity,
// // //       decoration: BoxDecoration(
// // //         border: Border.all(color: const Color(0xFF5B4FCF)),
// // //         borderRadius: BorderRadius.circular(8),
// // //         color: Colors.white.withValues(alpha: 0.01),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           _accordionHeader(
// // //             avatarText: _initialsFor(rank.rankName ?? ''),
// // //             title: title,
// // //             isExpanded: isExpanded,
// // //             onTap: () => setState(() {
// // //               if (isExpanded) {
// // //                 _collapsedRankKeys.add(key);
// // //               } else {
// // //                 _collapsedRankKeys.remove(key);
// // //               }
// // //             }),
// // //           ),
// // //           if (isExpanded)
// // //             Padding(
// // //               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
// // //               child: _buildShiftCardsGrid(
// // //                 rank.shifts ?? const <Shifts>[],
// // //                 height,
// // //                 state,
// // //                 dutyPostId,
// // //                 rank.rankId,
// // //               ),
// // //             ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   String _initialsFor(String label) {
// // //     final words = label.trim().split(RegExp(r'\s+'));
// // //     if (words.isEmpty || words.first.isEmpty) return '?';
// // //     return words
// // //         .take(2)
// // //         .map((w) => w.isNotEmpty ? w[0] : '')
// // //         .join()
// // //         .toUpperCase();
// // //   }
// // //
// // //   Widget _accordionHeader({
// // //     required String avatarText,
// // //     required String title,
// // //     required bool isExpanded,
// // //     required VoidCallback onTap,
// // //   }) {
// // //     return InkWell(
// // //       onTap: onTap,
// // //       child: Container(
// // //         width: double.infinity,
// // //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// // //         child: Row(
// // //           children: [
// // //             CircleAvatar(
// // //               radius: 12,
// // //               backgroundColor: Colors.white24,
// // //               child: Text(
// // //                 avatarText,
// // //                 style: const TextStyle(color: Colors.white, fontSize: 10),
// // //               ),
// // //             ),
// // //             const SizedBox(width: 8),
// // //             Expanded(
// // //               child: Text(
// // //                 title,
// // //                 style: const TextStyle(
// // //                   color: Colors.white,
// // //                   fontWeight: FontWeight.w700,
// // //                   fontSize: 13,
// // //                 ),
// // //               ),
// // //             ),
// // //             Icon(
// // //               isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
// // //               color: Colors.white70,
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   // ---------------------------------------------------------------------
// // //   // SHIFT CARDS GRID  (Shift A / B / C / G laid out 2-up, like the ref)
// // //   // ---------------------------------------------------------------------
// // //   Widget _buildShiftCardsGrid(
// // //       List<Shifts> shifts,
// // //       double height,
// // //       AttendanceShiftsState state,
// // //       int? dutyPostId,
// // //       int? rankId,
// // //       ) {
// // //     if (shifts.isEmpty) {
// // //       return const Padding(
// // //         padding: EdgeInsets.symmetric(vertical: 12),
// // //         child: Text(
// // //           'No shifts under this rank.',
// // //           style: Styles.textStyleWhite16,
// // //         ),
// // //       );
// // //     }
// // //
// // //     final width = MediaQuery.of(context).size.width;
// // //     final isTablet = width > Constants.tabletScreenWidth;
// // //     // Two columns on tablet/desktop widths, single column on phones —
// // //     // matches the 2-up grid in the reference screenshot.
// // //     final cardWidth = isTablet ? (width - 60) / 2 : width - 40;
// // //
// // //     return Wrap(
// // //       spacing: 12,
// // //       runSpacing: 12,
// // //       children: [
// // //         for (var i = 0; i < shifts.length; i++)
// // //           SizedBox(
// // //             width: cardWidth,
// // //             child: _buildShiftCard(
// // //               shifts[i],
// // //               i,
// // //               height,
// // //               state,
// // //               dutyPostId,
// // //               rankId,
// // //             ),
// // //           ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   String _shiftKey(Shifts shift) =>
// // //       'shift_${shift.attendanceShiftId ?? shift.shiftId}';
// // //
// // //   String _timeRangeForShift(String? shiftLabel) {
// // //     final normalized = (shiftLabel ?? '').toLowerCase().trim();
// // //     if (normalized == 'a') return '7AM - 3PM';
// // //     if (normalized == 'b') return '3PM - 11PM';
// // //     if (normalized == 'c') return '11PM - 7AM';
// // //     if (normalized == 'g') return '9AM - 6PM';
// // //     return '-';
// // //   }
// // //
// // //   Set<BaseUser> _selectableReplacementGuards(Shifts shift) {
// // //     return (shift.selectForReplacements ?? const <SelectForReplacements>[])
// // //         .map((g) => BaseUser(id: g.id, name: g.name))
// // //         .toSet();
// // //   }
// // //
// // //   // FIX: AddReplacementPopUp (viaAttendance path) still reads
// // //   // `widget.shiftModel!.attendanceShiftId!` when looking up "replacement
// // //   // by" guards — but this screen only ever passed `attendanceModel`, never
// // //   // `shiftModel`, so that call crashed with a null-check error as soon as
// // //   // a reason value of '1' was picked. Since AddReplacementPopUp itself is
// // //   // not being touched, we build the small ShiftModel it expects here, from
// // //   // the Shifts data we already have, and pass it through.
// // //   ShiftModel _shiftModelFor(Shifts shift) {
// // //     return ShiftModel(
// // //       shift: shift.shift,
// // //       attendanceShiftId: shift.attendanceShiftId ?? shift.shiftId,
// // //       allowed: shift.allowed,
// // //       attdStatus: shift.attdStatus,
// // //       activeShift: shift.activeShift ?? false,
// // //     );
// // //   }
// // //
// // //   List<ShiftSlaViolation> _parseSlaViolations(
// // //       List<dynamic>? violations, String fallbackStatus) {
// // //     return (violations ?? const []).map((v) {
// // //       if (v is Map) {
// // //         final location = v['location'] as Map?;
// // //         final locationRegion = v['locationRegion'] as Map?;
// // //         final entrySecurity = v['entrySecurity'] as Map?;
// // //         final approver = v['approver'] as Map?;
// // //         final typeOfServiceList = v['typeOfService'] as List?;
// // //
// // //         String fullName(Map? user) {
// // //           if (user == null) return '-';
// // //           final userInfo = user['userInfo'] as String?;
// // //           if (userInfo != null && userInfo.isNotEmpty) return userInfo;
// // //           final first = user['firstName'] as String? ?? '';
// // //           final last = user['lastName'] as String? ?? '';
// // //           final combined = '$first $last'.trim();
// // //           return combined.isNotEmpty ? combined : '-';
// // //         }
// // //
// // //         String formatEpochMs(dynamic epochMs) {
// // //           if (epochMs == null) return '-';
// // //           final millis = epochMs is int ? epochMs : int.tryParse('$epochMs');
// // //           if (millis == null) return '-';
// // //           final date = DateTime.fromMillisecondsSinceEpoch(millis);
// // //           return '${date.day.toString().padLeft(2, '0')}/'
// // //               '${date.month.toString().padLeft(2, '0')}/'
// // //               '${date.year} ${date.hour.toString().padLeft(2, '0')}:'
// // //               '${date.minute.toString().padLeft(2, '0')}';
// // //         }
// // //
// // //         return ShiftSlaViolation(
// // //           id: '${v['id'] ?? v['slNo'] ?? '-'}',
// // //           region: locationRegion?['name'] as String? ?? '-',
// // //           location: location?['name'] as String? ?? '-',
// // //           dateOfCreation: formatEpochMs(v['inputDate']),
// // //           createdBy: fullName(entrySecurity),
// // //           asl: fullName(approver),
// // //           typeOfService: (typeOfServiceList ?? const [])
// // //               .map((t) => (t as Map?)?['name'] as String? ?? '')
// // //               .where((s) => s.isNotEmpty)
// // //               .join(', '),
// // //           status: v['statusLabel'] as String? ?? fallbackStatus,
// // //         );
// // //       }
// // //       return ShiftSlaViolation(
// // //         id: '-',
// // //         region: '-',
// // //         location: '-',
// // //         dateOfCreation: '-',
// // //         createdBy: '-',
// // //         asl: '-',
// // //         typeOfService: '',
// // //         status: fallbackStatus,
// // //       );
// // //     }).toList();
// // //   }
// // //
// // //   Widget _buildShiftCard(
// // //       Shifts shift,
// // //       int index,
// // //       double height,
// // //       AttendanceShiftsState state,
// // //       int? dutyPostId,
// // //       int? rankId,
// // //       ) {
// // //     final accent = _shiftAccentColors[index % _shiftAccentColors.length];
// // //     final isActive = shift.activeShift == true;
// // //     final statusLabel = isActive ? 'Active' : 'Draft';
// // //     final statusColor =
// // //     isActive ? const Color(0xFF3FB65D) : const Color(0xFFF5A623);
// // //
// // //     final planned = shift.allowed ?? 0;
// // //     final present = shift.attended?.length ?? 0;
// // //
// // //     final shiftKey = _shiftKey(shift);
// // //     final shiftId = shift.attendanceShiftId ?? shift.shiftId;
// // //     final editable = !isReadOnly;
// // //
// // //     // See CAVEAT on `_parseSlaViolations` re: the assumed `violations` field.
// // //     final slaViolations = _parseSlaViolations(shift.slaViolations, statusLabel);
// // //
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         border: Border(top: BorderSide(color: accent, width: 3)),
// // //         color: Colors.white.withValues(alpha: 0.92),
// // //         borderRadius: BorderRadius.circular(10),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withValues(alpha: 0.06),
// // //             blurRadius: 8,
// // //             offset: const Offset(0, 3),
// // //           ),
// // //         ],
// // //       ),
// // //       padding: const EdgeInsets.all(14),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           // Header: avatar + "SHIFT X / time range" + status badge
// // //           Row(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Container(
// // //                 width: 26,
// // //                 height: 26,
// // //                 alignment: Alignment.center,
// // //                 decoration: BoxDecoration(
// // //                   color: accent.withValues(alpha: 0.15),
// // //                   borderRadius: BorderRadius.circular(6),
// // //                 ),
// // //                 child: Text(
// // //                   (shift.shift ?? '?').toUpperCase(),
// // //                   style: TextStyle(
// // //                     color: accent,
// // //                     fontWeight: FontWeight.w700,
// // //                     fontSize: 12,
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 10),
// // //               Expanded(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       'SHIFT ${(shift.shift ?? '-').toUpperCase()}',
// // //                       style: const TextStyle(
// // //                         color: Colors.black45,
// // //                         fontWeight: FontWeight.w700,
// // //                         fontSize: 11,
// // //                         letterSpacing: 0.5,
// // //                       ),
// // //                     ),
// // //                     Text(
// // //                       _timeRangeForShift(shift.shift),
// // //                       style: const TextStyle(
// // //                         color: Colors.black87,
// // //                         fontWeight: FontWeight.w700,
// // //                         fontSize: 14,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               Row(
// // //                 children: [
// // //                   Container(
// // //                     width: 8,
// // //                     height: 8,
// // //                     decoration: BoxDecoration(
// // //                         color: statusColor, shape: BoxShape.circle),
// // //                   ),
// // //                   const SizedBox(width: 4),
// // //                   Text(
// // //                     statusLabel,
// // //                     style: const TextStyle(
// // //                       color: Colors.black87,
// // //                       fontWeight: FontWeight.w600,
// // //                       fontSize: 12,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //           ),
// // //           CommonWidgets.verticalSpacerWidget(height * 0.012),
// // //
// // //           _plannedPresentRow(planned, present),
// // //           CommonWidgets.verticalSpacerWidget(height * 0.012),
// // //
// // //           // ATTENDANCE MARKING
// // //           _sectionHeader(
// // //             'ATTENDANCE MARKING',
// // //             trailing: null,
// // //           ),
// // //           const SizedBox(height: 6),
// // //           _attendanceMarkingBox(shift, shiftKey, editable),
// // //           const SizedBox(height: 12),
// // //
// // //           // REPLACEMENTS — only shown for active shifts, matching Shift A
// // //           // / Shift G in the reference (Shift B / C don't show it).
// // //           if (isActive) ...[
// // //             _sectionHeader(
// // //               'REPLACEMENTS',
// // //               trailing: editable
// // //                   ? _addIconButton(() {
// // //                 if (dutyPostId == null ||
// // //                     rankId == null ||
// // //                     shiftId == null) {
// // //                   Validator().showToast(
// // //                     context,
// // //                     'Please select a valid duty post, rank and shift '
// // //                         'before adding a replacement.',
// // //                   );
// // //                   return;
// // //                 }
// // //
// // //                 showReplacementPopUp(
// // //                   context: context,
// // //                   model: Replacement(),
// // //                   selectedGuards: _selectableReplacementGuards(shift),
// // //                   state: state,
// // //                   rankId: rankId,
// // //                   shiftId: shiftId,
// // //                   dutyPostId: dutyPostId,
// // //                   attendanceId: widget.attInfoId,
// // //                   shiftModel: _shiftModelFor(shift),
// // //                 );
// // //               })
// // //                   : null,
// // //             ),
// // //             const SizedBox(height: 6),
// // //             // FIX: this used to read from a local-only placeholder map that
// // //             // was never populated, so real replacements (either already on
// // //             // the record, or newly added through the popup) never showed
// // //             // up here. It now renders `shift.replacements`, the actual data
// // //             // coming back from the API, and lets you tap a row to edit it.
// // //             _replacementsBox(
// // //               shift,
// // //               dutyPostId: dutyPostId,
// // //               rankId: rankId,
// // //               shiftId: shiftId,
// // //               state: state,
// // //               editable: editable,
// // //             ),
// // //             const SizedBox(height: 12),
// // //           ],
// // //
// // //           // SLA VIOLATION LIST
// // //           _sectionHeader(
// // //             'SLA VIOLATION LIST',
// // //             trailing: editable
// // //                 ? _addIconButton(() => _onAddSlaViolation(shift, state))
// // //                 : null,
// // //           ),
// // //           const SizedBox(height: 6),
// // //           if (slaViolations.isEmpty)
// // //             _emptyStateBox('No SLA violations added yet')
// // //           else
// // //             Column(
// // //               children:
// // //               slaViolations.map((sla) => _slaViolationCard(sla)).toList(),
// // //             ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // ---------------------------------------------------------------------
// // //   // SLA VIOLATION LIST
// // //   // ---------------------------------------------------------------------
// // //
// // //   Widget _slaViolationCard(ShiftSlaViolation sla) {
// // //     final isCollapsed = _collapsedSlaIds.contains(sla.id);
// // //     return Container(
// // //       width: double.infinity,
// // //       margin: const EdgeInsets.only(bottom: 10),
// // //       decoration: BoxDecoration(
// // //         borderRadius: BorderRadius.circular(8),
// // //         border: Border.all(color: Colors.black12),
// // //       ),
// // //       clipBehavior: Clip.antiAlias,
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           InkWell(
// // //             onTap: () {
// // //               setState(() {
// // //                 if (isCollapsed) {
// // //                   _collapsedSlaIds.remove(sla.id);
// // //                 } else {
// // //                   _collapsedSlaIds.add(sla.id);
// // //                 }
// // //               });
// // //             },
// // //             child: Container(
// // //               width: double.infinity,
// // //               color: const Color(0xFF3D6DB0),
// // //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// // //               child: Row(
// // //                 children: [
// // //                   Expanded(
// // //                     child: Text.rich(
// // //                       TextSpan(
// // //                         children: [
// // //                           TextSpan(
// // //                             text: sla.typeOfService,
// // //                             style: const TextStyle(
// // //                               color: Colors.white,
// // //                               fontWeight: FontWeight.w700,
// // //                               fontSize: 13,
// // //                             ),
// // //                           ),
// // //                           TextSpan(
// // //                             text: '   ${sla.status}   ${sla.dateOfCreation}',
// // //                             style: const TextStyle(
// // //                               color: Colors.white70,
// // //                               fontWeight: FontWeight.w400,
// // //                               fontSize: 12,
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                       overflow: TextOverflow.ellipsis,
// // //                     ),
// // //                   ),
// // //                   Icon(
// // //                     isCollapsed
// // //                         ? Icons.keyboard_arrow_down
// // //                         : Icons.keyboard_arrow_up,
// // //                     color: Colors.white,
// // //                     size: 18,
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //           if (!isCollapsed)
// // //             Padding(
// // //               padding: const EdgeInsets.all(12),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Row(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Expanded(
// // //                           child: _readOnlyField(label: 'ID', value: sla.id)),
// // //                       const SizedBox(width: 12),
// // //                       Expanded(
// // //                           child: _readOnlyField(
// // //                               label: 'REGION', value: sla.region)),
// // //                     ],
// // //                   ),
// // //                   const SizedBox(height: 12),
// // //                   Row(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Expanded(
// // //                           child: _readOnlyField(
// // //                               label: 'LOCATION', value: sla.location)),
// // //                       const SizedBox(width: 12),
// // //                       Expanded(
// // //                           child: _readOnlyField(
// // //                               label: 'DATE OF CREATION',
// // //                               value: sla.dateOfCreation)),
// // //                     ],
// // //                   ),
// // //                   const SizedBox(height: 12),
// // //                   Row(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Expanded(
// // //                           child: _readOnlyField(
// // //                               label: 'CREATED BY', value: sla.createdBy)),
// // //                       const SizedBox(width: 12),
// // //                       Expanded(
// // //                           child: _readOnlyField(label: 'ASL', value: sla.asl)),
// // //                     ],
// // //                   ),
// // //                   const SizedBox(height: 12),
// // //                   Row(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Expanded(
// // //                           child: _readOnlyField(
// // //                               label: 'TYPE OF SERVICE',
// // //                               value: sla.typeOfService)),
// // //                       const SizedBox(width: 12),
// // //                       Expanded(
// // //                           child: _readOnlyField(
// // //                               label: 'STATUS', value: sla.status)),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _sectionHeader(String title, {Widget? trailing}) {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //       children: [
// // //         Text(
// // //           title,
// // //           style: const TextStyle(
// // //             color: Colors.black87,
// // //             fontWeight: FontWeight.w700,
// // //             fontSize: 12,
// // //             letterSpacing: 0.4,
// // //           ),
// // //         ),
// // //         if (trailing != null) trailing,
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _addIconButton(VoidCallback onTap) {
// // //     return InkWell(
// // //       onTap: onTap,
// // //       borderRadius: BorderRadius.circular(20),
// // //       child: Container(
// // //         width: 26,
// // //         height: 26,
// // //         decoration: const BoxDecoration(
// // //           color: Color(0xFF5B4FCF),
// // //           shape: BoxShape.circle,
// // //         ),
// // //         child: const Icon(Icons.add, color: Colors.white, size: 16),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _emptyStateBox(String message) {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.symmetric(vertical: 16),
// // //       decoration: BoxDecoration(
// // //         color: Colors.grey.shade50,
// // //         border: Border.all(color: Colors.grey.shade300),
// // //         borderRadius: BorderRadius.circular(8),
// // //       ),
// // //       alignment: Alignment.center,
// // //       child: Text(
// // //         message,
// // //         style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _plannedPresentRow(int planned, int present) {
// // //     return Text.rich(
// // //       TextSpan(
// // //         children: [
// // //           const TextSpan(
// // //             text: 'Planned: ',
// // //             style: TextStyle(
// // //                 color: Colors.black87,
// // //                 fontWeight: FontWeight.w700,
// // //                 fontSize: 13),
// // //           ),
// // //           TextSpan(
// // //             text: '$planned  ',
// // //             style: const TextStyle(
// // //                 color: Colors.black87,
// // //                 fontWeight: FontWeight.w700,
// // //                 fontSize: 13),
// // //           ),
// // //           const TextSpan(
// // //             text: 'Present: ',
// // //             style: TextStyle(
// // //                 color: Colors.black87,
// // //                 fontWeight: FontWeight.w700,
// // //                 fontSize: 13),
// // //           ),
// // //           TextSpan(
// // //             text: '$present',
// // //             style: const TextStyle(
// // //                 color: Colors.black87,
// // //                 fontWeight: FontWeight.w700,
// // //                 fontSize: 13),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // ---------------------------------------------------------------------
// // //   // ATTENDANCE MARKING
// // //   // ---------------------------------------------------------------------
// // //   Widget _attendanceMarkingBox(Shifts shift, String shiftKey, bool editable) {
// // //     final attended = shift.attended ?? const <Attended>[];
// // //     if (attended.isEmpty) {
// // //       return _emptyStateBox('No guards marked attended yet');
// // //     }
// // //
// // //     final newlyAdded = _newlyAddedGuardIdsByShift[shiftKey] ?? const <int>{};
// // //
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// // //       decoration: BoxDecoration(
// // //         color: Colors.grey.shade50,
// // //         border: Border.all(color: Colors.grey.shade300),
// // //         borderRadius: BorderRadius.circular(8),
// // //       ),
// // //       child: Column(
// // //         children: attended.map((guard) {
// // //           final canRemove =
// // //               editable && guard.id != null && newlyAdded.contains(guard.id);
// // //           return Padding(
// // //             padding: const EdgeInsets.symmetric(vertical: 6),
// // //             child: Row(
// // //               children: [
// // //                 CircleAvatar(
// // //                   radius: 12,
// // //                   backgroundColor: const Color(0xFFEDE9FE),
// // //                   child: Text(
// // //                     (guard.name?.isNotEmpty == true)
// // //                         ? guard.name![0].toUpperCase()
// // //                         : '?',
// // //                     style: const TextStyle(
// // //                       color: Color(0xFF5B4FCF),
// // //                       fontWeight: FontWeight.w700,
// // //                       fontSize: 11,
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(width: 8),
// // //                 Expanded(
// // //                   child: Text(
// // //                     guard.name ?? '-',
// // //                     style: const TextStyle(
// // //                         color: Colors.black87, fontWeight: FontWeight.w600),
// // //                     overflow: TextOverflow.ellipsis,
// // //                   ),
// // //                 ),
// // //                 if (canRemove)
// // //                   OutlinedButton(
// // //                     onPressed: () =>
// // //                         _removeAttendedGuard(shift, shiftKey, guard),
// // //                     style: OutlinedButton.styleFrom(
// // //                       foregroundColor: Colors.red,
// // //                       side: const BorderSide(color: Colors.red),
// // //                       shape: RoundedRectangleBorder(
// // //                         borderRadius: BorderRadius.circular(20),
// // //                       ),
// // //                       padding: const EdgeInsets.symmetric(
// // //                           horizontal: 12, vertical: 2),
// // //                       minimumSize: const Size(0, 30),
// // //                     ),
// // //                     child: const Text('Remove',
// // //                         style: TextStyle(fontWeight: FontWeight.w600)),
// // //                   ),
// // //               ],
// // //             ),
// // //           );
// // //         }).toList(),
// // //       ),
// // //     );
// // //   }
// // //
// // //   // TODO: replace direct field mutation with a real cubit call, e.g.
// // //   // BlocProvider.of<AttendanceShiftsCubit>(context).unmarkGuardAttended(guard);
// // //   void _removeAttendedGuard(Shifts shift, String shiftKey, Attended guard) {
// // //     setState(() {
// // //       shift.attended?.removeWhere((a) => a.id == guard.id);
// // //       if (guard.id != null) {
// // //         _newlyAddedGuardIdsByShift[shiftKey]?.remove(guard.id);
// // //       }
// // //     });
// // //   }
// // //
// // //   // ---------------------------------------------------------------------
// // //   // REPLACEMENTS — driven by the real `shift.replacements` list.
// // //   // ---------------------------------------------------------------------
// // //   Widget _replacementsBox(
// // //       Shifts shift, {
// // //         required int? dutyPostId,
// // //         required int? rankId,
// // //         required int? shiftId,
// // //         required AttendanceShiftsState state,
// // //         required bool editable,
// // //       }) {
// // //     final replacements = shift.replacements ?? const <Replacement>[];
// // //     if (replacements.isEmpty) {
// // //       return _emptyStateBox('No replacements added yet');
// // //     }
// // //
// // //     final canEdit =
// // //         editable && dutyPostId != null && rankId != null && shiftId != null;
// // //
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// // //       decoration: BoxDecoration(
// // //         color: Colors.grey.shade50,
// // //         border: Border.all(color: Colors.grey.shade300),
// // //         borderRadius: BorderRadius.circular(8),
// // //       ),
// // //       child: Column(
// // //         children: replacements.map((r) {
// // //           final fromDateLabel =
// // //           !r.fromDate.isEmptyOrNull
// // //               ? Utils.timestampToDateConversion(
// // //             int.tryParse(r.fromDate ?? '0') ?? 0,
// // //             Constants.dateFormat,
// // //           )
// // //               : '-';
// // //           final toDateLabel = !r.toDate.isEmptyOrNull
// // //               ? Utils.timestampToDateConversion(
// // //             int.tryParse(r.toDate ?? '0') ?? 0,
// // //             Constants.dateFormat,
// // //           )
// // //               : '-';
// // //           final reasonLabel = r.status != null
// // //               ? (Utils().getKeyFromValue(
// // //             value: r.status!,
// // //             dropdownValues: shiftScheduleReasonDropDownValues,
// // //           ) ??
// // //               '-')
// // //               : '-';
// // //
// // //           return InkWell(
// // //             onTap: canEdit
// // //                 ? () => showReplacementPopUp(
// // //               context: context,
// // //               model: r,
// // //               selectedGuards: _selectableReplacementGuards(shift),
// // //               state: state,
// // //               rankId: rankId,
// // //               shiftId: shiftId,
// // //               dutyPostId: dutyPostId,
// // //               attendanceId: widget.attInfoId,
// // //               shiftModel: _shiftModelFor(shift),
// // //             )
// // //                 : null,
// // //             child: Padding(
// // //               padding: const EdgeInsets.symmetric(vertical: 6),
// // //               child: Row(
// // //                 children: [
// // //                   Expanded(
// // //                     flex: 3,
// // //                     child: Text(
// // //                       r.replacedFor?.name ?? '-',
// // //                       style: const TextStyle(
// // //                           color: Colors.black87, fontWeight: FontWeight.w600),
// // //                       overflow: TextOverflow.ellipsis,
// // //                     ),
// // //                   ),
// // //                   Expanded(
// // //                     flex: 3,
// // //                     child: Text(
// // //                       '$fromDateLabel - $toDateLabel',
// // //                       style:
// // //                       TextStyle(color: Colors.grey.shade700, fontSize: 12),
// // //                       overflow: TextOverflow.ellipsis,
// // //                     ),
// // //                   ),
// // //                   Expanded(
// // //                     flex: 2,
// // //                     child: Text(
// // //                       r.replacementBy?.name ?? '-',
// // //                       style:
// // //                       TextStyle(color: Colors.grey.shade700, fontSize: 12),
// // //                       overflow: TextOverflow.ellipsis,
// // //                     ),
// // //                   ),
// // //                   Expanded(
// // //                     flex: 2,
// // //                     child: Text(
// // //                       reasonLabel,
// // //                       style:
// // //                       TextStyle(color: Colors.grey.shade700, fontSize: 12),
// // //                       overflow: TextOverflow.ellipsis,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           );
// // //         }).toList(),
// // //       ),
// // //     );
// // //   }
// // //
// // //   void _onAddSlaViolation(Shifts shift, AttendanceShiftsState state) {
// // //     FocusScope.of(context).unfocus();
// // //     BlocProvider.of<AttendanceShiftsCubit>(context).submitForm(isSaveOnly: true);
// // //
// // //     Navigator.pushNamed(
// // //       context,
// // //       slaViolationPenaltyDetailsRoute,
// // //       arguments: {
// // //         ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
// // //         ConstantsArgument.attdId: state.model.id,
// // //         ConstantsArgument.location: widget.location,
// // //         ConstantsArgument.locationRegion: widget.locationRegion,
// // //         ConstantsArgument.vendor: widget.vendor,
// // //       },
// // //     ).then((_) {
// // //       if (!mounted) return;
// // //       BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// // //     });
// // //   }
// // //
// // //   void showReplacementPopUp({
// // //     required BuildContext context,
// // //     required Replacement model,
// // //     required Set<BaseUser> selectedGuards,
// // //     required AttendanceShiftsState state,
// // //     required int rankId,
// // //     required int shiftId,
// // //     required int dutyPostId,
// // //     required int attendanceId,
// // //     required ShiftModel shiftModel,
// // //   }) {
// // //     showDialog(
// // //       context: context,
// // //       builder: (BuildContext dialogContext) {
// // //         return AddReplacementPopUp(
// // //           viaAttendance: true,
// // //           model: model,
// // //           mainContext: context,
// // //           selectedGuards: selectedGuards,
// // //           attendanceModel: state.model,
// // //           shiftModel: shiftModel,
// // //           shiftId: shiftId,
// // //           rankId: rankId,
// // //           dutyPostId: dutyPostId,
// // //           attendanceId: attendanceId,
// // //         );
// // //       },
// // //     ).then((_) {
// // //       // Refresh so any edits made in the popup are reflected here.
// // //       if (!mounted) return;
// // //       BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// // //     });
// // //   }
// // // }
// // import 'dart:ui';
// //
// // import 'package:db_atom/index.dart';
// //
// // import '../../attendance_details/views/attendance_details_view.dart';
// // import '../../models/dutyPost_attendance_model.dart';
// //
// // class AttendanceShiftsView extends StatefulWidget {
// //   const AttendanceShiftsView({
// //     super.key,
// //     required this.location,
// //     required this.locationRegion,
// //     required this.vendor,
// //     required this.attInfoId,
// //     required this.selectedDutyPostModel,
// //     required this.isReadOnly,
// //     required this.isEligibleToEdit,
// //   });
// //
// //   final Organisation location;
// //   final Organisation locationRegion;
// //   final Organisation vendor;
// //   final int attInfoId;
// //   final DutyPostModel selectedDutyPostModel;
// //   final bool isReadOnly;
// //   final bool isEligibleToEdit;
// //
// //   @override
// //   AttendanceShiftsViewState createState() => AttendanceShiftsViewState();
// // }
// //
// // class ShiftSlaViolation {
// //   final String id;
// //   final String region;
// //   final String location;
// //   final String dateOfCreation;
// //   final String createdBy;
// //   final String asl;
// //   final String typeOfService;
// //   final String status;
// //
// //   ShiftSlaViolation({
// //     required this.id,
// //     required this.region,
// //     required this.location,
// //     required this.dateOfCreation,
// //     required this.createdBy,
// //     required this.asl,
// //     required this.typeOfService,
// //     required this.status,
// //   });
// // }
// //
// // Widget _readOnlyField({required String label, required String value}) {
// //   return Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: [
// //       Text(
// //         label,
// //         style: const TextStyle(
// //           color: Colors.black,
// //           fontSize: 11,
// //           fontWeight: FontWeight.w700,
// //           letterSpacing: 0.5,
// //         ),
// //       ),
// //       const SizedBox(height: 6),
// //       Container(
// //         width: double.infinity,
// //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
// //         decoration: BoxDecoration(
// //           color: Colors.white.withValues(alpha: 0.9),
// //           borderRadius: BorderRadius.circular(6),
// //           border: Border.all(color: const Color(0xFF3D6DB0)),
// //         ),
// //         child: Text(
// //           value,
// //           style: const TextStyle(color: Colors.black87),
// //         ),
// //       ),
// //     ],
// //   );
// // }
// //
// // class AttendanceShiftsViewState extends State<AttendanceShiftsView> {
// //   bool isReadOnly = false;
// //
// //   // Accordion expand/collapse state — duty posts & ranks start expanded;
// //   // a key only ever lands in these sets once the user *collapses* it.
// //   final Set<String> _collapsedDutyPostKeys = {};
// //   final Set<String> _collapsedRankKeys = {};
// //
// //   // Tracks which guard ids were added to a shift's attendance *in this
// //   // session*, so only those rows show a "Remove" button — guards already
// //   // attended before the screen opened stay locked. Keyed by `_shiftKey`.
// //   final Map<String, Set<int>> _newlyAddedGuardIdsByShift = {};
// //
// //   // Card accent palette cycled per shift position within a rank, matching
// //   // the orange / blue / red / green top borders in the reference design.
// //   static const List<Color> _shiftAccentColors = [
// //     Color(0xFFF5A623), // orange
// //     Color(0xFF3D6DB0), // blue
// //     Color(0xFFD64545), // red
// //     Color(0xFF3FB65D), // green
// //   ];
// //
// //   final Set<String> _collapsedSlaIds = {};
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;
// //     final height = size.height;
// //
// //     return BlocConsumer<AttendanceShiftsCubit, AttendanceShiftsState>(
// //       listener: (context, state) {
// //         Utils().formError(state, context);
// //         Utils().errorAndLogout(state, context);
// //
// //         if (state.status == FormStatus.success) {
// //           var dialog = CustomAlertDialog(
// //             title: 'Attendance',
// //             message: state.message ?? '',
// //             positiveBtnText: Constants.ok,
// //             onPositivePressed: () {
// //               Navigator.pop(context);
// //               Navigator.pop(context);
// //               Navigator.popAndPushNamed(
// //                 context,
// //                 attendanceListRoute,
// //                 arguments: {},
// //               );
// //             },
// //           );
// //           showDialog(
// //               context: context,
// //               barrierDismissible: false,
// //               builder: (BuildContext context) => dialog);
// //         }
// //       },
// //       builder: (context, state) {
// //         isReadOnly = widget.isReadOnly ||
// //             !widget.isEligibleToEdit ||
// //             !state.model.lock.isEmptyOrNull;
// //
// //         return Scaffold(
// //           backgroundColor: Colors.transparent,
// //           extendBodyBehindAppBar: true,
// //           appBar: BaseAppBar().buildAppHeader(
// //             context: context,
// //             title: 'Attendance',
// //             showPopUp: false,
// //             showSaveButton: false,
// //             showSubmitButton: !isReadOnly && state.status != FormStatus.loading,
// //             showDisLikeButton: false,
// //             showLikeButton: false,
// //             popAndReplace: () {
// //               int flag = AttendanceDetailsView.flag;
// //               if (flag == 1) {
// //                 Navigator.pop(context);
// //               } else {
// //                 Navigator.pop(context);
// //               }
// //             },
// //             onTapSubmit: () {
// //               FocusScope.of(context).unfocus();
// //               BlocProvider.of<AttendanceShiftsCubit>(context)
// //                   .submitForm(isSaveOnly: false);
// //             },
// //           ),
// //
// //           // ================= BODY WITH BACKGROUND =================
// //           body: Stack(
// //             children: [
// //               Positioned.fill(
// //                 child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
// //               ),
// //               Positioned.fill(
// //                 child: BackdropFilter(
// //                   filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
// //                   child: Container(color: Colors.black.withValues(alpha: 0.15)),
// //                 ),
// //               ),
// //               Positioned.fill(
// //                 child: MediaQuery.removePadding(
// //                   context: context,
// //                   removeTop: true,
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(20),
// //                     child: SingleChildScrollView(
// //                       child: Column(
// //                         children: [
// //                           SizedBox(
// //                             height: kToolbarHeight +
// //                                 MediaQuery.of(context).padding.top,
// //                           ),
// //                           getBody(state, height),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //   // ---------------------------------------------------------------------
// //   // BODY
// //   // ---------------------------------------------------------------------
// //   Widget getBody(AttendanceShiftsState state, double height) {
// //     if (state.status == FormStatus.loading) {
// //       return const BaseLoader();
// //     }
// //
// //     final dutyPosts =
// //         state.dutyPostAttendanceModel?.dutyPosts ?? const <DutyPosts>[];
// //
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         if (!state.model.lock.isEmptyOrNull) ...[
// //           RecordLockedWidget(text: '${state.model.lock}'),
// //           CommonWidgets.verticalSpacerWidget(height * 0.02),
// //         ],
// //         if (dutyPosts.isEmpty)
// //           const Padding(
// //             padding: EdgeInsets.symmetric(vertical: 24),
// //             child: Text(
// //               'No duty posts found for this attendance record.',
// //               style: Styles.textStyleWhite16,
// //             ),
// //           )
// //         else
// //           for (final dutyPost in dutyPosts) ...[
// //             _buildDutyPostAccordion(dutyPost, height, state),
// //             CommonWidgets.verticalSpacerWidget(height * 0.02),
// //           ],
// //       ],
// //     );
// //   }
// //
// //   // ---------------------------------------------------------------------
// //   // DUTY POST ACCORDION  (e.g. "Basement")
// //   // ---------------------------------------------------------------------
// //   Widget _buildDutyPostAccordion(
// //       DutyPosts dutyPost, double height, AttendanceShiftsState state) {
// //     final key = 'dutypost_${dutyPost.dutyPostNameId}_${dutyPost.dutyPostName}';
// //     final isExpanded = !_collapsedDutyPostKeys.contains(key);
// //     final label = dutyPost.dutyPostName ?? '-';
// //
// //     return Container(
// //       width: double.infinity,
// //       decoration: BoxDecoration(
// //         border: Border.all(color: const Color(0xFF5B4FCF)),
// //         borderRadius: BorderRadius.circular(8),
// //         color: Colors.white.withValues(alpha: 0.04),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           _accordionHeader(
// //             avatarText: label.isNotEmpty ? label[0].toUpperCase() : '?',
// //             title: label,
// //             isExpanded: isExpanded,
// //             onTap: () => setState(() {
// //               if (isExpanded) {
// //                 _collapsedDutyPostKeys.add(key);
// //               } else {
// //                 _collapsedDutyPostKeys.remove(key);
// //               }
// //             }),
// //           ),
// //           if (isExpanded)
// //             Padding(
// //               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
// //               child: Column(
// //                 children: [
// //                   for (final rank in dutyPost.ranks ?? const <Ranks>[]) ...[
// //                     // dutyPostNameId is only known at this level of the
// //                     // tree, so it gets threaded down through
// //                     // rank -> shift-grid -> shift-card, all the way to
// //                     // where the "Add Replacement" button needs it.
// //                     _buildRankAccordion(
// //                       rank,
// //                       height,
// //                       state,
// //                       dutyPost.dutyPostNameId,
// //                     ),
// //                     const SizedBox(height: 10),
// //                   ],
// //                 ],
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // ---------------------------------------------------------------------
// //   // RANK ACCORDION  (e.g. "RANK: SECURITY GUARD/LADY SECURITY GUARD")
// //   // ---------------------------------------------------------------------
// //   Widget _buildRankAccordion(Ranks rank, double height,
// //       AttendanceShiftsState state, int? dutyPostId) {
// //     final key = 'rank_${rank.rankId}_${rank.rankName}';
// //     final isExpanded = !_collapsedRankKeys.contains(key);
// //     final title = 'RANK: ${(rank.rankName ?? '-').toUpperCase()}';
// //
// //     return Container(
// //       width: double.infinity,
// //       decoration: BoxDecoration(
// //         border: Border.all(color: const Color(0xFF5B4FCF)),
// //         borderRadius: BorderRadius.circular(8),
// //         color: Colors.white.withValues(alpha: 0.01),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           _accordionHeader(
// //             avatarText: _initialsFor(rank.rankName ?? ''),
// //             title: title,
// //             isExpanded: isExpanded,
// //             onTap: () => setState(() {
// //               if (isExpanded) {
// //                 _collapsedRankKeys.add(key);
// //               } else {
// //                 _collapsedRankKeys.remove(key);
// //               }
// //             }),
// //           ),
// //           if (isExpanded)
// //             Padding(
// //               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
// //               child: _buildShiftCardsGrid(
// //                 rank.shifts ?? const <Shifts>[],
// //                 height,
// //                 state,
// //                 dutyPostId,
// //                 rank.rankId,
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   String _initialsFor(String label) {
// //     final words = label.trim().split(RegExp(r'\s+'));
// //     if (words.isEmpty || words.first.isEmpty) return '?';
// //     return words
// //         .take(2)
// //         .map((w) => w.isNotEmpty ? w[0] : '')
// //         .join()
// //         .toUpperCase();
// //   }
// //
// //   Widget _accordionHeader({
// //     required String avatarText,
// //     required String title,
// //     required bool isExpanded,
// //     required VoidCallback onTap,
// //   }) {
// //     return InkWell(
// //       onTap: onTap,
// //       child: Container(
// //         width: double.infinity,
// //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// //         child: Row(
// //           children: [
// //             CircleAvatar(
// //               radius: 12,
// //               backgroundColor: Colors.white24,
// //               child: Text(
// //                 avatarText,
// //                 style: const TextStyle(color: Colors.white, fontSize: 10),
// //               ),
// //             ),
// //             const SizedBox(width: 8),
// //             Expanded(
// //               child: Text(
// //                 title,
// //                 style: const TextStyle(
// //                   color: Colors.white,
// //                   fontWeight: FontWeight.w700,
// //                   fontSize: 13,
// //                 ),
// //               ),
// //             ),
// //             Icon(
// //               isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
// //               color: Colors.white70,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ---------------------------------------------------------------------
// //   // SHIFT CARDS GRID  (Shift A / B / C / G laid out 2-up, like the ref)
// //   // ---------------------------------------------------------------------
// //   Widget _buildShiftCardsGrid(
// //       List<Shifts> shifts,
// //       double height,
// //       AttendanceShiftsState state,
// //       int? dutyPostId,
// //       int? rankId,
// //       ) {
// //     if (shifts.isEmpty) {
// //       return const Padding(
// //         padding: EdgeInsets.symmetric(vertical: 12),
// //         child: Text(
// //           'No shifts under this rank.',
// //           style: Styles.textStyleWhite16,
// //         ),
// //       );
// //     }
// //
// //     final width = MediaQuery.of(context).size.width;
// //     final isTablet = width > Constants.tabletScreenWidth;
// //     // Two columns on tablet/desktop widths, single column on phones —
// //     // matches the 2-up grid in the reference screenshot.
// //     final cardWidth = isTablet ? (width - 60) / 2 : width - 40;
// //
// //     return Wrap(
// //       spacing: 12,
// //       runSpacing: 12,
// //       children: [
// //         for (var i = 0; i < shifts.length; i++)
// //           SizedBox(
// //             width: cardWidth,
// //             child: _buildShiftCard(
// //               shifts[i],
// //               i,
// //               height,
// //               state,
// //               dutyPostId,
// //               rankId,
// //             ),
// //           ),
// //       ],
// //     );
// //   }
// //
// //   String _shiftKey(Shifts shift) =>
// //       'shift_${shift.attendanceShiftId ?? shift.shiftId}';
// //
// //   String _timeRangeForShift(String? shiftLabel) {
// //     final normalized = (shiftLabel ?? '').toLowerCase().trim();
// //     if (normalized == 'a') return '7AM - 3PM';
// //     if (normalized == 'b') return '3PM - 11PM';
// //     if (normalized == 'c') return '11PM - 7AM';
// //     if (normalized == 'g') return '9AM - 6PM';
// //     return '-';
// //   }
// //
// //   Set<BaseUser> _selectableReplacementGuards(Shifts shift) {
// //     return (shift.selectForReplacements ?? const <SelectForReplacements>[])
// //         .map((g) => BaseUser(id: g.id, name: g.name))
// //         .toSet();
// //   }
// //
// //   // FIX: AddReplacementPopUp (viaAttendance path) still reads
// //   // `widget.shiftModel!.attendanceShiftId!` when looking up "replacement
// //   // by" guards — but this screen only ever passed `attendanceModel`, never
// //   // `shiftModel`, so that call crashed with a null-check error as soon as
// //   // a reason value of '1' was picked. Since AddReplacementPopUp itself is
// //   // not being touched, we build the small ShiftModel it expects here, from
// //   // the Shifts data we already have, and pass it through.
// //   //
// //   // IMPORTANT: `attendanceShiftId` here must be the shift's OWN
// //   // `attendanceShiftId` — do NOT fall back to `shift.shiftId`. Inside
// //   // AddReplacementPopUp.getReplacementByUserListForAttendance(), this
// //   // value is sent as the `dutyPostId` path segment of
// //   // getAttAvailableGuardsByDate, while `widget.shiftId` (a separate,
// //   // distinct value — see `shiftId` in _buildShiftCard) is sent as the
// //   // `shiftId` query param. Falling back to the same field for both is
// //   // what caused the request to go out as
// //   // `.../getAttAvailableGuardsByDate/2390?...&shiftId=2390` — the same
// //   // id used twice instead of two different ones.
// //   ShiftModel _shiftModelFor(Shifts shift) {
// //     return ShiftModel(
// //       shift: shift.shift,
// //       attendanceShiftId: shift.attendanceShiftId,
// //       allowed: shift.allowed,
// //       attdStatus: shift.attdStatus,
// //       activeShift: shift.activeShift ?? false,
// //     );
// //   }
// //
// //   List<ShiftSlaViolation> _parseSlaViolations(
// //       List<dynamic>? violations, String fallbackStatus) {
// //     return (violations ?? const []).map((v) {
// //       if (v is Map) {
// //         final location = v['location'] as Map?;
// //         final locationRegion = v['locationRegion'] as Map?;
// //         final entrySecurity = v['entrySecurity'] as Map?;
// //         final approver = v['approver'] as Map?;
// //         final typeOfServiceList = v['typeOfService'] as List?;
// //
// //         String fullName(Map? user) {
// //           if (user == null) return '-';
// //           final userInfo = user['userInfo'] as String?;
// //           if (userInfo != null && userInfo.isNotEmpty) return userInfo;
// //           final first = user['firstName'] as String? ?? '';
// //           final last = user['lastName'] as String? ?? '';
// //           final combined = '$first $last'.trim();
// //           return combined.isNotEmpty ? combined : '-';
// //         }
// //
// //         String formatEpochMs(dynamic epochMs) {
// //           if (epochMs == null) return '-';
// //           final millis = epochMs is int ? epochMs : int.tryParse('$epochMs');
// //           if (millis == null) return '-';
// //           final date = DateTime.fromMillisecondsSinceEpoch(millis);
// //           return '${date.day.toString().padLeft(2, '0')}/'
// //               '${date.month.toString().padLeft(2, '0')}/'
// //               '${date.year} ${date.hour.toString().padLeft(2, '0')}:'
// //               '${date.minute.toString().padLeft(2, '0')}';
// //         }
// //
// //         return ShiftSlaViolation(
// //           id: '${v['id'] ?? v['slNo'] ?? '-'}',
// //           region: locationRegion?['name'] as String? ?? '-',
// //           location: location?['name'] as String? ?? '-',
// //           dateOfCreation: formatEpochMs(v['inputDate']),
// //           createdBy: fullName(entrySecurity),
// //           asl: fullName(approver),
// //           typeOfService: (typeOfServiceList ?? const [])
// //               .map((t) => (t as Map?)?['name'] as String? ?? '')
// //               .where((s) => s.isNotEmpty)
// //               .join(', '),
// //           status: v['statusLabel'] as String? ?? fallbackStatus,
// //         );
// //       }
// //       return ShiftSlaViolation(
// //         id: '-',
// //         region: '-',
// //         location: '-',
// //         dateOfCreation: '-',
// //         createdBy: '-',
// //         asl: '-',
// //         typeOfService: '',
// //         status: fallbackStatus,
// //       );
// //     }).toList();
// //   }
// //
// //   Widget _buildShiftCard(
// //       Shifts shift,
// //       int index,
// //       double height,
// //       AttendanceShiftsState state,
// //       int? dutyPostId,
// //       int? rankId,
// //       ) {
// //     final accent = _shiftAccentColors[index % _shiftAccentColors.length];
// //     final isActive = shift.activeShift == true;
// //     final statusLabel = isActive ? 'Active' : 'Draft';
// //     final statusColor =
// //     isActive ? const Color(0xFF3FB65D) : const Color(0xFFF5A623);
// //
// //     final planned = shift.allowed ?? 0;
// //     final present = shift.attended?.length ?? 0;
// //
// //     final shiftKey = _shiftKey(shift);
// //     // FIX: this must be the generic shift-type id (`shift.shiftId`), NOT
// //     // `shift.attendanceShiftId`. AddReplacementPopUp sends this value as
// //     // the `shiftId` query param on getAttAvailableGuardsByDate, while
// //     // `shiftModel.attendanceShiftId` (see `_shiftModelFor` above) is sent
// //     // as the path segment — they're two different ids and must not be
// //     // collapsed into the same fallback chain.
// //     final shiftId = shift.shiftId;
// //     final editable = !isReadOnly;
// //
// //     // See CAVEAT on `_parseSlaViolations` re: the assumed `violations` field.
// //     final slaViolations = _parseSlaViolations(shift.slaViolations, statusLabel);
// //
// //     return Container(
// //       decoration: BoxDecoration(
// //         border: Border(top: BorderSide(color: accent, width: 3)),
// //         color: Colors.white.withValues(alpha: 0.92),
// //         borderRadius: BorderRadius.circular(10),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withValues(alpha: 0.06),
// //             blurRadius: 8,
// //             offset: const Offset(0, 3),
// //           ),
// //         ],
// //       ),
// //       padding: const EdgeInsets.all(14),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // Header: avatar + "SHIFT X / time range" + status badge
// //           Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Container(
// //                 width: 26,
// //                 height: 26,
// //                 alignment: Alignment.center,
// //                 decoration: BoxDecoration(
// //                   color: accent.withValues(alpha: 0.15),
// //                   borderRadius: BorderRadius.circular(6),
// //                 ),
// //                 child: Text(
// //                   (shift.shift ?? '?').toUpperCase(),
// //                   style: TextStyle(
// //                     color: accent,
// //                     fontWeight: FontWeight.w700,
// //                     fontSize: 12,
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(width: 10),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       'SHIFT ${(shift.shift ?? '-').toUpperCase()}',
// //                       style: const TextStyle(
// //                         color: Colors.black45,
// //                         fontWeight: FontWeight.w700,
// //                         fontSize: 11,
// //                         letterSpacing: 0.5,
// //                       ),
// //                     ),
// //                     Text(
// //                       _timeRangeForShift(shift.shift),
// //                       style: const TextStyle(
// //                         color: Colors.black87,
// //                         fontWeight: FontWeight.w700,
// //                         fontSize: 14,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Row(
// //                 children: [
// //                   Container(
// //                     width: 8,
// //                     height: 8,
// //                     decoration: BoxDecoration(
// //                         color: statusColor, shape: BoxShape.circle),
// //                   ),
// //                   const SizedBox(width: 4),
// //                   Text(
// //                     statusLabel,
// //                     style: const TextStyle(
// //                       color: Colors.black87,
// //                       fontWeight: FontWeight.w600,
// //                       fontSize: 12,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //           CommonWidgets.verticalSpacerWidget(height * 0.012),
// //
// //           _plannedPresentRow(planned, present),
// //           CommonWidgets.verticalSpacerWidget(height * 0.012),
// //
// //           // ATTENDANCE MARKING
// //           _sectionHeader(
// //             'ATTENDANCE MARKING',
// //             trailing: null,
// //           ),
// //           const SizedBox(height: 6),
// //           _attendanceMarkingBox(shift, shiftKey, editable),
// //           const SizedBox(height: 12),
// //
// //           // REPLACEMENTS — only shown for active shifts, matching Shift A
// //           // / Shift G in the reference (Shift B / C don't show it).
// //           if (isActive) ...[
// //             _sectionHeader(
// //               'REPLACEMENTS',
// //               trailing: editable
// //                   ? _addIconButton(() {
// //                 if (dutyPostId == null ||
// //                     rankId == null ||
// //                     shiftId == null ||
// //                     shift.attendanceShiftId == null) {
// //                   Validator().showToast(
// //                     context,
// //                     'Please select a valid duty post, rank and shift '
// //                         'before adding a replacement.',
// //                   );
// //                   return;
// //                 }
// //
// //                 showReplacementPopUp(
// //                   context: context,
// //                   model: Replacement(),
// //                   selectedGuards: _selectableReplacementGuards(shift),
// //                   state: state,
// //                   rankId: rankId,
// //                   shiftId: shiftId,
// //                   dutyPostId: dutyPostId,
// //                   attendanceId: widget.attInfoId,
// //                   shiftModel: _shiftModelFor(shift),
// //                 );
// //               })
// //                   : null,
// //             ),
// //             const SizedBox(height: 6),
// //             // FIX: this used to read from a local-only placeholder map that
// //             // was never populated, so real replacements (either already on
// //             // the record, or newly added through the popup) never showed
// //             // up here. It now renders `shift.replacements`, the actual data
// //             // coming back from the API, and lets you tap a row to edit it.
// //             _replacementsBox(
// //               shift,
// //               dutyPostId: dutyPostId,
// //               rankId: rankId,
// //               shiftId: shiftId,
// //               state: state,
// //               editable: editable,
// //             ),
// //             const SizedBox(height: 12),
// //           ],
// //
// //           // SLA VIOLATION LIST
// //           _sectionHeader(
// //             'SLA VIOLATION LIST',
// //             trailing: editable
// //                 ? _addIconButton(() => _onAddSlaViolation(shift, state))
// //                 : null,
// //           ),
// //           const SizedBox(height: 6),
// //           if (slaViolations.isEmpty)
// //             _emptyStateBox('No SLA violations added yet')
// //           else
// //             Column(
// //               children:
// //               slaViolations.map((sla) => _slaViolationCard(sla)).toList(),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // ---------------------------------------------------------------------
// //   // SLA VIOLATION LIST
// //   // ---------------------------------------------------------------------
// //
// //   Widget _slaViolationCard(ShiftSlaViolation sla) {
// //     final isCollapsed = _collapsedSlaIds.contains(sla.id);
// //     return Container(
// //       width: double.infinity,
// //       margin: const EdgeInsets.only(bottom: 10),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(8),
// //         border: Border.all(color: Colors.black12),
// //       ),
// //       clipBehavior: Clip.antiAlias,
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           InkWell(
// //             onTap: () {
// //               setState(() {
// //                 if (isCollapsed) {
// //                   _collapsedSlaIds.remove(sla.id);
// //                 } else {
// //                   _collapsedSlaIds.add(sla.id);
// //                 }
// //               });
// //             },
// //             child: Container(
// //               width: double.infinity,
// //               color: const Color(0xFF3D6DB0),
// //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
// //               child: Row(
// //                 children: [
// //                   Expanded(
// //                     child: Text.rich(
// //                       TextSpan(
// //                         children: [
// //                           TextSpan(
// //                             text: sla.typeOfService,
// //                             style: const TextStyle(
// //                               color: Colors.white,
// //                               fontWeight: FontWeight.w700,
// //                               fontSize: 13,
// //                             ),
// //                           ),
// //                           TextSpan(
// //                             text: '   ${sla.status}   ${sla.dateOfCreation}',
// //                             style: const TextStyle(
// //                               color: Colors.white70,
// //                               fontWeight: FontWeight.w400,
// //                               fontSize: 12,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                   ),
// //                   Icon(
// //                     isCollapsed
// //                         ? Icons.keyboard_arrow_down
// //                         : Icons.keyboard_arrow_up,
// //                     color: Colors.white,
// //                     size: 18,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           if (!isCollapsed)
// //             Padding(
// //               padding: const EdgeInsets.all(12),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Expanded(
// //                           child: _readOnlyField(label: 'ID', value: sla.id)),
// //                       const SizedBox(width: 12),
// //                       Expanded(
// //                           child: _readOnlyField(
// //                               label: 'REGION', value: sla.region)),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 12),
// //                   Row(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Expanded(
// //                           child: _readOnlyField(
// //                               label: 'LOCATION', value: sla.location)),
// //                       const SizedBox(width: 12),
// //                       Expanded(
// //                           child: _readOnlyField(
// //                               label: 'DATE OF CREATION',
// //                               value: sla.dateOfCreation)),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 12),
// //                   Row(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Expanded(
// //                           child: _readOnlyField(
// //                               label: 'CREATED BY', value: sla.createdBy)),
// //                       const SizedBox(width: 12),
// //                       Expanded(
// //                           child: _readOnlyField(label: 'ASL', value: sla.asl)),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 12),
// //                   Row(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Expanded(
// //                           child: _readOnlyField(
// //                               label: 'TYPE OF SERVICE',
// //                               value: sla.typeOfService)),
// //                       const SizedBox(width: 12),
// //                       Expanded(
// //                           child: _readOnlyField(
// //                               label: 'STATUS', value: sla.status)),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _sectionHeader(String title, {Widget? trailing}) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(
// //           title,
// //           style: const TextStyle(
// //             color: Colors.black87,
// //             fontWeight: FontWeight.w700,
// //             fontSize: 12,
// //             letterSpacing: 0.4,
// //           ),
// //         ),
// //         if (trailing != null) trailing,
// //       ],
// //     );
// //   }
// //
// //   Widget _addIconButton(VoidCallback onTap) {
// //     return InkWell(
// //       onTap: onTap,
// //       borderRadius: BorderRadius.circular(20),
// //       child: Container(
// //         width: 26,
// //         height: 26,
// //         decoration: const BoxDecoration(
// //           color: Color(0xFF5B4FCF),
// //           shape: BoxShape.circle,
// //         ),
// //         child: const Icon(Icons.add, color: Colors.white, size: 16),
// //       ),
// //     );
// //   }
// //
// //   Widget _emptyStateBox(String message) {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.symmetric(vertical: 16),
// //       decoration: BoxDecoration(
// //         color: Colors.grey.shade50,
// //         border: Border.all(color: Colors.grey.shade300),
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       alignment: Alignment.center,
// //       child: Text(
// //         message,
// //         style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
// //       ),
// //     );
// //   }
// //
// //   Widget _plannedPresentRow(int planned, int present) {
// //     return Text.rich(
// //       TextSpan(
// //         children: [
// //           const TextSpan(
// //             text: 'Planned: ',
// //             style: TextStyle(
// //                 color: Colors.black87,
// //                 fontWeight: FontWeight.w700,
// //                 fontSize: 13),
// //           ),
// //           TextSpan(
// //             text: '$planned  ',
// //             style: const TextStyle(
// //                 color: Colors.black87,
// //                 fontWeight: FontWeight.w700,
// //                 fontSize: 13),
// //           ),
// //           const TextSpan(
// //             text: 'Present: ',
// //             style: TextStyle(
// //                 color: Colors.black87,
// //                 fontWeight: FontWeight.w700,
// //                 fontSize: 13),
// //           ),
// //           TextSpan(
// //             text: '$present',
// //             style: const TextStyle(
// //                 color: Colors.black87,
// //                 fontWeight: FontWeight.w700,
// //                 fontSize: 13),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // ---------------------------------------------------------------------
// //   // ATTENDANCE MARKING
// //   // ---------------------------------------------------------------------
// //   Widget _attendanceMarkingBox(Shifts shift, String shiftKey, bool editable) {
// //     final attended = shift.attended ?? const <Attended>[];
// //     if (attended.isEmpty) {
// //       return _emptyStateBox('No guards marked attended yet');
// //     }
// //
// //     final newlyAdded = _newlyAddedGuardIdsByShift[shiftKey] ?? const <int>{};
// //
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //       decoration: BoxDecoration(
// //         color: Colors.grey.shade50,
// //         border: Border.all(color: Colors.grey.shade300),
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: Column(
// //         children: attended.map((guard) {
// //           final canRemove =
// //               editable && guard.id != null && newlyAdded.contains(guard.id);
// //           return Padding(
// //             padding: const EdgeInsets.symmetric(vertical: 6),
// //             child: Row(
// //               children: [
// //                 CircleAvatar(
// //                   radius: 12,
// //                   backgroundColor: const Color(0xFFEDE9FE),
// //                   child: Text(
// //                     (guard.name?.isNotEmpty == true)
// //                         ? guard.name![0].toUpperCase()
// //                         : '?',
// //                     style: const TextStyle(
// //                       color: Color(0xFF5B4FCF),
// //                       fontWeight: FontWeight.w700,
// //                       fontSize: 11,
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 8),
// //                 Expanded(
// //                   child: Text(
// //                     guard.name ?? '-',
// //                     style: const TextStyle(
// //                         color: Colors.black87, fontWeight: FontWeight.w600),
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                 ),
// //                 if (canRemove)
// //                   OutlinedButton(
// //                     onPressed: () =>
// //                         _removeAttendedGuard(shift, shiftKey, guard),
// //                     style: OutlinedButton.styleFrom(
// //                       foregroundColor: Colors.red,
// //                       side: const BorderSide(color: Colors.red),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(20),
// //                       ),
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 12, vertical: 2),
// //                       minimumSize: const Size(0, 30),
// //                     ),
// //                     child: const Text('Remove',
// //                         style: TextStyle(fontWeight: FontWeight.w600)),
// //                   ),
// //               ],
// //             ),
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }
// //
// //   // TODO: replace direct field mutation with a real cubit call, e.g.
// //   // BlocProvider.of<AttendanceShiftsCubit>(context).unmarkGuardAttended(guard);
// //   void _removeAttendedGuard(Shifts shift, String shiftKey, Attended guard) {
// //     setState(() {
// //       shift.attended?.removeWhere((a) => a.id == guard.id);
// //       if (guard.id != null) {
// //         _newlyAddedGuardIdsByShift[shiftKey]?.remove(guard.id);
// //       }
// //     });
// //   }
// //
// //   // ---------------------------------------------------------------------
// //   // REPLACEMENTS — driven by the real `shift.replacements` list.
// //   // ---------------------------------------------------------------------
// //   Widget _replacementsBox(
// //       Shifts shift, {
// //         required int? dutyPostId,
// //         required int? rankId,
// //         required int? shiftId,
// //         required AttendanceShiftsState state,
// //         required bool editable,
// //       }) {
// //     final replacements = shift.replacements ?? const <Replacement>[];
// //     if (replacements.isEmpty) {
// //       return _emptyStateBox('No replacements added yet');
// //     }
// //
// //     final canEdit = editable &&
// //         dutyPostId != null &&
// //         rankId != null &&
// //         shiftId != null &&
// //         shift.attendanceShiftId != null;
// //
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
// //       decoration: BoxDecoration(
// //         color: Colors.grey.shade50,
// //         border: Border.all(color: Colors.grey.shade300),
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: Column(
// //         children: replacements.map((r) {
// //           final fromDateLabel =
// //           !r.fromDate.isEmptyOrNull
// //               ? Utils.timestampToDateConversion(
// //             int.tryParse(r.fromDate ?? '0') ?? 0,
// //             Constants.dateFormat,
// //           )
// //               : '-';
// //           final toDateLabel = !r.toDate.isEmptyOrNull
// //               ? Utils.timestampToDateConversion(
// //             int.tryParse(r.toDate ?? '0') ?? 0,
// //             Constants.dateFormat,
// //           )
// //               : '-';
// //           final reasonLabel = r.status != null
// //               ? (Utils().getKeyFromValue(
// //             value: r.status!,
// //             dropdownValues: shiftScheduleReasonDropDownValues,
// //           ) ??
// //               '-')
// //               : '-';
// //
// //           return InkWell(
// //             onTap: canEdit
// //                 ? () => showReplacementPopUp(
// //               context: context,
// //               model: r,
// //               selectedGuards: _selectableReplacementGuards(shift),
// //               state: state,
// //               rankId: rankId,
// //               shiftId: shiftId,
// //               dutyPostId: dutyPostId,
// //               attendanceId: widget.attInfoId,
// //               shiftModel: _shiftModelFor(shift),
// //             )
// //                 : null,
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(vertical: 6),
// //               child: Row(
// //                 children: [
// //                   Expanded(
// //                     flex: 3,
// //                     child: Text(
// //                       r.replacedFor?.name ?? '-',
// //                       style: const TextStyle(
// //                           color: Colors.black87, fontWeight: FontWeight.w600),
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                   ),
// //                   Expanded(
// //                     flex: 3,
// //                     child: Text(
// //                       '$fromDateLabel - $toDateLabel',
// //                       style:
// //                       TextStyle(color: Colors.grey.shade700, fontSize: 12),
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                   ),
// //                   Expanded(
// //                     flex: 2,
// //                     child: Text(
// //                       r.replacementBy?.name ?? '-',
// //                       style:
// //                       TextStyle(color: Colors.grey.shade700, fontSize: 12),
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                   ),
// //                   Expanded(
// //                     flex: 2,
// //                     child: Text(
// //                       reasonLabel,
// //                       style:
// //                       TextStyle(color: Colors.grey.shade700, fontSize: 12),
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         }).toList(),
// //       ),
// //     );
// //   }
// //
// //   void _onAddSlaViolation(Shifts shift, AttendanceShiftsState state) {
// //     FocusScope.of(context).unfocus();
// //     BlocProvider.of<AttendanceShiftsCubit>(context).submitForm(isSaveOnly: true);
// //
// //     Navigator.pushNamed(
// //       context,
// //       slaViolationPenaltyDetailsRoute,
// //       arguments: {
// //         ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
// //         ConstantsArgument.attdId: state.model.id,
// //         ConstantsArgument.location: widget.location,
// //         ConstantsArgument.locationRegion: widget.locationRegion,
// //         ConstantsArgument.vendor: widget.vendor,
// //       },
// //     ).then((_) {
// //       if (!mounted) return;
// //       BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// //     });
// //   }
// //
// //   void showReplacementPopUp({
// //     required BuildContext context,
// //     required Replacement model,
// //     required Set<BaseUser> selectedGuards,
// //     required AttendanceShiftsState state,
// //     required int rankId,
// //     required int shiftId,
// //     required int dutyPostId,
// //     required int attendanceId,
// //     required ShiftModel shiftModel,
// //   }) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext dialogContext) {
// //         return AddReplacementPopUp(
// //           viaAttendance: true,
// //           model: model,
// //           mainContext: context,
// //           selectedGuards: selectedGuards,
// //           attendanceModel: state.model,
// //           shiftModel: shiftModel,
// //           shiftId: shiftId,
// //           rankId: rankId,
// //           dutyPostId: dutyPostId,
// //           attendanceId: attendanceId,
// //         );
// //       },
// //     ).then((_) {
// //       // Refresh so any edits made in the popup are reflected here.
// //       if (!mounted) return;
// //       BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
// //     });
// //   }
// // }
// import 'dart:ui';
//
// import 'package:db_atom/index.dart';
//
// import '../../attendance_details/views/attendance_details_view.dart';
// import '../../models/dutyPost_attendance_model.dart';
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
// class ShiftSlaViolation {
//   final String id;
//   final String region;
//   final String location;
//   final String dateOfCreation;
//   final String createdBy;
//   final String asl;
//   final String typeOfService;
//   final String status;
//
//   ShiftSlaViolation({
//     required this.id,
//     required this.region,
//     required this.location,
//     required this.dateOfCreation,
//     required this.createdBy,
//     required this.asl,
//     required this.typeOfService,
//     required this.status,
//   });
// }
//
// Widget _readOnlyField({required String label, required String value}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         label,
//         style: const TextStyle(
//           color: Colors.black,
//           fontSize: 11,
//           fontWeight: FontWeight.w700,
//           letterSpacing: 0.5,
//         ),
//       ),
//       const SizedBox(height: 6),
//       Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: 0.9),
//           borderRadius: BorderRadius.circular(6),
//           border: Border.all(color: const Color(0xFF3D6DB0)),
//         ),
//         child: Text(
//           value,
//           style: const TextStyle(color: Colors.black87),
//         ),
//       ),
//     ],
//   );
// }
//
// class AttendanceShiftsViewState extends State<AttendanceShiftsView> {
//   bool isReadOnly = false;
//
//   // Accordion expand/collapse state — duty posts & ranks start expanded;
//   // a key only ever lands in these sets once the user *collapses* it.
//   final Set<String> _collapsedDutyPostKeys = {};
//   final Set<String> _collapsedRankKeys = {};
//
//   // Tracks which guard ids were added to a shift's attendance *in this
//   // session*, so only those rows show a "Remove" button — guards already
//   // attended before the screen opened stay locked. Keyed by `_shiftKey`.
//   final Map<String, Set<int>> _newlyAddedGuardIdsByShift = {};
//
//   // Card accent palette cycled per shift position within a rank, matching
//   // the orange / blue / red / green top borders in the reference design.
//   static const List<Color> _shiftAccentColors = [
//     Color(0xFFF5A623), // orange
//     Color(0xFF3D6DB0), // blue
//     Color(0xFFD64545), // red
//     Color(0xFF3FB65D), // green
//   ];
//
//   final Set<String> _collapsedSlaIds = {};
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
//           var dialog = CustomAlertDialog(
//             title: 'Attendance',
//             message: state.message ?? '',
//             positiveBtnText: Constants.ok,
//             onPositivePressed: () {
//               Navigator.pop(context);
//               Navigator.pop(context);
//               Navigator.popAndPushNamed(
//                 context,
//                 attendanceListRoute,
//                 arguments: {},
//               );
//             },
//           );
//           showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) => dialog);
//         }
//       },
//       builder: (context, state) {
//         isReadOnly = widget.isReadOnly ||
//             !widget.isEligibleToEdit ||
//             !state.model.lock.isEmptyOrNull;
//
//         return Scaffold(
//           backgroundColor: Colors.transparent,
//           extendBodyBehindAppBar: true,
//           appBar: BaseAppBar().buildAppHeader(
//             context: context,
//             title: 'Attendance',
//             showPopUp: false,
//             showSaveButton: false,
//             showSubmitButton: !isReadOnly && state.status != FormStatus.loading,
//             showDisLikeButton: false,
//             showLikeButton: false,
//             popAndReplace: () {
//               int flag = AttendanceDetailsView.flag;
//               if (flag == 1) {
//                 Navigator.pop(context);
//               } else {
//                 Navigator.pop(context);
//               }
//             },
//             onTapSubmit: () {
//               FocusScope.of(context).unfocus();
//               BlocProvider.of<AttendanceShiftsCubit>(context)
//                   .submitForm(isSaveOnly: false);
//             },
//           ),
//
//           // ================= BODY WITH BACKGROUND =================
//           body: Stack(
//             children: [
//               Positioned.fill(
//                 child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
//               ),
//               Positioned.fill(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
//                   child: Container(color: Colors.black.withValues(alpha: 0.15)),
//                 ),
//               ),
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
//                           getBody(state, height),
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
//   // ---------------------------------------------------------------------
//   // BODY
//   // ---------------------------------------------------------------------
//   Widget getBody(AttendanceShiftsState state, double height) {
//     if (state.status == FormStatus.loading) {
//       return const BaseLoader();
//     }
//
//     final dutyPosts =
//         state.dutyPostAttendanceModel?.dutyPosts ?? const <DutyPosts>[];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (!state.model.lock.isEmptyOrNull) ...[
//           RecordLockedWidget(text: '${state.model.lock}'),
//           CommonWidgets.verticalSpacerWidget(height * 0.02),
//         ],
//         if (dutyPosts.isEmpty)
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 24),
//             child: Text(
//               'No duty posts found for this attendance record.',
//               style: Styles.textStyleWhite16,
//             ),
//           )
//         else
//           for (final dutyPost in dutyPosts) ...[
//             _buildDutyPostAccordion(dutyPost, height, state),
//             CommonWidgets.verticalSpacerWidget(height * 0.02),
//           ],
//       ],
//     );
//   }
//
//   // ---------------------------------------------------------------------
//   // DUTY POST ACCORDION  (e.g. "Basement")
//   // ---------------------------------------------------------------------
//   Widget _buildDutyPostAccordion(
//       DutyPosts dutyPost, double height, AttendanceShiftsState state) {
//     final key = 'dutypost_${dutyPost.dutyPostNameId}_${dutyPost.dutyPostName}';
//     final isExpanded = !_collapsedDutyPostKeys.contains(key);
//     final label = dutyPost.dutyPostName ?? '-';
//
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFF5B4FCF)),
//         borderRadius: BorderRadius.circular(8),
//         color: Colors.white.withValues(alpha: 0.04),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _accordionHeader(
//             avatarText: label.isNotEmpty ? label[0].toUpperCase() : '?',
//             title: label,
//             isExpanded: isExpanded,
//             onTap: () => setState(() {
//               if (isExpanded) {
//                 _collapsedDutyPostKeys.add(key);
//               } else {
//                 _collapsedDutyPostKeys.remove(key);
//               }
//             }),
//           ),
//           if (isExpanded)
//             Padding(
//               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//               child: Column(
//                 children: [
//                   for (final rank in dutyPost.ranks ?? const <Ranks>[]) ...[
//                     // dutyPostNameId is only known at this level of the
//                     // tree, so it gets threaded down through
//                     // rank -> shift-grid -> shift-card, all the way to
//                     // where the "Add Replacement" button needs it.
//                     _buildRankAccordion(
//                       rank,
//                       height,
//                       state,
//                       dutyPost.dutyPostNameId,
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // ---------------------------------------------------------------------
//   // RANK ACCORDION  (e.g. "RANK: SECURITY GUARD/LADY SECURITY GUARD")
//   // ---------------------------------------------------------------------
//   Widget _buildRankAccordion(Ranks rank, double height,
//       AttendanceShiftsState state, int? dutyPostId) {
//     final key = 'rank_${rank.rankId}_${rank.rankName}';
//     final isExpanded = !_collapsedRankKeys.contains(key);
//     final title = 'RANK: ${(rank.rankName ?? '-').toUpperCase()}';
//
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFF5B4FCF)),
//         borderRadius: BorderRadius.circular(8),
//         color: Colors.white.withValues(alpha: 0.01),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _accordionHeader(
//             avatarText: _initialsFor(rank.rankName ?? ''),
//             title: title,
//             isExpanded: isExpanded,
//             onTap: () => setState(() {
//               if (isExpanded) {
//                 _collapsedRankKeys.add(key);
//               } else {
//                 _collapsedRankKeys.remove(key);
//               }
//             }),
//           ),
//           if (isExpanded)
//             Padding(
//               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//               child: _buildShiftCardsGrid(
//                 rank.shifts ?? const <Shifts>[],
//                 height,
//                 state,
//                 dutyPostId,
//                 rank.rankId,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   String _initialsFor(String label) {
//     final words = label.trim().split(RegExp(r'\s+'));
//     if (words.isEmpty || words.first.isEmpty) return '?';
//     return words
//         .take(2)
//         .map((w) => w.isNotEmpty ? w[0] : '')
//         .join()
//         .toUpperCase();
//   }
//
//   Widget _accordionHeader({
//     required String avatarText,
//     required String title,
//     required bool isExpanded,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 12,
//               backgroundColor: Colors.white24,
//               child: Text(
//                 avatarText,
//                 style: const TextStyle(color: Colors.white, fontSize: 10),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 13,
//                 ),
//               ),
//             ),
//             Icon(
//               isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//               color: Colors.white70,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ---------------------------------------------------------------------
//   // SHIFT CARDS GRID  (Shift A / B / C / G laid out 2-up, like the ref)
//   // ---------------------------------------------------------------------
//   Widget _buildShiftCardsGrid(
//       List<Shifts> shifts,
//       double height,
//       AttendanceShiftsState state,
//       int? dutyPostId,
//       int? rankId,
//       ) {
//     if (shifts.isEmpty) {
//       return const Padding(
//         padding: EdgeInsets.symmetric(vertical: 12),
//         child: Text(
//           'No shifts under this rank.',
//           style: Styles.textStyleWhite16,
//         ),
//       );
//     }
//
//     final width = MediaQuery.of(context).size.width;
//     final isTablet = width > Constants.tabletScreenWidth;
//     // Two columns on tablet/desktop widths, single column on phones —
//     // matches the 2-up grid in the reference screenshot.
//     final cardWidth = isTablet ? (width - 60) / 2 : width - 40;
//
//     return Wrap(
//       spacing: 12,
//       runSpacing: 12,
//       children: [
//         for (var i = 0; i < shifts.length; i++)
//           SizedBox(
//             width: cardWidth,
//             child: _buildShiftCard(
//               shifts[i],
//               i,
//               height,
//               state,
//               dutyPostId,
//               rankId,
//             ),
//           ),
//       ],
//     );
//   }
//
//   String _shiftKey(Shifts shift) =>
//       'shift_${shift.attendanceShiftId ?? shift.shiftId}';
//
//   String _timeRangeForShift(String? shiftLabel) {
//     final normalized = (shiftLabel ?? '').toLowerCase().trim();
//     if (normalized == 'a') return '7AM - 3PM';
//     if (normalized == 'b') return '3PM - 11PM';
//     if (normalized == 'c') return '11PM - 7AM';
//     if (normalized == 'g') return '9AM - 6PM';
//     return '-';
//   }
//
//   Set<BaseUser> _selectableReplacementGuards(Shifts shift) {
//     return (shift.selectForReplacements ?? const <SelectForReplacements>[])
//         .map((g) => BaseUser(id: g.id, name: g.name))
//         .toSet();
//   }
//
//   // FIX: AddReplacementPopUp (viaAttendance path) still reads
//   // `widget.shiftModel!.attendanceShiftId!` when looking up "replacement
//   // by" guards — but this screen only ever passed `attendanceModel`, never
//   // `shiftModel`, so that call crashed with a null-check error as soon as
//   // a reason value of '1' was picked. Since AddReplacementPopUp itself is
//   // not being touched, we build the small ShiftModel it expects here, from
//   // the Shifts data we already have, and pass it through.
//   //
//   // IMPORTANT: `attendanceShiftId` here must be the shift's OWN
//   // `attendanceShiftId` — do NOT fall back to `shift.shiftId`. Inside
//   // AddReplacementPopUp.getReplacementByUserListForAttendance(), this
//   // value is sent as the `dutyPostId` path segment of
//   // getAttAvailableGuardsByDate, while `widget.shiftId` (a separate,
//   // distinct value — see `shiftId` in _buildShiftCard) is sent as the
//   // `shiftId` query param. Falling back to the same field for both is
//   // what caused the request to go out as
//   // `.../getAttAvailableGuardsByDate/2390?...&shiftId=2390` — the same
//   // id used twice instead of two different ones.
//   ShiftModel _shiftModelFor(Shifts shift) {
//     return ShiftModel(
//       shift: shift.shift,
//       attendanceShiftId: shift.attendanceShiftId,
//       allowed: shift.allowed,
//       attdStatus: shift.attdStatus,
//       activeShift: shift.activeShift ?? false,
//     );
//   }
//
//   List<ShiftSlaViolation> _parseSlaViolations(
//       List<dynamic>? violations, String fallbackStatus) {
//     return (violations ?? const []).map((v) {
//       if (v is Map) {
//         final location = v['location'] as Map?;
//         final locationRegion = v['locationRegion'] as Map?;
//         final entrySecurity = v['entrySecurity'] as Map?;
//         final approver = v['approver'] as Map?;
//         final typeOfServiceList = v['typeOfService'] as List?;
//
//         String fullName(Map? user) {
//           if (user == null) return '-';
//           final userInfo = user['userInfo'] as String?;
//           if (userInfo != null && userInfo.isNotEmpty) return userInfo;
//           final first = user['firstName'] as String? ?? '';
//           final last = user['lastName'] as String? ?? '';
//           final combined = '$first $last'.trim();
//           return combined.isNotEmpty ? combined : '-';
//         }
//
//         String formatEpochMs(dynamic epochMs) {
//           if (epochMs == null) return '-';
//           final millis = epochMs is int ? epochMs : int.tryParse('$epochMs');
//           if (millis == null) return '-';
//           final date = DateTime.fromMillisecondsSinceEpoch(millis);
//           return '${date.day.toString().padLeft(2, '0')}/'
//               '${date.month.toString().padLeft(2, '0')}/'
//               '${date.year} ${date.hour.toString().padLeft(2, '0')}:'
//               '${date.minute.toString().padLeft(2, '0')}';
//         }
//
//         return ShiftSlaViolation(
//           id: '${v['id'] ?? v['slNo'] ?? '-'}',
//           region: locationRegion?['name'] as String? ?? '-',
//           location: location?['name'] as String? ?? '-',
//           dateOfCreation: formatEpochMs(v['inputDate']),
//           createdBy: fullName(entrySecurity),
//           asl: fullName(approver),
//           typeOfService: (typeOfServiceList ?? const [])
//               .map((t) => (t as Map?)?['name'] as String? ?? '')
//               .where((s) => s.isNotEmpty)
//               .join(', '),
//           status: v['statusLabel'] as String? ?? fallbackStatus,
//         );
//       }
//       return ShiftSlaViolation(
//         id: '-',
//         region: '-',
//         location: '-',
//         dateOfCreation: '-',
//         createdBy: '-',
//         asl: '-',
//         typeOfService: '',
//         status: fallbackStatus,
//       );
//     }).toList();
//   }
//
//   Widget _buildShiftCard(
//       Shifts shift,
//       int index,
//       double height,
//       AttendanceShiftsState state,
//       int? dutyPostId,
//       int? rankId,
//       ) {
//     final accent = _shiftAccentColors[index % _shiftAccentColors.length];
//     final isActive = shift.activeShift == true;
//     final statusLabel = isActive ? 'Active' : 'Draft';
//     final statusColor =
//     isActive ? const Color(0xFF3FB65D) : const Color(0xFFF5A623);
//
//     final planned = shift.allowed ?? 0;
//     final present = shift.attended?.length ?? 0;
//
//     final shiftKey = _shiftKey(shift);
//     // FIX: this must be the generic shift-type id (`shift.shiftId`), NOT
//     // `shift.attendanceShiftId`. AddReplacementPopUp sends this value as
//     // the `shiftId` query param on getAttAvailableGuardsByDate, while
//     // `shiftModel.attendanceShiftId` (see `_shiftModelFor` above) is sent
//     // as the path segment — they're two different ids and must not be
//     // collapsed into the same fallback chain.
//     final shiftId = shift.shiftId;
//     final editable = !isReadOnly;
//
//     // See CAVEAT on `_parseSlaViolations` re: the assumed `violations` field.
//     final slaViolations = _parseSlaViolations(shift.slaViolations, statusLabel);
//
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(top: BorderSide(color: accent, width: 3)),
//         color: Colors.white.withValues(alpha: 0.92),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.06),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(14),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header: avatar + "SHIFT X / time range" + status badge
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 26,
//                 height: 26,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: accent.withValues(alpha: 0.15),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Text(
//                   (shift.shift ?? '?').toUpperCase(),
//                   style: TextStyle(
//                     color: accent,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'SHIFT ${(shift.shift ?? '-').toUpperCase()}',
//                       style: const TextStyle(
//                         color: Colors.black45,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 11,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                     Text(
//                       _timeRangeForShift(shift.shift),
//                       style: const TextStyle(
//                         color: Colors.black87,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [
//                   Container(
//                     width: 8,
//                     height: 8,
//                     decoration: BoxDecoration(
//                         color: statusColor, shape: BoxShape.circle),
//                   ),
//                   const SizedBox(width: 4),
//                   Text(
//                     statusLabel,
//                     style: const TextStyle(
//                       color: Colors.black87,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           CommonWidgets.verticalSpacerWidget(height * 0.012),
//
//           _plannedPresentRow(planned, present),
//           CommonWidgets.verticalSpacerWidget(height * 0.012),
//
//           // ATTENDANCE MARKING
//           _sectionHeader(
//             'ATTENDANCE MARKING',
//             trailing: null,
//           ),
//           const SizedBox(height: 6),
//           _attendanceMarkingBox(shift, shiftKey, editable),
//           const SizedBox(height: 12),
//
//           // REPLACEMENTS — only shown for active shifts, matching Shift A
//           // / Shift G in the reference (Shift B / C don't show it).
//           if (isActive) ...[
//             _sectionHeader(
//               'REPLACEMENTS',
//               trailing: editable
//                   ? _addIconButton(() {
//                 if (dutyPostId == null ||
//                     rankId == null ||
//                     shiftId == null ||
//                     shift.attendanceShiftId == null) {
//                   Validator().showToast(
//                     context,
//                     'Please select a valid duty post, rank and shift '
//                         'before adding a replacement.',
//                   );
//                   return;
//                 }
//
//                 showReplacementPopUp(
//                   context: context,
//                   model: Replacement(),
//                   selectedGuards: _selectableReplacementGuards(shift),
//                   state: state,
//                   rankId: rankId,
//                   shiftId: shiftId,
//                   dutyPostId: dutyPostId,
//                   attendanceId: widget.attInfoId,
//                   shiftModel: _shiftModelFor(shift),
//                 );
//               })
//                   : null,
//             ),
//             const SizedBox(height: 6),
//             // FIX: this used to read from a local-only placeholder map that
//             // was never populated, so real replacements (either already on
//             // the record, or newly added through the popup) never showed
//             // up here. It now renders `shift.replacements`, the actual data
//             // coming back from the API, and lets you tap a row to edit it.
//             _replacementsBox(
//               shift,
//               dutyPostId: dutyPostId,
//               rankId: rankId,
//               shiftId: shiftId,
//               state: state,
//               editable: editable,
//             ),
//             const SizedBox(height: 12),
//           ],
//
//           // SLA VIOLATION LIST
//           _sectionHeader(
//             'SLA VIOLATION LIST',
//             trailing: editable
//                 ? _addIconButton(() => _onAddSlaViolation(shift, state))
//                 : null,
//           ),
//           const SizedBox(height: 6),
//           if (slaViolations.isEmpty)
//             _emptyStateBox('No SLA violations added yet')
//           else
//             Column(
//               children:
//               slaViolations.map((sla) => _slaViolationCard(sla)).toList(),
//             ),
//         ],
//       ),
//     );
//   }
//
//   // ---------------------------------------------------------------------
//   // SLA VIOLATION LIST
//   // ---------------------------------------------------------------------
//
//   Widget _slaViolationCard(ShiftSlaViolation sla) {
//     final isCollapsed = _collapsedSlaIds.contains(sla.id);
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.black12),
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           InkWell(
//             onTap: () {
//               setState(() {
//                 if (isCollapsed) {
//                   _collapsedSlaIds.remove(sla.id);
//                 } else {
//                   _collapsedSlaIds.add(sla.id);
//                 }
//               });
//             },
//             child: Container(
//               width: double.infinity,
//               color: const Color(0xFF3D6DB0),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text.rich(
//                       TextSpan(
//                         children: [
//                           TextSpan(
//                             text: sla.typeOfService,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 13,
//                             ),
//                           ),
//                           TextSpan(
//                             text: '   ${sla.status}   ${sla.dateOfCreation}',
//                             style: const TextStyle(
//                               color: Colors.white70,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(
//                     isCollapsed
//                         ? Icons.keyboard_arrow_down
//                         : Icons.keyboard_arrow_up,
//                     color: Colors.white,
//                     size: 18,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (!isCollapsed)
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                           child: _readOnlyField(label: 'ID', value: sla.id)),
//                       const SizedBox(width: 12),
//                       Expanded(
//                           child: _readOnlyField(
//                               label: 'REGION', value: sla.region)),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                           child: _readOnlyField(
//                               label: 'LOCATION', value: sla.location)),
//                       const SizedBox(width: 12),
//                       Expanded(
//                           child: _readOnlyField(
//                               label: 'DATE OF CREATION',
//                               value: sla.dateOfCreation)),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                           child: _readOnlyField(
//                               label: 'CREATED BY', value: sla.createdBy)),
//                       const SizedBox(width: 12),
//                       Expanded(
//                           child: _readOnlyField(label: 'ASL', value: sla.asl)),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                           child: _readOnlyField(
//                               label: 'TYPE OF SERVICE',
//                               value: sla.typeOfService)),
//                       const SizedBox(width: 12),
//                       Expanded(
//                           child: _readOnlyField(
//                               label: 'STATUS', value: sla.status)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _sectionHeader(String title, {Widget? trailing}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.w700,
//             fontSize: 12,
//             letterSpacing: 0.4,
//           ),
//         ),
//         if (trailing != null) trailing,
//       ],
//     );
//   }
//
//   Widget _addIconButton(VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(20),
//       child: Container(
//         width: 26,
//         height: 26,
//         decoration: const BoxDecoration(
//           color: Color(0xFF5B4FCF),
//           shape: BoxShape.circle,
//         ),
//         child: const Icon(Icons.add, color: Colors.white, size: 16),
//       ),
//     );
//   }
//
//   Widget _emptyStateBox(String message) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       alignment: Alignment.center,
//       child: Text(
//         message,
//         style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
//       ),
//     );
//   }
//
//   Widget _plannedPresentRow(int planned, int present) {
//     return Text.rich(
//       TextSpan(
//         children: [
//           const TextSpan(
//             text: 'Planned: ',
//             style: TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 13),
//           ),
//           TextSpan(
//             text: '$planned  ',
//             style: const TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 13),
//           ),
//           const TextSpan(
//             text: 'Present: ',
//             style: TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 13),
//           ),
//           TextSpan(
//             text: '$present',
//             style: const TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 13),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ---------------------------------------------------------------------
//   // ATTENDANCE MARKING
//   // ---------------------------------------------------------------------
//   Widget _attendanceMarkingBox(Shifts shift, String shiftKey, bool editable) {
//     final attended = shift.attended ?? const <Attended>[];
//     if (attended.isEmpty) {
//       return _emptyStateBox('No guards marked attended yet');
//     }
//
//     final newlyAdded = _newlyAddedGuardIdsByShift[shiftKey] ?? const <int>{};
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         children: attended.map((guard) {
//           final canRemove =
//               editable && guard.id != null && newlyAdded.contains(guard.id);
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 6),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 12,
//                   backgroundColor: const Color(0xFFEDE9FE),
//                   child: Text(
//                     (guard.name?.isNotEmpty == true)
//                         ? guard.name![0].toUpperCase()
//                         : '?',
//                     style: const TextStyle(
//                       color: Color(0xFF5B4FCF),
//                       fontWeight: FontWeight.w700,
//                       fontSize: 11,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     guard.name ?? '-',
//                     style: const TextStyle(
//                         color: Colors.black87, fontWeight: FontWeight.w600),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 if (canRemove)
//                   OutlinedButton(
//                     onPressed: () =>
//                         _removeAttendedGuard(shift, shiftKey, guard),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: Colors.red,
//                       side: const BorderSide(color: Colors.red),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 2),
//                       minimumSize: const Size(0, 30),
//                     ),
//                     child: const Text('Remove',
//                         style: TextStyle(fontWeight: FontWeight.w600)),
//                   ),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   // TODO: replace direct field mutation with a real cubit call, e.g.
//   // BlocProvider.of<AttendanceShiftsCubit>(context).unmarkGuardAttended(guard);
//   void _removeAttendedGuard(Shifts shift, String shiftKey, Attended guard) {
//     setState(() {
//       shift.attended?.removeWhere((a) => a.id == guard.id);
//       if (guard.id != null) {
//         _newlyAddedGuardIdsByShift[shiftKey]?.remove(guard.id);
//       }
//     });
//   }
//
//   // ---------------------------------------------------------------------
//   // REPLACEMENTS — driven by the real `shift.replacements` list.
//   // ---------------------------------------------------------------------
//   Widget _replacementsBox(
//       Shifts shift, {
//         required int? dutyPostId,
//         required int? rankId,
//         required int? shiftId,
//         required AttendanceShiftsState state,
//         required bool editable,
//       }) {
//     final replacements = shift.replacements ?? const <Replacement>[];
//     if (replacements.isEmpty) {
//       return _emptyStateBox('No replacements added yet');
//     }
//
//     final canEdit = editable &&
//         dutyPostId != null &&
//         rankId != null &&
//         shiftId != null &&
//         shift.attendanceShiftId != null;
//
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         children: replacements.map((r) {
//           final fromDateLabel =
//           !r.fromDate.isEmptyOrNull
//               ? Utils.timestampToDateConversion(
//             int.tryParse(r.fromDate ?? '0') ?? 0,
//             Constants.dateFormat,
//           )
//               : '-';
//           final toDateLabel = !r.toDate.isEmptyOrNull
//               ? Utils.timestampToDateConversion(
//             int.tryParse(r.toDate ?? '0') ?? 0,
//             Constants.dateFormat,
//           )
//               : '-';
//           final reasonLabel = r.status != null
//               ? (Utils().getKeyFromValue(
//             value: r.status!,
//             dropdownValues: shiftScheduleReasonDropDownValues,
//           ) ??
//               '-')
//               : '-';
//
//           return InkWell(
//             onTap: canEdit
//                 ? () => showReplacementPopUp(
//               context: context,
//               model: r,
//               selectedGuards: _selectableReplacementGuards(shift),
//               state: state,
//               rankId: rankId,
//               shiftId: shiftId,
//               dutyPostId: dutyPostId,
//               attendanceId: widget.attInfoId,
//               shiftModel: _shiftModelFor(shift),
//             )
//                 : null,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 6),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: Text(
//                       r.replacedFor?.name ?? '-',
//                       style: const TextStyle(
//                           color: Colors.black87, fontWeight: FontWeight.w600),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Text(
//                       '$fromDateLabel - $toDateLabel',
//                       style:
//                       TextStyle(color: Colors.grey.shade700, fontSize: 12),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       r.replacementBy?.name ?? '-',
//                       style:
//                       TextStyle(color: Colors.grey.shade700, fontSize: 12),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Text(
//                       reasonLabel,
//                       style:
//                       TextStyle(color: Colors.grey.shade700, fontSize: 12),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   void _onAddSlaViolation(Shifts shift, AttendanceShiftsState state) {
//     FocusScope.of(context).unfocus();
//     // BlocProvider.of<AttendanceShiftsCubit>(context).submitForm(isSaveOnly: true);
//
//     Navigator.pushNamed(
//       context,
//       slaViolationPenaltyDetailsRoute,
//       arguments: {
//         ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
//         ConstantsArgument.attdInfoId: state.model.id,
//         ConstantsArgument.location: widget.location,
//         ConstantsArgument.locationRegion: widget.locationRegion,
//         ConstantsArgument.vendor: widget.vendor,
//       },
//     ).then((_) {
//       if (!mounted) return;
//       BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
//     });
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
//     required ShiftModel shiftModel,
//   }) {
//     // Tells the cubit which rank/shift this replacement belongs to, since
//     // AddReplacementPopUp's Save button calls updateReplacement(...) with
//     // no rank/shift id of its own.
//     BlocProvider.of<AttendanceShiftsCubit>(context)
//         .setActiveReplacementContext(rankId: rankId, shiftId: shiftId);
//
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AddReplacementPopUp(
//           viaAttendance: true,
//           model: model,
//           mainContext: context,
//           selectedGuards: selectedGuards,
//           attendanceModel: state.model,
//           shiftModel: shiftModel,
//           shiftId: shiftId,
//           rankId: rankId,
//           dutyPostId: dutyPostId,
//           attendanceId: attendanceId,
//         );
//       },
//     ).then((_) {
//       // Refresh so any edits made in the popup are reflected here.
//       if (!mounted) return;
//       BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
//     });
//   }
// }

import 'dart:ui';

import 'package:db_atom/index.dart';

import '../../attendance_details/views/attendance_details_view.dart';
import '../../models/dutyPost_attendance_model.dart';

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

class ShiftSlaViolation {
  final String id;
  final String region;
  final String location;
  final String dateOfCreation;
  final String createdBy;
  final String asl;
  final String typeOfService;
  final String status;

  ShiftSlaViolation({
    required this.id,
    required this.region,
    required this.location,
    required this.dateOfCreation,
    required this.createdBy,
    required this.asl,
    required this.typeOfService,
    required this.status,
  });
}

Widget _readOnlyField({required String label, required String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(height: 6),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF3D6DB0)),
        ),
        child: Text(
          value,
          style: const TextStyle(color: Colors.black87),
        ),
      ),
    ],
  );
}

class AttendanceShiftsViewState extends State<AttendanceShiftsView> {
  bool isReadOnly = false;

  // Accordion expand/collapse state — duty posts & ranks start expanded;
  // a key only ever lands in these sets once the user *collapses* it.
  final Set<String> _collapsedDutyPostKeys = {};
  final Set<String> _collapsedRankKeys = {};

  // Tracks which guard ids were added to a shift's attendance *in this
  // session*, so only those rows show a "Remove" button — guards already
  // attended before the screen opened stay locked. Keyed by `_shiftKey`.
  final Map<String, Set<int>> _newlyAddedGuardIdsByShift = {};

  // Card accent palette cycled per shift position within a rank, matching
  // the orange / blue / red / green top borders in the reference design.
  static const List<Color> _shiftAccentColors = [
    Color(0xFFF5A623), // orange
    Color(0xFF3D6DB0), // blue
    Color(0xFFD64545), // red
    Color(0xFF3FB65D), // green
  ];

  final Set<String> _collapsedSlaIds = {};

  // Expand/collapse state for individual replacement cards — a replacement
  // starts expanded (matching the reference design) and only lands in this
  // set once the user collapses it. Keyed by a stable per-row key built in
  // `_replacementsBox`.
  final Set<String> _collapsedReplacementIds = {};

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
          var dialog = CustomAlertDialog(
            title: 'Attendance',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                attendanceListRoute,
                arguments: {},
              );
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
      },
      builder: (context, state) {
        isReadOnly = widget.isReadOnly ||
            !widget.isEligibleToEdit ||
            !state.model.lock.isEmptyOrNull;

        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: 'Attendance',
            showPopUp: false,
            showSaveButton: false,
            showSubmitButton: !isReadOnly && state.status != FormStatus.loading,
            showDisLikeButton: false,
            showLikeButton: false,
            popAndReplace: () {
              int flag = AttendanceDetailsView.flag;
              if (flag == 1) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<AttendanceShiftsCubit>(context)
                  .submitForm(isSaveOnly: false);
            },
          ),

          // ================= BODY WITH BACKGROUND =================
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(color: Colors.black.withValues(alpha: 0.15)),
                ),
              ),
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
                          getBody(state, height),
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

  // ---------------------------------------------------------------------
  // BODY
  // ---------------------------------------------------------------------
  Widget getBody(AttendanceShiftsState state, double height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    final dutyPosts =
        state.dutyPostAttendanceModel?.dutyPosts ?? const <DutyPosts>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!state.model.lock.isEmptyOrNull) ...[
          RecordLockedWidget(text: '${state.model.lock}'),
          CommonWidgets.verticalSpacerWidget(height * 0.02),
        ],
        if (dutyPosts.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'No duty posts found for this attendance record.',
              style: Styles.textStyleWhite16,
            ),
          )
        else
          for (final dutyPost in dutyPosts) ...[
            _buildDutyPostAccordion(dutyPost, height, state),
            CommonWidgets.verticalSpacerWidget(height * 0.02),
          ],
      ],
    );
  }

  // ---------------------------------------------------------------------
  // DUTY POST ACCORDION  (e.g. "Basement")
  // ---------------------------------------------------------------------
  Widget _buildDutyPostAccordion(
      DutyPosts dutyPost, double height, AttendanceShiftsState state) {
    final key = 'dutypost_${dutyPost.dutyPostNameId}_${dutyPost.dutyPostName}';
    final isExpanded = !_collapsedDutyPostKeys.contains(key);
    final label = dutyPost.dutyPostName ?? '-';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF5B4FCF)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withValues(alpha: 0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _accordionHeader(
            avatarText: label.isNotEmpty ? label[0].toUpperCase() : '?',
            title: label,
            isExpanded: isExpanded,
            onTap: () => setState(() {
              if (isExpanded) {
                _collapsedDutyPostKeys.add(key);
              } else {
                _collapsedDutyPostKeys.remove(key);
              }
            }),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                children: [
                  for (final rank in dutyPost.ranks ?? const <Ranks>[]) ...[
                    // dutyPostNameId is only known at this level of the
                    // tree, so it gets threaded down through
                    // rank -> shift-grid -> shift-card, all the way to
                    // where the "Add Replacement" button needs it.
                    _buildRankAccordion(
                      rank,
                      height,
                      state,
                      dutyPost.dutyPostNameId,
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // RANK ACCORDION  (e.g. "RANK: SECURITY GUARD/LADY SECURITY GUARD")
  // ---------------------------------------------------------------------
  Widget _buildRankAccordion(Ranks rank, double height,
      AttendanceShiftsState state, int? dutyPostId) {
    final key = 'rank_${rank.rankId}_${rank.rankName}';
    final isExpanded = !_collapsedRankKeys.contains(key);
    final title = 'RANK: ${(rank.rankName ?? '-').toUpperCase()}';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF5B4FCF)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withValues(alpha: 0.01),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _accordionHeader(
            avatarText: _initialsFor(rank.rankName ?? ''),
            title: title,
            isExpanded: isExpanded,
            onTap: () => setState(() {
              if (isExpanded) {
                _collapsedRankKeys.add(key);
              } else {
                _collapsedRankKeys.remove(key);
              }
            }),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: _buildShiftCardsGrid(
                rank.shifts ?? const <Shifts>[],
                height,
                state,
                dutyPostId,
                rank.rankId,
              ),
            ),
        ],
      ),
    );
  }

  String _initialsFor(String label) {
    final words = label.trim().split(RegExp(r'\s+'));
    if (words.isEmpty || words.first.isEmpty) return '?';
    return words
        .take(2)
        .map((w) => w.isNotEmpty ? w[0] : '')
        .join()
        .toUpperCase();
  }

  Widget _accordionHeader({
    required String avatarText,
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white24,
              child: Text(
                avatarText,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
            Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.white70,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // SHIFT CARDS GRID  (Shift A / B / C / G laid out 2-up, like the ref)
  // ---------------------------------------------------------------------
  Widget _buildShiftCardsGrid(
      List<Shifts> shifts,
      double height,
      AttendanceShiftsState state,
      int? dutyPostId,
      int? rankId,
      ) {
    if (shifts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'No shifts under this rank.',
          style: Styles.textStyleWhite16,
        ),
      );
    }

    final width = MediaQuery.of(context).size.width;
    final isTablet = width > Constants.tabletScreenWidth;
    // Two columns on tablet/desktop widths, single column on phones —
    // matches the 2-up grid in the reference screenshot.
    final cardWidth = isTablet ? (width - 60) / 2 : width - 40;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (var i = 0; i < shifts.length; i++)
          SizedBox(
            width: cardWidth,
            child: _buildShiftCard(
              shifts[i],
              i,
              height,
              state,
              dutyPostId,
              rankId,
            ),
          ),
      ],
    );
  }

  String _shiftKey(Shifts shift) =>
      'shift_${shift.attendanceShiftId ?? shift.shiftId}';

  String _timeRangeForShift(String? shiftLabel) {
    final normalized = (shiftLabel ?? '').toLowerCase().trim();
    if (normalized == 'a') return '7AM - 3PM';
    if (normalized == 'b') return '3PM - 11PM';
    if (normalized == 'c') return '11PM - 7AM';
    if (normalized == 'g') return '9AM - 6PM';
    return '-';
  }

  Set<BaseUser> _selectableReplacementGuards(Shifts shift) {
    return (shift.selectForReplacements ?? const <SelectForReplacements>[])
        .map((g) => BaseUser(id: g.id, name: g.name))
        .toSet();
  }

  // FIX: AddReplacementPopUp (viaAttendance path) still reads
  // `widget.shiftModel!.attendanceShiftId!` when looking up "replacement
  // by" guards — but this screen only ever passed `attendanceModel`, never
  // `shiftModel`, so that call crashed with a null-check error as soon as
  // a reason value of '1' was picked. Since AddReplacementPopUp itself is
  // not being touched, we build the small ShiftModel it expects here, from
  // the Shifts data we already have, and pass it through.
  //
  // IMPORTANT: `attendanceShiftId` here must be the shift's OWN
  // `attendanceShiftId` — do NOT fall back to `shift.shiftId`. Inside
  // AddReplacementPopUp.getReplacementByUserListForAttendance(), this
  // value is sent as the `dutyPostId` path segment of
  // getAttAvailableGuardsByDate, while `widget.shiftId` (a separate,
  // distinct value — see `shiftId` in _buildShiftCard) is sent as the
  // `shiftId` query param. Falling back to the same field for both is
  // what caused the request to go out as
  // `.../getAttAvailableGuardsByDate/2390?...&shiftId=2390` — the same
  // id used twice instead of two different ones.
  ShiftModel _shiftModelFor(Shifts shift) {
    return ShiftModel(
      shift: shift.shift,
      attendanceShiftId: shift.attendanceShiftId,
      allowed: shift.allowed,
      attdStatus: shift.attdStatus,
      activeShift: shift.activeShift ?? false,
    );
  }

  List<ShiftSlaViolation> _parseSlaViolations(
      List<dynamic>? violations, String fallbackStatus) {
    return (violations ?? const []).map((v) {
      if (v is Map) {
        final location = v['location'] as Map?;
        final locationRegion = v['locationRegion'] as Map?;
        final entrySecurity = v['entrySecurity'] as Map?;
        final approver = v['approver'] as Map?;
        final typeOfServiceList = v['typeOfService'] as List?;

        String fullName(Map? user) {
          if (user == null) return '-';
          final userInfo = user['userInfo'] as String?;
          if (userInfo != null && userInfo.isNotEmpty) return userInfo;
          final first = user['firstName'] as String? ?? '';
          final last = user['lastName'] as String? ?? '';
          final combined = '$first $last'.trim();
          return combined.isNotEmpty ? combined : '-';
        }

        String formatEpochMs(dynamic epochMs) {
          if (epochMs == null) return '-';
          final millis = epochMs is int ? epochMs : int.tryParse('$epochMs');
          if (millis == null) return '-';
          final date = DateTime.fromMillisecondsSinceEpoch(millis);
          return '${date.day.toString().padLeft(2, '0')}/'
              '${date.month.toString().padLeft(2, '0')}/'
              '${date.year} ${date.hour.toString().padLeft(2, '0')}:'
              '${date.minute.toString().padLeft(2, '0')}';
        }

        return ShiftSlaViolation(
          id: '${v['id'] ?? v['slNo'] ?? '-'}',
          region: locationRegion?['name'] as String? ?? '-',
          location: location?['name'] as String? ?? '-',
          dateOfCreation: formatEpochMs(v['inputDate']),
          createdBy: fullName(entrySecurity),
          asl: fullName(approver),
          typeOfService: (typeOfServiceList ?? const [])
              .map((t) => (t as Map?)?['name'] as String? ?? '')
              .where((s) => s.isNotEmpty)
              .join(', '),
          status: v['statusLabel'] as String? ?? fallbackStatus,
        );
      }
      return ShiftSlaViolation(
        id: '-',
        region: '-',
        location: '-',
        dateOfCreation: '-',
        createdBy: '-',
        asl: '-',
        typeOfService: '',
        status: fallbackStatus,
      );
    }).toList();
  }

  Widget _buildShiftCard(
      Shifts shift,
      int index,
      double height,
      AttendanceShiftsState state,
      int? dutyPostId,
      int? rankId,
      ) {
    final accent = _shiftAccentColors[index % _shiftAccentColors.length];
    final isActive = shift.activeShift == true;
    final statusLabel = isActive ? 'Active' : 'Draft';
    final statusColor =
    isActive ? const Color(0xFF3FB65D) : const Color(0xFFF5A623);

    final planned = shift.allowed ?? 0;
    final present = shift.attended?.length ?? 0;

    final shiftKey = _shiftKey(shift);
    // FIX: this must be the generic shift-type id (`shift.shiftId`), NOT
    // `shift.attendanceShiftId`. AddReplacementPopUp sends this value as
    // the `shiftId` query param on getAttAvailableGuardsByDate, while
    // `shiftModel.attendanceShiftId` (see `_shiftModelFor` above) is sent
    // as the path segment — they're two different ids and must not be
    // collapsed into the same fallback chain.
    final shiftId = shift.shiftId;
    final editable = !isReadOnly;

    // See CAVEAT on `_parseSlaViolations` re: the assumed `violations` field.
    final slaViolations = _parseSlaViolations(shift.slaViolations, statusLabel);

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: accent, width: 3)),
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: avatar + "SHIFT X / time range" + status badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  (shift.shift ?? '?').toUpperCase(),
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SHIFT ${(shift.shift ?? '-').toUpperCase()}',
                      style: const TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      _timeRangeForShift(shift.shift),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: statusColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    statusLabel,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(height * 0.012),

          _plannedPresentRow(planned, present),
          CommonWidgets.verticalSpacerWidget(height * 0.012),

          // ATTENDANCE MARKING
          _sectionHeader(
            'ATTENDANCE MARKING',
            trailing: null,
          ),
          const SizedBox(height: 6),
          _attendanceMarkingBox(shift, shiftKey, editable),
          const SizedBox(height: 12),

          // REPLACEMENTS — only shown for active shifts, matching Shift A
          // / Shift G in the reference (Shift B / C don't show it).
          if (isActive) ...[
            _sectionHeader(
              'REPLACEMENTS',
              trailing: editable
                  ? _addIconButton(() {
                if (dutyPostId == null ||
                    rankId == null ||
                    shiftId == null ||
                    shift.attendanceShiftId == null) {
                  Validator().showToast(
                    context,
                    'Please select a valid duty post, rank and shift '
                        'before adding a replacement.',
                  );
                  return;
                }

                showReplacementPopUp(
                  context: context,
                  model: Replacement(),
                  selectedGuards: _selectableReplacementGuards(shift),
                  state: state,
                  rankId: rankId,
                  shiftId: shiftId,
                  dutyPostId: dutyPostId,
                  attendanceId: widget.attInfoId,
                  shiftModel: _shiftModelFor(shift),
                );
              })
                  : null,
            ),
            const SizedBox(height: 6),
            // FIX: this used to read from a local-only placeholder map that
            // was never populated, so real replacements (either already on
            // the record, or newly added through the popup) never showed
            // up here. It now renders `shift.replacements`, the actual data
            // coming back from the API, and lets you tap a row to edit it.
            _replacementsBox(
              shift,
              dutyPostId: dutyPostId,
              rankId: rankId,
              shiftId: shiftId,
              state: state,
              editable: editable,
            ),
            const SizedBox(height: 12),
          ],

          // SLA VIOLATION LIST
          // _sectionHeader(
          //   'SLA VIOLATION LIST',
          //   trailing: editable
          //       ? _addIconButton(() => _onAddSlaViolation(shift, state))
          //       : null,
          // ),
          // const SizedBox(height: 6),
          // if (slaViolations.isEmpty)
          //   _emptyStateBox('No SLA violations added yet')
          // else
          //   Column(
          //     children:
          //     slaViolations.map((sla) => _slaViolationCard(sla)).toList(),
          //   ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // SLA VIOLATION LIST
  // ---------------------------------------------------------------------

  Widget _slaViolationCard(ShiftSlaViolation sla) {
    final isCollapsed = _collapsedSlaIds.contains(sla.id);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (isCollapsed) {
                  _collapsedSlaIds.remove(sla.id);
                } else {
                  _collapsedSlaIds.add(sla.id);
                }
              });
            },
            child: Container(
              width: double.infinity,
              color: const Color(0xFF3D6DB0),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: sla.typeOfService,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          TextSpan(
                            text: '   ${sla.status}   ${sla.dateOfCreation}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    isCollapsed
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          if (!isCollapsed)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _readOnlyField(label: 'ID', value: sla.id)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _readOnlyField(
                              label: 'REGION', value: sla.region)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _readOnlyField(
                              label: 'LOCATION', value: sla.location)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _readOnlyField(
                              label: 'DATE OF CREATION',
                              value: sla.dateOfCreation)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _readOnlyField(
                              label: 'CREATED BY', value: sla.createdBy)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _readOnlyField(label: 'ASL', value: sla.asl)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _readOnlyField(
                              label: 'TYPE OF SERVICE',
                              value: sla.typeOfService)),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _readOnlyField(
                              label: 'STATUS', value: sla.status)),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, {Widget? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 0.4,
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _addIconButton(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 26,
        height: 26,
        decoration: const BoxDecoration(
          color: Color(0xFF5B4FCF),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 16),
      ),
    );
  }

  Widget _emptyStateBox(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        message,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ),
    );
  }

  Widget _plannedPresentRow(int planned, int present) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Planned: ',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 13),
          ),
          TextSpan(
            text: '$planned  ',
            style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 13),
          ),
          const TextSpan(
            text: 'Present: ',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 13),
          ),
          TextSpan(
            text: '$present',
            style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 13),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // ATTENDANCE MARKING
  // ---------------------------------------------------------------------
  Widget _attendanceMarkingBox(Shifts shift, String shiftKey, bool editable) {
    final attended = shift.attended ?? const <Attended>[];
    if (attended.isEmpty) {
      return _emptyStateBox('No guards marked attended yet');
    }

    final newlyAdded = _newlyAddedGuardIdsByShift[shiftKey] ?? const <int>{};

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: attended.map((guard) {
          final canRemove =
              editable && guard.id != null && newlyAdded.contains(guard.id);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: const Color(0xFFEDE9FE),
                  child: Text(
                    (guard.name?.isNotEmpty == true)
                        ? guard.name![0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Color(0xFF5B4FCF),
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    guard.name ?? '-',
                    style: const TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (canRemove)
                  OutlinedButton(
                    onPressed: () =>
                        _removeAttendedGuard(shift, shiftKey, guard),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 2),
                      minimumSize: const Size(0, 30),
                    ),
                    child: const Text('Remove',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // TODO: replace direct field mutation with a real cubit call, e.g.
  // BlocProvider.of<AttendanceShiftsCubit>(context).unmarkGuardAttended(guard);
  void _removeAttendedGuard(Shifts shift, String shiftKey, Attended guard) {
    setState(() {
      shift.attended?.removeWhere((a) => a.id == guard.id);
      if (guard.id != null) {
        _newlyAddedGuardIdsByShift[shiftKey]?.remove(guard.id);
      }
    });
  }

  Widget _replacementsBox(
      Shifts shift, {
        required int? dutyPostId,
        required int? rankId,
        required int? shiftId,
        required AttendanceShiftsState state,
        required bool editable,
      }) {
    final replacements = shift.replacements ?? const <Replacement>[];
    if (replacements.isEmpty) {
      return _emptyStateBox('No replacements added yet');
    }

    final canEdit = editable &&
        dutyPostId != null &&
        rankId != null &&
        shiftId != null &&
        shift.attendanceShiftId != null;

    return Column(
      children: [
        for (var i = 0; i < replacements.length; i++) ...[
          _replacementCard(
            replacements[i],
            replacementKey: '${_shiftKey(shift)}_replacement_$i',
            shift: shift,
            dutyPostId: dutyPostId,
            rankId: rankId,
            shiftId: shiftId,
            state: state,
            canEdit: canEdit,
          ),
          if (i != replacements.length - 1) const SizedBox(height: 10),
        ],
      ],
    );
  }

  Widget _replacementCard(
      Replacement replacement, {
        required String replacementKey,
        required Shifts shift,
        required int? dutyPostId,
        required int? rankId,
        required int? shiftId,
        required AttendanceShiftsState state,
        required bool canEdit,
      }) {
    final isCollapsed = _collapsedReplacementIds.contains(replacementKey);

    final replacedForName = replacement.replacedFor?.name ?? '-';
    final replacementByName = replacement.replacementBy?.name ?? '-';

    final reasonLabel = replacement.status != null
        ? (Utils().getKeyFromValue(
      value: replacement.status!,
      dropdownValues: shiftScheduleReasonDropDownValues,
    ) ??
        '-')
        : '-';

    final replacementTypeLabel = replacement.status != null
        ? (Utils().getKeyFromValue(
      value: replacement.status!,
      dropdownValues: replacementTypeDropDownValues,
    ) ??
        '-')
        : '-';

    final fromDateLabel = !replacement.fromDate.isEmptyOrNull
        ? Utils.timestampToDateConversion(
      int.tryParse(replacement.fromDate ?? '0') ?? 0,
      Constants.dateFormat,
    )
        : '-';

    final toDateLabel = !replacement.toDate.isEmptyOrNull
        ? Utils.timestampToDateConversion(
      int.tryParse(replacement.toDate ?? '0') ?? 0,
      Constants.dateFormat,
    )
        : '-';

    // The header strip only shows the time-of-day, matching the "00:00"
    // chip next to the reason in the reference design.
    final timeLabel = !replacement.fromDate.isEmptyOrNull
        ? Utils.timestampToDateConversion(
      int.tryParse(replacement.fromDate ?? '0') ?? 0,
      'HH:mm',
    )
        : '00:00';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF1E2430),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                // Tapping the label/chevron area toggles the card; the
                // remove button (below) is a sibling, not a child of this
                // InkWell, so the two gestures never fight each other.
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (isCollapsed) {
                          _collapsedReplacementIds.remove(replacementKey);
                        } else {
                          _collapsedReplacementIds.add(replacementKey);
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: replacedForName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                                TextSpan(
                                  text: '   $reasonLabel   $timeLabel   ',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: replacementByName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isCollapsed
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
                if (canEdit) ...[
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => _removeReplacement(shift, replacement),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Color(0xFFD64545),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (!isCollapsed)
            InkWell(
              onTap: canEdit
                  ? () => showReplacementPopUp(
                context: context,
                model: replacement,
                selectedGuards: _selectableReplacementGuards(shift),
                state: state,
                rankId: rankId!,
                shiftId: shiftId!,
                dutyPostId: dutyPostId!,
                attendanceId: widget.attInfoId,
                shiftModel: _shiftModelFor(shift),
              )
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _readOnlyField(
                                label: 'REPLACEMENT FOR',
                                value: replacedForName)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _readOnlyField(
                                label: 'REPLACEMENT BY',
                                value: replacementByName)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _readOnlyField(
                                label: 'FROM DATE', value: fromDateLabel)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _readOnlyField(
                                label: 'END DATE', value: toDateLabel)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _readOnlyField(
                                label: 'REASON', value: reasonLabel)),
                        const SizedBox(width: 12),
                        Expanded(
                            child: _readOnlyField(
                                label: 'REPLACEMENT TYPE',
                                value: replacementTypeLabel)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // TODO: this assumes `AttendanceShiftsCubit.removeReplacement` exists
  // with this signature (it was already used elsewhere in this screen's
  // history). Point it at the real cubit method if the signature differs.
  void _removeReplacement(Shifts shift, Replacement replacement) {
    BlocProvider.of<AttendanceShiftsCubit>(context)
        .removeReplacement(replacement, context: context, rankId: null, shiftId: null);
  }

  void _onAddSlaViolation(Shifts shift, AttendanceShiftsState state) {
    FocusScope.of(context).unfocus();
    // BlocProvider.of<AttendanceShiftsCubit>(context).submitForm(isSaveOnly: true);

    Navigator.pushNamed(
      context,
      slaViolationPenaltyDetailsRoute,
      arguments: {
        ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
        ConstantsArgument.attdInfoId: state.model.id,
        ConstantsArgument.location: widget.location,
        ConstantsArgument.locationRegion: widget.locationRegion,
        ConstantsArgument.vendor: widget.vendor,
      },
    ).then((_) {
      if (!mounted) return;
      BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
    });
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
    required ShiftModel shiftModel,
  }) {
    // Tells the cubit which rank/shift this replacement belongs to, since
    // AddReplacementPopUp's Save button calls updateReplacement(...) with
    // no rank/shift id of its own.
    BlocProvider.of<AttendanceShiftsCubit>(context)
        .setActiveReplacementContext(rankId: rankId, shiftId: shiftId);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddReplacementPopUp(
          viaAttendance: true,
          model: model,
          mainContext: context,
          selectedGuards: selectedGuards,
          attendanceModel: state.model,
          shiftModel: shiftModel,
          shiftId: shiftId,
          rankId: rankId,
          dutyPostId: dutyPostId,
          attendanceId: attendanceId,
        );
      },
    ).then((_) {
      // Refresh so any edits made in the popup are reflected here.
      if (!mounted) return;
      BlocProvider.of<AttendanceShiftsCubit>(context).initializeValues();
    });
  }
}