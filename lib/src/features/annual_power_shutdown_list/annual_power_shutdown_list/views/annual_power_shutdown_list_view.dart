import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../bloc/annual_power_shutdown_list_bloc.dart';

class AnnualPowerShutdownListView extends StatefulWidget {
  const AnnualPowerShutdownListView({
    super.key,
  });

  @override
  State<AnnualPowerShutdownListView> createState() =>
      _AnnualPowerShutdownListViewState();
}

class _AnnualPowerShutdownListViewState
    extends State<AnnualPowerShutdownListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<AnnualPowerShutdownListBloc>().add(
          const InitializeValuesAPS(),
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
      context.read<AnnualPowerShutdownListBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  void _onRefresh() async {
    context.read<AnnualPowerShutdownListBloc>().add(
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
    return BlocConsumer<AnnualPowerShutdownListBloc,
        AnnualPowerShutdownListState>(listener: (context, state) {
      log('--state.status---${state.status}--');
      Utils().errorAndLogout(state, context);
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: state.extraProperties?.hasWritePermission ?? false
            ? Flutterfloatingbutton(
                backgroundColor: AppColors.navigationSkyBlueColor,
                foregroundColor: AppColors.backgroundWhiteColor,
                onPressed: () => {
                  Navigator.pushNamed(
                    context,
                    annualPowerShutdownListDetailsRoute,
                  )
                },
              )
            : const SizedBox(),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.annualPowerShutdownListTitle,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'exportEPExcel?aps=1',
          pdfAPIName: 'exportEPPDF?aps=1',
        ),
        body: BlocBuilder<AnnualPowerShutdownListBloc,
            AnnualPowerShutdownListState>(
          builder: (context, state) {
            // if (state.status == FormStatus.initial) {
            //   return const BaseLoader();
            // }
            // if (state.items.isEmptyOrNull) {
            //   return const NoRecordFoundWidget();
            // }
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
                  UtilsCommon().showNoRecordWidget(
                      state: state, height: height, items: state.items),
                  Expanded(
                    child: SmartRefresher(
                      controller: refreshController,
                      enablePullDown: true,
                      physics: const BouncingScrollPhysics(),
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
                            ? state.items.length
                            : state.items.length + 1,
                        itemBuilder: (context, index) {
                          List<Label> labels = [];
                          if (index < state.items.length) {
                            labels.add(Label(
                                key: state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    'Date of Creation',
                                value: state.items[index].inputDate != null
                                    ? Utils.timestampToDateConversion(
                                        int.tryParse(
                                            state.items[index].inputDate ??
                                                '0'),
                                        Constants.dateFormat)
                                    : ''));
                            labels.add(Label(
                                key: state.labels?.locale.locationRegion ??
                                    state
                                        .labels?.defaultLocale.locationRegion ??
                                    'Region',
                                value:
                                    state.items[index].locationRegion?.name ??
                                        ''));
                            labels.add(Label(
                                key: state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    'Location',
                                value:
                                    state.items[index].location?.name ?? ''));

                            return index >= state.items.length
                                ? const BaseLoader()
                                : BaseListTileItem(
                                    id: state.items[index].id,
                                    labels: labels,
                                    status: state.items[index].status,
                                    isMasterGuard: false,
                                    isEventProtectionStatus: true,
                                    onTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.items[selectedIndex].id
                                                .toString(),
                                            labels: labels,
                                            slNo:
                                                state.items[selectedIndex].slNo,
                                            status: state
                                                .items[selectedIndex].status,
                                            isMasterGuard: false,
                                            isEventProtectionStatus: true,
                                            epManager1Name: state
                                                .items[selectedIndex]
                                                .epManager1Name,
                                            eventType: state
                                                .items[selectedIndex].eventType,
                                          );
                                        },
                                      );
                                    },
                                    onEditTap: (selectedIndex) {
                                      getId(
                                          state.extraProperties
                                                  ?.hasWritePermission ??
                                              false,
                                          id: state.items[index].id ?? 0,
                                          eventStatus:
                                              state.items[index].status ?? 0);
                                    },
                                    onViewTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.items[selectedIndex].id
                                                .toString(),
                                            labels: labels,
                                            slNo:
                                                state.items[selectedIndex].slNo,
                                            status: state
                                                .items[selectedIndex].status,
                                            isEventProtectionStatus: true,
                                            // epManager1Name:
                                            // state.items[selectedIndex].epManager1Name,
                                            // eventType:
                                            // state.items[selectedIndex].eventType,
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
    });
  }

  getId(
    bool hasWritePermission, {
    required int id,
    required int eventStatus,
  }) async {
    Navigator.pushNamed(
      context,
      annualPowerShutdownListDetailsRoute,
      arguments: {
        'id': id.toString(),
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      },
    );
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<AnnualPowerShutdownListBloc>(context).add(
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

    BlocProvider.of<AnnualPowerShutdownListBloc>(context).add(
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
