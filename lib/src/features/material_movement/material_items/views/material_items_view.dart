import 'dart:developer';
import 'dart:ui';

import '../../../../../index.dart';
import '../../../contact_details/contact_records/views/add_contact_pop_up.dart';
import '../../models/material_items_model.dart';
import '../bloc/material_items_bloc.dart';
import 'add_material_items.dart';

class MaterialItemsView extends StatefulWidget {
  const MaterialItemsView({
    super.key,
    required this.id,
    required this.title,
    this.model,
    this.MMModel,
    this.extraProperties,
    this.lock,
    required this.parentStatus,
    required this.isInWard,
  });

  final int id;
  final String title;
  final MaterialMovementItem? model;
  final MaterialMovementModel? MMModel;
  final ExtraProperties? extraProperties;
  final String? lock;
  final int parentStatus;
  final bool isInWard;

  @override
  State<MaterialItemsView> createState() => _MaterialItemsViewView();
}

class _MaterialItemsViewView extends State<MaterialItemsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<MaterialItemsBloc>().add(
          const InitializeValues(),
        );
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
      context
          .read<MaterialItemsBloc>()
          .add(FetchItemData(id: widget.id, startPos: pageNumber, maxPos: 20));
    }
  }

  bool isPopUpShown = false;
  bool isReadOnly = false;

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<MaterialItemsBloc, MaterialItemsState>(
        listener: (context, state) {
      // Utils().formError(state, context);
      // Utils().errorAndLogout(state, context);
    }, builder: (context, state) {
      // if (widget.vvipModel?.status == 1) {
      //   isReadOnly = true;
      // }
      return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        // floatingActionButton: (widget.parentStatus == 0) &&
        //         !(widget.extraProperties != null &&
        //             !widget.extraProperties!.hasWritePermission!) &&
        //         widget.lock.isEmptyOrNull
        //     ? Flutterfloatingbutton(
        //         // foregroundColor: AppColors.backgroundWhiteColor,
        //         onPressed: () {
        //           showAddContactPopUp(
        //             context: context,
        //             contact: MaterialMovementItem(),
        //             unit: state.units ?? [],
        //           );
        //         },
        //       )
        //     : null,
        bottomNavigationBar: CustomBottomNavigationBar(
          hasAddPermission:(widget.parentStatus == 0) &&
              !(widget.extraProperties != null &&
                  !widget.extraProperties!.hasWritePermission!) &&
              widget.lock.isEmptyOrNull ? true : false,
          scaffoldKey: scaffoldKey,
          context: context,
          // displayMenu: state.displayMenu,
          list: true, // 🔥 only "+" button mode
          onAddPressed: () {
            showAddContactPopUp(
              context: context,
              contact: MaterialMovementItem(),
              unit: state.units ?? [],
            );
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: 'Material Items Description',
          showPopUp: false,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
        ),
        body: getBody(state),
      );
    });
  }

  getBody(MaterialItemsState state) {
    // if (state.status == FormStatus.initial ||
    //     state.status == FormStatus.loading) {
    //   return const BaseLoader();
    // }

    if (widget.parentStatus == 0 &&
        state.items!.isEmptyOrNull &&
        !isPopUpShown &&
        widget.lock.isEmptyOrNull) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isPopUpShown = true;
        // showAddVVIPVisitorsPopUp(
        //   context: context,
        //   contact: VIVPVisitorRecordModel(),
        // );
      });
      return const NoRecordFoundWidget();
    }
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
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
        ),

        ListView.builder(
          controller: _scrollController,
          itemCount: state.hasReachedMax
              ? state.items?.length
              : state.items!.length + 1,
          itemBuilder: (context, index) {
            List<Label> labels = [];
            if (index < state.items!.length) {
              labels.add(
                Label(
                  key:
                      // state.labels?.locale.visitorName ??
                      //     state.labels?.defaultLocale.visitorName ??
                      'Material Description',
                  value: state.items![index].materialDescription ?? '',
                ),
              );
              labels.add(
                Label(
                  key: 'Quantity',
                  value: '${state.items![index].quantity ?? ''}',
                ),
              );
              labels.add(
                Label(
                  key: 'Unit',
                  value: state.items![index].unit?.name ?? '',
                ),
              );
              labels.add(
                Label(
                  key:
                      // state.labels?.locale.visitorEmailId ??
                      //     state.labels?.defaultLocale.visitorEmailId ??
                      'Equipment No',
                  value: state.items![index].modelInfo ?? '',
                ),
              );
              return index >= state.items!.length
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
                              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withValues(alpha: 0.09),
                                      Colors.transparent,
                                      Colors.white.withValues(alpha: 0.09),
                                      // Color(0xFF6474C6).withOpacity(0.14)
                                    ],
                                    stops: [0.02, 0.35, 1],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(27),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    width: 0.7,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.white.withValues(alpha: 0.0),
                                      blurRadius: 12,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: BaseListTileItem(
                                  id: state.items?[index].id,

                                  labels: labels,
                                  onTap: (selectedIndex) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return BasePopUpItems(
                                          id: state.items?[selectedIndex].id
                                              .toString(),
                                          labels: labels,
                                        );
                                      },
                                    );
                                  },
                                  showEditButton: widget.parentStatus == 0 &&
                                      widget.lock.isEmptyOrNull,
                                  // onEditTap: (selectedIndex) async {
                                  //   // your edit logic
                                  // },
                                  // onEditTap: (selectedIndex) async {
                                  //   MaterialMovementItem contactsModel =
                                  //   await MaterialMovementServices()
                                  //       .getVPById(state.items?[index].id ?? 0);
                                  //
                                  //   showAddContactPopUp(
                                  //     context: context,
                                  //     contact: contactsModel,
                                  //     unit: state.units ?? [],
                                  //   );
                                  // },

                                  onEditTap: (selectedIndex) async {
                                    MaterialMovementItem visitorsModel =
                                        await MaterialMovementServices()
                                            .getVPById(
                                                state.items?[index].id ?? 0);

                                    showAddContactPopUp(
                                      context: context,
                                      contact: visitorsModel,
                                      unit: state.units ?? [],
                                    );
                                  },
                                  showViewButton: false,
                                  onViewTap: (selectedIndex) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return BasePopUpItems(
                                          id: state.items?[selectedIndex].id
                                              .toString(),
                                          labels: labels,
                                        );
                                      },
                                    );
                                  },
                                  showDeleteButton: widget.parentStatus == 0 &&
                                      widget.lock.isEmptyOrNull,
                                  // onDeleteTap: widget.parentStatus == 0
                                  //     ? (selectedIndex) async {
                                  //   BlocProvider.of<MaterialItemsBloc>(context)
                                  //       .add(DeleteRecord(
                                  //       state.items![selectedIndex].id!.toInt(),
                                  //       widget.id));
                                  // }
                                  onDeleteTap: (selectedIndex) async {
                                    /// Delete Warning Dialog Box
                                    var dialog = CustomAlertDialog(
                                        title: Constants.deleteRecord,
                                        message: Constants
                                            .deleteRecordWarningMessage,
                                        onPositivePressed: () {
                                          Navigator.pop(context);
                                          // Navigator.pop(context);
                                          // Call Delete API
                                          BlocProvider.of<MaterialItemsBloc>(
                                                  context)
                                              .add(DeleteRecord(
                                                  state
                                                      .items![selectedIndex].id!
                                                      .toInt(),
                                                  widget.id));
                                        },
                                        positiveBtnText: Constants.yes,
                                        negativeBtnText: Constants.no);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            dialog);

                                    // // Call Delete API
                                    // BlocProvider.of<ViolationPenaltyRecordBloc>(context).add(
                                    //     DeleteRecord(state.items![selectedIndex].id!.toInt(),
                                    //         widget.id));
                                  },

                                  index: index,
                                ),
                              ))));
            }
            return null;
          },
        ),
      ],
    );
  }

  // showAddVVIPVisitorsPopUp({
  //   required BuildContext context,
  //   required MaterialMovementItem contact,
  // }) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext dialogContext) {
  //       return AddMaterialItemsPopUp(
  //         title: widget.title,
  //         model: contact,
  //         mainContext: context,
  //         parentStatus: widget.parentStatus,
  //         onSubmit: (MaterialMovementItem model) {
  //           //loginFormKey.currentState!.validate();
  //           FocusScope.of(context).unfocus();
  //
  //
  //           BlocProvider.of<MaterialItemsBloc>(context).add(
  //             SaveRecord(
  //               model,
  //               widget.id,
  //             ),
  //           );
  //         }, users: [],
  //       );
  //     },
  //   );
  // }

  showAddContactPopUp({
    required BuildContext context,
    required MaterialMovementItem contact,
    required final List<Organisation> unit,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        log('widget.MMModel ${widget.isInWard}');
        log('parentStatu ${widget.parentStatus}');

        return AddMaterialItemsPopUp(
          title: widget.title,
          model: contact,
          mainContext: context,
          users: unit,
          parentStatus: widget.parentStatus,
          isInward: widget.isInWard,
          onSubmit: (MaterialMovementItem model) {
            //loginFormKey.currentState!.validate();
            FocusScope.of(context).unfocus();

            BlocProvider.of<MaterialItemsBloc>(context).add(
              SaveRecord(
                model,
                widget.id,
              ),
            );
          },
        );
      },
    );
  }
}
