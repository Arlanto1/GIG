import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/law_enforcement_list/bloc/law_enforcement_list_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'law_enforcement_list_item.dart';
import 'le_custom_list_pop_up.dart';

class LawEnforcementsView extends StatelessWidget {
  const LawEnforcementsView({super.key});

  @override
  Widget build(BuildContext context) {
    BaseFilterModel filters = BaseFilterModel();
    return BlocProvider<LawEnforcementListBloc>(
      create: (_) => LawEnforcementListBloc()
        ..add(LawEnforcementFetch(
            startPos: 0,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters)),
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
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<LawEnforcementListBloc>().add(
          const InitializeValuesLEO(),
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
      context.read<LawEnforcementListBloc>().add(LawEnforcementFetch(
          startPos: pageNumber,
          maxPos: Constants.maxResults,
          newSearch: false,
          filters: filters));
    }
  }

  void _onRefresh() async {
    context.read<LawEnforcementListBloc>().add(
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
    final bloc = BlocProvider.of<LawEnforcementListBloc>(context);
    return BlocConsumer<LawEnforcementListBloc, LawEnforcementListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.cardBgColor,
          floatingActionButton: state.extraProperties?.hasWritePermission ??
                  false
              ? Flutterfloatingbutton(
                  backgroundColor: AppColors.navigationSkyBlueColor,
                  foregroundColor: AppColors.backgroundWhiteColor,
                  onPressed: () {
                    // Navigator.pushNamed(context, lawenforcementScreenRoute);
                    Navigator.pushNamed(context, lawEnforcementDetailsViewRoute)
                        .then((value) async {
                      if (value != null && value == true) {
                        log('value--$value');
                        //localfoundlist?.clear();
                        pageNumber = 0;
                        bloc.add(LawEnforcementFetch(
                            startPos: 0,
                            maxPos: Constants.maxResults,
                            newSearch: false,
                            filters: filters));
                      }
                    });
                  },
                )
              : const SizedBox(),
          appBar: AppHeader(
            isTitleCenter: false,
            title: Constants.lawEnforcementVisitsListTitle,
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
                  //PopMenuItems("Close", AppIcon.close),
                ],
                itemTap: (value) async {
                  if (value == 0) {
                    DownloadImage()
                        .exportExcel(context, 'export.xslx', '/exportLEOExcel');
                  } else if (value == 1) {
                    DownloadImage()
                        .exportPdf(context, 'export.pdf', '/exportLEOPDF');
                  }
                },
                popupimagename: AppIcon.morewhiteicon,
              ),
            ],
          ),
          body: BlocBuilder<LawEnforcementListBloc, LawEnforcementListState>(
              builder: (context, state) {
            // if (state.status == FormStatus.initial) {
            //   return const BaseLoader();
            // }
            // else if (state.status == FormStatus.success) {}
            //
            // if (state.items.isEmptyOrNull) {
            //   return const NoRecordFoundWidget();
            // }

            return Container(
              margin: allMargin16,
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  )),
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
                  if (state.items.isEmptyOrNull &&
                      (state.status != FormStatus.loading &&
                          state.status != FormStatus.initial)) ...[
                    CommonWidgets.verticalSpacerWidget(height * 0.1),
                    const NoRecordFoundWidget(),
                  ],
                  Expanded(
                    child: SmartRefresher(
                      controller: refreshController,
                      enablePullDown: true,
                      physics: const BouncingScrollPhysics(),
                      header: const WaterDropHeader(
                        waterDropColor: AppColors.navigationSkyBlueColor,
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
                                      getById(
                                          state.extraProperties
                                                  ?.hasWritePermission ??
                                              false,
                                          state.items[index].id ?? 0);
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
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  getById(bool hasWritePermission, int lawEnforcementId) async {
    showLoadingDialog(context);
    LawEnforcementDetailsModel? model =
        await lawEnforcementListCubit.getById(lawEnforcementId, context);

    editDataLoading(model, hasWritePermission);
  }

  void editDataLoading(
    LawEnforcementDetailsModel? model,
    bool hasWritePermission,
  ) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(context, lawEnforcementDetailsViewRoute, arguments: {
        "UserElement": model,
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

    BlocProvider.of<LawEnforcementListBloc>(context).add(
      LawEnforcementFetch(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
  }

  void applyFilters(
    Filters model,
  ) {
    log('Applying Filters');

    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    log('id---filtersFun----${filters.filterCriteria!.filters!.id}---');

    BlocProvider.of<LawEnforcementListBloc>(context).add(
      LawEnforcementFetch(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
