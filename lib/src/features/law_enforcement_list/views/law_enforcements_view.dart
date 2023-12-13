import 'dart:developer';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_circular_loader.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_no_record_found_widget.dart';
import 'package:db_atom/src/features/law_enforcement_list/bloc/law_enforcement_bloc.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common_widgets/app_bar.dart';
import '../../../common_widgets/cubits.dart';
import '../../../common_widgets/custom_pop_menu.dart';
import '../../../common_widgets/floating_button.dart';
import '../../../common_widgets/image_download.dart';
import '../../../common_widgets/spinnerdialog.dart';
import '../../../constants/app_icon.dart';
import '../../../constants/ui_geometry_constants.dart';
import '../../../enums/form_status.dart';
import '../../../routing/router.dart';
import '../../../utils/app_themes/colors/app_color.dart';
import '../../../utils/shared_preferences.dart';
import '../models/law_enforcement_details.dart';
import 'law_enforcement_list_item.dart';
import 'le_custom_list_pop_up.dart';

class LawEnforcementsView extends StatelessWidget {
  const LawEnforcementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LawEnforcementBloc>(
      create: (_) => LawEnforcementBloc()
        ..add(LawEnforcementFetch(startPos: 0, maxPos: 20, cont: context)),
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
      context.read<LawEnforcementBloc>().add(
          LawEnforcementFetch(startPos: pageNumber, maxPos: 20, cont: context));
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
          Navigator.pushNamed(context, lawenforcementScreenRoute)
              .then((value) async {
            if (value != null && value == true) {
              print(value);
              //localfoundlist?.clear();
              pageNumber = 0;
              bloc.add(
                  LawEnforcementFetch(startPos: 0, maxPos: 20, cont: context));
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
              //PopMenuItems("Close", AppIcon.close),
            ],
            itemTap: (value) async {
              String userid = await SharedPrefs.getUserId();
              print(value);
              if (value == 0) {
                DownloadImage().exportExcel(context, int.parse(userid),
                    'export.xslx', 0, 20, '/exportLEOExcel');
              } else if (value == 1) {
                DownloadImage().exportPdf(context, int.parse(userid),
                    'export.pdf', 0, 20, '/exportLEOPDF');
              }
            },
            popupimagename: AppIcon.morewhiteicon,
          ),
        ],
      ),
      body: BlocBuilder<LawEnforcementBloc, LawEnforcementState>(
          builder: (context, state) {
        if (state.status == FormStatus.initial) {
          return const BaseLoader();
        } else if (state.status == FormStatus.success) {}

        if (state.items.isEmptyOrNull) {
          return const NoRecordFoundWidget();
        }

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
                ? state.items.length
                : state.items.length + 1,
            itemBuilder: (context, index) {
              // buildTodo(context, state, index);

              if (index < state.items.length) {
                return index >= state.items.length
                    ? const BaseLoader()
                    : LawEnforcementListItem(
                        userItem: state.items[index],
                        onTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return LawEnforcementCustomPopUpList(
                                  state.items[index]);
                            },
                          );
                          //do the detail edit of user found
                        },
                        onEditTap: (selectedIndex) {
                          getById(state.items[index].id ?? 0);
                        },
                        onViewTap: (selectedIndex) {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return LawEnforcementCustomPopUpList(
                                  state.items[selectedIndex]);
                            },
                          );
                        },
                        index: index,
                      );
              }
              return const Center(
                child: SizedBox(),
              );
            },
          ),
        );
      }),
    );
  }

  getById(int lawEnforcementId) async {
    showLoadingDialog(context);
    LawEnforcementDetails? model =
        await lawEnforcementListCubit.getById(lawEnforcementId, context);

    log('-model--maillist--${model?.mailList}-');

    editDataLoading(model);
  }

  void editDataLoading(LawEnforcementDetails? model) {
    dismissLoadingDialog(context);
    if (model != null) {
      for (Organisation organisation in model.entities ?? []) {
        log('-111--organisation.name--populateData--en-${organisation.name}');
      }

      for (Organisation organisation in model.mailList ?? []) {
        log('--111-organisation.name--populateData---${organisation.name}');
      }

      Navigator.pushNamed(context, lawenforcementScreenRoute,
          arguments: {"UserElement": model});
    }
  }
}
