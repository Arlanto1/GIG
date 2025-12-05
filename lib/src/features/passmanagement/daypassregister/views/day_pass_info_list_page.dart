import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';

class DayPassInfoListPage extends StatefulWidget {
  String passId = '0';
  String title;
  bool isRegister;

  DayPassInfoListPage(
      {super.key, this.passId = '0', this.title = '', this.isRegister = false});

  @override
  State<DayPassInfoListPage> createState() => _DayPassInfoListPageState();
}

class _DayPassInfoListPageState extends State<DayPassInfoListPage> {
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;
  int pageNumber = 0;
  List<PassInfo>? localFoundList;
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
      if ((localFoundList?.length ?? 0) > 0) {
        pageNumber = ((localFoundList?.length ?? 0));
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
    await dayPassInfoCubit.getPassMngtList(pageNumber.toString(), '20', userid,
        widget.passId, context, widget.isRegister);
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
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    final height = size.height;
    //_loadMore();
    return Scaffold(
      backgroundColor: AppColors.newColor,
      bottomNavigationBar: CustomBottomNavigationBar(
        hasAddPermission: false,
        scaffoldKey: scaffoldKey,
        context: context,
        // displayMenu: state.displayMenu,
        list: true,
        // 🔥 only "+" button mode
        onAddPressed: () {
        },
      ),
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title:  widget.passId == '0'
      ? 'Day Pass Info List'
          : widget.passId == '1'
      ? 'Visitor Pass Info List'
          : widget.passId == '2'
      ? 'Vendor Pass Info List'
          : 'SEZ Pass Info List',
        showPopUp: true,
        showSaveButton: false,
        showSubmitButton: false,
        showDisLikeButton: false,
        showLikeButton: false,
        excelAPIName: 'exportPassMgmtExcel?passType=${widget.passId}&isList=',
        pdfAPIName: 'exportPassMgmtPDF?passType=${widget.passId}&isList=',
      ),
      body: BlocBuilder<DayPassInfoCubit, DayPassInfoState>(
          bloc: dayPassInfoCubit,
          builder: (context, state) {
            if (state.stateType == DayPassInfoStateType.success) {
              if (state.foundListModel?.items == null &&
                  state.foundListModel!.items!.isEmpty) {
                if (pageNumber == 0) {
                  localFoundList = state.foundListModel?.items;
                }
                return const Center(
                  child: Text(
                    Constants.nodata,
                    style: Styles.textStyleRegularGrey16,
                  ),
                );
              } else {
                if (pageNumber == 0) {
                  localFoundList = state.foundListModel?.items;
                } else {
                  localFoundList?.addAll(state.foundListModel?.items ?? []);
                }
                if ((state.foundListModel?.items?.length ?? 0) == 0 ||
                    (state.foundListModel?.totalCount ?? 0) ==
                        localFoundList?.length) {
                  isPaginationLoading = false;
                } else {
                  isPaginationLoading = true;
                }
                return listWidgetLoading(
                    height, state, scrollController, localFoundList);
              }
            }

            if (state.stateType == DayPassInfoStateType.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.navigationSkyBlueColor));
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
                localFoundList = state.foundListModel?.items;
              } else {
                localFoundList?.addAll(state.foundListModel?.items ?? []);
              }
              return listWidgetLoading(
                  height, state, scrollController, localFoundList);
            }
          }),
    );
  }

  Widget listWidgetLoading(double height, DayPassInfoState state,
      ScrollController? scrollController, List<PassInfo>? foundList) {
    return Container(
        color: AppColors.newColor3,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(children: [
            // Container(
            //   height: height * 0.01,
            //   color: AppColors.lavender,
            // ),
            Container(
              //padding: const EdgeInsets.all(20.0),
              // decoration: const ShapeDecoration(
              //     color: AppColors.lavender,
              //     shape: RoundedRectangleBorder(
              //       borderRadius:
              //           BorderRadius.vertical(top: Radius.circular(20.0)),
              //     )),
              child: Column(
                children: [
                  searchWidget(),
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
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 2),
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
  Widget _userFoundListWidget(List<PassInfo>? userList, BuildContext cont,
      ScrollController? scrollController) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Color(0xFF6474C6),
            // Color(0xFF6474C6),
            Colors.transparent,
            Colors.transparent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      // width: double.infinity,
      // height: double.infinity,
      // color: const Color(0xFF6474C6),
      // padding: allMargin16,
      child: Visibility(
        visible: userList!.isNotEmpty,
        child: ListView.builder(
            //controller: scrollController,
            itemCount: isPaginationLoading
                ? userList.length + 1
                : userList.length, // userList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index >= userList.length) {
                return const BaseLoader();
              } else {
                PassInfo user = userList[index];

                return DayPassRegisterListItem(
                  userItem: user,
                  onTap: (selectedIndex) {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return DayPassInfoCustomPopUpList(
                            userList[selectedIndex]);
                      },
                    );
                    //do the detail edit of user found
                  },
                  // oneditTap: (selectedIndex) {
                  //   getpassFoundArticleListId(userList[selectedIndex].id ?? 0);
                  // },
                  onviewTap: (selectedIndex) {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return DayPassInfoCustomPopUpList(
                            userList[selectedIndex]);
                      },
                    );
                  },

                  index: index,
                );
              }
            }),
      ),
    );
  }
}

class PassMngArguments {
  final int passType;
  final String title;
  final bool isRegistry;

  PassMngArguments(this.passType, this.title, this.isRegistry);
}
