import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';

import '../../models/vvip_visitor_record_model.dart';
import '../../models/vvip_visitor_response_model.dart';
import '../../services/vvip_visitor_services.dart';
import '../bloc/vvip_visitors_record_bloc.dart';
import 'add_vvip_visitors_record_popup.dart';

class VVIPVisitorsRecordView extends StatefulWidget {
  const VVIPVisitorsRecordView({
    super.key,
    required this.id,
    required this.title,
    this.model,
    this.vvipModel,
    this.extraProperties,
    this.lock,
    required this.parentStatus,
  });

  final int id;
  final String title;
  final VIVPVisitorRecordModel? model;
  final VIVPVisitorModel? vvipModel;
  final ExtraProperties? extraProperties;
  final String? lock;
  final int parentStatus;

  @override
  State<VVIPVisitorsRecordView> createState() => _VVIPVisitorsRecordView();
}

class _VVIPVisitorsRecordView extends State<VVIPVisitorsRecordView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<VVIPVisitorsRecordBloc>().add(
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
          .read<VVIPVisitorsRecordBloc>()
          .add(FetchData(id: widget.id, startPos: pageNumber, maxPos: 20));
    }
  }

  bool isPopUpShown = false;
  bool isReadOnly = false;

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<VVIPVisitorsRecordBloc, VVIPVisitorsRecordState>(
        listener: (context, state) {
      // Utils().formError(state, context);
      // Utils().errorAndLogout(state, context);
    }, builder: (context, state) {
      if (widget.vvipModel?.status == 1) {
        isReadOnly = true;
      }
      return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        // floatingActionButton: (widget.parentStatus == 0) &&
        //         !(widget.extraProperties != null &&
        //             !widget.extraProperties!.hasWritePermission!) &&
        //         widget.lock.isEmptyOrNull
        //     ? Flutterfloatingbutton(
        //         backgroundColor: AppColors.navigationSkyBlueColor,
        //         foregroundColor: AppColors.backgroundWhiteColor,
        //         onPressed: () {
        //           showAddVVIPVisitorsPopUp(
        //             context: context,
        //             contact: VIVPVisitorRecordModel(),
        //           );
        //         },
        //       )
        //     : null,
        bottomNavigationBar: CustomBottomNavigationBar(
          hasAddPermission: (widget.parentStatus == 0) &&
                  !(widget.extraProperties != null &&
                      !widget.extraProperties!.hasWritePermission!) &&
                  widget.lock.isEmptyOrNull
              ? true
              : false,
          scaffoldKey: scaffoldKey,
          context: context,
          displayMenu: state.displayMenu,
          list: true,
          // 🔥 only "+" button mode
          onAddPressed: () {
            showAddVVIPVisitorsPopUp(
              context: context,
              contact: VIVPVisitorRecordModel(),
            );
          },
        ),
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.vVipVisitorsTitle,
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

  getBody(VVIPVisitorsRecordState state) {
    if (state.status == FormStatus.initial ||
        state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (widget.parentStatus == 0 &&
        state.items!.isEmptyOrNull &&
        !isPopUpShown &&
        widget.lock.isEmptyOrNull) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isPopUpShown = true;
        showAddVVIPVisitorsPopUp(
          context: context,
          contact: VIVPVisitorRecordModel(),
        );
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
                color: Colors.black.withValues(alpha: 0.2),
              ),
            ),
          ),
        ),
        ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.only(bottom: 100),

          itemCount: state.hasReachedMax
              ? state.items?.length
              : state.items!.length + 1,
          itemBuilder: (context, index) {
            List<Label> labels = [];
            if (index < state.items!.length) {
              labels.add(
                Label(
                  key: state.labels?.locale.visitorName ??
                      state.labels?.defaultLocale.visitorName ??
                      Constants.visitorsName,
                  value: state.items![index].name ?? '',
                ),
              );
              labels.add(
                Label(
                  key: state.labels?.locale.visitorEmailId ??
                      state.labels?.defaultLocale.visitorEmailId ??
                      Constants.visitorsEmailId,
                  value: state.items![index].email ?? '',
                ),
              );
              labels.add(
                Label(
                  key: state.labels?.locale.purposeOfVisit ??
                      state.labels?.defaultLocale.purposeOfVisit ??
                      Constants.purposeOfVisit,
                  value: state.items![index].purpose ?? '',
                ),
              );
              labels.add(
                Label(
                  key: state.labels?.locale.visitorDesignation ??
                      state.labels?.defaultLocale.visitorDesignation ??
                      Constants.visitorsDesignation,
                  value: state.items![index].designation ?? '',
                ),
              );
              labels.add(
                Label(
                  key: state.labels?.locale.baseLocationOfVisitor ??
                      state.labels?.defaultLocale.baseLocationOfVisitor ??
                      Constants.baseLocationOfVisitors,
                  value: state.items![index].baseLocation ?? '',
                ),
              );
              if (!(state.items![index].startDateVisit.isEmptyOrNull)) {
                labels.add(Label(
                    key: state.labels?.locale.startDateVisit ??
                        state.labels?.defaultLocale.startDateVisit ??
                        'Start Date of Visit',
                    value: Utils.timestampToDateConversion(
                        int.parse(state.items![index].startDateVisit ?? '0'),
                        Constants.twentyFourHourDateTimeFormat)));
              }
              if (!(state.items![index].endDateVisit.isEmptyOrNull)) {
                labels.add(Label(
                    key: state.labels?.locale.endDateVisit ??
                        state.labels?.defaultLocale.endDateVisit ??
                        'End Date of Visit',
                    value: Utils.timestampToDateConversion(
                        int.parse(state.items![index].endDateVisit ?? '0'),
                        Constants.twentyFourHourDateTimeFormat)));
              }
              return index >= state.items!.length
                  ? const BaseLoader()
                  : Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 15),
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
                                      stops: const [0.02, 0.35, 1],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.circular(27),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.6),
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
                                    onEditTap: (selectedIndex) async {
                                      VIVPVisitorRecordModel visitorsModel =
                                          await VVIPVisitorServices()
                                              .getVIPById(
                                                  state.items?[index].id ?? 0);

                                      showAddVVIPVisitorsPopUp(
                                        context: context,
                                        contact: visitorsModel,
                                      );
                                    },
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
                                    showDeleteButton:
                                        widget.parentStatus == 0 &&
                                            widget.lock.isEmptyOrNull,
                                    onDeleteTap: widget.parentStatus == 0
                                        ? (selectedIndex) async {
                                            // Call Delete API
                                            BlocProvider.of<
                                                        VVIPVisitorsRecordBloc>(
                                                    context)
                                                .add(
                                                    DeleteRecord(
                                                        state
                                                            .items![
                                                                selectedIndex]
                                                            .id!
                                                            .toInt(),
                                                        widget.id));
                                          }
                                        : null,
                                    index: index,
                                  )))));
            }
            return null;
          },
        ),
      ],
    );
  }

  showAddVVIPVisitorsPopUp({
    required BuildContext context,
    required VIVPVisitorRecordModel contact,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddVVIPVisitorsPopUp(
          title: widget.title,
          model: contact,
          mainContext: context,
          parentStatus: widget.parentStatus,
          onSubmit: (VIVPVisitorRecordModel model) {
            //loginFormKey.currentState!.validate();
            FocusScope.of(context).unfocus();

            log('-widget.model---${widget.model}----');

            BlocProvider.of<VVIPVisitorsRecordBloc>(context).add(
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
