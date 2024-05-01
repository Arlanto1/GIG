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
    this.model,
    required this.isMasterKey,
    this.id,
    this.extraProperties,
  });

  final int parentId;
  final int parentStatus;
  final int locationId;
  final String title;
  final KeyIssuanceProcessRecord? model;
  final bool isMasterKey;
  final int? id;
  final ExtraProperties? extraProperties;


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
      // TODO: implement listener
    }, builder: (context, state) {
      log('-k desc--${state.keyDescriptions?.length}---');

      return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: !(widget.extraProperties != null &&
            !widget.extraProperties!.hasWritePermission! ) &&
                widget.parentStatus == 0
            ? Flutterfloatingbutton(
                backgroundColor: AppColors.navigationSkybluecolor,
                foregroundColor: AppColors.backgroundWhitecolor,
                onPressed: () async {
                  KeyIssuanceProcessRecord keyIssuanceProcessModel =
                      KeyIssuanceProcessRecord();
                  bool isMasterKey =
                      keyIssuanceProcessModel.kmId == 1 ? true : false;
                  List<Organisation> keyDescriptions =
                      await KeyManagementIssuanceServices().getKeyDescriptions(
                          locationId: widget.locationId,
                          isMasterKey: isMasterKey);

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
          // excelAPIName: 'exportMMExcel',
          // pdfAPIName: 'exportMMPDF',
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
          color: AppColors.backgroundWhitecolor,
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
                            !widget.extraProperties!.hasWritePermission! )
                        ? true
                        : false,
                    showEditButton: widget.parentStatus != 0 &&
                            widget.parentStatus != 1 &&
                            widget.parentStatus != 2 &&
                            widget.parentStatus != 2 &&
                        (widget.extraProperties != null &&
                            !widget.extraProperties!.hasWritePermission! )
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
                                  isMasterKey: isMasterKey);

                      log('--state.keyDescriptions--onEditTap--${state.keyDescriptions?.length}---');

                      showAddKeyIssuanceProcessPopUp(
                        context: context,
                        keyIssuanceProcessRecord: keyIssuanceProcessModel,
                        keyDescriptions: keyDescriptions,
                        selectedKeyDescription: selectedKeyDescription,
                        parentStatus: widget.parentStatus,
                      );
                    },
                    onViewTap: (selectedIndex) {
                      getById(
                          state.extraProperties?.hasWritePermission ?? false,
                          state.items[index].kmId);
                    },
                    showLinkOffButton: (widget.parentStatus == 1 ||
                                widget.parentStatus == 2) &&
                        !(widget.extraProperties != null &&
                            !widget.extraProperties!.hasWritePermission! )
                        ? true
                        : false,
                    onLinkOffTap: (selectedIndex) async {
                      int? kmId = state.items[selectedIndex].kmId;
                      Navigator.pushNamed(
                        context,
                        keyHistoryRecordsDetailsRoute,
                        arguments: {
                          ConstantsArgument.title: Constants.keyLostHistory,
                          ConstantsArgument.id: kmId,
                          ConstantsArgument.type:
                              ConstantsIntValue.keyLostHistoryInt,
                        },
                      );
                    },
                    showDeleteButton: (widget.parentStatus == 1 ||
                                widget.parentStatus == 2) &&
                        !(widget.extraProperties != null &&
                            !widget.extraProperties!.hasWritePermission! )
                        ? true
                        : false,
                    onDeleteTap: (selectedIndex) async {
                      int? kmId = state.items[selectedIndex].kmId;
                      Navigator.pushNamed(
                        context,
                        keyHistoryRecordsDetailsRoute,
                        arguments: {
                          ConstantsArgument.title: Constants.keyDamageHistory,
                          ConstantsArgument.id: kmId,
                          ConstantsArgument.type:
                              ConstantsIntValue.keyDamageHistoryInt,
                        },
                      );
                    },
                    index: index,
                  );
          }
          return null;
        },
      ),
    );
  }

  getById(bool hasWritePermission, int? kmId) async {
    showLoadingDialog(context);

    KeyManagementMasterModel keyManagementMasterModel =
        await KeyManagementMasterServices().getById(kmId!);

    editDataLoading(keyManagementMasterModel, hasWritePermission);
  }

  void editDataLoading(KeyManagementMasterModel? keyManagementMasterModel,
      bool hasWritePermission) {
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

  createRecord(int? kmId) async {
    showLoadingDialog(context);

    KeyHistoryRecordRequest request = KeyHistoryRecordRequest();
    await KeyManagementMasterServices().createKeyHistoryRecord(
      body: request,
      kmId: kmId.toString(),
      isSubmit: false,
    );
    Navigator.pushNamed(context, keyHistoryRecordsDetailsRoute, arguments: {
      "keyLossGi": KeyHistoryModel,
      "title": Constants.keyLostHistory
    });
  }

  showAddKeyIssuanceProcessPopUp({
    required BuildContext context,
    required KeyIssuanceProcessRecord keyIssuanceProcessRecord,
    required final List<Organisation> keyDescriptions,
    required Organisation? selectedKeyDescription,
    required final int parentStatus,
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
