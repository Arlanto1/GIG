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
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/violation_penalty_record/views/add_violation_pop_up.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../index.dart';
import '../../../../../enums/form_status.dart';
import '../../models/violation_penalty_model.dart';
import '../bloc/violation_penalty_record_bloc.dart';

class ViolationPenaltyRecordsView extends StatefulWidget {
  const ViolationPenaltyRecordsView({
    super.key,
    required this.id,
    required this.title,
    this.model,
    this.extraProperties,
  });

  final int id;
  final String title;
  final ViolationPenaltyRecord? model;
  final ExtraProperties? extraProperties;

  @override
  State<ViolationPenaltyRecordsView> createState() => _ContactRecordViewState();
}

class _ContactRecordViewState extends State<ViolationPenaltyRecordsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<ViolationPenaltyRecordBloc>().add(
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
          .read<ViolationPenaltyRecordBloc>()
          .add(FetchData(id: widget.id, startPos: pageNumber, maxPos: 20));
    }
  }

  bool isPopUpShown = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViolationPenaltyRecordBloc,
        ViolationPenaltyRecordState>(listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: !(widget.extraProperties != null &&
            !widget.extraProperties!.hasWritePermission! )
            ? Flutterfloatingbutton(
                backgroundColor: AppColors.navigationSkybluecolor,
                foregroundColor: AppColors.backgroundWhitecolor,
                onPressed: () {
                  log('--state.users--llen-fff-${state.violationDescriptions?.length}---');

                  showAddContactPopUp(
                    context: context,
                    contact: ViolationPenaltyRecord(
                      svpId: widget.id,
                    ),
                    users: state.violationDescriptions ?? [],
                    staffCategoriesValues:
                        state.staffCategoriesValues ?? <String, int>{},
                  );
                },
              )
            : const SizedBox(),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.violationPenalty,
          showPopUp: false,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'exportMMExcel',
          pdfAPIName: 'exportMMPDF',
        ),
        body: getBody(state),
      );
    });
  }

  getBody(ViolationPenaltyRecordState state) {
    if (state.status == FormStatus.initial ||
        state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.items.isEmptyOrNull && !isPopUpShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isPopUpShown = true;
        showAddContactPopUp(
          context: context,
          contact: ViolationPenaltyRecord(
            svpId: widget.id,
          ),
          users: state.violationDescriptions ?? [],
          staffCategoriesValues: state.staffCategoriesValues ?? <String, int>{},
        );
      });
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
            labels.add(
              Label(
                key: 'Violation',
                value: state.items![index].violation?.name ?? '',
              ),
            );
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
                      ViolationPenaltyRecord contactsModel =
                          await SLAViolationPenaltyServices()
                              .getVPById(state.items?[index].id ?? 0);

                      log('--state.users--llen--${state.violationDescriptions?.length}---');

                      showAddContactPopUp(
                        context: context,
                        contact: contactsModel,
                        users: state.violationDescriptions ?? [],
                        staffCategoriesValues:
                            state.staffCategoriesValues ?? <String, int>{},
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
                      BlocProvider.of<ViolationPenaltyRecordBloc>(context).add(
                          DeleteRecord(state.items![selectedIndex].id!.toInt(),
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

  showAddContactPopUp({
    required BuildContext context,
    required ViolationPenaltyRecord contact,
    required final List<Organisation> users,
    required final Map<String, dynamic> staffCategoriesValues,
  }) {
    log('--.users-1111-llen--${users.length}---');
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddContactPopUp(
          title: widget.title,
          model: contact,
          mainContext: context,
          users: users,
          staffCategoriesValues: staffCategoriesValues,
          onSubmit: (ViolationPenaltyRecord model) {
            //loginFormKey.currentState!.validate();
            FocusScope.of(context).unfocus();

            log('-widget.title---${widget.title}----');

            BlocProvider.of<ViolationPenaltyRecordBloc>(context).add(
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
