import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/ticketing_system_model.dart';
import 'package:db_atom/src/features/ticketing_system/services/ticketing_system_services.dart';
import 'package:db_atom/src/features/ticketing_system/ticketing_systems/bloc/ticketing_system_bloc.dart';

class TicketingSystemView extends StatefulWidget {
  const TicketingSystemView({
    super.key,
  });

  @override
  State<TicketingSystemView> createState() => _TicketingSystemViewState();
}

class _TicketingSystemViewState extends State<TicketingSystemView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<TicketingSystemBloc>().add(
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
      context.read<TicketingSystemBloc>().add(FetchTicketingSystemData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  // Future<void> _onRefresh() async {
  //   context.read<MaterialMovementBloc>().add(
  //         const RefreshList(),
  //       );
  //   await Future.delayed(const Duration(milliseconds: 2000));
  // }

  Future<void> _onRefresh() async {
    // Trigger the refresh event
    context.read<TicketingSystemBloc>().add(const RefreshList());

    // Wait until the state status is FormStatus.success or FormStatus.failure
    await context.read<TicketingSystemBloc>().stream.firstWhere(
          (state) =>
              state.status == FormStatus.success ||
              state.status == FormStatus.failure,
        );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<TicketingSystemBloc, TicketingSystemState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor:Colors.transparent,
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: true,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true, // 🔥 only "+" button mode
            onAddPressed: () {
              Navigator.pushNamed(
                context,
                ticketingSystemDetailsRoute,
                arguments: {"title": Constants.ticketingSystem},
              );
            },
          ),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.ticketingSystem,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            // excelAPIName:
            // 'exportSSSLAExcel?ticketType=${widget.isInternal ? 1 : 0}',
            // pdfAPIName:
            // 'exportSSSLAPDF?ticketType=${widget.isInternal ? 1 : 0}',
          ),
          body: BlocConsumer<TicketingSystemBloc, TicketingSystemState>(
            listener: (context, state) {
              Utils().formError(state, context);
              Utils().errorAndLogout(state, context);
              if (state.status == FormStatus.sessionExpired) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.message ?? 'Session Expired...')));
                Validator.logoutAction(context);
              }
            },
            builder: (context, state) {
              // if (state.status == FormStatus.initial) {
              //   return const BaseLoader();
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
                    ) :CustomMaterialIndicator(
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
                          final item = state.items[index];

                          // Build labels
                          List<Label> labels = [
                            Label(
                                key:
                                // state.labels?.locale.i ??
                                //     statee.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                value: item.inputDate != null
                                    ? Utils.timestampToDateConversion(
                                    int.parse(item.inputDate ?? '0'),
                                    Constants.twentyFourHourDateTimeFormat)
                                    : ''),
                            Label(
                                key: state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                value: item.location?.name ?? ''),
                            Label(
                                key: state.labels?.locale.createdBy ??
                                    state.labels?.defaultLocale.createdBy ??
                                    Constants.createdby,
                                value:
                                '${item.createdBy?.firstName ?? ''} ${item.createdBy?.lastName ?? ''}'),
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
                                    isOccurrenceStatus: false,
                                    isEventProtectionStatus: false,
                                    isTicketStatus: true,
                                    index: index,
                                    onTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (dialogContext) => BasePopUpItems(
                                          id: state.items[selectedIndex].id.toString(),
                                          slNo: state.items[selectedIndex].ticketNo,
                                          status: state.items[selectedIndex].status,
                                          labels: labels,
                                          isOccurrenceStatus: false,
                                          isTicketStatus: true,
                                          isMasterGuard: false,
                                          isEventProtectionStatus: false,
                                        ),
                                      );
                                    },
                                    showEditButton: true,
                                    onEditTap: (selectedIndex) {
                                      getById(
                                          state.items[index].id ?? 0);
                                    },
                                    onViewTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (dialogContext) => BasePopUpItems(
                                          id: state.items[selectedIndex].id.toString(),
                                          slNo: state.items[selectedIndex].ticketNo,
                                          status: state.items[selectedIndex].status,
                                          labels: labels,
                                          isEventProtectionStatus: false,
                                          isMasterGuard: false,
                                          isOccurrenceStatus: false,
                                            isTicketStatus: true
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

  getById(int id) async {
    showLoadingDialog(context);

    TicketingSystemModel ticketingSystemModel =
        await TicketingSystemServices().getById(id);

    editDataLoading(ticketingSystemModel);
  }

  Future<void> editDataLoading(TicketingSystemModel? ticketingSystemModel) async {
    dismissLoadingDialog(context);
    Navigator.pushNamed(context, ticketingSystemDetailsRoute, arguments: {
      "ticketingSystem": ticketingSystemModel,
      "title": 'Edit Ticketing System',
    });
  }

  // getId(
  //     bool hasWritePermission, {
  //       required int id,
  //     }) async {
  //   Navigator.pushNamed(
  //     context,
  //     ticketingSystemDetailsRoute,
  //     arguments: {
  //       'id': id.toString(),
  //       "title": 'edit Ticket',
  //       // ConstantsArgument.extraProperties:
  //       // ExtraProperties(hasWritePermission: hasWritePermission),
  //     },
  //   );
  // }
  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<TicketingSystemBloc>(context).add(
      FetchTicketingSystemData(
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

    BlocProvider.of<TicketingSystemBloc>(context).add(
      FetchTicketingSystemData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
