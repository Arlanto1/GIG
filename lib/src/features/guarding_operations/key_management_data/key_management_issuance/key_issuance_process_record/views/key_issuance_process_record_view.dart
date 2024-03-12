import 'dart:developer';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_circular_loader.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_no_record_found_widget.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/key_issuance_process_record/bloc/key_issuance_process_record_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/key_issuance_process_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/services/key_management_issuance_services.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_key_issuance_process_pop_up.dart';

class KeyIssuanceProcessRecordsView extends StatefulWidget {
  const KeyIssuanceProcessRecordsView({
    super.key,
    required this.parentId,
    required this.parentStatus,
    required this.locationId,
    required this.title,
    this.model,
    this.isMasterKey,
  });

  final int parentId;
  final int parentStatus;
  final int locationId;
  final String title;
  final KeyIssuanceProcessRecord? model;
  final bool? isMasterKey;

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
        floatingActionButton: widget.parentStatus == 0
            ? Flutterfloatingbutton(
                backgroundColor: AppColors.navigationSkybluecolor,
                foregroundColor: AppColors.backgroundWhitecolor,
                onPressed: () async {
                  log('-floatingActionButton-state.keyDescriptions--llen-fff-${state.keyDescriptions?.length}---');
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
            state.hasReachedMax ? state.items?.length : state.items!.length + 1,
        itemBuilder: (context, index) {
          List<Label> labels = [];
          if (index < state.items!.length) {
            //labels.add(
            //   Label(
            //     key: 'Email',
            //     value: state.items![index].staffCategory ?? '',
            //   ),
            // );
            // labels.add(
            //   Label(
            //     key: 'Violation',
            //     value: state.items![index].violation?.name ?? '',
            //   ),
            // );
            // labels.add(
            //   Label(
            //     key: 'Contact No',
            //     value: state.items[index].penaltyAmount??0,
            //   ),
            // );
            return index >= state.items!.length
                ? const BaseLoader()
                : BaseListTileItem(
                    id: state.items?[index].id,
                    labels: labels,
                    onTap: (selectedIndex) {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return BasePopUpItems(
                            id: state.items?[selectedIndex].id.toString(),
                            labels: labels,
                          );
                        },
                      );
                    },
                    onEditTap: (selectedIndex) async {
                      KeyIssuanceProcessRecord keyIssuanceProcessModel =
                          await KeyManagementIssuanceServices()
                              .getIssuanceProcessById(
                                  state.items?[index].id ?? 0);

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
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return BasePopUpItems(
                            id: state.items?[selectedIndex].id.toString(),
                            labels: labels,
                          );
                        },
                      );
                    },
                    onDeleteTap: (selectedIndex) async {
                      // Call Delete API
                      BlocProvider.of<KeyIssuanceProcessRecordBloc>(context)
                          .add(DeleteRecord(
                              state.items![selectedIndex].id!.toInt(),
                              widget.parentId));
                    },
                    index: index,
                  );
          }
          return null;
        },
      ),
    );
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
            FocusScope.of(context).unfocus();

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
