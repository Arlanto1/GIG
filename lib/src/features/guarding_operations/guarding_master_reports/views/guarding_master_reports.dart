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
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
        backgroundColor: AppColors.lavender,
        // floatingActionButton: Flutterfloatingbutton(
        //   backgroundColor: AppColors.navigationSkybluecolor,
        //   foregroundColor: AppColors.backgroundWhitecolor,
        //   onPressed: () => {
        //     Navigator.pushNamed(context, guardingMasterDataDetailsRoute,
        //         arguments: {"title": Constants.createGuardingMasterData}),
        //   },
        // ),

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
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const ShapeDecoration(
                color: AppColors.lavender,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                )),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 10,
                ),
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
                    state.status != FormStatus.loading &&
                    state.status != FormStatus.initial) ...[
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
                        if (index < state.list.length) {
                          return index >= state.list.length
                              ? null : Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF6474C6),
                                    Color(0xFF6474C6)
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
                                                Colors.white
                                                    .withValues(alpha: 0.2),
                                                Colors.transparent,
                                                Colors.white
                                                    .withValues(alpha: 0.2),
                                                // Color(0xFF6474C6).withOpacity(0.14)
                                              ],
                                              stops: [0.02, 0.35, 1],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(27),
                                            border: Border.all(
                                              color: Colors.white
                                                  .withValues(alpha: 0.80),
                                              width: 0.8,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF6474C6)
                                                    .withValues(alpha: 0.09),
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
            ),
          );
        }));
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
