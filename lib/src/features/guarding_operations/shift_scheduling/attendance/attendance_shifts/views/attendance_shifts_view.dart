import 'dart:developer';

import 'package:db_atom/index.dart';

class AttendanceShiftsView extends StatefulWidget {
  const AttendanceShiftsView({
    super.key,
    required this.location,
    required this.locationRegion,
    required this.vendor,
  });

  final Organisation location;
  final Organisation locationRegion;
  final Organisation vendor;

  @override
  AttendanceShiftsViewState createState() => AttendanceShiftsViewState();
}

class AttendanceShiftsViewState extends State<AttendanceShiftsView> {
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

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: state.model.name ?? '',
            showPopUp: false,
            showSaveButton: true,
            showSubmitButton: true,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () => submitDutyPost(context, isSaveOnly: true),
            onTapSubmit: () => submitDutyPost(context, isSaveOnly: false),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: getBody(state, height, state.model),
              ),
            ),
          ),
        );
      },
    );
  }

  void submitDutyPost(BuildContext context, {required bool isSaveOnly}) {
    FocusScope.of(context).unfocus();
    log('----onTap${isSaveOnly ? 'Save' : 'Submit'}--');
    BlocProvider.of<AttendanceShiftsCubit>(context)
        .submitForm(isSaveOnly: isSaveOnly);
  }

  List<Widget> getBody(
    AttendanceShiftsState state,
    double height,
    DutyPostModel model,
  ) {
    log('--model.name-${model.name}-');
    log('--model.ranks-${model.ranks?.length}-');
    return [
      for (Rank rank in model.ranks ?? [])
        IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Rank: ${Utils().buildGuardRank(guardRank: rank.rank ?? 0, returnTextOnly: true)}',
                  style: Styles.textStyleNavigator16,
                ),
              ),
              CommonWidgets.verticalSpacerWidget(height * 0.01),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: buildDutyPostSelectionWidget(
                      state,
                      rank.attendanceShift ?? [],
                      height,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    ];
  }

  List<Widget> buildDutyPostSelectionWidget(
      AttendanceShiftsState state, List<Shift> shifts, double height) {
    log('--shifts--length--${shifts.length}-');
    return [
      for (Shift shift in shifts) ...[
        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.01),
        buildTextWithLabel(
            'Attendance Status:',
            Utils().buildAttendanceStatusRow(
                status: shift.attdStatus ?? 0, returnTextOnly: true)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildShiftColumn(
              shift: shift,
              guards: shift.selectForAttendance ?? [],
              destinationList: shift.attended ?? [],
              isSourceList: true,
              label: 'Select For \nAttendance: \n${shift.shift}',
            ),

            Column(
              children: [
                buildArrowButton(
                  icon: Icons.arrow_right,
                  destinationList: shift.attended ?? [],
                  onAdd: (BaseUser guard) {
                    shift.attended?.add(guard);
                    shift.selectForAttendance?.remove(guard);
                  },
                ),
                buildArrowButton(
                  icon: Icons.arrow_left,
                  destinationList: shift.selectForAttendance ?? [],
                  onAdd: (BaseUser guard) {
                    shift.selectForAttendance?.add(guard);
                    shift.attended?.remove(guard);
                  },
                ),
              ],
            ),
            // buildArrowButtons(
            //   sourceList: shift.selectForAttendance ?? [],
            //   destinationList: shift.attended ?? [],
            //   onAdd: (BaseUser guard) {
            //     shift.attended?.add(guard);
            //   },
            //   onRemove: (BaseUser guard) {
            //     shift.attended?.remove(guard);
            //   },
            // ),
            buildShiftColumn(
              shift: shift,
              guards: shift.attended ?? [],
              destinationList: shift.attended ?? [],
              isSourceList: false,
              label: 'Attended\n\n',
            ),
            Column(
              children: [
                buildArrowButton(
                  icon: Icons.arrow_right,
                  destinationList: shift.previousShift ?? [],
                  onAdd: (BaseUser guard) {
                    shift.previousShift?.add(guard);
                    shift.attended?.remove(guard);
                  },
                ),
                buildArrowButton(
                  icon: Icons.arrow_left,
                  destinationList: shift.attended ?? [],
                  onAdd: (BaseUser guard) {
                    shift.attended?.add(guard);
                    shift.previousShift?.remove(guard);
                  },
                ),
              ],
            ),
            buildShiftColumn(
              shift: shift,
              destinationList: shift.attended ?? [],
              guards: shift.previousShift ?? [],
              isSourceList: false,
              label: 'Select From\nPrevious Shift\n',
            ),
          ],
        ),
        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.01),
        if (!shift.attended.isEmptyOrNull) ...[
          buildReplacementColumn(shift),
        ],

        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.01),

        /// Briefing Points
        CommonWidgets.textDisplay(
          'Briefing Points:',
          isMandatory: false,
          Styles.textStyleBlack14,
        ),
        MultiSelectDropdown(
          briefingPoints: state.briefingPoints ?? [],
          selectedPoints: shift.briefingPoints?.split(',') ?? [],
          updatedBriefingPoints: (List<String> points) {
            shift.briefingPoints = Utils().joinListWithComma(points);
            // BlocProvider.of<AttendanceShiftsCubit>(context).updateBriefingPoints();
          },
        ),
        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.01),

        /// SLA Violation List
        // CommonWidgets.textDisplay(
        //   'SLA Violation List',
        //   isMandatory: false,
        //   Styles.textStyleBlack14,
        // ),

        if (!state.shiftSlaList.isEmptyOrNull) ...[
          buildSlaListColumn(
            state: state,
            shift: shift,
          )
        ],
      ],
    ];
  }

  Widget buildArrowButton({
    required IconData icon,
    required List<BaseUser> destinationList,
    required void Function(BaseUser guard) onAdd,
    // required void Function(BaseUser guard) onRemove,
  }) {
    return IconButton(
      iconSize: 30,
      onPressed: () {
        if (selectedGuard != null && !destinationList.contains(selectedGuard)) {
          log('--onPressed----');
          onAdd(selectedGuard!);
          setState(() {});
        }
      },
      icon: Icon(icon),
    );
  }

  BaseUser? selectedGuard;

  Widget buildShiftColumn({
    required Shift shift,
    required List<BaseUser> guards,
    required bool isSourceList,
    required String label,
    required List<BaseUser> destinationList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonWidgets.textDisplay(
          label,
          isMandatory: false,
          Styles.textStyleBlack14,
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
    required Shift shift,
  }) {
    List<SLAViolationPenaltyModel> slaList = [];

    log('----state.shiftSlaList--${state.shiftSlaList?.length}-');

    if (!state.shiftSlaList.isEmptyOrNull) {
      SlaList? sla = state.shiftSlaList?.firstWhere(
          (element) => element.attInfoId == shift.attendanceShiftId);
      slaList = sla?.items ?? [];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              slaViolationPenaltyDetailsRoute,
              arguments: {
                "title": Constants.slaViolationPenaltyTitle,
                "attdInfoId": state.model.id.toString(),
                ConstantsArgument.location: widget.location,
                ConstantsArgument.locationRegion: widget.locationRegion,
                ConstantsArgument.vendor: widget.vendor,
              },
            );
          },
          child: Row(
            children: <Widget>[
              const SizedBox(width: 14),
              SvgPicture.asset(AppIcon.pluscircle),
              const SizedBox(width: 10),
              const Text(
                'Add SLA',
                style: TextStyle(
                  color: AppColors.navigationSkyBlueColor,
                  decoration: TextDecoration.underline,
                ),
              ),
              CommonWidgets.verticalSpacerWidget(
                  MediaQuery.of(context).size.height * 0.01),
              CommonWidgets.verticalSpacerWidget(
                  MediaQuery.of(context).size.height * 0.01),
            ],
          ),
        ),
        if (!slaList.isEmptyOrNull) ...[
          // Problem: make this column list with horizontal scroll
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
              MediaQuery.of(context).size.height * 0.01),
        ],
      ],
    );
  }

  Widget buildSlaCard(SLAViolationPenaltyModel model) {
    return InkWell(
      onTap: () async {
        var nav = Navigator.of(context);
        // SLAViolationPenaltyModel model =
        //     await SLAViolationPenaltyServices().getGvpById(model.id??0);
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextWithLabel('Id:', model.id.toString()),
                buildTextWithLabel('Region:', model.locationRegion?.name),
                buildTextWithLabel('Location:', model.location?.name),
                buildTextWithLabel('Created By:', model.entrySecurity?.name),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildReplacementColumn(Shift shift) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => showReplacementPopUp(
            context: context,
            model: Replacement(),
            availableGuards: shift.availableGuards ?? [],
            selectedGuards: shift.selectedGuards ?? [],
          ),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 14),
              SvgPicture.asset(AppIcon.pluscircle),
              const SizedBox(width: 10),
              const Text(
                Constants.addReplacement,
                style: TextStyle(
                  color: AppColors.navigationSkyBlueColor,
                  decoration: TextDecoration.underline,
                ),
              ),
              CommonWidgets.verticalSpacerWidget(
                  MediaQuery.of(context).size.height * 0.01),
              CommonWidgets.verticalSpacerWidget(
                  MediaQuery.of(context).size.height * 0.01),
            ],
          ),
        ),
        if (shift.replacements != null && shift.replacements!.isNotEmpty) ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: buildReplacements(shift),
              ),
            ),
          ),
          CommonWidgets.verticalSpacerWidget(
              MediaQuery.of(context).size.height * 0.01),
        ],
      ],
    );
  }

  List<Widget> buildReplacements(Shift shift) {
    log('--shift---${shift.replacements?.length}-');
    return [
      for (Replacement replacement in shift.replacements ?? [])
        InkWell(
          onTap: () => showReplacementPopUp(
            context: context,
            model: replacement,
            availableGuards: shift.availableGuards ?? [],
            selectedGuards: shift.selectedGuards ?? [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextWithLabel(
                  'Replacement For:', replacement.replacedFor?.name),
              buildTextWithLabel(
                  'Replacement By:', replacement.replacementBy?.name),
              buildTextWithLabel(
                'From Date:',
                Utils.timestampToDateConversion(
                  int.parse(replacement.fromDate ?? '0'),
                  Constants.dateFormat,
                ),
              ),
              buildTextWithLabel(
                'To Date:',
                Utils.timestampToDateConversion(
                  int.parse(replacement.toDate ?? '0'),
                  Constants.dateFormat,
                ),
              ),
            ],
          ),
        ),
    ];
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
              color: Colors.black, // You can adjust the color as needed
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.black,
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
    required List<BaseUser> availableGuards,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.disableTextFieldBackground,
      ),
      height: MediaQuery.of(context).size.height / 3.3,
      width: MediaQuery.of(context).size.width / 4.7,
      child: ListView.builder(
        itemCount: availableGuards.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final element = availableGuards[index];
          return GestureDetector(
            onTap: () => handleUserTap(element),
            child: Card(
              color: selectedGuard == element
                  ? AppColors.navigationSkyBlueColor
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  element.name ?? '',
                  style: const TextStyle(fontSize: 15),
                  overflow: TextOverflow.ellipsis,
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
    required List<BaseUser> availableGuards,
    required List<BaseUser> selectedGuards,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddReplacementPopUp(
          model: model,
          mainContext: context,
          availableGuards: availableGuards,
          selectedGuards: selectedGuards,
        );
      },
    );
  }
}
