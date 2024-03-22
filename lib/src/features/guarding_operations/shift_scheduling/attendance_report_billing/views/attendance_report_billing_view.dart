import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../../../index.dart';
import '../bloc/attendance_report_billing_bloc.dart';

class AttendanceReportBillingView extends StatefulWidget {
  const AttendanceReportBillingView({
    super.key,
  });

  @override
  State<AttendanceReportBillingView> createState() =>
      _AttendanceReportBillingViewState();
}

class _AttendanceReportBillingViewState
    extends State<AttendanceReportBillingView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<AttendanceReportBillingBloc>().add(
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
      context
          .read<AttendanceReportBillingBloc>()
          .add(FetchAttendanceReportBillingList(
            startPos: pageNumber,
            maxPos: 20,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  void _onRefresh() async {
    context.read<AttendanceReportBillingBloc>().add(
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
          title: Constants.attendanceReportBilling,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'exportKmiExcel',
          pdfAPIName: 'exportKmiPDF',
        ),
        body: BlocBuilder<AttendanceReportBillingBloc,
            AttendanceReportBillingState>(builder: (context, state) {
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
                if (state.status == FormStatus.initial) ...[
                  CommonWidgets.verticalSpacerWidget(height * 0.01),
                  const BaseLoader(),
                  CommonWidgets.verticalSpacerWidget(height * 0.01),
                ],
                // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                // Text('state.status=====${state.status}'),
                if (state.items.isEmptyOrNull &&
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
                            ? state.items.length
                            : state.items.length + 1,
                        itemBuilder: (context, index) {
                          List<Label> labels = [];
                          if (index < state.items.length) {
                            labels.add(Label(
                                key:
                                    // state.labels?.locale.locationRegion ??
                                    //  state.labels?.defaultLocale.locationRegion ??
                                    'Region',
                                value:
                                    state.items[index].locationRegion?.name ??
                                        ''));
                            labels.add(Label(
                                key:
                                    // state.labels?.locale.location ??
                                    //     state.labels?.defaultLocale.location ??
                                    'Location ',
                                value:
                                    state.items[index].location?.name ?? ''));
                            labels.add(Label(
                                key: 'Date',
                                value: state.items[index].inputDate != null
                                    ? Utils.timestamptoDateConversion(
                                        int.parse(
                                            state.items[index].inputDate ??
                                                '0'),
                                        Constants.dateFormat)
                                    : ''));
                            labels.add(Label(
                                key: 'Year',
                                value: state.items[index].year.toString()));
                            return index >= state.items.length
                                ? const BaseLoader()
                                : BaseListTileItem(
                                    id: state.items[index].id,
                                    labels: labels,
                                    // status: state.items[index].status,
                                    isMasterGuard: false,
                                    isAttendanceStatus: true,
                                    isEventProtectionStatus: false,
                                    onTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.items[selectedIndex].id
                                                .toString(),
                                            labels: labels,
                                            // dutyType: state.items[selectedIndex].dutyType,
                                            isAttendance: true,
                                            isMasterGuard: false,
                                            isEventProtectionStatus: false,
                                            // status: state.items[selectedIndex].status,
                                          );
                                        },
                                      );
                                    },
                                    onEditTap: (selectedIndex) {
                                      getById(id: state.items[index].id ?? 0);
                                    },
                                    showEditButton: true,
                                    onViewTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.items[selectedIndex].id
                                                .toString(),
                                            labels: labels,
                                            // dutyType: state.items[selectedIndex].dutyType,
                                            // status: state.items[selectedIndex].status,
                                            isMaterGuard: false,
                                            isMasterGuard: false,
                                            isAttendance: true,
                                            isEventProtectionStatus: false,
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
                        }),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  getById({
    required int id,
  }) async {
    Navigator.pushNamed(
      context,
      attendanceDetailsRoute,
      arguments: {
        ConstantsArgument.id: id.toString(),
        ConstantsArgument.title: Constants.editAttendance
      },
    );
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<AttendanceReportBillingBloc>(context).add(
      FetchAttendanceReportBillingList(
          startPos: 0, maxPos: 20, newSearch: true, filters: filters),
    );
  }

  void applyFilters(
    Filters model,
  ) {
    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));

    BlocProvider.of<AttendanceReportBillingBloc>(context).add(
      FetchAttendanceReportBillingList(
          startPos: 0, maxPos: 20, newSearch: true, filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
