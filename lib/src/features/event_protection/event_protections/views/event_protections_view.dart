import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../bloc/event_protections_bloc.dart';

class EventProtectionsView extends StatefulWidget {
  const EventProtectionsView({
    super.key,
  });

  @override
  State<EventProtectionsView> createState() => _EventProtectionsViewState();
}

class _EventProtectionsViewState extends State<EventProtectionsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<EventProtectionsBloc>().add(
          const InitializeValuesEP(),
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

  // void _onScroll() {
  //   if (!_scrollController.hasClients) return;
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.position.pixels;
  //
  //   // Set a threshold value, e.g., 100 pixels from the end
  //   const threshold = 1000.0;
  //
  //   if (maxScroll - currentScroll <= threshold) {
  //     pageNumber = pageNumber + 20;
  //     context
  //         .read<EventProtectionsBloc>()
  //         .add(InwardFetch(startPos: pageNumber, maxPos: 20));
  //   }
  // }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      pageNumber = pageNumber + 20;
      context.read<EventProtectionsBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: 20,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  void _onRefresh() async {
    context.read<EventProtectionsBloc>().add(
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
      floatingActionButton: Flutterfloatingbutton(
        backgroundColor: AppColors.navigationSkybluecolor,
        foregroundColor: AppColors.backgroundWhitecolor,
        onPressed: () => {
          Navigator.pushNamed(
            context,
            eventProtectionDetailsTabRoute,
          )
        },
      ),
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: Constants.eventProtectionTitle,
        showPopUp: true,
        showSaveButton: false,
        showSubmitButton: false,
        showDisLikeButton: false,
        showLikeButton: false,
        excelAPIName: 'exportEPExcel?aps=0',
        pdfAPIName: 'exportEPPDF?aps=0',
      ),
      body: BlocBuilder<EventProtectionsBloc, EventProtectionsState>(
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
                color: AppColors.backgroundWhitecolor,
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
                if (state.items.isEmptyOrNull &&
                    state.status != FormStatus.loading) ...[
                  CommonWidgets.verticalSpacerWidget(height * 0.1),
                  const NoRecordFoundWidget(),
                ],
                Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullDown: true,
                    physics: const BouncingScrollPhysics(),
                    header: const WaterDropHeader(
                      waterDropColor: AppColors.navigationSkybluecolor,
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
                              key: state.labels?.locale.inputDate ??
                                  state.labels?.defaultLocale.inputDate ??
                                  'Date of Creation',
                              value: state.items[index].inputDate != null
                                  ? Utils.timestamptoDateConversion(
                                      int.parse(
                                          state.items[index].inputDate ?? '0'),
                                      Constants.dateFormat)
                                  : ''));
                          labels.add(Label(
                              key: state.labels?.locale.locationRegion ??
                                  state.labels?.defaultLocale.locationRegion ??
                                  'Region',
                              value: state.items[index].locationRegion?.name ??
                                  ''));
                          labels.add(Label(
                              key: state.labels?.locale.location ??
                                  state.labels?.defaultLocale.location ??
                                  'Location',
                              value: state.items[index].location?.name ?? ''));

                          return index >= state.items.length
                              ? const BaseLoader()
                              : BaseListTileItem(
                                  id: state.items[index].id,
                                  labels: labels,
                                  status: state.items[index].status,
                                  isMasterGuard: false,
                                  onTap: (selectedIndex) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return BasePopUpItems(
                                          id: state.items[selectedIndex].id
                                              .toString(),
                                          labels: labels,
                                          slNo: state.items[selectedIndex].slNo,
                                          status:
                                              state.items[selectedIndex].status,
                                          isMasterGuard: false,
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
                                    getById(
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
                                          isMasterGuard: false,
                                          slNo: state.items[selectedIndex].slNo,
                                          status:
                                              state.items[selectedIndex].status,
                                          epManager1Name: state
                                              .items[selectedIndex]
                                              .epManager1Name,
                                          eventType: state
                                              .items[selectedIndex].eventType,
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
  }

  getById({
    required int id,
    required int eventStatus,
  }) async {
    log('-----');
    var nav = Navigator.of(context);
    ShowEPGridsModel showEPGridsModel =
        await EventProtectionServices().showEpGrids(id);
    nav.pushNamed(
      eventProtectionDetailsTabRoute,
      arguments: {
        'id': id.toString(),
        'eventStatus': eventStatus,
        ConstantsArgument.showEPGridsModel: showEPGridsModel,
      },
    );
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<EventProtectionsBloc>(context).add(
      FetchData(startPos: 0, maxPos: 20, newSearch: true, filters: filters),
    );
  }

  void applyFilters(
    Filters model,
  ) {
    log('Applying Filters');

    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    log('id---filtersFun----${filters.filterCriteria!.filters!.id}---');

    BlocProvider.of<EventProtectionsBloc>(context).add(
      FetchData(startPos: 0, maxPos: 20, newSearch: true, filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
