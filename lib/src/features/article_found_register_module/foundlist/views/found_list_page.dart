import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/services/foundlist_services.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/views/found_list_item.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

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
  late RefreshController refreshController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    refreshController = RefreshController(initialRefresh: false);
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
      _getFoundArticleList();
    }
  }

  void _getFoundArticleList() async {
    String userid = await SharedPrefs.getUserId();
    await foundListArticleCubit.getFoundList(
        pageNumber.toString(), '20', userid, context);
  }

  getFoundArticleListId(int articleId) async {
    showLoadingDialog(context);
    final FoundListServices foundListServices = FoundListServices();
    FoundListArticleDetails foundArticleDetailsResponse =
        await foundListServices.getArticleById(articleId, context);
    editDataLoading(foundArticleDetailsResponse);
  }

  void editDataLoading(FoundListArticleDetails? foundArticleDetailsResponse) {
    dismissLoadingDialog(context);
    if (foundArticleDetailsResponse != null) {
      Navigator.pushNamed(context, createFoundScreenRoute, arguments: {
        "UserElement": foundArticleDetailsResponse,
        'eventId': foundArticleDetailsResponse.id
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    refreshController.dispose(); // Dispose refresh controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      floatingActionButton: Flutterfloatingbutton(
        backgroundColor: AppColors.navigationSkybluecolor,
        foregroundColor: AppColors.backgroundWhitecolor,
        onPressed: () {
          Navigator.pushNamed(context, createFoundScreenRoute)
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
        title: Constants.foundList,
        backBtn: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
        ),
        action: [
          CustomPopmenu(
            itemList: const [
              PopMenuItems("Export Excel", AppIcon.exportexcel),
              PopMenuItems("Export PDF", AppIcon.exportpdf),
            ],
            itemTap: (value) async {
              String userid = await SharedPrefs.getUserId();
              if (value == 0) {
                DownloadImage().exportExcel(context, int.parse(userid),
                    'export.xslx', '/exportFoundExcel');
              } else if (value == 1) {
                DownloadImage().exportPdf(context, int.parse(userid),
                    'export.pdf', '/exportFoundPDF');
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
            if (state.foundListModel?.items == null ||
                state.foundListModel!.items!.isEmpty) {
              return const NoRecordFoundWidget();
            }

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
          if (state.stateType == FoundListStateType.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.navigationSkybluecolor,
              ),
            );
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
              localfoundlist = state.foundListModel?.items;
            } else {
              localfoundlist?.addAll(state.foundListModel?.items ?? []);
            }
            return listWidgetLoading(
                height, state, scrollController, localfoundlist);
          }
        },
      ),
    );
  }

  Widget listWidgetLoading(double height, FoundListState state,
      ScrollController? scrollController, List<FoundModel>? foundList) {
    return Container(
      color: AppColors.navigationSkybluecolor,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkybluecolor,
            ),
            Container(
              decoration: const ShapeDecoration(
                color: AppColors.backgroundWhitecolor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
              ),
              child: Column(
                children: [
                  (foundList != null)
                      ? _userFoundListWidget(
                          foundList, context, scrollController, state)
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userFoundListWidget(
    List<FoundModel> userList,
    BuildContext cont,
    ScrollController? scrollController,
    FoundListState state,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const ShapeDecoration(
        color: AppColors.backgroundWhitecolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
      ),
      child: SizedBox(
        height: MediaQuery.of(cont).size.height * 01,
        child: SmartRefresher(
          controller: RefreshController(initialRefresh: false),
          enablePullDown: true,
          physics: const BouncingScrollPhysics(),
          header: const WaterDropHeader(
            waterDropColor: AppColors.navigationSkybluecolor,
            refresh: BaseLoader(),
          ),
          key: const Key(Keys.refreshKey),
          onRefresh: () async {
            context.read<FoundListCubit>().refreshList('0', '20');
            await Future.delayed(const Duration(milliseconds: 2000));
            refreshController.refreshCompleted();
          },
          onLoading: () async {
            if (mounted) {
              setState(() {});
            }
            refreshController.loadComplete();
          },
          child: ListView.builder(
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
      ),
    );
  }
}
