import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import '../bloc/event_protections_bloc.dart';

class EventProtectionsView extends StatefulWidget {
  const EventProtectionsView({
    super.key,
  });

  @override
  State<EventProtectionsView> createState() => _EventProtectionsViewState();
}

class _EventProtectionsViewState extends State<EventProtectionsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<EventProtectionsBloc>().add(
          const InitializeValuesEP(),
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

  // void _onScroll() {
  //   if (!_scrollController.hasClients) return;
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.position.pixels;
  //
  //   // Set a threshold value, e.g., 100 pixels from the end
  //   const threshold = 1000.0;
  //
  //   if (maxScroll - currentScroll <= threshold) {
  //     pageNumber = pageNumber + 20;
  //     context
  //         .read<EventProtectionsBloc>()
  //         .add(InwardFetch(startPos: pageNumber, maxPos: 20));
  //   }
  // }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      pageNumber = pageNumber + 20;
      context.read<EventProtectionsBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<EventProtectionsBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<EventProtectionsBloc, EventProtectionsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.cardBgColor,
          // floatingActionButton:
          //     state.extraProperties?.hasWritePermission ?? false
          //         ? Flutterfloatingbutton(
          //             backgroundColor: AppColors.navigationSkyBlueColor,
          //             foregroundColor: AppColors.backgroundWhiteColor,
          //             onPressed: () => {
          //               Navigator.pushNamed(
          //                 context,
          //                 eventProtectionDetailsTabRoute,
          //               )
          //             },
          //           )
          //         : const SizedBox(),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.eventProtectionTitle,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportEPExcel?aps=0',
            pdfAPIName: 'exportEPPDF?aps=0',
          ),
          body: BlocBuilder<EventProtectionsBloc, EventProtectionsState>(
            builder: (context, state) {
              // if (state.status == FormStatus.initial) {
              //   return const BaseLoader();
              // }
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
                                          int.parse(
                                              state.items[index].inputDate ??
                                                  '0'),
                                          Constants
                                              .twentyFourHourDateTimeFormat)
                                      : ''));
                              labels.add(Label(
                                  key: state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.createdby,
                                  value:
                                  '${state.items[index].createdBy?.firstName ?? ''} ${state.items[index].createdBy?.lastName ?? ''}'));
                              labels.add(Label(
                                  key: state.labels?.locale.locationRegion ??
                                      state.labels?.defaultLocale
                                          .locationRegion ??
                                      Constants.region,
                                  value:
                                      state.items[index].locationRegion?.name ??
                                          ''));
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
                                        Constants
                                            .twentyFourHourDateTimeFormat)));
                              }
                              if (!(state
                                  .items[index].eventEndDate.isEmptyOrNull)) {
                                labels.add(Label(
                                    key: state.labels?.locale.eventEndDate ??
                                        state.labels?.defaultLocale
                                            .eventEndDate ??
                                        Constants.eventEndDate,
                                    value: Utils.timestampToDateConversion(
                                        int.tryParse(
                                            state.items[index].eventEndDate ??
                                                '0'),
                                        Constants
                                            .twentyFourHourDateTimeFormat)));
                              }
                              return index >= state.items.length
                                  ? const BaseLoader()
                                  : BaseListTileItem(
                                      id: state.items[index].id,
                                      labels: labels,
                                      status: state.items[index].status,
                                      isMasterGuard: false,
                                      onTap: (selectedIndex) {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return BasePopUpItems(
                                              id: state.items[selectedIndex].id
                                                  .toString(),
                                              labels: labels,
                                              slNo: state
                                                  .items[selectedIndex].slNo,
                                              status: state
                                                  .items[selectedIndex].status,
                                              isMasterGuard: false,
                                              eventType: state
                                                  .items[selectedIndex]
                                                  .eventType,
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
                                          builder:
                                              (BuildContext dialogContext) {
                                            return BasePopUpItems(
                                              id: state.items[selectedIndex].id
                                                  .toString(),
                                              labels: labels,
                                              isMasterGuard: false,
                                              slNo: state
                                                  .items[selectedIndex].slNo,
                                              status: state
                                                  .items[selectedIndex].status,
                                              eventType: state
                                                  .items[selectedIndex]
                                                  .eventType,
                                            );
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
        ConstantsArgument.id: id.toString(),
        'eventStatus': eventStatus,
        ConstantsArgument.title: Constants.eventProtectionTitle,
        ConstantsArgument.isEventProtection: true,
        ConstantsArgument.showEPGridsModel: showEPGridsModel,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      },
    );
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<EventProtectionsBloc>(context).add(
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

    BlocProvider.of<EventProtectionsBloc>(context).add(
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
