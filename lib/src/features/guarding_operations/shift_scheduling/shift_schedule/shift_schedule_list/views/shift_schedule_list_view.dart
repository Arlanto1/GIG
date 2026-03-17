import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_list/bloc/shift_schedule_list_bloc.dart';

class ShiftScheduleListView extends StatefulWidget {
  const ShiftScheduleListView({
    super.key,
  });

  @override
  State<ShiftScheduleListView> createState() => _ShiftScheduleListViewState();
}

class _ShiftScheduleListViewState extends State<ShiftScheduleListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<ShiftScheduleListBloc>().add(
          const InitializeValues(),
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
      pageNumber = pageNumber + 10;
      context.read<ShiftScheduleListBloc>().add(FetchShiftScheduleList(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<ShiftScheduleListBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<ShiftScheduleListBloc, ShiftScheduleListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.transparent,
            extendBody: true,
            extendBodyBehindAppBar: true,
            // floatingActionButton: state.extraProperties?.hasWritePermission ??
            //         false
            //     ? Flutterfloatingbutton(
            //         backgroundColor: AppColors.navigationSkyBlueColor,
            //         foregroundColor: AppColors.backgroundWhiteColor,
            //         onPressed: () => {
            //           Navigator.pushNamed(context, shiftScheduleDetailsRoute,
            //               arguments: {"title": Constants.createShiftSchedule}),
            //         },
            //       )
            //     : const SizedBox(),
            bottomNavigationBar: CustomBottomNavigationBar(
                scaffoldKey: scaffoldKey,
                context: context,
                hasAddPermission:
                    state.extraProperties?.hasWritePermission ?? false
                        ? true
                        : false,
                displayMenu: state.displayMenu,
                list: true,
                onAddPressed: () {
                  Navigator.pushNamed(context, shiftScheduleDetailsRoute,
                      arguments: {"title": Constants.createShiftSchedule});
                }),
            appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: Constants.shiftSchedule,
              showPopUp: true,
              showSaveButton: false,
              showSubmitButton: false,
              showDisLikeButton: false,
              showLikeButton: false,
              excelAPIName: 'exportShiftSchdExcel',
              pdfAPIName: 'exportShiftSchdPDF',
            ),
            body: BlocBuilder<ShiftScheduleListBloc, ShiftScheduleListState>(
                builder: (context, state) {
              // if (state.status == FormStatus.loading) {
              //   return const BaseLoader();
              // }
              // if (state.list.isEmptyOrNull) {
              //   return const NoRecordFoundWidget();
              // }
              // log('--labels-${state.labels?.locale.locationRegion}');
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
                    top: MediaQuery.of(context).padding.top +
                        kToolbarHeight +
                        -40, // below AppBar
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

                  // 🔹 ListView - start immediately below search bar
                  Positioned(
                    top: MediaQuery.of(context).padding.top +
                        kToolbarHeight +
                        10,
                    // search bar height ~64+padding
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
                          // padding: EdgeInsets.zero,
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: state.hasReachedMax
                              ? state.items.length
                              : state.items.length + 1,
                          itemBuilder: (context, index) {
                            List<Label> labels = [];
                            if (index < state.items.length) {
                              labels.add(Label(
                                  key: state.labels?.locale.createdDate ??
                                      state.labels?.defaultLocale.createdDate ??
                                      Constants.createdDate,
                                  value: state.items[index].inputDate != null
                                      ? Utils.timestampToDateConversion(
                                          int.parse(
                                              state.items[index].inputDate ??
                                                  '0'),
                                          Constants
                                              .twentyFourHourDateTimeFormat)
                                      : ''));
                              // labels.add(Label(
                              // key: state.labels?.locale.entrySecurity ??
                              //     state.labels?.defaultLocale
                              //         .entrySecurity ??
                              //     Constants.createdby,
                              // value:
                              //     '${state.items[index].entrySecurity?.firstName ?? ''}${state.items[index].entrySecurity?.lastName ?? ''} '));
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
                              labels.add(Label(
                                  key: state.labels?.locale.fromDate ??
                                      state.labels?.defaultLocale.fromDate ??
                                      Constants.fromDate,
                                  value: state.items[index].fromDate != null
                                      ? Utils.timestampToDateConversion(
                                          int.parse(
                                              state.items[index].fromDate ??
                                                  '0'),
                                          Constants.dateFormat)
                                      : ''));
                              labels.add(Label(
                                  key: state.labels?.locale.toDate ??
                                      state.labels?.defaultLocale.toDate ??
                                      Constants.toDate,
                                  value: state.items[index].toDate != null
                                      ? Utils.timestampToDateConversion(
                                          int.parse(
                                              state.items[index].toDate ?? '0'),
                                          Constants.dateFormat)
                                      : ''));

                              return index >= state.items.length
                                  ? const BaseLoader()
                                  :
                                  // index >= state.items.length
                                  //   ? const BaseLoader()
                                  Container(
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 18, sigmaY: 18),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.white.withValues(
                                                            alpha: 0.09),
                                                        Colors.transparent,
                                                        Colors.white.withValues(
                                                            alpha: 0.09),
                                                        // Color(0xFF6474C6).withOpacity(0.14)
                                                      ],
                                                      stops: const [0.02, 0.35, 1],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            27),
                                                    border: Border.all(
                                                      color: Colors.white
                                                          .withValues(
                                                              alpha: 0.6),
                                                      width: 0.7,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.white
                                                            .withValues(
                                                                alpha: 0.0),
                                                        blurRadius: 12,
                                                        offset:
                                                            const Offset(0, 2),
                                                      ),
                                                    ],
                                                  ),
                                                  child: BaseListTileItem(
                                                    id: state.items[index].id,
                                                    status: state
                                                        .items[index].status,
                                                    isMasterGuard: false,
                                                    isShiftScheduleStatus: true,
                                                    isEventProtectionStatus:
                                                        false,
                                                    labels: labels,
                                                    onTap: (selectedIndex) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            dialogContext) {
                                                          return BasePopUpItems(
                                                            id: state
                                                                .items[
                                                                    selectedIndex]
                                                                .id
                                                                .toString(),
                                                            labels: labels,
                                                            slNo: state
                                                                .items[
                                                                    selectedIndex]
                                                                .slNo,
                                                            status: state
                                                                .items[
                                                                    selectedIndex]
                                                                .status,
                                                            isMasterGuard:
                                                                false,
                                                            isEventProtectionStatus:
                                                                false,
                                                            isShiftScheduleStatus:
                                                                true,
                                                          );
                                                        },
                                                      );
                                                    },
                                                    showEditButton: state
                                                            .items[index]
                                                            .status !=
                                                        ConstantsIntValue
                                                            .cancelledStatus,
                                                    onEditTap: (selectedIndex) {
                                                      getById(
                                                          state.extraProperties
                                                                  ?.hasWritePermission ??
                                                              false,
                                                          id: state.items[index]
                                                                  .id ??
                                                              0);
                                                    },
                                                    onViewTap: (selectedIndex) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            dialogContext) {
                                                          return BasePopUpItems(
                                                            id: state
                                                                .items[
                                                                    selectedIndex]
                                                                .id
                                                                .toString(),
                                                            labels: labels,
                                                            slNo: state
                                                                .items[
                                                                    selectedIndex]
                                                                .slNo,
                                                            status: state
                                                                .items[
                                                                    selectedIndex]
                                                                .status,
                                                            isMasterGuard:
                                                                false,
                                                            isEventProtectionStatus:
                                                                false,
                                                            isShiftScheduleStatus:
                                                                true,
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
              );
            }));
      },
    );
  }

  // getById(int id) async {
  //   showLoadingDialog(context);
  //
  //   ShiftScheduleModel shiftScheduleModel =
  //       await ShiftScheduleServices().getById(id);
  //
  //   editDataLoading(shiftScheduleModel);
  // }
  //
  // void editDataLoading(ShiftScheduleModel? shiftScheduleModel) {
  //   dismissLoadingDialog(context);
  //   if (shiftScheduleModel != null) {
  //     Navigator.pushNamed(context, dutyPostMasterDetailsRoute, arguments: {
  //       "shiftScheduleModel": shiftScheduleModel,
  //       "title": Constants.editShiftSchedule
  //     });
  //   }
  // }

  getById(
    bool hasWritePermission, {
    required int id,
  }) async {
    Navigator.pushNamed(
      context,
      shiftScheduleDetailsRoute,
      arguments: {
        ConstantsArgument.id: id.toString(),
        ConstantsArgument.title: Constants.editShiftSchedule,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      },
    );
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<ShiftScheduleListBloc>(context).add(
      FetchShiftScheduleList(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
  }

  void applyFilters(
    Filters model,
  ) {
    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));

    BlocProvider.of<ShiftScheduleListBloc>(context).add(
      FetchShiftScheduleList(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
