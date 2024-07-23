import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found_register_module/article_found_list/bloc/article_found_bloc.dart';
import 'package:db_atom/src/features/article_found_register_module/article_found_list/views/found_list_item.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/services/foundlist_services.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ArticleFoundListView extends StatefulWidget {
  const ArticleFoundListView({
    super.key,
  });

  @override
  State<ArticleFoundListView> createState() => _ArticleFoundListViewState();
}

class _ArticleFoundListViewState extends State<ArticleFoundListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<ArticleFoundBloc>().add(
          const InitializeValuesAF(),
        );
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    refreshController.dispose();
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
      context.read<ArticleFoundBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    context.read<ArticleFoundBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) {
      setState(() {});
    }
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<ArticleFoundBloc, ArticleFoundState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.cardBgColor,
          floatingActionButton:
              state.extraProperties?.hasWritePermission ?? false
                  ? Flutterfloatingbutton(
                      backgroundColor: AppColors.navigationSkyBlueColor,
                      foregroundColor: AppColors.backgroundWhiteColor,
                      onPressed: () => {
                        Navigator.pushNamed(
                          context,
                          createFoundScreenRoute,
                        )
                      },
                    )
                  : const SizedBox(),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.foundListTitle,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportFoundExcel',
            pdfAPIName: 'exportFoundPDF',
          ),
          body: BlocConsumer<ArticleFoundBloc, ArticleFoundState>(
            listener: (context, state) {
              Utils().formError(state, context);
              Utils().errorAndLogout(state, context);

              if (state.status == FormStatus.sessionExpired) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.message ?? 'Session Expired...')));
                Validator.logoutAction(context);
              }
            },
            builder: (context, state) {
              // if (state.status == FormStatus.initial) {
              //   return const BaseLoader();
              // }

              return Container(
                margin: allMargin16,
                decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  ),
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BaseSearchWidget(
                      applySearchFilters: applySearchFilters,
                      applyFilters: applyFilters,
                      commonFilters: state.commonFilters ??
                          CommonFilters(
                            statuses: [],
                            regions: [],
                          ),
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.001),
                    if (state.status == FormStatus.loading) ...[
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      const BaseLoader(),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                    ],
                    // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                    // Text('state.status=====${state.status}'),
                    UtilsCommon().showNoRecordWidget(
                        state: state, height: height, items: state.items),

                    Expanded(
                      child: SmartRefresher(
                        controller: refreshController,
                        enablePullDown: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        header: WaterDropHeader(
                          waterDropColor: AppColors.navigationSkyBlueColor,
                          refresh: state.status != FormStatus.loading
                              ? const BaseLoader()
                              : null,
                        ),
                        key: const Key(Keys.refreshKey),
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: state.hasReachedMax
                              ? state.items.length
                              : state.items.length + 1,
                          itemBuilder: (context, index) {
                            if (index < state.items.length) {
                              FoundModel user = state.items[index];
                              return FoundListItem(
                                userItem: user,
                                onTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return CustomPopUpList(
                                          state.items[selectedIndex]);
                                    },
                                  );
                                },
                                onEditTap: (selectedIndex) {
                                  getById(
                                    state.items[selectedIndex].id ?? 0,
                                    state.extraProperties?.hasWritePermission ??
                                        false,
                                  );
                                },
                                onViewTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return CustomPopUpList(
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
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  getById(int id, bool hasWritePermission) async {
    showLoadingDialog(context);

    FoundListArticleDetails foundArticleDetailsResponse =
        await FoundListServices().getArticleById(id, context);
    editDataLoading(foundArticleDetailsResponse, hasWritePermission);
  }

  Future<void> editDataLoading(
    FoundListArticleDetails? model,
    bool hasWritePermission,
  ) async {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(context, createFoundScreenRoute, arguments: {
        "UserElement": model,
        'eventId': model.id,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      });
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<ArticleFoundBloc>(context).add(
      FetchData(
        startPos: 0,
        maxPos: Constants.maxResults,
        newSearch: true,
        filters: filters,
      ),
    );
  }

  void applyFilters(
    Filters model,
  ) {
    log('Applying Filters');

    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    log('id---filtersFun----${filters.filterCriteria!.filters!.id}---');

    BlocProvider.of<ArticleFoundBloc>(context).add(
      FetchData(
        startPos: 0,
        maxPos: Constants.maxResults,
        newSearch: true,
        filters: filters,
      ),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
