import 'package:db_atom/index.dart';

class MultiSelectDropdown extends StatefulWidget {
  const MultiSelectDropdown({
    super.key,
    required this.briefingPoints,
    required this.selectedPoints,
    required this.updatedBriefingPoints,
  });

  final List<String> briefingPoints;
  final List<String> selectedPoints;
  final Function(List<String> id) updatedBriefingPoints;

  @override
  MultiSelectDropdownState createState() => MultiSelectDropdownState();
}

class MultiSelectDropdownState extends State<MultiSelectDropdown> {
  // final List<String> widget.selectedPoints = [];
  final TextEditingController _customValueController = TextEditingController();

  // final _items = List.generate(
  //   10,
  //   (index) => 'Item $index',
  // );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: [
          if (!widget.selectedPoints.isEmptyOrNull) ...[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gerylightBackground),
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Wrap(
                  spacing: 4.0,
                  runSpacing: 2.0,
                  children: [
                    ...widget.selectedPoints.map(
                      (item) => InkWell(
                        onTap: () {
                          setState(() {
                            widget.selectedPoints.remove(item);
                            widget.updatedBriefingPoints(widget.selectedPoints);

                          });
                        },
                        child: Chip(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 1.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(item),
                                const Icon(
                                  Icons.clear,
                                  size: 15,
                                  color: AppColors.navigationSkybluecolor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ...widget.selectedPoints.map(
                    //   (customValue) => InkWell(
                    //     onTap: () {
                    //       log('----onTap----');
                    //       log('----onTap-widget.selectedPoints-${widget.selectedPoints}--');
                    //
                    //       setState(() {
                    //         widget.selectedPoints.remove(customValue);
                    //       });
                    //     },
                    //     child: Chip(
                    //       label: Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 1.0, horizontal: 1.0),
                    //         child: Row(
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             Text(customValue),
                    //             const Icon(
                    //               Icons.clear,
                    //               size: 15,
                    //               color: AppColors.navigationSkybluecolor,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
          CommonWidgets.verticalSpacerWidget(
              MediaQuery.of(context).size.height * 0.01),
          DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Select Items',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.navigationSkybluecolor,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.navigationSkybluecolor,
                ),
              ),
            ),
            value: null,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  if (!widget.selectedPoints.contains(value) &&
                      !widget.selectedPoints.contains(value)) {
                    widget.selectedPoints.add(value);
                    widget.updatedBriefingPoints(widget.selectedPoints);
                  }
                });
              }
            },
            items: widget.briefingPoints.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // FlutterInputField(
              //   textFormKey: Keys.dateofcreationTextController,
              //   initialValue: date,
              //   hintText: '',
              //   isEnable: false,
              //   isDisableColor: true,
              //   onChange: (String value) {},
              //   validateTextField: (String? user) {},
              // ),
              SizedBox(
                width: 280,
                child: TextField(
                  controller: _customValueController,
                  decoration: InputDecoration(
                    fillColor: AppColors.enabletextfieldBackground,
                    filled: true,
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.gerylightBackground, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.gerylightBackground, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'Add Custom Briefing Point',
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.gerylightBackground, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              AppButton(
                width: 70,
                buttonText: 'Add',
                buttonTextKey: Keys.submitButton,
                onTap: () {
                  String customValue = _customValueController.text.trim();
                  if (customValue.isNotEmpty &&
                      !widget.selectedPoints.contains(customValue)) {
                    widget.updatedBriefingPoints(widget.selectedPoints);
                    setState(() {
                      widget.selectedPoints.add(customValue);
                      _customValueController.clear();
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
