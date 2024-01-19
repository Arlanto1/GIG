import 'dart:developer';

import 'package:db_atom/index.dart';

import '../../../duty_post_name_master/duty_post_name_master_details/views/add_duty_post_location_name_pop_up.dart';
import '../../../duty_post_name_master/models/duty_post_name_master_model.dart';

class DutyPostDetailsView extends StatefulWidget {
  final DutyPostModel model;

  const DutyPostDetailsView({super.key, required this.model});

  @override
  DutyPostDetailsViewState createState() => DutyPostDetailsViewState();
}

class DutyPostDetailsViewState extends State<DutyPostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: widget.model.name ?? '',
        showPopUp: false,
        showSaveButton: true,
        showSubmitButton: true,
        onTapSave: () {
          FocusScope.of(context).unfocus();
          // BlocProvider.of<ShiftScheduleDetailsCubit>(context)
          //     .submitForm(isSaveOnly: true);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: buildDutyPostRow(height),
          ),
        ),
      ),
    );
  }

  List<Widget> buildDutyPostRow(double height) {
    List<Widget> widgets = [];

    for (Rank rank in widget.model.ranks ?? []) {
      widgets.add(
        SizedBox( // Wrap with Container
          height: 360, // Specify a height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonWidgets.textDisplay(
                  'Rank: ${rank.rank}',
                  isMandatory: false,
                  Styles.textStyleBlack14),
              CommonWidgets.verticalSpacerWidget(height * 0.01),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildDutyPostSelectionWidget(rank.shifts ?? []),
                ),
              ),
              GestureDetector(
                onTap: () {
                  log('--onTap------');

                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AddDutyPostLocationNamePopUp(
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
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    return widgets;
  }

  List<Widget> buildDutyPostSelectionWidget(List<Shift> shifts) {
    List<Widget> widgets = [];

    for (Shift shift in shifts) {
      widgets.add(
        buildUserList(
          availableGuards: shift.availableGuards ?? [],
          isSourceList: true,
          selectedGuards: shift.selectedGuards ?? [],
          maxAllowed: shift.allowed ?? 0,
          onAdd: (Guard guard) {
            setState(() {
              shift.availableGuards = List.from(shift.availableGuards!)
                ..remove(guard);
              shift.selectedGuards = List.from(shift.selectedGuards!)
                ..add(guard);
            });
          },
          onRemove: (Guard guard) {
            setState(() {
              shift.selectedGuards = List.from(shift.selectedGuards!)
                ..remove(guard);
              shift.availableGuards = List.from(shift.availableGuards!)
                ..add(guard);
            });
          },
        ),
      );
      widgets.add(
        buildUserList(
          availableGuards: shift.selectedGuards ?? [],
          isSourceList: false,
          selectedGuards: shift.selectedGuards ?? [],
          maxAllowed: shift.allowed ?? 0,
          onAdd: (Guard guard) {
            setState(() {
              shift.selectedGuards = List.from(shift.selectedGuards!)
                ..add(guard);
              shift.availableGuards = List.from(shift.availableGuards!)
                ..remove(guard);
            });
          },
          onRemove: (Guard guard) {
            setState(() {
              shift.selectedGuards = List.from(shift.selectedGuards!)
                ..remove(guard);
              shift.availableGuards = List.from(shift.availableGuards!)
                ..add(guard);
            });
          },
        ),
      );
    }

    return widgets;
  }

  Widget buildUserList({
    required List<Guard> availableGuards,
    required List<Guard> selectedGuards,
    required bool isSourceList,
    required int maxAllowed,
    required void Function(Guard guard) onAdd,
    required void Function(Guard guard) onRemove,
  }) {
    return Container(
      height: 300,
      width: 170,
      color: Colors.grey[300],
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
              child: ListTile(
                title: Text(
                  element.name ?? '',
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
