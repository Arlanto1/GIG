// Created by Ramesh

import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/custom_pop_menu.dart';
import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/common_widgets/image_download.dart';
import 'package:db_atom/src/common_widgets/search_widget.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_item_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/controllers/day_pass_info_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/controllers/day_pass_info_state.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/models/day_pass_info_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/views/day_pass_info_detail_popup.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/views/day_pass_list.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayPassregisterList extends StatefulWidget {
  String passId = '0';
  String title;

  DayPassregisterList({Key? key, this.passId = '0', this.title = ''})
      : super(key: key);

  @override
  State<DayPassregisterList> createState() => _DayPassregisterListState();
}

class _DayPassregisterListState extends State<DayPassregisterList> {
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;
  int pageNumber = 0;
  List<DaypassInfoListElement>? localfoundlist;
  late ScrollController scrollController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    //added the pagination function with listener
    scrollController.addListener(_loadMore);
    _getpassFoundArticleList();
  }

  _loadMore() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      if ((localfoundlist?.length ?? 0) > 0) {
        pageNumber = ((localfoundlist?.length ?? 0));
      } else {
        pageNumber = pageNumber + 20;
      }
      showLoadingDialog(context);
      print(pageNumber);
      // Perform event when user reach at the end of list (e.g. do Api call)
      _getpassFoundArticleList();
      // }
    }
    //  });
  }

  void _getpassFoundArticleList() async {
    String userid = await SharedPrefs.getUserId();
    await daypassinfoCubit.getPassMngtList(
        pageNumber.toString(), '20', userid, widget.passId, context);
  }

  getpassFoundArticleListId(int articleid) async {
    showLoadingDialog(context);
    // DayPassListItemResponse? foundArticleDetailsResponse = await daypassListCubit.getpassArticleById(articleid,context);

    //    editDataLoading(foundArticleDetailsResponse);
  }

  void editDataLoading(DayPassListItemResponse? foundArticleDetailsResponse) {
    dismissLoadingDialog(context);
    if (foundArticleDetailsResponse != null) {
      // Navigator.pushNamed(context, createfoundScreenRoute,arguments:{"UserElement" : foundArticleDetailsResponse}  );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    //_loadMore();
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      floatingActionButton: Flutterfloatingbutton(
        backgroundColor: AppColors.navigationSkybluecolor,
        foregroundColor: AppColors.backgroundWhitecolor,
        onPressed: () {},
      ),
      appBar: AppHeader(
        isTitleCenter: false,
        title: widget.title,
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
                DownloadImage().exportExcel(context, int.parse(userid),
                    'export.xslx', 0, pageNumber, '/exportPassInfoExcel');
              } else if (value == 1) {
                DownloadImage().exportPdf(context, int.parse(userid),
                    'export.pdf', 0, pageNumber, '/exportPassInfoPDF');
              }
            },
            popupimagename: AppIcon.morewhiteicon,
          ),
        ],
      ),
      body: BlocBuilder<DayPassInfoCubit, DayPassInfoState>(
          bloc: daypassinfoCubit,
          builder: (context, state) {
            if (state.stateType == DayPassInfoStateType.success) {
              if (state.foundListModel?.list == null &&
                  state.foundListModel?.list?.length == 0) {
                if (pageNumber == 0) {
                  localfoundlist = state.foundListModel?.list;
                }
                return const Center(
                  child: Text(
                    Constants.nodata,
                    style: Styles.textStyleRegularGrey16,
                  ),
                );
              } else {
                if (pageNumber == 0) {
                  localfoundlist = state.foundListModel?.list;
                } else {
                  localfoundlist?.addAll(state.foundListModel?.list ?? []);
                }
                return listWidgetLoading(
                    height, state, scrollController, localfoundlist);
              }
            }
            if (state.stateType == DayPassInfoStateType.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.navigationSkybluecolor));
            } else if (state.stateType == DayPassInfoStateType.failure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    state.errorMessage ?? Constants.nodata,
                    style: Styles.textStyleRegularGrey16,
                  ),
                ),
              );
            } else {
              if (pageNumber == 0) {
                localfoundlist = state.foundListModel?.list;
              } else {
                localfoundlist?.addAll(state.foundListModel?.list ?? []);
              }
              return listWidgetLoading(
                  height, state, scrollController, localfoundlist);
            }
          }),
    );
  }

  Widget listWidgetLoading(
      double height,
      DayPassInfoState state,
      ScrollController? scrollController,
      List<DaypassInfoListElement>? foundList) {
    return Container(
        color: AppColors.navigationSkybluecolor,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkybluecolor,
            ),
            Container(
              //padding: const EdgeInsets.all(20.0),
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhitecolor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  )),
              child: Column(
                children: [
                  // searchWidget(),
                  (foundList != null)
                      ? _userFoundListWidget(
                          foundList, context, scrollController)
                      : const SizedBox()
                ],
              ),
            ),
          ]),
        ));
  }

  // Search Widget
  Widget searchWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 20, bottom: 2),
      child: SearchWidget(
        controller: _searchCtrl,
        hintText: Constants.searchHintText,
        textInputFieldKey: Keys.searchInputField,
        leadingIcon: AppIcon.searchIcon,
        border: borderColor,
        isEnabled: false,
        focusChange: (bool focus) {
          if (focus) {
            borderColor = AppColors.navigationSkybluecolor;
          } else {
            borderColor = AppColors.textgreyThemecolor;
          }
          setState(() {});
        },
        onSubmit: (String txt) {
          if (txt.trim().length >= 15) {
          } else {
            //Show error message for validations
          }
          _searchCtrl.text = txt;
        },
      ),
    );
  }

  // List view builder
  Widget _userFoundListWidget(List<DaypassInfoListElement>? userList,
      BuildContext cont, ScrollController? scrollController) {
    return Container(
      padding: allMargin16,
      child: Visibility(
        visible: userList!.isNotEmpty,
        child: ListView.builder(
          //controller: scrollController,
          itemCount: userList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            DaypassInfoListElement user = userList[index];

            return DayPassregisterListItem(
              userItem: user,
              onTap: (selectedIndex) {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return DayPassInfoCustomPopUpList(userList[selectedIndex]);
                  },
                );
                //do the detail edit of user found
              },
              oneditTap: (selectedIndex) {
                getpassFoundArticleListId(userList[selectedIndex].id ?? 0);
              },
              onviewTap: (selectedIndex) {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return DayPassInfoCustomPopUpList(userList[selectedIndex]);
                  },
                );
              },
              index: index,
            );
          },
        ),
      ),
    );
  }
}

class PassMngArguments {
  final String passType;
  final String title;

  PassMngArguments(this.passType, this.title);
}
