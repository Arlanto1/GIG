import 'dart:developer';

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
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<TicketingSystemBloc, TicketingSystemState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.cardBgColor,
          floatingActionButton: Flutterfloatingbutton(
            backgroundColor: AppColors.navigationSkyBlueColor,
            foregroundColor: AppColors.backgroundWhiteColor,
            onPressed: () => {
              Navigator.pushNamed(
                context,
                ticketingSystemDetailsRoute,
                arguments: {"title": Constants.ticketLifeCycle},
              )
            },
          ),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.ticketingSystemListTitle,
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
              return Container(
                margin: allMargin16,
                decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  ),
                ),
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
                    if (state.status == FormStatus.loading) ...[
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      const BaseLoader(),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
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
                                          builder:
                                              (BuildContext dialogContext) {
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
                                      showEditButton: true,
                                      onEditTap: (selectedIndex) {
                                        getById(
                                            // state.extraProperties
                                            //         ?.hasWritePermission ??
                                            //     false,
                                            state.items[index].id ?? 0);
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
      "redmineIssue": ticketingSystemModel,
      "title": 'Edit Ticketing System',
    });
  }

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
