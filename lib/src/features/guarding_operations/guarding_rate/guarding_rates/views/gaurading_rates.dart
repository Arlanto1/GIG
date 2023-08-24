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
import 'package:db_atom/src/features/guarding_operations/guarding_rate/services/guarding_services.dart';
import 'package:db_atom/src/features/law_enforcement_list/controllers/law_enforcement_list_state.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/guarding_rates_bloc.dart';

class GuardingRates extends StatefulWidget {
  const GuardingRates({
    super.key,
  });

  @override
  State<GuardingRates> createState() => _GuardingRatesState();
}

class _GuardingRatesState extends State<GuardingRates> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
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
      context
          .read<GuardingRatesBloc>()
          .add(FetchList(startPos: pageNumber, maxPos: 20));
    }
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
              "gmRate": GMRate(),
            })
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.guardingRates,
          showPopUp: true,
          showSaveButton: false,
        ),
        body: BlocBuilder<GuardingRatesBloc, GuardingRatesState>(
            builder: (context, state) {
          if (state.status == LawEnforcementListStateType.initial) {
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
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.items.length
                  : state.items.length + 1,
              itemBuilder: (context, index) {

                log('-state.items.length---${state.items.length}--');

                return index >= state.items.length
                    ? const Center(
                        child: CustomCircularProgressIndicator(),
                      )
                    : BaseListTileItem(
                        id: state.items[index].id,
                        inputDate: state.items[index].inputDate,
                        location: state.items[index].location,
                        locationRegion: state.items[index].locationRegion,
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
                          getId(state.items[index].id ?? 0);
                        },
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.items[selectedIndex].id.toString(),
                                inputDate: state.items[selectedIndex].inputDate,
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
                                slNo: state.items[selectedIndex].slNo,
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

  getId(int id) async {
    showLoadingDialog(context);

    GMRate response = await GuardingServices().getRate(id);

    editDataLoading(response);
  }

  void editDataLoading(GMRate? rate) {
    dismissLoadingDialog(context);
    if (rate != null) {
      Navigator.pushNamed(context, guardingRateDetailsRoute, arguments: {
        "title": Constants.createGuardingRatingCards,
        "gmRate" : rate,
      });
    }
  }
}
