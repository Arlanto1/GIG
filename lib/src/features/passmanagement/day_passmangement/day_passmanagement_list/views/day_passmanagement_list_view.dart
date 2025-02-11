import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/day_passmangement/day_passmanagement_list/bloc/day_passmanagement_bloc.dart';

class DayPassManagementListView extends StatefulWidget {
  const DayPassManagementListView({
    super.key,
    required this.isInward,
    this.returnable,
  });

  final bool isInward;
  final bool? returnable;

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
    context.read<DayPassManagementBloc>().add(
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
      context.read<DayPassManagementBloc>().add(FetchDayPassData(
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
    context.read<DayPassManagementBloc>().add(const RefreshDayPassList());

    // Wait until the state status is FormStatus.success or FormStatus.failure
    await context.read<DayPassManagementBloc>().stream.firstWhere(
          (state) =>
      state.status == FormStatus.success ||
          state.status == FormStatus.failure,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<DayPassManagementBloc, DayPassManagementState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.cardBgColor,
          floatingActionButton:
          state.extraProperties?.hasWritePermission ?? false
              ? Flutterfloatingbutton(
            backgroundColor: AppColors.navigationSkyBlueColor,
            foregroundColor: AppColors.backgroundWhiteColor,
            onPressed: () => {
              Navigator.pushNamed(
                  context, materialMovementInwardOutwardDetailsRoute,
                  arguments: {
                    "isInward": widget.isInward,
                    "isCreate": true,
                    "title": widget.isInward
                        ? Constants.materialMovementInwardCreate
                        : Constants.materialMovementOutwardCreate,
                    "returnable": widget.returnable ?? false,
                  })
            },
          )
              : const SizedBox(),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.isInward
                ? Constants.materialMovementsInwardTitle
                : Constants.materialMovementsOutwardTitle,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName: 'exportMMExcel?mmType=${widget.isInward ? 1 : 0}',
            pdfAPIName: 'exportMMPDF?mmType=${widget.isInward ? 1 : 0}',
          ),
          body: BlocConsumer<DayPassManagementBloc, DayPassManagementState>(
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
                                  key: state.labels?.locale.inputDate ??
                                      state.labels?.defaultLocale
                                          .inputDate ??
                                      Constants.date,
                                  value: state.items[index].inputDate != null
                                      ? Utils.timestampToDateConversion(
                                      int.parse(
                                          state.items[index].inputDate ??
                                              '0'),
                                      Constants
                                          .twentyFourHourDateTimeFormat)
                                      : ''));
                              labels.add(Label(
                                  key: state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.createdby,
                                  value:
                                  '${state.items[index].entrySecurity?.firstName ?? ''} ${state.items[index].entrySecurity?.lastName ?? ''}'));

                              labels.add(Label(
                                  key: Constants.region,
                                  value:
                                  state.items[index].locationRegion?.name ??
                                      ''));
                              labels.add(Label(
                                  key: state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.location,
                                  value:
                                  state.items[index].location?.name ?? ''));
                              // labels.add(Label(
                              //     key: state.labels?.locale.type ??
                              //         state.labels?.defaultLocale.type ??
                              //         Constants.materialMovementsType,
                              //     value: state.items[index].returnable == true
                              //         ? state.labels?.locale.returnable ??
                              //         state.labels?.defaultLocale
                              //             .returnable ??
                              //         Constants.returnable
                              //         : state.labels?.locale.nonReturnable ??
                              //         state.labels?.defaultLocale
                              //             .nonReturnable ??
                              //         Constants.nonReturnable)
                              // );

                              return index >= state.items.length
                                  ? const BaseLoader()
                                  : BaseListTileItem(
                                id: state.items[index].id,
                                labels: labels,
                                status: state.items[index].status,
                                isMasterGuard: false,
                                isMaterialMovementStatus: false,
                                isEventProtectionStatus: false,
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
                                        entrySecurityName: state
                                            .items[selectedIndex]
                                            .entrySecurityName,
                                        isMasterGuard: false,
                                        isEventProtectionStatus: false,
                                      );
                                    },
                                  );
                                },
                                showEditButton: state
                                    .items[index].status !=
                                    ConstantsIntValue
                                        .mmStatusClosed &&
                                    state.items[index].status !=
                                        ConstantsIntValue.cancelledStatus,
                                onEditTap: (selectedIndex) {
                                  getById(
                                      state.extraProperties
                                          ?.hasWritePermission ??
                                          false,
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
                                        slNo: state
                                            .items[selectedIndex].slNo,
                                        status: state
                                            .items[selectedIndex].status,
                                        entrySecurityName: state
                                            .items[selectedIndex]
                                            .entrySecurityName,
                                        isMasterGuard: false,
                                        isEventProtectionStatus: false,
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

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    MaterialMovementModel materialMovementModel =
    await MaterialMovementServices().getById(id);

    editDataLoading(materialMovementModel, hasWritePermission);
  }

  Future<void> editDataLoading(MaterialMovementModel? materialMovementModel,
      bool hasWritePermission) async {
    dismissLoadingDialog(context);
    if (materialMovementModel != null) {
      Navigator.pushNamed(context, materialMovementInwardOutwardDetailsRoute,
          arguments: {
            "MaterialMovementModel": materialMovementModel,
            "isInward": widget.isInward,
            "title": widget.isInward
                ? Constants.materialMovementInwardEdit
                : Constants.materialMovementOutwardEdit,
            ConstantsArgument.extraProperties:
            ExtraProperties(hasWritePermission: hasWritePermission),
            "returnable": widget.returnable,
          });
    }
  }

  void applySearchFilters(
      FilterCriteria model,
      ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<DayPassManagementBloc>(context).add(
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
    log('Applying Filters');

    filters = BaseFilterModel(filterCriteria: FilterCriteria(filters: model));
    log('id---filtersFun----${filters.filterCriteria!.filters!.id}---');

    BlocProvider.of<DayPassManagementBloc>(context).add(
      FetchDayPassData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }
}
