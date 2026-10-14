
import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/patrolling/models/patrolling_model.dart';
import 'package:db_atom/src/features/patrolling/patrolling_details/cubit/patrolling_details_cubit.dart';

class PatrollingGeneralInfoDetailsView extends StatefulWidget {
  final PatrollingModel? model;
  final String title;
  final ExtraProperties? extraProperties;

  const PatrollingGeneralInfoDetailsView(
      {super.key, this.model, required this.title, this.extraProperties});

  @override
  State<PatrollingGeneralInfoDetailsView> createState() =>
      _PatrollingGeneralInfoDetailsView();
}

class _PatrollingGeneralInfoDetailsView
    extends State<PatrollingGeneralInfoDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController statusController = TextEditingController();
  TextEditingController ticketTypeController = TextEditingController();
  TextEditingController priorityTypController = TextEditingController();
  TextEditingController ticketRaisedForController = TextEditingController();
  TextEditingController ragStatusController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  User? userDetails;
  bool isReadOnly = false;
  bool showSaveSubmitButton = false;
  List<ImageContent> uploadFiles = [];
  List<ImageContent> getAttachments = [];

  TextEditingController shiftController = TextEditingController();
  TextEditingController startDateTextController = TextEditingController();
  TextEditingController activityDateController = TextEditingController();

  TextEditingController additionalInformationTextController =
  TextEditingController();

  get model => null;
  bool? isCanLSMEdit;
  bool? isCanActionOwnerEdit;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PatrollingDetailsCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<PatrollingDetailsCubit, PatrollingDetailsState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          if (state.isSaveOnly == true) {
            var dialog = CustomAlertDialog(
              title: Constants.generalInfo,
              message: state.message ?? '',
              positiveBtnText: Constants.ok,
              onPositivePressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, patrollingListCardRoute,
                    arguments: {
                      ConstantsArgument.title: widget.title,
                      "model": state.model,
                    });
              },
            );
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => dialog);

          } else {
            // Submit: show success dialog, then rebuild stack as
            // Dashboard -> Patrolling List, regardless of how deep
            // the user navigated to reach this screen.
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return CustomAlertDialog(
                  title: Constants.generalInfo,
                  message: state.message ?? '',
                  positiveBtnText: Constants.ok,
                  onPositivePressed: () {
                    Navigator.pop(dialogContext); // close dialog

                    // Build the new stack in one call: [Dashboard, PatrollingList]
                    // User sees PatrollingList; Dashboard sits underneath for back-nav.
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      dashboardViewRoute,
                          (route) => false,
                    );
                    Navigator.of(context).pushNamed(patrollingListRoute);
                  },
                );
              },
            );
          }
        }
      },
      builder: (context, state) {
        if (state.model.status == null &&
            state.loggedInUserDetails?.email == state.model.lsm?.email) {
          isReadOnly = false;
        }
        showSaveSubmitButton =
            state.model.status != 9 && state.model.lock.isEmptyOrNull;


        // isCanLSMEdit = state.model.status == null && state.loggedInUserDetails?.email == state.model.lsm?.email;
//         final items = state.otherModel.items ?? [];
//         final bool hasEditableItemField = items.any((item) =>
//         item.canEditGuardFields == true ||
//             item.canEditLsmFields == true ||
//             item.canEditOwnerFields == true ||
//             item.canEditEta == true ||
//             item.canReview == true);
        final items = state.model.items ?? [];
        final bool hasEditableField = state.model.status == 0 ||
            items.any((item) =>
            item.canEditGuardFields == true ||
                item.canEditLsmFields == true ||
                item.canEditOwnerFields == true ||
                item.canEditEta == true ||
                item.canReview == true);
        log('hasEditableField ${hasEditableField}');

        showSaveSubmitButton = (state.model.lock.isEmptyOrNull) && (hasEditableField|| state.model.status == 0 || state.model.status == 1);;
        // showSaveSubmitButton =
        //     (state.model.lock.isEmptyOrNull) &&
        //     (hasEditableItemField || state.model.status == 0 || state.model.status == 1);
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.patrolling,
            showPopUp: false,
            showSaveButton:
            showSaveSubmitButton && state.status != FormStatus.loading
                ? true
                : false,
            showSubmitButton:
            showSaveSubmitButton && state.status != FormStatus.loading
                ? true
                : false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<PatrollingDetailsCubit>(context)
                  .submitGenInfoForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<PatrollingDetailsCubit>(context)
                  .submitGenInfoForm(
                isSaveOnly: false,
              );
            },
          ),
          backgroundColor: AppColors.newColor,
          body: getBodybuilder(state, height),
        );
      },
    );
  }

  void initializeDates(PatrollingDetailsState state) {}

  getBodybuilder(PatrollingDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    return Stack(
      children: [
        // 🔹 Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg2.png',
            fit: BoxFit.cover,
          ),
        ),

        // 🔹 Blur Layer
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child: Container(
              color: Colors.black.withValues(alpha: 0.08), // optional tint
            ),
          ),
        ),

        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
                child: AbsorbPointer(
                  absorbing: false,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: isReadOnly
                        ? AutovalidateMode.disabled
                        : AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(
                            children: [
                              if (!state.model.lock.isEmptyOrNull) ...[
                                RecordLockedWidget(text: '${state.model.lock}'),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  Constants.generalinformation,
                                  style: Styles.textStyleRegularNormalWhite18,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Status
                              CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),

                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: statusController,
                                items: patrollingStatusDropDownValues,
                                initialValue: '${state.model.status ??= 0}',
                                onTap: () {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Created By
                              CommonWidgets.horizontalTextHandling(
                                Constants.createdby,
                                isMandatory: true,
                                '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Created Date
                              CommonWidgets.textDisplay(
                                Constants.createDate,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              BaseDate().creationDateDisplay(
                                state.model.inputDate != null
                                    ? Utils.timestampToDateConversion(
                                  int.tryParse(
                                      state.model.inputDate ?? '0'),
                                  Constants.fulldateFormat,
                                )
                                    : '',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Location
                              CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              BaseLocationDropdown().locationWidgetDisplay(
                                selectedLocationName:
                                state.model.location?.name ?? '',
                                isEnabled:showSaveSubmitButton,
                                context: context,
                                locations: state.locations,
                                onTap: (Organisation? location) async {
                                  log('location?.name-----${location?.name}');

                                  state.model.location = location;

                                  BlocProvider.of<PatrollingDetailsCubit>(
                                    context,
                                  ).updateLocationDropdownValue(
                                    location: location,
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Location Type
                              CommonWidgets.textDisplay(
                                Constants.locationType,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              TextFieldAddButton(
                                title: state.model.locationType?.name,
                                height: 75,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.getLocationType.getLocationType ?? [],
                                      onTap: (Organisation locationType) {
                                        BlocProvider.of<PatrollingDetailsCubit>(context)
                                            .updateDropdownValues(locationType: locationType);
                                      },
                                      leftImage: false,
                                      createEntity: false,
                                      functionToCall: () {
                                        BlocProvider.of<PatrollingDetailsCubit>(context).refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// Sl No.
                              CommonWidgets.horizontalTextHandling(
                                state.labels?.locale.slNo ??
                                    state.labels?.defaultLocale.slNo ??
                                    'Sl No',
                                isMandatory: true,
                                state.model.slNo ?? '',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Entity
                              CommonWidgets.textDisplay(
                                  Constants.entity,
                                  Styles.textStyleWhite14,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.002),

                              BaseEntitiesSelection().entityDropDownSelection(
                                context: context,
                                selectedValues: state.model.entity != null
                                    ? [state.model.entity!]
                                    : [],
                                all: state.listOfEntities ?? [],
                                enabled:   showSaveSubmitButton?true: false,
                                onTap: (List<Organisation> selectedEntities) {
                                  log('--selectedEntities----${selectedEntities.length}');
                                  state.model.entity =
                                  selectedEntities.isNotEmpty
                                      ? selectedEntities.first
                                      : null;
                                  BlocProvider.of<PatrollingDetailsCubit>(
                                      context)
                                      .updateDropdownValues(
                                      entity: state.model.entity);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                orgName: 'ATOM_ENTITIES',
                                functionToCall: () {
                                  // refresh the list
                                  BlocProvider.of<PatrollingDetailsCubit>(
                                      context)
                                      .refreshList();
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Shift
                              CommonWidgets.textDisplay(
                                  Constants.shift, Styles.textStyleWhite14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDropDown().getDropDown(
                                  isDisabled:   !showSaveSubmitButton,
                                  textController: shiftController,
                                  initialValue: state.model.shift.toString(),
                                  items: patrollingShift,
                                  onTap: () {
                                    if(  showSaveSubmitButton) {
                                      BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues: patrollingShift
                                            .map((label) => label.key)
                                            .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              patrollingShift.firstWhere(
                                                    (label) =>
                                                label.key == value,
                                                orElse: () =>
                                                const Label(key: '', value: ''),
                                              );
                                          shiftController.text =
                                              selectedLabel.key;
                                          state.model.shift =
                                              int.tryParse(selectedLabel.value);
                                        },
                                      );
                                    }
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// LSM
                              CommonWidgets.textDisplay(
                                  Constants.lsm,
                                  isMandatory: true,
                                  Styles.textStyleWhite14),

                              TextFieldAddButton(
                                title: state.model.lsm?.name,
                                height: 75,
                                isDisableColor: !showSaveSubmitButton,
                                onTap: () {
                                  if(showSaveSubmitButton) {
                                    BaseOrganisationDialog().userDialog(
                                      employeeId: false,
                                      context: context,
                                      users: state.lsm,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<PatrollingDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                          lsm: user,
                                        );
                                      },
                                      roleName: ConstantUserRoles
                                          .atomStaticUser,
                                      locationId: state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<PatrollingDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                          lsm: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<PatrollingDetailsCubit>(
                                            context)
                                            .refreshList();
                                      },
                                    );
                                  };
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Security Supervisor
                              CommonWidgets.textDisplay(
                                  Constants.securitySupervisor,
                                  isMandatory: true,
                                  Styles.textStyleWhite14),

                              TextFieldAddButton(
                                title: state.model.securitySupervisor?.name,
                                height: 75,
                                isDisableColor: !showSaveSubmitButton,
                                onTap: () {
                                  if(showSaveSubmitButton) {
                                    BaseOrganisationDialog().userDialog(
                                      context: context,
                                      users: state.securitySupervisor,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<PatrollingDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                          securitySupervisor: user,
                                        );
                                      },
                                      roleName: ConstantUserRoles
                                          .atomStaticUser,
                                      locationId: state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<PatrollingDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                          securitySupervisor: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<PatrollingDetailsCubit>(
                                            context)
                                            .refreshList();
                                      },
                                    );
                                  };
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (state.model.status != null &&
                                  state.model.status != 0) ...[
                                /// Submitted Date
                                CommonWidgets.textDisplay(
                                  Constants.submittedDate,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                  height * 0.01,
                                ),
                                BaseDate().creationDateDisplay(
                                  state.model.submittedDate ?? '',
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],
                              if (state.model.status != null &&
                                  state.model.status != 0 &&
                                  state.model.status != 1) ...[
                                /// Verified Date
                                CommonWidgets.textDisplay(
                                  Constants.verifiedDate,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                  height * 0.01,
                                ),
                                BaseDate().creationDateDisplay(
                                  state.model.verifiedDate ?? '',
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],
                              if (state.model.id != null) ...[
                                /// Modified By
                                CommonWidgets.horizontalTextHandling(
                                  Constants.modifiedBy,
                                  isMandatory: true,
                                  '${state.model.modifiedBy}',
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Modified Date
                                CommonWidgets.textDisplay(
                                  Constants.modifiedDate,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                  height * 0.01,
                                ),
                                BaseDate().creationDateDisplay(
                                  state.model.modifiedDate ?? '',
                                ),
                              ],
                            ],
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.02),

                        /// SubmitButton
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if ((showSaveSubmitButton) ? true : false) ...[
                              cancelButtonDisplay(),
                              submitButtonDisplay()
                            ],
                          ],
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.02),
                      ],
                    ),
                  ),
                ),
              ),
              if ((!showSaveSubmitButton)) ...[
                Container(
                  padding: const EdgeInsets.all(5.0),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cancelButtonDisplay(),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      width: Constants.cancelButtonWidth,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.close,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
        CommonServices().unlock();
      },
    );
  }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<PatrollingDetailsCubit>(context).submitGenInfoForm();
      },
    );
  }
}