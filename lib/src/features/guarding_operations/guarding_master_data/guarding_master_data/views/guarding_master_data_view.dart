import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/services/guarding_master_data_services.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class GuardingMasterDataView extends StatefulWidget {
  const GuardingMasterDataView({
    super.key,
  });

  @override
  State<GuardingMasterDataView> createState() => _GuardingMasterDataViewState();
}

class _GuardingMasterDataViewState extends State<GuardingMasterDataView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<GuardingMasterDataBloc>().add(
          const InitializeValuesGMD(),
        );
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    refreshController.dispose();
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
      context.read<GuardingMasterDataBloc>().add(FetchDataList(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  void _onRefresh() async {
    context.read<GuardingMasterDataBloc>().add(
          const RefreshLists(),
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
    return BlocConsumer<GuardingMasterDataBloc, GuardingMasterDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: AppColors.cardBgColor,
              // floatingActionButton: Flutterfloatingbutton(
              //   backgroundColor: AppColors.navigationSkybluecolor,
              //   foregroundColor: AppColors.backgroundWhitecolor,
              //   onPressed: () => {
              //     Navigator.pushNamed(context, guardingMasterDataDetailsRoute,
              //         arguments: {"title": Constants.createGuardingMasterData}),
              //   },
              // ),

              appBar: BaseAppBar().buildAppHeader(
                context: context,
                title: Constants.guardingMasterDataTitle,
                showPopUp: true,
                showSaveButton: false,
                showSubmitButton: false,
                showDisLikeButton: false,
                showLikeButton: false,
                excelAPIName: 'exportGMDataExcel',
                pdfAPIName: 'exportGMDataPDF',
              ),
              body:
                  BlocBuilder<GuardingMasterDataBloc, GuardingMasterDataState>(
                      builder: (context, state) {
                // if (state.status == FormStatus.initial) {
                //   return const BaseLoader();
                // }
                // if (state.list.isEmptyOrNull) {
                //   return const NoRecordFoundWidget();
                // }
                log('--labels-${state.labels?.locale.locationRegion}');
                return Container(
                  margin: allMargin16,
                  decoration: const ShapeDecoration(
                      color: AppColors.backgroundWhiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0)),
                      )),
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
                      // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                      // Text('state.status=====${state.status}'),
                      if (state.list.isEmptyOrNull &&
                          state.status != FormStatus.loading &&
                          state.status != FormStatus.initial) ...[
                        CommonWidgets.verticalSpacerWidget(height * 0.1),
                        const NoRecordFoundWidget(),
                      ],

                      Expanded(
                        child: SmartRefresher(
                          controller: refreshController,
                          enablePullDown: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          header: WaterDropHeader(
                            waterDropColor: AppColors.navigationSkyBlueColor,
                            refresh: state.status != FormStatus.loading
                                ? const BaseLoader()
                                : null,
                          ),
                          key: const Key(Keys.refreshKey),
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: state.hasReachedMax
                                ? state.list.length
                                : state.list.length + 1,
                            itemBuilder: (context, index) {
                              List<Label> labels = [];
                              if (index < state.list.length) {
                                labels.add(Label(
                                    key: state.labels?.locale.locationRegion ??
                                        state.labels?.defaultLocale
                                            .locationRegion ??
                                        'Region',
                                    value: state
                                            .list[index].locationRegion?.name ??
                                        ''));
                                labels.add(Label(
                                    key: state.labels?.locale.location ??
                                        state.labels?.defaultLocale.location ??
                                        'Building Location ',
                                    value: state.list[index].location?.name ??
                                        ''));
                                labels.add(Label(
                                    key: state.labels?.locale.vendor ??
                                        state.labels?.defaultLocale.vendor ??
                                        'Vendor',
                                    value:  state.list[index].vendor?.name ?? ''));
                                labels.add(Label(
                                    key: state.labels?.locale.guard ??
                                        state.labels?.defaultLocale
                                            .guard ??
                                        'Guard Name',
                                    value:
                                    '${state.list[index].guard?.firstName ?? ''} ${state.list[index].guard?.lastName ?? ''}'));
                                labels.add(Label(
                                    key: state.labels?.locale.entrySecurity ??
                                        state.labels?.defaultLocale
                                            .entrySecurity ??
                                        'Created By',
                                    value:
                                        '${state.list[index].entrySecurity?.firstName ?? ''} ${state.list[index].entrySecurity?.lastName ?? ''}'));
                                return index >= state.list.length
                                    ? const BaseLoader()
                                    : BaseListTileItem(
                                        id: state.list[index].id,
                                        labels: labels,
                                        status: state.list[index].status,
                                        isMasterGuard: true,
                                        guardRank: state.list[index].guardRank,
                                        onTap: (selectedIndex) {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext dialogContext) {
                                              return BasePopUpItems(
                                                id: state.list[selectedIndex].id
                                                    .toString(),
                                                slNo: state
                                                    .list[selectedIndex].slNo,
                                                guardRank: state
                                                    .list[selectedIndex]
                                                    .guardRank,
                                                gender: state
                                                    .list[selectedIndex].gender,
                                                dutyType: state
                                                    .list[selectedIndex]
                                                    .dutyType,
                                                maritalStatus: state
                                                    .list[selectedIndex]
                                                    .maritalStatus,
                                                labels: labels,
                                                isMaterGuard: true,
                                                //isEventProtectionStatus: false,
                                                status: state
                                                    .list[selectedIndex].status,
                                              );
                                            },
                                          );
                                        },
                                        onEditTap: (selectedIndex) {
                                          getById(
                                              state.extraProperties
                                                      ?.hasWritePermission ??
                                                  false,
                                              state.list[index].id ?? 0);
                                        },
                                        showEditButton: true,
                                        onViewTap: (selectedIndex) {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext dialogContext) {
                                              return BasePopUpItems(
                                                id: state.list[selectedIndex].id
                                                    .toString(),
                                                slNo: state
                                                    .list[selectedIndex].slNo,
                                                guardRank: state
                                                    .list[selectedIndex]
                                                    .guardRank,
                                                gender: state
                                                    .list[selectedIndex].gender,
                                                dutyType: state
                                                    .list[selectedIndex]
                                                    .dutyType,
                                                maritalStatus: state
                                                    .list[selectedIndex]
                                                    .maritalStatus,
                                                labels: labels,
                                                status: state
                                                    .list[selectedIndex].status,
                                                isMaterGuard: true,
                                                // isEventProtectionStatus: false,
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
              }));
        });
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    GuardingMastersDataModel guardingMastersDataModel =
        await GuardingMasterDataServices().getGuardingMastersData(id);

    editDataLoading(guardingMastersDataModel, hasWritePermission);
  }

  void editDataLoading(GuardingMastersDataModel? guardingMastersDataModel,
      bool hasWritePermission) {
    dismissLoadingDialog(context);

    log('-guardingMastersDataModel---id---${guardingMastersDataModel?.id}---');

    if (guardingMastersDataModel != null) {
      Navigator.pushNamed(context, guardingMasterDataDetailsRoute, arguments: {
        "GuardingMastersDataModel": guardingMastersDataModel,
        "title": Constants.editGuardingMasterData,
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

    BlocProvider.of<GuardingMasterDataBloc>(context).add(
      FetchDataList(
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

    BlocProvider.of<GuardingMasterDataBloc>(context).add(
      FetchDataList(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
