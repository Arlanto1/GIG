

import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found/article_found_list/bloc/article_found_list_bloc.dart';
import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
import 'package:db_atom/src/features/article_found/services/article_found_service.dart';
import 'package:db_atom/src/features/law_enforcement_new/law_enforcement_list_new/bloc/law_enforcement_bloc_new.dart';

class ArticleFoundNewListView extends StatefulWidget {
  const ArticleFoundNewListView({
    super.key,
  });

  @override
  State<ArticleFoundNewListView> createState() => _ArticleFoundNewListViewState();
}

class _ArticleFoundNewListViewState extends State<ArticleFoundNewListView> {
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
      context.read<ArticleFoundBloc>().add(FetchArticleData(
        startPos: pageNumber,
        maxPos: Constants.maxResults,
        newSearch: false,
        filters: filters,
      ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<ArticleFoundBloc>().add(
      const RefreshList(),
    );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<ArticleFoundBloc, ArticleFoundState>(
        listener: (context, state) {},
        builder: (context, state) {
          log('plus ${state.extraProperties?.hasWritePermission}');
          return Scaffold(
              backgroundColor: AppColors.cardBgColor,
              floatingActionButton:
              state.extraProperties?.hasWritePermission ??
                  false
                  ?
              Flutterfloatingbutton(
                backgroundColor: AppColors.navigationSkyBlueColor,
                foregroundColor: AppColors.backgroundWhiteColor,
                onPressed: () => {
                  Navigator.pushNamed(context, articleFoundNewDetailsRoute,
                      arguments: {
                        "title": Constants.createFound
                      }),
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
              body:
              BlocBuilder<ArticleFoundBloc, ArticleFoundState>(
                  builder: (context, state) {
                    return Container(
                      margin: allMargin16,
                      decoration: const ShapeDecoration(
                          color: AppColors.backgroundWhiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0)),
                          )),
                      child: Column(
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
                          if (state.items.isEmptyOrNull &&
                              state.status != FormStatus.loading) ...[
                            CommonWidgets.verticalSpacerWidget(height * 0.1),
                            const NoRecordFoundWidget(),
                          ],

                          Expanded(
                            child: CustomMaterialIndicator(
                              onRefresh: () => _onRefresh(),
                              backgroundColor: Colors.white,
                              indicatorBuilder: (context, controller) {
                                return const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: BaseLoader(),
                                );
                              },
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: state.hasReachedMax
                                    ? state.items.length
                                    : state.items.length + 1,
                                itemBuilder: (context, index) {
                                  List<Label> labels = [];
                                  if (index < state.items.length) {
                                    labels.add(Label(
                                        key:
                                        // state.labels?.locale.inputDate ??
                                        //     state.labels?.defaultLocale
                                        //         .inputDate ??
                                        Constants.dateofcreation,
                                        value: state.items[index].inputDate != null
                                            ? Utils.timestampToDateConversion(
                                            int.parse(
                                                state.items[index].inputDate ??
                                                    '0'),
                                            Constants
                                                .twentyFourHourDateTimeFormat)
                                            : ''));
                                    labels.add(Label(
                                        key:
                                        // state.labels?.locale.inputDate ??
                                        //     state.labels?.defaultLocale
                                        //         .inputDate ??
                                            Constants.founddate,
                                        value: state.items[index].foundDate != null
                                            ? Utils.timestampToDateConversion(
                                            int.parse(
                                                state.items[index].foundDate ??
                                                    '0'),
                                            Constants
                                                .twentyFourHourDateTimeFormat)
                                            : ''));
                                    labels.add(Label(
                                        key:
                                      // state.labels?.locale.locationRegion ??
                                        //     state.labels?.defaultLocale
                                        //         .locationRegion ??
                                            Constants.region,
                                        value:
                                        state.items[index].locationRegion?.name ?? ''));
                                    labels.add(Label(
                                        key:
                                        // state.labels?.locale.location ??
                                        //     state.labels?.defaultLocale.location ??
                                            Constants.location,
                                        value: state.items[index].location?.name ??
                                            ''));
                                    labels.add(Label(
                                        key:
                                        // state.labels?.locale.entrySecurity ??
                                        //     state.labels?.defaultLocale
                                        //         .entrySecurity ??
                                            Constants.createdby,
                                        value:
                                        '${state.items[index].entrySecurity?.firstName ?? ''} ${state.items[index].entrySecurity?.lastName ?? ''}'));

                                    return index >= state.items.length
                                        ? const BaseLoader()
                                        : BaseListTileItem(
                                      id: state.items[index].id,
                                      status: state.items[index].status,
                                      labels: labels,
                                      isArticleFoundStatus: true,
                                      isEventProtectionStatus: false,
                                      onTap: (selectedIndex) {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return BasePopUpItems(
                                              id: state.items[selectedIndex].id
                                                  .toString(),
                                              status: state.items[index].status,
                                              slNo: state
                                                  .items[selectedIndex].slNo,
                                              labels: labels,
                                              isEventProtectionStatus: false,
                                              isMasterGuard: false,
                                              isArticleFoundStatus: true,
                                            );
                                          },
                                        );
                                      },
                                      onEditTap: (selectedIndex) {
                                        getById(
                                            state.extraProperties
                                                ?.hasWritePermission ??
                                                false,
                                            state.items[index].id ?? 0);
                                      },
                                      showEditButton: state
                                          .items[index].status ==
                                          ConstantsIntValue.articleFoundStatusFound || state
                                          .items[index].status ==
                                          ConstantsIntValue.articleFoundStatusUnderSecurityCustody,
                                      onViewTap: (selectedIndex) {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return BasePopUpItems(
                                              id: state.items[selectedIndex].id
                                                  .toString(),
                                              slNo: state
                                                  .items[selectedIndex].slNo,
                                              status: state.items[index].status,
                                              labels: labels,
                                              isEventProtectionStatus: false,
                                              isArticleFoundStatus: true,
                                              isMasterGuard: false,
                                            );
                                          },
                                        );
                                      },
                                      index: index,
                                    );
                                  }

                                  // Handle the case where index is out of bounds
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
                  }));
        });
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    ArticleFoundModel model=
    await ArticleFoundServices().getById(id);

    editDataLoading(model, hasWritePermission);
  }

  void editDataLoading(
      ArticleFoundModel? model, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(context, articleFoundNewDetailsRoute, arguments: {
        "model": model,
        "title": Constants.editFound,
        ConstantsArgument.extraProperties:
        ExtraProperties(hasWritePermission: hasWritePermission),
      });
    }
  }

  void applySearchFilters(
      FilterCriteria model,
      ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<ArticleFoundBloc>(context).add(
      FetchArticleData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
  }

  void applyFilters(
      Filters model,
      ) {
    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));

    BlocProvider.of<ArticleFoundBloc>(context).add(
      FetchArticleData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    Navigator.pop(context);
  }
}

