import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_reconciliation_list/key_reconciliation_list/bloc/key_reconciliation_list_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    context.read<KeyReconciliationListBloc>().add(
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
      context.read<KeyReconciliationListBloc>().add(FetchKeyReconciliationList(
          startPos: pageNumber,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: BaseFilterModel()));
    }
  }

  Future<void> _onRefresh() async {
    context.read<KeyReconciliationListBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.keyReconciliationList,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
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
                if (state.status == FormStatus.loading) ...[
                  CommonWidgets.verticalSpacerWidget(height * 0.01),
                  const BaseLoader(),
                  CommonWidgets.verticalSpacerWidget(height * 0.01),
                ],
                // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                // Text('state.status=====${state.status}'),
                if (state.list.isEmptyOrNull &&
                    state.status != FormStatus.loading) ...[
                  CommonWidgets.verticalSpacerWidget(height * 0.1),
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
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: state.hasReachedMax
                          ? state.list.length
                          : state.list.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.list.length) {
                          if (state.status == FormStatus.loading ||
                              state.status == FormStatus.initial) {
                            return const Center(child: BaseLoader());
                          }
                          return const SizedBox();
                        }
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
                                // showNonEditButton: true,
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

    BlocProvider.of<KeyReconciliationListBloc>(context).add(
      FetchKeyReconciliationList(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
