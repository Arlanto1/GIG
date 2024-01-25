import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance_report_billing/bloc/attendance_report_billing_bloc.dart';

class AttendanceReportBillingView extends StatefulWidget {
  const AttendanceReportBillingView({
    super.key,
  });

  @override
  State<AttendanceReportBillingView> createState() => _AttendanceReportBillingViewState();
}

class _AttendanceReportBillingViewState extends State<AttendanceReportBillingView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

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
          .read<AttendanceReportBillingBloc>()
          .add(FetchAttendanceList(startPos: pageNumber, maxPos: 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: Constants.attendanceReportBilling,
        showPopUp: true,
        showSaveButton: false,
        showSubmitButton: false,
        excelAPIName: 'exportGMDataExcel',
        pdfAPIName: 'exportGMDataPDF',
      ),
      body: BlocBuilder<AttendanceReportBillingBloc, AttendanceReportBillingState>(
        builder: (context, state) {
          if (state.status == FormStatus.initial) {
            return const BaseLoader();
          }
          if (state.items.isEmptyOrNull) {
            return const NoRecordFoundWidget();
          }
          // log('--labels-${state.labels?.locale.locationRegion}');
          return Container(
            margin: allMargin16,
            decoration: const ShapeDecoration(
                color: AppColors.backgroundWhitecolor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                )),
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
                      value: state.items[index].locationRegion?.name ?? ''));
                  labels.add(Label(
                      key:
                          // state.labels?.locale.location ??
                          //     state.labels?.defaultLocale.location ??
                          'Building Location ',
                      value: state.items[index].location?.name ?? ''));
                  labels.add(Label(
                      key:
                          // state.labels?.locale.locationRegion ??
                          //  state.labels?.defaultLocale.locationRegion ??
                          'SlNo',
                      value: state.items[index].slNo ?? ''));
                  return index >= state.items.length
                      ? const BaseLoader()
                      : BaseListTileItem(
                          id: state.items[index].id,
                          labels: labels,
                          status: state.items[index].status,
                          isMasterGuard: false,
                          isAttendanceStatus: true,
                          isEventProtectionStatus: false,
                          onTap: (selectedIndex) {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return BasePopUpItems(
                                  id: state.items[selectedIndex].id.toString(),
                                  labels: labels,
                                  dutyType: state.items[selectedIndex].dutyType,
                                  isAttendance: true,
                                  isMasterGuard: false,
                                  isEventProtectionStatus: false,
                                  status: state.items[selectedIndex].status,
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
                                  id: state.items[selectedIndex].id.toString(),
                                  labels: labels,
                                  dutyType: state.items[selectedIndex].dutyType,
                                  status: state.items[selectedIndex].status,
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
              },
            ),
          );
        },
      ),
    );
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
}
