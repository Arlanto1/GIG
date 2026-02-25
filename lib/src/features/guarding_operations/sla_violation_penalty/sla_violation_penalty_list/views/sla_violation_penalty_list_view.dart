import 'dart:ui';

import 'package:db_atom/index.dart';
import '../../services/sla_violation_penalty_services.dart';
import '../bloc/sla_violation_penalty_list_bloc.dart';

class SLAViolationPenaltyListView extends StatefulWidget {
  const SLAViolationPenaltyListView({super.key});

  @override
  State<SLAViolationPenaltyListView> createState() =>
      _ContactDetailsListViewState();
}

class _ContactDetailsListViewState extends State<SLAViolationPenaltyListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<SLAViolationPenaltyListBloc>().add(const InitializeValues());
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
      context.read<SLAViolationPenaltyListBloc>().add(
            FetchData(
              startPos: pageNumber,
              maxPos: Constants.maxResults,
              newSearch: false,
              filters: BaseFilterModel(),
            ),
          );
    }
  }

  Future<void> _onRefresh() async {
    context.read<SLAViolationPenaltyListBloc>().add(const RefreshList());
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  Future<void> _onLoading() async {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<SLAViolationPenaltyListBloc,
        SLAViolationPenaltyListState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          extendBodyBehindAppBar: true,
          // floatingActionButton: state.extraProperties?.hasWritePermission ??
          //         false
          //     ? Flutterfloatingbutton(
          //         backgroundColor: AppColors.navigationSkyBlueColor,
          //         foregroundColor: AppColors.backgroundWhiteColor,
          //         onPressed: () => {
          //           Navigator.pushNamed(
          //             context,
          //             slaViolationPenaltyDetailsRoute,
          //             arguments: {"title": Constants.slaViolationPenaltyTitle},
          //           ),
          //         },
          //       )
          //     : const SizedBox(),
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: state.extraProperties?.hasWritePermission ??
                false ? true : false,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true, // 🔥 only "+" button mode
            onAddPressed: () {
              Navigator.pushNamed(
                context,
                slaViolationPenaltyDetailsRoute,
                arguments: {"title": Constants.slaViolationPenaltyTitle},
              );
            },
          ),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.slaViolationPenaltyTitle,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportSvpExcel',
            pdfAPIName: 'exportSvpPDF',
          ),
            body: BlocBuilder<SLAViolationPenaltyListBloc, SLAViolationPenaltyListState>(
              builder: (context, state) {
                // if (state.status == FormStatus.initial) {
                //   return const BaseLoader();
                // }
                // if (state.list.isEmptyOrNull) {
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
                              labels.add(
                                Label(
                                  key: state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.createdby,
                                  value:
                                  '${state.items[index].entrySecurity
                                      ?.firstName ?? ''} ${state.items[index]
                                      .entrySecurity?.lastName ?? ''}',
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.locationRegion ??
                                      state.labels?.defaultLocale
                                          .locationRegion ??
                                      Constants.region,
                                  value:
                                  state.items[index].locationRegion?.name ?? '',
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.location,
                                  value: state.items[index].location?.name ??
                                      '',
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.slNo ??
                                      state.labels?.defaultLocale.slNo ??
                                      Constants.slno,
                                  value: state.items[index].slNo ?? '',
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.inputDate ??
                                      state.labels?.defaultLocale.inputDate ??
                                      Constants.dateofcreation,
                                  value: state.items[index].inputDate != null
                                      ? Utils.timestampToDateConversion(
                                    int.parse(
                                      state.items[index].inputDate ?? '0',
                                    ),
                                    Constants.twentyFourHourDateTimeFormat,
                                  )
                                      : '',
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.entity ??
                                      state.labels?.defaultLocale.entity ??
                                      Constants.entity,
                                  value: state.items[index].entitiesInfo ?? '',
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.typeOfService ??
                                      state.labels?.defaultLocale
                                          .typeOfService ??
                                      Constants.typeOfService,
                                  value: state.items[index].typeOfServiceInfo ??
                                      '',
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.vendor ??
                                      state.labels?.defaultLocale.vendor ??
                                      Constants.vendor,
                                  value: state.items[index].vendorInfo ?? '',
                                ),
                              );
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
                                              decoration:
                                              BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white.withValues(
                                                        alpha: 0.09),
                                                    Colors.transparent,
                                                    Colors.white.withValues(
                                                        alpha: 0.09),
                                                    // Color(0xFF6474C6).withOpacity(0.14)
                                                  ],
                                                  stops: [0.02, 0.35, 1],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                                borderRadius: BorderRadius
                                                    .circular(27),
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
                                              child: BaseListTileItem(
                                                id: state.items[index].id,
                                                status:
                                                state.items[index].status,
                                                labels: labels,
                                                isEventProtectionStatus: false,
                                                isSLAViolationStatus: true,
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
                                                        status: state
                                                            .items[
                                                        selectedIndex]
                                                            .status,
                                                        isSLAViolationStatus:
                                                        true,
                                                        isEventProtectionStatus:
                                                        false,
                                                        isMasterGuard: false,
                                                        labels: labels,
                                                      );
                                                    },
                                                  );
                                                },
                                                showEditButton: state
                                                    .items[index]
                                                    .status !=
                                                    ConstantsIntValue
                                                        .slaStatusFinalized &&
                                                    state.items[index].status !=
                                                        ConstantsIntValue
                                                            .cancelledStatus,
                                                onEditTap: (selectedIndex) {
                                                  getById(
                                                    state.extraProperties
                                                        ?.hasWritePermission ??
                                                        false,
                                                    state.items[index].id ?? 0,
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
                                                        status: state
                                                            .items[
                                                        selectedIndex]
                                                            .status,
                                                        isSLAViolationStatus:
                                                        true,
                                                        isEventProtectionStatus:
                                                        false,
                                                        isMasterGuard: false,
                                                        labels: labels,
                                                      );
                                                    },
                                                  );
                                                },
                                                index: index,
                                              )))));
                            }

                            // Handle the case where index is out of bounds
                            return const Center(child: SizedBox());
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

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    SLAViolationPenaltyModel model =
        await SLAViolationPenaltyServices().getGvpById(id);

    editDataLoading(model, hasWritePermission);
  }

  void editDataLoading(
    SLAViolationPenaltyModel? model,
    bool hasWritePermission,
  ) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        slaViolationPenaltyDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.slaViolationPenaltyTitle,
          ConstantsArgument.extraProperties: ExtraProperties(
            hasWritePermission: hasWritePermission,
          ),
        },
      );
    }
  }

  void applySearchFilters(FilterCriteria model) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<SLAViolationPenaltyListBloc>(context).add(
      FetchData(startPos: 0, maxPos: 20, newSearch: true, filters: filters),
    );
  }

  void applyFilters(Filters model) {
    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));

    BlocProvider.of<SLAViolationPenaltyListBloc>(context).add(
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
