import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';

class GuardingMasterReport extends StatefulWidget {
  const GuardingMasterReport({
    super.key,
  });

  @override
  State<GuardingMasterReport> createState() => _GuardingMasterReportState();
}

class _GuardingMasterReportState extends State<GuardingMasterReport> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<GuardingMasterReportBloc>().add(
          const InitializeValuesGMR(),
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
      context.read<GuardingMasterReportBloc>().add(FetchReportList(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<GuardingMasterReportBloc>().add(
          const RefreshListGMR(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
        backgroundColor:Colors.transparent,
        extendBody: true,
        extendBodyBehindAppBar: true,
        // floatingActionButton: Flutterfloatingbutton(
        //   backgroundColor: AppColors.navigationSkybluecolor,
        //   foregroundColor: AppColors.backgroundWhitecolor,
        //   onPressed: () => {
        //     Navigator.pushNamed(context, guardingMasterDataDetailsRoute,
        //         arguments: {"title": Constants.createGuardingMasterData}),
        //   },
        // ),

        bottomNavigationBar: CustomBottomNavigationBar(
          hasAddPermission: false,
          scaffoldKey: scaffoldKey,
          context: context,
          // displayMenu: state.displayMenu,
          list: true, // 🔥 only "+" button mode
          onAddPressed: () {
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.guardingMasterReportTitle,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'gmReportExcel',
          pdfAPIName: 'gmReportPDF',
        ),
        body: BlocBuilder<GuardingMasterReportBloc, GuardingMasterReportState>(
            builder: (context, state) {
          // if (state.status == FormStatus.initial) {
          //   return const BaseLoader();
          // }
          // if (state.list.isEmptyOrNull) {
          //   return const NoRecordFoundWidget();
          // }
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
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),

                  // 🔹 Search Bar - positioned safely at the top
                  Positioned(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight + -40, // below AppBar
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
                    top: MediaQuery.of(context).padding.top + kToolbarHeight + 10, // search bar height ~64+padding
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
                      padding: EdgeInsets.zero,
                      itemCount: state.hasReachedMax
                          ? state.list.length
                          : state.list.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.list.length) {
                          return index >= state.list.length
                              ? null : Container(
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
                                          decoration:
                                          BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.white.withValues(alpha: 0.09),
                                                Colors.transparent,
                                                Colors.white.withValues(alpha: 0.09),
                                                // Color(0xFF6474C6).withOpacity(0.14)
                                              ],
                                              stops: [0.02, 0.35, 1],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius: BorderRadius.circular(27),
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
                                          // index >= state.list.length
                                          //   ? const BaseLoader()

                                          child: BaseListTileItem(
                                            id: state.list[index].id,
                                            vendor: state.list[index].vendor,
                                            region: state.list[index].region,
                                            guardCount:
                                                state.list[index].guardCount,
                                            pvcExpired:
                                                state.list[index].pvcExpired,
                                            msgbExempted:
                                                state.list[index].msgbExempted,
                                            locationStr:
                                                state.list[index].location,
                                            onTap: (selectedIndex) {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                    dialogContext) {
                                                  return BasePopUpItems(
                                                    id: state
                                                        .list[selectedIndex].id
                                                        .toString(),
                                                    vendor: state
                                                        .list[selectedIndex]
                                                        .vendor,
                                                    region: state
                                                        .list[index].region,
                                                    guardCount: state
                                                        .list[index].guardCount,
                                                    pvcExpired: state
                                                        .list[index].pvcExpired,
                                                    msgbExempted: state
                                                        .list[index]
                                                        .msgbExempted,
                                                    mcNotSubmitted: state
                                                        .list[selectedIndex]
                                                        .mcNotSubmitted,
                                                    mcExpired: state
                                                        .list[selectedIndex]
                                                        .mcExpired,
                                                    systemAccess: state
                                                        .list[selectedIndex]
                                                        .systemAccess,
                                                    trainingCertPending: state
                                                        .list[selectedIndex]
                                                        .trainingCertPending,
                                                  );
                                                },
                                              );
                                            },
                                            showEditButton: false,
                                            onViewTap: (selectedIndex) {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                    dialogContext) {
                                                  return BasePopUpItems(
                                                    id: state
                                                        .list[selectedIndex].id
                                                        .toString(),
                                                    vendor: state
                                                        .list[selectedIndex]
                                                        .vendor,
                                                    region: state
                                                        .list[selectedIndex]
                                                        .region,
                                                    guardCount: state
                                                        .list[selectedIndex]
                                                        .guardCount,
                                                    mcNotSubmitted: state
                                                        .list[selectedIndex]
                                                        .mcNotSubmitted,
                                                    mcExpired: state
                                                        .list[selectedIndex]
                                                        .mcExpired,
                                                    photoNotSubmitted: state
                                                        .list[selectedIndex]
                                                        .photoNotSubmitted,
                                                    deploymentOrderPending: state
                                                        .list[selectedIndex]
                                                        .deploymentOrderPending,
                                                    pvcExpired: state
                                                        .list[selectedIndex]
                                                        .pvcExpired,
                                                    msgbExempted: state
                                                        .list[selectedIndex]
                                                        .msgbExempted,
                                                    msgbNotExempted: state
                                                        .list[selectedIndex]
                                                        .msgbNotExempted,
                                                    msgbFormBNotSubmitted: state
                                                        .list[selectedIndex]
                                                        .msgbFormBNotSubmitted,
                                                    msgbFormBUnderProcess: state
                                                        .list[selectedIndex]
                                                        .msgbFormBUnderProcess,
                                                    systemAccess: state
                                                        .list[selectedIndex]
                                                        .systemAccess,
                                                    trainingCertPending: state
                                                        .list[selectedIndex]
                                                        .trainingCertPending,
                                                    precPending: state
                                                        .list[selectedIndex]
                                                        .precPending,
                                                    precDoseCount: state
                                                        .list[selectedIndex]
                                                        .precDoseCount,
                                                    ertCertified: state
                                                        .list[selectedIndex]
                                                        .ertCertified,
                                                    ertPending: state
                                                        .list[selectedIndex]
                                                        .ertPending,
                                                    esicPending: state
                                                        .list[selectedIndex]
                                                        .esicPending,
                                                    uanNoPending: state
                                                        .list[selectedIndex]
                                                        .uanNoPending,
                                                    firstAidCertified: state
                                                        .list[selectedIndex]
                                                        .firstAidCertified,
                                                    firstAidNotCertified: state
                                                        .list[selectedIndex]
                                                        .firstAidNotCertified,
                                                  );
                                                },
                                              );
                                            },
                                            index: index,
                                          )))));
                        }
                        return const Center(
                          child: SizedBox(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
        },));
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<GuardingMasterReportBloc>(context).add(
      FetchReportList(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
  }

  void applyFilters(
    Filters model,
  ) {
    log('Applying Filters');

    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    log('id---filtersFun----${filters.filterCriteria!.filters!.id}---');

    BlocProvider.of<GuardingMasterReportBloc>(context).add(
      FetchReportList(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
