import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/common_widgets/progress_indicators/custom_circular_progress_indicator.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/features/material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common_widgets/app_button.dart';
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
            title: Constants.addSecurityGuard,
            payRate: payRate,
            mainContext: context,
            onSubmit: (PayRate payRate) {
              // BlocProvider.of<PayRateCubit>(context).onSave();
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
            showAddButton: true,
            onTapAddButton: () {
              addSecurityGuardPopUp(context: context, payRate: PayRate());
            }),
        body: BlocConsumer<PayRateCubit, PayRateState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state.status == FormStatus.loading) {
              String title = '';
              List<PayRate> payRates = [];
              switch (widget.title) {
                case Constants.createSecurityGuard:
                  title = Constants.createSecuritySupervisor;
                  payRates = state.rate.securitySupervisorRates ?? [];
                  break;

                case Constants.createSecuritySupervisor:
                  title = Constants.createSecurityOfficer;
                  payRates = state.rate.securityOfficerRates ?? [];
                  break;

                case Constants.createSecurityOfficer:
                  title = Constants.createSecurityFacilitator;
                  payRates = state.rate.securityFacilitatorRates ?? [];
                  break;

                case Constants.createSecurityFacilitator:
                  title = Constants.createGunMan;
                  payRates = state.rate.securityGunManRates ?? [];
                  break;

                default:
                  break;
              }
              Navigator.pushReplacementNamed(
                context,
                payRateRoute,
                arguments: {
                  "payRates": payRates,
                  "gmRate": state.rate,
                  "title": title,
                },
              );
            }
          },
          builder: (context, state) {
            if (state.status == FormStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.items.isEmpty) {
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
                          key: 'Days', value: '${state.items[index].days}'));
                      labels.add(Label(
                          key: 'Per Hour',
                          value: '${state.items[index].perHour}'));

                      log('-${state.items.length}----lenth---');

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
                                      id: state.items[selectedIndex].id
                                          .toString(),
                                      labels: labels,
                                    );
                                  },
                                );
                              },
                              onEditTap: (selectedIndex) {
                                log('---payRate- onedit-- ${state.items[index].id}-----');
                                log('---payRate- onedit-- ${state.items[index].total}-----');

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
                        cancelButtonDisplay(),
                        const SizedBox(
                          width: 50,
                        ),
                        submitButtonDisplay(onTap: () {
                          log('-onTapSubmit--${state.rate.vendor?.name}----');
                          FocusScope.of(context).unfocus();
                          // BlocProvider.of<PayRateCubit>(context).onSave(
                          //   isSubmit: false,
                          // );

                          BlocProvider.of<PayRateCubit>(context).onSave(
                              isSubmit: false, newPayRate: state.newPayRate);

                          String title = '';
                          List<PayRate> payRates = [];
                          switch (widget.title) {
                            case Constants.createSecurityGuard:
                              title = Constants.createSecuritySupervisor;
                              payRates =
                                  state.rate.securitySupervisorRates ?? [];
                              break;

                            case Constants.createSecuritySupervisor:
                              title = Constants.createSecurityOfficer;
                              payRates = state.rate.securityOfficerRates ?? [];
                              break;

                            case Constants.createSecurityOfficer:
                              title = Constants.createSecurityFacilitator;
                              payRates =
                                  state.rate.securityFacilitatorRates ?? [];
                              break;

                            case Constants.createSecurityFacilitator:
                              title = Constants.createGunMan;
                              payRates = state.rate.securityGunManRates ?? [];
                              break;

                            default:
                              break;
                          }
                          Navigator.pushReplacementNamed(
                            context,
                            payRateRoute,
                            arguments: {
                              "payRates": payRates,
                              "gmRate": state.rate,
                              "title": title,
                            },
                          );
                        }),
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
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget submitButtonDisplay({required Function onTap}) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.next,
      buttonTextKey: Keys.submitButton,
      onTap: onTap,
    );
  }
}
