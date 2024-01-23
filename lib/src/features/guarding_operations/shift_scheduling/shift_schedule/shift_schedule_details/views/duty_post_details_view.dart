import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/cubits/shift_schedule_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/replacement_pop_up.dart';

import '../../../duty_post_name_master/models/duty_post_name_master_model.dart';

class DutyPostDetailsView extends StatefulWidget {
  final DutyPostModel model;

  const DutyPostDetailsView({
    super.key,
    required this.model,
  });

  @override
  DutyPostDetailsViewState createState() => DutyPostDetailsViewState();
}

class DutyPostDetailsViewState extends State<DutyPostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<ShiftScheduleDetailsCubit, ShiftScheduleDetailsState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Duty Post Master',
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
              builder: (BuildContext context) => dialog);

          // Utils.dynamicAlert(
          //     context, state.message ?? '', 'Material Movement', '');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: widget.model.name ?? '',
              showPopUp: false,
              showSaveButton: true,
              showSubmitButton: true,
              onTapSave: () {
                FocusScope.of(context).unfocus();
                log('----onTapSave--');
                BlocProvider.of<ShiftScheduleDetailsCubit>(context)
                    .submitDutyPost(model: widget.model, isSaveOnly: true);
              },
              onTapSubmit: () {
                FocusScope.of(context).unfocus();
                log('----onTapSubmit--');
                BlocProvider.of<ShiftScheduleDetailsCubit>(context)
                    .submitDutyPost(model: widget.model, isSaveOnly: false);
              }),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: buildDutyPostRow(height),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> buildDutyPostRow(double height) {
    List<Widget> widgets = [];

    for (Rank rank in widget.model.ranks ?? []) {
      widgets.add(
        SizedBox(
          // Wrap with Container
          height: MediaQuery.of(context).size.height / 1.9, // i want remove to remove this sized box so that that content take space accordingly
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.textDisplay(
                'Rank: ${Utils().buildGuardRank(guardRank: rank.rank ?? 0, returnTextOnly: true)}',
                isMandatory: false,
                Styles.textStyleBlack14,
              ),
              CommonWidgets.verticalSpacerWidget(height * 0.01),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: buildDutyPostSelectionWidget(rank.shifts ?? [], height),
                  ),
                ),
              ),
            ],
          ),

        ),
      );
    }
    return widgets;
  }

  List<Widget> buildDutyPostSelectionWidget(List<Shift> shifts, double height) {
    List<Widget> widgets = [];

    for (Shift shift in shifts) {
      log('---shift--${shift.shift}------');
      widgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidgets.textDisplay(
                    'Select For Shift: ${shift.shift}',
                    isMandatory: false,
                    Styles.textStyleBlack14),
                CommonWidgets.verticalSpacerWidget(height * 0.01),
                buildUserList(
                  availableGuards: shift.availableGuards ?? [],
                  isSourceList: true,
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
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonWidgets.textDisplay(
                    'Selected (Max Allowed: ${shift.allowed})',
                    isMandatory: false,
                    Styles.textStyleBlack14),
                CommonWidgets.verticalSpacerWidget(height * 0.01),
                buildUserList(
                  availableGuards: shift.selectedGuards ?? [],
                  isSourceList: false,
                  selectedGuards: shift.selectedGuards ?? [],
                  maxAllowed: shift.allowed ?? 0,
                  onAdd: (BaseUser guard) {
                    setState(() {
                      shift.selectedGuards = List.from(shift.selectedGuards!)
                        ..add(guard);
                      shift.availableGuards = List.from(shift.availableGuards!)
                        ..remove(guard);
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
              ],
            ),
          ],
        ),
      );

      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                log('--onTap------');

                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddReplacementPopUp(
                      model: DutyPostNameMasterModel(),
                      mainContext: context,
                    );
                  },
                );
              },
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 14),
                  SvgPicture.asset(
                    AppIcon.pluscircle,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    Constants.addReplacement,
                    style: TextStyle(
                      color: AppColors.navigationSkybluecolor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  CommonWidgets.verticalSpacerWidget(height * 0.01),
                  CommonWidgets.verticalSpacerWidget(height * 0.01),
                ],
              ),
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // children: buildReplacements(shift),
                  children: [
                    Text('Replacement For: asfd}'),
                    Text('Replacement By: asfd}'),
                    Text('From Date: asfd}'),
                    Text('To Date: asfd}'),
                    Text('Reason: asfd}'),
                    Divider(),
                    Text('Replacement For: asfd}'),
                    Text('Replacement By: asfd}'),
                    Text('From Date: asfd}'),
                    Text('To Date: asfd}'),
                    Text('Reason: asfd}'),

                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
    return widgets;
  }

  List<Widget> buildReplacements(Shift shift) {
    List<Widget> widgets = [];

    for (Replacement replacement in shift.replacements ?? []) {
      widgets.add(Text('Replacement For: ${replacement.replacedFor}'));
    }
    return widgets;
  }

  Widget buildUserList({
    required List<BaseUser> availableGuards,
    required List<BaseUser> selectedGuards,
    required bool isSourceList,
    required int maxAllowed,
    required void Function(BaseUser guard) onAdd,
    required void Function(BaseUser guard) onRemove,
  }) {
    log('---availableGuards--${availableGuards.length}------');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // Adjust the value to control the curvature
        color: AppColors.disabletextfieldBackground,
      ),
      // height: 300,
      height: MediaQuery.of(context).size.height / 3.3,
      width: MediaQuery.of(context).size.width / 2.3,
      child: ListView.builder(
        itemCount: availableGuards.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final element = availableGuards[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSourceList) {
                  log('-selectedGuards.l--b----${selectedGuards.length}---');
                  if (selectedGuards.length < maxAllowed) {
                    // Check if the element is not already selected
                    if (!selectedGuards.contains(element)) {
                      // Add the element to the selected list
                      onAdd(element);
                      log('-selectedGuards.l--a----${selectedGuards.length}---');
                    }
                  } else {
                    // Show a message when the maximum number of users is reached
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('You can not add more than $maxAllowed'),
                      ),
                    );
                  }
                } else {
                  // Remove the element from the selected list
                  log('-selectedGuards.l--b----${selectedGuards.length}---');
                  onRemove(element);
                  log('-selectedGuards.l-${selectedGuards.length}---');
                }
              });
            },
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
}
