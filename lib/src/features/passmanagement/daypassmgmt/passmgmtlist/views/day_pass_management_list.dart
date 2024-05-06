import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/controllers/day_passlist_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/views/day_pass_list_detail_popup.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/views/day_pass_management_list_item.dart';

class DayPassManagementList extends StatefulWidget {
  final int passId;
  final String title;

  const DayPassManagementList(
      {super.key, required this.passId, required this.title});

  @override
  State<DayPassManagementList> createState() => _DayPassManagementListState();
}

class _DayPassManagementListState extends State<DayPassManagementList> {
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;
  int pageNumber = 0;
  List<PassManagementModel>? localfoundlist;
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
      if ((localfoundlist?.length ?? 0) > 0) {
        pageNumber = ((localfoundlist?.length ?? 0));
      } else {
        pageNumber = pageNumber + 20;
      }
      isPaginationLoading = true;
      //showLoadingDialog(context);
      // Perform event when user reach at the end of list (e.g. do Api call)
      _getpassFoundArticleList();
      // }
    }
    //  });
  }

  void _getpassFoundArticleList() async {
    String userid = await SharedPrefs.getUserId();
    await dayPassListCubit.getList(
        pageNumber.toString(), '20', userid, '${widget.passId}', context);
  }

  getpassFoundArticleListId(int articleid) async {
    showLoadingDialog(context);
    PassManagementModel? foundArticleDetailsResponse =
        await dayPassListCubit.getpassArticleById(articleid, context);

    editDataLoading(foundArticleDetailsResponse);
  }

  void editDataLoading(PassManagementModel? foundArticleDetailsResponse) {
    dismissLoadingDialog(context);
    if (foundArticleDetailsResponse != null) {
      // Navigator.pushNamed(context, createpassmgmtRoute,
      //     arguments: {"UserElement": foundArticleDetailsResponse});
      String titleIdentify = '';
      if (widget.passId == 0) {
        titleIdentify = 'Edit Day Pass Management';
      } else if (widget.passId == 1) {
        titleIdentify = 'Edit Visitor Pass Management';
      } else if (widget.passId == 2) {
        titleIdentify = 'Edit Vendor Pass Management';
      } else if (widget.passId == 3) {
        titleIdentify = 'Edit SEZ Pass Management';
      }

      // DayPassListElement? listuser = foundArticleDetailsResponse;
      Navigator.pushNamed(context, createpassmgmtRoute, arguments: {
        "passMngCreateDetails": CreatePassMngArguments(
            widget.passId, titleIdentify, true, foundArticleDetailsResponse)
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
        backgroundColor: AppColors.navigationSkyBlueColor,
        foregroundColor: AppColors.backgroundWhiteColor,
        onPressed: () {
          // Navigator.pushNamed(context, createpassmgmtRoute);
          String titleIdentify = '';
          if (widget.passId == 0) {
            titleIdentify = 'Create Day Pass Management';
          } else if (widget.passId == 1) {
            titleIdentify = 'Create Visitor Pass Management';
          } else if (widget.passId == 2) {
            titleIdentify = 'Create Vendor Pass Management';
          } else if (widget.passId == 3) {
            titleIdentify = 'Create SEZ Pass Management';
          }

          Navigator.pushNamed(context, createpassmgmtRoute, arguments: {
            "passMngCreateDetails":
                CreatePassMngArguments(widget.passId, titleIdentify, true, null)
          }).then((value) async {
            if (value != null && value == true) {
              localfoundlist?.clear();
              pageNumber = 0;
              _getpassFoundArticleList();
            }
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
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
        ),
        // action: [
        //   CustomPopmenu(
        //     //itemList :[],
        //     itemList: const [
        //       PopMenuItems("Export Excel", AppIcon.exportexcel),
        //       PopMenuItems("Export PDF", AppIcon.exportpdf),
        //       //PopMenuItems("Export XML", AppIcon.exportxml),
        //       //PopMenuItems("Close", AppIcon.close),
        //     ],
        //     itemTap: (value) async {
        //       String userid = await SharedPrefs.getUserId();
        //       log(value);
        //       if (value == 0) {
        //         DownloadImage().exportExcel(context, int.parse(userid),
        //             'export.xslx', 0, pageNumber, '/exportPassMgmtExcel');
        //         DownloadImage().passexportExcel(
        //             context,
        //             int.parse(userid),
        //             'export.xslx',
        //             int.parse(widget.passId ?? '0'),
        //             1,
        //             '/exportPassMgmtExcel');
        //       } else if (value == 1) {
        //         // DownloadImage().exportPdf(context, int.parse(userid),
        //         //     'export.pdf', 0, pageNumber, '/exportPassMgmtPDF');
        //         DownloadImage().passexportExcel(
        //             context,
        //             int.parse(userid),
        //             'export.pdf',
        //             int.parse(widget.passId ?? '0'),
        //             1,
        //             '/exportPassMgmtPDF');
        //       }
        //     },
        //     popupimagename: AppIcon.morewhiteicon,
        //   ),
        // ],
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
                    'export.xslx', '/exportPassMgmtExcel');
              } else if (value == 1) {
                DownloadImage().exportPdf(context, int.parse(userid),
                    'export.pdf', '/exportPassMgmtPDF');
              }
            },
            popupimagename: AppIcon.morewhiteicon,
          ),
        ],
      ),
      body: BlocBuilder<DayPassListCubit, DayPassListState>(
          bloc: dayPassListCubit,
          builder: (context, state) {
            if (state.stateType == FormStatus.loading) {
              return const BaseLoader();
            }
            if (state.stateType == FormStatus.success) {
              if (state.foundListModel?.items == null &&
                  state.foundListModel!.items!.isEmpty) {
                if (pageNumber == 0) {
                  localfoundlist = state.foundListModel?.items;
                }
                return const Center(
                  child: Text(
                    Constants.nodata,
                    style: Styles.textStyleRegularGrey16,
                  ),
                );
              } else {
                if (pageNumber == 0) {
                  localfoundlist = state.foundListModel?.items;
                } else {
                  localfoundlist?.addAll(state.foundListModel?.items ?? []);
                }
                if ((state.foundListModel?.items?.length ?? 0) == 0 ||
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
            if (state.stateType == FormStatus.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.navigationSkyBlueColor));
            } else if (state.stateType == FormStatus.failure &&
                (localfoundlist ?? []).isEmpty) {
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
                localfoundlist = state.foundListModel?.items;
              } else {
                localfoundlist?.addAll(state.foundListModel?.items ?? []);
              }
              return listWidgetLoading(
                  height, state, scrollController, localfoundlist);
            }
          }),
    );
  }

  Widget listWidgetLoading(
      double height,
      DayPassListState state,
      ScrollController? scrollController,
      List<PassManagementModel>? foundList) {
    return Container(
        color: AppColors.navigationSkyBlueColor,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkyBlueColor,
            ),
            Container(
              //padding: const EdgeInsets.all(20.0),
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
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
            borderColor = AppColors.navigationSkyBlueColor;
          } else {
            borderColor = AppColors.textGreyThemeColor;
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
  Widget _userFoundListWidget(List<PassManagementModel>? userList,
      BuildContext cont, ScrollController? scrollController) {
    return Container(
      padding: allMargin16,
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
              PassManagementModel user = userList[index];

              return DayPassManagementListItem(
                userItem: user,
                onTap: (selectedIndex) {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return DayPassCustomPopUpList(
                          userList[selectedIndex], widget.passId.toString());
                    },
                  );
                  //do the detail edit of user found
                },
                onEditTap: (selectedIndex) {
                  getpassFoundArticleListId(userList[selectedIndex].id ?? 0);
                },
                onViewTap: (selectedIndex) {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return DayPassCustomPopUpList(
                          userList[selectedIndex], widget.passId.toString());
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
