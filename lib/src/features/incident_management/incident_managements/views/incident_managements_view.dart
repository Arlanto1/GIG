import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../bloc/incident_management_bloc.dart';

class IncidentManagementsView extends StatefulWidget {
  const IncidentManagementsView({
    super.key,
    this.occId,
    this.occType,
    this.kldId,
  });

  final String? occId;
  final int? occType;
  final int? kldId;

  @override
  State<IncidentManagementsView> createState() =>
      _IncidentManagementsViewState();
}

class _IncidentManagementsViewState extends State<IncidentManagementsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<IncidentManagementsBloc>().add(
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
      context.read<IncidentManagementsBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  void _onRefresh() async {
    context.read<IncidentManagementsBloc>().add(
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
    return BlocConsumer<IncidentManagementsBloc, IncidentManagementsState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
      },
      builder: (context, state) {
        log('state.extraProperties?.hasWritePermission ${state.extraProperties?.hasWritePermission}');
        return Scaffold(
            backgroundColor: AppColors.cardBgColor,
            floatingActionButton:
                state.extraProperties?.hasWritePermission ?? false
                    ? Flutterfloatingbutton(
                        backgroundColor: AppColors.navigationSkyBlueColor,
                        foregroundColor: AppColors.backgroundWhiteColor,
                        onPressed: () => {
                          Navigator.pushNamed(
                            context,
                            incidentManagementDetailsRoute,
                            arguments: {
                              'occId': widget.occId?.toString(),
                              'occType': widget.occType,
                            },
                          )
                        },
                      )
                    : const SizedBox(),
            appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: Constants.incidentManagementTitle,
              showPopUp: true,
              showSaveButton: false,
              showSubmitButton: false,
              showDisLikeButton: false,
              showLikeButton: false,
              excelAPIName: 'exportIMExcel',
              pdfAPIName: 'exportIMPdf',
            ),
            body: getBody(state));
      },
    );
  }

  Widget getBody(IncidentManagementsState state) {
    // if (state.status == FormStatus.initial) {
    //   return const BaseLoader();
    // }
    // if (state.items.isEmptyOrNull) {
    //   return const NoRecordFoundWidget();
    // }

    return Container(
      margin: allMargin16,
      decoration: const ShapeDecoration(
          color: AppColors.backgroundWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
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
          if (state.status == FormStatus.loading) ...[
            const BaseLoader(),
          ],
          // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
          // Text('state.status=====${state.status}'),
          if (state.items.isEmptyOrNull &&
              state.status != FormStatus.initial &&
              state.status != FormStatus.loading) ...[
            const NoRecordFoundWidget(),
          ],
          Expanded(
            child: SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              physics: const BouncingScrollPhysics(),
              header: const WaterDropHeader(
                waterDropColor: AppColors.navigationSkyBlueColor,
                refresh: BaseLoader(),
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
                        key: state.labels?.locale.inputDate ??
                            state.labels?.defaultLocale.inputDate ??
                            'Date of Creation',
                        value: state.items[index].inputDate != null
                            ? Utils.timestampToDateConversion(
                                int.parse(state.items[index].inputDate ?? '0'),
                                Constants.dateFormat)
                            : ''));
                    labels.add(
                      Label(
                        key: state.labels?.locale.locationRegion ??
                            state.labels?.defaultLocale.locationRegion ??
                            'Region',
                        value: state.items[index].locationRegion?.name ?? '',
                      ),
                    );
                    labels.add(
                      Label(
                        key: state.labels?.locale.location ??
                            state.labels?.defaultLocale.location ??
                            'Location',
                        value: state.items[index].location?.name ?? '',
                      ),
                    );
                    labels.add(Label(
                        key: state.labels?.locale.entrySecurity ??
                            state.labels?.defaultLocale.entrySecurity ??
                            'Created By',
                        value:
                            '${state.items[index].entrySecurity?.firstName ?? ''} ${state.items[index].entrySecurity?.lastName ?? ''}'));
                    return index >= state.items.length
                        ? const BaseLoader()
                        : BaseListTileItem(
                            id: state.items[index].id,
                            labels: labels,
                            status: state.items[index].status,
                            incidentType: state.items[index].incidentType,
                            isMasterGuard: false,
                            isEventProtectionStatus: false,
                            isIncident: true,
                            onTap: (selectedIndex) {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return BasePopUpItems(
                                    id: state.items[selectedIndex].id
                                        .toString(),
                                    labels: labels,
                                    slNo: state.items[selectedIndex].slNo,
                                    status: state.items[selectedIndex].status,
                                    incidentType:
                                        state.items[selectedIndex].incidentType,
                                    isMasterGuard: false,
                                    isEventProtectionStatus: false,
                                    isIncident: true,
                                  );
                                },
                              );
                            },
                            onEditTap: (selectedIndex) {
                              getById(
                                state.extraProperties?.hasWritePermission ??
                                    false,
                                id: state.items[index].id ?? 0,
                                occType: state.items[index].occType ?? 0,
                              );
                            },
                            onViewTap: (selectedIndex) {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return BasePopUpItems(
                                    id: state.items[selectedIndex].id
                                        .toString(),
                                    labels: labels,
                                    slNo: state.items[selectedIndex].slNo,
                                    status: state.items[selectedIndex].status,
                                    isMasterGuard: false,
                                    isEventProtectionStatus: false,
                                    isIncident: true,
                                    incidentType:
                                        state.items[selectedIndex].incidentType,
                                  );
                                },
                              );
                            },
                            index: index,
                          );
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
  }

  getById(bool hasWritePermission,
      {required int id, required int occType}) async {
    Navigator.pushNamed(
      context,
      incidentManagementDetailsRoute,
      arguments: {
        ConstantsArgument.id: id.toString(),
        ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
      },
    );
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<IncidentManagementsBloc>(context).add(
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
    log('Applying Filters');

    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    log('id---filtersFun----${filters.filterCriteria!.filters!.id}---');

    BlocProvider.of<IncidentManagementsBloc>(context).add(
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
