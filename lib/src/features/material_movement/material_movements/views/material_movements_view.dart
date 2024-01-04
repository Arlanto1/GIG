import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/material_movement/material_movements/bloc/material_movement_bloc.dart';

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
    context.read<MaterialMovementBloc>().add(
          const InitializeValuesMM(),
        );
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
                // BaseFilterWidget().showFiltersWidget(
                //   context: context,
                //   locations: Locations(),
                //   applyFilters: applyFilters,
                // ),
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

  void applyFilters(String name, ) {
    log('Applying Filters'); // this log is not getting printed
    log('name-------$name'); // this log is not getting printed
  }
}
