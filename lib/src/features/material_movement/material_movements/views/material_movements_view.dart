import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/material_movement/material_movements/bloc/material_movement_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

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
  BaseFilterModel filters = BaseFilterModel();

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
      context.read<MaterialMovementBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    context.read<MaterialMovementBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) {
      setState(() {});
    }
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<MaterialMovementBloc, MaterialMovementState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.cardBgColor,
          floatingActionButton:
              state.extraProperties?.hasWritePermission ?? false
                  ? Flutterfloatingbutton(
                      backgroundColor: AppColors.navigationSkyBlueColor,
                      foregroundColor: AppColors.backgroundWhiteColor,
                      onPressed: () => {
                        Navigator.pushNamed(
                            context, materialMovementInwardOutwardDetailsRoute,
                            arguments: {
                              "isInward": widget.isInward,
                              "isCreate": true,
                              "title": widget.isInward
                                  ? Constants.materialMovementInwardCreate
                                  : Constants.materialMovementOutwardCreate,
                            })
                      },
                    )
                  : const SizedBox(),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.isInward
                ? Constants.materialMovementsInwardTitle
                : Constants.materialMovementsOutwardTitle,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportMMExcel&mmType=${widget.isInward ? 1 : 0}',
            pdfAPIName: 'exportMMPDF&mmType=${widget.isInward ? 1 : 0}',
          ),
          body: BlocConsumer<MaterialMovementBloc, MaterialMovementState>(
            listener: (context, state) {
              Utils().formError(state, context);
              Utils().errorAndLogout(state, context);
              if (state.status == FormStatus.sessionExpired) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.message ?? 'Session Expired...')));
                Validator.logoutAction(context);
              }
            },
            builder: (context, state) {
              // if (state.status == FormStatus.initial) {
              //   return const BaseLoader();
              // }

              return Container(
                margin: allMargin16,
                decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  ),
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BaseSearchWidget(
                      applySearchFilters: applySearchFilters,
                      applyFilters: applyFilters,
                      commonFilters: state.commonFilters ??
                          CommonFilters(
                            statuses: [],
                            regions: [],
                          ),
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.001),
                    if (state.status == FormStatus.loading) ...[
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      const BaseLoader(),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                    ],
                    UtilsCommon().showNoRecordWidget(
                        state: state, height: height, items: state.items),
                    Expanded(
                      child: SmartRefresher(
                        controller: refreshController,
                        enablePullDown: true,
                        physics: const BouncingScrollPhysics(),
                        header: const WaterDropHeader(
                          waterDropColor: AppColors.navigationSkyBlueColor,
                          refresh: BaseLoader(),
                        ),
                        key: const Key(Keys.refreshKey),
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
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
                                      ? Utils.timestampToDateConversion(
                                          int.parse(
                                              state.items[index].inputDate ??
                                                  '0'),
                                          Constants.dateFormat)
                                      : ''));
                              labels.add(Label(
                                  key: 'Region',
                                  value:
                                      state.items[index].locationRegion?.name ??
                                          ''));
                              labels.add(Label(
                                  key: 'Location',
                                  value:
                                      state.items[index].location?.name ?? ''));
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
                                      isMaterialMovementStatus: true,
                                      isEventProtectionStatus: false,
                                      onTap: (selectedIndex) {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return BasePopUpItems(
                                              id: state.items[selectedIndex].id
                                                  .toString(),
                                              labels: labels,
                                              quantity: state
                                                  .items[selectedIndex].quantity
                                                  .toString(),
                                              challanNo: state
                                                  .items[selectedIndex]
                                                  .challanNo,
                                              slNo: state
                                                  .items[selectedIndex].slNo,
                                              status: state
                                                  .items[selectedIndex].status,
                                              entrySecurityName: state
                                                  .items[selectedIndex]
                                                  .entrySecurityName,
                                              isMasterGuard: false,
                                              isMaterialMovementStatus: true,
                                              isEventProtectionStatus: false,
                                            );
                                          },
                                        );
                                      },
                                      onEditTap: (selectedIndex) {
                                        getById(
                                            state.extraProperties
                                                    ?.hasWritePermission ??
                                                false,
                                            state.items[index].id ?? 0);
                                      },
                                      onViewTap: (selectedIndex) {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return BasePopUpItems(
                                              id: state.items[selectedIndex].id
                                                  .toString(),
                                              labels: labels,
                                              quantity: state
                                                  .items[selectedIndex].quantity
                                                  .toString(),
                                              challanNo: state
                                                  .items[selectedIndex]
                                                  .challanNo,
                                              slNo: state
                                                  .items[selectedIndex].slNo,
                                              status: state
                                                  .items[selectedIndex].status,
                                              entrySecurityName: state
                                                  .items[selectedIndex]
                                                  .entrySecurityName,
                                              isMasterGuard: false,
                                              isMaterialMovementStatus: true,
                                              isEventProtectionStatus: false,
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
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    MaterialMovementModel materialMovementModel =
        await MaterialMovementServices().getById(id);

    editDataLoading(materialMovementModel, hasWritePermission);
  }

  Future<void> editDataLoading(MaterialMovementModel? materialMovementModel,
      bool hasWritePermission) async {
    dismissLoadingDialog(context);
    if (materialMovementModel != null) {
      Navigator.pushNamed(context, materialMovementInwardOutwardDetailsRoute,
          arguments: {
            "MaterialMovementModel": materialMovementModel,
            "isInward": widget.isInward,
            "title": widget.isInward
                ? Constants.materialMovementInwardEdit
                : Constants.materialMovementOutwardEdit,
            ConstantsArgument.extraProperties:
                ExtraProperties(hasWritePermission: hasWritePermission),
          });
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<MaterialMovementBloc>(context).add(
      FetchData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
  }

  void applyFilters(
    Filters model,
  ) {
    log('Applying Filters');

    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    log('id---filtersFun----${filters.filterCriteria!.filters!.id}---');

    BlocProvider.of<MaterialMovementBloc>(context).add(
      FetchData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
