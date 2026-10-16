import 'dart:developer';
import 'dart:ui';

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
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<KeyIssuanceProcessRecordBloc,
        KeyIssuanceProcessRecordState>(listener: (context, state) {
      Utils().formError(state, context);
      Utils().errorAndLogout(state, context);

      // if (state.status == FormStatus.popOnly) {
      //   Navigator.pop(context);
      // }
    }, builder: (context, state) {
      log('-k desc--${state.keyDescriptions?.length}---');

      return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        extendBody: true,
        // floatingActionButton: !(widget.extraProperties != null &&
        //             !widget.extraProperties!.hasWritePermission!) &&
        //         widget.parentStatus == 0 &&
        //         widget.lock.isEmptyOrNull
        //     ? Flutterfloatingbutton(
        //         backgroundColor: AppColors.navigationSkyBlueColor,
        //         foregroundColor: AppColors.backgroundWhiteColor,
        //         onPressed: () async {
        //           KeyIssuanceProcessRecord keyIssuanceProcessModel =
        //               KeyIssuanceProcessRecord();
        //           bool isMasterKey =
        //               keyIssuanceProcessModel.kmId == 1 ? true : false;
        //           List<Organisation> keyDescriptions =
        //               await KeyManagementIssuanceServices().getKeyDescriptions(
        //             locationId: widget.locationId,
        //             isMasterKey: isMasterKey,
        //             kmIssuanceId: widget.parentId,
        //           );
        //
        //           showAddKeyIssuanceProcessPopUp(
        //             context: context,
        //             keyIssuanceProcessRecord: KeyIssuanceProcessRecord(),
        //             keyDescriptions: keyDescriptions,
        //             selectedKeyDescription: null,
        //             parentStatus: widget.parentStatus,
        //             state: state,
        //           );
        //         },
        //       ),

        bottomNavigationBar: !(widget.extraProperties != null &&
                    !widget.extraProperties!.hasWritePermission!) &&
                widget.parentStatus == 0 &&
                widget.lock.isEmptyOrNull
            ? CustomBottomNavigationBar(
                hasAddPermission: true,
                scaffoldKey: scaffoldKey,
                context: context,
                // displayMenu: state.displayMenu,
                list: true,
                // 🔥 only "+" button mode
                // onAddPressed: () async {
                //   KeyIssuanceProcessRecord keyIssuanceProcessModel =
                //       KeyIssuanceProcessRecord();
                //   bool isMasterKey =
                //       keyIssuanceProcessModel.kmId == 1 ? true : false;
                //   List<Organisation> keyDescriptions =
                //       await KeyManagementIssuanceServices().getKeyDescriptions(
                //     locationId: widget.locationId,
                //     isMasterKey: isMasterKey,
                //     kmIssuanceId: widget.parentId,
                //   );
                //
                //   showAddKeyIssuanceProcessPopUp(
                //     context: context,
                //     keyIssuanceProcessRecord: KeyIssuanceProcessRecord(),
                //     keyDescriptions: keyDescriptions,
                //     selectedKeyDescription: null,
                //     parentStatus: widget.parentStatus,
                //     state: state,
                //   );
                // },
          onAddPressed: () async {
            showLoadingDialog(context);

            try {
              KeyIssuanceProcessRecord keyIssuanceProcessModel =
              KeyIssuanceProcessRecord();

              bool isMasterKey =
                  keyIssuanceProcessModel.kmId == 1;

              List<Organisation> keyDescriptions =
              await KeyManagementIssuanceServices().getKeyDescriptions(
                locationId: widget.locationId,
                isMasterKey: isMasterKey,
                kmIssuanceId: widget.parentId,
              );

              if (!mounted) return;

              dismissLoadingDialog(context);

              showAddKeyIssuanceProcessPopUp(
                context: context,
                keyIssuanceProcessRecord: KeyIssuanceProcessRecord(),
                keyDescriptions: keyDescriptions,
                selectedKeyDescription: null,
                parentStatus: widget.parentStatus,
                state: state,
              );
            } catch (e) {
              if (mounted) {
                dismissLoadingDialog(context);
              }

              log('Error while loading key descriptions: $e');
            }
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
    if (
        state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.items.isEmptyOrNull) {
      return const NoRecordFoundWidget();
    }
    bool showIcons;
    bool editableStatus;
    bool showNonEditIcon;

    editableStatus = (widget.parentStatus ==
            ConstantsIntValue.issuanceHandedOverStatus ||
        widget.parentStatus == ConstantsIntValue.issuanceNotReturnedStatus ||
        widget.parentStatus ==
            ConstantsIntValue.issuanceLostNotReturnedStatus ||
        widget.parentStatus ==
            ConstantsIntValue.issuanceClosedLostNotReturnedStatus ||
        widget.parentStatus ==
            ConstantsIntValue.issuanceLostDamagedNotReturnedStatus ||
        widget.parentStatus ==
            ConstantsIntValue.issuanceClosedLostDamagedNotReturnedStatus ||
        widget.parentStatus ==
            ConstantsIntValue.issuanceDamagedNotReturnedStatus);

    showNonEditIcon = (widget.parentStatus ==
            ConstantsIntValue.issuanceClosedDamagedStatus ||
        widget.parentStatus == ConstantsIntValue.issuanceClosedLostStatus ||
        widget.parentStatus ==
            ConstantsIntValue.issuanceClosedLostDamagedStatus ||
        widget.parentStatus == ConstantsIntValue.issuanceClosedDamagedStatus ||
        widget.parentStatus == ConstantsIntValue.issuanceClosedStatus ||
        widget.parentStatus == ConstantsIntValue.cancelledStatus);

    showIcons = editableStatus &&
        !(widget.extraProperties != null &&
            !widget.extraProperties!.hasWritePermission!) &&
        widget.lock.isEmptyOrNull;
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
    return Stack(
      children: [
        // // 🔹 Background
        // Positioned.fill(
        //   child: Image.asset(
        //     'assets/images/bg2.png',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // Positioned.fill(
        //   child: ClipRect(
        //     child: BackdropFilter(
        //       filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        //       child: Container(
        //         color: Colors.black.withValues(alpha: 0.2),
        //       ),
        //     ),
        //   ),
        // ),
        SafeArea(
          child: Column(
            children: [
              Expanded(
                // <-- Wrap ListView.builder inside Expanded
                child: Stack(
                  children: [
                    ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: state.hasReachedMax
                          ? state.items.length
                          : state.items.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= state.items.length) {
                          if (state.status == FormStatus.loading ||
                              state.status == FormStatus.initial) {
                            return const Center(child: BaseLoader());
                          }
                          return const SizedBox();
                        }
                        List<Label> labels = [];
                        if (index < state.items.length) {
                          labels.add(
                            Label(
                              key: state.labels?.locale.noKeysIssued ??
                                  state.labels?.defaultLocale.noKeysIssued ??
                                  Constants.noKeysIssued,
                              value: state.items[index].noKeysIssued.toString(),
                            ),
                          );
                          labels.add(
                            Label(
                              key: state.labels?.locale.available ??
                                  state.labels?.defaultLocale.available ??
                                  Constants.available,
                              value: state.items[index].available.toString(),
                            ),
                          );
                          labels.add(
                            Label(
                              key: state.labels?.locale.keysReturned ??
                                  state.labels?.defaultLocale.keysReturned ??
                                  Constants.keysReturned,
                              value: state.items[index].returned.toString(),
                            ),
                          );
                          labels.add(
                            Label(
                              key: state.labels?.locale.keysNotReturned ??
                                  state.labels?.defaultLocale.keysNotReturned ??
                                  Constants.keysNotReturned,
                              value: state.items[index].notReturned.toString(),
                            ),
                          );
                          labels.add(
                            Label(
                              key: state.labels?.locale.keysLost ??
                                  state.labels?.defaultLocale.keysLost ??
                                  Constants.keysLost,
                              value: state.items[index].lost.toString(),
                            ),
                          );
                          labels.add(
                            Label(
                              key: state.labels?.locale.keysDamaged ??
                                  state.labels?.defaultLocale.keysDamaged ??
                                  Constants.keysDamaged,
                              value: state.items[index].damaged.toString(),
                            ),
                          );
                          return
                              // index >= state.items.length
                              //   ? const BaseLoader()
                              Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        // Color(0xFF6474C6),
                                        // Color(0xFF6474C6),
                                        Colors.transparent,
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 18, sigmaY: 18),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white.withValues(
                                                        alpha: 0.09),
                                                    Colors.transparent,
                                                    Colors.white.withValues(
                                                        alpha: 0.09),
                                                    // Color(0xFF6474C6).withOpacity(0.14)
                                                  ],
                                                  stops: const [0.02, 0.35, 1],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(27),
                                                border: Border.all(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.6),
                                                  width: 0.7,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white
                                                        .withValues(alpha: 0.0),
                                                    blurRadius: 12,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              // index >= state.list.length
                                              //   ? null
                                              child: BaseListTileItem(
                                                id: state.items[index].id,
                                                labels: labels,
                                                isKeyManagementIssuanceStatus:
                                                    true,
                                                onTap: (selectedIndex) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                        dialogContext) {
                                                      return BasePopUpItems(
                                                        id: state
                                                            .items[
                                                                selectedIndex]
                                                            .id
                                                            .toString(),
                                                        labels: labels,
                                                      );
                                                    },
                                                  );
                                                },
                                                showEditButton:
                                                    !showNonEditIcon,
                                                // onEditTap:
                                                //     (selectedIndex) async {
                                                //   KeyIssuanceProcessRecord
                                                //       keyIssuanceProcessModel =
                                                //       await KeyManagementIssuanceServices()
                                                //           .getIssuanceProcessById(
                                                //               state.items[index]
                                                //                       .id ??
                                                //                   0);
                                                //
                                                //   /// Get Key Description
                                                //   bool isMasterKey =
                                                //       keyIssuanceProcessModel
                                                //                   .kmId ==
                                                //               1
                                                //           ? true
                                                //           : false;
                                                //   Organisation
                                                //       selectedKeyDescription =
                                                //       await KeyManagementIssuanceServices()
                                                //           .getKeyDescById(
                                                //               id: keyIssuanceProcessModel
                                                //                   .kmId!,
                                                //               isMasterKey:
                                                //                   isMasterKey);
                                                //
                                                //   List<Organisation>
                                                //       keyDescriptions =
                                                //       await KeyManagementIssuanceServices()
                                                //           .getKeyDescriptions(
                                                //     locationId:
                                                //         widget.locationId,
                                                //     isMasterKey: isMasterKey,
                                                //     kmIssuanceId:
                                                //         widget.parentId,
                                                //   );
                                                //
                                                //   log('--state.keyDescriptions--onEditTap--${state.keyDescriptions?.length}---');
                                                //
                                                //   showAddKeyIssuanceProcessPopUp(
                                                //       context: context,
                                                //       keyIssuanceProcessRecord:
                                                //           keyIssuanceProcessModel,
                                                //       keyDescriptions:
                                                //           keyDescriptions,
                                                //       selectedKeyDescription:
                                                //           selectedKeyDescription,
                                                //       parentStatus:
                                                //           widget.parentStatus,
                                                //       lock: widget.lock,
                                                //       state: state);
                                                // },
                                                onEditTap: (selectedIndex) async {
                                                  showLoadingDialog(context);

                                                  try {
                                                    final KeyIssuanceProcessRecord keyIssuanceProcessModel =
                                                    await KeyManagementIssuanceServices()
                                                        .getIssuanceProcessById(
                                                      state.items[selectedIndex].id ?? 0,
                                                    );

                                                    bool isMasterKey =
                                                        keyIssuanceProcessModel.kmId == 1;

                                                    Organisation selectedKeyDescription =
                                                    await KeyManagementIssuanceServices().getKeyDescById(
                                                      id: keyIssuanceProcessModel.kmId!,
                                                      isMasterKey: isMasterKey,
                                                    );

                                                    List<Organisation> keyDescriptions =
                                                    await KeyManagementIssuanceServices().getKeyDescriptions(
                                                      locationId: widget.locationId,
                                                      isMasterKey: isMasterKey,
                                                      kmIssuanceId: widget.parentId,
                                                    );

                                                    if (!mounted) return;

                                                    dismissLoadingDialog(context);

                                                    showAddKeyIssuanceProcessPopUp(
                                                      context: context,
                                                      keyIssuanceProcessRecord: keyIssuanceProcessModel,
                                                      keyDescriptions: keyDescriptions,
                                                      selectedKeyDescription: selectedKeyDescription,
                                                      parentStatus: widget.parentStatus,
                                                      lock: widget.lock,
                                                      state: state,
                                                    );
                                                  } catch (e) {
                                                    if (mounted) {
                                                      dismissLoadingDialog(context);
                                                    }

                                                    log('Error while loading edit data: $e');
                                                  }
                                                },
                                                showViewButton:
                                                    showIcons ? true : false,
                                                onViewTap: (selectedIndex) {
                                                  getById(
                                                      state.extraProperties
                                                              ?.hasWritePermission ??
                                                          false,
                                                      state.items[index].kmId);
                                                },
                                                showLinkOffButton:
                                                    showIcons ? true : false,
                                                onLinkOffTap:
                                                    (selectedIndex) async {
                                                  if (state.items[selectedIndex]
                                                          .lost ==
                                                      0) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Dialog(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          elevation: 0,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child:
                                                                BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX:
                                                                          12,
                                                                      sigmaY:
                                                                          12),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        20),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withValues(
                                                                          alpha:
                                                                              0.12),
                                                                  // glass layer
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white
                                                                        .withValues(
                                                                            alpha:
                                                                                0.35),
                                                                    // glass border
                                                                    width: 1.3,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    const Text(
                                                                      Constants
                                                                          .valueNotAccepted,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            12),
                                                                    const Text(
                                                                      Constants
                                                                          .enteredKeyLostValueNotAccepted,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white70,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            20),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        Constants
                                                                            .ok,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                        //   AlertDialog(
                                                        //   title: const Text(
                                                        //       Constants.valueNotAccepted),
                                                        //   content: const Text(Constants
                                                        //       .enteredKeyLostValueNotAccepted),
                                                        //   actions: <Widget>[
                                                        //     TextButton(
                                                        //       child: const Text(Constants.ok),
                                                        //       onPressed: () {
                                                        //         Navigator.of(context).pop();
                                                        //       },
                                                        //     ),
                                                        //   ],
                                                        // );
                                                      },
                                                    );
                                                  } else {
                                                    getKeyHistoryById(
                                                      state.extraProperties
                                                              ?.hasWritePermission ??
                                                          false,
                                                      state.isEligibleToEdit,
                                                      state.items[index].kmId,
                                                      widget.parentId,
                                                      state.items[selectedIndex]
                                                          .id,
                                                      Constants.keyLostHistory,
                                                      ConstantsIntValue
                                                          .keyLostHistoryInt,
                                                      keyIssuanceProcessModel:
                                                          state.items[index],
                                                    );
                                                  }
                                                },
                                                showDeleteButton:
                                                    showIcons ? true : false,
                                                onDeleteTap:
                                                    (selectedIndex) async {
                                                  if (state.items[selectedIndex]
                                                          .damaged ==
                                                      0) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Dialog(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          elevation: 0,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child:
                                                                BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX:
                                                                          12,
                                                                      sigmaY:
                                                                          12),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        20),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withValues(
                                                                          alpha:
                                                                              0.12),
                                                                  // glass layer
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white
                                                                        .withValues(
                                                                            alpha:
                                                                                0.35),
                                                                    // glass border
                                                                    width: 1.3,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    const Text(
                                                                      Constants
                                                                          .valueNotAccepted,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            12),
                                                                    const Text(
                                                                      Constants
                                                                          .enteredKeyDamageValueNotAccepted,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white70,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            20),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        Constants
                                                                            .ok,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                        //   AlertDialog(
                                                        //   title: const Text(
                                                        //       Constants.valueNotAccepted),
                                                        //   content: const Text(Constants
                                                        //       .enteredKeyDamageValueNotAccepted),
                                                        //   actions: <Widget>[
                                                        //     TextButton(
                                                        //       child: const Text(Constants.ok),
                                                        //       onPressed: () {
                                                        //         Navigator.of(context).pop();
                                                        //       },
                                                        //     ),
                                                        //   ],
                                                        // );
                                                      },
                                                    );
                                                  } else {
                                                    getKeyHistoryById(
                                                      state.extraProperties
                                                              ?.hasWritePermission ??
                                                          false,
                                                      state.isEligibleToEdit,
                                                      state.items[index].kmId,
                                                      widget.parentId,
                                                      state.items[selectedIndex]
                                                          .id,
                                                      Constants
                                                          .keyDamageHistory,
                                                      ConstantsIntValue
                                                          .keyDamageHistoryInt,
                                                      keyIssuanceProcessModel:
                                                          state.items[index],
                                                    );
                                                  }
                                                },
                                                index: index,
                                              )))));
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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

  getKeyHistoryById(
    bool hasWritePermission,
    bool? isEligibleToEdit,
    int? kmId,
    int? keyIssuanceId,
    int? id,
    String? title,
    int? type, {
    required KeyIssuanceProcessRecord keyIssuanceProcessModel,
  }) async {
    showLoadingDialog(context);

    KeyHistoryModel keyHistoryModel =
        await KeyManagementIssuanceServices().getIssuanceKHById(
      kmId!,
      keyIssuanceId!,
      type!,
    );

    editKeyHistoryDataLoading(
      kmId,
      keyHistoryModel,
      hasWritePermission,
      isEligibleToEdit,
      id,
      keyIssuanceId,
      title,
      type,
      keyIssuanceProcessModel: keyIssuanceProcessModel,
    );
  }

  Future<void> editKeyHistoryDataLoading(
    int kmId,
    KeyHistoryModel? keyHistoryModel,
    bool hasWritePermission,
    bool? isEligibleToEdit,
    int? id,
    int? keyIssuanceId,
    String? title,
    int? type, {
    required KeyIssuanceProcessRecord keyIssuanceProcessModel,
  }) async {
    dismissLoadingDialog(context);

    if (keyHistoryModel?.id != null) {
      Navigator.pushNamed(
        context,
        keyHistoryRecordsDetailsRoute,
        arguments: {
          "keyLossGi": KeyHistoryModel,
          ConstantsArgument.title: title,
          ConstantsArgument.id: keyHistoryModel?.kmId,
          ConstantsArgument.model: keyHistoryModel,
          ConstantsArgument.keyIssuanceId: keyIssuanceId,
          ConstantsArgument.keyLostType: type,
          ConstantsArgument.keyType: keyIssuanceProcessModel.keyType,
          ConstantsArgument.extraProperties: ExtraProperties(
            hasWritePermission: hasWritePermission,
          ),
          ConstantsArgument.isEligibleToEdit: isEligibleToEdit,
          ConstantsArgument.locationId: widget.locationId,
          ConstantsArgument.parentStatus: widget.parentStatus,
        },
      );
    } else {
      /// For creating the record for the first time
      Navigator.pushNamed(
        context,
        keyHistoryRecordsDetailsRoute,
        arguments: {
          ConstantsArgument.title: title,
          ConstantsArgument.id: kmId,
          ConstantsArgument.kipId: id,
          ConstantsArgument.keyIssuanceId: keyIssuanceId,
          ConstantsArgument.keyLostType: type,
          ConstantsArgument.keyType: keyIssuanceProcessModel.keyType,
          ConstantsArgument.isEligibleToEdit: isEligibleToEdit,
          ConstantsArgument.locationId: widget.locationId,
          ConstantsArgument.parentStatus: widget.parentStatus,
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
    required KeyIssuanceProcessRecordState state,
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

            BlocProvider.of<KeyIssuanceProcessRecordBloc>(this.context).add(
              SaveRecord(
                model,
                widget.parentId,
              ),
            );

            log('-state.status-NAV-${state.status}----');
          },
        );
      },
    );
  }
}
