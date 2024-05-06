import 'package:db_atom/index.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../services/sla_violation_penalty_services.dart';
import '../bloc/sla_violation_penalty_list_bloc.dart';

class SLAViolationPenaltyListView extends StatefulWidget {
  const SLAViolationPenaltyListView({
    super.key,
  });

  @override
  State<SLAViolationPenaltyListView> createState() =>
      _ContactDetailsListViewState();
}

class _ContactDetailsListViewState extends State<SLAViolationPenaltyListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<SLAViolationPenaltyListBloc>().add(
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
      context.read<SLAViolationPenaltyListBloc>().add(FetchData(
          startPos: pageNumber,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: BaseFilterModel()));
    }
  }

  void _onRefresh() async {
    context.read<SLAViolationPenaltyListBloc>().add(
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
    return BlocConsumer<SLAViolationPenaltyListBloc,
        SLAViolationPenaltyListState>(
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
                              context, slaViolationPenaltyDetailsRoute,
                              arguments: {
                                "title": Constants.slaViolationPenalty,
                              })
                        },
                      )
                    : const SizedBox(),
            appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: Constants.slaViolationPenalty,
              showPopUp: true,
              showSaveButton: false,
              showSubmitButton: false,
              showDisLikeButton: false,
              showLikeButton: false,
              excelAPIName: 'exportSvpExcel',
              pdfAPIName: 'exportSvpPDF',
            ),
            body: BlocBuilder<SLAViolationPenaltyListBloc,
                SLAViolationPenaltyListState>(builder: (context, state) {
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
                    // if (state.status == FormStatus.loading) ...[
                    //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                    //   const BaseLoader(),
                    //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                    // ],
                    // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                    // Text('state.status=====${state.status}'),
                    if (state.items.isEmptyOrNull &&
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
                                  value:
                                      state.items[index].locationRegion?.name ??
                                          ''));
                              labels.add(Label(
                                  key: state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      'Location',
                                  value:
                                      state.items[index].location?.name ?? ''));
                              labels.add(Label(
                                  key: state.labels?.locale.slNo ??
                                      state.labels?.defaultLocale.slNo ??
                                      'SL No',
                                  value: state.items[index].slNo ?? ''));
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
                            }
                            return index >= state.items.length
                                ? const BaseLoader()
                                : BaseListTileItem(
                                    id: state.items[index].id,
                                    status: state.items[index].status,
                                    labels: labels,
                                    isEventProtectionStatus: false,
                                    isSLAViolationStatus: true,
                                    onTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.items[selectedIndex].id
                                                .toString(),
                                            status: state
                                                .items[selectedIndex].status,
                                            isSLAViolationStatus: true,
                                            isEventProtectionStatus: false,
                                            isMasterGuard: false,
                                            labels: labels,
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
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.items[selectedIndex].id
                                                .toString(),
                                            status: state
                                                .items[selectedIndex].status,
                                            isSLAViolationStatus: true,
                                            isEventProtectionStatus: false,
                                            isMasterGuard: false,
                                            labels: labels,
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

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    SLAViolationPenaltyModel model =
        await SLAViolationPenaltyServices().getGvpById(id);

    editDataLoading(model, hasWritePermission);
  }

  void editDataLoading(
      SLAViolationPenaltyModel? model, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        slaViolationPenaltyDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.slaViolationPenalty,
          ConstantsArgument.extraProperties:
              ExtraProperties(hasWritePermission: hasWritePermission),
        },
      );
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<SLAViolationPenaltyListBloc>(context).add(
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

    BlocProvider.of<SLAViolationPenaltyListBloc>(context).add(
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
