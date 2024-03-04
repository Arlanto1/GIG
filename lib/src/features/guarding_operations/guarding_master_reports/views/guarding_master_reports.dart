import 'package:db_atom/index.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

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
      context
          .read<GuardingMasterReportBloc>()
          .add(FetchReportList(startPos: pageNumber, maxPos: 20));
    }
  }

  void _onRefresh() async {
    context.read<GuardingMasterReportBloc>().add(
          const RefreshListGMR(),
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
    return Scaffold(
        backgroundColor: AppColors.cardBgColor,
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
          if (state.status == FormStatus.initial) {
            return const BaseLoader();
          }
          if (state.list.isEmptyOrNull) {
            return const NoRecordFoundWidget();
          }
          return Container(
            margin: allMargin16,
            decoration: const ShapeDecoration(
                color: AppColors.backgroundWhitecolor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                )),
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
                  return index >= state.list.length
                      ? const BaseLoader()
                      : BaseListTileItem(
                          id: state.list[index].id,
                          vendor: state.list[index].vendor,
                          region: state.list[index].region,
                          guardCount: state.list[index].guardCount,
                          pvcExpired: state.list[index].pvcExpired,
                          msgbExempted: state.list[index].msgbExempted,
                          locationStr: state.list[index].location,
                          onTap: (selectedIndex) {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return BasePopUpItems(
                                  id: state.list[selectedIndex].id.toString(),
                                  vendor: state.list[selectedIndex].vendor,
                                  region: state.list[index].region,
                                  guardCount: state.list[index].guardCount,
                                  pvcExpired: state.list[index].pvcExpired,
                                  msgbExempted: state.list[index].msgbExempted,
                                  mcNotSubmitted:
                                      state.list[selectedIndex].mcNotSubmitted,
                                  mcExpired:
                                      state.list[selectedIndex].mcExpired,
                                  systemAccess:
                                      state.list[selectedIndex].systemAccess,
                                  trainingCertPending: state
                                      .list[selectedIndex].trainingCertPending,
                                );
                              },
                            );
                          },
                          showEditButton: false,
                          onViewTap: (selectedIndex) {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return BasePopUpItems(
                                  id: state.list[selectedIndex].id.toString(),
                                  vendor: state.list[selectedIndex].vendor,
                                  region: state.list[selectedIndex].region,
                                  guardCount:
                                      state.list[selectedIndex].guardCount,
                                  mcNotSubmitted:
                                      state.list[selectedIndex].mcNotSubmitted,
                                  mcExpired:
                                      state.list[selectedIndex].mcExpired,
                                  photoNotSubmitted: state
                                      .list[selectedIndex].photoNotSubmitted,
                                  deploymentOrderPending: state
                                      .list[selectedIndex]
                                      .deploymentOrderPending,
                                  pvcExpired:
                                      state.list[selectedIndex].pvcExpired,
                                  msgbExempted:
                                      state.list[selectedIndex].msgbExempted,
                                  msgbNotExempted:
                                      state.list[selectedIndex].msgbNotExempted,
                                  msgbFormBNotSubmitted: state
                                      .list[selectedIndex]
                                      .msgbFormBNotSubmitted,
                                  msgbFormBUnderProcess: state
                                      .list[selectedIndex]
                                      .msgbFormBUnderProcess,
                                  systemAccess:
                                      state.list[selectedIndex].systemAccess,
                                  trainingCertPending: state
                                      .list[selectedIndex].trainingCertPending,
                                  precPending:
                                      state.list[selectedIndex].precPending,
                                  precDoseCount:
                                      state.list[selectedIndex].precDoseCount,
                                  ertCertified:
                                      state.list[selectedIndex].ertCertified,
                                  ertPending:
                                      state.list[selectedIndex].ertPending,
                                  esicPending:
                                      state.list[selectedIndex].esicPending,
                                  uanNoPending:
                                      state.list[selectedIndex].uanNoPending,
                                  firstAidCertified: state
                                      .list[selectedIndex].firstAidCertified,
                                  firstAidNotCertified: state
                                      .list[selectedIndex].firstAidNotCertified,
                                );
                              },
                            );
                          },
                          index: index,
                        );
                },
              ),
            ),
          );
        }));
  }
}
