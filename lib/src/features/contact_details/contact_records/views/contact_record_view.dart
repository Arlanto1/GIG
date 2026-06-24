import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/contact_details/contact_records/views/add_contact_pop_up.dart';
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';

import '../bloc/contact_record_bloc.dart';

class ContactRecordView extends StatefulWidget {
  const ContactRecordView({
    super.key,
    required this.id,
    required this.title,
    required this.type,
    required this.rankType,
    this.model,
    required this.parentStatus,
    this.lock,
    this.extraProperties,
  });

  final int id;
  final String title;
  final int type;
  final String rankType;
  final ContactDetailModel? model;
  final int parentStatus;
  final String? lock;
  final ExtraProperties? extraProperties;

  @override
  State<ContactRecordView> createState() => _ContactRecordViewState();
}

class _ContactRecordViewState extends State<ContactRecordView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    context.read<ContactRecordBloc>().add(
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
      context.read<ContactRecordBloc>().add(FetchData(
          id: widget.id, type: widget.type, startPos: pageNumber, maxPos: 20));
    }
  }

  bool isPopUpShown = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactRecordBloc, ContactRecordState>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: widget.title,
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

  Widget getBody(ContactRecordState state) {
    if (state.status == FormStatus.initial ||
        state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.items.isEmptyOrNull &&
        !isPopUpShown &&
        widget.lock.isEmptyOrNull &&
        widget.parentStatus != ConstantsIntValue.cancelledStatus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isPopUpShown = true;
        showAddContactPopUp(
          // context: context,
          contact: ContactRecord(
            contactId: widget.id,
            email: '',
            contactNo: '',
            rank: Organisation(),
            type: widget.type,
          ),
          users: state.ranks,
          rankType: widget.rankType,
        );
      });
      return const NoRecordFoundWidget();
    }

    return Stack(
      children: [
        //  Background
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
        SafeArea(
        child: Column(
          children: [
            Expanded(
                // <-- Wrap ListView.builder inside Expanded
                child: Stack(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: state.hasReachedMax
                      ? state.items?.length
                      : state.items!.length + 1,
                  itemBuilder: (context, index) {
                    List<Label> labels = [];
                    if (index < state.items!.length) {
                      labels.add(
                        Label(
                          key: widget.rankType == Constants.contactZone
                              ? Constants.zone
                              : widget.rankType == Constants.contactGeneralRank
                                  ? Constants.rank
                                  : widget.rankType ==
                                          Constants.contactSystemEscalationRank
                                      ? Constants.systemSiEscalationMatrixRank
                                      : widget.rankType ==
                                              Constants.contactSupervisorRank
                                          ? Constants.supervisorRank
                                          : Constants.guardingAgencyRank,
                          value: state.items![index].rank?.name ?? '',
                        ),
                      );
                      labels.add(
                        Label(
                          key: widget.rankType == Constants.contactZone
                              ? Constants.areaNameManager
                              : Constants.name,
                          value: state.items![index].email ?? '',
                        ),
                      );
                      labels.add(
                        Label(
                          key: Constants.phoneNumber,
                          value: state.items![index].contactNo ?? '',
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
                                      filter: ImageFilter.blur(
                                          sigmaX: 18, sigmaY: 18),
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
                                          child: BaseListTileItem(
                                            id: state.items?[index].id,
                                            labels: labels,
                                            onTap: (selectedIndex) {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                    dialogContext) {
                                                  return BasePopUpItems(
                                                    id: state
                                                        .items?[selectedIndex]
                                                        .id
                                                        .toString(),
                                                    labels: labels,
                                                  );
                                                },
                                              );
                                            },
                                            showEditButton: false,
                                            onEditTap: (selectedIndex) async {
                                              ContactRecord contactsModel =
                                                  await ContactDetailsServices()
                                                      .getCdById(state
                                                              .items?[index]
                                                              .id ??
                                                          0);

                                              if (!mounted) return;
                                              showAddContactPopUp(
                                                // context: context,
                                                contact: contactsModel,
                                                users: state.ranks,
                                                rankType: widget.rankType,
                                              );
                                              // getDetails(state.items?[index].id ?? 0);
                                            },
                                            onViewTap: (selectedIndex) {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                    dialogContext) {
                                                  return BasePopUpItems(
                                                    id: state
                                                        .items?[selectedIndex]
                                                        .id
                                                        .toString(),
                                                    labels: labels,
                                                  );
                                                },
                                              );
                                            },
                                            showDeleteButton: false,
                                            onDeleteTap: (selectedIndex) async {
                                              // Call Delete API
                                              BlocProvider.of<
                                                          ContactRecordBloc>(
                                                      context)
                                                  .add(DeleteRecord(
                                                      state
                                                          .items![selectedIndex]
                                                          .id!
                                                          .toInt(),
                                                      widget.type,
                                                      widget.id));
                                            },
                                            index: index,
                                          )))));
                    }
                    return null;
                  },
                ),
              ],
            ))
          ],
        ),),
      ],
    );
  }

  void showAddContactPopUp({
    // required BuildContext context,
    required ContactRecord contact,
    required List<Organisation> users,
    required String rankType,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddContactPopUp(
          title: widget.title,
          model: contact,
          mainContext: context,
          users: users,
          rankType: rankType,
          parentStatus: widget.parentStatus,
          lock: widget.lock,
          onSubmit: (ContactRecord model) {
            //loginFormKey.currentState!.validate();
            FocusScope.of(context).unfocus();

            log('-widget.title---${widget.title}----');

            BlocProvider.of<ContactRecordBloc>(context)
                .add(SaveRecord(model, widget.id, widget.type));
          },
        );
      },
    );
  }

  getDetails(int id) async {
    showLoadingDialog(context);

    ContactRecord contactsModel = await ContactDetailsServices().getCdById(id);

    editDataLoading(contactsModel);
  }

  void editDataLoading(ContactRecord? model) {
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
}
