import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/security_systems/sst_incident_list/bloc/sst_incident_bloc.dart';

class SstIncidentView extends StatefulWidget {
  final bool isInternal;
  final SstIncident? model;
  final String? occId;

  const SstIncidentView({
    super.key,
    required this.isInternal,
    this.occId,
    this.model,
  });

  @override
  State<SstIncidentView> createState() => _SstIncidentViewState();
}

class _SstIncidentViewState extends State<SstIncidentView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<SstIncidentBloc>().add(
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
      context.read<SstIncidentBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<SstIncidentBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<SstIncidentBloc, SstIncidentState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          extendBody: true,

          /// disable + icon when navigating via Shift Occurrence
          // floatingActionButton: widget.isInternal &&
          //         (state.extraProperties?.hasWritePermission ?? false) &&
          //         widget.occId.isEmptyOrNull
          //     ? Flutterfloatingbutton(
          //         backgroundColor: AppColors.navigationSkyBlueColor,
          //         foregroundColor: AppColors.backgroundWhiteColor,
          //         onPressed: () => {
          //           Navigator.pushNamed(
          //             context,
          //             sstIncidentDetailsRoute,
          //             arguments: {
          //               "isInternal": widget.isInternal,
          //               "title": Constants.ticketLifeCycle
          //             },
          //           )
          //         },
          //       )
          //     : const SizedBox(),
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: widget.isInternal &&
                    (state.extraProperties?.hasWritePermission ?? false) &&
                    widget.occId.isEmptyOrNull
                ? true
                : false,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true,
            // 🔥 only "+" button mode
            onAddPressed: () {
              Navigator.pushNamed(
                context,
                sstIncidentDetailsRoute,
                arguments: {
                  "isInternal": widget.isInternal,
                  "title": Constants.ticketLifeCycle
                },
              );
            },
          ),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.ticketLifeCycle,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName:
                'exportSSSLAExcel?ticketType=${widget.isInternal ? 1 : 0}',
            pdfAPIName:
                'exportSSSLAPDF?ticketType=${widget.isInternal ? 1 : 0}',
          ),
          body: BlocConsumer<SstIncidentBloc, SstIncidentState>(
            listener: (context, state) {
              Utils().formError(state, context);
              Utils().errorAndLogout(state, context);

              if (state.status == FormStatus.sessionExpired) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.message ?? 'Session Expired...'),
                  ),
                );
                Validator.logoutAction(context);
              }
            },
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
                          color: Colors.black.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                  ),

                  // 🔹 Search Bar - positioned safely at the top
                  Positioned(
                    top: MediaQuery.of(context).padding.top +
                        kToolbarHeight +
                        -40, // below AppBar
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
                    top: MediaQuery.of(context).padding.top +
                        kToolbarHeight +
                        10,
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
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: state.hasReachedMax
                            ? state.items.length
                            : state.items.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.items.length) {
                            if (state.status == FormStatus.loading ||
                                state.status == FormStatus.initial) {
                              return const Center(child: BaseLoader());
                            }
                            return const SizedBox();
                          }
                          List<Label> labels = [];

                          if (index < state.items.length) {
                            labels.add(Label(
                              key: state.labels?.locale.createDate ??
                                  state.labels?.defaultLocale.createDate ??
                                  Constants.dateofcreation,
                              value: state.items[index].createdDate != null
                                  ? Utils.timestampToDateConversion(
                                      int.tryParse(
                                          state.items[index].createdDate ??
                                              '0'),
                                      Constants.twentyFourHourDateTimeFormat)
                                  : '',
                            ));
                            labels.add(Label(
                              key: state.labels?.locale.location ??
                                  state.labels?.defaultLocale.location ??
                                  Constants.location,
                              value: state.items[index].location?.name ?? '',
                            ));
                            labels.add(Label(
                              key: state.labels?.locale.region ??
                                  state.labels?.defaultLocale.region ??
                                  Constants.region,
                              value: state.items[index].region?.name ?? '',
                            ));
                            labels.add(Label(
                                key: state.labels?.locale.createdBy ??
                                    state.labels?.defaultLocale.createdBy ??
                                    Constants.createdby,
                                value:
                                    '${state.items[index].createdBy?.firstName ?? ''} ${state.items[index].createdBy?.lastName ?? ''}'));
                            labels.add(Label(
                              key:
                                  // state.labels?.locale.createDate ??
                                  //     state.labels?.defaultLocale.createDate ??
                                  Constants.modifiedDate,
                              value: state.items[index].modifiedDate != null
                                  ? Utils.timestampToDateConversion(
                                      int.tryParse(
                                          state.items[index].modifiedDate ??
                                              '0'),
                                      Constants.twentyFourHourDateTimeFormat)
                                  : '',
                            ));
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
                                            filter: ImageFilter.blur(
                                                sigmaX: 18, sigmaY: 18),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.white.withValues(
                                                          alpha: 0.09),
                                                      Colors.transparent,
                                                      Colors.white.withValues(
                                                          alpha: 0.09),
                                                      // Color(0xFF6474C6).withOpacity(0.14)
                                                    ],
                                                    stops: const [0.02, 0.35, 1],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(27),
                                                  border: Border.all(
                                                    color: Colors.white
                                                        .withValues(alpha: 0.6),
                                                    width: 0.7,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.white
                                                          .withValues(
                                                              alpha: 0.0),
                                                      blurRadius: 12,
                                                      offset:
                                                          const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: BaseListTileItem(
                                                  id: state.items[index].id,
                                                  labels: labels,
                                                  status:
                                                      state.items[index].status,
                                                  // isMasterGuard: false,
                                                  isEventProtectionStatus:
                                                      false,
                                                  // isSLAViolationStatus: false,
                                                  isSecuritySystemSLA: true,
                                                  onTap: (selectedIndex) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          dialogContext) {
                                                        return BasePopUpItems(
                                                          id: state
                                                              .items[
                                                                  selectedIndex]
                                                              .id
                                                              .toString(),
                                                          labels: labels,
                                                          slNo: state
                                                              .items[
                                                                  selectedIndex]
                                                              .slNo,
                                                          status: state
                                                              .items[
                                                                  selectedIndex]
                                                              .status,
                                                          isMasterGuard: false,
                                                          isEventProtectionStatus:
                                                              false,
                                                          isSecuritySystemSLAStatus:
                                                              true,
                                                        );
                                                      },
                                                    );
                                                  },
                                                  showEditButton: state
                                                          .items[index]
                                                          .status ==
                                                      ConstantsIntValue
                                                          .securitySystemCreatedStatus,
                                                  onEditTap: (selectedIndex) {
                                                    getId(
                                                      state.extraProperties
                                                              ?.hasWritePermission ??
                                                          false,
                                                      id: state.items[index]
                                                              .id ??
                                                          0,
                                                      eventStatus: state
                                                              .items[index]
                                                              .status ??
                                                          0,
                                                    );
                                                  },
                                                  onViewTap: (selectedIndex) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          dialogContext) {
                                                        return BasePopUpItems(
                                                          id: state
                                                              .items[
                                                                  selectedIndex]
                                                              .id
                                                              .toString(),
                                                          labels: labels,
                                                          slNo: state
                                                              .items[
                                                                  selectedIndex]
                                                              .slNo,
                                                          status: state
                                                              .items[
                                                                  selectedIndex]
                                                              .status,
                                                          isMasterGuard: false,
                                                          isEventProtectionStatus:
                                                              false,
                                                          isSecuritySystemSLAStatus:
                                                              true,
                                                        );
                                                      },
                                                    );
                                                  },
                                                  showEmailButton: true,
                                                  onEmailTap:
                                                      (selectedIndex) async {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Dialog(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          elevation: 0,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child:
                                                                BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX:
                                                                          12,
                                                                      sigmaY:
                                                                          12),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        20),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withValues(
                                                                          alpha:
                                                                              0.12),
                                                                  // glass layer
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white
                                                                        .withValues(
                                                                            alpha:
                                                                                0.35),
                                                                    // glass border
                                                                    width: 1.3,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    const Text(
                                                                      Constants
                                                                          .sentReminder,
                                                                      style:
                                                                           TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            12),
                                                                    const Text(
                                                                      Constants
                                                                          .sentRemindertoVendor,
                                                                      style:
                                                                           TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white70,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            20),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        Constants
                                                                            .ok,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                        //   AlertDialog(
                                                        //   title: const Text(Constants.sentReminder),
                                                        //   content: const Text(
                                                        //       Constants.sentRemindertoVendor),
                                                        //   actions: <Widget>[
                                                        //     TextButton(
                                                        //       child: const Text(Constants.ok),
                                                        //       onPressed: () {
                                                        //         Navigator.of(context).pop();
                                                        //       },
                                                        //     ),
                                                        //   ],
                                                        // );
                                                      },
                                                    );
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    int? id = state
                                                        .items[selectedIndex]
                                                        .id;
                                                    context
                                                        .read<SstIncidentBloc>()
                                                        .add(SendReminderEmail(
                                                          id: id!,
                                                        ));
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
    required int eventStatus,
  }) async {
    Navigator.pushNamed(
      context,
      sstIncidentDetailsRoute,
      arguments: {
        'id': id.toString(),
        'isInternal': widget.isInternal,
        "title": widget.isInternal
            ? Constants.externalVendor
            : Constants.ticketLifeCycle,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      },
    );
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<SstIncidentBloc>(context).add(
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

    BlocProvider.of<SstIncidentBloc>(context).add(
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
