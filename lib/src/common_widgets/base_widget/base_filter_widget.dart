import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/services/common_services.dart';

class BaseSearchWidget extends StatefulWidget {
  final Function(FilterCriteria) applySearchFilters;
  final Function(Filters) applyFilters;
  final List<Organisation> statuses;
  final List<Organisation> regions;

  const BaseSearchWidget({
    super.key,
    required this.applySearchFilters,
    required this.applyFilters,
    required this.statuses,
    required this.regions,
  });

  @override
  BaseSearchWidgetState createState() => BaseSearchWidgetState();
}

class BaseSearchWidgetState extends State<BaseSearchWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 30,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      FilterCriteria filterCriteriaModel = FilterCriteria();
                      filterCriteriaModel.all = searchController.text;
                      widget.applySearchFilters(filterCriteriaModel);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.navigationSkybluecolor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: AppColors.navigationSkybluecolor,
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(5),
                  hintText: 'Search...',
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.navigationSkybluecolor,
                      style: BorderStyle.solid,
                    ),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.navigationSkybluecolor,
                      width: 1,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.navigationSkybluecolor,
                      width: 1,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.navigationSkybluecolor,
                      width: 1,
                    ),
                  ),
                ),
                onChanged: (value) {
                  // Implement search logic here
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Problem: clear the value in searchController when ShowFiltersWidget is tapped
          // ShowFiltersWidget(
          //   context: context,
          //   locations: Locations(),
          //   applyFilters: widget.applyFilters,
          // ),
          ShowFiltersWidget(
            context: context,
            locations: Locations(),
            applyFilters: widget.applyFilters,
            statuses: widget.statuses,
            regions: widget.regions,
            clearSearchController: () {
              searchController.clear();
            },
          ),
        ],
      ),
    );
  }
}

class ShowFiltersWidget extends StatelessWidget {
  final BuildContext context;
  final Locations locations;
  final Function(Filters) applyFilters;
  final List<Organisation> statuses;
  final List<Organisation> regions;
  final VoidCallback clearSearchController;

