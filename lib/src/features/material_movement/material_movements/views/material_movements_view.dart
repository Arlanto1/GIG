import 'dart:developer';

import 'package:db_atom/index.dart';

class MaterialMovementsView extends StatefulWidget {
  const MaterialMovementsView({
    super.key,
    required this.isInward,
  });

  final bool isInward;

  @override
  State<MaterialMovementsView> createState() => _MaterialMovementsViewState();
}

class _MaterialMovementsViewState extends State<MaterialMovementsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      pageNumber = pageNumber + 20;
      context
          .read<MaterialMovementBloc>()
          .add(FetchData(startPos: pageNumber, maxPos: 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      floatingActionButton: Flutterfloatingbutton(
        backgroundColor: AppColors.navigationSkybluecolor,
        foregroundColor: AppColors.backgroundWhitecolor,
        onPressed: () => {
          Navigator.pushNamed(context, materialMovementInwardDetailsRoute,
              arguments: {
                "isInward": widget.isInward,
                "isCreate": true,
                "title": widget.isInward
                    ? Constants.materialMovementInwardCreate
                    : Constants.materialMovementOutwardCreate,
              })
        },
      ),
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: widget.isInward
            ? Constants.materialMovementsInwardTitle
            : Constants.materialMovementsOutwardTitle,
        showPopUp: true,
        showSaveButton: false,
        showSubmitButton: false,
        excelAPIName: 'exportMMExcel',
        pdfAPIName: 'exportMMPDF',
      ),
      body: BlocConsumer<MaterialMovementBloc, MaterialMovementState>(
        listener: (context, state) {
          if (state.status == FormStatus.sessionExpired) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message ?? 'Session Expired...')));
            Validator.logoutAction(context);
          }
        },
        builder: (context, state) {
          if (state.status == FormStatus.initial) {
            return const BaseLoader();
          }
          if (state.items.isEmptyOrNull) {
            return const NoRecordFoundWidget();
          }
          return Container(
            margin: allMargin16,
            decoration: const ShapeDecoration(
              color: AppColors.backgroundWhitecolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 9),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      border:
                          Border.all(color: AppColors.navigationSkybluecolor),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.all(3),
                  child: IntrinsicWidth(
                    child: InkWell(
                      onTap: () {
                        showFilters(context);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            ' Filters',
                            style: TextStyle(
                                color: AppColors.navigationSkybluecolor),
                          ),
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            color: AppColors.navigationSkybluecolor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                CommonWidgets.verticalSpacerWidget(height * 0.001),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.hasReachedMax
                        ? state.items.length
                        : state.items.length + 1,
                    itemBuilder: (context, index) {
                      List<Label> labels = [];
                      if (index < state.items.length) {
                        labels.add(Label(
                            key: 'Date',
                            value: state.items[index].inputDate != null
                                ? Utils.timestamptoDateConversion(
                                    int.parse(
                                        state.items[index].inputDate ?? '0'),
                                    Constants.dateFormat)
                                : ''));
                        labels.add(Label(
                            key: 'Region',
                            value:
                                state.items[index].locationRegion?.name ?? ''));
                        labels.add(Label(
                            key: 'Location',
                            value: state.items[index].location?.name ?? ''));
                        labels.add(Label(
                            key: 'Material Movement Type ',
                            value: state.items[index].returnable == true
                                ? 'Returnable'
                                : 'Not Returnable'));

                        return index >= state.items.length
                            ? const BaseLoader()
                            : BaseListTileItem(
                                id: state.items[index].id,
                                labels: labels,
                                status: state.items[index].status,
                                isMasterGuard: false,
                                isEventProtectionStatus: false,
                                onTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return BasePopUpItems(
                                        id: state.items[selectedIndex].id
                                            .toString(),
                                        labels: labels,
                                        quantity: state
                                            .items[selectedIndex].quantity
                                            .toString(),
                                        challanNo: state
                                            .items[selectedIndex].challanNo,
                                        slNo: state.items[selectedIndex].slNo,
                                        status:
                                            state.items[selectedIndex].status,
                                        entrySecurityName: state
                                            .items[selectedIndex]
                                            .entrySecurityName,
                                        isMasterGuard: false,
                                        isEventProtectionStatus: false,
                                      );
                                    },
                                  );
                                },
                                onEditTap: (selectedIndex) {
                                  getById(state.items[index].id ?? 0);
                                },
                                onViewTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return BasePopUpItems(
                                        id: state.items[selectedIndex].id
                                            .toString(),
                                        labels: labels,
                                        quantity: state
                                            .items[selectedIndex].quantity
                                            .toString(),
                                        challanNo: state
                                            .items[selectedIndex].challanNo,
                                        slNo: state.items[selectedIndex].slNo,
                                        status:
                                            state.items[selectedIndex].status,
                                        entrySecurityName: state
                                            .items[selectedIndex]
                                            .entrySecurityName,
                                        isMasterGuard: false,
                                      );
                                    },
                                  );
                                },
                                index: index,
                              );
                      }
                      return const Center(
                        child: SizedBox(),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void showFilters(BuildContext context) {
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
                _buildFilterField('ID', TextFormField()),
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
                    _buildFilterField(
                      'Location',
                      DropdownButton<String>(
                        value: 'City A', // Set the default selected value
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'City A',
                            child: Text('City A'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'City B',
                            child: Text('City B'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'City C',
                            child: Text('City C'),
                          ),
                        ],
                        onChanged: (String? value) {
                          // Handle the selected value
                          log('Selected location: $value');
                        },
                      ),
                    ),
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
                    // Apply filters
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

    if (result != null && result != selectedValue) {
      setState(() {
        selectedValue = result;
      });
    }
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

  getById(int id) async {
    showLoadingDialog(context);

    MaterialMovementModel materialMovementModel =
        await MaterialMovementServices().getById(id);

    editDataLoading(materialMovementModel);
  }

  void editDataLoading(MaterialMovementModel? materialMovementModel) {
    dismissLoadingDialog(context);
    if (materialMovementModel != null) {
      Navigator.pushNamed(context, materialMovementInwardDetailsRoute,
          arguments: {
            "MaterialMovementModel": materialMovementModel,
            "isInward": widget.isInward,
            "title": widget.isInward
                ? Constants.materialMovementInwardEdit
                : Constants.materialMovementOutwardEdit,
          });
    }
  }
}
