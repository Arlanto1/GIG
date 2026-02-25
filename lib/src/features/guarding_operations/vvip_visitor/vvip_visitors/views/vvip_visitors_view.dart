import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/models/vvip_visitor_response_model.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/services/vvip_visitor_services.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/vvip_visitors/bloc/vvip_visitors_bloc.dart';

class VVIPVisitorsView extends StatefulWidget {
  final VIVPVisitorModel? model;

  const VVIPVisitorsView({
    super.key,
    this.model,
  });

  @override
  State<VVIPVisitorsView> createState() => _VVIPVisitorsViewState();
}

class _VVIPVisitorsViewState extends State<VVIPVisitorsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<VVIPVisitorsBloc>().add(
          const InitializeValues(),
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
      context.read<VVIPVisitorsBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<VVIPVisitorsBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<VVIPVisitorsBloc, VVIPVisitorsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.transparent,
            extendBody: true,
            extendBodyBehindAppBar: true,
            // floatingActionButton:
            //     (widget.model?.status != 0 || widget.model?.status != null) &&
            //             (state.extraProperties?.hasWritePermission ?? false)
            //         ? Flutterfloatingbutton(
            //             backgroundColor: AppColors.navigationSkyBlueColor,
            //             foregroundColor: AppColors.backgroundWhiteColor,
            //             onPressed: () => {
            //               Navigator.pushNamed(context, vipVisitorsDetailsRoute,
            //                   arguments: {
            //                     "title": Constants.vVipVisitorsTitle,
            //                   })
            //             },
            //           )
            //         : null,
            bottomNavigationBar: CustomBottomNavigationBar(
              hasAddPermission:  (widget.model?.status != 0 || widget.model?.status != null) &&
                  (state.extraProperties?.hasWritePermission ?? false) ? true : false,
              scaffoldKey: scaffoldKey,
              context: context,
              displayMenu: state.displayMenu,
              list: true, // 🔥 only "+" button mode
              onAddPressed: () {
                Navigator.pushNamed(context, vipVisitorsDetailsRoute,
                    arguments: {
                      "title": Constants.vVipVisitorsTitle,
                    });
              },
            ),
            appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: Constants.vVipVisitorsListTitle,
              showPopUp: true,
              showSaveButton: false,
              showSubmitButton: false,
              showDisLikeButton: false,
              showLikeButton: false,
              excelAPIName: 'exportVipExcel',
              pdfAPIName: 'exportVipPDF',
            ),
            body: BlocBuilder<VVIPVisitorsBloc, VVIPVisitorsState>(
                builder: (context, state) {
              // if (state.status == FormStatus.initial) {
              //   return const BaseLoader();
              // }
              // if (state.items.isEmptyOrNull) {
              //   return const NoRecordFoundWidget();
              // }
                  return Stack(
                    children: [
                      // 🔹 Background
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/bg2.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                            child: Container(
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),

                      // 🔹 Search Bar - positioned safely at the top
                      Positioned(
                        top: MediaQuery
                            .of(context)
                            .padding
                            .top + kToolbarHeight + -40, // below AppBar
                        left: 3,
                        right: 3,
                        child: BaseSearchWidget(
                          applySearchFilters: applySearchFilters,
                          applyFilters: applyFilters,
                          commonFilters: state.commonFilters ??
                              CommonFilters(
                                statuses: [],
                                regions: [],
                              ),
                        ),
                      ),

                      // 🔹 ListView - start immediately below search bar
                      Positioned(
                        top: MediaQuery
                            .of(context)
                            .padding
                            .top + kToolbarHeight + 10,
                        // search bar height ~64+padding
                        left: 0,
                        right: 0,
                        bottom: 0,
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
                          padding: EdgeInsets.zero,
                          itemCount: state.hasReachedMax
                              ? state.items.length
                              : state.items.length + 1,
                          itemBuilder: (context, index) {
                            List<Label> labels = [];
                            if (index < state.items.length) {
                              labels.add(Label(
                                  key: state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      'Created By',
                                  value:
                                      '${state.items[index].entrySecurity?.firstName ?? ''} ${state.items[index].entrySecurity?.lastName ?? ''}'));
                              labels.add(Label(
                                  key: state.labels?.locale.slNo ??
                                      state.labels?.defaultLocale.slNo ??
                                      'SL No',
                                  value: state.items[index].slNo ?? ''));
                              labels.add(Label(
                                  key: state.labels?.locale.inputDate ??
                                      state.labels?.defaultLocale.inputDate ??
                                      'Date of Creation',
                                  value: state.items[index].inputDate != null
                                      ? Utils.timestampToDateConversion(
                                          int.parse(
                                              state.items[index].inputDate ??
                                                  '0'),
                                          Constants
                                              .twentyFourHourDateTimeFormat)
                                      : ''));
                              labels.add(Label(
                                  key: state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      'Location',
                                  value:
                                      state.items[index].location?.name ?? ''));
                            }
                            return index >= state.items.length
                                ? const BaseLoader()
                                : Container(
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
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: BackdropFilter(
                                        filter:
                                        ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                                        child: Container(
                                decoration:
                                BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withValues(alpha: 0.09),
                                      Colors.transparent,
                                      Colors.white.withValues(alpha: 0.09),
                                      // Color(0xFF6474C6).withOpacity(0.14)
                                    ],
                                    stops: [0.02, 0.35, 1],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(27),
                                  border: Border.all(
                                    color: Colors.white
                                        .withValues(alpha: 0.6),
                                    width: 0.7,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white
                                          .withValues(alpha: 0.0),
                                      blurRadius: 12,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child:BaseListTileItem(
                                    id: state.items[index].id,
                                    labels: labels,
                                    status: state.items[index].status,
                                    isVipStatus: true,
                                    isEventProtectionStatus: false,
                                    onTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.items[selectedIndex].id
                                                .toString(),
                                            labels: labels,
                                            status: state
                                                .items[selectedIndex].status,
                                            isVipStatus: true,
                                            isEventProtectionStatus: false,
                                            isMasterGuard: false,
                                          );
                                        },
                                      );
                                    },
                                    showEditButton:
                                        state.items[index].status ==
                                            ConstantsIntValue.vVIPCreatedStatus,
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
                                          return BasePopUpItems(
                                            id: state.items[selectedIndex].id
                                                .toString(),
                                            labels: labels,
                                            status: state
                                                .items[selectedIndex].status,
                                            isVipStatus: true,
                                            isEventProtectionStatus: false,
                                            isMasterGuard: false,
                                          );
                                        },
                                      );
                                    },
                                    index: index,
                                ) ))));
                          },
                        ),
                      ),
                    ),
                  ],
              );
            }));
      },
    );
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    VIVPVisitorModel model = await VVIPVisitorServices().getGVipById(id);

    editDataLoading(model, hasWritePermission);
  }

  void editDataLoading(VIVPVisitorModel? model, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        vipVisitorsDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.vVipVisitorsTitle,
          ConstantsArgument.extraProperties:
              ExtraProperties(hasWritePermission: hasWritePermission),
        },
      );
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<VVIPVisitorsBloc>(context).add(
      FetchData(
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

    BlocProvider.of<VVIPVisitorsBloc>(context).add(
      FetchData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
