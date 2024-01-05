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
    required this.id,
    required this.title,
    this.model,
  });

  final int id;
  final String title;
  final KeyIssuanceProcessRecord? model;

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
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<KeyIssuanceProcessRecordBloc>().add(
          const InitializeValues(),
        );
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
          .read<KeyIssuanceProcessRecordBloc>()
          .add(FetchData(id: widget.id, startPos: pageNumber, maxPos: 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KeyIssuanceProcessRecordBloc,
        KeyIssuanceProcessRecordState>(listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: Flutterfloatingbutton(
          backgroundColor: AppColors.navigationSkybluecolor,
          foregroundColor: AppColors.backgroundWhitecolor,
          onPressed: () {
            log('--state.users--llen-fff-${state.violationDescriptions?.length}---');

            showAddKeyIssuanceProcessPopUp(
              context: context,
              keyIssuanceProcessRecord: KeyIssuanceProcessRecord(
                id: widget.id,
              ),
              users: state.violationDescriptions ?? [],
              getKeyDescriptionValues:
                  state.getKeyDescriptionValues ?? <String, int>{},
            );
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.keyIssuanceProcess,
          showPopUp: true,
          showSaveButton: false,
          excelAPIName: 'exportMMExcel',
          pdfAPIName: 'exportMMPDF',
          showSubmitButton: false,
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
                      KeyIssuanceProcessRecord KeyIssuanceProcessModel =
                          await KeyManagementIssuanceServices()
                              .getIssuanceProcessById(
                                  state.items?[index].id ?? 0);

                      log('--state.users--llen--${state.violationDescriptions?.length}---');

                      showAddKeyIssuanceProcessPopUp(
                        context: context,
                        keyIssuanceProcessRecord: KeyIssuanceProcessModel,
                        users: state.violationDescriptions ?? [],
                        getKeyDescriptionValues:
                            state.getKeyDescriptionValues ?? <String, int>{},
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
                              widget.id));
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
    required final List<Organisation> users,
    required final Map<String, dynamic> getKeyDescriptionValues,
  }) {
    log('--.users-1111-llen--${users.length}---');
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddKeyIssuanceProcessPopUp(
          title: widget.title,
          model: keyIssuanceProcessRecord,
          mainContext: context,
          users: users,
          getKeyDescriptionValues: getKeyDescriptionValues,
          onSubmit: (KeyIssuanceProcessRecord model) {
            //loginFormKey.currentState!.validate();
            FocusScope.of(context).unfocus();

            log('-widget.title---${widget.title}----');

            BlocProvider.of<KeyIssuanceProcessRecordBloc>(context).add(
              SaveRecord(
                model,
                widget.id,
              ),
            );
          },
        );
      },
    );
  }
}
