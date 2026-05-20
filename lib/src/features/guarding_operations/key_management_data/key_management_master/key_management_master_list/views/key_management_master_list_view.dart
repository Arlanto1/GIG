import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_list/bloc/key_management_master_list_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';

class KeyManagementMasterListView extends StatefulWidget {
  const KeyManagementMasterListView({super.key});

  @override
  State<KeyManagementMasterListView> createState() =>
      _KeyManagementMasterListViewState();
}

class _KeyManagementMasterListViewState
    extends State<KeyManagementMasterListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<KeyManagementMasterListBloc>().add(const InitializeValues());
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
      context.read<KeyManagementMasterListBloc>().add(
            FetchKeyMasterList(
              startPos: pageNumber,
              maxPos: Constants.maxResults,
              newSearch: false,
              filters: filters,
            ),
          );
    }
  }

  Future<void> _onRefresh() async {
    context.read<KeyManagementMasterListBloc>().add(const RefreshList());
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<KeyManagementMasterListBloc,
        KeyManagementMasterListState>(
      listener: (context, state) {},
      builder: (context, state) {
        log('hasWritePermission ${state.extraProperties?.hasWritePermission}');
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBody: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: true,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true, // 🔥 only "+" button mode
            onAddPressed: () {
              Navigator.pushNamed(context, keyManagementMasterDetailsRoute,
                  arguments: {
                    "title": Constants.createkeyManagementMaster,
                    "keyMgmtGi": KeyManagementMasterModel(),
                  });
            },
          ),
          // floatingActionButton:
          //     state.extraProperties?.hasWritePermission ?? false
          //         ? Flutterfloatingbutton(
          //             backgroundColor: AppColors.navigationSkyBlueColor,
          //             foregroundColor: AppColors.backgroundWhiteColor,
          //             onPressed: () => {
          //               Navigator.pushNamed(
          //                   context, keyManagementMasterDetailsRoute,
          //                   arguments: {
          //                     "title": Constants.createkeyManagementMaster,
          //                     "keyMgmtGi": KeyManagementMasterModel(),
          //                   }),
          // //             },
          //           )
          //         : const SizedBox(),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.keyManagementMasterTitle,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportKeyMgmtExcel',
            pdfAPIName: 'exportKeyMgmtPDF',
          ),
          body: BlocBuilder<KeyManagementMasterListBloc,
              KeyManagementMasterListState>(
            builder: (context, state) {
              // if (state.status == FormStatus.initial) {
              //   return const BaseLoader();
              // }
              // if (state.list.isEmptyOrNull) {
              //   return const NoRecordFoundWidget();
              // }
              // log('--labels-${state.labels?.locale.locationRegion}');
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
                              ? state.list.length
                              : state.list.length + 1,
                          itemBuilder: (context, index) {
                            if (index >= state.list.length) {
                              if (state.status == FormStatus.loading ||
                                  state.status == FormStatus.initial) {
                                return const Center(child: BaseLoader());
                              }
                              return const SizedBox();
                            }
                            List<Label> labels = [];
                            if (index < state.list.length) {
                              labels.add(
                                Label(
                                  key: state.labels?.locale.floor ??
                                      state.labels?.defaultLocale.floor ??
                                      Constants.floor,
                                  value: state.list[index].floor.toString(),
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.createdBy ??
                                      state.labels?.defaultLocale.createdBy ??
                                      Constants.createdby,
                                  value:
                                      '${state.list[index].createdBy?.firstName ?? ''} ${state.list[index].createdBy?.lastName ?? ''}',
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.createdDate ??
                                      state.labels?.defaultLocale.createdDate ??
                                      Constants.createdDate,
                                  value: state.list[index].createdDate != null
                                      ? Utils.timestampToDateConversion(
                                          int.parse(
                                            state.list[index].createdDate ??
                                                '0',
                                          ),
                                          Constants
                                              .twentyFourHourDateTimeFormat,
                                        )
                                      : '',
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.noKeys ??
                                      state.labels?.defaultLocale.noKeys ??
                                      Constants.noOfKeys,
                                  value: state.list[index].noKeys.toString(),
                                ),
                              );
                              labels.add(
                                Label(
                                  key: state.labels?.locale.noMasterKey ??
                                      state.labels?.defaultLocale.noMasterKey ??
                                      Constants.noOfKeys,
                                  value:
                                      state.list[index].noMasterKey.toString(),
                                ),
                              );
                              return index >= state.list.length
                                  ? null
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
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 18,
                                            sigmaY: 18,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.white
                                                      .withValues(alpha: 0.09),
                                                  Colors.transparent,
                                                  Colors.white
                                                      .withValues(alpha: 0.09),
                                                  // Color(0xFF6474C6).withOpacity(0.14)
                                                ],
                                                stops: const [0.02, 0.35, 1],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(27),
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
                                            // index >= state.list.length
                                            //   ? const BaseLoader()
                                            child: BaseListTileItem(
                                              id: state.list[index].id,
                                              labels: labels,
                                              status: state.list[index].status,
                                              isKeyManagementStatus: true,
                                              isEventProtectionStatus: false,
                                              onTap: (selectedIndex) {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                      dialogContext) {
                                                    return BasePopUpItems(
                                                      id: state
                                                          .list[selectedIndex]
                                                          .id
                                                          .toString(),
                                                      slNo: state
                                                          .list[selectedIndex]
                                                          .slNo,
                                                      labels: labels,
                                                      status: state
                                                          .list[selectedIndex]
                                                          .status,
                                                      keyNo: state
                                                          .list[selectedIndex]
                                                          .keyNo,
                                                      // keyTagging: state
                                                      //     .list[selectedIndex]
                                                      //     .keyTagging,
                                                      doorName: state
                                                          .list[selectedIndex]
                                                          .doorName,
                                                      isKeyManagementStatus:
                                                          true,
                                                      isEventProtectionStatus:
                                                          false,
                                                      isMasterGuard: false,
                                                      isKeyManagementIssuanceStatus:
                                                          false,
                                                    );
                                                  },
                                                );
                                              },
                                              showEditButton: state
                                                          .list[index].status !=
                                                      ConstantsIntValue
                                                          .cancelledStatus &&
                                                  state.list[index].status !=
                                                      ConstantsIntValue
                                                          .keyMMClosedStatus &&
                                                  state.extraProperties
                                                          ?.hasWritePermission ==
                                                      true,
                                              onEditTap: (selectedIndex) {
                                                getById(
                                                  state.extraProperties
                                                          ?.hasWritePermission ??
                                                      false,
                                                  state.list[index].id ?? 0,
                                                );
                                              },
                                              onViewTap: (selectedIndex) {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                      dialogContext) {
                                                    return BasePopUpItems(
                                                      id: state
                                                          .list[selectedIndex]
                                                          .id
                                                          .toString(),
                                                      slNo: state
                                                          .list[selectedIndex]
                                                          .slNo,
                                                      labels: labels,
                                                      status: state
                                                          .list[selectedIndex]
                                                          .status,
                                                      keyNo: state
                                                          .list[selectedIndex]
                                                          .keyNo,
                                                      // keyTagging: state
                                                      //     .list[selectedIndex]
                                                      //     .keyTagging,
                                                      doorName: state
                                                          .list[selectedIndex]
                                                          .doorName,
                                                      isEventProtectionStatus:
                                                          false,
                                                      isKeyManagementStatus:
                                                          true,
                                                      isKeyManagementIssuanceStatus:
                                                          false,
                                                      isMasterGuard: false,
                                                    );
                                                  },
                                                );
                                              },
                                              index: index,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                            }
                            // Handle the case where index is out of bounds
                            return const Center(child: SizedBox());
                          },
                        ),
                      ),
                    ),
                  ],
              );
            }),
        );
      },
    );
  }


  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    KeyManagementMasterModel keyManagementMasterModel =
        await KeyManagementMasterServices().getById(id);

    editDataLoading(keyManagementMasterModel, hasWritePermission);
  }

  void editDataLoading(
    KeyManagementMasterModel? keyManagementMasterModel,
    bool hasWritePermission,
  ) {
    dismissLoadingDialog(context);
    if (keyManagementMasterModel != null) {
      Navigator.pushNamed(
        context,
        keyManagementMasterDetailsRoute,
        arguments: {
          "keyMgmtGi": keyManagementMasterModel,
          "title": Constants.editkeyManagementMaster,
          ConstantsArgument.extraProperties: ExtraProperties(
            hasWritePermission: hasWritePermission,
          ),
        },
      );
    }
  }

  void applySearchFilters(FilterCriteria model) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<KeyManagementMasterListBloc>(context).add(
      FetchKeyMasterList(
        startPos: 0,
        maxPos: Constants.maxResults,
        newSearch: true,
        filters: filters,
      ),
    );
  }

  void applyFilters(Filters model) {
    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));

    BlocProvider.of<KeyManagementMasterListBloc>(context).add(
      FetchKeyMasterList(
        startPos: 0,
        maxPos: Constants.maxResults,
        newSearch: true,
        filters: filters,
      ),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
