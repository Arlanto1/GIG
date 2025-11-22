

import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/day_pass_mangement/day_passmanagement_list/bloc/day_passmanagement_list_bloc.dart';
import 'package:db_atom/src/features/passmanagement/day_pass_mangement/models/day_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/day_pass_mangement/services/day_passmanagement_service.dart';

class DayPassManagementListView extends StatefulWidget {
  const DayPassManagementListView({
    super.key,
  });

  @override
  State<DayPassManagementListView> createState() => _DayPassManagementListViewState();
}

class _DayPassManagementListViewState extends State<DayPassManagementListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<DayPassManagementListBloc>().add(
      const InitializeDayPassValues(),
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
      context.read<DayPassManagementListBloc>().add(FetchDayPassData(
        startPos: pageNumber,
        maxPos: Constants.maxResults,
        newSearch: false,
        filters: filters,
      ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<DayPassManagementListBloc>().add(
      const RefreshDayPassList(),
    );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<DayPassManagementListBloc, DayPassManagementListState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: AppColors.lavender,
              // floatingActionButton: state.extraProperties?.hasWritePermission ??
              //     false
              //     ? Flutterfloatingbutton(
              //   backgroundColor: AppColors.navigationSkyBlueColor,
              //   foregroundColor: AppColors.backgroundWhiteColor,
              //   onPressed: () => {
              //     Navigator.pushNamed(context, dayPassManagementDetailsRoute,
              //         arguments: {
              //           "title": Constants.createDayPassManagementTitle
              //         }),
              //   },
              // )
              //     : const SizedBox(),
              bottomNavigationBar: CustomBottomNavigationBar(
                hasAddPermission: state.extraProperties?.hasWritePermission ??
                    false ? true : false,
                scaffoldKey: scaffoldKey,
                context: context,
                displayMenu: state.displayMenu,
                list: true,
                // 🔥 only "+" button mode
                onAddPressed: () {
                  Navigator.pushNamed(context, dayPassManagementDetailsRoute,
                      arguments: {
                        "title": Constants.createDayPassManagementTitle
                      });
                },
              ),
              appBar: BaseAppBar().buildAppHeader(
                context: context,
                title: Constants.dayPassManagementTitle,
                showPopUp: true,
                showSaveButton: false,
                showSubmitButton: false,
                showDisLikeButton: false,
                showLikeButton: false,
                excelAPIName: 'exportPassMgmtExcel?passType=${0}&isList=1',
            pdfAPIName: 'exportPassMgmtPDF?passType=${0}&isList=1',
              ),
              body:
              BlocBuilder<DayPassManagementListBloc, DayPassManagementListState>(
                  builder: (context, state) {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: const Color(0xFF6474C6),

                      // margin: allMargin16,
                      // decoration: const ShapeDecoration(
                      //     color: AppColors.backgroundWhiteColor,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius:
                      //       BorderRadius.vertical(top: Radius.circular(20.0)),
                      //     )),
                      child: Column(
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
                          if (state.items.isEmptyOrNull &&
                              state.status != FormStatus.loading) ...[
                            CommonWidgets.verticalSpacerWidget(height * 0.1),
                            const NoRecordFoundWidget(),
                          ],

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
                                        key:
                                        state.labels?.locale.inputDate ??
                                            state.labels?.defaultLocale
                                                .inputDate ??
                                            Constants.createdDate,
                                        value: state.items[index].inputDate != null
                                            ? Utils.timestampToDateConversion(
                                            int.parse(
                                                // state.items[index].inputDate ??
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
                                        state.items[index].locationRegion?.name ?? ''));
                                    labels.add(Label(
                                        key: state.labels?.locale.location ??
                                            state.labels?.defaultLocale.location ??
                                            Constants.location,
                                        value: state.items[index].location?.name ??
                                            ''));
                                    labels.add(Label(
                                        key: state.labels?.locale.entrySecurity ??
                                            state.labels?.defaultLocale
                                                .entrySecurity ??
                                            Constants.createdby,
                                        value:
                                        '${state.items[index].entrySecurity?.firstName ?? ''} ${state.items[index].entrySecurity?.lastName ?? ''}'));

                                    labels.add(Label(
                                        key: state.labels?.locale.dayPassInfo ??
                                            state.labels?.defaultLocale
                                                .dayPassInfo ??
                                            Constants.dayPassNo,
                                        value:
                                        '${state.items[index].passInfo?.passNo ?? ''} '));

                                    labels.add(Label(
                                        key: state.labels?.locale.companyType ??
                                            state.labels?.defaultLocale.companyType ??
                                            Constants.companyType,
                                        value: state.items[index].companyType?.name ??
                                            ''));

                                    labels.add(Label(
                                        key: state.labels?.locale.returnedTime ??
                                            state.labels?.defaultLocale
                                                .returnedTime ??
                                            Constants.passReturnedOn,
                                        value: state.items[index]. returnedTime != null
                                            ? Utils.timestampToDateConversion(
                                            int.parse(
                                                state.items[index].returnedTime ??
                                                    '0'),
                                            Constants
                                                .twentyFourHourDateTimeFormat)
                                            : ''));

                                    labels.add(Label(
                                        key: state.labels?.locale.handoverSecurity ??
                                            state.labels?.defaultLocale.handoverSecurity ??
                                            Constants.passCollectedBy,
                                        value: state.items[index].handoverSecurity?.name != null ?state.items[index].handoverSecurity?.name ??
                                            '':''));

                                    return index >= state.items.length
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
                                                        Colors.white.withValues(
                                                            alpha: 0.2),
                                                        Colors.transparent,
                                                        Colors.white.withValues(
                                                            alpha: 0.2),
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
                                                          .withValues(alpha: 0.80),
                                                      width: 0.8,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: const Color(
                                                            0xFF6474C6).withValues(
                                                            alpha: 0.09),
                                                        blurRadius: 12,
                                                        offset: const Offset(0, 2),
                                                      ),
                                                    ],
                                                  ),
                                                  child: BaseListTileItem(
                                      id: state.items[index].id,
                                      status: state.items[index].status,
                                      labels: labels,
                                      isPassManagementStatus: true,
                                      isEventProtectionStatus: false,
                                      onTap: (selectedIndex) {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return BasePopUpItems(
                                              id: state.items[selectedIndex].id
                                                  .toString(),
                                              status: state.items[index].status,
                                              slNo: state
                                                  .items[selectedIndex].slNo,
                                              labels: labels,
                                              passValidFrom: state.items[selectedIndex].startTime,
                                              passValidUntil: state.items[selectedIndex].endTime,
                                              companyName: state.items[selectedIndex].companyName,
                                              isPassManagementStatus: true,
                                                isEventProtectionStatus: false,
                                              isMasterGuard: false,
                                            );
                                          },
                                        );
                                      },
                                      onEditTap: (selectedIndex) {
                                        getById(
                                            state.extraProperties
                                                ?.hasWritePermission ??
                                                false,
                                            state.items[index].id ?? 0);
                                      },
                                      showEditButton: state
                                          .items[index].status ==
                                          ConstantsIntValue.passCreatedStatus || state
                                          .items[index].status ==
                                          ConstantsIntValue.passStatusHandedOver,
                                      onViewTap: (selectedIndex) {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return BasePopUpItems(
                                              id: state.items[selectedIndex].id
                                                  .toString(),
                                              status: state.items[index].status,
                                              slNo: state
                                                  .items[selectedIndex].slNo,
                                              labels: labels,
                                              passValidFrom: state.items[selectedIndex].startTime,
                                              passValidUntil: state.items[selectedIndex].endTime,
                                              companyName: state.items[selectedIndex].companyName,
                                              isPassManagementStatus: true,
                                              isEventProtectionStatus: false,
                                              isMasterGuard: false,
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
                      ),
                    );
                  }));
        });
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    DayPassManagementModel dayPassManagementModel =
    await DayPassManagementServices().getById(id);

    editDataLoading(dayPassManagementModel, hasWritePermission);
  }

  void editDataLoading(
      DayPassManagementModel? dayPassManagementModel, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (dayPassManagementModel != null) {
      Navigator.pushNamed(context, dayPassManagementDetailsRoute, arguments: {
        "model": dayPassManagementModel,
        "title": Constants.editDayPassManagementTitle,
        ConstantsArgument.extraProperties:
        ExtraProperties(hasWritePermission: hasWritePermission),
      });
    }
  }

  void applySearchFilters(
      FilterCriteria model,
      ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<DayPassManagementListBloc>(context).add(
      FetchDayPassData(
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

    BlocProvider.of<DayPassManagementListBloc>(context).add(
      FetchDayPassData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    Navigator.pop(context);
  }
}

