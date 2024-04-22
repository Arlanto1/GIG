import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../bloc/contact_details_list_bloc.dart';

class ContactDetailsListView extends StatefulWidget {
  const ContactDetailsListView({
    super.key,
  });

  @override
  State<ContactDetailsListView> createState() => _ContactDetailsListViewState();
}

class _ContactDetailsListViewState extends State<ContactDetailsListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    context.read<ContactDetailsListBloc>().add(
          const InitializeValuesCD(),
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
      context.read<ContactDetailsListBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    log('-----didUpdateWidget----------');
    // This method is called when the widget is updated or rebuilt
    // You can perform actions here when the state is resumed
    setState(() {
      // Fetch or update yourItemList here
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   log('-----didChangeDependencies----------');
  //   // Fetch or update yourItemList here
  //   _scrollController = ScrollController()..addListener(_onScroll);
  //
  // }

  void _onRefresh() async {
    context.read<ContactDetailsListBloc>().add(
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
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      floatingActionButton: Flutterfloatingbutton(
        backgroundColor: AppColors.navigationSkybluecolor,
        foregroundColor: AppColors.backgroundWhitecolor,
        onPressed: () => {
          Navigator.pushNamed(context, contactDetailsRoute, arguments: {
            "title": Constants.escalationMatrix,
          })
        },
      ),
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: Constants.escalationMatrix,
        showPopUp: true,
        showSaveButton: false,
        showSubmitButton: false,
        showDisLikeButton: false,
        showLikeButton: false,
        excelAPIName: 'exportGcdExcel',
        pdfAPIName: 'exportGcdPDF',
      ),
      body: BlocConsumer<ContactDetailsListBloc, ContactDetailsListState>(
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
          // if (state.items.isEmptyOrNull) {
          //   return const NoRecordFoundWidget();
          // }
          return Container(
            margin: allMargin16,
            decoration: const ShapeDecoration(
              color: AppColors.backgroundWhitecolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
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
                // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                // Text('state.status=====${state.status}'),
                if (state.items.isEmptyOrNull &&
                    state.status != FormStatus.loading) ...[
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
                              key: state.labels?.locale.entrySecurity ??
                                  state.labels?.defaultLocale.entrySecurity ??
                                  'Created By',
                              value:'${state.items[index].entrySecurity?.firstName ??''} ${state.items[index].entrySecurity?.lastName ?? ''}'
                                  ));
                          labels.add(Label(
                              key: state.labels?.locale.locationRegion ??
                                  state.labels?.defaultLocale.locationRegion ??
                                  'Region',
                              value: state.items[index].locationRegion?.name ??
                                  ''));
                          labels.add(Label(
                              key: state.labels?.locale.slNo ??
                                  state.labels?.defaultLocale.slNo ??
                                  'SL No',
                              value: state.items[index].slNo ?? ''));
                          labels.add(Label(
                              key: state.labels?.locale.location ??
                                  state.labels?.defaultLocale.location ??
                                  'Location',
                              value: state.items[index].location?.name ?? ''));
                          return index >= state.items.length
                              ? const BaseLoader()
                              : BaseListTileItem(
                                  id: state.items[index].id,
                                  labels: labels,
                                  status: state.items[index].status,
                                  isEventProtectionStatus: false,
                                  isContactDetailsStatus: true,
                                  onTap: (selectedIndex) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return BasePopUpItems(
                                          id: state.items[selectedIndex].id
                                              .toString(),
                                          labels: labels,
                                          status:
                                              state.items[selectedIndex].status,
                                          isContactDetailsStatus: true,
                                          isEventProtectionStatus: false,
                                          isMasterGuard: false,
                                        );
                                      },
                                    );
                                  },
                                  onEditTap: (selectedIndex) {
                                    getById(state.items[index].id ?? 0);
                                  },
                                  onViewTap: (selectedIndex) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return BasePopUpItems(
                                          id: state.items[selectedIndex].id
                                              .toString(),
                                          labels: labels,
                                          status:
                                              state.items[selectedIndex].status,
                                          isContactDetailsStatus: true,
                                          isEventProtectionStatus: false,
                                          isMasterGuard: false,
                                        );
                                      },
                                    );
                                  },
                                  index: index,
                                );
                        }
                        return null;
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
  }

  getById(int id) async {
    showLoadingDialog(context);

    ContactDetailModel materialMovementModel =
        await ContactDetailsServices().getGcdById(id);

    editDataLoading(materialMovementModel);
  }

  void editDataLoading(ContactDetailModel? model) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        contactDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.escalationMatrix,
        },
      );
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<ContactDetailsListBloc>(context).add(
      FetchData(startPos: 0, maxPos: Constants.maxResults, newSearch: true, filters: filters),
    );
  }

  void applyFilters(
    Filters model,
  ) {
    log('Applying Filters');

    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    log('id---filtersFun----${filters.filterCriteria!.filters!.id}---');

    BlocProvider.of<ContactDetailsListBloc>(context).add(
      FetchData(startPos: 0, maxPos: Constants.maxResults, newSearch: true, filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