  const ShowFiltersWidget({
    super.key,
    required this.context,
    required this.locations,
    required this.applyFilters,
    required this.clearSearchController,
    required this.statuses,
    required this.regions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 9),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.navigationSkybluecolor),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.all(3),
      child: IntrinsicWidth(
        child: InkWell(
          onTap: () {
            clearSearchController
                ?.call(); // Call the clearSearchController function if it's not null
            showFilters(
              context: context,
              locations: locations,
              applyFilters: applyFilters,
              statuses: statuses,
              regions: regions,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showFilters({
    required BuildContext context,
    required final Locations locations,
    required final Function(Filters) applyFilters,
    required List<Organisation> statuses,
    required List<Organisation> regions,
  }) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    TextEditingController idController = TextEditingController();
    TextEditingController slNoController = TextEditingController();
    TextEditingController createdByController = TextEditingController();
    TextEditingController fromDateController = TextEditingController();
    TextEditingController toDateController = TextEditingController();
    Organisation? selectedRegion = Organisation();
    Organisation? selectedLocation = Organisation();
    Organisation? selectedStatus = Organisation();
    List<Organisation> locations = [];

    double textFieldWidth = width * 0.45;
    showModalBottomSheet(
      isScrollControlled: true, // Make the bottom sheet scrollable
      context: context,

      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 8,
            right: 8,
            top: 5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filters',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  /// ID
                  Column(
                    children: [
                      CommonWidgets.textDisplay(
                        Constants.id,
                        Styles.textStyleBlack14,
                        isMandatory: false,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      SizedBox(
                        width: textFieldWidth,
                        child: FlutterInputField(
                          textInputType: TextInputType.number,
                          textFormKey: Keys.idKey,
                          // initialValue: state.model.challanNo,
                          controller: idController,
                          hintText: '',
                          isEnable: true,
                          isDisableColor: false,
                          onChange: (String value) {},
                          validateTextField: (String? user) {},
                        ),
                      ),
                    ],
                  ),
                  CommonWidgets.horizontalSpacerWidget(height * 0.01),

                  /// Created By
                  Column(
                    children: [
                      CommonWidgets.textDisplay(
                        Constants.createdby,
                        Styles.textStyleBlack14,
                        isMandatory: false,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      SizedBox(
                        width: textFieldWidth,
                        child: FlutterInputField(
                          textInputType: TextInputType.text,
                          textFormKey: Keys.slNoKey,
                          controller: createdByController,
                          hintText: '',
                          isEnable: true,
                          isDisableColor: false,
                          onChange: (String value) {},
                          validateTextField: (String? user) {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CommonWidgets.verticalSpacerWidget(height * 0.01),
              Row(
                children: [
                  /// From Date
                  Column(
                    children: [
                      CommonWidgets.textDisplay(
                        Constants.fromDate,
                        Styles.textStyleBlack14,
                        isMandatory: false,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: textFieldWidth,
                          child: BaseDate().datePickerWidgetLoading(
                            textController: fromDateController,
                            onlyDate: true,
                            onChange: (String value) {},
                            context: context,
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// To Date
                  Column(
                    children: [
                      CommonWidgets.textDisplay(
                        Constants.toDate,
                        Styles.textStyleBlack14,
                        isMandatory: false,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: textFieldWidth,
                          child: BaseDate().datePickerWidgetLoading(
                            textController: toDateController,
                            onlyDate: true,
                            onChange: (String value) {},
                            context: context,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CommonWidgets.verticalSpacerWidget(height * 0.01),

              Row(
                children: [
                  DropdownWidget(
                    label: 'Select Region',
                    elements: regions,
                    onChange: (value) async {
                      selectedRegion = value;

                      locations = await CommonServices().getRegionsOrLocationsByRegionId(
                          id: selectedRegion?.id);
                    },
                  ),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // DropdownWidget(
                  //   label: 'Select Location',
                  //   elements: locations,
                  //   onChange: (value) {
                  //     selectedLocation = value;
                  //   },
                  // )
                ],
              ),

              CommonWidgets.verticalSpacerWidget(height * 0.01),
              Row(
                children: [
                  DropdownWidget(
                    label: 'Select Status',
                    elements: statuses,
                    onChange: (value) {
                      selectedStatus = value;
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              // Add more filter fields as needed
              const SizedBox(height: 16),

              /// Search
              ElevatedButton(
                onPressed: () {
                  log('Applying Filters---onPressed---');
                  Filters filtersModel = Filters();
                  filtersModel.id = int.tryParse(idController.text);
                  filtersModel.createdBy = createdByController.text;
                  // filtersModel.slNo = int.tryParse(slNoController.text);
                  if (!fromDateController.text.isEmptyOrNull) {
                    filtersModel.fromDate =
                        Utils().formatTime(fromDateController.text);
                  }
                  if (!toDateController.text.isEmptyOrNull) {
                    filtersModel.toDate =
                        Utils().formatTime(toDateController.text);
                  }
                  filtersModel.status = selectedStatus?.id;
                  filtersModel.regionId = selectedRegion?.id;
                  applyFilters(filtersModel);
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      AppColors.navigationSkybluecolor),
                  // Change the text color here
                ),
                child: const Text('Search'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class DropdownWidget extends StatefulWidget {
  final List<Organisation> elements;
  final void Function(Organisation?)? onChange;
  final String label;

  const DropdownWidget({
    super.key,
    required this.elements,
    required this.onChange,
    required this.label,
  });

  @override
  DropdownWidgetState createState() => DropdownWidgetState();
}

class DropdownWidgetState extends State<DropdownWidget> {
  Organisation? selectedRegion;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField<Organisation>(
        value: selectedRegion,
        hint: Text(widget.label),
        onChanged: widget.onChange,
        items: widget.elements.map((region) {
          return DropdownMenuItem<Organisation>(
            value: region,
            child: Text(region.name ?? ''),
          );
        }).toList(),
      ),
    );
  }
}
