import 'package:db_atom/index.dart';
import '../bloc/occurrences_bloc.dart';
import 'dart:ui';

class OccurrencesView extends StatefulWidget {
  const OccurrencesView({
    super.key,
  });

  @override
  State<OccurrencesView> createState() => _OccurrencesViewState();
}

class _OccurrencesViewState extends State<OccurrencesView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<OccurrencesBloc>().add(
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
      context.read<OccurrencesBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<OccurrencesBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<OccurrencesBloc, OccurrencesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          extendBody: true,
          extendBodyBehindAppBar: true,

          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: true,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true,
            onAddPressed: () {
              Navigator.pushNamed(
                context,
                shiftOccurrenceDetailsRoute,
                arguments: {
                  "title": Constants.createOccurrence,
                },
              );
            },
          ),

          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.occurrenceListTitle,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportOCCExcel',
            pdfAPIName: 'exportOCCPDF',
          ),

          body: BlocBuilder<OccurrencesBloc, OccurrencesState>(
            builder: (context, state) {
              return Stack(
                children: [
                  // // 🔹 Background
                  // Positioned.fill(
                  //   child: Image.asset(
                  //     'assets/images/bg2.png',
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  // Positioned.fill(
                  //   child: ClipRect(
                  //     child: BackdropFilter(
                  //       filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                  //       child: Container(
                  //         color: Colors.black.withValues(alpha: 0.2),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // 🔹 Search Bar - positioned safely at the top
                  Positioned(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight + -40, // below AppBar
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
                    top: MediaQuery.of(context).padding.top + kToolbarHeight + 2, // search bar height ~64+padding
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
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: state.hasReachedMax
                            ? state.list.length
                            : state.list.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.list.length) {
                            if (state.status == FormStatus.loading) {
                              return const Center(child: BaseLoader());
                            }
                            return const SizedBox();
                          }
                          final item = state.list[index];

                          // Build labels
                          List<Label> labels = [
                            Label(
                                key: state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                value: item.inputDate != null
                                    ? Utils.timestampToDateConversion(
                                    int.parse(item.inputDate ?? '0'),
                                    Constants.twentyFourHourDateTimeFormat)
                                    : ''),
                            Label(
                                key: state.labels?.locale.locationRegion ??
                                    state.labels?.defaultLocale.locationRegion ??
                                    Constants.region,
                                value: item.locationRegion?.name ?? ''),
                            Label(
                                key: state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                value: item.location?.name ?? ''),
                            Label(
                                key: state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.shiftHandoverBy,
                                value:
                                '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}'),
                          ];

                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withValues(alpha: 0.09),
                                        Colors.transparent,
                                        Colors.white.withValues(alpha: 0.09),
                                      ],
                                      stops: const [0.02, 0.35, 1],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(27),
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.6),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withValues(alpha: 0.0),
                                        blurRadius: 12,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: BaseListTileItem(
                                    id: item.id,
                                    labels: labels,
                                    status: item.status,
                                    isOccurrenceStatus: true,
                                    isEventProtectionStatus: false,
                                    index: index,
                                    onTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (dialogContext) => BasePopUpItems(
                                          id: state.list[selectedIndex].id.toString(),
                                          slNo: state.list[selectedIndex].slNo,
                                          status: state.list[selectedIndex].status,
                                          labels: labels,
                                          shiftBrfngAttnded: state.list[selectedIndex].shiftBrfngAttnded,
                                          materialMovement: state.list[selectedIndex].materialMovement,
                                          leoVisit: state.list[selectedIndex].leoVisit,
                                          handOverSecurity: state.list[selectedIndex].handoverSecurity,
                                          isOccurrenceStatus: true,
                                          isMasterGuard: false,
                                          isEventProtectionStatus: false,
                                        ),
                                      );
                                    },
                                    showEditButton: item.status == ConstantsIntValue.occurrenceStatusCreated,
                                    onEditTap: (selectedIndex) {
                                      getId(
                                          state.extraProperties?.hasWritePermission ?? false,
                                          id: item.id ?? 0);
                                    },
                                    onViewTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (dialogContext) => BasePopUpItems(
                                          id: state.list[selectedIndex].id.toString(),
                                          slNo: state.list[selectedIndex].slNo,
                                          status: state.list[selectedIndex].status,
                                          labels: labels,
                                          shiftBrfngAttnded: state.list[selectedIndex].shiftBrfngAttnded,
                                          materialMovement: state.list[selectedIndex].materialMovement,
                                          leoVisit: state.list[selectedIndex].leoVisit,
                                          handOverSecurity: state.list[selectedIndex].handoverSecurity,
                                          isEventProtectionStatus: false,
                                          isMasterGuard: false,
                                          isOccurrenceStatus: true,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );

      },
    );
  }

  getId(
    bool hasWritePermission, {
    required int id,
  }) async {
    Navigator.pushNamed(
      context,
      shiftOccurrenceDetailsRoute,
      arguments: {
        'id': id.toString(),
        "title": Constants.editOccurrence,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      },
    );
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<OccurrencesBloc>(context).add(
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

    BlocProvider.of<OccurrencesBloc>(context).add(
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
