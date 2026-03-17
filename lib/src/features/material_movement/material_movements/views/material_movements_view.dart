import 'dart:developer';
import 'dart:ui';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/material_movement/material_movements/bloc/material_movement_bloc.dart';
import '../../models/approval_model.dart';
import 'add_approval_popUp.dart';

class MaterialMovementsView extends StatefulWidget {
  const MaterialMovementsView({
    super.key,
    required this.isInward,
    this.returnable,
     this.model
  });

  final bool isInward;
  final bool? returnable;
  final ApprovalModel? model;

  @override
  State<MaterialMovementsView> createState() => _MaterialMovementsViewState();
}

class _MaterialMovementsViewState extends State<MaterialMovementsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<MaterialMovementBloc>().add(
          const InitializeValuesMM(),
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
      context.read<MaterialMovementBloc>().add(FetchData(
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
    context.read<MaterialMovementBloc>().add(const RefreshList());

    // Wait until the state status is FormStatus.success or FormStatus.failure
    await context.read<MaterialMovementBloc>().stream.firstWhere(
          (state) =>
              state.status == FormStatus.success ||
              state.status == FormStatus.failure,
        );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<MaterialMovementBloc, MaterialMovementState>(
      listener: (context, state) {
        // if (state.status == FormStatus.success &&
        //     state.approvalModel != null &&  state.model.approverStepId != null) {
        //   showAddContactPopUp(
        //     context: context,
        //     approvalModel: state.approvalModel!,
        //     apStepId: state.model.approverStepId!,
        //   );
        // }
        // if (state.status == FormStatus.success &&
        //     state.approvalModel != null &&
        //     state.model != null &&
        //     state.model!.approverStepId != null) {
        //   showAddContactPopUp(
        //     context: context,
        //     approvalModel: state.approvalModel!,
        //     apStepId: state.model!.approverStepId!,
        //   );
        // }
        // if (state.status != FormStatus.success) return;
        //
        // final approvalModel = state.approvalModel;
        // final apStepId = state.model?.approverStepId;
        //
        // debugPrint('approvalModel: $approvalModel');
        // debugPrint('apStepId: $apStepId');
        //
        // if (approvalModel == null || apStepId == null) return;
        //
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   showAddContactPopUp(
        //     context: context,
        //     approvalModel: approvalModel,
        //     apStepId: apStepId,
        //   );
        // });
        if (state.status != FormStatus.success) return;

        final approvalModel = state.approvalModel;
        final apStepId = state.selectedId ?? approvalModel?.apStepId;

        log('approvalModel: $approvalModel');
        debugPrint('apStepId: $apStepId');

        if (approvalModel == null || apStepId == null) return;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAddContactPopUp(
            context: context,
            approvalModel: approvalModel,
            apStepId: apStepId,
          );
        });
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          extendBody: true,
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: state.extraProperties?.hasWritePermission ?? false
                ? true
                : false,
            scaffoldKey: scaffoldKey,
            context: context,
            displayMenu: state.displayMenu,
            list: true,
            // 🔥 only "+" button mode
            onAddPressed: () {
              Navigator.pushNamed(
                  context, materialMovementInwardOutwardDetailsRoute,
                  arguments: {
                    "isInward": widget.isInward,
                    "isCreate": true,
                    "title": widget.isInward
                        ? Constants.materialMovementInwardCreate
                        : Constants.materialMovementOutwardCreate,
                    "returnable": widget.returnable ?? false,
                  });
            },
          ),
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
          body: BlocConsumer<MaterialMovementBloc, MaterialMovementState>(
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
                    top: MediaQuery.of(context).padding.top +
                        kToolbarHeight +
                        -40, // below AppBar
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
                    top: MediaQuery.of(context).padding.top +
                        kToolbarHeight +
                        10,
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
                            ? state.items.length
                            : state.items.length + 1,
                        itemBuilder: (context, index) {
                          List<Label> labels = [];
                          if (index < state.items.length) {
                            // log('000 ${state.items[index]
                            //     .approver1Email}');
                            // log('111 ${state.items[index]
                            //     .status}');
                            // // log('999 ${state.items[index]
                            //     .approver2Email}');
                            // log('888 ${state.items[index]
                            //     .approver1Email == state.items[index]
                            //     .entrySecurity?.userName}');
                            // log('777 ${state.items[index]
                            //     .approver2Email == state.items[index]
                            //     .entrySecurity?.userName}');
                            labels.add(Label(
                                key: state.labels?.locale.inputDate ??
                                    state
                                        .labels?.defaultLocale.requestorEmail ??
                                    Constants.date,
                                value: state.items[index].inputDate != null
                                    ? Utils.timestampToDateConversion(
                                        int.parse(
                                            state.items[index].inputDate ??
                                                '0'),
                                        Constants.twentyFourHourDateTimeFormat)
                                    : ''));
                            labels.add(Label(
                                key: state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
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
                            labels.add(Label(
                                key: state.labels?.locale.type ??
                                    state.labels?.defaultLocale.type ??
                                    Constants.materialMovementsType,
                                value: state.items[index].returnable == true
                                    ? state.labels?.locale.returnable ??
                                        state
                                            .labels?.defaultLocale.returnable ??
                                        Constants.returnable
                                    : state.labels?.locale.nonReturnable ??
                                        state.labels?.defaultLocale
                                            .nonReturnable ??
                                        Constants.nonReturnable));
                            if (widget.isInward) {
                              labels.add(Label(
                                  key: Constants.challan,
                                  value: state.items[index].challanNo ?? ''));
                            }
                            labels.add(Label(
                                key: !widget.isInward
                                    ? 'Gate Pass No'
                                    : Constants.slno,
                                value: state.items[index].slNo ?? ''));

                            return index >= state.items.length
                                ? const BaseLoader()
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
                                        horizontal: 12, vertical: 8),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 18, sigmaY: 18),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.white.withValues(
                                                          alpha: 0.09),
                                                      Colors.transparent,
                                                      Colors.white.withValues(
                                                          alpha: 0.09),
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
                                                          .withValues(
                                                              alpha: 0.0),
                                                      blurRadius: 12,
                                                      offset:
                                                          const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: BaseListTileItem(
                                                  id: state.items[index].id,
                                                  labels: labels,
                                                  status:
                                                      state.items[index].status,
                                                  isMasterGuard: false,
                                                  isMaterialMovementStatus:
                                                      true,
                                                  isEventProtectionStatus:
                                                      false,
                                                  showApproveButton: (state
                                                                  .items[index]
                                                                  .status ==
                                                      ConstantsIntValue
                                                          .mmStatusLSMApproved)
                                                      // &&
                                                      //     ((state.items[index]
                                                      //                 .approver1Email ==
                                                      //             state
                                                      //                 .items[index].entrySecurity
                                                      //                 ?.email) ||
                                                      //         (state.items[index]
                                                      //             .approver2Email ==
                                                      //             state
                                                      //                 .items[index].entrySecurity
                                                      //                 ?.email))
                                                      ? true
                                                      : false,
                                                  onApproveTap: (index) {
                                                    context.read<MaterialMovementBloc>().add(
                                                      FetchApprovalById(
                                                        apStepId: state.items[index].approverStepId!,
                                                      ),
                                                    );
                                                  },


                                                  onTap: (selectedIndex) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          dialogContext) {
                                                        return BasePopUpItems(
                                                          id: state
                                                              .items[
                                                                  selectedIndex]
                                                              .id
                                                              .toString(),
                                                          labels: labels,
                                                          quantity: state
                                                              .items[
                                                                  selectedIndex]
                                                              .quantity
                                                              .toString(),
                                                          challanNo: state
                                                              .items[
                                                                  selectedIndex]
                                                              .challanNo,
                                                          // slNo: state
                                                          //     .items[selectedIndex].slNo,
                                                          status: state
                                                              .items[
                                                                  selectedIndex]
                                                              .status,
                                                          entrySecurityName: state
                                                              .items[
                                                                  selectedIndex]
                                                              .entrySecurityName,
                                                          isMasterGuard: false,
                                                          isMaterialMovementStatus:
                                                              true,
                                                          isEventProtectionStatus:
                                                              false,
                                                        );
                                                      },
                                                    );
                                                  },
                                                  showEditButton: state
                                                              .items[index]
                                                              .status !=
                                                          ConstantsIntValue
                                                              .mmStatusClosed &&
                                                      state.items[index]
                                                              .status !=
                                                          ConstantsIntValue
                                                              .cancelledStatus,
                                                  onEditTap: (selectedIndex) {
                                                    getById(
                                                        state.extraProperties
                                                                ?.hasWritePermission ??
                                                            false,
                                                        state.items[index].id ??
                                                            0);
                                                  },
                                                  onViewTap: (selectedIndex) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          dialogContext) {
                                                        return BasePopUpItems(
                                                          id: state
                                                              .items[
                                                                  selectedIndex]
                                                              .id
                                                              .toString(),
                                                          labels: labels,
                                                          quantity: state
                                                              .items[
                                                                  selectedIndex]
                                                              .quantity
                                                              .toString(),
                                                          challanNo: state
                                                              .items[
                                                                  selectedIndex]
                                                              .challanNo,
                                                          // slNo: state
                                                          //     .items[selectedIndex].slNo,
                                                          status: state
                                                              .items[
                                                                  selectedIndex]
                                                              .status,
                                                          entrySecurityName: state
                                                              .items[
                                                                  selectedIndex]
                                                              .entrySecurityName,
                                                          isMasterGuard: false,
                                                          isMaterialMovementStatus:
                                                              true,
                                                          isEventProtectionStatus:
                                                              false,
                                                        );
                                                      },
                                                    );
                                                  },
                                                  index: index,
                                                )))));
                          }
                          return const Center(
                            child: SizedBox(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
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

    BlocProvider.of<MaterialMovementBloc>(context).add(
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

    BlocProvider.of<MaterialMovementBloc>(context).add(
      FetchData(
          startPos: 0,
          maxPos: Constants.maxResults,
          newSearch: true,
          filters: filters),
    );
    // _scrollController = ScrollController()..addListener(_onScroll);

    Navigator.pop(context);
  }

  showAddContactPopUp({
    required BuildContext context,
    required ApprovalModel approvalModel,
    required int apStepId,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return MaterialApproveRejectPopUp(
          title: '',
          model: approvalModel,
          mainContext: context,
          onSubmit: (ApprovalModel model) {
            //loginFormKey.currentState!.validate();
            FocusScope.of(context).unfocus();
            // model.apStepId = ;
            model.apStepId = apStepId;
            // model.objectId = approvalModel.objectId;
            BlocProvider.of<MaterialMovementBloc>(context).add(
              SaveRecord(
                model: model,
              ),
            );
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
