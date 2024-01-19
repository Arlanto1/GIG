import 'dart:developer';

import 'package:db_atom/index.dart';

class DutyPostDetailsView extends StatefulWidget {
  final DutyPostModel model;

  const DutyPostDetailsView({super.key, required this.model});

  @override
  DutyPostDetailsViewState createState() => DutyPostDetailsViewState();
}

class DutyPostDetailsViewState extends State<DutyPostDetailsView> {
  List<Guard> selectedElements = [];

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: buildDutyPostRow(),
      ),
    );
  }

  List<Widget> buildDutyPostRow() {
    List<Widget> widgets = [];

    for (Rank rank in widget.model.ranks ?? []) {
      widgets.add(Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buildDutyPostSelectionWidget(rank.shifts ?? []),
        ),
      ));
    }
    return widgets;
  }

  List<Widget> buildDutyPostSelectionWidget(List<Shift> shifts) {
    List<Widget> widgets = [];

    for (Shift shift in shifts) {
      widgets.add(buildUserList(
        elements: shift.availableGuards ?? [],
        isSourceList: true,
      ));
      widgets.add(buildUserList(
        elements: shift.selectedGuards ?? [],
        isSourceList: false,
      ));
    }

    return widgets;
  }

  Widget buildUserList({
    required List<Guard> elements,
    required bool isSourceList,
  }) {
    log('---elements-----${elements.length}------');
    log('---isSourceList-----$isSourceList------');
    return Container(
      height: 300,
      width: 150,
      color: Colors.grey[300],
      child: ListView.builder(
        itemCount: elements.length,
        itemBuilder: (context, index) {
          final user = elements[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSourceList) {
                  selectedElements.add(user);
                  elements.remove(user);
                } else {
                  elements.add(user);
                  selectedElements.remove(user);
                }
              });
            },
            child: Card(
              child: ListTile(
                title: Text(
                  user.name ?? '',
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
