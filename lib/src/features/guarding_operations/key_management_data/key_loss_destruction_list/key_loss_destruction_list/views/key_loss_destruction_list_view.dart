import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/key_loss_destruction_list/bloc/key_loss_destruction_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/models/key_loss_destruction_list_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/services/key_loss_destruction_list_services.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class KeyLossDestructionListView extends StatefulWidget {
  const KeyLossDestructionListView({
    super.key,
  });

  @override
  State<KeyLossDestructionListView> createState() =>
      _KeyLossDestructionListViewState();
}

class _KeyLossDestructionListViewState
    extends State<KeyLossDestructionListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<KeyLossDestructionListBloc>().add(
          const InitializeValues(),
        );
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    refreshController.dispose();
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
      context.read<KeyLossDestructionListBloc>().add(FetchKeyLossList(
          startPos: pageNumber,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: BaseFilterModel()));
    }
  }

  void _onRefresh() async {
    context.read<KeyLossDestructionListBloc>().add(
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
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.keyLossDestructionList,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'exportKmKldExcel',
          pdfAPIName: 'exportKmKldPDF',
        ),
        body: BlocListener<KeyLossDestructionListBloc,
            KeyLossDestructionListState>(
          listener: (context, state) {
            Utils().formError(state, context);
            Utils().errorAndLogout(state, context);
          },
          child: BlocBuilder<KeyLossDestructionListBloc,
              KeyLossDestructionListState>(builder: (context, state) {
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
                  // if (state.status == FormStatus.loading) ...[
                  //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                  //   const BaseLoader(),
                  //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                  // ],
                  // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                  // Text('state.status=====${state.status}'),
                  // if (state.list.isEmptyOrNull &&
                  //     state.status != FormStatus.loading&& state.status != FormStatus.initial) ...[
                  //   CommonWidgets.verticalSpacerWidget(height * 0.1),
                  //   const NoRecordFoundWidget(),
                  // ],

                  UtilsCommon().showNoRecordWidget(
                      state: state, height: height, items: state.list),
                  Expanded(
                    child: SmartRefresher(
                      controller: refreshController,
                      enablePullDown: true,
                      physics: const AlwaysScrollableScrollPhysics(),
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
                                key:
                                    // state.labels?.locale.reg ??
                                    //  state.labels?.defaultLocale.locationRegion ??
                                    'Created Date',
                                value: state.list[index].createdDate != null
                                    ? Utils.timestampToDateConversion(
                                        int.parse(
                                            state.list[index].createdDate ??
                                                '0'),
                                        Constants.dateFormat)
                                    : ''));
                            labels.add(Label(
                                key: state.labels?.locale.createdBy ??
                                    state.labels?.defaultLocale.createdBy ??
                                    'Created By',
                                value:
                                    '${state.list[index].createdBy?.firstName ?? ''} ${state.list[index].createdBy?.lastName ?? ''}'));
                            return index >= state.list.length
                                ? const BaseLoader()
                                : BaseListTileItem(
                                    id: state.list[index].id,
                                    labels: labels,
                                    status: state.list[index].status,
                                    isKeyLossStatus: true,
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
                                            labels: labels,
                                            isKeyLossStatus: true,
                                            isEventProtectionStatus: false,
                                            isMasterGuard: false,
                                            status: state
                                                .list[selectedIndex].status,
                                            keyType: state
                                                .list[selectedIndex].keyType,
                                            type:
                                                state.list[selectedIndex].type,
                                            srh: state.list[selectedIndex].srh,
                                            securityManager: state
                                                .list[selectedIndex]
                                                .securityManager,
                                          );
                                        },
                                      );
                                    },
                                    onEditTap: (selectedIndex) {
                                      getById(
                                          state.extraProperties
                                                  ?.hasWritePermission ??
                                              false,
                                          state.list[index].id ?? 0);
                                    },
                                    showEditButton: true,
                                    onViewTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.list[selectedIndex].id
                                                .toString(),
                                            slNo:
                                                state.list[selectedIndex].slNo,
                                            labels: labels,
                                            status: state
                                                .list[selectedIndex].status,
                                            isKeyLossStatus: true,
                                            isEventProtectionStatus: false,
                                            isMasterGuard: false,
                                            keyType: state
                                                .list[selectedIndex].keyType,
                                            type:
                                                state.list[selectedIndex].type,
                                            srh: state.list[selectedIndex].srh,
                                            securityManager: state
                                                .list[selectedIndex]
                                                .securityManager,
                                          );
                                        },
                                      );
                                    },
                                    index: index,
                                  );
                          }

                          // Handle the case where index is out of bounds
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
          }),
        ));
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    KeyLossDestructionListModel keyLossDestructionListModel =
        await KeyLossDestructionListServices().getById(id);

    editDataLoading(keyLossDestructionListModel, hasWritePermission);
  }

  void editDataLoading(
    KeyLossDestructionListModel? keyLossDestructionListModel,
    bool hasWritePermission,
  ) {
    dismissLoadingDialog(context);
    if (keyLossDestructionListModel != null) {
      Navigator.pushNamed(context, keyLossDestructionListDetailsRoute,
          arguments: {
            "keyLossGi": keyLossDestructionListModel,
            "title": Constants.editKeyLossDestruction,
            ConstantsArgument.extraProperties:
                ExtraProperties(hasWritePermission: hasWritePermission),
          });
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<KeyLossDestructionListBloc>(context).add(
      FetchKeyLossList(
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

    BlocProvider.of<KeyLossDestructionListBloc>(context).add(
      FetchKeyLossList(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
