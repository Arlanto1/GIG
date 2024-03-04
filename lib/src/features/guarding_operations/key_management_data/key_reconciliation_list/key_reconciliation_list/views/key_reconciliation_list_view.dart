import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_reconciliation_list/key_reconciliation_list/bloc/key_reconciliation_list_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class KeyReconciliationListView extends StatefulWidget {
  const KeyReconciliationListView({
    super.key,
  });

  @override
  State<KeyReconciliationListView> createState() =>
      _KeyLossDestructionListViewState();
}

class _KeyLossDestructionListViewState
    extends State<KeyReconciliationListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
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
      context.read<KeyReconciliationListBloc>().add(FetchKeyReconciliationList(
          startPos: pageNumber,
          maxPos: 20,
          newSearch: true,
          filters: BaseFilterModel()));
    }
  }

  void _onRefresh() async {
    context.read<KeyReconciliationListBloc>().add(
          const RefreshList(),
        );
    // await Future.delayed(const Duration(milliseconds: 2000));
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
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.keyReconciliationList,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'exportGMDataExcel',
          pdfAPIName: 'exportGMDataPDF',
        ),
        body:
            BlocBuilder<KeyReconciliationListBloc, KeyReconciliationListState>(
                builder: (context, state) {
          // if (state.status == FormStatus.initial) {
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
                    header: const WaterDropHeader(
                      waterDropColor: AppColors.navigationSkybluecolor,
                    ),
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
                          //labels.add(Label(
                          // key: state.labels?.locale.locationRegion ??
                          //  state.labels?.defaultLocale.locationRegion ??
                          //'Region',
                          // value: state.list[index].locationRegion?.name ?? ''));
                          // labels.add(Label(
                          //key: state.labels?.locale.location ??
                          //     state.labels?.defaultLocale.location ??'Building Location ',
                          // value: state.list[index].location?.name ?? ''));
                        }
                        return index >= state.list.length
                            ? const BaseLoader()
                            : BaseListTileItem(
                                id: state.list[index].id,
                                labels: labels,
                                status: state.list[index].status,
                                isMasterGuard: true,
                                guardRank: state.list[index].guardRank,
                                onTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return BasePopUpItems(
                                        id: state.list[selectedIndex].id
                                            .toString(),
                                        slNo: state.list[selectedIndex].slNo,
                                        guardRank:
                                            state.list[selectedIndex].guardRank,
                                        gender:
                                            state.list[selectedIndex].gender,
                                        dutyType:
                                            state.list[selectedIndex].dutyType,
                                        maritalStatus: state
                                            .list[selectedIndex].maritalStatus,
                                        labels: labels,
                                        isMaterGuard: true,
                                        //isEventProtectionStatus: false,
                                        status:
                                            state.list[selectedIndex].status,
                                      );
                                    },
                                  );
                                },
                                // onEditTap: (selectedIndex) {
                                //   getById(state.list[index].id ?? 0);
                                // },
                                showEditButton: false,
                                onViewTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return BasePopUpItems(
                                        id: state.list[selectedIndex].id
                                            .toString(),
                                        slNo: state.list[selectedIndex].slNo,
                                        guardRank:
                                            state.list[selectedIndex].guardRank,
                                        gender:
                                            state.list[selectedIndex].gender,
                                        dutyType:
                                            state.list[selectedIndex].dutyType,
                                        maritalStatus: state
                                            .list[selectedIndex].maritalStatus,
                                        labels: labels,
                                        status:
                                            state.list[selectedIndex].status,
                                        isMaterGuard: true,
                                        // isEventProtectionStatus: false,
                                      );
                                    },
                                  );
                                },
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<KeyReconciliationListBloc>(context).add(
      FetchKeyReconciliationList(
          startPos: 0, maxPos: 20, newSearch: true, filters: filters),
    );
  }

  void applyFilters(
    Filters model,
  ) {
    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));

    BlocProvider.of<KeyReconciliationListBloc>(context).add(
      FetchKeyReconciliationList(
          startPos: 0, maxPos: 20, newSearch: true, filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
