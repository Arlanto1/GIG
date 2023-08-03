import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/features/material_movement_list/bloc/inward_bloc.dart';
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
import '../../law_enforcement_list/views/law_enforcement_list_item.dart';
import '../../law_enforcement_list/views/le_custom_list_pop_up.dart';

class MaterialMovementInward extends StatefulWidget {
  const MaterialMovementInward({super.key});

  @override
  State<MaterialMovementInward> createState() => _MaterialMovementInwardState();
}

class _MaterialMovementInwardState extends State<MaterialMovementInward> {
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
                  ? state.lawEnforceItems.length
                  : state.lawEnforceItems.length + 1,
              itemBuilder: (context, index) {
                // buildTodo(context, state, index);

                return index >= state.lawEnforceItems.length
                    ? const Center(
                        child: CustomCircularProgressIndicator(),
                      )
                    : BaseListTileItem(
                        userItem: state.lawEnforceItems[index],
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return LawEnforcementCustomPopUpList(
                                  state.lawEnforceItems[index]);
                            },
                          );
                          //do the detail edit of user found
                        },
                        onEditTap: (selectedIndex) {
                          getLawEnforcementId(
                              state.lawEnforceItems[index].id ?? 0);
                        },
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return LawEnforcementCustomPopUpList(
                                  state.lawEnforceItems[selectedIndex]);
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
