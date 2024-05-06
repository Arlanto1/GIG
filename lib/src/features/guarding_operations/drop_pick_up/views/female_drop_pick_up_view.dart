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
import 'package:db_atom/src/features/guarding_operations/drop_pick_up/bloc/female_drop_pick_up_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../enums/form_status.dart';

class FemaleDropPickUpView extends StatefulWidget {
  const FemaleDropPickUpView({
    super.key,
  });

  @override
  State<FemaleDropPickUpView> createState() => _FemaleDropPickUpViewState();
}

class _FemaleDropPickUpViewState extends State<FemaleDropPickUpView> {
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
          .read<FemaleDropPickUpBloc>()
          .add(FetchList(startPos: pageNumber, maxPos: 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: Flutterfloatingbutton(
          backgroundColor: AppColors.navigationSkyBlueColor,
          foregroundColor: AppColors.backgroundWhiteColor,
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
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
        ),
        body: BlocBuilder<FemaleDropPickUpBloc, FemaleDropPickUpState>(
            builder: (context, state) {
          if (state.status == FormStatus.initial) {
            return const BaseLoader();
          }
          if (state.items.isEmptyOrNull) {
            return const NoRecordFoundWidget();
          }
          return Container(
            margin: allMargin16,
            decoration: const ShapeDecoration(
                color: AppColors.backgroundWhiteColor,
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
                return index >= state.items.length
                    ? const BaseLoader()
                    : BaseListTileItem(
                        id: state.items[index].id,
                        inputDate: state.items[index].inputDate.toString(),
                        // location: state.items[index].dropPickUp?.location,
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
                          getId(state.items[index].id ?? 0);
                        },
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.items[selectedIndex].id.toString(),
                                inputDate: state.items[selectedIndex].inputDate
                                    .toString(),
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

    // FemaleDropPickUp response = await GuardingServices().getRate(id);

    // editDataLoading(response);
  }

  void editDataLoading(GMRate? rate) {
    dismissLoadingDialog(context);
    if (rate != null) {
      Navigator.pushNamed(context, guardingRateDetailsRoute, arguments: {
        "title": Constants.createGuardingRatingCards,
        "gmRate": rate,
      });
    }
  }
}
