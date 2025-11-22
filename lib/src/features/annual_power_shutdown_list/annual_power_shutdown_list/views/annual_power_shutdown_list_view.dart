import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import '../../../event_protection/services/event_protection_services.dart';
import '../bloc/annual_power_shutdown_list_bloc.dart';

class AnnualPowerShutdownListView extends StatefulWidget {
  const AnnualPowerShutdownListView({
    super.key,
  });

  @override
  State<AnnualPowerShutdownListView> createState() =>
      _AnnualPowerShutdownListViewState();
}

class _AnnualPowerShutdownListViewState
    extends State<AnnualPowerShutdownListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<AnnualPowerShutdownListBloc>().add(
          const InitializeValuesAPS(),
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
      context.read<AnnualPowerShutdownListBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<AnnualPowerShutdownListBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<AnnualPowerShutdownListBloc,
        AnnualPowerShutdownListState>(listener: (context, state) {
      log('--state.status---${state.status}--');

      Utils().formError(state, context);
      Utils().errorAndLogout(state, context);
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor:AppColors.lavender,
        // floatingActionButton: state.extraProperties?.hasWritePermission ?? false
        //     ? Flutterfloatingbutton(
        //         backgroundColor: AppColors.navigationSkyBlueColor,
        //         foregroundColor: AppColors.backgroundWhiteColor,
        //         onPressed: () => {
        //           Navigator.pushNamed(
        //             context,
        //             annualPowerShutdownListDetailsRoute,
        //           )
        //         },
        //       )
        //     : const SizedBox(),
        bottomNavigationBar: CustomBottomNavigationBar(
          hasAddPermission: false,
          scaffoldKey: scaffoldKey,
          context: context,
          displayMenu: state.displayMenu,
          list: true, // 🔥 only "+" button mode
          onAddPressed: () {
            // Navigator.pushNamed(
            //   context,
            //   articleFoundNewDetailsRoute,
            //   arguments: {"title": Constants.createFound},
            // );
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.annualPowerShutdownListTitle,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'exportEPExcel?aps=1',
          pdfAPIName: 'exportEPPDF?aps=1',
        ),
        body: BlocBuilder<AnnualPowerShutdownListBloc,
            AnnualPowerShutdownListState>(
          builder: (context, state) {
            return Container(
              width:double.infinity,
              height: double.infinity,
              color: const Color(0xFF6474C6),
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
                  CommonWidgets.verticalSpacerWidget(height * 0.01),
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
                                key: state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                value: state.items[index].inputDate != null
                                    ? Utils.timestampToDateConversion(
                                        int.tryParse(
                                            state.items[index].inputDate ??
                                                '0'),
                                        Constants.twentyFourHourDateTimeFormat)
                                    : ''));
                            labels.add(Label(
                                key: state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                value:
                                    '${state.items[index].createdBy?.firstName ?? ''} ${state.items[index].createdBy?.lastName ?? ''}'));
                            labels.add(Label(
                                key: state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                value:
                                    state.items[index].location?.name ?? ''));

                            if (!state
                                .items[index].eventStartDate.isEmptyOrNull) {
                              labels.add(Label(
                                  key: state.labels?.locale.eventStartDate ??
                                      state.labels?.defaultLocale
                                          .eventStartDate ??
                                      Constants.eventStartDate,
                                  value: Utils.timestampToDateConversion(
                                      int.tryParse(
                                          state.items[index].eventStartDate ??
                                              '0'),
                                      Constants.twentyFourHourDateTimeFormat)));
                            }
                            if (!state
                                .items[index].eventEndDate.isEmptyOrNull) {
                              labels.add(Label(
                                  key: state.labels?.locale.eventEndDate ??
                                      state
                                          .labels?.defaultLocale.eventEndDate ??
                                      Constants.eventEndDate,
                                  value: Utils.timestampToDateConversion(
                                      int.tryParse(
                                          state.items[index].eventEndDate ??
                                              '0'),
                                      Constants.twentyFourHourDateTimeFormat)));
                            }
                            labels.add(Label(
                              key: state.labels?.locale.budget ??
                                  state.labels?.defaultLocale.budget ??
                                  Constants.budget,
                              value: (double.tryParse(state.items[index].budget
                                              ?.toString() ??
                                          '0.0')
                                      ?.toString() ??
                                  '0.0'),
                            ));

                            return index >= state.items.length
                                ? const BaseLoader()
                                : Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFF6474C6), Color(0xFF6474C6)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.white.withValues(alpha: 0.2),
                                              Colors.transparent,
                                              Colors.white.withValues(alpha: 0.2),
                                              // Color(0xFF6474C6).withOpacity(0.14)
                                            ],
                                            stops: [0.02, 0.35, 1],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius: BorderRadius.circular(27),
                                          border: Border.all(
                                            color: Colors.white.withValues(alpha: 0.80),
                                            width: 0.8,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF6474C6).withValues(alpha: 0.09),
                                              blurRadius: 12,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child:
                           BaseListTileItem(
                                    id: state.items[index].id,
                                    labels: labels,
                                    status: state.items[index].status,
                                    isMasterGuard: false,
                                    isEventProtectionStatus: true,
                                    onTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.items[selectedIndex].id
                                                .toString(),
                                            labels: labels,
                                            slNo:
                                                state.items[selectedIndex].slNo,
                                            status: state
                                                .items[selectedIndex].status,
                                            isMasterGuard: false,
                                            isEventProtectionStatus: true,
                                            eventType: state
                                                .items[selectedIndex].eventType,
                                          );
                                        },
                                      );
                                    },
                                    onEditTap: (selectedIndex) {
                                      getById(
                                          state.extraProperties
                                                  ?.hasWritePermission ??
                                              false,
                                          id: state.items[index].id ?? 0,
                                          eventStatus:
                                              state.items[index].status ?? 0);
                                    },
                                    onViewTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.items[selectedIndex].id
                                                .toString(),
                                            labels: labels,
                                            slNo:
                                                state.items[selectedIndex].slNo,
                                            eventType: state
                                                .items[selectedIndex].eventType,
                                            status: state
                                                .items[selectedIndex].status,
                                            isEventProtectionStatus: true,
                                            isMasterGuard: false,
                                            // epManager1Name:
                                            // state.items[selectedIndex].epManager1Name,
                                            // eventType:
                                            // state.items[selectedIndex].eventType,
                                          );
                                        },
                                      );
                                    },
                                    index: index,
                           ), ))));
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
    });
  }

  getById(
    bool hasWritePermission, {
    required int id,
    required int eventStatus,
  }) async {
    log('-----');
    var nav = Navigator.of(context);
    ShowEPGridsModel showEPGridsModel =
        await EventProtectionServices().showEpGrids(id);
    nav.pushNamed(
      eventProtectionDetailsTabRoute,
      arguments: {
        ConstantsArgument.title: Constants.annualPowerShutdownListDetails,
        'id': id.toString(),
        'eventStatus': eventStatus,
        ConstantsArgument.showEPGridsModel: showEPGridsModel,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      },
    );
  }

  // getId(
  //   bool hasWritePermission, {
  //   required int id,
  //   required int eventStatus,
  // }) async {
  //   Navigator.pushNamed(
  //     context,
  //     annualPowerShutdownListDetailsRoute,
  //     arguments: {
  //       'id': id.toString(),
  //       ConstantsArgument.extraProperties:
  //           ExtraProperties(hasWritePermission: hasWritePermission),
  //     },
  //   );
  // }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<AnnualPowerShutdownListBloc>(context).add(
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
    log('Applying Filters');

    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    log('id---filtersFun----${filters.filterCriteria!.filters!.id}---');

    BlocProvider.of<AnnualPowerShutdownListBloc>(context).add(
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
