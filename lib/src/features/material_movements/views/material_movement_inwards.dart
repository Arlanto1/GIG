import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/base_pop_up_items.dart';
import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main_DEV.dart';
import '../../../common_widgets/base_widget/base_app_bar.dart';
import '../../../common_widgets/base_widget/base_list_tile_item.dart';
import '../../../common_widgets/cubits.dart';
import '../../../common_widgets/progress_indicators/custom_circular_progress_indicator.dart';
import '../../../common_widgets/spinnerdialog.dart';
import '../../../constants/ui_geometry_constants.dart';
import '../../../routing/router.dart';
import '../../law_enforcement_list/controllers/law_enforcement_list_state.dart';
import '../../law_enforcement_list/models/law_enforcement_details.dart';
import '../bloc/inward_bloc.dart';
import '../models/material_movements_model.dart';

class MaterialMovementInwards extends StatefulWidget {
  const MaterialMovementInwards({super.key});

  @override
  State<MaterialMovementInwards> createState() => _MaterialMovementInwardsState();
}

class _MaterialMovementInwardsState extends State<MaterialMovementInwards> {
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
          .read<InwardBloc>()
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
        appBar: BaseAppBar().buildAppHeader(),
        body: BlocBuilder<InwardBloc, InwardState>(builder: (context, state) {
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
                // buildTodo(context, state, index);

                log('-----state.items--------${state.items}-------');
                MaterialMovementModel item = state.items[index];
                return index >= state.items.length
                    ? const Center(
                        child: CustomCircularProgressIndicator(),
                      )
                    : BaseListTileItem(
                        id: item.id,
                        inputDate: item.inputDate,
                        location: item.location,
                        locationRegion: item.locationRegion,
                        status: item.status,
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                  state.items[index]);
                            },
                          );
                          //do the detail edit of user found
                        },
                        onEditTap: (selectedIndex) {
                          getLawEnforcementId(
                              state.items[index].id ?? 0);
                        },
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return BasePopUpItems(
                                  state.items[selectedIndex]);
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

  getLawEnforcementId(int lawEnforcementId) async {
    showLoadingDialog(context);
    LawEnforcementDetails? foundArticleDetailsResponse =
        await lawEnforcementListCubit.getLawEnforcementById(
            lawEnforcementId, context);

    editDataLoading(foundArticleDetailsResponse);
  }

  void editDataLoading(LawEnforcementDetails? foundArticleDetailsResponse) {
    dismissLoadingDialog(context);
    if (foundArticleDetailsResponse != null) {
      Navigator.pushNamed(context, lawenforcementScreenRoute,
          arguments: {"UserElement": foundArticleDetailsResponse});
    }
  }
}
