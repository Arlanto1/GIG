
import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/transport_medical_incident/models/transport_medical_incident_model.dart';
import 'package:db_atom/src/features/transport_medical_incident/services/transport_medical_service.dart';
import 'package:db_atom/src/features/transport_medical_incident/transport_medical_list/bloc/transport_medical_list_bloc.dart';

class TransportMedicalListView extends StatefulWidget {
  const TransportMedicalListView({
    super.key,
    required this.isTransport,
  });

final bool isTransport;
  @override
  State<TransportMedicalListView> createState() =>
      _TransportMedicalListViewState();
}

class _TransportMedicalListViewState extends State<TransportMedicalListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<TransportMedicalBloc>().add(
      const InitializeValuesTM(),
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
      context.read<TransportMedicalBloc>().add(FetchTMData(
        startPos: pageNumber,
        maxPos: Constants.maxResults,
        newSearch: false,
        filters: filters,
      ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<TransportMedicalBloc>().add(
      const RefreshList(),
    );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    log('widget.isTransport${widget.isTransport}');
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<TransportMedicalBloc, TransportMedicalState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.formError &&
            state.message != null &&
            state.message!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }

      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          extendBodyBehindAppBar: true,
          // floatingActionButton: (state.extraProperties?.hasWritePermission ??
          //             false) &&
          //         (widget.occId.isEmptyOrNull) &&
          //         (widget.kldId.isEmptyOrNull)
          //
          //     /// disable + icon when navigating via Shift Occurrence or via Key Issuance
          //     ? Flutterfloatingbutton(
          //         backgroundColor: AppColors.navigationSkyBlueColor,
          //         foregroundColor: AppColors.backgroundWhiteColor,
          //         onPressed: () => {
          //           Navigator.pushNamed(
          //             context,
          //             incidentManagementDetailsRoute,
          //             arguments: {
          //               'occId': widget.occId?.toString(),
          //               'occType': widget.occType,
          //               'kldId': widget.kldId?.toString(),
          //             },
          //           )
          //         },
          //       )
          //     : const SizedBox(),
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: (state.extraProperties?.hasWritePermission ??
                false) ,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true, // 🔥 only "+" button mode
            onAddPressed: () {
              Navigator.popAndPushNamed(
                context,
                transportMedicalDetailsRoute,
                arguments: {
                   ConstantsArgument.title: widget.isTransport ? Constants.transportIncidentList : Constants.medicalEmergencyTitle,
                ConstantsArgument.isTransport: widget.isTransport },
              );
            },
          ),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.isTransport ? Constants.transportIncidentList : Constants.medicalEmergencyTitle,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportIMExcel',
            pdfAPIName: 'exportIMPdf',
          ),
          body:
          BlocBuilder<TransportMedicalBloc, TransportMedicalState>(
              builder: (context, state) {
                log('state.extraProperties?.hasWritePermission ${state.extraProperties?.hasWritePermission}');
                // if (state.items.isEmpty) {
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
                            color: Colors.black.withValues(alpha: 0.2),
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
                      child: state.status == FormStatus.loading
                          ? const Center(
                        child: BaseLoader(),
                      ) : CustomMaterialIndicator(
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
                              labels.add(
                                Label(
                                  key: state.labels?.locale.locationRegion ??
                                      state.labels?.defaultLocale
                                          .locationRegion ??
                                      Constants.region,
                                  value:
                                  state.items[index].locationRegion?.name ??
                                      '',
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.location,
                                  value:
                                  state.items[index].location?.name ?? '',
                                ),
                              );
                              labels.add(Label(
                                  key: state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.createdby,
                                  value:
                                  '${state.items[index].entrySecurity?.firstName ?? ''} ${state.items[index].entrySecurity?.lastName ?? ''}'));
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
                                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
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
                                                  stops: const [0.02, 0.35, 1],
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
                                                transportIncidentType:
                                                state.items[index].incidentType,
                                                isMasterGuard: false,
                                                isEventProtectionStatus: false,
                                                isTransportStatus: true,
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
                                                        transportIncidentType: state
                                                            .items[selectedIndex]
                                                            .incidentType,
                                                        isMasterGuard: false,
                                                        isEventProtectionStatus: false,
                                                        isTransportStatus: true,
                                                      );
                                                    },
                                                  );
                                                },
                                                showEditButton:
                                                state.items[index].status ==
                                                    ConstantsIntValue
                                                        .incidentCreatedStatus ||
                                                  state.items[index].status ==
                                                      ConstantsIntValue.transportIncidentOpenStatus,
                                                onEditTap: (selectedIndex) {
                                                  getById(
                                                      state.extraProperties
                                                          ?.hasWritePermission ??
                                                          false,
                                                      state.items[index]
                                                          .id ??
                                                          0);
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
                                                        slNo: state
                                                            .items[selectedIndex].slNo,
                                                        status: state
                                                            .items[selectedIndex].status,
                                                        isMasterGuard: false,
                                                        isEventProtectionStatus: false,
                                                        isIncident: true,
                                                        transportIncidentType: state
                                                            .items[selectedIndex]
                                                            .incidentType,
                                                      );
                                                    },
                                                  );
                                                },
                                                index: index,
                                              )))) );
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
                );
              }),
        );
      },
    );
  }

  // getById(bool hasWritePermission,
  //     {required int id}) async {
  //   Navigator.pushNamed(
  //     context,
  //     transportMedicalDetailsRoute,
  //     arguments: {
  //       ConstantsArgument.title: widget.isTransport ? Constants.transportIncidentList : Constants.medicalEmergencyTitle,
  //       ConstantsArgument.id: id.toString(),
  //       ConstantsArgument.extraProperties:
  //       ExtraProperties(hasWritePermission: hasWritePermission),
  //       ConstantsArgument.isTransport : widget.isTransport
  //     },
  //   );
  // }
  getById(bool hasWritePermission,int id) async {
    showLoadingDialog(context);

    TransportMedicalModel model =
    await TransportMedicalServices().getTransportById(id.toString());

    editDataLoading(model, hasWritePermission);
  }

  void editDataLoading(
      TransportMedicalModel? model, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(context, transportMedicalDetailsRoute, arguments: {
        "model": model,
        "title": Constants.editDayPassManagementTitle,
        ConstantsArgument.extraProperties:
        ExtraProperties(hasWritePermission: hasWritePermission),
        ConstantsArgument.isTransport : widget.isTransport
      });
    }
  }


  void applySearchFilters(
      FilterCriteria model,
      ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<TransportMedicalBloc>(context).add(
      FetchTMData(
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

    BlocProvider.of<TransportMedicalBloc>(context).add(
      FetchTMData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}

// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/transport_medical_incident/models/transport_medical_incident_model.dart';
// import 'package:db_atom/src/features/transport_medical_incident/services/transport_medical_service.dart';
// import 'package:db_atom/src/features/transport_medical_incident/transport_medical_list/bloc/transport_medical_list_bloc.dart';
//
// class TransportMedicalListView extends StatefulWidget {
//   const TransportMedicalListView({
//     super.key,
//     required this.isTransport,
//   });
//
//   final bool isTransport;
//
//   @override
//   State<TransportMedicalListView> createState() =>
//       _TransportMedicalListViewState();
// }
//
// class _TransportMedicalListViewState extends State<TransportMedicalListView> {
//   //  All keys and controllers declared as fields, NOT inside build()
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   late final ScrollController _scrollController;
//
//   int _pageNumber = 0;
//   BaseFilterModel _filters = BaseFilterModel();
//
//   //  Cache the blurred background — built once, never rebuilt
//   static final Widget _cachedBackground = Stack(
//     children: [
//       Positioned.fill(
//         child: Image.asset(
//           'assets/images/bg2.png',
//           fit: BoxFit.cover,
//           // cacheWidth/cacheHeight reduces memory if image is large
//         ),
//       ),
//       Positioned.fill(
//         child: ClipRect(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
//             child: const ColoredBox(
//               color: Colors.black12,
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<TransportMedicalBloc>().add(const InitializeValuesTM());
//     _scrollController = ScrollController()..addListener(_onScroll);
//   }
//
//   @override
//   void dispose() {
//     _scrollController
//       ..removeListener(_onScroll)
//       ..dispose();
//     super.dispose();
//   }
//
//   void _onScroll() {
//     if (!_scrollController.hasClients) return;
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.position.pixels;
//     if (currentScroll == maxScroll) {
//       _pageNumber += 20;
//       context.read<TransportMedicalBloc>().add(FetchTMData(
//         startPos: _pageNumber,
//         maxPos: Constants.maxResults,
//         newSearch: false,
//         filters: _filters,
//       ));
//     }
//   }
//
//   Future<void> _onRefresh() async {
//     context.read<TransportMedicalBloc>().add(const RefreshList());
//     await Future.delayed(const Duration(milliseconds: 2000));
//   }
//
//   // Build labels outside itemBuilder — called once per item, not per frame
//   List<Label> _buildLabels(TransportMedicalState state, int index) {
//     final item = state.items[index];
//     final locale = state.labels?.locale;
//     final defaultLocale = state.labels?.defaultLocale;
//
//     return [
//       Label(
//         key: locale?.inputDate ?? defaultLocale?.inputDate ?? Constants.dateofcreation,
//         value: item.inputDate != null
//             ? Utils.timestampToDateConversion(
//           int.parse(item.inputDate ?? '0'),
//           Constants.twentyFourHourDateTimeFormat,
//         )
//             : '',
//       ),
//       Label(
//         key: locale?.locationRegion ?? defaultLocale?.locationRegion ?? Constants.region,
//         value: item.locationRegion?.name ?? '',
//       ),
//       Label(
//         key: locale?.location ?? defaultLocale?.location ?? Constants.location,
//         value: item.location?.name ?? '',
//       ),
//       Label(
//         key: locale?.entrySecurity ?? defaultLocale?.entrySecurity ?? Constants.createdby,
//         value:
//         '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}',
//       ),
//     ];
//   }
//
//   void _showItemDialog(BuildContext context, TransportMedicalState state, int index,
//       {bool isIncident = false}) {
//     final labels = _buildLabels(state, index);
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return BasePopUpItems(
//           id: state.items[index].id.toString(),
//           labels: labels,
//           slNo: state.items[index].slNo,
//           status: state.items[index].status,
//           incidentType: state.items[index].incidentType,
//           isMasterGuard: false,
//           isEventProtectionStatus: false,
//           isTransportStatus: !isIncident,
//           isIncident: isIncident,
//         );
//       },
//     );
//   }
//
//   Future<void> _onEditTap(bool hasWritePermission, int id) async {
//     showLoadingDialog(context);
//     try {
//       final TransportMedicalModel model =
//       await TransportMedicalServices().getTransportById(id.toString());
//       if (!mounted) return;
//       dismissLoadingDialog(context);
//       _navigateToDetails(model, hasWritePermission);
//     } catch (e) {
//       if (!mounted) return;
//       dismissLoadingDialog(context);
//       log('Error fetching transport by id: $e');
//     }
//   }
//
//   void _navigateToDetails(TransportMedicalModel? model, bool hasWritePermission) {
//     if (model == null) return;
//     Navigator.pushNamed(context, transportMedicalDetailsRoute, arguments: {
//       'model': model,
//       'title': Constants.editDayPassManagementTitle,
//       ConstantsArgument.extraProperties:
//       ExtraProperties(hasWritePermission: hasWritePermission),
//       ConstantsArgument.isTransport: widget.isTransport,
//     });
//   }
//
//   void applySearchFilters(FilterCriteria model) {
//     log('Applying Search Filters');
//     _filters = BaseFilterModel(filterCriteria: model);
//     context.read<TransportMedicalBloc>().add(
//       FetchTMData(
//         startPos: 0,
//         maxPos: Constants.maxResults,
//         newSearch: true,
//         filters: _filters,
//       ),
//     );
//   }
//
//   void applyFilters(Filters model) {
//     log('Applying Filters');
//     _filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
//     log('id---filtersFun----${_filters.filterCriteria!.filters!.id}---');
//     context.read<TransportMedicalBloc>().add(
//       FetchTMData(
//         startPos: 0,
//         maxPos: Constants.maxResults,
//         newSearch: true,
//         filters: _filters,
//       ),
//     );
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final scaffoldKey = GlobalKey<ScaffoldState>();
//     //  Single BlocConsumer only — removed nested BlocBuilder
//     return BlocConsumer<TransportMedicalBloc, TransportMedicalState>(
//       listener: (context, state) {
//         log('state.extraProperties?.hasWritePermission ${state.extraProperties?.hasWritePermission}');
//
//         Utils().formError(state, context);
//         Utils().errorAndLogout(state, context);
//       },
//
//       //  buildWhen prevents unnecessary rebuilds when unrelated state changes
//       buildWhen: (previous, current) =>
//       previous.items != current.items ||
//           previous.hasReachedMax != current.hasReachedMax ||
//           previous.displayMenu != current.displayMenu ||
//           previous.extraProperties != current.extraProperties ||
//           previous.commonFilters != current.commonFilters,
//       builder: (context, state) {
//         final hasWritePermission = state.extraProperties?.hasWritePermission ?? false;
//         final title = widget.isTransport
//             ? Constants.transportIncidentList
//             : Constants.medicalEmergencyTitle;
//
//         return Scaffold(
//           key: _scaffoldKey, // using field key
//           backgroundColor: Colors.transparent,
//           extendBody: true,
//           extendBodyBehindAppBar: true,
//           // bottomNavigationBar: CustomBottomNavigationBar(
//           //   hasAddPermission: (state.extraProperties?.hasWritePermission ??
//           //     false) ? true : false,
//           //   scaffoldKey: _scaffoldKey,
//           //   context: context,
//           //   displayMenu: state.displayMenu,
//           //   list: true,
//           //   onAddPressed: () {
//           //     Navigator.popAndPushNamed(
//           //       context,
//           //       transportMedicalDetailsRoute,
//           //       arguments: {
//           //         ConstantsArgument.title: title,
//           //         ConstantsArgument.isTransport: widget.isTransport,
//           //       },
//           //     );
//           //   },
//           // ),
//           bottomNavigationBar: CustomBottomNavigationBar(
//             hasAddPermission: (state.extraProperties?.hasWritePermission ??
//                 false) ? true : false,
//             scaffoldKey: scaffoldKey,
//             context: context,
//             displayMenu: state.displayMenu,
//             list: true, // 🔥 only "+" button mode
//             onAddPressed: () {
//               Navigator.pushNamed(
//                 context,
//                 incidentManagementDetailsRoute,
//                 arguments: {
//
//                 },
//               );
//             },
//           ),
//           appBar: BaseAppBar().buildAppHeader(
//             context: context,
//             title: title,
//             showPopUp: true,
//             showSaveButton: false,
//             showSubmitButton: false,
//             showDisLikeButton: false,
//             showLikeButton: false,
//             excelAPIName: 'exportIMExcel',
//             pdfAPIName: 'exportIMPdf',
//           ),
//           body: Stack(
//             children: [
//               //  Static cached background — never rebuilt
//               _cachedBackground,
//
//               // Search bar
//               Positioned(
//                 //  statusBar + appBar height = correct position just below AppBar
//                 top: MediaQuery.of(context).padding.top + kToolbarHeight + 10,
//                 left: 3,
//                 right: 3,
//                 child: BaseSearchWidget(
//                   applySearchFilters: applySearchFilters,
//                   applyFilters: applyFilters,
//                   commonFilters: state.commonFilters ??
//                       CommonFilters(statuses: [], regions: []),
//                 ),
//               ),
//
//               // List — starts below search bar (search bar height ~56)
//               Positioned(
//                 top: MediaQuery.of(context).padding.top + kToolbarHeight + 56,
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: CustomMaterialIndicator(
//                   onRefresh: _onRefresh,
//                   backgroundColor: Colors.white,
//                   indicatorBuilder: (context, controller) {
//                     return const Padding(
//                       padding: EdgeInsets.all(6.0),
//                       child: BaseLoader(),
//                     );
//                   },
//                   child: ListView.builder(
//                     controller: _scrollController,
//                     padding: const EdgeInsets.only(bottom: 100),
//                     // addAutomaticKeepAlives/addRepaintBoundaries false
//                     // since we handle this ourselves
//                     addAutomaticKeepAlives: false,
//                     addRepaintBoundaries: false,
//                     itemCount: state.hasReachedMax
//                         ? state.items.length
//                         : state.items.length + 1,
//                     itemBuilder: (context, index) {
//                       // Loading indicator at end of list
//                       if (index >= state.items.length ) {
//                         return const SizedBox();
//                       }else BaseLoader();
//
//                       final item = state.items[index];
//
//                       //Wrap each card in RepaintBoundary
//                       // so scrolling one item doesn't repaint others
//                       return RepaintBoundary(
//                         child: _TransportListCard(
//                           item: item,
//                           index: index,
//                           labels: _buildLabels(state, index),
//                           hasWritePermission: hasWritePermission,
//                           onTap: () => _showItemDialog(context, state, index),
//                           onViewTap: () => _showItemDialog(context, state, index,
//                               isIncident: true),
//                           onEditTap: () => _onEditTap(hasWritePermission, item.id ?? 0),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// //  Extracted list card into its own widget
// // This prevents the entire list from rebuilding when one card changes
// class _TransportListCard extends StatelessWidget {
//   const _TransportListCard({
//     required this.item,
//     required this.index,
//     required this.labels,
//     required this.hasWritePermission,
//     required this.onTap,
//     required this.onViewTap,
//     required this.onEditTap,
//   });
//
//   final dynamic item; // replace with your actual TransportMedicalModel type
//   final int index;
//   final List<Label> labels;
//   final bool hasWritePermission;
//   final VoidCallback onTap;
//   final VoidCallback onViewTap;
//   final VoidCallback onEditTap;
//
//   bool get _showEditButton =>
//       item.status == ConstantsIntValue.incidentCreatedStatus ||
//           item.status == ConstantsIntValue.transportIncidentOpenStatus;
//
//   @override
//   Widget build(BuildContext context) {
//     //  BackdropFilter only on the card, not recreated in a loop
//     // Also using Container with const decorations where possible
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(18),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.white.withValues(alpha: 0.09),
//                   Colors.transparent,
//                   Colors.white.withValues(alpha: 0.09),
//                 ],
//                 stops: const [0.02, 0.35, 1],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//               borderRadius: BorderRadius.circular(27),
//               border: Border.all(
//                 color: Colors.white.withValues(alpha: 0.6),
//                 width: 0.7,
//               ),
//             ),
//             child: BaseListTileItem(
//               id: item.id,
//               labels: labels,
//               status: item.status,
//               incidentType: item.incidentType,
//               isMasterGuard: false,
//               isEventProtectionStatus: false,
//               isTransportStatus: true,
//               onTap: (_) => onTap(),
//               showEditButton: _showEditButton,
//               onEditTap: (_) => onEditTap(),
//               onViewTap: (_) => onViewTap(),
//               index: index,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }