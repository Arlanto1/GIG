import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../services/guarding_services.dart';
import '../bloc/guarding_rates_bloc.dart';

class GuardingRatesView extends StatefulWidget {
  const GuardingRatesView({
    super.key,
  });

  @override
  State<GuardingRatesView> createState() => _GuardingRatesViewState();
}

class _GuardingRatesViewState extends State<GuardingRatesView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<GuardingRatesBloc>().add(
          const InitializeValuesGR(),
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
    log('---_onScroll----');
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      pageNumber = pageNumber + 20;
      context.read<GuardingRatesBloc>().add(
            FetchData(
              startPos: pageNumber,
              maxPos: Constants.maxResults,
              newSearch: false,
              filters: filters,
            ),
          );
    }
  }

  void _onRefresh() async {
    context.read<GuardingRatesBloc>().add(
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
    return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        // floatingActionButton: Flutterfloatingbutton(
        //   backgroundColor: AppColors.navigationSkybluecolor,
        //   foregroundColor: AppColors.backgroundWhitecolor,
        //   onPressed: () => {
        //     Navigator.pushNamed(
        //       context,
        //       guardingRateDetailsRoute,
        //       arguments: {
        //         "title": Constants.createGuardingRatingCards,
        //         "gmRate": GMRate(),
        //       },
        //     )
        //   },
        // ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.guardingRates,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'exportGMRateExcel',
          pdfAPIName: 'exportGMRatePDF',
        ),
        body: BlocConsumer<GuardingRatesBloc, GuardingRatesState>(
            listener: (context, state) {
          Utils().formError(state, context);
          Utils().errorAndLogout(state, context);

          if (state.status == FormStatus.sessionExpired) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message ?? 'Session Expired...')));
            Validator.logoutAction(context);
          }
        }, builder: (context, state) {
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
                // Text('-state.status-${state.status}----'),
                if (state.status == FormStatus.loading) ...[
                  CommonWidgets.verticalSpacerWidget(height * 0.01),
                  const BaseLoader(),
                  CommonWidgets.verticalSpacerWidget(height * 0.01),
                ],
                // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                // Text('state.status=====${state.status}'),
                // if (state.items.isEmptyOrNull &&
                //     state.status != FormStatus.initial &&
                //     state.status != FormStatus.loading) ...[
                //   CommonWidgets.verticalSpacerWidget(height * 0.1),
                //   const NoRecordFoundWidget(),
                // ],

                if (state.items.isEmptyOrNull) ...[
                  CommonWidgets.verticalSpacerWidget(height * 0.1),
                  if (state.status != FormStatus.loading) const NoRecordFoundWidget(),
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
                                        int.parse(
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
                                    'Building Location',
                                value:
                                    state.items[index].location?.name ??
                                        ''));
                            labels.add(Label(
                                key: state.labels?.locale.slNo ??
                                    state.labels?.defaultLocale.slNo ??
                                    'SlNo',
                                value: state.items[index].slNo ?? ''));
                            return BaseListTileItem(
                              id: state.items[index].id,
                              // inputDate: state.items[index].inputDate,
                              vendors: state.items[index].vendor,
                              onTap: (selectedIndex) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return BasePopUpItems(
                                      id: state.items[selectedIndex].id
                                          .toString(),
                                      labels: labels,
                                      // inputDate: state
                                      //     .items[selectedIndex].inputDate,
                                      // slNo:
                                      //     state.items[selectedIndex].slNo,
                                      vendors:
                                          state.items[selectedIndex].vendor,
                                    );
                                  },
                                );
                              },
                              onEditTap: (selectedIndex) {
                                getId(
                                    state.extraProperties?.hasWritePermission ??
                                        false,
                                    state.items[index].id ?? 0);
                              },
                              onViewTap: (selectedIndex) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return BasePopUpItems(
                                      id: state.items[selectedIndex].id
                                          .toString(),
                                      // inputDate: state
                                      //     .items[selectedIndex].inputDate,
                                      labels: labels,
                                      // slNo:
                                      //     state.items[selectedIndex].slNo,
                                      vendors:
                                          state.items[selectedIndex].vendor,

                                      // status: state.items[selectedIndex].status
                                      //     .toString(),
                                      // entrySecurityName: state
                                      //     .items[selectedIndex].entrySecurityName,
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
                        }),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  getId(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    GMRate response = await GuardingServices().getRate(id);

    log('----response sgr--------${response.securityGuardRates?.length}---');

    editDataLoading(response, hasWritePermission);
  }

  void editDataLoading(GMRate? rate, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (rate != null) {
      Navigator.pushNamed(
        context,
        guardingRateDetailsRoute,
        arguments: {
          "title": Constants.createGuardingRatingCards,
          "gmRate": rate,
          ConstantsArgument.extraProperties:
              ExtraProperties(hasWritePermission: hasWritePermission),
        },
      );
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<GuardingRatesBloc>(context).add(
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

    BlocProvider.of<GuardingRatesBloc>(context).add(
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
