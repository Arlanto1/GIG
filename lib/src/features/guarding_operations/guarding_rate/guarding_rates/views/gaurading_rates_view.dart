import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
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

  Future<void> _onRefresh() async {
    context.read<GuardingRatesBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<GuardingRatesBloc, GuardingRatesState>(
        listener: (context, state) {
          Utils().formError(state, context);
          Utils().errorAndLogout(state, context);
        }, builder: (context, state) {
      return Scaffold(
          backgroundColor: AppColors.newColor,
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
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: false,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true,
            // 🔥 only "+" button mode
            onAddPressed: () {
            },
          ),
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
              width: double.infinity,
              height: double.infinity,
              color: AppColors.newColor3,
              // margin: allMargin16,
              // decoration: const ShapeDecoration(
              //     color: AppColors.backgroundWhiteColor,
              //     shape: RoundedRectangleBorder(
              //       borderRadius:
              //           BorderRadius.vertical(top: Radius.circular(20.0)),
              //     )),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonWidgets.verticalSpacerWidget(height * 0.01),
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
                    if (state.status != FormStatus.loading)
                      const NoRecordFoundWidget(),
                  ],
                  Expanded(
                    child: CustomMaterialIndicator(
                      onRefresh: () => _onRefresh(),
                      backgroundColor: Colors.white,
                      indicatorBuilder: (context, controller) {
                        return const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: BaseLoader(),
                        );
                      },
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
                                      Constants.dateofcreation,
                                  value: state.items[index].inputDate != null
                                      ? Utils.timestampToDateConversion(
                                      int.parse(
                                          state.items[index].inputDate ??
                                              '0'),
                                      Constants.twentyFourHourDateTimeFormat)
                                      : ''));
                              labels.add(Label(
                                  key: state.labels?.locale.locationRegion ??
                                      state
                                          .labels?.defaultLocale
                                          .locationRegion ??
                                      Constants.region,
                                  value:
                                  state.items[index].locationRegion?.name ??
                                      ''));
                              labels.add(Label(
                                  key: state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.buildingLocation,
                                  value:
                                  state.items[index].location?.name ?? ''));
                              labels.add(Label(
                                  key: state.labels?.locale.slNo ??
                                      state.labels?.defaultLocale.slNo ??
                                      Constants.slno,
                                  value: state.items[index].slNo ?? ''));
                              return index >= state.items.length
                                  ? const BaseLoader()
                                  : Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),

                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 18, sigmaY: 18),
                                          child: Container(
                                              decoration:
                                              BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white.withValues(alpha: 0.09),
                                                    Colors.transparent,
                                                    Colors.white.withValues(alpha: 0.09),
                                                    // Color(0xFF6474C6).withOpacity(0.14)
                                                  ],
                                                  stops: [0.02, 0.35, 1],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                                borderRadius: BorderRadius.circular(27),
                                                border: Border.all(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.6),
                                                  width: 0.7,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white
                                                        .withValues(alpha: 0.0),
                                                    blurRadius: 12,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: BaseListTileItem(
                                                id: state.items[index].id,
                                                // inputDate: state.items[index].inputDate,
                                                vendors: state.items[index]
                                                    .vendor,
                                                labels: labels,
                                                onTap: (selectedIndex) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (
                                                        BuildContext dialogContext) {
                                                      return BasePopUpItems(
                                                        id: state
                                                            .items[selectedIndex]
                                                            .id
                                                            .toString(),
                                                        labels: labels,
                                                        // inputDate: state
                                                        //     .items[selectedIndex].inputDate,
                                                        // slNo:
                                                        //     state.items[selectedIndex].slNo,
                                                        vendors:
                                                        state
                                                            .items[selectedIndex]
                                                            .vendor,
                                                      );
                                                    },
                                                  );
                                                },
                                                showEditButton: false,
                                                onEditTap: (selectedIndex) {
                                                  getId(
                                                      state.extraProperties
                                                          ?.hasWritePermission ??
                                                          false,
                                                      state.items[index].id ??
                                                          0);
                                                },
                                                onViewTap: (selectedIndex) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (
                                                        BuildContext dialogContext) {
                                                      return BasePopUpItems(
                                                        id: state
                                                            .items[selectedIndex]
                                                            .id
                                                            .toString(),
                                                        // inputDate: state
                                                        //     .items[selectedIndex].inputDate,
                                                        labels: labels,
                                                        // slNo:
                                                        //     state.items[selectedIndex].slNo,
                                                        vendors:
                                                        state
                                                            .items[selectedIndex]
                                                            .vendor,

                                                        // status: state.items[selectedIndex].status
                                                        //     .toString(),
                                                        // entrySecurityName: state
                                                        //     .items[selectedIndex].entrySecurityName,
                                                      );
                                                    },
                                                  );
                                                },
                                                index: index,
                                              )))));
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
    });
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
