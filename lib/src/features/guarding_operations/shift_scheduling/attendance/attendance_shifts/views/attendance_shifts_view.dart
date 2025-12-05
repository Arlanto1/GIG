import 'dart:developer';

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
    log('----build----');

    return BlocConsumer<AttendanceShiftsCubit, AttendanceShiftsState>(
      listener: (context, state) {
        log('----state.status--${state.status}--');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Attendance',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                attendanceListRoute,
              );
            },
          );

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => dialog,
          );
        }
      },
      builder: (context, state) {
        log('----builder----');

        if (!state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }

        log('11111${state.model.attdStatus}');
        if (state.model.attdStatus != 1) {
          isReadOnly = true;
        }
        if (widget.isEligibleToEdit == false) {
          isReadOnly = true;
        }
        // if (widget.isEligibleToEdit == false) {
        //   isReadOnly = true;
        // }

        if (state.model.attdStatus == 1 && widget.isEligibleToEdit == true) {
          isReadOnly = false;
        }
        // isReadOnly = false; // TODO: remove this

        return Scaffold(
          backgroundColor: AppColors.newColor3,
          appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: widget.selectedDutyPostModel.name ?? '',
              showPopUp: false,
              showSaveButton: false,
              showSubmitButton: state.model.activeShift == true &&
                      state.status != FormStatus.loading
                  ? true
                  : false,
              showDisLikeButton: false,
              showLikeButton: false,
              // onTapSave: () => BlocProvider.of<AttendanceShiftsCubit>(context)
              //     .submitAndRefreshScreen(),
              // onTapSubmit: () => submitDutyPost(context, isSaveOnly: false),

              popAndReplace: () {
                int flag = AttendanceDetailsView.flag;

                // log('flagValueinShiftsView----${flag}');
                if (flag == 1) {
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },

              /// On Click on Submit it will show the confirmation dialogue box
              onTapSubmit: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(Constants.attendanceMessage),
                      content:
                          const Text(Constants.attendanceSubmissionMessage),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(Constants.cancel),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),

                        /// on click ok, it will submit the record
                        TextButton(
                          child: const Text(Constants.ok),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            // Close the dialog
                            Navigator.of(context).pop();
                            // Submit and refresh data
                            BlocProvider.of<AttendanceShiftsCubit>(this.context)
                                .submitAndRefreshScreen(
                                    isSubmit: true,
                                    isSaveOnly: false,
                                    isRemove: false);
                          },
                        ),
                      ],
                    );
                  },
                );
              }),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: getBody(
                state,
                height,
                state.model,
              ),
            ),
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
              // Container(
              //   alignment: Alignment.topLeft,
              //   child: Text(
              //     'Rank: ${Utils().buildGuardRank(guardRank: rank.rank ?? 0, returnTextOnly: true)}',
              //     style: Styles.textStyleNavigator16,
              //   ),
              // ),
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
            selectedShift =
                null; // set selectedShift to null, when we select the rank
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
        isInitial: selectedRank != null && selectedShift == null ? true : false,
        //remove the previous data when we select rank
        initialValue: selectedShift,
        onChange: (Organisation? value) {
          // selectedShift = value;
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
                      guards: state.model.selectForAttendance ?? {},
                      destinationList: state.model.attended ?? {},
                      isSourceList: true,
                      label:
                          'Select for Attendance: \n${state.model.shift} (Planned: ${state.model.allowed})',
                    ),
                  ),
                ),
                Column(
                  children: [
                    Opacity(
                      opacity: state.model.attdStatus != 1 ? 0.5 : 1.0,
                      child: AbsorbPointer(
                        absorbing: state.model.attdStatus != 1,
                        child: buildArrowButton(
                          state: state,
                          icon: Icons.arrow_right,
                          destinationList: state.model.attended ?? {},
                          onAdd: (BaseUser guard) {
                            state.model.attended?.add(guard);
                            state.model.selectForAttendance?.remove(guard);
                          },
                          isRemove: false,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: state.model.attdStatus != 1 ? 0.5 : 1.0,
                      child: AbsorbPointer(
                        absorbing: state.model.attdStatus != 1,
                        child: buildArrowButton(
                          state: state,
                          icon: Icons.arrow_left,
                          destinationList:
                              state.model.selectForAttendance ?? {},
                          onAdd: (BaseUser guard) {
                            state.model.selectForAttendance?.add(guard);
                            state.model.attended?.remove(guard);
                          },
                          isRemove: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Opacity(
                  opacity: state.model.attdStatus != 1 ? 0.5 : 1.0,
                  child: AbsorbPointer(
                    absorbing: state.model.attdStatus != 1,
                    child: buildShiftColumn(
                      shift: state.model,
                      guards: state.model.attended ?? {},
                      destinationList: state.model.attended ?? {},
                      isSourceList: false,
                      label: '           Attended\n',
                    ),
                  ),
                ),
                // Column(
                //  children: [
                // buildArrowButton(
                //   state: state,
                //   icon: Icons.arrow_right,
                //   destinationList: state.model.previousShift ?? {},
                //   onAdd: (BaseUser guard) {
                //     state.model.previousShift?.add(guard);
                //     state.model.attended?.remove(guard);
                //   },
                // ),
                // buildArrowButton(
                //   state: state,
                //   icon: Icons.arrow_left,
                //   destinationList: state.model.attended ?? {},
                //   onAdd: (BaseUser guard) {
                //     state.model.attended?.add(guard);
                //     state.model.previousShift?.remove(guard);
                //   },
                // ),
                //  ],
                // ),
                // buildShiftColumn(
                //   shift: state.model,
                //   destinationList: state.model.attended ?? {},
                //   guards: state.model.previousShift ?? {},
                //   isSourceList: false,
                //   label: 'Select From\nPrevious Shift\n',
                // )   ,
              ],
            ),
            CommonWidgets.verticalSpacerWidget(
                MediaQuery.of(context).size.height * 0.02),
            // if (!state.model.selectForAttendance.isEmptyOrNull) ...[
            //   buildReplacementColumn(state),
            // ],
            // if (!state.model.selectForAttendance.isEmptyOrNull) ...[
            AbsorbPointer(
              absorbing: state.model.activeShift == false,
              // Disable interaction if inactive
              child: buildReplacementColumn(state),
            ),
            // ],
            CommonWidgets.verticalSpacerWidget(
                MediaQuery.of(context).size.height * 0.02),

            /// Briefing Points
            CommonWidgets.textDisplay(
              'Briefing Points:',
              isMandatory: true,
              Styles.textStyleWhite16,
            ),
            Opacity(
              opacity: state.model.attdStatus != 1 ? 0.5 : 1.0,
              child: AbsorbPointer(
                absorbing: isReadOnly,
                child: MultiSelectDropdown(
                  briefingPoints: state.briefingPoints ?? [],
                  selectedPoints: state.model.briefingPoints?.split(',') ?? [],
                  onSelectedBriefingPointsChanged: (List<String> points) {
                    log('-points--$points--');
                    state.model.briefingPoints =
                        Utils().joinListWithComma(points);

                    BlocProvider.of<AttendanceShiftsCubit>(context)
                        .submitAndRefreshScreen(
                            isRemove: true, isSubmit: false, isSaveOnly: true);
                    // Update the points in your Bloc or state management accordingly
                    // BlocProvider.of<AttendanceShiftsCubit>(context).updateBriefingPoints();
                  },
                ),
              ),
            ),
            CommonWidgets.verticalSpacerWidget(
                MediaQuery.of(context).size.height * 0.01),

            /// SLA Violation List
            // CommonWidgets.textDisplay(
            //   'SLA Violation List',
            //   isMandatory: false,
            //   Styles.textStyleBlack14,
            // ),

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

  Widget buildArrowButton({
    required AttendanceShiftsState state,
    required IconData icon,
    required Set<BaseUser> destinationList,
    required void Function(BaseUser guard) onAdd,
    required bool isRemove,
  }) {
    return IconButton(
      iconSize: 30,
      color: Colors.white,
      onPressed: () {
        if (selectedGuard != null && !destinationList.contains(selectedGuard)) {
          log('--onPressed----');

          log('----@@@--${state.status}-----');
          log('------${state.status}-----');
          onAdd(selectedGuard!);
          BlocProvider.of<AttendanceShiftsCubit>(context)
              .submitAndRefreshScreen(
                  isRemove: isRemove, isSubmit: false, isSaveOnly: true);
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonWidgets.textDisplay(
          label,
          isMandatory: false,
          Styles.textStyleWhite16,
        ),
        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.01),
        AbsorbPointer(
          // absorbing: !shift.activeShift,
          absorbing: false,
          child: buildUserList(
            availableGuards: guards,
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
            Navigator.pushNamed(
              context,
              slaViolationPenaltyDetailsRoute,
              arguments: {
                ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
                ConstantsArgument.attdInfoId: state.model.attendanceShiftId,
                ConstantsArgument.location: widget.location,
                ConstantsArgument.locationRegion: widget.locationRegion,
                // ConstantsArgument.vendor: widget.vendor,
              },
            ).then((_) => BlocProvider.of<AttendanceShiftsCubit>(context)
                .submitAndRefreshScreen(
                    isRemove: false, isSubmit: false, isSaveOnly: true));
          },
          child: Row(
            children: <Widget>[
              const SizedBox(width: 14),
              SvgPicture.asset(
                AppIcon.pluscircle,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Add SLA',
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
            height: MediaQuery.of(context).size.height *
                0.094, // Set the desired height
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

  Column buildReplacementColumn(AttendanceShiftsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => showReplacementPopUp(
            context: context,
            model: Replacement(),
            selectedGuards: state.model.selectForReplacements ?? {},
            state: state,
            rankId: state.selectedRank!.id!,
            shiftId: state.selectedShift!.id!,
          ),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 14),
              SvgPicture.asset(
                AppIcon.pluscircle,
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
        if (state.model.replacements != null &&
            state.model.replacements!.isNotEmpty) ...[
          // Card(
          //   color: Colors.transparent,
          //   child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: buildReplacements(state),
            ),
          ),
          // ),
          CommonWidgets.verticalSpacerWidget(
              MediaQuery.of(context).size.height * 0.01),
        ],
      ],
    );
  }

  // List<Widget> buildReplacements(AttendanceShiftsState state) {
  //   log('selectForReplacements${state.model.selectForReplacements}');
  //   return [
  //     for (Replacement replacement in state.model.replacements ?? [])
  //       InkWell(
  //         onTap: () => (state.model.attdStatus == 1 &&
  //                     replacement.statusActive == true) ||
  //                 (state.model.attdStatus == 2 &&
  //                     replacement.statusActive == true)
  //             ? showReplacementPopUp(
  //                 context: context,
  //                 model: replacement,
  //                 selectedGuards: state.model.selectForReplacements ?? {},
  //                 state: state,
  //                 rankId: state.selectedRank!.id!,
  //                 shiftId: state.selectedShift!.id!,
  //               )
  //             : null,
  //         child: Stack(
  //           children: [
  //             Card(
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     buildTextWithLabel(
  //                         'Replacement For:', replacement.replacedFor?.name),
  //                     buildTextWithLabel(
  //                       'From Date:',
  //                       replacement.fromDate != null
  //                           ? Utils.timestampToDateConversion(
  //                               int.tryParse(replacement.fromDate ?? '0'),
  //                               Constants.dateFormat,
  //                             )
  //                           : '',
  //                     ),
  //                     // buildTextWithLabel(
  //                     //   'To Date:',
  //                     //   replacement.toDate != null
  //                     //       ? Utils.timestampToDateConversion(
  //                     //           int.parse(replacement.toDate ?? '0'),
  //                     //           Constants.dateFormat,
  //                     //         )
  //                     //       : '',
  //                     // ),
  //
  //                     buildTextWithLabel(
  //                         'Reason:',
  //                         Utils().getKeyFromValue(
  //                           value: replacement.status!,
  //                           dropdownValues: shiftScheduleReasonDropDownValues,
  //                         )),
  //                     buildTextWithLabel(
  //                         'Replacement By:', replacement.replacementBy?.name),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               right: 0,
  //               top: 0,
  //               child: InkWell(
  //                 onTap: () {
  //                   state.model.replacements?.remove(replacement);
  //                   BlocProvider.of<AttendanceShiftsCubit>(context)
  //                       .submitAndRefreshScreen(
  //                           checkValidations: false,
  //                           isRemove: true,
  //                           isSubmit: false,
  //                           isSaveOnly: true);
  //                   setState(() {});
  //                 },
  //                 child: Card(
  //                   elevation: 5,
  //                   child: replacement.statusActive == true
  //                       ? BaseIcons().closeIcon()
  //                       : SizedBox.fromSize(),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //   ];
  // }
  List<Widget> buildReplacements(AttendanceShiftsState state) {
    log('selectForReplacements${state.model.selectForReplacements}');

    List<Widget> rows = [];

    // ------------------------------
    // ✅ ADD HEADER ONLY ONCE
    // ------------------------------
    rows.add(
      Container(
        // margin: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: AppColors.white,
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
            5: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: [
                tableHeader("Replacement For"),
                tableHeader("From Date"),
                tableHeader("To Date"),
                tableHeader("Reason"),
                tableHeader("Replacement By"),
                tableHeader(""),
              ],
            )
          ],
        ),
      ),
    );

    // ------------------------------
    // ✅ ADD TABLE ROWS (ONE PER REPLACEMENT)
    // ------------------------------
    for (Replacement replacement in state.model.replacements ?? []) {
      rows.add(
        InkWell(
          onTap: () => (state.model.attdStatus == 1 &&
                      replacement.statusActive == true) ||
                  (state.model.attdStatus == 2 &&
                      replacement.statusActive == true)
              ? showReplacementPopUp(
                  context: context,
                  model: replacement,
                  selectedGuards: state.model.selectForReplacements ?? {},
                  state: state,
                  rankId: state.selectedRank!.id!,
                  shiftId: state.selectedShift!.id!,
                )
              : null,
          child: Container(
            // margin: const EdgeInsets.only(bottom: 1),
            decoration: BoxDecoration(
              color: AppColors.newColor3,
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
                5: FlexColumnWidth(1),
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
                            dropdownValues: shiftScheduleReasonDropDownValues!,
                          ) ??
                          ''),
                    ),
                    tableCell(replacement.replacementBy?.name ?? ""),

                    // ❌ Delete Button
                    Center(
                      child: replacement.statusActive == true
                          ? IconButton(
                              icon: const Icon(Icons.close, size: 18),
                              onPressed: () {
                                state.model.replacements?.remove(replacement);
                                BlocProvider.of<AttendanceShiftsCubit>(context)
                                    .submitAndRefreshScreen(
                                  checkValidations: false,
                                  isRemove: true,
                                  isSubmit: false,
                                  isSaveOnly: true,
                                );
                                setState(() {});
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
          color: Colors.black,
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

  // Helper method to create a RichText widget with label and value
  Widget buildTextWithLabel(String label, String? value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.white, // You can adjust the color as needed
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
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
      selectedGuard = element; // Update the selected element
    });
  }

  Widget buildUserList({
    required Set<BaseUser> availableGuards,
  }) {
    double width = MediaQuery.of(context).size.width;
    double columnWidth;
    if (width > Constants.tabletScreenWidth) {
      /// TABLET
      columnWidth = width / 3.6;
    } else {
      /// Mobile
      columnWidth = width / 2.67;
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.disableTextFieldBackground,
      ),
      height: MediaQuery.of(context).size.height / 3.3,
      width: columnWidth,
      child: ListView.builder(
        itemCount: availableGuards.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final element = availableGuards.toList()[index];
          return GestureDetector(
            onTap: () => handleUserTap(element),
            child: Card(
              color: selectedGuard == element
                  ? AppColors.navigationSkyBlueColor
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Tooltip(
                  preferBelow: false,
                  message: selectedGuard == element ? element.name ?? '' : '',
                  child: Text(
                    element.name ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      color: selectedGuard == element
                          ? AppColors.white
                          : AppColors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          );
        },
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
        );
      },
    );
  }
}
