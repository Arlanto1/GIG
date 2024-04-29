import 'package:db_atom/index.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../bloc/occurrences_bloc.dart';

class OccurrencesView extends StatefulWidget {
  const OccurrencesView({
    super.key,
  });

  @override
  State<OccurrencesView> createState() => _OccurrencesViewState();
}

class _OccurrencesViewState extends State<OccurrencesView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<OccurrencesBloc>().add(
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
      context.read<OccurrencesBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  void _onRefresh() async {
    context.read<OccurrencesBloc>().add(
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
    return BlocConsumer<OccurrencesBloc, OccurrencesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.cardBgColor,
            floatingActionButton:
                state.extraProperties?.hasWritePermission ?? false
                    ? Flutterfloatingbutton(
                        backgroundColor: AppColors.navigationSkybluecolor,
                        foregroundColor: AppColors.backgroundWhitecolor,
                        onPressed: () => {
                          Navigator.pushNamed(context, occurrenceDetailsRoute,
                              arguments: {
                                "title": Constants.createOccurrence,
                              }),
                        },
                      )
                    : const SizedBox(),
            appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: Constants.occurrenceList,
              showPopUp: true,
              showSaveButton: false,
              showSubmitButton: false,
              showDisLikeButton: false,
              showLikeButton: false,
              excelAPIName: 'exportOCCExcel',
              pdfAPIName: 'exportOCCPDF',
            ),
            body: BlocBuilder<OccurrencesBloc, OccurrencesState>(
                builder: (context, state) {
              // if (state.status == FormStatus.initial) {
              //   return const BaseLoader();
              // }
              // if (state.list.isEmpty) {
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
                    // if (state.status == FormStatus.loading) ...[
                    //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                    //   const BaseLoader(),
                    //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                    // ],
                    // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                    // Text('state.status=====${state.status}'),
                    if (state.list.isEmptyOrNull &&
                        state.status != FormStatus.initial &&
                        state.status != FormStatus.loading) ...[
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
                              ? state.list.length
                              : state.list.length + 1,
                          itemBuilder: (context, index) {
                            List<Label> labels = [];
                            if (index < state.list.length) {
                              labels.add(
                                Label(
                                    key: state.labels?.locale.inputDate ??
                                        state.labels?.defaultLocale.inputDate ??
                                        'Date of Creation',
                                    value: state.list[index].inputDate != null
                                        ? Utils.timestampToDateConversion(
                                            int.parse(
                                                state.list[index].inputDate ??
                                                    '0'),
                                            Constants.dateFormat)
                                        : ''),
                              );
                              labels.add(Label(
                                  key: state.labels?.locale.locationRegion ??
                                      state.labels?.defaultLocale
                                          .locationRegion ??
                                      'Region',
                                  value:
                                      state.list[index].locationRegion?.name ??
                                          ''));
                              labels.add(Label(
                                  key: state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      'Location',
                                  value:
                                      state.list[index].location?.name ?? ''));
                              labels.add(Label(
                                  key: state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      'Shift Handed Over By',
                                  value:
                                      '${state.list[index].entrySecurity?.firstName ?? ''} ${state.list[index].entrySecurity?.lastName ?? ''}'));
                            }
                            return index >= state.list.length
                                ? const BaseLoader()
                                : BaseListTileItem(
                                    id: state.list[index].id,
                                    labels: labels,
                                    status: state.list[index].status,
                                    isOccurrenceStatus: true,
                                    isEventProtectionStatus: false,
                                    onTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.list[selectedIndex].id
                                                .toString(),
                                            slNo:
                                                state.list[selectedIndex].slNo,
                                            status: state
                                                .list[selectedIndex].status,
                                            labels: labels,
                                            shiftBrfngAttnded: state
                                                .list[selectedIndex]
                                                .shiftBrfngAttnded,
                                            materialMovement: state
                                                .list[selectedIndex]
                                                .materialMovement,
                                            leoVisit: state
                                                .list[selectedIndex].leoVisit,
                                            handOverSecurity: state
                                                .list[selectedIndex]
                                                .handoverSecurity,
                                            isOccurrenceStatus: true,
                                            isMasterGuard: false,
                                            isEventProtectionStatus: false,
                                          );
                                        },
                                      );
                                    },
                                    onEditTap: (selectedIndex) {
                                      getId(
                                          state.extraProperties
                                                  ?.hasWritePermission ??
                                              false,
                                          id: state.list[index].id ?? 0);
                                    },
                                    onViewTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.list[selectedIndex].id
                                                .toString(),
                                            slNo:
                                                state.list[selectedIndex].slNo,
                                            status: state
                                                .list[selectedIndex].status,
                                            labels: labels,
                                            shiftBrfngAttnded: state
                                                .list[selectedIndex]
                                                .shiftBrfngAttnded,
                                            materialMovement: state
                                                .list[selectedIndex]
                                                .materialMovement,
                                            leoVisit: state
                                                .list[selectedIndex].leoVisit,
                                            handOverSecurity: state
                                                .list[selectedIndex]
                                                .handoverSecurity,
                                            isEventProtectionStatus: false,
                                            isMasterGuard: false,
                                            isOccurrenceStatus: true,
                                          );
                                        },
                                      );
                                    },
                                    index: index,
                                  );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
      },
    );
  }

  getId(
    bool hasWritePermission, {
    required int id,
  }) async {
    Navigator.pushNamed(
      context,
      occurrenceDetailsRoute,
      arguments: {
        'id': id.toString(),
        "title": Constants.editOccurrence,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      },
    );
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<OccurrencesBloc>(context).add(
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
    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));

    BlocProvider.of<OccurrencesBloc>(context).add(
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
