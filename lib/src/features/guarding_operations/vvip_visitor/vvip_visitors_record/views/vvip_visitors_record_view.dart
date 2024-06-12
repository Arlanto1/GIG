import 'dart:developer';

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
    return BlocConsumer<VVIPVisitorsRecordBloc, VVIPVisitorsRecordState>(
        listener: (context, state) {
      // Utils().formError(state, context);
      // Utils().errorAndLogout(state, context);
    }, builder: (context, state) {
      if (widget.vvipModel?.status == 1) {
        isReadOnly = true;
      }
      return Scaffold(
        backgroundColor: AppColors.cardBgColor,
        floatingActionButton: (widget.vvipModel?.status == 0 ||
                    widget.vvipModel?.status == null) &&
            !(widget.extraProperties != null &&
                !widget.extraProperties!.hasWritePermission!) && widget.lock.isEmptyOrNull
            ? Flutterfloatingbutton(
                backgroundColor: AppColors.navigationSkyBlueColor,
                foregroundColor: AppColors.backgroundWhiteColor,
                onPressed: () {
                  showAddVVIPVisitorsPopUp(
                    context: context,
                    contact: VIVPVisitorRecordModel(),
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

  getBody(VVIPVisitorsRecordState state) {
    if (state.status == FormStatus.initial ||
        state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.items!.isEmptyOrNull && !isPopUpShown && widget.lock.isEmptyOrNull) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isPopUpShown = true;
        showAddVVIPVisitorsPopUp(
          context: context,
          contact: VIVPVisitorRecordModel(),
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
                key: 'Visitor Name',
                value: state.items![index].name ?? '',
              ),
            );
            labels.add(
              Label(
                key: 'Visitor Email Id',
                value: state.items![index].email ?? '',
              ),
            );
            labels.add(
              Label(
                key: 'Purpose of Visit',
                value: state.items![index].purpose ?? '',
              ),
            );
            labels.add(
              Label(
                key: 'Visitor Designation',
                value: state.items![index].designation ?? '',
              ),
            );
            labels.add(
              Label(
                key: 'Base Location of Visitor',
                value: state.items![index].baseLocation ?? '',
              ),
            );
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
              showEditButton: widget.parentStatus != 0 && !widget.lock.isEmptyOrNull,
              showDutyPostEditButton: widget.parentStatus == 0 && widget.lock.isEmptyOrNull,
                    onEditTap: (selectedIndex) async {
                      VIVPVisitorRecordModel visitorsModel =
                          await VVIPVisitorServices()
                              .getVIPById(state.items?[index].id ?? 0);

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
                            id: state.items?[selectedIndex].id.toString(),
                            labels: labels,
                          );
                        },
                      );
                    },
              showDeleteButton: widget.parentStatus == 0 && widget.lock.isEmptyOrNull,
                    onDeleteTap: widget.parentStatus == 0
                        ? (selectedIndex) async {
                            // Call Delete API
                            BlocProvider.of<VVIPVisitorsRecordBloc>(context)
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
