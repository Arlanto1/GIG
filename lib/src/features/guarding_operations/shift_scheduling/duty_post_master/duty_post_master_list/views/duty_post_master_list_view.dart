import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/duty_post_master_list/bloc/duty_post_master_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/services/duty_post_master_services.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class DutyPostMasterListView extends StatefulWidget {
  const DutyPostMasterListView({
    super.key,
  });

  @override
  State<DutyPostMasterListView> createState() => _DutyPostMasterListViewState();
}

class _DutyPostMasterListViewState extends State<DutyPostMasterListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<DutyPostMasterListBloc>().add(
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
      context.read<DutyPostMasterListBloc>().add(FetchDutyPostMasterList(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  void _onRefresh() async {
    context.read<DutyPostMasterListBloc>().add(
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
    return BlocConsumer<DutyPostMasterListBloc, DutyPostMasterListState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: AppColors.cardBgColor,
              floatingActionButton: state.extraProperties?.hasWritePermission ??
                      false
                  ? Flutterfloatingbutton(
                      backgroundColor: AppColors.navigationSkyBlueColor,
                      foregroundColor: AppColors.backgroundWhiteColor,
                      onPressed: () => {
                        Navigator.pushNamed(context, dutyPostMasterDetailsRoute,
                            arguments: {
                              "title": Constants.createDutyPostMaster
                            }),
                      },
                    )
                  : const SizedBox(),
              appBar: BaseAppBar().buildAppHeader(
                context: context,
                title: Constants.dutyPostMaster,
                showPopUp: true,
                showSaveButton: false,
                showSubmitButton: false,
                showDisLikeButton: false,
                showLikeButton: false,
                excelAPIName: 'exportDpmExcel',
                pdfAPIName: 'exportDpmPDF',
              ),
              body:
                  BlocBuilder<DutyPostMasterListBloc, DutyPostMasterListState>(
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
                      if (state.list.isEmptyOrNull &&
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
                                ? state.list.length
                                : state.list.length + 1,
                            itemBuilder: (context, index) {
                              List<Label> labels = [];
                              if (index < state.list.length) {
                                labels.add(Label(
                                    key: state.labels?.locale.createdDate ??
                                        state.labels?.defaultLocale
                                            .createdDate ??
                                        'Created Date',
                                    value: state.list[index].createdDate != null
                                        ? Utils.timestampToDateConversion(
                                            int.parse(
                                                state.list[index].createdDate ??
                                                    '0'),
                                            Constants.dateFormat)
                                        : ''));
                                labels.add(Label(
                                    key: state.labels?.locale.locationRegion ??
                                        state.labels?.defaultLocale
                                            .locationRegion ??
                                        'Region',
                                    value:
                                        state.list[index].region?.name ?? ''));
                                labels.add(Label(
                                    key: state.labels?.locale.location ??
                                        state.labels?.defaultLocale.location ??
                                        'Location',
                                    value: state.list[index].location?.name ??
                                        ''));
                                labels.add(Label(
                                    key: state.labels?.locale.createdBy ??
                                        state.labels?.defaultLocale.createdBy ??
                                        'Created By',
                                    value:
                                        '${state.list[index].createdBy?.firstName ?? ''} ${state.list[index].createdBy?.lastName ?? ''}'));
                                labels.add(Label(
                                    key: state.labels?.locale.shiftA ??
                                        state.labels?.defaultLocale.shiftA ??
                                        'Shift A',
                                    value:
                                        state.list[index].shiftA.toString()));
                                labels.add(Label(
                                    key: state.labels?.locale.shiftB ??
                                        state.labels?.defaultLocale.shiftB ??
                                        'Shift B',
                                    value:
                                        state.list[index].shiftB.toString()));
                                labels.add(Label(
                                    key: state.labels?.locale.shiftC ??
                                        state.labels?.defaultLocale.shiftC ??
                                        'Shift C',
                                    value:
                                        state.list[index].shiftC.toString()));
                                labels.add(Label(
                                    key: state.labels?.locale.shiftG ??
                                        state.labels?.defaultLocale.shiftG ??
                                        'Shift G',
                                    value:
                                        state.list[index].shiftG.toString()));
                              }
                              return index >= state.list.length
                                  ? const BaseLoader()
                                  : BaseListTileItem(
                                      id: state.list[index].id,
                                      labels: labels,
                                      onTap: (selectedIndex) {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return BasePopUpItems(
                                              id: state.list[selectedIndex].id
                                                  .toString(),
                                              labels: labels,
                                              guardRank: state
                                                  .list[selectedIndex].rankId,
                                              isMasterGuard: true,
                                            );
                                          },
                                        );
                                      },
                                      onEditTap: (selectedIndex) {
                                        getById(
                                            state.extraProperties
                                                    ?.hasWritePermission ??
                                                false,state.list[index].id ?? 0);
                                },
                                showDutyPostEditButton: true,
                                showEditButton: false,
                                onViewTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return BasePopUpItems(
                                        id: state.list[selectedIndex].id
                                            .toString(),
                                        labels: labels,
                                        guardRank:state
                                                  .list[selectedIndex].rankId,
                                              isMasterGuard: true,
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
        });
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    DutyPostMasterModel dutyPostMasterModel =
        await DutyPostMasterServices().getById(id);

    editDataLoading(dutyPostMasterModel, hasWritePermission);
  }

  void editDataLoading(
      DutyPostMasterModel? dutyPostMasterModel, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (dutyPostMasterModel != null) {
      Navigator.pushNamed(context, dutyPostMasterDetailsRoute, arguments: {
        "dutyPostMasterModel": dutyPostMasterModel,
        "title": Constants.editDutyPostMaster,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      });
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<DutyPostMasterListBloc>(context).add(
      FetchDutyPostMasterList(
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

    BlocProvider.of<DutyPostMasterListBloc>(context).add(
      FetchDutyPostMasterList(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
