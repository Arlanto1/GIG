import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/security_systems/sst_incident_list/bloc/sst_incident_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../models/sst_incident_response.dart';

class SstIncidentView extends StatefulWidget {
  final bool isInternal;
  final SstIncident? model;

  const SstIncidentView({
    super.key,
    required this.isInternal,
    this.model,
  });

  @override
  State<SstIncidentView> createState() => _SstIncidentViewState();
}

class _SstIncidentViewState extends State<SstIncidentView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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

  void _onRefresh() async {
    context.read<SstIncidentBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) {
      setState(() {});
    }
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<SstIncidentBloc, SstIncidentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.cardBgColor,
            floatingActionButton: widget.isInternal &&
                    (state.extraProperties?.hasWritePermission ?? false)
                ? Flutterfloatingbutton(
                    backgroundColor: AppColors.navigationSkybluecolor,
                    foregroundColor: AppColors.backgroundWhitecolor,
                    onPressed: () => {
                      Navigator.pushNamed(
                        context,
                        sstIncidentDetailsRoute,
                        arguments: {
                          "isInternal": widget.isInternal,
                          "title": widget.isInternal
                              ? Constants.ticketLifeCycle
                              : Constants.externalVendor
                        },
                      )
                    },
                  )
                : const SizedBox(),
            appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: widget.isInternal
                  ? Constants.ticketLifeCycle
                  : Constants.externalVendor,
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
            body: BlocListener<SstIncidentBloc, SstIncidentState>(
                listener: (context, state) {
              if (state.status == FormStatus.success &&
                  !state.message.isEmptyOrNull) {
                var dialog = CustomAlertDialog(
                  title: Constants.sentReminder,
                  message: state.message,
                  positiveBtnText: Constants.ok,
                  onPositivePressed: () {
                    Navigator.popAndPushNamed(
                      context,
                      sstIncidentListRoute,
                      arguments: {"isInternal": widget.isInternal},
                    );
                  },
                );
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => dialog,
                );
              }
            }, child: BlocBuilder<SstIncidentBloc, SstIncidentState>(
                    builder: (context, state) {
              if (state.status == FormStatus.loading) {
                return const BaseLoader();
              }
              // if (state.items.isEmptyOrNull) {
              //   return const NoRecordFoundWidget();
              // }
              return Container(
                margin: allMargin16,
                decoration: const ShapeDecoration(
                    color: AppColors.backgroundWhitecolor,
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
                    // if (state.status == FormStatus.loading) ...[
                    //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                    //   const BaseLoader(),
                    //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                    // ],
                    // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                    // Text('state.status=====${state.status}'),
                    if (state.items.isEmptyOrNull &&
                        state.status != FormStatus.loading &&
                        state.status != FormStatus.initial) ...[
                      CommonWidgets.verticalSpacerWidget(height * 0.1),
                      const NoRecordFoundWidget(),
                    ],
                    Expanded(
                      child: SmartRefresher(
                        controller: refreshController,
                        enablePullDown: true,
                        physics: const BouncingScrollPhysics(),
                        header: WaterDropHeader(
                          waterDropColor: AppColors.navigationSkybluecolor,
                          refresh: state.status != FormStatus.loading
                              ? const BaseLoader()
                              : null,
                        ),
                        key: const Key(Keys.refreshKey),
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: state.hasReachedMax
                              ? state.items.length
                              : state.items.length + 1,
                          itemBuilder: (context, index) {
                            List<Label> labels = [];

                            if (index < state.items.length) {
                              labels.add(Label(
                                key: state.labels?.locale.createDate ??
                                    state.labels?.defaultLocale.createDate ??
                                    'Date of Creation',
                                value: state.items[index].createdDate != null
                                    ? Utils.timestampToDateConversion(
                                        int.tryParse(
                                            state.items[index].createdDate ??
                                                '0'),
                                        Constants.dateFormat)
                                    : '',
                              ));
                              labels.add(Label(
                                key: state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    'Location',
                                value: state.items[index].location?.name ?? '',
                              ));
                              labels.add(Label(
                                key: state.labels?.locale.region ??
                                    state.labels?.defaultLocale.region ??
                                    'Region',
                                value: state.items[index].region?.name ?? '',
                              ));
                              labels.add(Label(
                                  key: state.labels?.locale.createdBy ??
                                      state.labels?.defaultLocale.createdBy ??
                                      'Created By',
                                  value:
                                      '${state.items[index].createdBy?.firstName ?? ''} ${state.items[index].createdBy?.lastName ?? ''}'));
                              return index >= state.items.length
                                  ? const BaseLoader()
                                  : BaseListTileItem(
                                      id: state.items[index].id,
                                      labels: labels,
                                      status: state.items[index].status,
                                      // isMasterGuard: false,
                                      isEventProtectionStatus: false,
                                      // isSLAViolationStatus: false,
                                      isSecuritySystemSLA: true,
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
                                              isEventProtectionStatus: false,
                                              isSecuritySystemSLAStatus: true,
                                            );
                                          },
                                        );
                                      },
                                      onEditTap: (selectedIndex) {
                                        getId(
                                          state.extraProperties
                                                  ?.hasWritePermission ??
                                              false,
                                          id: state.items[index].id ?? 0,
                                          eventStatus:
                                              state.items[index].status ?? 0,
                                        );
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
                                              isSecuritySystemSLAStatus: true,
                                            );
                                          },
                                        );
                                      },
                                      showEmailButton: true,
                                      onEmailTap: (selectedIndex) async {
                                        FocusScope.of(context).unfocus();
                                        int? id = state.items[selectedIndex]
                                            .id;
                                        SstIncident selectedIncident =
                                            state.items.firstWhere(
                                          (incident) => incident.id == id,
                                        );
                                        context
                                            .read<SstIncidentBloc>()
                                            .add(SendReminderEmail(
                                              selectedIncident:
                                                  selectedIncident,
                                            ));
                                      },
                                      index: index,
                                    );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })));
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
