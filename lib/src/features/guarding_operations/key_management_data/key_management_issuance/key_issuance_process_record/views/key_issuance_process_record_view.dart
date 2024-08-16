import 'dart:developer';

import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/key_issuance_process_record/bloc/key_issuance_process_record_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/services/key_management_issuance_services.dart';

import '../../../../../../../index.dart';
import '../../../key_management_master/services/key_management_master_services.dart';
import 'add_key_issuance_process_pop_up.dart';

class KeyIssuanceProcessRecordsView extends StatefulWidget {
  const KeyIssuanceProcessRecordsView({
    super.key,
    required this.parentId,
    required this.parentStatus,
    required this.locationId,
    required this.title,
    // this.model,
    required this.isMasterKey,
    this.id,
    this.extraProperties,
    this.lock,
    this.kldId,
  });

  final int parentId;
  final int parentStatus;
  final int locationId;
  final String title;

  // final KeyIssuanceProcessRecord? model;
  final bool isMasterKey;
  final int? id;
  final ExtraProperties? extraProperties;
  final String? lock;
  final int? kldId;

  @override
  State<KeyIssuanceProcessRecordsView> createState() =>
      _ContactRecordViewState();
}

class _ContactRecordViewState extends State<KeyIssuanceProcessRecordsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    context.read<KeyIssuanceProcessRecordBloc>().add(
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
      context.read<KeyIssuanceProcessRecordBloc>().add(
          FetchData(id: widget.parentId, startPos: pageNumber, maxPos: 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KeyIssuanceProcessRecordBloc,
        KeyIssuanceProcessRecordState>(listener: (context, state) {
      Utils().formError(state, context);
      Utils().errorAndLogout(state, context);
    }, builder: (context, state) {
      log('-k desc--${state.keyDescriptions?.length}---');

      return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: !(widget.extraProperties != null &&
                    !widget.extraProperties!.hasWritePermission!) &&
                widget.parentStatus == 0 &&
                widget.lock.isEmptyOrNull
            ? Flutterfloatingbutton(
                backgroundColor: AppColors.navigationSkyBlueColor,
                foregroundColor: AppColors.backgroundWhiteColor,
                onPressed: () async {
                  KeyIssuanceProcessRecord keyIssuanceProcessModel =
                      KeyIssuanceProcessRecord();
                  bool isMasterKey =
                      keyIssuanceProcessModel.kmId == 1 ? true : false;
                  List<Organisation> keyDescriptions =
                      await KeyManagementIssuanceServices().getKeyDescriptions(
                    locationId: widget.locationId,
                    isMasterKey: isMasterKey,
                    kmIssuanceId: widget.parentId,
                  );

                  showAddKeyIssuanceProcessPopUp(
                    context: context,
                    keyIssuanceProcessRecord: KeyIssuanceProcessRecord(),
                    keyDescriptions: keyDescriptions,
                    selectedKeyDescription: null,
                    parentStatus: widget.parentStatus,
                  );
                },
              )
            : null,
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: state.labels?.locale.keyIssProcess ??
              state.labels?.defaultLocale.keyIssProcess ??
              Constants.keyIssuanceProcess,
          showPopUp: false,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
        ),
        body: getBody(state),
      );
    });
  }

  getBody(KeyIssuanceProcessRecordState state) {
    if (state.status == FormStatus.initial ||
        state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.items.isEmptyOrNull) {
      return const NoRecordFoundWidget();
    }
    //  if (state.items.isEmptyOrNull && !isPopUpShown) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     isPopUpShown = true;
    //     showAddKeyIssuanceProcessPopUp(
    //       context: context,
    //       keyIssuanceProcessRecord: KeyIssuanceProcessRecord(),
    //       keyDescriptions: state.keyDescriptions??[],
    //       selectedKeyDescription: state.keyDescription,
    //       parentStatus: widget.parentStatus,
    //     );
    //   });
    //   return const NoRecordFoundWidget();
    // }

    return Container(
      margin: allMargin16,
      decoration: const ShapeDecoration(
          color: AppColors.backgroundWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          )),
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
            state.hasReachedMax ? state.items.length : state.items.length + 1,
        itemBuilder: (context, index) {
          List<Label> labels = [];
          if (index < state.items.length) {
            labels.add(
              Label(
                key: 'No.keys issued',
                value: state.items[index].noKeysIssued.toString(),
              ),
            );
            labels.add(
              Label(
                key: 'Available ',
                value: state.items[index].available.toString(),
              ),
            );
            labels.add(
              Label(
                key: 'Keys Returned',
                value: state.items[index].returned.toString(),
              ),
            );
            labels.add(
              Label(
                key: 'Keys Not Returned',
                value: state.items[index].notReturned.toString(),
              ),
            );
            labels.add(
              Label(
                key: 'Keys Lost',
                value: state.items[index].lost.toString(),
              ),
            );
            labels.add(
              Label(
                key: 'Keys Damaged',
                value: state.items[index].damaged.toString(),
              ),
            );
            return index >= state.items.length
                ? const BaseLoader()
                : BaseListTileItem(
                    id: state.items[index].id,
                    labels: labels,
                    onTap: (selectedIndex) {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return BasePopUpItems(
                            id: state.items[selectedIndex].id.toString(),
                            labels: labels,
                          );
                        },
                      );
                    },
                    showDutyPostEditButton: (widget.parentStatus == 0 ||
                                widget.parentStatus == 1 ||
                                widget.parentStatus == 2) &&
                            !(widget.extraProperties != null &&
                                !widget.extraProperties!.hasWritePermission!) &&
                            widget.lock.isEmptyOrNull
                        ? true
                        : false,
                    showEditButton: widget.parentStatus != 0 &&
                            widget.parentStatus != 1 &&
                            widget.parentStatus != 2 &&
                            (widget.extraProperties != null &&
                                !widget.extraProperties!.hasWritePermission!) &&
                            !widget.lock.isEmptyOrNull
                        ? true
                        : false,
                    onEditTap: (selectedIndex) async {
                      KeyIssuanceProcessRecord keyIssuanceProcessModel =
                          await KeyManagementIssuanceServices()
                              .getIssuanceProcessById(
                                  state.items[index].id ?? 0);

                      /// Get Key Description
                      bool isMasterKey =
                          keyIssuanceProcessModel.kmId == 1 ? true : false;
                      Organisation selectedKeyDescription =
                          await KeyManagementIssuanceServices().getKeyDescById(
                              id: keyIssuanceProcessModel.kmId!,
                              isMasterKey: isMasterKey);

                      List<Organisation> keyDescriptions =
                          await KeyManagementIssuanceServices()
                              .getKeyDescriptions(
                        locationId: widget.locationId,
                        isMasterKey: isMasterKey,
                        kmIssuanceId: widget.parentId,
                      );

                      log('--state.keyDescriptions--onEditTap--${state.keyDescriptions?.length}---');

                      showAddKeyIssuanceProcessPopUp(
                        context: context,
                        keyIssuanceProcessRecord: keyIssuanceProcessModel,
                        keyDescriptions: keyDescriptions,
                        selectedKeyDescription: selectedKeyDescription,
                        parentStatus: widget.parentStatus,
                        lock: widget.lock,
                      );
                    },
                    showViewButton: (widget.parentStatus == 1 ||
                                widget.parentStatus == 2) &&
                            !(widget.extraProperties != null &&
                                !widget.extraProperties!.hasWritePermission!) &&
                            widget.lock.isEmptyOrNull
                        ? true
                        : false,
                    onViewTap: (selectedIndex) {
                      getById(
                          state.extraProperties?.hasWritePermission ?? false,
                          state.items[index].kmId);
                    },
                    showLinkOffButton: widget.lock.isEmptyOrNull &&
                            (widget.parentStatus == 1 ||
                                widget.parentStatus == 2) &&
                            !(widget.extraProperties != null &&
                                !widget.extraProperties!.hasWritePermission!)
                        ? true
                        : false,
                    onLinkOffTap: (selectedIndex) async {
                      if (state.items[selectedIndex].lost == 0) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(Constants.valueNotAccepted),
                              content:
                                  const Text(Constants.enteredValueNotAccepted),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(Constants.ok),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        getKeyHistoryById(
                            state.extraProperties?.hasWritePermission ?? false,
                            state.items[index].kmId,
                            widget.parentId,
                            state.items[selectedIndex].id,
                            Constants.keyLostHistory,
                            ConstantsIntValue.keyLostHistoryInt);
                      }
                    },
                    showDeleteButton: widget.lock.isEmptyOrNull &&
                            (widget.parentStatus == 1 ||
                                widget.parentStatus == 2) &&
                            !(widget.extraProperties != null &&
                                !widget.extraProperties!.hasWritePermission!)
                        ? true
                        : false,
                    onDeleteTap: (selectedIndex) async {
                      if (state.items[selectedIndex].damaged == 0) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(Constants.valueNotAccepted),
                              content:
                                  const Text(Constants.enteredValueNotAccepted),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(Constants.ok),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        getKeyHistoryById(
                            state.extraProperties?.hasWritePermission ?? false,
                            state.items[index].kmId,
                            widget.parentId,
                            state.items[selectedIndex].id,
                            Constants.keyDamageHistory,
                            ConstantsIntValue.keyDamageHistoryInt);
                      }
                    },
                    index: index,
                  );
          }
          return const SizedBox();
        },
      ),
    );
  }

  getById(bool hasWritePermission, int? kmId) async {
    showLoadingDialog(context);
    log('MasterId $kmId');

    KeyManagementMasterModel keyManagementMasterModel =
        await KeyManagementMasterServices().getById(kmId!);

    editDataLoading(keyManagementMasterModel, hasWritePermission);
  }

  void editDataLoading(KeyManagementMasterModel? keyManagementMasterModel,
      bool hasWritePermission) {
    log('MasterId ${keyManagementMasterModel?.id}');
    dismissLoadingDialog(context);
    if (keyManagementMasterModel != null) {
      Navigator.pushNamed(context, keyManagementMasterDetailsRoute, arguments: {
        "keyMgmtGi": keyManagementMasterModel,
        "title": Constants.editkeyManagementMaster,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      });
    }
  }

  getKeyHistoryById(bool hasWritePermission, int? kmId, int? keyIssuanceId,
      int? id, String? title, int? type) async {
    showLoadingDialog(context);

    KeyHistoryModel keyHistoryModel = await KeyManagementIssuanceServices()
        .getIssuanceKHById(kmId!, keyIssuanceId!, type!);

    editKeyHistoryDataLoading(kmId, keyHistoryModel, hasWritePermission, id,
        keyIssuanceId, title, type);
  }

  Future<void> editKeyHistoryDataLoading(
      int kmId,
      KeyHistoryModel? keyHistoryModel,
      bool hasWritePermission,
      int? id,
      int? keyIssuanceId,
      String? title,
      int? type) async {
    dismissLoadingDialog(context);
    if (keyHistoryModel?.id != null) {
      Navigator.pushNamed(context, keyHistoryRecordsDetailsRoute, arguments: {
        "keyLossGi": KeyHistoryModel,
        ConstantsArgument.title: title,
        ConstantsArgument.id: keyHistoryModel?.kmId,
        ConstantsArgument.model: keyHistoryModel,
        ConstantsArgument.keyIssuanceId: keyIssuanceId,
        ConstantsArgument.keyLostType: type,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      });
    } else {
      Navigator.pushNamed(
        context,
        keyHistoryRecordsDetailsRoute,
        arguments: {
          ConstantsArgument.title: title,
          ConstantsArgument.id: kmId,
          ConstantsArgument.kipId: id,
          ConstantsArgument.keyIssuanceId: keyIssuanceId,
          ConstantsArgument.keyLostType: type,
        },
      );
    }
  }

  showAddKeyIssuanceProcessPopUp({
    required BuildContext context,
    required KeyIssuanceProcessRecord keyIssuanceProcessRecord,
    required final List<Organisation> keyDescriptions,
    required Organisation? selectedKeyDescription,
    required final int parentStatus,
    final String? lock,
  }) {
    log('---showAddKeyIssuanceProcessPopUp-----k desc-333-${keyDescriptions.length}---');

    // List<Organisation> orgs=[];
    //  for(KeyDescription keyDescription in keyDescriptions) {
    //    orgs.add(Organisation(name: keyDescription.keyDescription));
    // }
    log('keyIssuanceProcessRecord-------${keyIssuanceProcessRecord.available}-----');

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddKeyIssuanceProcessPopUp(
          title: widget.title,
          model: keyIssuanceProcessRecord,
          mainContext: context,
          keyDescriptions: keyDescriptions,
          selectedKeyDescription: selectedKeyDescription,
          parentStatus: parentStatus,
          lock: widget.lock,
          onSubmit: (KeyIssuanceProcessRecord model) {
            //loginFormKey.currentState!.validate();
            // FocusScope.of(context).unfocus();

            log('-widget.title---${widget.title}----');

            BlocProvider.of<KeyIssuanceProcessRecordBloc>(context).add(
              SaveRecord(
                model,
                widget.parentId,
              ),
            );
          },
        );
      },
    );
  }
}
