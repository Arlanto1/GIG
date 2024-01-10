import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_list/bloc/key_management_master_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';

class KeyManagementMasterListView extends StatefulWidget {
  const KeyManagementMasterListView({
    super.key,
  });

  @override
  State<KeyManagementMasterListView> createState() =>
      _KeyManagementMasterListViewState();
}

class _KeyManagementMasterListViewState
    extends State<KeyManagementMasterListView> {
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
          .read<KeyManagementMasterListBloc>()
          .add(FetchKeyMasterList(startPos: pageNumber, maxPos: 20));
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
            Navigator.pushNamed(context, keyManagementMasterDetailsRoute,
                arguments: {"title": Constants.createkeyManagementMaster}),
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.keyManagementMaster,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          excelAPIName: 'exportGMDataExcel',
          pdfAPIName: 'exportGMDataPDF',
        ),
        body: BlocBuilder<KeyManagementMasterListBloc,
            KeyManagementMasterListState>(builder: (context, state) {
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
                  labels.add(Label(
                      // key: state.labels?.locale.locationRegion ??
                      //  state.labels?.defaultLocale.locationRegion ??
                      key: 'Floor',
                      value: state.list[index].floor.toString()));
                  labels.add(Label(
                      key:
                          // state.labels?.locale.location ??
                          //state.labels?.defaultLocale.location ??
                          'Created By',
                      value: state.list[index].createdBy?.name ?? ''));

                return index >= state.list.length
                    ? const BaseLoader()
                    : BaseListTileItem(
                        id: state.list[index].id,
                        labels: labels,
                        status: state.list[index].status,
                  isKeyManagementStatus: true,
                  isEventProtectionStatus: false,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.list[selectedIndex].id.toString(),
                                slNo: state.list[selectedIndex].slNo,
                                labels: labels,
                                status: state.list[selectedIndex].status,
                                keyNo: state.list[selectedIndex].keyNo,
                                keyTagging: state.list[selectedIndex].keyTagging,
                                doorName: state.list[selectedIndex].doorName,
                                isKeyManagementStatus: true,
                                isEventProtectionStatus: false,
                                isMasterGuard: false,
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
                                labels: labels,
                                status: state.list[selectedIndex].status,
                                keyNo: state.list[selectedIndex].keyNo,
                                keyTagging: state.list[selectedIndex].keyTagging,
                                doorName: state.list[selectedIndex].doorName,
                                isEventProtectionStatus: false,
                                isKeyManagementStatus: true,
                                isMasterGuard: false,
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
              }


            ),

          );
        }));
  }

  getById(int id) async {
    showLoadingDialog(context);

    KeyManagementMasterModel keyManagementMasterModel =
        await KeyManagementMasterServices().getById(id);

    editDataLoading(keyManagementMasterModel);
  }

  void editDataLoading(KeyManagementMasterModel? keyManagementMasterModel) {
    dismissLoadingDialog(context);
    if (keyManagementMasterModel != null) {
      Navigator.pushNamed(context, keyManagementMasterDetailsRoute, arguments: {
        "keyMgmtGi": keyManagementMasterModel,
        "title": Constants.editkeyManagementMaster
      });
    }
  }
}
