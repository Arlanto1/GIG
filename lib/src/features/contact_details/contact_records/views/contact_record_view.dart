import 'dart:developer';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_circular_loader.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_no_record_found_widget.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/contact_details/contact_records/views/add_contact_pop_up.dart';
import 'package:db_atom/src/features/contact_details/models/contact_details_list_response_model.dart';
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enums/form_status.dart';
import '../../models/contact_info.dart';
import '../bloc/contact_record_bloc.dart';

class ContactRecordView extends StatefulWidget {
  const ContactRecordView({
    super.key,
    required this.id,
    required this.title,
    required this.type,
    required this.rankType,
    this.model,
  });

  final int id;
  final String title;
  final int type;
  final String rankType;
  final ContactDetailModel? model;

  @override
  State<ContactRecordView> createState() => _ContactRecordViewState();
}

class _ContactRecordViewState extends State<ContactRecordView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    context.read<ContactRecordBloc>().add(
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
      context.read<ContactRecordBloc>().add(FetchData(
          id: widget.id, type: widget.type, startPos: pageNumber, maxPos: 20));
    }
  }

  bool isPopUpShown = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactRecordBloc, ContactRecordState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: widget.model?.status ==0 ||widget.model?.status ==1 ?Flutterfloatingbutton(
          backgroundColor: AppColors.navigationSkybluecolor,
          foregroundColor: AppColors.backgroundWhitecolor,
          onPressed: () {
            showAddContactPopUp(
                context: context,
                contact: ContactRecord(
                  contactId: widget.id,
                  email: '',
                  contactNo: '',
                  rank: Organisation(),
                  type: widget.type,
                ),
                users: state.ranks,
                rankType: widget.rankType);
          },
        ): const SizedBox(),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.escalationMatrix,
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

  getBody(ContactRecordState state) {
    if (state.status == FormStatus.initial ||
        state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.items.isEmptyOrNull && !isPopUpShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isPopUpShown = true;
        showAddContactPopUp(
            context: context,
            contact: ContactRecord(
              contactId: widget.id,
              email: '',
              contactNo: '',
              rank: Organisation(),
              type: widget.type,
            ),
            users: state.ranks,
            rankType: widget.rankType);
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
            labels.add(
              Label(
                key:  widget.rankType ==
                    Constants.contactZone
                    ? Constants.zone
                    : widget.rankType ==
                    Constants.contactGeneralRank
                    ? Constants.rank
                    : widget.rankType ==
                    Constants
                        .contactSystemEscalationRank
                    ?Constants.systemSiEscalationMatrixRank
                    : widget.rankType ==
                    Constants
                        .contactSupervisorRank
                    ? Constants.supervisorRank
                    : Constants.guardingAgencyRank,
                value: state.items![index].rank?.name ?? '',
              ),
            );
            labels.add(
              Label(
                key:  widget.rankType ==
                    Constants.contactZone
                    ? Constants.areaNameManager :Constants.name,
                value: state.items![index].email ?? '',
              ),
            );
            labels.add(
              Label(
                key: Constants.phoneNumber,
                value: state.items![index].contactNo ?? '',
              ),
            );
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
                      ContactRecord contactsModel =
                          await ContactDetailsServices()
                              .getCdById(state.items?[index].id ?? 0);

                      log('--state.users--llen--${state.ranks.length}---');

                      showAddContactPopUp(
                          context: context,
                          contact: contactsModel,
                          users: state.ranks,
                          rankType: widget.rankType);
                      // getDetails(state.items?[index].id ?? 0);
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
                showDeleteButton: widget.model?.status ==0 || widget.model?.status ==1,
                    onDeleteTap: (selectedIndex) async {
                      // Call Delete API
                      BlocProvider.of<ContactRecordBloc>(context).add(
                          DeleteRecord(state.items![selectedIndex].id!.toInt(),
                              widget.type, widget.id));
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
    required ContactRecord contact,
    required final List<Organisation> users,
    required String rankType,
  }) {
    log('--.users--llen--${users.length}---');
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddContactPopUp(
          title: widget.title,
          model: contact,
          mainContext: context,
          users: users,
          rankType: rankType,
          onSubmit: (ContactRecord model) {
            //loginFormKey.currentState!.validate();
            FocusScope.of(context).unfocus();

            log('-widget.title---${widget.title}----');

            BlocProvider.of<ContactRecordBloc>(context)
                .add(SaveRecord(model, widget.id, widget.type));
          },
        );
      },
    );
  }

  getDetails(int id) async {
    showLoadingDialog(context);

    ContactRecord contactsModel = await ContactDetailsServices().getCdById(id);

    editDataLoading(contactsModel);
  }

  void editDataLoading(ContactRecord? model) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        contactDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.escalationMatrix,
        },
      );
    }
  }
}
