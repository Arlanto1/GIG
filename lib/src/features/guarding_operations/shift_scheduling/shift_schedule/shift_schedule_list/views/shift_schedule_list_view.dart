import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/models/shift_schedule_model.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
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
            Navigator.pushNamed(context, shiftScheduleDetailsRoute,
                arguments: {"title": Constants.createShiftSchedule}),
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.shiftSchedule,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          excelAPIName: 'exportGMDataExcel',
          pdfAPIName: 'exportGMDataPDF',
        ),
        body: BlocBuilder<ShiftScheduleListBloc, ShiftScheduleListState>(
            builder: (context, state) {
              if (state.status == FormStatus.initial) {
                return const BaseLoader();
              }
              if (state.list.isEmptyOrNull) {
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
                      ? state.list.length
                      : state.list.length + 1,
                  itemBuilder: (context, index) {
                    List<Label> labels = [];
                    if (index < state.list.length) {
                      //labels.add(Label(
                      // key: state.labels?.locale.locationRegion ??
                      //  state.labels?.defaultLocale.locationRegion ??
                      //'Region',
                      // value: state.list[index].locationRegion?.name ?? ''));
                      // labels.add(Label(
                      //key: state.labels?.locale.location ??
                      //     state.labels?.defaultLocale.location ??'Building Location ',
                      // value: state.list[index].location?.name ?? ''));
                    }
                    return index >= state.list.length
                        ? const BaseLoader()
                        : BaseListTileItem(
                      id: state.list[index].id,
                      labels: labels,
                      status: state.list[index].status,
                      isMasterGuard: true,
                      //guardRank: state.list[index].guardRank,
                      onTap: (selectedIndex) {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return BasePopUpItems(
                              id: state.list[selectedIndex].id.toString(),
                              slNo: state.list[selectedIndex].slNo,
                             // guardRank: state.list[selectedIndex].guardRank,
                              gender: state.list[selectedIndex].gender,
                              dutyType: state.list[selectedIndex].dutyType,
                              maritalStatus:
                              state.list[selectedIndex].maritalStatus,
                              labels: labels,
                              isMaterGuard: true,
                              //isEventProtectionStatus: false,
                              status: state.list[selectedIndex].status,
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
                              id: state.list[selectedIndex].id.toString(),
                              slNo: state.list[selectedIndex].slNo,
                              //guardRank: state.list[selectedIndex].guardRank,
                              gender: state.list[selectedIndex].gender,
                              dutyType: state.list[selectedIndex].dutyType,
                              maritalStatus:
                              state.list[selectedIndex].maritalStatus,
                              labels: labels,
                              status: state.list[selectedIndex].status,
                              isMaterGuard: true,
                              // isEventProtectionStatus: false,
                            );
                          },
                        );
                      },
                      index: index,
                    );
                  },
                ),
              );
            }));
  }

  getById(int id) async {
    showLoadingDialog(context);

    ShiftScheduleModel shiftScheduleModel =
    await ShiftScheduleServices().getById(id);

    editDataLoading(shiftScheduleModel);
  }

  void editDataLoading(ShiftScheduleModel? shiftScheduleModel) {
    dismissLoadingDialog(context);
    if (shiftScheduleModel != null) {
      Navigator.pushNamed(context, dutyPostMasterDetailsRoute, arguments: {
        "shiftScheduleModel": shiftScheduleModel,
        "title": Constants.editShiftSchedule
      });
    }
  }
}
