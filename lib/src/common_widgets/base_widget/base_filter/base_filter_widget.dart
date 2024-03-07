import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_filter/cubit/base_filter_cubit.dart';

class BaseSearchWidget extends StatefulWidget {
  final Function(FilterCriteria) applySearchFilters;
  final Function(Filters) applyFilters;
  final CommonFilters commonFilters;

  const BaseSearchWidget({
    super.key,
    required this.applySearchFilters,
    required this.applyFilters,
    required this.commonFilters,
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
          // ShowFiltersWidget is used to trigger the showModalBottomSheet
          ShowFiltersWidget(
            applyFilters: widget.applyFilters,
            commonFilters: widget.commonFilters,
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
  final Function(Filters) applyFilters;
  final CommonFilters commonFilters;
  final VoidCallback clearSearchController;

  const ShowFiltersWidget({
    super.key,
    required this.applyFilters,
    required this.clearSearchController,
    required this.commonFilters,
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
            clearSearchController();
            showFilters(context
                // context: context,
                // locations: locations,
                // applyFilters: applyFilters,
                // statuses: statuses,
                // regions: regions,
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

  void showFilters(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => BaseFilterCubit(), // Provide the BaseFilterCubit
          child: BaseFilterSheet(
            applyFilters: applyFilters,
            statuses: commonFilters.statuses ?? [],
            regions: commonFilters.regions ?? [],
          ),
        );
      },
    );
  }
}

class BaseFilterSheet extends StatelessWidget {
  final Function(Filters) applyFilters;
  final List<Organisation> statuses;
  final List<Organisation> regions;

  const BaseFilterSheet({
    super.key,
    required this.applyFilters,
    required this.statuses,
    required this.regions,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController idController = TextEditingController();
    TextEditingController slNoController = TextEditingController();
    TextEditingController createdByController = TextEditingController();
    TextEditingController fromDateController = TextEditingController();
    TextEditingController toDateController = TextEditingController();
    Organisation? selectedRegion = Organisation();
    Organisation? selectedLocation = Organisation();
    Organisation? selectedStatus = Organisation();
    List<Organisation> locations = [];
    Filters filtersModel = Filters();

    final size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    double textFieldWidth = width * 0.45;
    return BlocConsumer<BaseFilterCubit, BaseFilterState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        log('-state.status-builder---${state.status}-');
        if (state.status == FormStatus.loading) {
          // return BaseLoader();
        }

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
                          initialValue: '${filtersModel.id ?? ''}',
                          // controller: idController,
                          hintText: '',
                          isEnable: true,
                          isDisableColor: false,
                          onChange: (String value) {
                            filtersModel.id = int.tryParse(value);
                          },
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
                          initialValue: filtersModel.createdBy ?? '',
                          // controller: createdByController,
                          hintText: '',
                          isEnable: true,
                          isDisableColor: false,
                          onChange: (String value) {
                            filtersModel.createdBy = value;
                          },
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

                      BlocProvider.of<BaseFilterCubit>(context)
                          .getRegionsOrLocationsByRegionId(
                              id: selectedRegion?.id ?? 0);
                      // locations = await CommonServices()
                      //     .getRegionsOrLocationsByRegionId(id: selectedRegion?.id);
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  DropdownWidget(
                    label: 'Select Location',
                    elements: state.locations,
                    onChange: (value) {
                      selectedLocation = value;
                    },
                  )
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
                  // filtersModel.id = int.tryParse(idController.text);
                  // filtersModel.createdBy = createdByController.text;
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
                  filtersModel.locationId = selectedLocation?.id;
                  applyFilters(filtersModel);
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      AppColors.navigationSkybluecolor),
                  // Change the text color here
                ),
                child: const Text('Search'),
              ),
              const SizedBox(height: 40),
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
