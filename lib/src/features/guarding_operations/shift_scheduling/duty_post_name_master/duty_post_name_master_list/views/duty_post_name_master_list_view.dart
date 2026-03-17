import 'dart:ui';

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
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<DutyPostNameMasterListBloc,
        DutyPostNameMasterListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            extendBody: true,
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
                  Navigator.pushNamed(context, dutyPostNameMasterDetailsRoute,
                      arguments: {
                        "title": Constants.createDutyPostNameMaster,
                        "dutyPostNameMasterModel": DutyPostNameMasterModel(),
                      });
                }),
            appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: Constants.dutyPostNameMasterListTitle,
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
              if (state.list.isEmptyOrNull) {
                return const NoRecordFoundWidget();
              }
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
                        padding: const EdgeInsets.only(bottom: 100),
                        // padding: EdgeInsets.zero,
                        itemCount: state.hasReachedMax
                            ? state.list.length
                            : state.list.length + 1,
                        itemBuilder: (context, index) {
                          List<Label> labels = [];
                          if (index < state.list.length) {
                            labels.add(Label(
                                key: state.labels?.locale.locationRegion ??
                                    state
                                        .labels?.defaultLocale.locationRegion ??
                                    Constants.region,
                                value: state.list[index].locationRegion?.name ??
                                    ''));
                            labels.add(Label(
                                key: state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                value: state.list[index].location?.name ?? ''));
                            labels.add(Label(
                                key: state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                value:
                                    '${state.list[index].entrySecurity?.firstName ?? ''} ${state.list[index].entrySecurity?.lastName ?? ''}'));
                          }
                          return index >= state.list.length
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
                                      borderRadius: BorderRadius.circular(18),
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
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(27),
                                                border: Border.all(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.6),
                                                  width: 0.7,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white
                                                        .withValues(alpha: 0.0),
                                                    blurRadius: 12,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: BaseListTileItem(
                                                id: state.list[index].id,
                                                labels: labels,
                                                status:
                                                    state.list[index].status,
                                                isDutyPostNameMasterStatus:
                                                    true,
                                                isMasterGuard: false,
                                                isEventProtectionStatus: false,
                                                onTap: (selectedIndex) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                        dialogContext) {
                                                      return BasePopUpItems(
                                                        id: state
                                                            .list[selectedIndex]
                                                            .id
                                                            .toString(),
                                                        slNo: state
                                                            .list[selectedIndex]
                                                            .slNo,
                                                        labels: labels,
                                                        isEventProtectionStatus:
                                                            false,
                                                        isDutyPostNameMasterStatus:
                                                            true,
                                                        status: state
                                                            .list[selectedIndex]
                                                            .status,
                                                      );
                                                    },
                                                  );
                                                },
                                                showEditButton:
                                                    state.list[index].status !=
                                                        ConstantsIntValue
                                                            .cancelledStatus,
                                                onEditTap: (selectedIndex) {
                                                  getById(
                                                      state.extraProperties
                                                              ?.hasWritePermission ??
                                                          false,
                                                      state.list[index].id ??
                                                          0);
                                                },
                                                onViewTap: (selectedIndex) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                        dialogContext) {
                                                      return BasePopUpItems(
                                                        id: state
                                                            .list[selectedIndex]
                                                            .id
                                                            .toString(),
                                                        slNo: state
                                                            .list[selectedIndex]
                                                            .slNo,
                                                        labels: labels,
                                                        status: state
                                                            .list[selectedIndex]
                                                            .status,
                                                        isEventProtectionStatus:
                                                            false,
                                                        isDutyPostNameMasterStatus:
                                                            true,
                                                      );
                                                    },
                                                  );
                                                },
                                                index: index,
                                              )))));
                        },
                      ),
                    ),
                  ),
                ],
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
