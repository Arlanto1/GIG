
import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/common_widgets/progress_indicators/custom_circular_progress_indicator.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/law_enforcement_list/controllers/law_enforcement_list_state.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common_widgets/floating_button.dart';
import '../../../../../common_widgets/spinnerdialog.dart';
import '../../../../../routing/router.dart';
import '../../models/guarding_master_data_model.dart';
import '../../services/guarding_master_data_services.dart';
import '../bloc/guarding_master_data_bloc.dart';

class GuardingMasterData extends StatefulWidget {
  const GuardingMasterData({
    super.key,
  });

  @override
  State<GuardingMasterData> createState() => _GuardingMasterDataState();
}

class _GuardingMasterDataState extends State<GuardingMasterData> {
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
          .read<GuardingMasterDataBloc>()
          .add(FetchDataList(startPos: pageNumber, maxPos: 20));
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
            Navigator.pushNamed(context, guardingMasterDataDetailsRoute,
                arguments: {"title": Constants.createGuardingMasterData}),
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.guardingMasterDataTitle,
          showPopUp: true,
          showSaveButton: false,
        ),
        body: BlocBuilder<GuardingMasterDataBloc, GuardingMasterDataState>(
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
                  ? state.list.length
                  : state.list.length + 1,
              itemBuilder: (context, index) {
                return index >= state.list.length
                    ? const Center(
                        child: CustomCircularProgressIndicator(),
                      )
                    : BaseListTileItem(
                        id: state.list[index].id,
                        guardRank: state.list[index].guardRank,
                         location: state.list[index].location,
                         locationRegion: state.list[index].locationRegion,
                        status: state.list[index].status,
                        isMasterGuard: true,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.list[selectedIndex].id.toString(),
                                slNo: state.list[selectedIndex].slNo,
                                guardRank: state.list[selectedIndex].guardRank,
                                gender: state.list[selectedIndex].gender,
                                dutyType: state.list[selectedIndex].dutyType,
                                maritalStatus:
                                state.list[selectedIndex].maritalStatus,
                                 location: state.list[selectedIndex].location,
                                locationRegion: state.list[selectedIndex].locationRegion,
                                isMaterGuard:true,
                                 status: state.list[selectedIndex].status,
                              );
                            },
                          );
                        },
                        onEditTap: (selectedIndex) {
                          getLawEnforcementId(state.list[index].id ?? 0);
                        },
                        showEditButton: true,
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                id: state.list[selectedIndex].id.toString(),
                                slNo: state.list[selectedIndex].slNo,
                                 locationRegion: state.list[selectedIndex].locationRegion,
                                 location: state.list[selectedIndex].location,
                                maritalStatus:
                                state.list[selectedIndex].maritalStatus,
                                guardRank: state.list[selectedIndex].guardRank,
                                gender: state.list[selectedIndex].gender,
                                dutyType: state.list[selectedIndex].dutyType,
                                isMaterGuard:true,
                                status: state.list[selectedIndex].status,
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

    GuardingMastersDataModel guardingMastersDataModel =
        await GuardingMasterDataServices().getGuardingMastersData(id);

    editDataLoading(guardingMastersDataModel);
  }

  void editDataLoading(GuardingMastersDataModel? guardingMastersDataModel) {
    dismissLoadingDialog(context);
    if (guardingMastersDataModel != null) {
      Navigator.pushNamed(context, guardingMasterDataDetailsRoute, arguments: {
        "GuardingMastersDataModel": guardingMastersDataModel,
        //"isInward": widget.isInward,
        "title": Constants.editGuardingMasterData
      });
    }
  }
}
