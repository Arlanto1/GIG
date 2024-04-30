import 'dart:developer';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_circular_loader.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common_widgets/app_button.dart';
import '../../../../../../enums/form_status.dart';
import '../../../../../../routing/router.dart';
import '../../../../../../utils/helpers/keys/keys.dart';
import '../cubits/pay_rate_cubit.dart';
import 'add_security_guard_pop_up.dart';

class PayRateView extends StatefulWidget {
  final List<PayRate> payRates;
  final GMRate? rate;
  final String title;

  const PayRateView({
    super.key,
    required this.payRates,
    required this.rate,
    required this.title,
  });

  @override
  State<PayRateView> createState() => _PayRateViewState();
}

class _PayRateViewState extends State<PayRateView> {
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  addSecurityGuardPopUp({
    required BuildContext context,
    required PayRate payRate,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AddSecurityGuardPopUp(
            title: widget.title,
            payRate: payRate,
            mainContext: context,
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: false,
            showCustomIcon: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapCustomIcon: () {
              addSecurityGuardPopUp(context: context, payRate: PayRate());
            }),
        body: BlocConsumer<PayRateCubit, PayRateState>(
          listener: (context, state) {
            Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

            if (state.status == FormStatus.loading) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state.status == FormStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.items.isEmptyOrNull) {
              return Center(
                child: AppButton(
                  width: 150,
                  backgroundColor: AppColors.navigationSkybluecolor,
                  key: const Key(Keys.cancelButton),
                  buttonText: Constants.add,
                  buttonTextKey: Keys.cancelButton,
                  onTap: () {
                    addSecurityGuardPopUp(context: context, payRate: PayRate());
                  },
                ),
              );
            }
            return Container(
              margin: allMargin16,
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhitecolor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  )),
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      /// Adding Fields to BaseListTile
                      List<Label> labels = [];
                      labels.add(Label(
                          key: 'Monthly',
                          value: '${state.items[index].total}'));
                      labels.add(Label(
                          key: 'Days',
                          value: '${state.items[index].days ?? ''}'));
                      labels.add(Label(
                          key: 'Per Hour',
                          value: '${state.items[index].perHour}'));

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
                                      isMasterGuard: false,
                                      id: state.items[selectedIndex].id
                                          .toString(),
                                      labels: labels,
                                    );
                                  },
                                );
                              },
                              onEditTap: (selectedIndex) {
                                addSecurityGuardPopUp(
                                    context: context,
                                    payRate: state.items[index]);
                              },
                              onViewTap: (selectedIndex) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return BasePopUpItems(
                                      id: state.items[selectedIndex].id
                                          .toString(),
                                      labels: labels,
                                      isMasterGuard: false,
                                    );
                                  },
                                );
                              },
                              index: index,
                            );
                    },
                  ),
                  Positioned(
                    bottom: 16.0, // Adjust the position as needed
                    right: 16.0, // Adjust the position as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.title == Constants.createOthers)
                          Row(
                            children: [
                              cancelButtonDisplay(),
                              const SizedBox(
                                width: 70,
                              ),
                            ],
                          )
                        else
                          cancelButtonDisplay(),
                        const SizedBox(
                          width: 30,
                        ),
                        Visibility(
                          visible: widget.title != Constants.createOthers,
                          // Only show the submit button for specific titles
                          child: submitButtonDisplay(
                            title: widget.title,
                            onTap: () {
                              log('-onTapSubmit--${state.model.vendor?.name}----');
                              FocusScope.of(context).unfocus();

                              String title = '';
                              List<PayRate> payRates = [];
                              switch (widget.title) {
                                case Constants.createSecuritySupervisor:
                                  title = Constants.createSecurityOfficer;
                                  payRates =
                                      state.model.securityOfficerRates ?? [];
                                  state.newPayRate.rankId = 2;
                                  break;

                                case Constants.createSecurityGuard:
                                  title = Constants.createSecuritySupervisor;
                                  payRates =
                                      state.model.securitySupervisorRates ?? [];
                                  state.newPayRate.rankId = 3;
                                  break;

                                case Constants.createSecurityOfficer:
                                  title = Constants.createSecurityFacilitator;
                                  payRates =
                                      state.model.securityFacilitatorRates ??
                                          [];
                                  state.newPayRate.rankId = 4;
                                  break;

                                case Constants.createSecurityFacilitator:
                                  log('--case ---createSecurityFacilitator-');
                                  title = Constants.createGunMan;
                                  payRates =
                                      state.model.securityGunManRates ?? [];
                                  state.newPayRate.rankId = 5;
                                  break;

                                default:
                                  title = Constants.createOthers;
                                  payRates = state.model.otherRates ?? [];
                                  state.newPayRate.rankId = 6;
                                  break;
                              }

                              if (widget.title == Constants.createOthers) {
                                BlocProvider.of<PayRateCubit>(context).onSave(
                                  isSubmit: true,
                                  // newPayRate: state.newPayRate,
                                );

                                Navigator.pushReplacementNamed(
                                  context,
                                  guardingRateDetailsRoute,
                                  arguments: {
                                    "title":
                                        Constants.createGuardingRatingCards,
                                    "gmRate": state.model,
                                  },
                                );
                                return;
                              }
                              log('--ifff-3333-');

                              Navigator.pushReplacementNamed(
                                context,
                                payRateRoute,
                                arguments: {
                                  "payRates": payRates,
                                  "gmRate": state.model,
                                  "title": title,
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      width: Constants.cancelButtonWidth,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget submitButtonDisplay({required Function onTap, required String title}) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText:
          title == Constants.createOthers ? Constants.submit : Constants.next,
      buttonTextKey: Keys.submitButton,
      onTap: onTap,
    );
  }
}
