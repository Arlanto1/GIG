import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/common_widgets/progress_indicators/custom_circular_progress_indicator.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/law_enforcement_list/controllers/law_enforcement_list_state.dart';
import 'package:db_atom/src/features/material_movement/services/material_movement_services.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/inward_outward_bloc.dart';
import '../models/material_movements_model.dart';

class MaterialMovementInwardsOutwards extends StatefulWidget {
  const MaterialMovementInwardsOutwards({super.key, required this.isInward});

  final bool isInward;

  @override
  State<MaterialMovementInwardsOutwards> createState() =>
      _MaterialMovementInwardsOutwardsState();
}

class _MaterialMovementInwardsOutwardsState extends State<MaterialMovementInwardsOutwards> {
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
          .read<InwardOutwardBloc>()
          .add(InwardFetch(startPos: pageNumber, maxPos: 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: const Flutterfloatingbutton(
          backgroundColor: AppColors.navigationSkybluecolor,
          foregroundColor: AppColors.backgroundWhitecolor,
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: widget.isInward? Constants.materialMovementsInwardTitle: Constants.materialMovementsOutwardTitle,
          showPopUp: true,
          showSaveButton: false,
        ),
        body: BlocBuilder<InwardOutwardBloc, InwardOutwardState>(builder: (context, state) {
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
                return index >= state.items.length
                    ? const Center(
                        child: CustomCircularProgressIndicator(),
                      )
                    : BaseListTileItem(
                        id: state.items[index].id,
                        inputDate: state.items[index].inputDate,
                        location: state.items[index].location,
                        locationRegion: state.items[index].locationRegion,
                        status: state.items[index].status,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(state.items[index]);
                            },
                          );
                          //do the detail edit of user found
                        },
                        onEditTap: (selectedIndex) {
                          getLawEnforcementId(state.items[index].id ?? 0);
                        },
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(state.items[selectedIndex]);
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

  // TODO: Need to discuss
  // TODO: whether to use bloc or cubits
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
          arguments: {"MaterialMovementModel": materialMovementModel});
    }
  }
}
