import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';
import '../bloc/key_history_record_bloc.dart';

class KeyHistoryRecordsView extends StatefulWidget {
  const KeyHistoryRecordsView(
      {super.key,
      required this.id,
      required this.type,
      this.model,
      this.extraProperties,
      this.lock,
      this.kipId});

  final int id;
  final int type;
  final KeyManagementMasterModel? model;
  final ExtraProperties? extraProperties;
  final String? lock;
  final int? kipId;

  @override
  State<KeyHistoryRecordsView> createState() => _KeyHistoryRecordsViewState();
}

class _KeyHistoryRecordsViewState extends State<KeyHistoryRecordsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  bool hasPermission = false;
  bool lockEmpty = false;
  bool keyDamageHistoryScreen = false;
  bool keyLostHistoryScreen = false;
  bool keyDestroyHistoryScreen = false;
  bool keyLockChangeHistoryScreen = false;

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
          startPos: pageNumber,
          maxPos: Constants.maxResults,
          id: widget.id,
          type: widget.type));
    }
  }

  @override
  Widget build(BuildContext context) {
    log('--widget.type---${widget.type}---');
    log('--status.type---${widget.model?.status}---');
    log('--id111--- ${(keyLostHistoryScreen && widget.id != 0)}');
    return BlocConsumer<KeyHistoryRecordBloc, KeyHistoryRecordState>(
      listener: (context, state) {},
      builder: (context, state) {
        if ((widget.extraProperties != null &&
            !widget.extraProperties!.hasWritePermission!)) {
          hasPermission = true;
        }
        if (widget.lock.isEmptyOrNull) {
          lockEmpty = true;
        }
        if (widget.type == ConstantsIntValue.keyLostHistoryInt) {
          keyLostHistoryScreen = true;
        }
        if (widget.type == ConstantsIntValue.keyDamageHistoryInt) {
          keyDamageHistoryScreen = true;
        }

        if (widget.type == ConstantsIntValue.keyDestroyHistoryInt) {
          keyDestroyHistoryScreen = true;
        }
        if (widget.type == ConstantsIntValue.lockChangeHistoryInt) {
          keyLockChangeHistoryScreen = true;
        }
        return Scaffold(
            backgroundColor: AppColors.cardBgColor,
            floatingActionButton: !hasPermission &&
                    lockEmpty &&
                    widget.model?.status != -1 &&
                    widget.model?.status != 0 &&
                    !keyLostHistoryScreen &&
                    !keyDamageHistoryScreen
                ? Flutterfloatingbutton(
                    backgroundColor: AppColors.navigationSkyBlueColor,
                    foregroundColor: AppColors.backgroundWhiteColor,
                    onPressed: () => {
                      Navigator.pushNamed(
                          context, keyHistoryRecordsDetailsRoute,
                          arguments: {
                            ConstantsArgument.title: keyLockChangeHistoryScreen
                                ? Constants.createLockChangeHistory
                                : keyLostHistoryScreen
                                    ? Constants.createKeyLostHistory
                                    : keyDamageHistoryScreen
                                        ? Constants.createKeyDamageHistory
                                        : keyDestroyHistoryScreen
                                            ? Constants.createKeyDestroyHistory
                                            : Constants
                                                .createkeyManagementMaster,
                            ConstantsArgument.id: widget.id,
                            ConstantsArgument.keyLostType: widget.type,
                          }),
                    },
                  )
                : const SizedBox(),
            appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: keyLockChangeHistoryScreen
                  ? Constants.lockChangeHistory
                  : keyLostHistoryScreen
                      ? Constants.keyLostHistory
                      : keyDamageHistoryScreen
                          ? Constants.keyDamageHistory
                          : keyDestroyHistoryScreen
                              ? Constants.keyDestroyHistory
                              : 'Default Title',
              showPopUp: false,
              showSaveButton: false,
              showSubmitButton: false,
              showDisLikeButton: false,
              showLikeButton: false,
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
                    color: AppColors.backgroundWhiteColor,
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
                                Constants.floor,
                            value: state.list[index].floor.toString()));
                        labels.add(Label(
                            key: state.labels?.locale.createdBy ??
                                state.labels?.defaultLocale.createdBy ??
                                Constants.createdby,
                            value:
                                '${state.list[index].createdBy?.firstName ?? ''} ${state.list[index].createdBy?.lastName ?? ''}'));
                        labels.add(Label(
                            key: state.labels?.locale.createdDate ??
                                state.labels?.defaultLocale.createdDate ??
                                Constants.createOn,
                            value: state.list[index].createdDate != null
                                ? Utils.timestampToDateConversion(
                                    int.parse(
                                        state.list[index].createdDate ?? '0'),
                                    Constants.twentyFourHourDateTimeFormat)
                                : ''));
                        labels.add(Label(
                            key: state.labels?.locale.noKeys ??
                                state.labels?.defaultLocale.noKeys ??
                                Constants.noOfKeys,
                            value: state.list[index].noOfKeys.toString()));
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
                                        id: state.list[selectedIndex].id
                                            .toString(),
                                        slNo: state.list[selectedIndex].slNo,
                                        labels: labels,
                                        status:
                                            state.list[selectedIndex].status,
                                        keyNo: state.list[selectedIndex].keyNo,
                                        keyTagging: state
                                            .list[selectedIndex].keyTagging,
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
                                  getById(
                                      state.extraProperties
                                              ?.hasWritePermission ??
                                          false,
                                      state.list[index].id ?? 0);
                                },
                                showEditButton:
                                    !(widget.extraProperties != null &&
                                            !widget.extraProperties!
                                                .hasWritePermission!)
                                        ? false
                                        : true,
                                onViewTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return BasePopUpItems(
                                        id: state.list[selectedIndex].id
                                            .toString(),
                                        slNo: state.list[selectedIndex].slNo,
                                        labels: labels,
                                        status:
                                            state.list[selectedIndex].status,
                                        keyNo: state.list[selectedIndex].keyNo,
                                        keyTagging: state
                                            .list[selectedIndex].keyTagging,
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
      },
    );
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    KeyHistoryModel keyHistoryModel =
        await KeyManagementMasterServices().getKHById(id);

    editDataLoading(keyHistoryModel, hasWritePermission);
  }

  void editDataLoading(
      KeyHistoryModel keyHistoryModel, bool hasWritePermission) {
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
        ConstantsArgument.keyLostType: widget.type,
        ConstantsArgument.keyType: keyHistoryModel.keyType,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      },
    );
  }
}
