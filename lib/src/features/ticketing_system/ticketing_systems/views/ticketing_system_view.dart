import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/ticketing_system_list_model.dart';
import 'package:db_atom/src/features/ticketing_system/ticketing_systems/bloc/ticketing_system_bloc.dart';

class TicketingSystemView extends StatefulWidget {
  final TicketingSystems? model;

  const TicketingSystemView({
    super.key,
    this.model,
  });

  @override
  State<TicketingSystemView> createState() => _TicketingSystemView();
}

class _TicketingSystemView extends State<TicketingSystemView> {
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
      context.read<TicketingSystemBloc>().add(FetchTicketingSystemData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<TicketingSystemBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketingSystemBloc, TicketingSystemState>(
        listener: (context, state) {
      Utils().formError(state, context);
      Utils().errorAndLogout(state, context);
    }, builder: (context, state) {
      return Scaffold(
          backgroundColor: AppColors.cardBgColor,

          /// disable + icon when navigating via Shift Occurrence
          floatingActionButton: Flutterfloatingbutton(
            backgroundColor: AppColors.navigationSkyBlueColor,
            foregroundColor: AppColors.backgroundWhiteColor,
            onPressed: () => {
              // Navigator.pushNamed(
              //   context,
              //   sstIncidentDetailsRoute,
              //   arguments: {
              //     "isInternal": '',
              //     "title": Constants.ticketLifeCycle
              //   },
              // )
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
          body: getBody(state));
    });
  }

  Widget getBody(TicketingSystemState state) {
    // if (state.status == FormStatus.initial) {
    //   return const BaseLoader();
    // }
    // if (state.items.isEmptyOrNull) {
    //   return const NoRecordFoundWidget();
    // }
    final size = MediaQuery.of(context).size;
    double height = size.height;
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
          // if (state.status == FormStatus.loading) ...[
          //   const BaseLoader(),
          // ],
          // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
          // Text('state.status=====${state.status}'),
          if (state.items.isEmptyOrNull &&
              state.status != FormStatus.initial &&
              state.status != FormStatus.loading) ...[
            const NoRecordFoundWidget(),
          ],

          UtilsCommon().showNoRecordWidget(
              state: state, height: height, items: state.items),
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
                      key: state.labels?.locale.location ??
                          state.labels?.defaultLocale.location ??
                          Constants.status,
                      value: state.items[index].statusName ?? '',
                    ));
                    labels.add(Label(
                      key: state.labels?.locale.location ??
                          state.labels?.defaultLocale.location ??
                          Constants.assigneeName,
                      value: state.items[index].assigneeName ?? '',
                    ));
                    labels.add(Label(
                      key: state.labels?.locale.location ??
                          state.labels?.defaultLocale.location ??
                          Constants.priority,
                      value: state.items[index].priorityName ?? '',
                    ));
                    labels.add(Label(
                      key: state.labels?.locale.location ??
                          state.labels?.defaultLocale.location ??
                          Constants.title,
                      value: state.items[index].title ?? '',
                    ));
                    labels.add(Label(
                      key: state.labels?.locale.location ??
                          state.labels?.defaultLocale.location ??
                          Constants.project,
                      value: state.items[index].projectName ?? '',
                    ));
                    return index >= state.items.length
                        ? const BaseLoader()
                        : BaseListTileItem(
                            id: state.items[index].id,
                            labels: labels,
                            // status: state.items[index].status,
                            // isMasterGuard: false,
                            isEventProtectionStatus: false,
                            // isSLAViolationStatus: false,
                            isSecuritySystemSLA: true,
                            onTap: (selectedIndex) {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return BasePopUpItems(
                                    id: state.items[selectedIndex].id
                                        .toString(),
                                    labels: labels,
                                    // slNo: state.items[selectedIndex].slNo,
                                    // status: state.items[selectedIndex].status,
                                    isMasterGuard: false,
                                    isEventProtectionStatus: false,
                                    isSecuritySystemSLAStatus: true,
                                  );
                                },
                              );
                            },
                            // showEditButton: state.items[index].status ==
                            //     ConstantsIntValue.securitySystemCreatedStatus,
                            onEditTap: (selectedIndex) {
                              // getId(
                              //   state.extraProperties?.hasWritePermission ??
                              //       false,
                              //   id: state.items[index].id ?? 0,
                              //   // eventStatus: state.items[index].status ?? 0,
                              // );
                            },
                            onViewTap: (selectedIndex) {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return BasePopUpItems(
                                    id: state.items[selectedIndex].id
                                        .toString(),
                                    labels: labels,
                                    // slNo: state.items[selectedIndex].slNo,
                                    // status: state.items[selectedIndex].status,
                                    isMasterGuard: false,
                                    isEventProtectionStatus: false,
                                    isSecuritySystemSLAStatus: true,
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

  getId(
    bool hasWritePermission, {
    required int id,
    required int eventStatus,
  }) async {
    // Navigator.pushNamed(
    //   context,
    //   sstIncidentDetailsRoute,
    //   arguments: {
    //     'id': id.toString(),
    //     'isInternal': widget.isInternal,
    //     "title": widget.isInternal
    //         ? Constants.externalVendor
    //         : Constants.ticketLifeCycle,
    //     ConstantsArgument.extraProperties:
    //     ExtraProperties(hasWritePermission: hasWritePermission),
    //   },
    // );
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
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
    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));

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
