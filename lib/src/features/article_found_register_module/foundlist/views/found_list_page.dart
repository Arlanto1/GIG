import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_circular_loader.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_no_record_found_widget.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/custom_list_pop_up.dart';
import 'package:db_atom/src/common_widgets/custom_pop_menu.dart';
import 'package:db_atom/src/common_widgets/floating_button.dart';
import 'package:db_atom/src/common_widgets/image_download.dart';
import 'package:db_atom/src/common_widgets/search_widget.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/controllers/foundlist_cubit.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/controllers/foundlist_state.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/services/foundlist_services.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/views/found_list_item.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoundList extends StatefulWidget {
  const FoundList({super.key});

  @override
  State<FoundList> createState() => _FoundListState();
}

class _FoundListState extends State<FoundList> {
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;
  int pageNumber = 0;
  List<FoundModel>? localfoundlist;
  late ScrollController scrollController;
  bool isPaginationLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    //added the pagination function with listener
    scrollController.addListener(_loadMore);
    _getFoundArticleList();
  }

  _loadMore() {
    if (scrollController.position.maxScrollExtent ==
        scrollController.position.pixels) {
      if ((localfoundlist?.length ?? 0) > 0) {
        pageNumber = ((localfoundlist?.length ?? 0));
      } else {
        pageNumber = pageNumber + 20;
      }
      isPaginationLoading = true;
      //showLoadingDialog(context);
      // Perform event when user reach at the end of list (e.g. do Api call)
      _getFoundArticleList();
      // }
    }
    //  });
  }

  void _getFoundArticleList() async {
    String userid = await SharedPrefs.getUserId();
    await foundListArticleCubit.getFoundList(
        pageNumber.toString(), '20', userid, context);
  }

  getFoundArticleListId(int articleId) async {
    showLoadingDialog(context);
    // FoundListArticleDetails? foundArticleDetailsResponse =
    //     await foundListArticleCubit.getArticleById(articleId, context);
    final FoundListServices foundListServices = FoundListServices();
    FoundListArticleDetails foundArticleDetailsResponse =
    await foundListServices.getArticleById(articleId, context);
    editDataLoading(foundArticleDetailsResponse);
  }

  void editDataLoading(FoundListArticleDetails? foundArticleDetailsResponse) {
    dismissLoadingDialog(context);
    // Navigator.pushNamed(context, createfoundScreenRoute);
    if (foundArticleDetailsResponse != null) {
      Navigator.pushNamed(context, createfoundScreenRoute, arguments: {
        "UserElement": foundArticleDetailsResponse,
        'eventId': foundArticleDetailsResponse.id
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

    //_loadMore();
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      floatingActionButton: Flutterfloatingbutton(
        backgroundColor: AppColors.navigationSkybluecolor,
        foregroundColor: AppColors.backgroundWhitecolor,
        onPressed: () {
          Navigator.pushNamed(context, createfoundScreenRoute)
              .then((value) async {
            if (value != null && value == true) {
              localfoundlist?.clear();
              pageNumber = 0;
              _getFoundArticleList();
            }
          });
        },
      ),
      appBar: AppHeader(
        isTitleCenter: false,
        title: 'Found List',
        backBtn: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
        ),
        action: [
          CustomPopmenu(
            //itemList :[],
            itemList: const [
              PopMenuItems("Export Excel", AppIcon.exportexcel),
              PopMenuItems("Export PDF", AppIcon.exportpdf),
              //PopMenuItems("Export XML", AppIcon.exportxml),
              // PopMenuItems("Close", AppIcon.close),
            ],
            itemTap: (value) async {
              String userid = await SharedPrefs.getUserId();
              if (value == 0) {
                DownloadImage().exportExcel(context, int.parse(userid),
                    'export.xslx', 0, pageNumber, '/exportFoundExcel');
              } else if (value == 1) {
                DownloadImage().exportPdf(context, int.parse(userid),
                    'export.pdf', 0, pageNumber, '/exportFoundPDF');
              }
            },
            popupimagename: AppIcon.morewhiteicon,
          ),
        ],
      ),
      body: BlocBuilder<FoundListCubit, FoundListState>(
          bloc: foundListArticleCubit,
          builder: (context, state) {
            if (state.stateType == FoundListStateType.success) {
              if (state.foundListModel?.list == null ||
                  state.foundListModel!.list!.isEmpty) {
                return const NoRecordFoundWidget();
              }

              if (state.foundListModel?.list == null &&
                  state.foundListModel!.list!.isEmpty) {
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
                if ((state.foundListModel?.list?.length ?? 0) == 0 ||
                    (state.foundListModel?.totalCount ?? 0) ==
                        localfoundlist?.length) {
                  isPaginationLoading = false;
                } else {
                  isPaginationLoading = true;
                }
                return listWidgetLoading(
                    height, state, scrollController, localfoundlist);
              }
            }
            if (state.stateType == FoundListStateType.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.navigationSkybluecolor));
            } else if (state.stateType == FoundListStateType.failure) {
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

  Widget listWidgetLoading(double height, FoundListState state,
      ScrollController? scrollController, List<FoundModel>? foundList) {
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
                      foundList, context, scrollController, state)
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
  Widget _userFoundListWidget(List<FoundModel>? userList, BuildContext cont,
      ScrollController? scrollController, FoundListState state) {
    return Container(
      padding: allMargin16,
      decoration: const ShapeDecoration(
          color: AppColors.backgroundWhitecolor,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.vertical(top: Radius.circular(20.0)),
          )),
      child: Visibility(
        visible: userList!.isNotEmpty,
        child: ListView.builder(
          //controller: scrollController,
          itemCount:
          isPaginationLoading ? userList.length + 1 : userList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index >= userList.length) {
              return const BaseLoader();
            } else {
              FoundModel user = userList[index];

              return FoundListItem(
                userItem: user,
                onTap: (selectedIndex) {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return CustomPopUpList(userList[selectedIndex]);
                    },
                  );
                  //do the detail edit of user found
                },
                onEditTap: (selectedIndex) {
                  getFoundArticleListId(userList[selectedIndex].id ?? 0);
                },
                onViewTap: (selectedIndex) {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return CustomPopUpList(userList[selectedIndex]);
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
