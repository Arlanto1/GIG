import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/views/day_pass_list_detail_popup.dart';
import 'package:db_atom/src/features/passmanagement/pass_management_list/bloc/pass_management_list_bloc.dart';
import '../../daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import '../../daypassmgmt/passmgmtlist/views/day_pass_management_list_item.dart';

class PassManagementListView extends StatefulWidget {
  const PassManagementListView({
    super.key,
    required this.passId,
    required this.title,
  });

  final int passId;
  final String title;

  @override
  State<PassManagementListView> createState() => _PassManagementListViewState();
}

class _PassManagementListViewState extends State<PassManagementListView> {
  late final ScrollController _scrollController;
  int pageNumber = 0;
  BaseFilterModel filters = BaseFilterModel();

  @override
  void initState() {
    super.initState();
    context.read<PassManagementListBloc>().add(
          const InitializeValuesPM(),
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
      context.read<PassManagementListBloc>().add(FetchData(
            startPos: pageNumber,
            maxPos: Constants.maxResults,
            newSearch: false,
            filters: filters,
          ));
    }
  }

  Future<void> _onRefresh() async {
    context.read<PassManagementListBloc>().add(
          const RefreshList(),
        );
    await Future.delayed(const Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<PassManagementListBloc, PassManagementListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.cardBgColor,
          floatingActionButton:
              state.extraProperties?.hasWritePermission ?? false
                  ? Flutterfloatingbutton(
                      backgroundColor: AppColors.navigationSkyBlueColor,
                      foregroundColor: AppColors.backgroundWhiteColor,
                      onPressed: () {
                        // Navigator.pushNamed(context, createpassmgmtRoute);
                        String titleIdentify = '';
                        if (widget.passId == 0) {
                          titleIdentify = 'Create Day Pass Management';
                        } else if (widget.passId == 1) {
                          titleIdentify = 'Create Visitor Pass Management';
                        } else if (widget.passId == 2) {
                          titleIdentify = 'Create Vendor Pass Management';
                        } else if (widget.passId == 3) {
                          titleIdentify = 'Create SEZ Pass Management';
                        }

                        Navigator.pushNamed(context, createpassmgmtRoute,
                            arguments: {
                              "passMngCreateDetails": CreatePassMngArguments(
                                  widget.passId, titleIdentify, true, null)
                            });
                      },
                    )
                  : const SizedBox(),
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: true,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            excelAPIName:
                'exportPassMgmtExcel?passType=${widget.passId}&isList=1',
            pdfAPIName: 'exportPassMgmtPDF?passType=${widget.passId}&isList=1',
          ),
          body: BlocConsumer<PassManagementListBloc, PassManagementListState>(
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
              // if (state.status == FormStatus.loading) {
              //   return const BaseLoader();
              // }
              //
              // if (state.items.isEmptyOrNull && state.status != FormStatus.loading) {
              //   CommonWidgets.verticalSpacerWidget(height * 0.1);
              //   return const NoRecordFoundWidget();
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
                            if (index < state.items.length) {
                              PassManagementModel model = state.items[index];

                              return DayPassManagementListItem(
                                userItem: model,
                                onTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return DayPassCustomPopUpList(
                                          state.items[selectedIndex],
                                          widget.passId.toString());
                                    },
                                  );
                                  //do the detail edit of user found
                                },
                                onEditTap: (selectedIndex) {
                                  getId(
                                      state.extraProperties
                                              ?.hasWritePermission ??
                                          false,
                                      state.items[selectedIndex].id ?? 0);
                                },
                                onViewTap: (selectedIndex) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return DayPassCustomPopUpList(
                                          state.items[selectedIndex],
                                          widget.passId.toString());
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

  getId(bool hasWritePermission, int id) async {
    showLoadingDialog(context);
    PassManagementModel? model =
        await dayPassListCubit.getpassArticleById(id, context);

    log('-model---${model?.id}--');
    editDataLoading(model, hasWritePermission);
  }

  void editDataLoading(
    PassManagementModel? model,
    bool hasWritePermission,
  ) {
    dismissLoadingDialog(context);
    if (model == null) {
      return;
    }
    // Navigator.pushNamed(context, createpassmgmtRoute,
    //     arguments: {"UserElement": foundArticleDetailsResponse});
    String titleIdentify = '';
    if (widget.passId == 0) {
      titleIdentify = 'Edit Day Pass Management';
    } else if (widget.passId == 1) {
      titleIdentify = 'Edit Visitor Pass Management';
    } else if (widget.passId == 2) {
      titleIdentify = 'Edit Vendor Pass Management';
    } else if (widget.passId == 3) {
      titleIdentify = 'Edit SEZ Pass Management';
    }

    // DayPassListElement? listuser = foundArticleDetailsResponse;
    Navigator.pushNamed(context, createpassmgmtRoute, arguments: {
      "passMngCreateDetails":
          CreatePassMngArguments(widget.passId, titleIdentify, true, model),
      ConstantsArgument.extraProperties:
          ExtraProperties(hasWritePermission: hasWritePermission),
    });
  }

  // getById(int id) async {
  //   showLoadingDialog(context);
  //
  //   MaterialMovementModel materialMovementModel =
  //       await MaterialMovementServices().getById(id);
  //
  //   editDataLoading(materialMovementModel);
  // }
  //
  // Future<void> editDataLoading(
  //     MaterialMovementModel? materialMovementModel) async {
  //   dismissLoadingDialog(context);
  //   if (materialMovementModel != null) {
  //     Navigator.pushNamed(context, materialMovementInwardOutwardDetailsRoute,
  //         arguments: {
  //           "MaterialMovementModel": materialMovementModel,
  //           "isInward": widget.passId,
  //           "title": widget.title
  //         });
  //   }
  // }

  void applySearchFilters(
    FilterCriteria model,
  ) {
    log('Applying Search Filters');

    filters = BaseFilterModel(filterCriteria: model);

    BlocProvider.of<PassManagementListBloc>(context).add(
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

    BlocProvider.of<PassManagementListBloc>(context).add(
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
