import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/common_widgets/progress_indicators/custom_circular_progress_indicator.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/contact_details/contact_listing/views/add_contact_pop_up.dart';
import 'package:db_atom/src/features/contact_details/models/contact_details_list_response_model.dart';
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rate_details/pay_rates/cubits/pay_rate_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enums/form_status.dart';
import '../../../../utils/util.dart';
import '../bloc/contact_listing_bloc.dart';

class ContactListingView extends StatefulWidget {
  const ContactListingView({
    super.key,
    required this.title,
  });

  final String title;

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
      context.read<ContactListingBloc>().add(
            FetchData(startPos: pageNumber, maxPos: 20),
          );
    }
  }

  showAddContactPopUp({
    required BuildContext context,
    required PayRate payRate,
    required final List<BaseUser> users,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddContactPopUp(
          title: widget.title,
          payRate: payRate,
          mainContext: context,
          users: users,
          onSubmit: (PayRate payRate) {
            //loginFormKey.currentState!.validate();
            FocusScope.of(context).unfocus();

            log('-widget.title---${widget.title}----');

            switch (widget.title) {
              case Constants.createSecurityGuard:
                payRate.rankId = 1;
                break;

              case Constants.createSecuritySupervisor:
                payRate.rankId = 3;
                break;

              case Constants.createSecurityOfficer:
                payRate.rankId = 2;
                break;

              case Constants.createSecurityFacilitator:
                payRate.rankId = 4;
                break;

              default:
                payRate.rankId = 5;
                break;
            }

            log('--newPayRate--total---${payRate.total}------------');
            log('--newPayRate--2222--33333--rankid-${payRate.rankId}------------');

            BlocProvider.of<PayRateCubit>(context)
                .onSave(isSubmit: false, newPayRate: payRate);
          },
        );
      },
    );
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
              payRate: PayRate(),
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
    log('---users---state-${state.users?.length}--');
    if (state.status == FormStatus.initial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
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
            state.hasReachedMax ? state.items.length : state.items.length + 1,
        itemBuilder: (context, index) {
          List<Label> labels = [];
          if (index < state.items.length) {
            labels.add(Label(
                key: 'Rank',
                value: state.items[index].locationRegion?.name ?? ''));
            labels.add(Label(
                key: 'Name',
                value: state.items[index].location?.name ?? ''));
            labels.add(Label(
                key: 'Phone Number',
                value: state.items[index].locationRegion?.name ?? ''));
          }
          return index >= state.items.length
              ? const Center(
                  child: CustomCircularProgressIndicator(),
                )
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
                  onEditTap: (selectedIndex) {
                    getLawEnforcementId(state.items[index].id ?? 0);
                  },
                  onViewTap: (selectedIndex) {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return BasePopUpItems(
                          id: state.items[selectedIndex].id.toString(),
                          labels: labels,
                          slNo: state.items[selectedIndex].slNo,
                          status: state.items[selectedIndex].status,
                          entrySecurityName:
                              state.items[selectedIndex].entrySecurity?.name,
                          isMasterGuard: false,
                        );
                      },
                    );
                  },
                  index: index,
                );
        },
      ),
    );
  }

  getLawEnforcementId(int id) async {
    showLoadingDialog(context);

    ContactDetailModel materialMovementModel =
        await ContactDetailsServices().getById(id);

    editDataLoading(materialMovementModel);
  }

  void editDataLoading(ContactDetailModel? model) {
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
