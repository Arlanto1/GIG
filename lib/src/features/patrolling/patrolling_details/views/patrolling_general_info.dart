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
        }
      },
      builder: (context, state) {
        // if (state.model.status == null) {
        //   isReadOnly = false;
        // }
        if( state.model.status == null && state.loggedInUserDetails?.email == state.model.lsm?.email){
          isReadOnly = false;
        }
        showSaveSubmitButton =
            state.model.status != 9 && state.model.lock.isEmptyOrNull;
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
            // pdfAPIName:
            // '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.vipVisitorsDetailsModule}',
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
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(PatrollingDetailsState state) {}

  getBodybuilder(PatrollingDetailsState state, height) {
    // initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    // if (state.status == FormStatus.addAttachment ||
    //     state.status == FormStatus.initial) {
    //   // uploadFiles = state.uploadAttachments;
    //   uploadFiles = state.model.attachments ?? [];
    // }

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
                                onTap: () {
                                  // BaseDropDown().assetTypeDialog(
                                  //   context: context,
                                  //   dropDownValues:
                                  //       patrollingStatusDropDownValues
                                  //           .map((label) => label.key)
                                  //           .toList(),
                                  //   onTap: (String value) {
                                  //     Label? selectedLabel;
                                  //     selectedLabel =
                                  //         patrollingStatusDropDownValues
                                  //             .firstWhere(
                                  //       (label) => label.key == value,
                                  //       orElse: () => const Label(
                                  //         key: '',
                                  //         value: '',
                                  //       ),
                                  //     );
                                  //
                                  //     BlocProvider.of<PatrollingDetailsCubit>(
                                  //             context)
                                  //         .updateDropdownValues(
                                  //       status: int.tryParse(
                                  //         selectedLabel.value,
                                  //       ),
                                  //     );
                                  //   },
                                  // );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Created By
                              CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.entrySecurity ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                Constants.createdby,
                                isMandatory: true,
                                '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Created Date
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.inputDate ??
                                //     state.labels?.defaultLocale.inputDate ??
                                Constants.createDate,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              // BaseDate().creationDateDisplay(
                              //   state.model.inputDate ?? '',
                              // ),
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
                                isEnabled: !isReadOnly,
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

                              /// Sl No.
                              CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.slNo ??
                                    state.labels?.defaultLocale.slNo ??
                                    'Sl No',
                                isMandatory: true,
                                state.model.slNo ?? '',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Entity
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.entities ??
                                  //     state
                                  //         .labels?.defaultLocale.entities ??
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
                                enabled: false,
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
                                  // state.labels?.locale.staffCategory ??
                                  //     state.labels?.defaultLocale.staffCategory ??
                                  Constants.shift,
                                  //isMandatory: true,
                                  Styles.textStyleWhite14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDropDown().getDropDown(
                                  isDisabled: false,
                                  textController: shiftController,
                                  initialValue: state.model.shift.toString(),
                                  items: shift,
                                  onTap: () {
                                    // if (showSaveSubmitButtons) {
                                    BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: patrollingShift
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            patrollingShift.firstWhere(
                                          (label) => label.key == value,
                                          orElse: () =>
                                              const Label(key: '', value: ''),
                                        );
                                        shiftController.text =
                                            selectedLabel.key;
                                        state.model.shift =
                                            int.tryParse(selectedLabel.value);
                                      },
                                    );
                                    // }
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// LSM
                              CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.entrySecurity ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                Constants.lsm,
                                isMandatory: true,
                                '${state.model.lsm?.email}',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Security Supervisor
                              CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.entrySecurity ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                Constants.securitySupervisor,
                                isMandatory: true,
                                state.model.securitySupervisor?.email ?? '',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (state.model.status != null &&
                                  state.model.status != 0) ...[
                                /// Submitted Date
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.inputDate ??
                                  //     state.labels?.defaultLocale.inputDate ??
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
                                  // state.labels?.locale.inputDate ??
                                  //     state.labels?.defaultLocale.inputDate ??
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
                                CommonWidgets.horizentaltextHandling(
                                  // state.labels?.locale.entrySecurity ??
                                  //     state.labels?.defaultLocale.entrySecurity ??
                                  Constants.modifiedBy,
                                  isMandatory: true,
                                  '${state.model.modifiedBy}',
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Modified Date
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.modifiedDate ??
                                  //     state.labels?.defaultLocale.modifiedDate ??
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
                            if ((state.model.status != 9) ? true : false) ...[
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
              if ((state.model.status == 9)) ...[
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
        BlocProvider.of<PatrollingDetailsCubit>(context).submitForm();
      },
    );
  }
}
