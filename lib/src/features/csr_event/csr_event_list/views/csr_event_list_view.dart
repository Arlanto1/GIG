import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/csr_event/services/csr_event_services.dart';
import '../bloc/csr_event_list_bloc.dart';

class CSREventListView extends StatefulWidget {

  const CSREventListView({
    super.key,
    required this.isCSREvent,
    required this.isSportEvent,
  });

  final bool isCSREvent;
  final bool isSportEvent;

  @override
  State<CSREventListView> createState() => _CSREventListViewState();
}

class _CSREventListViewState extends State<CSREventListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<CSREventBloc>().add(
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
      context.read<CSREventBloc>().add(FetchData(
        startPos: pageNumber,
        maxPos: Constants.maxResults,
        newSearch: false,
        filters: filters,
      ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<CSREventBloc>().add(
      const RefreshList(),
    );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<CSREventBloc, CSREventState>(
      listener: (context, state) {},
      builder: (context, state) {
        return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                // fallback to list screen
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  csrEventListRoute, arguments: {ConstantsArgument.isCSREvent : widget.isCSREvent, ConstantsArgument.isSportEvent : widget.isSportEvent}, // or appropriate route
                      (route) => false,
                );
              }
            },
        child:  Scaffold(
          backgroundColor:AppColors.newColor,
          extendBody: true,
          extendBodyBehindAppBar: true,
          // backgroundColor: AppColors.cardBgColor,
          // floatingActionButton:
          //     state.extraProperties?.hasWritePermission ?? false
          //         ? Flutterfloatingbutton(
          //             backgroundColor: AppColors.navigationSkyBlueColor,
          //             foregroundColor: AppColors.backgroundWhiteColor,
          //             onPressed: () => {
          //               Navigator.pushNamed(
          //                 context,
          //                 eventProtectionDetailsTabRoute,
          //               )
          //             },
          //           )
          //         : const SizedBox(),
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: false,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true, // 🔥 only "+" button mode
            onAddPressed: () {
              // Navigator.pushNamed(
              //   context,
              //   articleFoundNewDetailsRoute,
              //   arguments: {"title": Constants.createFound},
              // );
            },
          ),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.isCSREvent ? Constants.cSREventList : Constants.sportEventList,
            showPopUp: false,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportEPExcel?aps=0',
            pdfAPIName: 'exportEPPDF?aps=0',
          ),
          body: BlocBuilder<CSREventBloc, CSREventState>(
            builder: (context, state) {
              // if (state.status == FormStatus.initial) {
              //   return const BaseLoader();
              // }
              // if (state.items.isEmptyOrNull) {
              //   return const NoRecordFoundWidget();
              // }
              return Stack(
                children: [
                  // 🔹 Background
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/bg2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                  ),

                  // 🔹 Search Bar - positioned safely at the top
                  Positioned(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight + -40, // below AppBar
                    left: 3,
                    right: 3,
                    child: BaseSearchWidget(
                      applySearchFilters: applySearchFilters,
                      applyFilters: applyFilters,
                      commonFilters: state.commonFilters ??
                          CommonFilters(
                            statuses: [],
                            regions: [],
                          ),
                    ),
                  ),

                  //  ListView - start immediately below search bar
                  Positioned(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight + 4, // search bar height ~64+padding
                    left: 0,
                    right: 0,
                    bottom: 0,
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
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: state.hasReachedMax
                            ? state.items.length
                            : state.items.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.items.length) {
                            if (state.status == FormStatus.loading ||
                                state.status == FormStatus.initial) {
                              return const Center(child: BaseLoader());
                            }
                            return const SizedBox();
                          }
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
                                    Constants
                                        .twentyFourHourDateTimeFormat)
                                    : ''));
                            labels.add(Label(
                                key: state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale
                                        .entrySecurity ??
                                    Constants.createdby,
                                value:
                                '${state.items[index].createdBy?.firstName ?? ''} ${state.items[index].createdBy?.lastName ?? ''}'));
                            labels.add(Label(
                                key: state.labels?.locale.locationRegion ??
                                    state.labels?.defaultLocale
                                        .locationRegion ??
                                    Constants.region,
                                value:
                                state.items[index].locationRegion?.name ??
                                    ''));
                            labels.add(Label(
                                key: state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                value:
                                state.items[index].location?.name ?? ''));
                            if (!state
                                .items[index].eventStartDate.isEmptyOrNull) {
                              labels.add(Label(
                                  key: state.labels?.locale.eventStartDate ??
                                      state.labels?.defaultLocale
                                          .eventStartDate ??
                                      Constants.eventStartDate,
                                  value: Utils.timestampToDateConversion(
                                      int.tryParse(
                                          state.items[index].eventStartDate ??
                                              '0'),
                                      Constants
                                          .twentyFourHourDateTimeFormat)));
                            }
                            if (!(state
                                .items[index].eventEndDate.isEmptyOrNull)) {
                              labels.add(Label(
                                  key: state.labels?.locale.eventEndDate ??
                                      state.labels?.defaultLocale
                                          .eventEndDate ??
                                      Constants.eventEndDate,
                                  value: Utils.timestampToDateConversion(
                                      int.tryParse(
                                          state.items[index].eventEndDate ??
                                              '0'),
                                      Constants
                                          .twentyFourHourDateTimeFormat)));
                            }
                            return index >= state.items.length
                                ? const SizedBox()
                                : Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      // Color(0xFF6474C6),
                                      // Color(0xFF6474C6),
                                      Colors.transparent,
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
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
                                                stops: const [0.02, 0.35, 1],
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
                                              labels: labels,
                                              status: state.items[index].status,
                                              isMasterGuard: false,
                                              isEventProtectionStatus: false,
                                              isCSREventProtectionStatus: true,
                                              onTap: (selectedIndex) {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext dialogContext) {
                                                    return BasePopUpItems(
                                                      id: state.items[selectedIndex].id
                                                          .toString(),
                                                      labels: labels,
                                                      slNo: state
                                                          .items[selectedIndex].slNo,
                                                      status: state
                                                          .items[selectedIndex].status,
                                                      isMasterGuard: false,
                                                      isEventProtectionStatus: false,
                                                      isCSREventProtectionStatus: true,                                                      // eventType: state
                                                      //     .items[selectedIndex]
                                                      //     .eventType,
                                                    );
                                                  },
                                                );
                                              },
                                              showEditButton: state
                                                  .items[index].status !=
                                                  ConstantsIntValue
                                                      .cancelledStatus &&
                                                  state.items[index].status !=
                                                      ConstantsIntValue.ePClosedStatus,
                                              onEditTap: (selectedIndex) {
                                                getById(
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
                                                  builder:
                                                      (BuildContext dialogContext) {
                                                    return BasePopUpItems(
                                                      id: state.items[selectedIndex].id
                                                          .toString(),
                                                      labels: labels,
                                                      isMasterGuard: false,
                                                      isEventProtectionStatus: false,
                                                      isCSREventProtectionStatus: true,                                                      slNo: state
                                                          .items[selectedIndex].slNo,
                                                      status: state
                                                          .items[selectedIndex].status,
                                                      // eventType: state
                                                      //     .items[selectedIndex]
                                                      //     .eventType,
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
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),);

      },
    );
  }

  getById(
      bool hasWritePermission, {
        required int id,
        required int eventStatus,
      }) async {
    log('-----');
    showLoadingDialog(context);

    ShowEPGridsModel? model;
    try {
      model = await CSREventServices().showEventGrids(id);
    } finally {
      if (mounted) dismissLoadingDialog(context);
    }

    if (!mounted || model == null) return;

    editDataLoading(model, hasWritePermission, id: id, eventStatus: eventStatus);
  }

  void editDataLoading(
      ShowEPGridsModel model,
      bool hasWritePermission, {
        required int id,
        required int eventStatus,
      }) {
    if (!mounted) return;
    var nav = Navigator.of(context);
    nav.pushNamed(
      csrEventDetailsTabRoute,
      arguments: {
        ConstantsArgument.id: id,
        'eventStatus': eventStatus,
        ConstantsArgument.title: Constants.cSREventList,
        ConstantsArgument.isCSREvent: widget.isCSREvent,
        ConstantsArgument.isSportEvent: widget.isSportEvent,
        ConstantsArgument.showEPGridsModel: model,
        ConstantsArgument.extraProperties:
        ExtraProperties(hasWritePermission: hasWritePermission),
      },
    );
    if (mounted) {
      context.read<CSREventBloc>().add(const RefreshList());
    }
  }

  // getById(
  //     bool hasWritePermission, {
  //       required int id,
  //       required int eventStatus,
  //     }) async {
  //   showLoadingDialog(context);
  //
  //   log('-----');
  //   var nav = Navigator.of(context);
  //   dismissLoadingDialog(context);
  //
  //   ShowEPGridsModel showEPGridsModel =
  //   await CSREventServices().showEventGrids(id);
  //   if (!mounted) return;
  //   nav.pushNamed(
  //     csrEventDetailsTabRoute,
  //     arguments: {
  //       ConstantsArgument.id: id,
  //       'eventStatus': eventStatus,
  //       ConstantsArgument.title: Constants.cSREventList,
  //       ConstantsArgument.isCSREvent: widget.isCSREvent,
  //       ConstantsArgument.isSportEvent: widget.isSportEvent,
  //       ConstantsArgument.showEPGridsModel: showEPGridsModel,
  //       ConstantsArgument.extraProperties:
  //       ExtraProperties(hasWritePermission: hasWritePermission),
  //     },
  //   );
  // }
  //
  // getById(bool hasWritePermission, { required int id, required int eventStatus}) async{
  //   showLoadingDialog(context);
  //   ShowEPGridsModel model = await CSREventServices().showEventGrids(id);
  //   editDataLoading(model, hasWritePermission);
  // }
  //
  // void editDataLoading(ShowEPGridsModel? model, bool hasWritePermission, int eventStatus) {
  //   dismissLoadingDialog(context);
  //     if (!mounted) return;
  //     var nav = Navigator.of(context);
  //     nav.pushNamed(
  //       csrEventDetailsTabRoute,
  //       arguments: {
  //         ConstantsArgument.id: id,
  //         'eventStatus': eventStatus,
  //         ConstantsArgument.title: Constants.cSREventList,
  //         ConstantsArgument.isCSREvent: widget.isCSREvent,
  //         ConstantsArgument.isSportEvent: widget.isSportEvent,
  //         ConstantsArgument.showEPGridsModel: showEPGridsModel,
  //         ConstantsArgument.extraProperties:
  //         ExtraProperties(hasWritePermission: hasWritePermission),
  //       },
  //     );
  // }
  void applySearchFilters(
      FilterCriteria model,
      ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<CSREventBloc>(context).add(
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

    BlocProvider.of<CSREventBloc>(context).add(
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
