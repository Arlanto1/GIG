import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/key_management_issuance_list/bloc/key_management_issuance_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/services/key_management_issuance_services.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class KeyManagementIssuanceListView extends StatefulWidget {
  const KeyManagementIssuanceListView({
    super.key,
  });

  @override
  State<KeyManagementIssuanceListView> createState() =>
      _KeyManagementIssuanceListViewState();
}

class _KeyManagementIssuanceListViewState
    extends State<KeyManagementIssuanceListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<KeyManagementIssuanceListBloc>().add(
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
      context.read<KeyManagementIssuanceListBloc>().add(FetchKeyIssuanceList(
            startPos: pageNumber,
            maxPos: 20,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  void _onRefresh() async {
    context.read<KeyManagementIssuanceListBloc>().add(
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
            Navigator.pushNamed(context, keyManagementIssuanceDetailsRoute,
                arguments: {"title": Constants.createKeyManagementIssuance}),
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.keyManagementIssuance,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'exportKmiExcel',
          pdfAPIName: 'exportKmiPDF',
        ),
        body: BlocBuilder<KeyManagementIssuanceListBloc,
            KeyManagementIssuanceListState>(builder: (context, state) {
          log('state${state.status}');

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
                      refresh: BaseLoader(),
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
                              key: state.labels?.locale.createdBy ??
                                  state.labels?.defaultLocale.createdBy ??
                                  'Created By',
                              value:
                                  '${state.list[index].createdBy?.firstName ?? ''} ${state.list[index].createdBy?.lastName ?? ''}'));
                          labels.add(Label(
                              key: state.labels?.locale.location ??
                                  state.labels?.defaultLocale.location ??
                                  'Location ',
                              value: state.list[index].location?.name ?? ''));
                        }
                        return index >= state.list.length
                            ? const BaseLoader()
                            : BaseListTileItem(
                                id: state.list[index].id,
                                labels: labels,
                                status: state.list[index].status,
                                isEventProtectionStatus: false,
                                isKeyManagementIssuanceStatus: true,
                                onTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return BasePopUpItems(
                                        id: state.list[selectedIndex].id
                                            .toString(),
                                        slNo: state.list[selectedIndex].slNo,
                                        labels: labels,
                                        isMasterGuard: false,
                                        isEventProtectionStatus: false,
                                        isKeyManagementIssuanceStatus: true,
                                        status:
                                            state.list[selectedIndex].status,
                                        employeeType: state
                                            .list[selectedIndex].employeeType,
                                        dbSponsorCWRT2: state
                                            .list[selectedIndex].dbSponsorCwrT2,
                                        department: state
                                            .list[selectedIndex].department,
                                        handedOver: state
                                            .list[selectedIndex].handedOverTo,
                                        returnedByName: state
                                            .list[selectedIndex].returnedByName,
                                      );
                                    },
                                  );
                                },
                                onEditTap: (selectedIndex) {
                                  getById(state.list[index].id ?? 0);
                                },
                                showEditButton: true,
                                onViewTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return BasePopUpItems(
                                        id: state.list[selectedIndex].id
                                            .toString(),
                                        slNo: state.list[selectedIndex].slNo,
                                        labels: labels,
                                        status:
                                            state.list[selectedIndex].status,
                                        employeeType: state
                                            .list[selectedIndex].employeeType,
                                        dbSponsorCWRT2: state
                                            .list[selectedIndex].dbSponsorCwrT2,
                                        department: state
                                            .list[selectedIndex].department,
                                        handedOver: state
                                            .list[selectedIndex].handedOverTo,
                                        returnedByName: state
                                            .list[selectedIndex].returnedByName,
                                        isKeyManagementIssuanceStatus: true,
                                        isEventProtectionStatus: false,
                                        isMasterGuard: false,
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
  }

  getById(int id) async {
    showLoadingDialog(context);

    KeyManagementIssuanceModel keyManagementIssuanceModel =
        await KeyManagementIssuanceServices().getById(id);

    editDataLoading(keyManagementIssuanceModel);
  }

  void editDataLoading(KeyManagementIssuanceModel? model) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        keyManagementIssuanceDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.keyManagementIssuance,
        },
      );
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<KeyManagementIssuanceListBloc>(context).add(
      FetchKeyIssuanceList(
          startPos: 0, maxPos: 20, newSearch: true, filters: filters),
    );
  }

  void applyFilters(
    Filters model,
  ) {
    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));

    BlocProvider.of<KeyManagementIssuanceListBloc>(context).add(
      FetchKeyIssuanceList(
          startPos: 0, maxPos: 20, newSearch: true, filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
