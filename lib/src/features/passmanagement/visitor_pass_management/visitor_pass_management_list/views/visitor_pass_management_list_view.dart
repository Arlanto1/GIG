
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/models/visitor_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/services/visitor_pass_management_service.dart';
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/visitor_pass_management_list/bloc/visitor_pass_management_list_bloc.dart';

class VisitorPassManagementListView extends StatefulWidget {
  const VisitorPassManagementListView({
    super.key,
  });

  @override
  State<VisitorPassManagementListView> createState() => _VisitorPassManagementListViewState();
}

class _VisitorPassManagementListViewState extends State<VisitorPassManagementListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<VisitorPassManagementListBloc>().add(
      const InitializeVisitorPassValues(),
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
      context.read<VisitorPassManagementListBloc>().add(FetchVisitorPassData(
        startPos: pageNumber,
        maxPos: Constants.maxResults,
        newSearch: false,
        filters: filters,
      ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<VisitorPassManagementListBloc>().add(
      const RefreshVisitorPassList(),
    );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<VisitorPassManagementListBloc, VisitorPassManagementListState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              backgroundColor: AppColors.cardBgColor,
              floatingActionButton: state.extraProperties?.hasWritePermission ??
                  false
                  ? Flutterfloatingbutton(
                backgroundColor: AppColors.navigationSkyBlueColor,
                foregroundColor: AppColors.backgroundWhiteColor,
                onPressed: () => {
                  Navigator.pushNamed(context, visitorPassManagementDetailsRoute,
                      arguments: {
                        "title": Constants.createVisitorPassManagementTitle
                      }),
                },
              )
                  : const SizedBox(),
              appBar: BaseAppBar().buildAppHeader(
                context: context,
                title: Constants.visitorPassManagementTitle,
                showPopUp: true,
                showSaveButton: false,
                showSubmitButton: false,
                showDisLikeButton: false,
                showLikeButton: false,
                excelAPIName: 'exportPassMgmtExcel?passType=${1}&isList=1',
                pdfAPIName: 'exportPassMgmtPDF?passType=${1}&isList=1',
              ),
              body:
              BlocBuilder<VisitorPassManagementListBloc, VisitorPassManagementListState>(
                  builder: (context, state) {
                    // if (state.status == FormStatus.loading) {
                    //   return const BaseLoader();
                    // }
                    // if (state.list.isEmptyOrNull) {
                    //   return const NoRecordFoundWidget();
                    // }
                    // log('--labels-${state.labels?.locale.locationRegion}');
                    return Container(
                      margin: allMargin16,
                      decoration: const ShapeDecoration(
                          color: AppColors.backgroundWhiteColor,
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
                                        key: state.labels?.locale.visitorPassInfo ??
                                            state.labels?.defaultLocale
                                                .visitorPassInfo ??
                                            Constants.visitorPassNo,
                                        value:
                                        '${state.items[index].passInfo?.passNo ?? ''} '));

                                    // labels.add(Label(
                                    //     key: state.labels?.locale.companyType ??
                                    //         state.labels?.defaultLocale.companyType ??
                                    //         Constants.companyType,
                                    //     value: state.items[index].companyType?.name ??
                                    //         ''));
                                    return index >= state.items.length
                                        ? const BaseLoader()
                                        : BaseListTileItem(
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
                                              isPassManagementStatus: true,
                                              isEventProtectionStatus: false,
                                              isMasterGuard: false,
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
                  }));
        });
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    VisitorPassManagementModel visitorPassManagementModel =
    await VisitorPassManagementServices().getById(id);

    editDataLoading(visitorPassManagementModel, hasWritePermission);
  }

  void editDataLoading(
      VisitorPassManagementModel? visitorPassManagementModel, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (VisitorPassManagementModel != null) {
      Navigator.pushNamed(context, visitorPassManagementDetailsRoute, arguments: {
        "model": visitorPassManagementModel,
        "title": Constants.editVisitorPassManagementTitle,
        ConstantsArgument.extraProperties:
        ExtraProperties(hasWritePermission: hasWritePermission),
      });
    }
  }

  void applySearchFilters(
      FilterCriteria model,
      ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<VisitorPassManagementListBloc>(context).add(
      FetchVisitorPassData(
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

    BlocProvider.of<VisitorPassManagementListBloc>(context).add(
      FetchVisitorPassData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}

