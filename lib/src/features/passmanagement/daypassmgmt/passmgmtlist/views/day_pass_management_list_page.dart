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
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/views/create_pass_mgmt.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/controllers/day_passlist_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/controllers/day_passlist_state.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_item_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/views/day_pass_list_detail_popup.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/views/day_pass_management_list.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/views/day_pass_info_list_page.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayPassManagementList extends StatefulWidget {
  String? passId = '0';
  String? title;

  DayPassManagementList({Key? key, this.passId, this.title}) : super(key: key);

  @override
  State<DayPassManagementList> createState() => _DayPassManagementListState();
}

class _DayPassManagementListState extends State<DayPassManagementList> {
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;
  int pageNumber = 0;
  List<DayPassListElement>? localfoundlist;
  late ScrollController scrollController;
  bool isPaginationLoading = false;

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
     
      if ((localfoundlist?.length ?? 0) > 0)
      {
         pageNumber =  ((localfoundlist?.length ?? 0));
      }
      else
      {
      pageNumber = pageNumber + 20;
      }
      isPaginationLoading = true;
       //showLoadingDialog(context);
      print(pageNumber);
      // Perform event when user reach at the end of list (e.g. do Api call)
      _getpassFoundArticleList();
      // }
    }
    //  });
  }

  

  void _getpassFoundArticleList() async {
    String userid = await SharedPrefs.getUserId();
    await daypassListCubit.getFoundList(
        pageNumber.toString(), '20', userid, '${widget.passId}', context);
  }

  getpassFoundArticleListId(int articleid) async {
    showLoadingDialog(context);
    DayPassListItemResponse? foundArticleDetailsResponse =
        await daypassListCubit.getpassArticleById(articleid, context);

    editDataLoading(foundArticleDetailsResponse);
  }

  void editDataLoading(DayPassListItemResponse? foundArticleDetailsResponse) {
    dismissLoadingDialog(context);
    if (foundArticleDetailsResponse != null) {
      // Navigator.pushNamed(context, createpassmgmtRoute,
      //     arguments: {"UserElement": foundArticleDetailsResponse});
     String titleIdentify  = '';
         if(widget.passId  == '0')
         {
            titleIdentify = 'Edit Day Pass Management';
         }
         else if(widget.passId  == '1')
         {
            titleIdentify = 'Edit Vistor Pass Management';
         }
          else if(widget.passId  == '2')
         {
            titleIdentify = 'Edit Vendor Pass Management';
         }
          else if(widget.passId  == '3')
         {
            titleIdentify = 'Edit SEZ Pass Management';
         }

 DayPassListItemResponse? listuser = foundArticleDetailsResponse;
           Navigator.pushNamed(context, createpassmgmtRoute, arguments: {
        "passMngCreateDetails":
            CreatePassMngArguments(widget.passId ?? '', titleIdentify, true,foundArticleDetailsResponse)
      });
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
        onPressed: () {
         // Navigator.pushNamed(context, createpassmgmtRoute);
         String titleIdentify  = '';
         if(widget.passId  == '0')
         {
            titleIdentify = 'Create Day Pass Management';
         }
         else if(widget.passId  == '1')
         {
            titleIdentify = 'Create Vistor Pass Management';
         }
          else if(widget.passId  == '2')
         {
            titleIdentify = 'Create Vendor Pass Management';
         }
          else if(widget.passId  == '3')
         {
            titleIdentify = 'Create SEZ Pass Management';
         }

          Navigator.pushNamed(context, createpassmgmtRoute, arguments: {
        "passMngCreateDetails":
            CreatePassMngArguments(widget.passId ?? '', titleIdentify, true,null)
      });
        },
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
                // DownloadImage().exportExcel(context, int.parse(userid),
                //     'export.xslx', 0, pageNumber, '/exportPassMgmtExcel');
                DownloadImage().passexportExcel(context, int.parse(userid), 'export.xslx', int.parse(widget.passId ?? '0'),1 , '/exportPassMgmtExcel');
              } else if (value == 1) {
                // DownloadImage().exportPdf(context, int.parse(userid),
                //     'export.pdf', 0, pageNumber, '/exportPassMgmtPDF');
                DownloadImage().passexportExcel(context, int.parse(userid), 'export.pdf', int.parse(widget.passId ?? '0'),1 , '/exportPassMgmtPDF');
              }
            },
            popupimagename: AppIcon.morewhiteicon,
          ),
        ],
      ),
      body: BlocBuilder<DayPassListCubit, DayPassListState>(
          bloc: daypassListCubit,
          builder: (context, state) {
            if (state.stateType == DayPassListStateType.success) {
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
                if ((state.foundListModel?.list?.length ?? 0) == 0 || (state.foundListModel?.totalCount ?? 0) == localfoundlist?.length)
                {
                  isPaginationLoading = false;
                }
                else
                {
                  isPaginationLoading = true;
                }
                return listWidgetLoading(
                    height, state, scrollController, localfoundlist);
              }
            }
            if (state.stateType == DayPassListStateType.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.navigationSkybluecolor));
            } 
            else if (state.stateType == DayPassListStateType.failure && (localfoundlist ?? []).isEmpty) {
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

  Widget listWidgetLoading(double height, DayPassListState state,
      ScrollController? scrollController, List<DayPassListElement>? foundList) {
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
  Widget _userFoundListWidget(List<DayPassListElement>? userList,
      BuildContext cont, ScrollController? scrollController) {
    return Container(
      padding: allMargin16,
      child: Visibility(
        visible: userList!.isNotEmpty,
        child: ListView.builder(
          //controller: scrollController,
          itemCount: isPaginationLoading ? userList.length + 1 : userList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index >= userList.length)
            {
              return const Center(child:  CircularProgressIndicator());
            }
            else
            {
            DayPassListElement user = userList[index];

            return DayPassManagementListItem(
              userItem: user,
              onTap: (selectedIndex) {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return DayPassCustomPopUpList(userList[selectedIndex],widget.passId);
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
                    return DayPassCustomPopUpList(userList[selectedIndex],widget.passId);
                  },
                );
              },
              index: index,
            );
            }
          },
        ),
      ),
    );
  }
}
