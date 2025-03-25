import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/law_enforcement_new/models/law_enforcement_model_new.dart';
import 'package:db_atom/src/features/law_enforcement_new/services/law_enforcement_services_new.dart';
import 'package:db_atom/src/features/law_enforcement_new/visiting_officials/bloc/visiting_officials_bloc.dart';
import 'package:db_atom/src/features/law_enforcement_new/visiting_officials/views/add_visiting_officials_pop_up.dart';

class VisitingOfficialsView extends StatefulWidget {
  const VisitingOfficialsView({
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
  final VisitingOfficialsModel? model;
  final LawEnforcementModelNew? vvipModel;
  final ExtraProperties? extraProperties;
  final String? lock;
  final int parentStatus;

  @override
  State<VisitingOfficialsView> createState() => _VisitingOfficialsView();
}

class _VisitingOfficialsView extends State<VisitingOfficialsView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<VisitingOfficialsBloc>().add(
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
          .read<VisitingOfficialsBloc>()
          .add(FetchVisitingOfficialsData(id: widget.id, startPos: pageNumber, maxPos: 20));
    }
  }

  bool isPopUpShown = false;
  bool isReadOnly = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VisitingOfficialsBloc, VisitingOfficialsState>(
        listener: (context, state) {
          // Utils().formError(state, context);
          // Utils().errorAndLogout(state, context);
        }, builder: (context, state) {
      if (widget.vvipModel?.status == 1) {
        isReadOnly = true;
      }
      return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: (widget.parentStatus == 0) &&
            !(widget.extraProperties != null &&
                !widget.extraProperties!.hasWritePermission!) &&
            widget.lock.isEmptyOrNull
            ? Flutterfloatingbutton(
          backgroundColor: AppColors.navigationSkyBlueColor,
          foregroundColor: AppColors.backgroundWhiteColor,
          onPressed: () {
            showAddVVIPVisitorsPopUp(
              context: context,
              model: VisitingOfficialsModel(),
              // departments: state.departments,
            );
          },
        )
            : null,
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

  getBody(VisitingOfficialsState state) {
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
          model: VisitingOfficialsModel(),
          // departments: state.departments,
        );
      });
      return const NoRecordFoundWidget();
    }
    return Container(
      margin: allMargin16,
      decoration: const ShapeDecoration(
          color: AppColors.backgroundWhiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          )),
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
        state.hasReachedMax ? state.items?.length : state.items!.length + 1,
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
            // labels.add(
            //   Label(
            //     key: state.labels?.locale.purposeOfVisit ??
            //         state.labels?.defaultLocale.purposeOfVisit ??
            //         Constants.purposeOfVisit,
            //     value: state.items![index].purpose ?? '',
            //   ),
            // );
            labels.add(
              Label(
                key: state.labels?.locale.visitorDesignation ??
                    state.labels?.defaultLocale.visitorDesignation ??
                    Constants.visitorsDesignation,
                value: state.items![index].designation ?? '',
              ),
            );
            // labels.add(
            //   Label(
            //     key: state.labels?.locale.baseLocationOfVisitor ??
            //         state.labels?.defaultLocale.baseLocationOfVisitor ??
            //         Constants.baseLocationOfVisitors,
            //     value: state.items![index].loc ?? '',
            //   ),
            // );
            // if (!(state.items![index].startDateVisit.isEmptyOrNull)) {
            //   labels.add(Label(
            //       key: state.labels?.locale.startDateVisit ??
            //           state.labels?.defaultLocale.startDateVisit ??
            //           'Start Date of Visit',
            //       value: Utils.timestampToDateConversion(
            //           int.parse(state.items![index].startDateVisit ?? '0'),
            //           Constants.twentyFourHourDateTimeFormat)));
            // }
            // if (!(state.items![index].endDateVisit.isEmptyOrNull)) {
            //   labels.add(Label(
            //       key: state.labels?.locale.endDateVisit ??
            //           state.labels?.defaultLocale.endDateVisit ??
            //           'End Date of Visit',
            //       value: Utils.timestampToDateConversion(
            //           int.parse(state.items![index].endDateVisit ?? '0'),
            //           Constants.twentyFourHourDateTimeFormat)));
            // }
            return index >= state.items!.length
                ? const BaseLoader()
                : BaseListTileItem(
              id: state.items?[index].id,
              labels: labels,
              onTap: (selectedIndex) {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return BasePopUpItems(
                      id: state.items?[selectedIndex].id.toString(),
                      labels: labels,
                    );
                  },
                );
              },
              showEditButton:
              widget.parentStatus == 0 && widget.lock.isEmptyOrNull,
              onEditTap: (selectedIndex) async {
                VisitingOfficialsModel visitorsModel =
                await LawEnforcementServicesNew()
                    .getLeoVisitingOfficialById(id:state.items?[index].id ?? 0);

                showAddVVIPVisitorsPopUp(
                  context: context,
                  model: visitorsModel,
                );
              },
              onViewTap: (selectedIndex) {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return BasePopUpItems(
                      id: state.items?[selectedIndex].id.toString(),
                      labels: labels,
                    );
                  },
                );
              },
              showDeleteButton:
              widget.parentStatus == 0 && widget.lock.isEmptyOrNull,
              onDeleteTap: widget.parentStatus == 0
                  ? (selectedIndex) async {
                // Call Delete API
                BlocProvider.of<VisitingOfficialsBloc>(context)
                    .add(DeleteRecord(
                    state.items![selectedIndex].id!.toInt(),
                    widget.id));
              }
                  : null,
              index: index,
            );
          }
          return null;
        },
      ),
    );
  }

  showAddVVIPVisitorsPopUp({
    required BuildContext context,
    required VisitingOfficialsModel model,
    // required final List<Organisation> departments,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddVisitingOfficialsPopUp(
          title: widget.title,
          model: model,
          mainContext: context,
          parentStatus: widget.parentStatus,
          // departments: departments,
          isLocked: true,
          onSubmit: (VisitingOfficialsModel model) {
            //loginFormKey.currentState!.validate();
            FocusScope.of(context).unfocus();

            log('-widget.model---${widget.model}----');

            BlocProvider.of<VisitingOfficialsBloc>(context).add(
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
