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
    final size = MediaQuery.of(context).size;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    double height = size.height;
    return BlocConsumer<OccurrencesBloc, OccurrencesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.lavender,
            bottomNavigationBar: CustomBottomNavigationBar(
              hasAddPermission: true,
              scaffoldKey: scaffoldKey,
              context: context,
              displayMenu: state.displayMenu,
              list: true, // 🔥 only "+" button mode
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
            // floatingActionButton: state.extraProperties?.hasWritePermission ??
            //         false
            //     ? Flutterfloatingbutton(
            //         backgroundColor: AppColors.navigationSkyBlueColor,
            //         foregroundColor: AppColors.backgroundWhiteColor,
            //         onPressed: () => {
            //           Navigator.pushNamed(context, shiftOccurrenceDetailsRoute,
            //               arguments: {
            //                 "title": Constants.createOccurrence,
            //               }),
            //         },
            //       )
            //     : const SizedBox(),
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
              // if (state.status == FormStatus.initial) {
              //   return const BaseLoader();
              // }
              // if (state.list.isEmpty) {
              //   return const NoRecordFoundWidget();
              // }
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xFF6474C6),
                // color: Colors.black,
                // margin: allMargin16,
                // decoration: const ShapeDecoration(
                //     color: AppColors.backgroundWhiteColor,
                //     shape: RoundedRectangleBorder(
                //       borderRadius:
                //           BorderRadius.vertical(top: Radius.circular(20.0)),
                //     )),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10),
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
                    // if (state.status == FormStatus.loading) ...[
                    //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                    //   const BaseLoader(),
                    //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                    // ],
                    // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                    // Text('state.status=====${state.status}'),
                    UtilsCommon().showNoRecordWidget(
                        state: state, height: height, items: state.list),
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
                              ? state.list.length
                              : state.list.length + 1,
                          itemBuilder: (context, index) {
                            List<Label> labels = [];
                            if (index < state.list.length) {
                              labels.add(
                                Label(
                                    key: state.labels?.locale.inputDate ??
                                        state.labels?.defaultLocale.inputDate ??
                                        Constants.dateofcreation,
                                    value: state.list[index].inputDate != null
                                        ? Utils.timestampToDateConversion(
                                            int.parse(
                                                state.list[index].inputDate ??
                                                    '0'),
                                            Constants
                                                .twentyFourHourDateTimeFormat)
                                        : ''),
                              );
                              labels.add(Label(
                                  key: state.labels?.locale.locationRegion ??
                                      state.labels?.defaultLocale
                                          .locationRegion ??
                                      Constants.region,
                                  value:
                                      state.list[index].locationRegion?.name ??
                                          ''));
                              labels.add(Label(
                                  key: state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.location,
                                  value:
                                      state.list[index].location?.name ?? ''));
                              labels.add(Label(
                                  key: state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.shiftHandoverBy,
                                  value:
                                      '${state.list[index].entrySecurity?.firstName ?? ''} ${state.list[index].entrySecurity?.lastName ?? ''}'));
                              return index >= state.list.length
                                  ? const BaseLoader()
                                  : Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF6474C6),
                                        Color(0xFF6474C6)
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
                                          filter: ImageFilter.blur(
                                              sigmaX: 18, sigmaY: 18),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white
                                                        .withValues(alpha: 0.2),
                                                    Colors.transparent,
                                                    Colors.white
                                                        .withValues(alpha: 0.2),
                                                    // Color(0xFF6474C6).withOpacity(0.14)
                                                  ],
                                                  stops: [0.02, 0.35, 1],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(27),
                                                border: Border.all(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.80),
                                                  width: 0.8,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xFF6474C6)
                                                            .withValues(
                                                                alpha: 0.09),
                                                    blurRadius: 12,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),

                                              // index >= state.list.length
                                              //   ? const BaseLoader()
                                              child: BaseListTileItem(
                                                id: state.list[index].id,
                                                labels: labels,
                                                status:
                                                    state.list[index].status,
                                                isOccurrenceStatus: true,
                                                isEventProtectionStatus: false,
                                                onTap: (selectedIndex) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                        dialogContext) {
                                                      return BasePopUpItems(
                                                        id: state
                                                            .list[selectedIndex]
                                                            .id
                                                            .toString(),
                                                        slNo: state
                                                            .list[selectedIndex]
                                                            .slNo,
                                                        status: state
                                                            .list[selectedIndex]
                                                            .status,
                                                        labels: labels,
                                                        shiftBrfngAttnded: state
                                                            .list[selectedIndex]
                                                            .shiftBrfngAttnded,
                                                        materialMovement: state
                                                            .list[selectedIndex]
                                                            .materialMovement,
                                                        leoVisit: state
                                                            .list[selectedIndex]
                                                            .leoVisit,
                                                        handOverSecurity: state
                                                            .list[selectedIndex]
                                                            .handoverSecurity,
                                                        isOccurrenceStatus:
                                                            true,
                                                        isMasterGuard: false,
                                                        isEventProtectionStatus:
                                                            false,
                                                      );
                                                    },
                                                  );
                                                },
                                                showEditButton: state
                                                        .list[index].status ==
                                                    ConstantsIntValue
                                                        .occurrenceStatusCreated,
                                                onEditTap: (selectedIndex) {
                                                  getId(
                                                      state.extraProperties
                                                              ?.hasWritePermission ??
                                                          false,
                                                      id: state
                                                              .list[index].id ??
                                                          0);
                                                },
                                                onViewTap: (selectedIndex) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                        dialogContext) {
                                                      return BasePopUpItems(
                                                        id: state
                                                            .list[selectedIndex]
                                                            .id
                                                            .toString(),
                                                        slNo: state
                                                            .list[selectedIndex]
                                                            .slNo,
                                                        status: state
                                                            .list[selectedIndex]
                                                            .status,
                                                        labels: labels,
                                                        shiftBrfngAttnded: state
                                                            .list[selectedIndex]
                                                            .shiftBrfngAttnded,
                                                        materialMovement: state
                                                            .list[selectedIndex]
                                                            .materialMovement,
                                                        leoVisit: state
                                                            .list[selectedIndex]
                                                            .leoVisit,
                                                        handOverSecurity: state
                                                            .list[selectedIndex]
                                                            .handoverSecurity,
                                                        isEventProtectionStatus:
                                                            false,
                                                        isMasterGuard: false,
                                                        isOccurrenceStatus:
                                                            true,
                                                      );
                                                    },
                                                  );
                                                },
                                                index: index,
                                              )))));
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
