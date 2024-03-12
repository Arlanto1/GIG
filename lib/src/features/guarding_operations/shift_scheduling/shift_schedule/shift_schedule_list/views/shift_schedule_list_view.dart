import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_list/bloc/shift_schedule_list_bloc.dart';

class ShiftScheduleListView extends StatefulWidget {
  const ShiftScheduleListView({
    super.key,
  });

  @override
  State<ShiftScheduleListView> createState() => _ShiftScheduleListViewState();
}

class _ShiftScheduleListViewState extends State<ShiftScheduleListView> {
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
          .read<ShiftScheduleListBloc>()
          .add(FetchShiftScheduleList(startPos: pageNumber, maxPos: 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      floatingActionButton: Flutterfloatingbutton(
        backgroundColor: AppColors.navigationSkybluecolor,
        foregroundColor: AppColors.backgroundWhitecolor,
        onPressed: () => {
          Navigator.pushNamed(context, shiftScheduleDetailsRoute, arguments: {
            ConstantsArgument.title: Constants.createShiftSchedule,
          }),
        },
      ),
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: Constants.shiftSchedule,
        showPopUp: true,
        showSaveButton: false,
        showSubmitButton: false,
        showDisLikeButton: false,
        showLikeButton: false,
        excelAPIName: 'exportShiftSchdExcel',
        pdfAPIName: 'exportShiftSchdPDF',
      ),
      body: BlocBuilder<ShiftScheduleListBloc, ShiftScheduleListState>(
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
                      key: state.labels?.locale.createdDate ??
                          state.labels?.defaultLocale.createdDate ??
                          'Date of Creation',
                      value: state.items[index].inputDate != null
                          ? Utils.timestamptoDateConversion(
                              int.parse(state.items[index].inputDate ?? '0'),
                              Constants.dateFormat)
                          : ''));
                  labels.add(Label(
                      key: state.labels?.locale.createdBy ??
                          state.labels?.defaultLocale.createdBy ??
                          'Created By',
                      value: state.items[index].entrySecurity?.name ?? ''));
                  labels.add(Label(
                      key: state.labels?.locale.locationRegion ??
                          state.labels?.defaultLocale.locationRegion ??
                          'Region',
                      value: state.items[index].locationRegion?.name ?? ''));
                  labels.add(Label(
                      key: state.labels?.locale.location ??
                          state.labels?.defaultLocale.location ??
                          'Location',
                      value: state.items[index].location?.name ?? ''));

                  return index >= state.items.length
                      ? const BaseLoader()
                      : BaseListTileItem(
                          id: state.items[index].id,
                          status: state.items[index].status,
                          isMasterGuard: false,
                          isShiftScheduleStatus: true,
                          isEventProtectionStatus: false,
                          labels: labels,
                          onTap: (selectedIndex) {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return BasePopUpItems(
                                  id: state.items[selectedIndex].id.toString(),
                                  labels: labels,
                                  slNo: state.items[selectedIndex].slNo,
                                  status: state.items[selectedIndex].status,
                                  isMasterGuard: false,
                                  isEventProtectionStatus: false,
                                  isShiftScheduleStatus: true,
                                );
                              },
                            );
                          },
                          onEditTap: (selectedIndex) {
                            getById(id: state.items[index].id ?? 0);
                          },
                          onViewTap: (selectedIndex) {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return BasePopUpItems(
                                  id: state.items[selectedIndex].id.toString(),
                                  labels: labels,
                                  slNo: state.items[selectedIndex].slNo,
                                  status: state.items[selectedIndex].status,
                                  isMasterGuard: false,
                                  isEventProtectionStatus: false,
                                  isShiftScheduleStatus: true,
                                );
                              },
                            );
                          },
                          index: index,
                        );
                }
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

  // getById(int id) async {
  //   showLoadingDialog(context);
  //
  //   ShiftScheduleModel shiftScheduleModel =
  //       await ShiftScheduleServices().getById(id);
  //
  //   editDataLoading(shiftScheduleModel);
  // }
  //
  // void editDataLoading(ShiftScheduleModel? shiftScheduleModel) {
  //   dismissLoadingDialog(context);
  //   if (shiftScheduleModel != null) {
  //     Navigator.pushNamed(context, dutyPostMasterDetailsRoute, arguments: {
  //       "shiftScheduleModel": shiftScheduleModel,
  //       "title": Constants.editShiftSchedule
  //     });
  //   }
  // }

  getById({
    required int id,
  }) async {
    Navigator.pushNamed(
      context,
      shiftScheduleDetailsRoute,
      arguments: {
        ConstantsArgument.id: id.toString(),
        ConstantsArgument.title: Constants.editShiftSchedule
      },
    );
  }
}
