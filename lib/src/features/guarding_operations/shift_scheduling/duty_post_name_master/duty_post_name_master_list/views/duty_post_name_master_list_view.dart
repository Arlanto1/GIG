import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/duty_post_master_list/bloc/duty_post_master_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/duty_post_name_master_list/bloc/duty_post_name_master_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/models/duty_post_name_master_model.dart';
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
          .read<DutyPostMasterListBloc>()
          .add(FetchDutyPostMasterList(startPos: pageNumber, maxPos: 20));
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
            Navigator.pushNamed(context, dutyPostNameMasterDetailsRoute,
                arguments: {"title": Constants.createDutyPostNameMaster,
                  "dutyPostNameMasterModel": DutyPostNameMasterModel(),
                }),
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.dutyPostNameMaster,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          excelAPIName: 'exportGMDataExcel',
          pdfAPIName: 'exportGMDataPDF',
        ),
        body: BlocBuilder<DutyPostNameMasterListBloc,
            DutyPostNameMasterListState>(builder: (context, state) {
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
                        location: state.list[index].location,
                        locationRegion: state.list[index].locationRegion,
                        labels: labels,
                        status: state.list[index].status,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.list[selectedIndex].id.toString(),
                                slNo: state.list[selectedIndex].slNo,
                                location: state.list[selectedIndex].location,
                                locationRegion:
                                    state.list[selectedIndex].locationRegion,
                                labels: labels,
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
                                location: state.list[selectedIndex].location,
                                locationRegion:
                                    state.list[selectedIndex].locationRegion,
                                labels: labels,
                                status: state.list[selectedIndex].status,
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

    DutyPostNameMasterModel dutyPostNameMasterModel =
        await DutyPostNameMasterServices().getById(id);

    editDataLoading(dutyPostNameMasterModel);
  }

  void editDataLoading(DutyPostNameMasterModel? dutyPostNameMasterModel) {
    dismissLoadingDialog(context);
    if (dutyPostNameMasterModel != null) {
      Navigator.pushNamed(context, dutyPostNameMasterDetailsRoute, arguments: {
        "dutyPostNameMasterModel": dutyPostNameMasterModel,
        "title": Constants.editDutyPostNameMaster
      });
    }
  }
}
