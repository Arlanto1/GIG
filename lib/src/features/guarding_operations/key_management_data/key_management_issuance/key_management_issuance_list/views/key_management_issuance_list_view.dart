import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/key_management_issuance_list/bloc/key_management_issuance_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/key_management_issuance_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/services/key_management_issuance_services.dart';

class KeyManagementIssuanceListView extends StatefulWidget {
  const KeyManagementIssuanceListView({
    super.key,
  });

  @override
  State<KeyManagementIssuanceListView> createState() =>
      _KeyManagementIssuanceListViewState();
}

class _KeyManagementIssuanceListViewState
    extends State<KeyManagementIssuanceListView> {
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
          .read<KeyManagementIssuanceListBloc>()
          .add(FetchKeyIssuanceList(startPos: pageNumber, maxPos: 20));
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
            Navigator.pushNamed(context, keyManagementIssuanceDetailsRoute,
                arguments: {"title": Constants.createKeyManagementIssuance}),
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.keyManagementIssuance,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          excelAPIName: 'exportGMDataExcel',
          pdfAPIName: 'exportGMDataPDF',
        ),
        body: BlocBuilder<KeyManagementIssuanceListBloc,
            KeyManagementIssuanceListState>(builder: (context, state) {
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
                      key: 'Created By',
                      value: state.list[index].createdBy?.name ?? ''));
                  labels.add(Label(
                      key:
                          // state.labels?.locale.location ??
                          //     state.labels?.defaultLocale.location ??
                          'Location ',
                      value: state.list[index].location?.name ?? ''));
                }
                return index >= state.list.length
                    ? const BaseLoader()
                    : BaseListTileItem(
                        id: state.list[index].id,
                        labels: labels,
                        status: state.list[index].status,
                        isEventProtectionStatus: false,
                        isKeyManagementIssuanceStatus: true,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.list[selectedIndex].id.toString(),
                                slNo: state.list[selectedIndex].slNo,
                                labels: labels,
                                isMasterGuard: false,
                                isEventProtectionStatus: false,
                                isKeyManagementIssuanceStatus: true,
                                status: state.list[selectedIndex].status,
                                employeeType:
                                    state.list[selectedIndex].employeeType,
                                dbSponsorCWRT2:
                                    state.list[selectedIndex].dbSponsorCwrT2,
                                department:
                                    state.list[selectedIndex].department,
                                handedOver:
                                    state.list[selectedIndex].handedOverTo,
                                returnedByName:
                                    state.list[selectedIndex].returnedByName,
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
                                employeeType:
                                    state.list[selectedIndex].employeeType,
                                dbSponsorCWRT2:
                                    state.list[selectedIndex].dbSponsorCwrT2,
                                department:
                                    state.list[selectedIndex].department,
                                handedOver:
                                    state.list[selectedIndex].handedOverTo,
                                returnedByName:
                                    state.list[selectedIndex].returnedByName,
                                isKeyManagementIssuanceStatus: true,
                                isEventProtectionStatus: false,
                                isMasterGuard: false,
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

    KeyManagementIssuanceModel keyManagementIssuanceModel =
        await KeyManagementIssuanceServices().getKMIById(id);

    editDataLoading(keyManagementIssuanceModel);
  }

  void editDataLoading(KeyManagementIssuanceModel? model) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        keyManagementIssuanceDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.keyManagementIssuance,
        },
      );
    }
  }
}
