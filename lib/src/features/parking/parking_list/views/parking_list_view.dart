import 'dart:developer';
import 'dart:ui';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/parking/models/parking_model.dart';
import 'package:db_atom/src/features/parking/parking_list/bloc/parking_list_bloc.dart';
import 'package:db_atom/src/features/parking/services/parking_service.dart';

class ParkingListView extends StatefulWidget {
  const ParkingListView({super.key});

  @override
  State<ParkingListView> createState() =>
      _ParkingListViewState();
}

class _ParkingListViewState extends State<ParkingListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<ParkingListBloc>().add(const InitializeValuesParking());
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
      context.read<ParkingListBloc>().add(FetchParkingData(
        startPos: pageNumber,
        maxPos: Constants.maxResults,
        newSearch: false,
        filters: filters,
      ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<ParkingListBloc>().add(const RefreshParkingList());
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<ParkingListBloc, ParkingListState>(
      listener: (context, state) {},
      builder: (context, state) {
        log('plus ${state.extraProperties?.hasWritePermission}');
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: true,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true, //  only "+" button mode
            onAddPressed: () {
              Navigator.pushNamed(
                context,
                parkingDetailsRoute,
                arguments: {"title": Constants.parking},
              );
            },
          ),
          // backgroundColor: const Color(0xFF071130),
          // backgroundColor: AppColors.newColor,
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.parking,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportFoundExcel',
            pdfAPIName: 'exportFoundPDF',
          ),
          body: BlocBuilder<ParkingListBloc, ParkingListState>(
            builder: (context, state) {
              return Stack(
                children: [
                  //  Background
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

                  //  Search Bar - positioned safely at the top
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

                  //  ListView - start immediately below search bar
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
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: state.hasReachedMax
                            ? state.items.length
                            : state.items.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.items.length) {
                            if (state.status == FormStatus.loading) {
                              return const Center(child: BaseLoader());
                            }
                            return const SizedBox();
                          }

                          final item = state.items[index];
                          List<Label> labels = [
                            Label(
                              key: Constants.dateofcreation,
                              value: item.inputDate != null
                                  ? Utils.timestampToDateConversion(
                                  int.parse(item.inputDate ?? '0'),
                                  Constants.twentyFourHourDateTimeFormat)
                                  : '',
                            ),
                            // Label(
                            //   key: Constants.founddate,
                            //   value: item.foundDate != null
                            //       ? Utils.timestampToDateConversion(
                            //       int.parse(item.foundDate ?? '0'),
                            //       Constants.twentyFourHourDateTimeFormat)
                            //       : '',
                            // ),
                            // Label(
                            //     key: Constants.region,
                            //     value: item.locationRegion?.name ?? ''),
                            Label(
                                key: Constants.location,
                                value: item.location?.name ?? ''),
                            Label(
                              key: Constants.createdby,
                              value:
                              '${item.entrySecurity?.firstName ?? ''} ${item.entrySecurity?.lastName ?? ''}',
                            ),
                          ];

                          return index >= state.items.length
                              ? const SizedBox()
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
                                  child: BaseListTileItem(
                                    id: item.id,
                                    labels: labels,
                                    status: item.status,
                                    isParkingStatus: true,
                                    isEventProtectionStatus: false,
                                    onTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (_) => BasePopUpItems(
                                          id: item.id.toString(),
                                          status: item.status,
                                          labels: labels,
                                          isEventProtectionStatus: false,
                                          parkingStatus: true,
                                          isMasterGuard: false,
                                        ),
                                      );
                                    },
                                    onEditTap: (selectedIndex) {
                                      getById(
                                        state.extraProperties
                                            ?.hasWritePermission ??
                                            false,
                                        '${item.id ?? 0}',
                                      );
                                    },
                                    showEditButton: item.status ==
                                        ConstantsIntValue
                                            .articleFoundStatusFound ||
                                        item.status ==
                                            ConstantsIntValue
                                                .articleFoundStatusUnderSecurityCustody,
                                    onViewTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (_) => BasePopUpItems(
                                          id: item.id.toString(),
                                          status: item.status,
                                          labels: labels,
                                          isEventProtectionStatus: false,
                                          parkingStatus: true,
                                          isMasterGuard: false,
                                        ),
                                      );
                                    },
                                    index: index,
                                  ),
                                ),
                              ),
                            ),
                          );
//
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

  getById(bool hasWritePermission, String id) async {
    showLoadingDialog(context);
    ParkingModel model = await ParkingService().getParkingDetailsById(id);
    editDataLoading(model, hasWritePermission);
  }

  void editDataLoading(ParkingModel? model, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(context, parkingDetailsRoute, arguments: {
        "model": model,
        "title": Constants.parking,
        ConstantsArgument.extraProperties:
        ExtraProperties(hasWritePermission: hasWritePermission),
      });
    }
  }

  void applySearchFilters(FilterCriteria model) {
    filters = BaseFilterModel(filterCriteria: model);
    BlocProvider.of<ParkingListBloc>(context).add(FetchParkingData(
        startPos: 0,
        maxPos: Constants.maxResults,
        newSearch: true,
        filters: filters));
  }

  void applyFilters(Filters model) {
    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    BlocProvider.of<ParkingListBloc>(context).add(FetchParkingData(
        startPos: 0,
        maxPos: Constants.maxResults,
        newSearch: true,
        filters: filters));
    Navigator.pop(context);
  }
}
