import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/sez_pass_management/models/sez_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/sez_pass_management/services/sez_pass_management_service.dart';
import 'package:db_atom/src/features/passmanagement/sez_pass_management/sez_pass_managememt_list/bloc/sez_pass_management_list_bloc.dart';

class SezPassManagementListView extends StatefulWidget {
  const SezPassManagementListView({
    super.key,
  });

  @override
  State<SezPassManagementListView> createState() =>
      _SezPassManagementListViewState();
}

class _SezPassManagementListViewState extends State<SezPassManagementListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<SezPassManagementListBloc>().add(
          const InitializeSezPassValues(),
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
      context.read<SezPassManagementListBloc>().add(FetchSezPassData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<SezPassManagementListBloc>().add(
          const RefreshSezPassList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<SezPassManagementListBloc, SezPassManagementListState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              extendBody: true,
              bottomNavigationBar: CustomBottomNavigationBar(
                hasAddPermission:
                    state.extraProperties?.hasWritePermission ?? false
                        ? true
                        : false,
                scaffoldKey: scaffoldKey,
                context: context,
                displayMenu: state.displayMenu,
                list: true,
                // 🔥 only "+" button mode
                onAddPressed: () {
                  Navigator.pushNamed(context, sezPassManagementDetailsRoute,
                      arguments: {
                        "title": Constants.createSezPassManagementTitle
                      });
                },
              ),
              appBar: BaseAppBar().buildAppHeader(
                context: context,
                title: Constants.sezPassManagementTitle,
                showPopUp: true,
                showSaveButton: false,
                showSubmitButton: false,
                showDisLikeButton: false,
                showLikeButton: false,
                excelAPIName: 'exportPassMgmtExcel?passType=${3}&isList=1',
                pdfAPIName: 'exportPassMgmtPDF?passType=${3}&isList=1',
              ),
              body: BlocBuilder<SezPassManagementListBloc,
                  SezPassManagementListState>(builder: (context, state) {
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
                                  key: state.labels?.locale.inputDate ??
                                      state.labels?.defaultLocale.inputDate ??
                                      Constants.createdDate,
                                  value: state.items[index].inputDate != null
                                      ? Utils.timestampToDateConversion(
                                          int.parse(
                                              state.items[index].inputDate ??
                                                  '0'),
                                          Constants
                                              .twentyFourHourDateTimeFormat)
                                      : ''));
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
                              labels.add(Label(
                                  key: state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.createdby,
                                  value:
                                      '${state.items[index].entrySecurity?.firstName ?? ''} ${state.items[index].entrySecurity?.lastName ?? ''}'));
                              labels.add(Label(
                                  key: state.labels?.locale.companyType ??
                                      state.labels?.defaultLocale.companyType ??
                                      Constants.companyType,
                                  value: state.items[index].companyType?.name ??
                                      ''));

                              labels.add(Label(
                                  key: state.labels?.locale.returnedTime ??
                                      state
                                          .labels?.defaultLocale.returnedTime ??
                                      Constants.passReturnedOn,
                                  value: state.items[index].returnedTime != null
                                      ? Utils.timestampToDateConversion(
                                          int.parse(
                                              state.items[index].returnedTime ??
                                                  '0'),
                                          Constants
                                              .twentyFourHourDateTimeFormat)
                                      : ''));

                              labels.add(Label(
                                  key: state.labels?.locale.handoverSecurity ??
                                      state.labels?.defaultLocale
                                          .handoverSecurity ??
                                      Constants.passCollectedBy,
                                  value: state.items[index].handoverSecurity
                                              ?.name !=
                                          null
                                      ? state.items[index].handoverSecurity
                                              ?.name ??
                                          ''
                                      : ''));

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
                                          borderRadius:
                                              BorderRadius.circular(18),
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
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            27),
                                                    border: Border.all(
                                                      color: Colors.white
                                                          .withValues(
                                                              alpha: 0.6),
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
                                                    status: state
                                                        .items[index].status,
                                                    labels: labels,
                                                    isPassManagementStatus:
                                                        true,
                                                    isEventProtectionStatus:
                                                        false,
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
                                                                .items[index]
                                                                .status,
                                                            slNo: state
                                                                .items[
                                                                    selectedIndex]
                                                                .slNo,
                                                            labels: labels,
                                                            passValidFrom: state
                                                                .items[
                                                                    selectedIndex]
                                                                .passIssuedOn,
                                                            passValidUntil: state
                                                                .items[
                                                                    selectedIndex]
                                                                .endTime,
                                                            companyName: state
                                                                .items[
                                                                    selectedIndex]
                                                                .companyName,
                                                            isPassManagementStatus:
                                                                true,
                                                            isEventProtectionStatus:
                                                                false,
                                                            isMasterGuard:
                                                                false,
                                                            sez: true,
                                                          );
                                                        },
                                                      );
                                                    },
                                                    onEditTap: (selectedIndex) {
                                                      getById(
                                                          state.extraProperties
                                                                  ?.hasWritePermission ??
                                                              false,
                                                          state.items[index]
                                                                  .id ??
                                                              0);
                                                    },
                                                    showEditButton: state
                                                                .items[index]
                                                                .status ==
                                                            ConstantsIntValue
                                                                .passCreatedStatus ||
                                                        state.items[index]
                                                                .status ==
                                                            ConstantsIntValue
                                                                .passStatusHandedOver,
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
                                                                .items[index]
                                                                .status,
                                                            slNo: state
                                                                .items[
                                                                    selectedIndex]
                                                                .slNo,
                                                            labels: labels,
                                                            passValidFrom: state
                                                                .items[
                                                                    selectedIndex]
                                                                .passIssuedOn,
                                                            passValidUntil: state
                                                                .items[
                                                                    selectedIndex]
                                                                .endTime,
                                                            companyName: state
                                                                .items[
                                                                    selectedIndex]
                                                                .companyName,
                                                            isPassManagementStatus:
                                                                true,
                                                            isEventProtectionStatus:
                                                                false,
                                                            isMasterGuard:
                                                                false,
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
                );
              }));
        });
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    SezPassManagementModel sezPassManagementModel =
        await SezPassManagementServices().getById(id);

    editDataLoading(sezPassManagementModel, hasWritePermission);
  }

  void editDataLoading(
      SezPassManagementModel? sezPassManagementModel, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (sezPassManagementModel != null) {
      Navigator.pushNamed(context, sezPassManagementDetailsRoute, arguments: {
        "model": sezPassManagementModel,
        "title": Constants.editSezPassManagementTitle,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      });
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<SezPassManagementListBloc>(context).add(
      FetchSezPassData(
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

    BlocProvider.of<SezPassManagementListBloc>(context).add(
      FetchSezPassData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    Navigator.pop(context);
  }
}
