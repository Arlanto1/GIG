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
import 'package:db_atom/src/features/contact_details/contact_listing/views/add_contact_pop_up.dart';
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rate_details/pay_rates/cubits/pay_rate_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enums/form_status.dart';
import '../../models/contact_info.dart';
import '../bloc/contact_listing_bloc.dart';

class ContactListingView extends StatefulWidget {
  const ContactListingView({
    super.key,
    required this.id,
    required this.title,
    required this.type,
  });

  final int id;
  final String title;
  final int type;

  @override
  State<ContactListingView> createState() => _ContactListingViewState();
}

class _ContactListingViewState extends State<ContactListingView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<ContactListingBloc>().add(
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
      context.read<ContactListingBloc>().add(FetchData(
          id: widget.id, type: widget.type, startPos: pageNumber, maxPos: 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactListingBloc, ContactListingState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: Flutterfloatingbutton(
          backgroundColor: AppColors.navigationSkybluecolor,
          foregroundColor: AppColors.backgroundWhitecolor,
          onPressed: () {
            showAddContactPopUp(
              context: context,
              contact: ContactInfo(),
              users: state.users ?? [],
            );
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.contactDetails,
          showPopUp: true,
          showSaveButton: false,
          excelAPIName: 'exportMMExcel',
          pdfAPIName: 'exportMMPDF',
        ),
        body: getBody(state),
      );
    });
  }

  getBody(ContactListingState state) {
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
            labels.add(
              Label(
                key: 'Email',
                value: state.items![index].email ?? '',
              ),
            );
            labels.add(
              Label(
                key: 'Rank',
                value: state.items![index].generalRank?.name ?? '',
              ),
            );
            labels.add(
              Label(
                key: 'Contact No',
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
                      ContactInfo contactsModel = await ContactDetailsServices()
                          .getCdById(state.items?[index].id ?? 0);

                      log('--state.users--llen--${state.users?.length}---');

                      showAddContactPopUp(
                        context: context,
                        contact: contactsModel,
                        users: state.users ?? [],
                      );
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
                    onDeleteTap: (selectedIndex) async {
                      // Call Delete API
                      BlocProvider.of<ContactListingBloc>(context)
                          .add(DeleteRecord(state.items![selectedIndex].id!.toInt(), widget.type, widget.id));
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
    required ContactInfo contact,
    required final List<BaseUser> users,
  }) {
    log('--.users--llen--${users.length}---');
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddContactPopUp(
          title: widget.title,
          contact: contact,
          mainContext: context,
          users: users,
          onSubmit: (PayRate payRate) {
            //loginFormKey.currentState!.validate();
            FocusScope.of(context).unfocus();

            log('-widget.title---${widget.title}----');

            log('--newPayRate--total---${payRate.total}------------');
            log('--newPayRate--2222--33333--rankid-${payRate.rankId}------------');

            BlocProvider.of<PayRateCubit>(context)
                .onSave(isSubmit: false, newPayRate: payRate);
          },
        );
      },
    );
  }

  getDetails(int id) async {
    showLoadingDialog(context);

    ContactInfo contactsModel = await ContactDetailsServices().getCdById(id);

    editDataLoading(contactsModel);
  }

  void editDataLoading(ContactInfo? model) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        contactDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.contactDetails,
        },
      );
    }
  }
}
