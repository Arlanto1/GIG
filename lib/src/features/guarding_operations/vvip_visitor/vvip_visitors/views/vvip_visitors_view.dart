import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/models/vvip_visitor_response_model.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/services/vvip_visitor_services.dart';
import 'package:db_atom/src/features/guarding_operations/vvip_visitor/vvip_visitors/bloc/vvip_visitors_bloc.dart';

class VVIPVisitorsView extends StatefulWidget {
  final VIVPVisitorModel? model;

  const VVIPVisitorsView({
    super.key,
    this.model,
  });

  @override
  State<VVIPVisitorsView> createState() => _VVIPVisitorsViewState();
}

class _VVIPVisitorsViewState extends State<VVIPVisitorsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<VVIPVisitorsBloc>().add(
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
      context.read<VVIPVisitorsBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<VVIPVisitorsBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<VVIPVisitorsBloc, VVIPVisitorsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.cardBgColor,
            floatingActionButton:
                (widget.model?.status != 0 || widget.model?.status != null) &&
                        (state.extraProperties?.hasWritePermission ?? false)
                    ? Flutterfloatingbutton(
                        backgroundColor: AppColors.navigationSkyBlueColor,
                        foregroundColor: AppColors.backgroundWhiteColor,
                        onPressed: () => {
                          Navigator.pushNamed(context, vipVisitorsDetailsRoute,
                              arguments: {
                                "title": Constants.vVipVisitorsTitle,
                              })
                        },
                      )
                    : null,
            appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: Constants.vVipVisitorsListTitle,
              showPopUp: true,
              showSaveButton: false,
              showSubmitButton: false,
              showDisLikeButton: false,
              showLikeButton: false,
              excelAPIName: 'exportVipExcel',
              pdfAPIName: 'exportVipPDF',
            ),
            body: BlocBuilder<VVIPVisitorsBloc, VVIPVisitorsState>(
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
                    if (state.status == FormStatus.loading) ...[
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      const BaseLoader(),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                    ],
                    // Text('state.items.isEmptyOrNull=====${state.items.isEmptyOrNull}'),
                    // Text('state.status=====${state.status}'),
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
                                  key: state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      'Created By',
                                  value:
                                      '${state.items[index].entrySecurity?.firstName ?? ''} ${state.items[index].entrySecurity?.lastName ?? ''}'));
                              labels.add(Label(
                                  key: state.labels?.locale.slNo ??
                                      state.labels?.defaultLocale.slNo ??
                                      'SL No',
                                  value: state.items[index].slNo ?? ''));
                              labels.add(Label(
                                  key: state.labels?.locale.inputDate ??
                                      state.labels?.defaultLocale.inputDate ??
                                      'Date of Creation',
                                  value: state.items[index].inputDate != null
                                      ? Utils.timestampToDateConversion(
                                          int.parse(
                                              state.items[index].inputDate ??
                                                  '0'),
                                          Constants
                                              .twentyFourHourDateTimeFormat)
                                      : ''));
                              labels.add(Label(
                                  key: state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      'Location',
                                  value:
                                      state.items[index].location?.name ?? ''));
                            }
                            return index >= state.items.length
                                ? const SizedBox()
                                : BaseListTileItem(
                                    id: state.items[index].id,
                                    labels: labels,
                                    status: state.items[index].status,
                                    isVipStatus: true,
                                    isEventProtectionStatus: false,
                                    onTap: (selectedIndex) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.items[selectedIndex].id
                                                .toString(),
                                            labels: labels,
                                            status: state
                                                .items[selectedIndex].status,
                                            isVipStatus: true,
                                            isEventProtectionStatus: false,
                                            isMasterGuard: false,
                                          );
                                        },
                                      );
                                    },
                                    showEditButton:
                                        state.items[index].status ==
                                            ConstantsIntValue.vVIPCreatedStatus,
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
                                        builder: (BuildContext dialogContext) {
                                          return BasePopUpItems(
                                            id: state.items[selectedIndex].id
                                                .toString(),
                                            labels: labels,
                                            status: state
                                                .items[selectedIndex].status,
                                            isVipStatus: true,
                                            isEventProtectionStatus: false,
                                            isMasterGuard: false,
                                          );
                                        },
                                      );
                                    },
                                    index: index,
                                  );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
      },
    );
  }

  getById(bool hasWritePermission, int id) async {
    showLoadingDialog(context);

    VIVPVisitorModel model = await VVIPVisitorServices().getGVipById(id);

    editDataLoading(model, hasWritePermission);
  }

  void editDataLoading(VIVPVisitorModel? model, bool hasWritePermission) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        vipVisitorsDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.vVipVisitorsTitle,
          ConstantsArgument.extraProperties:
              ExtraProperties(hasWritePermission: hasWritePermission),
        },
      );
    }
  }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<VVIPVisitorsBloc>(context).add(
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

    BlocProvider.of<VVIPVisitorsBloc>(context).add(
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
