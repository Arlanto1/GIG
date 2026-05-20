import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/patrolling/models/patrolling_model.dart';
import 'package:db_atom/src/features/patrolling/patrolling_list/bloc/patrolling_list_bloc.dart';
import 'package:db_atom/src/features/patrolling/services/patrolling_service.dart';

class PatrollingListView extends StatefulWidget {
  const PatrollingListView({
    super.key,
  });

  @override
  State<PatrollingListView> createState() =>
      _PatrollingListViewState();
}

class _PatrollingListViewState extends State<PatrollingListView> {
  //  All keys and controllers declared as fields, NOT inside build()
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final ScrollController _scrollController;

  int _pageNumber = 0;
  BaseFilterModel _filters = BaseFilterModel();

  //  Cache the blurred background — built once, never rebuilt
  static final Widget _cachedBackground = Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          'assets/images/bg2.png',
          fit: BoxFit.cover,
          // cacheWidth/cacheHeight reduces memory if image is large
        ),
      ),
      Positioned.fill(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: const ColoredBox(
              color: Colors.black12,
            ),
          ),
        ),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    context.read<PatrollingListBloc>().add(const InitializeValuesPatrolling());
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
      _pageNumber += 20;
      context.read<PatrollingListBloc>().add(FetchPatrolData(
        startPos: _pageNumber,
        maxPos: Constants.maxResults,
        newSearch: false,
        filters: _filters,
      ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<PatrollingListBloc>().add(const RefreshList());
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  // Build labels outside itemBuilder — called once per item, not per frame
  List<Label> _buildLabels(PatrollingListState state, int index) {
    final item = state.items[index];
    final locale = state.labels?.locale;
    final defaultLocale = state.labels?.defaultLocale;

    return [
      Label(
        key: locale?.inputDate ?? defaultLocale?.inputDate ?? Constants.dateofcreation,
        value: item.inputDate != null
            ? Utils.timestampToDateConversion(
          int.parse(item.inputDate ?? '0'),
          Constants.twentyFourHourDateTimeFormat,
        )
            : '',
      ),
      Label(
        key: locale?.locationRegion ?? defaultLocale?.locationRegion ?? Constants.region,
        value: item.locationRegion?.name ?? '',
      ),
      Label(
        key: locale?.location ?? defaultLocale?.location ?? Constants.location,
        value: item.location?.name ?? '',
      ),
      Label(
        key: locale?.entrySecurity ?? defaultLocale?.entrySecurity ?? Constants.createdby,
        value:
        '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}',
      ),
    ];
  }

  void _showItemDialog(BuildContext context, PatrollingListState state, int index,
      {bool isIncident = false}) {
    final labels = _buildLabels(state, index);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BasePopUpItems(
          id: state.items[index].id.toString(),
          labels: labels,
          slNo: state.items[index].slNo,
          status: state.items[index].status,
          // incidentType: state.items[index].incidentType,
          isMasterGuard: false,
          isEventProtectionStatus: false,
          isPatrollingStatus: true,
        );
      },
    );
  }

  Future<void> _onEditTap(bool hasWritePermission, PatrollingModel item) async {
    showLoadingDialog(context);
    try {
      final PatrollingModel model =
      await PatrollingService().getGeneralInfoById(item.id.toString());
      if (!mounted) return;
      dismissLoadingDialog(context);
      Navigator.pushNamed(context, patrollingListCardRoute, arguments: {
        'model': model,
        'title': Constants.editPatrolling,
        ConstantsArgument.extraProperties:
        ExtraProperties(hasWritePermission: hasWritePermission),
      });
    } catch (e) {
      if (!mounted) return;
      dismissLoadingDialog(context);
      log('Error fetching transport by id: $e');
    }
  }

  void applySearchFilters(FilterCriteria model) {
    log('Applying Search Filters');
    _filters = BaseFilterModel(filterCriteria: model);
    context.read<PatrollingListBloc>().add(
      FetchPatrolData(
        startPos: 0,
        maxPos: Constants.maxResults,
        newSearch: true,
        filters: _filters,
      ),
    );
  }

  void applyFilters(Filters model) {
    log('Applying Filters');
    _filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    log('id---filtersFun----${_filters.filterCriteria!.filters!.id}---');
    context.read<PatrollingListBloc>().add(
      FetchPatrolData(
        startPos: 0,
        maxPos: Constants.maxResults,
        newSearch: true,
        filters: _filters,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    //  Single BlocConsumer only — removed nested BlocBuilder
    return BlocConsumer<PatrollingListBloc, PatrollingListState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
      },
      //  buildWhen prevents unnecessary rebuilds when unrelated state changes
      buildWhen: (previous, current) =>
      previous.items != current.items ||
          previous.hasReachedMax != current.hasReachedMax ||
          previous.displayMenu != current.displayMenu ||
          previous.extraProperties != current.extraProperties ||
          previous.commonFilters != current.commonFilters,
      builder: (context, state) {
        final hasWritePermission = state.extraProperties?.hasWritePermission ?? false;
        const title =
             Constants.patrolling;

        return Scaffold(
          key: _scaffoldKey, // using field key
          backgroundColor: Colors.transparent,
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: true,
            scaffoldKey: _scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true,
            onAddPressed: () {
              Navigator.popAndPushNamed(
                context,
                patrollingListCardRoute,
                arguments: {
                  ConstantsArgument.title: title,
                },
              );
            },
          ),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: title,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportIMExcel',
            pdfAPIName: 'exportIMPdf',
          ),
          body: Stack(
            children: [
              //  Static cached background — never rebuilt
              _cachedBackground,

              // Search bar
              Positioned(
                //  statusBar + appBar height = correct position just below AppBar
                top: MediaQuery.of(context).padding.top + kToolbarHeight + 10,
                left: 3,
                right: 3,
                child: BaseSearchWidget(
                  applySearchFilters: applySearchFilters,
                  applyFilters: applyFilters,
                  commonFilters: state.commonFilters ??
                      CommonFilters(statuses: [], regions: []),
                ),
              ),

              // List — starts below search bar (search bar height ~56)
              Positioned(
                top: MediaQuery.of(context).padding.top + kToolbarHeight + 56,
                left: 0,
                right: 0,
                bottom: 0,
                child: CustomMaterialIndicator(
                  onRefresh: _onRefresh,
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
                    // addAutomaticKeepAlives/addRepaintBoundaries false
                    // since we handle this ourselves
                    addAutomaticKeepAlives: false,
                    addRepaintBoundaries: false,
                    itemCount: state.hasReachedMax
                        ? state.items.length
                        : state.items.length + 1,
                    itemBuilder: (context, index) {
                      // Loading indicator at end of list
                      if (index >= state.items.length) {
                        if (state.status == FormStatus.loading ||
                            state.status == FormStatus.initial) {
                          return const Center(child: BaseLoader());
                        }
                        return const SizedBox();
                      }

                      final item = state.items[index];

                      //Wrap each card in RepaintBoundary
                      // so scrolling one item doesn't repaint others
                      return RepaintBoundary(
                        child: _TransportListCard(
                          item: item,
                          index: index,
                          labels: _buildLabels(state, index),
                          hasWritePermission: hasWritePermission,
                          onTap: () => _showItemDialog(context, state, index),
                          onViewTap: () => _showItemDialog(context, state, index,
                              isIncident: true),
                          onEditTap: () => _onEditTap(hasWritePermission, item),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

//  Extracted list card into its own widget
// This prevents the entire list from rebuilding when one card changes
class _TransportListCard extends StatelessWidget {
  const _TransportListCard({
    required this.item,
    required this.index,
    required this.labels,
    required this.hasWritePermission,
    required this.onTap,
    required this.onViewTap,
    required this.onEditTap,
  });

  final dynamic item; // replace with your actual TransportMedicalModel type
  final int index;
  final List<Label> labels;
  final bool hasWritePermission;
  final VoidCallback onTap;
  final VoidCallback onViewTap;
  final VoidCallback onEditTap;

  bool get _showEditButton =>
      item.status == ConstantsIntValue.incidentCreatedStatus ||
          item.status == ConstantsIntValue.transportIncidentOpenStatus;

  @override
  Widget build(BuildContext context) {
    //  BackdropFilter only on the card, not recreated in a loop
    // Also using Container with const decorations where possible
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
                width: 0.7,
              ),
            ),
            child: BaseListTileItem(
              id: item.id,
              labels: labels,
              status: item.status,
              isMasterGuard: false,
              isEventProtectionStatus: false,
              isPatrollingStatus: true,
              onTap: (_) => onTap(),
              showEditButton: _showEditButton,
              onEditTap: (_) => onEditTap(),
              onViewTap: (_) => onViewTap(),
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}