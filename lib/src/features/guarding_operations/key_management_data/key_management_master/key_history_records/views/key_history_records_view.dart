import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/models/key_history_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../bloc/key_history_record_bloc.dart';

class KeyHistoryRecordsView extends StatefulWidget {
  const KeyHistoryRecordsView({
    super.key,
    required this.id,
    required this.type,
  });

  final int id;
  final int type;

  @override
  State<KeyHistoryRecordsView> createState() => _KeyHistoryRecordsViewState();
}

class _KeyHistoryRecordsViewState extends State<KeyHistoryRecordsView> {
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
      context.read<KeyHistoryRecordBloc>().add(FetchData(
          startPos: pageNumber, maxPos: Constants.maxResults, id: widget.id, type: widget.type));
    }
  }

  @override
  Widget build(BuildContext context) {
    log('--widget.type---${widget.type}---');

    return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: Flutterfloatingbutton(
          backgroundColor: AppColors.navigationSkybluecolor,
          foregroundColor: AppColors.backgroundWhitecolor,
          onPressed: () => {
            Navigator.pushNamed(context, keyHistoryRecordsDetailsRoute,
                arguments: {
                  ConstantsArgument.title: widget.type ==
                          ConstantsIntValue.lockChangeHistoryInt
                      ? Constants.createLockChangeHistory
                      : widget.type == ConstantsIntValue.keyLostHistoryInt
                          ? Constants.createKeyLostHistory
                          : widget.type == ConstantsIntValue.keyDamageHistoryInt
                              ? Constants.createKeyDamageHistory
                              : widget.type ==
                                      ConstantsIntValue.keyDestroyHistoryInt
                                  ? Constants.createKeyDestroyHistory
                                  : Constants.createkeyManagementMaster,
                  ConstantsArgument.id: widget.id,
                  ConstantsArgument.type: widget.type,
                }),
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: widget.type == ConstantsIntValue.lockChangeHistoryInt
              ? Constants.lockChangeHistory
              : widget.type == ConstantsIntValue.keyLostHistoryInt
                  ? Constants.keyLostHistory
                  : widget.type == ConstantsIntValue.keyDamageHistoryInt
                      ? Constants.keyDamageHistory
                      : widget.type == ConstantsIntValue.keyDestroyHistoryInt
                          ? Constants.keyDestroyHistory
                          : 'Default Title',
          showPopUp: false,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'exportGMDataExcel',
          pdfAPIName: 'exportGMDataPDF',
        ),
        body: BlocBuilder<KeyHistoryRecordBloc, KeyHistoryRecordState>(
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
                    labels.add(Label(
                        key: state.labels?.locale.floor ??
                            state.labels?.defaultLocale.floor ??
                            'Floor',
                        value: state.list[index].floor.toString()));
                    labels.add(Label(
                        key: state.labels?.locale.createdBy ??
                            state.labels?.defaultLocale.createdBy ??
                            'Created By',
                        value:
                            '${state.list[index].createdBy?.firstName ?? ''} ${state.list[index].createdBy?.lastName ?? ''}'));
                    // labels.add(Label(
                    //     key: 'Date of Creation',
                    //     value: DateFormat('dd-MM-yyyy').format(
                    //         DateTime.fromMillisecondsSinceEpoch(
                    //             state.list[index].createdDate ?? 0 * 1000))));
                    return index >= state.list.length
                        ? const BaseLoader()
                        : BaseListTileItem(
                            id: state.list[index].id,
                            labels: labels,
                            status: state.list[index].status,
                            isKeyManagementHistoryStatus: true,
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
                                    keyTagging:
                                        state.list[selectedIndex].keyTagging,
                                    doorName:
                                        state.list[selectedIndex].doorName,
                                    isEventProtectionStatus: false,
                                    isKeyManagementHistoryStatus: true,
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
                                    keyTagging:
                                        state.list[selectedIndex].keyTagging,
                                    doorName:
                                        state.list[selectedIndex].doorName,
                                    isEventProtectionStatus: false,
                                    isKeyManagementHistoryStatus: true,
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
                }),
          );
        }));
  }

  getById(int id) async {
    showLoadingDialog(context);

    KeyHistoryModel keyHistoryModel =
        await KeyManagementMasterServices().getKHById(id);

    editDataLoading(keyHistoryModel);
  }

  void editDataLoading(KeyHistoryModel keyHistoryModel) {
    dismissLoadingDialog(context);
    Navigator.pushNamed(
      context,
      keyHistoryRecordsDetailsRoute,
      arguments: {
        ConstantsArgument.model: keyHistoryModel,
        ConstantsArgument.title:
            widget.type == ConstantsIntValue.lockChangeHistoryInt
                ? Constants.editLockChangeHistory
                : widget.type == ConstantsIntValue.keyLostHistoryInt
                    ? Constants.editKeyLostHistory
                    : widget.type == ConstantsIntValue.keyDamageHistoryInt
                        ? Constants.editKeyDamageHistory
                        : widget.type == ConstantsIntValue.keyDestroyHistoryInt
                            ? Constants.editKeyDestroyHistory
                            : 'Default Title',
        ConstantsArgument.id: widget.id,
        ConstantsArgument.type: widget.type,
      },
    );
  }
}
