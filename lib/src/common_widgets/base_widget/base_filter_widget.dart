import 'dart:developer';

import 'package:db_atom/index.dart';

class BaseFilterWidget {
  Container showFiltersWidget({
    required BuildContext context,
    required final Locations locations,
    required final Function(String) applyFilters,
  }) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return Container(
      margin: const EdgeInsets.only(right: 9),
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.navigationSkybluecolor),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      padding: const EdgeInsets.all(3),
      child: IntrinsicWidth(
        child: InkWell(
          onTap: () {
            showFilters(
              context: context,
              height: height,
              locations: locations,
              applyFilters: applyFilters,
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                ' Filters',
                style: TextStyle(color: AppColors.navigationSkybluecolor),
              ),
              Icon(
                Icons.arrow_drop_down_outlined,
                color: AppColors.navigationSkybluecolor,
              )
            ],
          ),
        ),
      ),
    );
  }

  void showFilters({
    required BuildContext context,
    required double height,
    required final Locations locations,
    required final Function(String) applyFilters,
  }) {
    TextEditingController idController = TextEditingController();

    showModalBottomSheet(
      isScrollControlled: true, // Make the bottom sheet scrollable
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                /// ID
                CommonWidgets.textDisplay(
                  Constants.id,
                  Styles.textStyleBlack14,
                  isMandatory: false,
                ),
                CommonWidgets.verticalSpacerWidget(height * 0.001),
                FlutterInputField(
                  keyboardType: TextInputType.name,
                  textFormKey: Keys.challanKey,
                  // initialValue: state.model.challanNo,
                  textFieldController: idController,
                  hintText: '',
                  isEnable: true,
                  isDisableColor: false,
                  onChange: (String value) {},
                  validateTextField: (String? user) {},
                ),
                CommonWidgets.verticalSpacerWidget(height * 0.01),
                _buildFilterField(
                  'Date',
                  InkWell(
                    onTap: () {
                      // Open DatePicker
                    },
                    child: TextFormField(
                      enabled: false,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    CommonWidgets.textDisplay(
                      Constants.location,
                      Styles.textStyleBlack14,
                      isMandatory: false,
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.001),
                    locationWidget(context: context, locations: locations),
                    CommonWidgets.verticalSpacerWidget(height * 0.01),
                    const Spacer(),
                    _buildFilterField(
                      'Status',
                      DropdownButton<String>(
                        value: 'Created', // Set the default selected value
                        isDense: true,
                        // isExpanded: true,
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'Created',
                            child: Text('Created'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Completed',
                            child: Text('Completed'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Approved',
                            child: Text('Approved'),
                          ),
                        ],
                        onChanged: (String? value) {
                          // Handle the selected value
                          log('Selected status: $value');
                        },
                      ),
                    ),
                  ],
                ),
                _buildFilterField(
                  'Type',
                  InkWell(
                    onTap: () {
                      // Open dialog box
                      // _showDropdownPopup(context);
                      _showSamplePopUp(context);
                    },
                    child: TextFormField(
                      enabled: false,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ),
                ),
                // Add more filter fields as needed
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    log('Applying Filters---onPressed---');
                    applyFilters(idController.text);
                  },
                  child: const Text('Apply Filters'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterField(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        child,
        const SizedBox(height: 16),
      ],
    );
  }

  void _showDropdownPopup(BuildContext context) async {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final List<String> options = [
      'Option 1',
      'Option 2',
      'Option 3',
      'Option 4'
    ];

    String? result = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          overlay.localToGlobal(Offset.zero),
          overlay.localToGlobal(Offset.zero),
        ),
        Offset.zero & overlay.size,
      ),
      items: options.map((String option) {
        return PopupMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    );
    String selectedValue = 'Option 1';

    // if (result != null && result != selectedValue) {
    //   setState(() {
    //     selectedValue = result;
    //   });
    // }
  }

  Future<void> _showSamplePopUp(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sample Pop-Up'),
          content: const Text('This is a sample pop-up content.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget locationWidget({
    required BuildContext context,
    required final Locations locations,
  }) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return CustomExpansionListTexts(
              locationList: locations,
              onTap: (Organisation? list) async {
                Organisation location = Organisation();
                location.id = list?.id;
                location.name = list?.name;

                BlocProvider.of<MaterialMovementDetailsCubit>(context)
                    .updateDropdownValues(location: location);
              },
            );
          },
        );
      },
      child: SelectedTileValueWidget(name: 'TEST Location' ?? ''),
    );
  }
}
