import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/duty_post_name_master_list/bloc/duty_post_name_master_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/services/duty_post_name_master_services.dart';

class DutyPostNameMasterListView extends StatefulWidget {
  const DutyPostNameMasterListView({
    super.key,
  });

  @override
  State<DutyPostNameMasterListView> createState() =>
      _DutyPostNameMasterListViewState();
}

class _DutyPostNameMasterListViewState
    extends State<DutyPostNameMasterListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<DutyPostNameMasterListBloc>().add(
          const InitializeValue(),
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
      context
          .read<DutyPostNameMasterListBloc>()
          .add(FetchDutyPostNameMasterList(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<DutyPostNameMasterListBloc>().add(
          const RefreshDPNList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<DutyPostNameMasterListBloc,
        DutyPostNameMasterListState>(
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
                              context, dutyPostNameMasterDetailsRoute,
                              arguments: {
                                "title": Constants.createDutyPostNameMaster,
                                "dutyPostNameMasterModel":
                                    DutyPostNameMasterModel(),
                              }),
                        },
                      )
                    : const SizedBox(),
            appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: Constants.dutyPostNameMaster,
              showPopUp: true,
              showSaveButton: false,
              showSubmitButton: false,
              showDisLikeButton: false,
              showLikeButton: false,
              excelAPIName: 'exportDpnExcel',
              pdfAPIName: 'exportDpnPDF',
            ),
            body: BlocBuilder<DutyPostNameMasterListBloc,
                DutyPostNameMasterListState>(builder: (context, state) {
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
                          itemCount: state.hasReachedMax
                              ? state.list.length
                              : state.list.length + 1,
                          itemBuilder: (context, index) {
                            List<Label> labels = [];
                            if (index < state.list.length) {
                              labels.add(Label(
                                  key: state.labels?.locale.locationRegion ??
                                      state.labels?.defaultLocale
                                          .locationRegion ??
                                      Constants.region,
                                  value:
                                      state.list[index].locationRegion?.name ??
                                          ''));
                              labels.add(Label(
                                  key: state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.location,
                                  value:
                                      state.list[index].location?.name ?? ''));
                              labels.add(Label(
                                  key: state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.createdby,
                                  value:
                                      '${state.list[index].entrySecurity?.firstName ?? ''} ${state.list[index].entrySecurity?.lastName ?? ''}'));
                            }
                            return index >= state.list.length
                                ? null
                                : BaseListTileItem(
                                    id: state.list[index].id,
                                    labels: labels,
                                    status: state.list[index].status,
                                    isDutyPostNameMasterStatus: true,
                                    isMasterGuard: false,
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
                                            isEventProtectionStatus: false,
                                            isDutyPostNameMasterStatus: true,
                                            status: state
                                                .list[selectedIndex].status,
                                          );
                                        },
                                      );
                                    },
                                    showNonEditButton:
                                        state.list[index].status ==
                                            ConstantsIntValue.cancelledStatus,
                                    showEditButton:
                                        state.list[index].status !=
                                            ConstantsIntValue.cancelledStatus,
                                    onEditTap: (selectedIndex) {
                                      getById(
                                          state.extraProperties
                                                  ?.hasWritePermission ??
                                              false,
                                          state.list[index].id ?? 0);
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
                                            labels: labels,
                                            status: state
                                                .list[selectedIndex].status,
                                            isEventProtectionStatus: false,
                                            isDutyPostNameMasterStatus: true,
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

    DutyPostNameMasterModel dutyPostNameMasterModel =
        await DutyPostNameMasterServices().getById(id);

    editDataLoading(dutyPostNameMasterModel, hasWritePermission);
  }

  void editDataLoading(DutyPostNameMasterModel? dutyPostNameMasterModel,
      bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (dutyPostNameMasterModel != null) {
      Navigator.pushNamed(context, dutyPostNameMasterDetailsRoute, arguments: {
        "dutyPostNameMasterModel": dutyPostNameMasterModel,
        "title": Constants.editDutyPostNameMaster,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      });
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<DutyPostNameMasterListBloc>(context).add(
      FetchDutyPostNameMasterList(
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

    BlocProvider.of<DutyPostNameMasterListBloc>(context).add(
      FetchDutyPostNameMasterList(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
