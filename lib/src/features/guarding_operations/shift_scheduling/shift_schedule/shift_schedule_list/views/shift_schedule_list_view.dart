import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_list/bloc/shift_schedule_list_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

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
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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
      pageNumber = pageNumber + 20;
      context.read<ShiftScheduleListBloc>().add(FetchShiftScheduleList(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  void _onRefresh() async {
    context.read<ShiftScheduleListBloc>().add(
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
    return BlocConsumer<ShiftScheduleListBloc, ShiftScheduleListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.cardBgColor,
            floatingActionButton: state.extraProperties?.hasWritePermission ??
                    false
                ? Flutterfloatingbutton(
                    backgroundColor: AppColors.navigationSkybluecolor,
                    foregroundColor: AppColors.backgroundWhitecolor,
                    onPressed: () => {
                      Navigator.pushNamed(context, shiftScheduleDetailsRoute,
                          arguments: {"title": Constants.createShiftSchedule}),
                    },
                  )
                : const SizedBox(),
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
                    ],
                    // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                    // Text('state.status=====${state.status}'),
                    if (state.items.isEmptyOrNull &&
                        state.status != FormStatus.loading &&
                        state.status != FormStatus.initial) ...[
                      CommonWidgets.verticalSpacerWidget(height * 0.1),
                      const NoRecordFoundWidget(),
                    ],

                    Expanded(
                      child: SmartRefresher(
                        controller: refreshController,
                        enablePullDown: true,
                        physics: const BouncingScrollPhysics(),
                        header: WaterDropHeader(
                          waterDropColor: AppColors.navigationSkybluecolor,
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
                                    key: state.labels?.locale.createdDate ??
                                        state.labels?.defaultLocale
                                            .createdDate ??
                                        'Date of Creation',
                                    value: state.items[index].inputDate != null
                                        ? Utils.timestampToDateConversion(
                                            int.parse(
                                                state.items[index].inputDate ??
                                                    '0'),
                                            Constants.dateFormat)
                                        : ''));
                                labels.add(Label(
                                    key: state.labels?.locale.entrySecurity ??
                                        state.labels?.defaultLocale
                                            .entrySecurity ??
                                        'Created By',
                                    value:
                                        '${state.items[index].entrySecurity?.firstName ?? ''} ${state.items[index].entrySecurity?.lastName ?? ''}'));

                                labels.add(Label(
                                    key: state.labels?.locale.locationRegion ??
                                        state.labels?.defaultLocale
                                            .locationRegion ??
                                        'Region',
                                    value: state.items[index].locationRegion
                                            ?.name ??
                                        ''));
                                labels.add(Label(
                                    key: state.labels?.locale.location ??
                                        state.labels?.defaultLocale.location ??
                                        'Location',
                                    value: state.items[index].location?.name ??
                                        ''));

                                return index >= state.items.length
                                    ? null
                                    : BaseListTileItem(
                                        id: state.items[index].id,
                                        status: state.items[index].status,
                                        isMasterGuard: false,
                                        isShiftScheduleStatus: true,
                                        isEventProtectionStatus: false,
                                        labels: labels,
                                        onTap: (selectedIndex) {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext dialogContext) {
                                              return BasePopUpItems(
                                                id: state
                                                    .items[selectedIndex].id
                                                    .toString(),
                                                labels: labels,
                                                slNo: state
                                                    .items[selectedIndex].slNo,
                                                status: state
                                                    .items[selectedIndex]
                                                    .status,
                                                isMasterGuard: false,
                                                isEventProtectionStatus: false,
                                                isShiftScheduleStatus: true,
                                              );
                                            },
                                          );
                                        },
                                        onEditTap: (selectedIndex) {
                                          getById(
                                              state.extraProperties
                                                      ?.hasWritePermission ??
                                                  false,
                                              id: state.items[index].id ?? 0);
                                        },
                                        onViewTap: (selectedIndex) {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext dialogContext) {
                                              return BasePopUpItems(
                                                id: state
                                                    .items[selectedIndex].id
                                                    .toString(),
                                                labels: labels,
                                                slNo: state
                                                    .items[selectedIndex].slNo,
                                                status: state
                                                    .items[selectedIndex]
                                                    .status,
                                                isMasterGuard: false,
                                                isEventProtectionStatus: false,
                                                isShiftScheduleStatus: true,
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
