import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/attendance/attendance/bloc/attendance_bloc.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({
    super.key,
  });

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<AttendanceBloc>().add(
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
      context.read<AttendanceBloc>().add(FetchAttendanceList(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<AttendanceBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<AttendanceBloc,
        AttendanceState>(
        listener: (context, state) {},
        builder: (context, state) {
    return Scaffold(
        backgroundColor: AppColors.lavender,
        bottomNavigationBar: CustomBottomNavigationBar(
            scaffoldKey: scaffoldKey,
            context: context,
            hasAddPermission: false,
            displayMenu: state.displayMenu,
            list: true,
            onAddPressed: () {
            }),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.attendanceListTitle,
          showPopUp: true,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          excelAPIName: 'exportAttendanceExcel',
          pdfAPIName: 'exportAttendancePDF',
        ),
        body: BlocBuilder<AttendanceBloc, AttendanceState>(
            builder: (context, state) {
          // if (state.status == FormStatus.loading) {
          //   return const BaseLoader();
          // }
          // if (state.list.isEmptyOrNull) {
          //   return const NoRecordFoundWidget();
          // }
          // log('--labels-${state.labels?.locale.locationRegion}');
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.lavender,
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
                if (state.items.isEmptyOrNull &&
                    state.status != FormStatus.initial &&
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
                                key: state.labels?.locale.locationRegion ??
                                    state
                                        .labels?.defaultLocale.locationRegion ??
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
                                key: state.labels?.locale.slNo ??
                                    state.labels?.defaultLocale.slNo ??
                                    Constants.slno,
                                value: state.items[index].slNo ?? ''));
                            labels.add(Label(
                                key: state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                value: state.items[index].inputDate != null
                                    ? Utils.timestampToDateConversion(
                                    int.parse(
                                        state.items[index].inputDate ??
                                            '0'),
                                    Constants.twentyFourHourDateTimeFormat)
                                    : ''));
                            labels.add(Label(
                                key:
                                Constants.shiftScheduleId,
                                value:
                                (state.items[index].shiftInfo?.id ??
                                    '').toString()));
                            return index >= state.items.length
                                ? const BaseLoader()
                                :
                            // index >= state.items.length
                            //   ? const BaseLoader()
                            Container(
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
                                                      alpha: 0.2),
                                                  Colors.transparent,
                                                  Colors.white.withValues(
                                                      alpha: 0.2),
                                                  // Color(0xFF6474C6).withOpacity(0.14)
                                                ],
                                                stops: [0.02, 0.35, 1],
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
                                                    alpha: 0.80),
                                                width: 0.8,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(
                                                      0xFF6474C6)
                                                      .withValues(
                                                      alpha: 0.09),
                                                  blurRadius: 12,
                                                  offset:
                                                  const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: BaseListTileItem(
                                              id: state.items[index].id,
                                              labels: labels,
                                              status: state.items[index].status,
                                              isMasterGuard: false,
                                              isAttendanceStatus: true,
                                              isEventProtectionStatus: false,
                                              onTap: (selectedIndex) {
                                                showDialog(
                                                  context: context,
                                                  builder: (
                                                      BuildContext dialogContext) {
                                                    return BasePopUpItems(
                                                      id: state
                                                          .items[selectedIndex]
                                                          .id
                                                          .toString(),
                                                      labels: labels,
                                                      dutyType: state
                                                          .items[selectedIndex]
                                                          .dutyType,
                                                      isAttendance: true,
                                                      isShiftScheduleStatus: true,
                                                      isMasterGuard: false,
                                                      isEventProtectionStatus: false,
                                                      status: state
                                                          .items[selectedIndex]
                                                          .status,
                                                    );
                                                  },
                                                );
                                              },
                                              showEditButton: true,
                                              onEditTap: (selectedIndex) {
                                                getById(
                                                    state.extraProperties
                                                        ?.hasWritePermission ??
                                                        false,
                                                    id: state.items[index].id ??
                                                        0);
                                              },
                                              onViewTap: (selectedIndex) {
                                                showDialog(
                                                  context: context,
                                                  builder: (
                                                      BuildContext dialogContext) {
                                                    return BasePopUpItems(
                                                      id: state
                                                          .items[selectedIndex]
                                                          .id
                                                          .toString(),
                                                      labels: labels,
                                                      dutyType: state
                                                          .items[selectedIndex]
                                                          .dutyType,
                                                      status: state
                                                          .items[selectedIndex]
                                                          .status,
                                                      isMaterGuard: false,
                                                      isMasterGuard: false,
                                                      isAttendance: true,
                                                      isEventProtectionStatus: false,
                                                    );
                                                  },
                                                );
                                              },
                                              index: index,
                                            )))));
                          };
                        }),
              ),
              ),
              ],
              ),
              );
              }));
            },
        );
    }

  getById(
    bool hasWritePermission, {
    required int id,
  }) async {
    Navigator.pushNamed(
      context,
      attendanceDetailsRoute,
      arguments: {
        ConstantsArgument.id: id.toString(),
        ConstantsArgument.title: Constants.editAttendance,
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      },
    );
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<AttendanceBloc>(context).add(
      FetchAttendanceList(
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

    BlocProvider.of<AttendanceBloc>(context).add(
      FetchAttendanceList(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
