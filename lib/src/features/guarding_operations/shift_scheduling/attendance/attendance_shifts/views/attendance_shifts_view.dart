import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_multiselect.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/attendance_shifts/cubits/attendance_shifts_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/replacement_pop_up.dart';

class AttendanceShiftsView extends StatefulWidget {
  const AttendanceShiftsView({
    super.key,
  });

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
                shiftScheduleListRoute,
                arguments: {},
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
    // BlocProvider.of<AttendanceShiftsCubit>(context)
    //     .submitDutyPost(model: widget.model, isSaveOnly: isSaveOnly);
  }

  List<Widget> getBody(
      AttendanceShiftsState state, double height, DutyPostModel model) {
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
                    children: buildDutyPostSelectionWidget(
                        state, rank.attendanceShift ?? [], height),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Problem here I have 3 lists now and i want to move elements between all three lists
            // Movement of element can be from:
            // first to second list
            // second to third list
            // second to first list
            // Movement of element can't be from
            // first to third list
            // third to first list
            // Please modify code accordingly

            buildShiftColumn(shift, isSourceList: true),
            buildShiftColumn(shift, isSourceList: false),
          ],
        ),
        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.01),
        if (!shift.attended.isEmptyOrNull) ...[
          buildReplacementColumn(shift),
        ],

        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.01),
        CommonWidgets.textDisplay(
          'Briefing Points:',
          isMandatory: false,
          Styles.textStyleBlack14,
        ),
        MultiSelectDropdown(
            briefingPoints: state.briefingPoints ?? [],
            selectedPoints: shift.briefingPoints?.split(';') ?? []),
        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.01),
      ],
    ];
  }

  String selectedValue = '';

  Column buildShiftColumn(Shift shift, {required bool isSourceList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonWidgets.textDisplay(
          'Select For Shift: ${shift.shift}',
          isMandatory: false,
          Styles.textStyleBlack14,
        ),
        CommonWidgets.verticalSpacerWidget(
            MediaQuery.of(context).size.height * 0.01),
        AbsorbPointer(
          absorbing: !shift.activeShift,
          child: buildUserList(
            availableGuards: isSourceList
                ? shift.selectForAttendance ?? []
                : shift.attended ?? [],
            isSourceList: isSourceList,
            selectedGuards: shift.selectedGuards ?? [],
            maxAllowed: shift.allowed ?? 0,
            onAdd: (BaseUser guard) {
              setState(() {
                shift.availableGuards = List.from(shift.availableGuards!)
                  ..remove(guard);
                shift.selectedGuards = List.from(shift.selectedGuards!)
                  ..add(guard);
              });
            },
            onRemove: (BaseUser guard) {
              setState(() {
                shift.selectedGuards = List.from(shift.selectedGuards!)
                  ..remove(guard);
                shift.availableGuards = List.from(shift.availableGuards!)
                  ..add(guard);
              });
            },
          ),
        ),
      ],
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
                  color: AppColors.navigationSkybluecolor,
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
                Utils.timestamptoDateConversion(
                  int.parse(replacement.fromDate ?? '0'),
                  Constants.dateFormat,
                ),
              ),
              buildTextWithLabel(
                'To Date:',
                Utils.timestamptoDateConversion(
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

  Widget buildUserList({
    required List<BaseUser> availableGuards,
    required List<BaseUser> selectedGuards,
    required bool isSourceList,
    required int maxAllowed,
    required void Function(BaseUser guard) onAdd,
    required void Function(BaseUser guard) onRemove,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.disabletextfieldBackground,
      ),
      height: MediaQuery.of(context).size.height / 3.3,
      width: MediaQuery.of(context).size.width / 2.3,
      child: ListView.builder(
        itemCount: availableGuards.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final element = availableGuards[index];
          return GestureDetector(
            onTap: () => handleUserListTap(isSourceList, element,
                selectedGuards, maxAllowed, onAdd, onRemove),
            child: Card(
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

  void handleUserListTap(
    bool isSourceList,
    BaseUser element,
    List<BaseUser> selectedGuards,
    int maxAllowed,
    void Function(BaseUser guard) onAdd,
    void Function(BaseUser guard) onRemove,
  ) {
    setState(() {
      if (isSourceList) {
        if (selectedGuards.length < maxAllowed &&
            !selectedGuards.contains(element)) {
          onAdd(element);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('You can not add more than $maxAllowed'),
            ),
          );
        }
      } else {
        onRemove(element);
      }
    });
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
