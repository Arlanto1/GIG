import 'package:db_atom/src/features/law_enforcement_list/bloc/law_enforcement_bloc.dart';
import 'package:db_atom/src/features/law_enforcement_list/controllers/law_enforcement_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common_widgets/app_bar.dart';
import '../../../common_widgets/cubits.dart';
import '../../../common_widgets/custom_pop_menu.dart';
import '../../../common_widgets/floating_button.dart';
import '../../../common_widgets/image_download.dart';
import '../../../common_widgets/progress_indicators/custom_circular_progress_indicator.dart';
import '../../../common_widgets/spinnerdialog.dart';
import '../../../constants/app_icon.dart';
import '../../../constants/ui_geometry_constants.dart';
import '../../../routing/router.dart';
import '../../../utils/app_themes/colors/app_color.dart';
import '../../../utils/shared_preferences.dart';
import '../models/law_enforcement_details.dart';
import 'law_enforcement_list_item.dart';
import 'le_custom_list_pop_up.dart';

class LnListPageList extends StatelessWidget {
  const LnListPageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LawEnforcementBloc>(
      create: (_) => LawEnforcementBloc()
        ..add( LawEnforcementFetch(startPos: 0, maxPos: 20,cont: context)),
      child: const LnPage(),
    );
  }
}

class LnPage extends StatefulWidget {
  const LnPage({super.key});

  @override
  State<LnPage> createState() => _LnPageState();
}

class _LnPageState extends State<LnPage> {
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
          .read<LawEnforcementBloc>()
          .add(LawEnforcementFetch(startPos: pageNumber, maxPos: 20,cont: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LawEnforcementBloc>(context);
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      floatingActionButton: Flutterfloatingbutton(
        backgroundColor: AppColors.navigationSkybluecolor,
        foregroundColor: AppColors.backgroundWhitecolor,
        onPressed: () {
         // Navigator.pushNamed(context, lawenforcementScreenRoute);
          Navigator.pushNamed(context, lawenforcementScreenRoute).then((value) async {
            if(value != null && value == true)
            {
              print(value);
              //localfoundlist?.clear();
              pageNumber = 0;
          bloc.add( LawEnforcementFetch(startPos: 0, maxPos: 20,cont: context));

            }
          });
        },
      ),
      appBar: AppHeader(
        isTitleCenter: false,
        title: 'LawEnforcement List',
        backBtn: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppIcon.backIcon,
              color: AppColors.backgroundWhitecolor),
        ),
        action: [
          CustomPopmenu(
            //itemList :[],
            itemList: const [
              PopMenuItems("Export Excel", AppIcon.exportexcel),
              PopMenuItems("Export PDF", AppIcon.exportpdf),
              //PopMenuItems("Export XML", AppIcon.exportxml),
              PopMenuItems("Close", AppIcon.close),
            ],
            itemTap: (value) async {
              String userid = await SharedPrefs.getUserId();
              print(value);
              if (value == 0) {
                DownloadImage().exportExcel(
                    context, int.parse(userid), 'export.xslx', 0, 20,'/exportLEOExcel');
              } else if (value == 1) {
                DownloadImage()
                    .exportPdf(context, int.parse(userid), 'export.pdf', 0, 20, '/exportLEOPDF');
              }
            },
            popupimagename: AppIcon.morewhiteicon,
          ),
        ],
      ),
      body: BlocBuilder<LawEnforcementBloc, LawEnforcementState>(
          builder: (context, state) {
        if (state.status == LawEnforcementListStateType.initial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == LawEnforcementListStateType.success) {}
        return Container(
          margin: allMargin16,
          decoration: const ShapeDecoration(
              color: AppColors.backgroundWhitecolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
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
                  : LawEnforcementListItem(
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
                      oneditTap: (selectedIndex) {
                        getLawEnforcementId(state.lawEnforceItems[index].id ?? 0);
                      },
                      onviewTap: (selectedIndex) {
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
      }),
    );
  }

  getLawEnforcementId(int lawEnforcementId) async {
    showLoadingDialog(context);
    LawEnforcementDetails? foundArticleDetailsResponse =
        await lawEnforcementListCubit.getLawEnforcementById(lawEnforcementId, context);

    editDataLoading(foundArticleDetailsResponse);
  }
  void editDataLoading( LawEnforcementDetails? foundArticleDetailsResponse)
  {
    dismissLoadingDialog(context);
    if (foundArticleDetailsResponse != null)
     {
    Navigator.pushNamed(context, lawenforcementScreenRoute,arguments:{"UserElement" : foundArticleDetailsResponse}  );
     }
  }
}
