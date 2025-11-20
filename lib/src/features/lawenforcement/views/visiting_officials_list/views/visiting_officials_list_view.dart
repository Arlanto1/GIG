import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/contact_details/services/contact_details_services.dart';
import 'package:db_atom/src/features/lawenforcement/services/law_enforcement_services.dart';

import '../bloc/visiting_officials_list_bloc.dart';

class VisitingOfficialListView extends StatefulWidget {
  const VisitingOfficialListView({
    super.key,
    required this.id,
    required this.title,
    required this.type,
    required this.showSaveButton,
    required this.parentIsEligibleToEdit,
    this.lock,
  });

  final int id;
  final String title;
  final int type;
  final bool showSaveButton;
  final String? lock;
  final bool parentIsEligibleToEdit;

  @override
  State<VisitingOfficialListView> createState() =>
      _VisitingOfficialListViewState();
}

class _VisitingOfficialListViewState extends State<VisitingOfficialListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    context.read<VisitingOfficialListBloc>().add(
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
      context.read<VisitingOfficialListBloc>().add(FetchData(
          id: widget.id, type: widget.type, startPos: pageNumber, maxPos: 20));
    }
  }

  bool isPopUpShown = false;

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<VisitingOfficialListBloc, VisitingOfficialListState>(
        listener: (context, state) {
      Utils().formError(state, context);
      Utils().errorAndLogout(state, context);
    }, builder: (context, state) {
      return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return;
          }
          await backButtonFunction(context);
        },
        child: Scaffold(
          backgroundColor: AppColors.lavender,
          // floatingActionButton: widget.showSaveButton && widget.parentIsEligibleToEdit
          //     ? Flutterfloatingbutton(
          //         backgroundColor: AppColors.navigationSkyBlueColor,
          //         foregroundColor: AppColors.backgroundWhiteColor,
          //         onPressed: () {
          //           showAddContactPopUp(
          //             context: context,
          //             visitingOfficialDetails: LawVisitingOfficial(
          //               id: null,
          //               email: '',
          //               contactNo: '',
          //               department: Organisation(),
          //               designation: '',
          //             ),
          //             departments: state.departments,
          //           );
          //         },
          //       )
          //     : Container(),
          bottomNavigationBar: CustomBottomNavigationBar(
            hasAddPermission: widget.showSaveButton && widget.parentIsEligibleToEdit ? true : false,
            scaffoldKey: scaffoldKey,
            context: context,
            // displayMenu: state.displayMenu,
            list: true,
            // 🔥 only "+" button mode
            onAddPressed: () {
              showAddContactPopUp(
                context: context,
                visitingOfficialDetails: LawVisitingOfficial(
                  id: null,
                  email: '',
                  contactNo: '',
                  department: Organisation(),
                  designation: '',
                ),
                departments: state.departments,
              );
            },
          ),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.visitingOfficials,
            showPopUp: false,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            popAndReplace: () async {
              log('--popAndReplace-----');
              Navigator.pop(context);
              // await backButtonFunction(context);
            },
            showLikeButton: false,
          ),
          body: getBody(state),
        ),
      );
    });
  }

  Future<void> backButtonFunction(BuildContext context) async {
    var nav = Navigator.of(context);

    LawEnforcementDetailsModel? model =
        await lawEnforcementListCubit.getById(widget.id, context);

    nav.pop();
    nav.pushReplacementNamed(lawEnforcementDetailsViewRoute,
        arguments: {"UserElement": model});
  }

  getBody(VisitingOfficialListState state) {
    if (state.status == FormStatus.initial ||
        state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.items.isEmptyOrNull && !isPopUpShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isPopUpShown = true;
        showAddContactPopUp(
          context: context,
          visitingOfficialDetails: LawVisitingOfficial(
            id: null,
            email: '',
            contactNo: '',
            department: Organisation(),
            designation: '',
          ),
          departments: state.departments,
        );
      });
      return const NoRecordFoundWidget();
    }
    return Container(
      // margin: allMargin16,
      decoration: const ShapeDecoration(
          color: AppColors.lavender,
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
                key: state.labels?.locale.visitingOfficialName ??
                    state.labels?.defaultLocale.visitingOfficialName ??
                    Constants.name,
                value: state.items![index].name ?? '',
              ),
            );
            labels.add(
              Label(
                key: state.labels?.locale.visitingOfficialDesignation ??
                    state.labels?.defaultLocale.visitingOfficialDesignation ??
                    Constants.designation,
                value: state.items![index].designation ?? '',
              ),
            );
            labels.add(
              Label(
                key: state.labels?.locale.visitingOfficialDepartment ??
                    state.labels?.defaultLocale.visitingOfficialDepartment ??
                    Constants.department,
                value: state.items![index].department?.name ?? '',
              ),
            );
            labels.add(
              Label(
                key: state.labels?.locale.visitingOfficialContactNo ??
                    state.labels?.defaultLocale.visitingOfficialContactNo ??
                    Constants.phoneNumber,
                value: state.items![index].contactNo ?? '',
              ),
            );
            labels.add(
              Label(
                key: state.labels?.locale.visitingOfficialAddress ??
                    state.labels?.defaultLocale.visitingOfficialAddress ??
                    Constants.officeAddress,
                value: state.items![index].address ?? '',
              ),
            );
            labels.add(
              Label(
                key: state.labels?.locale.visitingOfficialEmail ??
                    state.labels?.defaultLocale.visitingOfficialEmail ??
                    Constants.visitingOfficialsEmailId,
                value: state.items![index].email ?? '',
              ),
            );
            return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF6474C6),
                      Color(0xFF6474C6)
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
                                      alpha: 0.2),
                                  Colors.transparent,
                                  Colors.white.withValues(
                                      alpha: 0.2),
                                  // Color(0xFF6474C6).withOpacity(0.14)
                                ],
                                stops: [0.02, 0.35, 1],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius
                                  .circular(27),
                              border: Border.all(
                                color: Colors.white
                                    .withValues(alpha: 0.80),
                                width: 0.8,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                      0xFF6474C6).withValues(
                                      alpha: 0.09),
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
                            id: state.items?[selectedIndex].id.toString(),
                            labels: labels,
                          );
                        },
                      );
                    },
                    showEditButton:
                        widget.showSaveButton && widget.lock.isEmptyOrNull
                            ? true
                            : false,
                    onEditTap: (selectedIndex) async {
                      LawVisitingOfficial model = await LawEnforcementServices()
                          .getLeoVisitingOfficialById(
                              id: state.items?[index].id ?? 0);

                      log('--state.users--llen--${state.departments.length}---');

                      showAddContactPopUp(
                        context: context,
                        visitingOfficialDetails: model,
                        departments: state.departments,
                      );
                      // getDetails(state.items?[index].id ?? 0);
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
                        widget.showSaveButton && widget.lock.isEmptyOrNull && widget.parentIsEligibleToEdit,
                    onDeleteTap: (selectedIndex) async {
                      // Call Delete API
                      BlocProvider.of<VisitingOfficialListBloc>(context).add(
                          DeleteRecord(state.items![selectedIndex].id!.toInt(),
                              widget.id));
                    },
                    index: index,
                            )))) );
          }
          return null;
        },
      ),
    );
  }

  showAddContactPopUp({
    required BuildContext context,
    required LawVisitingOfficial visitingOfficialDetails,
    required final List<Organisation> departments,
  }) {
    log('--.departments--llen--${departments.length}---');
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AddVisitingOfficialPopUp(
          title: widget.title,
          model: visitingOfficialDetails,
          mainContext: context,
          departments: departments,
          showSaveButton: widget.showSaveButton && widget.lock.isEmptyOrNull && widget.parentIsEligibleToEdit,
          onSubmit: (LawVisitingOfficial model) {
            //loginFormKey.currentState!.validate();
            FocusScope.of(context).unfocus();

            log('-model.id---${model.id}----');

            BlocProvider.of<VisitingOfficialListBloc>(context).add(
              SaveRecord(
                model: model,
                parentId: widget.id,
              ),
            );
          },
        );
      },
    );
  }

  getDetails(int id) async {
    showLoadingDialog(context);

    LawVisitingOfficial contactsModel = await LawEnforcementServices().getLeoVisitingOfficialById(id:id);

    editDataLoading(contactsModel);
  }

  void editDataLoading(LawVisitingOfficial? model) {
    dismissLoadingDialog(context);
    if (model != null) {
      Navigator.pushNamed(
        context,
        contactDetailsRoute,
        arguments: {
          "model": model,
          "title": Constants.visitingOfficials,
          ConstantsArgument.isEligibleToEdit: widget.parentIsEligibleToEdit,
        },
      );
    }
  }
}
