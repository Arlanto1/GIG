import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/common_widgets/progress_indicators/custom_circular_progress_indicator.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/features/material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/services/material_movement_services.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/pay_rate_cubit.dart';
import 'add_security_guard_pop_up.dart';

class PayRateView extends StatefulWidget {
  final List<PayRate> payRates;

  const PayRateView({
    super.key,
    required this.payRates,
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
            payRate:  payRate,
            onSubmit: () {},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: Flutterfloatingbutton(
          backgroundColor: AppColors.navigationSkybluecolor,
          foregroundColor: AppColors.backgroundWhitecolor,
          onPressed: () => {
            Navigator.pushNamed(context, guardingRateDetailsRoute, arguments: {
              "title": Constants.createGuardingRatingCards,
            })
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.guardingRates,
            showPopUp: false,
            showSaveButton: false,
            showAddButton: true,
            onTapAddButton: () {
              addSecurityGuardPopUp(context: context, payRate: PayRate());
            }),
        body:
            BlocBuilder<PayRateCubit, PayRateState>(builder: (context, state) {
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
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                )),
            child: ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return index >= state.items.length
                    ? const Center(
                        child: CustomCircularProgressIndicator(),
                      )
                    : BaseListTileItem(
                        id: state.items[index].id,
                        // inputDate: state.items[index].inputDate,
                        // location: state.items[index].location,
                        // locationRegion: state.items[index].locationRegion,
                        // status: state.items[index].status,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.items[selectedIndex].id.toString(),
                              );
                            },
                          );
                        },
                        onEditTap: (selectedIndex) {
                          log('---payRate- onedit-- ${state.items[index].id}-----');
                          log('---payRate- onedit-- ${state.items[index].total}-----');

                          addSecurityGuardPopUp(
                              context: context, payRate: state.items[index]);
                        },
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.items[selectedIndex].id.toString(),
                                // inputDate: state.items[selectedIndex].inputDate,
                                // location: state.items[selectedIndex].location,
                                // returnable:
                                // state.items[selectedIndex].returnable,
                                // quantity: state.items[selectedIndex].quantity
                                //     .toString(),
                                // challanNo: state.items[selectedIndex].challanNo,
                                // locationRegion:
                                // state.items[selectedIndex].locationRegion,
                                //  securityName: state
                                //       .items[selectedIndex].entrySecurityName,
                                // slNo: state.items[selectedIndex].slNo,
                                // status: state.items[selectedIndex].status
                                //     .toString(),
                                // entrySecurityName: state
                                //     .items[selectedIndex].entrySecurityName,
                              );
                            },
                          );
                        },
                        index: index,
                      );
              },
            ),
          );
        }));
  }

  getLawEnforcementId(int id) async {
    showLoadingDialog(context);

    MaterialMovementModel materialMovementModel =
        await MaterialMovementServices().getMaterialMovement(id);

    editDataLoading(materialMovementModel);
  }

  void editDataLoading(MaterialMovementModel? materialMovementModel) {
    dismissLoadingDialog(context);
    if (materialMovementModel != null) {
      Navigator.pushNamed(context, materialMovementInwardDetailsRoute,
          arguments: {
            "model": materialMovementModel,
            "title": Constants.materialMovementOutwardEdit,
          });
    }
  }
}
