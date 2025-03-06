import 'dart:developer';

import 'package:db_atom/index.dart';

import 'comment_pop_up.dart';

class SstIncidentGeneralInfoView extends StatefulWidget {
  final bool isInternal;
  final bool viaOccurrence;
  final SstIncident? model;
  final ExtraProperties? extraProperties;

  const SstIncidentGeneralInfoView({
    super.key,
    required this.isInternal,
    required this.viaOccurrence,
    this.model,
    this.extraProperties,
  });

  @override
  State<SstIncidentGeneralInfoView> createState() =>
      _SstIncidentGeneralInfoViewState();
}

class _SstIncidentGeneralInfoViewState
    extends State<SstIncidentGeneralInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController incidentDateTimeController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController assetTypeController = TextEditingController();
  TextEditingController incidentTypeController = TextEditingController();
  TextEditingController systemController = TextEditingController();
  TextEditingController vendorPocController = TextEditingController();
  TextEditingController escalation1PocController = TextEditingController();
  TextEditingController escalation2PocController = TextEditingController();
  TextEditingController escalation3PocController = TextEditingController();
  TextEditingController acknowledgeDateController = TextEditingController();
  TextEditingController escalation1Controller = TextEditingController();
  TextEditingController escalation2Controller = TextEditingController();
  TextEditingController escalation3Controller = TextEditingController();
  TextEditingController vendorTicketNoController = TextEditingController();
  TextEditingController onsiteVisitDateController = TextEditingController();
  TextEditingController issueTypeController = TextEditingController();
  TextEditingController slaOnsiteResponseController = TextEditingController();
  TextEditingController solvedProposedDateController = TextEditingController();
  TextEditingController reworkProposedDateController = TextEditingController();
  TextEditingController solvedCompleteDateController = TextEditingController();
  TextEditingController downTimeController = TextEditingController();
  TextEditingController slaResolutionDateController = TextEditingController();

  bool isDisabled = true;
  bool disableForm = false;
  List<ImageContent>? uploadFiles;
  List<ImageContent>? uploadDocuments;
  List<ImageContent>? attachDocuments;
  bool showSystemIntegratorFields = false;
  bool isShowSubmitButtonForSecurityManager = false;
  final FocusNode vendorPocFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  bool showSolvedProposed = false;
  bool showSLAOnsiteResponse = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SstIncidentGeneralInfoCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<SstIncidentGeneralInfoCubit,
        SstIncidentGeneralInfoState>(
      listener: (context, state) {
        log('--state.status---${state.status}---');
        log('--state.message---${state.message}---');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.generalInformation,
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                sstIncidentListRoute,
                // arguments: {"isInternal": widget.isInternal},
              );
              if (widget.viaOccurrence) {
                Navigator.popAndPushNamed(
                  context,
                  shiftOccurrenceDetailsRoute,
                  arguments: {
                    'id': state.model.occurrence?.id.toString(),
                    "title": Constants.editOccurrence,
                  },
                );
                return;
              }
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
        if (state.status == FormStatus.error) {
          log('-if error-state.status---${state.status}---');
          log('-if error-state.message---${state.message}---');
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
        }
      },
      builder: (context, state) {
        vendorPocController.text = state.model.vendorPoc ?? '';
        escalation1PocController.text = state.model.escalation1Poc ?? '';
        escalation2PocController.text = state.model.escalation2Poc ?? '';
        escalation3PocController.text = state.model.escalation3Poc ?? '';
        vendorTicketNoController.text = state.model.vendorTicketNo ?? '';
        slaOnsiteResponseController.text =
            state.model.slaOnsiteRes?.toString() ?? '0.0';
        downTimeController.text = state.model.downTime?.toString() ?? '0.0';
        slaResolutionDateController.text =
            state.model.slaResolutionDate?.toString() ?? '0.0';
        state.model.status ??= 1;
        if (state.model.id != null && state.model.status! > 1) {
          log('--state.model.status----asd---${state.model.status}-');
          disableForm = true;
        }
        if (state.model.status == -1) {
          disableForm = true;
        }

        if (!state.model.lock.isEmptyOrNull) {
          disableForm = true;
        }

        if (state.model.status ==
                ConstantsIntValue.ticketLifeCycleSolveProposedStatus ||
            state.model.status ==
                ConstantsIntValue.ticketLifeCycleClosedStatus) {
          showSolvedProposed = true;
        }

        if (showSolvedProposed ||
            state.model.status ==
                ConstantsIntValue.ticketLifeCycleReworkStatus) {
          showSLAOnsiteResponse = true;
        }

        if (state.model.status !=
                ConstantsIntValue.ticketLifeCycleCreateStatus &&
            state.model.status != null) {
          showSystemIntegratorFields = true;
        }

        if (state.model.status ==
                ConstantsIntValue.ticketLifeCycleSolveProposedStatus &&
            state.model.systemManager!.email
                .equalsIgnoreCase(state.loggedInUserDetails.email)) {
          isShowSubmitButtonForSecurityManager = true;
        }

        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   disableForm = true;
        // }
        log('@@@--${state.loggedInUserDetails.userName}----${state.model.createdBy?.userName}---');
        if (!(state.loggedInUserDetails.userName
            .equalsIgnoreCase(state.model.createdBy?.userName))) {
          disableForm = true;
        }

        log('---disableForm---$disableForm');
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.isInternal
                ? Constants.ticketLifeCycle
                : Constants.ticketLifeCycle,
            showPopUp: false,
            showSaveButton: !disableForm && state.status != FormStatus.loading? true : false,
            showSubmitButton:
            (!disableForm || isShowSubmitButtonForSecurityManager ) && state.status != FormStatus.loading
                    ? true
                    : false,
            showDisLikeButton: false,
            showLikeButton: false,
            pdfAPIName:
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.securitySystemModule}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<SstIncidentGeneralInfoCubit>(context).submitForm(
                  isSaveOnly: true, isSubmitOnly: false, isReworkOnly: false);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              if (state.model.status ==
                  ConstantsIntValue.ticketLifeCycleCreateStatus) {
                BlocProvider.of<SstIncidentGeneralInfoCubit>(context)
                    .submitForm(
                        isSaveOnly: false,
                        isReworkOnly: false,
                        isSubmitOnly: true);
              }
              if (state.model.status ==
                  ConstantsIntValue.ticketLifeCycleSolveProposedStatus) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(Constants.selectStatus),
                      content: const Text(Constants.message),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(Constants.rework),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return AddCommentPopUp(
                                  mainContext: context,
                                  onSubmit: (value) {
                                    state.model.rejectionComment = value;
                                    BlocProvider.of<
                                                SstIncidentGeneralInfoCubit>(
                                            this.context)
                                        .onAddComment(value);
                                    Navigator.pop(context);
                                    BlocProvider.of<
                                                SstIncidentGeneralInfoCubit>(
                                            this.context)
                                        .submitForm(
                                      isReworkOnly: true,
                                      isSaveOnly: false,
                                      isSubmitOnly: false,
                                    );
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        ),
                        TextButton(
                          child: const Text(Constants.closed),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return AddCommentPopUp(
                                  mainContext: context,
                                  onSubmit: (value) {
                                    state.model.closedActivityNotes = value;
                                    BlocProvider.of<
                                                SstIncidentGeneralInfoCubit>(
                                            this.context)
                                        .onAddActivityNotes(value);
                                    Navigator.pop(context);
                                    BlocProvider.of<
                                                SstIncidentGeneralInfoCubit>(
                                            this.context)
                                        .submitForm(
                                      isSubmitOnly: true,
                                      isSaveOnly: false,
                                      isReworkOnly: false,
                                    );
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        ),
                        TextButton(
                          child: const Text(Constants.abort),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
          body: getBodybuilder(state, height),
        );
      },
    );
  }

  void initializeDates(SstIncidentGeneralInfoState state) {
    acknowledgeDateController.text = state.model.acknowledgeDate != null
        ? Utils.timestampToDateConversion(
            int.tryParse(state.model.acknowledgeDate ?? '0'),
            Constants.fulldateFormat)
        :  (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    escalation1Controller.text = state.model.escalation1 != null
        ? Utils.timestampToDateConversion(
            int.tryParse(state.model.escalation1 ?? '0'),
            Constants.fulldateFormat)
        : '';
    escalation2Controller.text = state.model.escalation2 != null
        ? Utils.timestampToDateConversion(
            int.tryParse(state.model.escalation2 ?? '0'),
            Constants.fulldateFormat)
        : '';
    escalation3Controller.text = state.model.escalation3 != null
        ? Utils.timestampToDateConversion(
            int.tryParse(state.model.escalation3 ?? '0'),
            Constants.fulldateFormat)
        : '';
    solvedProposedDateController.text = state.model.solvedProposed != null
        ? Utils.timestampToDateConversion(
            int.tryParse(state.model.solvedProposed ?? '0'),
            Constants.fulldateFormat)
        : '';
    reworkProposedDateController.text = state.model.reworkDate != null
        ? Utils.timestampToDateConversion(
            int.tryParse(state.model.reworkDate ?? '0'),
            Constants.fulldateFormat)
        : '';

    onsiteVisitDateController.text = state.model.siteVisitDate != null
        ? Utils.timestampToDateConversion(
            int.tryParse(state.model.siteVisitDate ?? '0'),
            Constants.fulldateFormat)
        : '';

    solvedCompleteDateController.text = state.model.solvedComplete != null
        ? Utils.timestampToDateConversion(
            int.tryParse(state.model.solvedComplete ?? '0'),
            Constants.fulldateFormat)
        : '';
  }

  getBodybuilder(SstIncidentGeneralInfoState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      // uploadFiles = state.uploadAttachments;
      uploadFiles = state.uploadAttachments ?? [];
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      // uploadFiles = state.uploadAttachments;
      uploadDocuments = state.dataLossAttachments ?? [];
    }
    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      // uploadFiles = state.uploadAttachments;
      attachDocuments = state.additionalAttachments ?? [];
    }
    return Container(
      color: AppColors.navigationSkyBlueColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkyBlueColor,
            ),
            Container(
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  )),
              child: Form(
                key: _formKey,
                autovalidateMode: disableForm
                    ? AutovalidateMode.disabled
                    : AutovalidateMode.onUserInteraction,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (!state.model.lock.isEmptyOrNull) ...[
                        RecordLockedWidget(text: '${state.model.lock}'),
                      ],
                      AbsorbPointer(
                        absorbing: disableForm,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  Constants.generalinformation,
                                  style: Styles.styleHeaderGreyText16,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Created By
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.createdBy ??
                                      state.labels?.defaultLocale.createdBy ??
                                      Constants.createdby,
                                  isMandatory: true,
                                  '${state.model.createdBy?.firstName ?? ''} ${state.model.createdBy?.lastName ?? ''}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Status
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.status ??
                                      state.labels?.defaultLocale.status ??
                                      Constants.status,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              // FlutterInputField(
                              //   isEnable: true,
                              //   isDisableColor: true,
                              //   textFormKey: Keys.statusTextController,
                              //   hintText: '',
                              //   initialValue:
                              //       getStatusString(state.model.status ?? 1),
                              //   onChange: (String value) {},
                              //   validateTextField: (String? user) {},
                              // ),
                              BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: statusController,
                                items: sstIncidentsStatusItems,
                                initialValue: '${state.model.status ?? -1}',
                                onTap: () {
                                  if (!isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: sstIncidentsStatusItems
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            sstIncidentsStatusItems.firstWhere(
                                          (label) => label.key == value,
                                          orElse: () =>
                                              const Label(key: '', value: ''),
                                        );
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .updateDropdownValues(
                                                status: int.tryParse(
                                                    selectedLabel.value));
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Date of creation
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.createDate ??
                                      state.labels?.defaultLocale.createDate ??
                                      Constants.createDate,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDate().creationDateDisplay(
                                  state.model.createdDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Location
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.location,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              locationWidgetdislay(
                                  selectedLocation:
                                      state.model.location?.name ?? '',
                                  enabled: state.model.id == null ||
                                      state.model.status == 1,
                                  locations: state.locations,
                                  onTap: (Organisation? location) async {
                                    log('location?.name-----${location?.name}');

                                    state.model.location = location;

                                    BlocProvider.of<
                                                SstIncidentGeneralInfoCubit>(
                                            context)
                                        .updateLocationDropdownValue(
                                            location: location);
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Sl No.
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.slNo ??
                                      state.labels?.defaultLocale.slNo ??
                                      Constants.slno,
                                  isMandatory: true,
                                  state.model.slNo ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// System
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.system ??
                                      state.labels?.defaultLocale.system ??
                                      Constants.system,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                  isDisabled: state.model.status != 6,
                                  textController: systemController,
                                  items: systemDropDownValues,
                                  initialValue:
                                      state.model.systemSLA.toString(),
                                  onTap: () {
                                    if (isDisabled) {
                                      BaseDropDown().assetTypeDialog(
                                          context: context,
                                          dropDownValues: systemDropDownValues
                                              .map((label) => label.key)
                                              .toList(),
                                          onTap: (String value) {
                                            Label? selectedLabel;
                                            selectedLabel =
                                                systemDropDownValues.firstWhere(
                                              (label) => label.key == value,
                                              orElse: () => const Label(
                                                  key: '', value: ''),
                                            );
                                            BlocProvider.of<
                                                        SstIncidentGeneralInfoCubit>(
                                                    context)
                                                .updateDropdownValues(
                                                    systemSLA: int.tryParse(
                                                        selectedLabel.value));
                                          });
                                    }
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Vendor
                              CommonWidgets.textDisplay(
                                state.labels?.locale.vendor ??
                                    state.labels?.defaultLocale.vendor ??
                                    Constants.vendor,
                                isMandatory: true,
                                Styles.textStyleBlack14,
                              ),
                              TextFieldAddButton(
                                title: state.model.vendor?.name,
                                height: 70,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      //enabled: !disableForm,
                                      organisations: state.vendors,
                                      onTap: (Organisation user) {
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .updateDropdownValues(
                                          vendor: user,
                                        );
                                        FocusScope.of(context)
                                            .requestFocus(vendorPocFocusNode);
                                      },
                                      orgName: 'ATOM_VENDORS',
                                      createEntity: false,
                                      title: 'Add Vendor',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .refreshList();
                                      });
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Vendor Poc
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.vendorPoc ??
                                      state.labels?.defaultLocale.vendorPoc ??
                                      Constants.vendorPoc,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 1,
                                controller: vendorPocController,
                                // initialValue: state.model.vendorPoc,
                                textFormKey: Keys.claimantTextController,
                                hintText: Constants.informationhere,
                                focusNode: vendorPocFocusNode,
                                textCapitalization: false,
                                isEnable: state.model.status != 2,
                                isDisableColor: state.model.status == 2,
                                onChange: (String value) {
                                  state.model.vendorPoc = value;
                                  context
                                      .read<SstIncidentGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Escalation 1 Poc
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.escalation1Poc ??
                                      state.labels?.defaultLocale
                                          .escalation1Poc ??
                                      Constants.escalation1Poc,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 1,
                                controller: escalation1PocController,
                                // initialValue: state.model.escalation1Poc,
                                textFormKey: Keys.claimantTextController,
                                textCapitalization: false,
                                hintText: Constants.informationhere,
                                isEnable: state.model.status != 2,
                                isDisableColor: state.model.status == 2,
                                onChange: (String value) {
                                  state.model.escalation1Poc = value;
                                  context
                                      .read<SstIncidentGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Escalation 2 Poc
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.escalation2Poc ??
                                      state.labels?.defaultLocale
                                          .escalation2Poc ??
                                      Constants.escalation2Poc,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 1,
                                controller: escalation2PocController,
                                // initialValue: state.model.escalation2Poc,
                                textFormKey: Keys.claimantTextController,
                                hintText: Constants.informationhere,
                                textCapitalization: false,
                                isEnable: state.model.status != 2,
                                isDisableColor: state.model.status == 2,
                                onChange: (String value) {
                                  state.model.escalation2Poc = value;
                                  context
                                      .read<SstIncidentGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Escalation 3 Poc
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.escalation3Poc ??
                                      state.labels?.defaultLocale
                                          .escalation3Poc ??
                                      Constants.escalation3Poc,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 1,
                                controller: escalation3PocController,
                                // initialValue: state.model.escalation3Poc,
                                textFormKey: Keys.claimantTextController,
                                textCapitalization: false,
                                hintText: Constants.informationhere,
                                isEnable: state.model.status != 2,
                                isDisableColor: state.model.status == 2,
                                onChange: (String value) {
                                  state.model.escalation3Poc = value;
                                  context
                                      .read<SstIncidentGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// System Manager
                              CommonWidgets.textDisplay(
                                state.labels?.locale.sm ??
                                    state.labels?.defaultLocale.sm ??
                                    Constants.systemManager,
                                isMandatory: true,
                                Styles.textStyleBlack14,
                              ),
                              TextFieldAddButton(
                                title: state.model.systemManager?.userInfo ??
                                    state.model.systemManager?.name,
                                height: 70,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                      context: context,
                                      enabled: !disableForm,
                                      users: state.systemManagers!,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .updateEmailsValue(
                                          systemManager: user,
                                        );
                                      },
                                      roleName: ConstantUserRoles
                                          .atomSecuritySystemManagerUser,
                                      locationId: state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .updateEmailsValue(
                                          systemManager: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .refreshList();
                                      });
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Security Manager
                              CommonWidgets.textDisplay(
                                state.labels?.locale.ssm ??
                                    state.labels?.defaultLocale.ssm ??
                                    Constants.securityManager,
                                isMandatory: true,
                                Styles.textStyleBlack14,
                              ),
                              TextFieldAddButton(
                                title: state.model.lsm?.userInfo ??
                                    state.model.lsm?.name,
                                height: 70,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                      context: context,
                                      enabled: !disableForm,
                                      users: state.securityManagers!,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .updateEmailsValue(
                                          securityManager: user,
                                        );
                                      },
                                      roleName: ConstantUserRoles
                                          .atomSecurityAndSeniorSecurityManagerUser,
                                      locationId: state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .updateEmailsValue(
                                          securityManager: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .refreshList();
                                      });
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Security Lead
                              CommonWidgets.textDisplay(
                                state.labels?.locale.asl ??
                                    state.labels?.defaultLocale.asl ??
                                    Constants.securityLead,
                                isMandatory: true,
                                Styles.textStyleBlack14,
                              ),
                              TextFieldAddButton(
                                title: state.model.asl?.userInfo ??
                                    state.model.asl?.name,
                                height: 70,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                      context: context,
                                      enabled: !disableForm,
                                      users: state.securityLeads!,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .updateEmailsValue(
                                          securityLead: user,
                                        );
                                      },
                                      roleName: ConstantUserRoles
                                          .atomSecurityLeadAndAssistantSecurityLeadUser,
                                      locationId: state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .updateEmailsValue(
                                          securityLead: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .refreshList();
                                      });
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Location Team
                              CommonWidgets.textDisplay(
                                state.labels?.locale.lt ??
                                    state.labels?.defaultLocale.lt ??
                                    Constants.locationTeam,
                                isMandatory: true,
                                Styles.textStyleBlack14,
                              ),
                              TextFieldAddButton(
                                title: state.model.lt?.userInfo ??
                                    state.model.lt?.name,
                                height: 70,
                                isDisableColor: disableForm,
                                onTap: () {
                                  BaseOrganisationDialog().userDialog(
                                      context: context,
                                      enabled: !disableForm,
                                      users: state.locationTeamUsers!,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .updateEmailsValue(
                                          locationTeam: user,
                                        );
                                        FocusScope.of(context)
                                            .requestFocus(descriptionFocusNode);
                                      },
                                      roleName: ConstantUserRoles
                                          .atomSecurityTeamUser,
                                      locationId: state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .updateEmailsValue(
                                          locationTeam: user,
                                        );
                                        FocusScope.of(context)
                                            .requestFocus(descriptionFocusNode);
                                        // refresh the list
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .refreshList();
                                      });
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Short Description of Incident
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.shortDecIncident ??
                                      state.labels?.defaultLocale
                                          .shortDecIncident ??
                                      Constants.shortIncidentDescription,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                characterLimit:
                                Constants.characterLimitDescTextFormField,
                                showBorder: true,
                                initialValue: state.model.shortDescription,
                                textFormKey: Keys.incidentDescription,
                                hintText: Constants.informationhere,
                                focusNode: descriptionFocusNode,
                                isEnable: state.model.status != 2,
                                isDisableColor:
                                    state.model.status == 2 || disableForm,
                                onChange: (String value) {
                                  state.model.shortDescription = value;
                                  context
                                      .read<SstIncidentGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Detail Description
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.detailDes ??
                                      state.labels?.defaultLocale.detailDes ??
                                      Constants.detailIncidentDescription,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                characterLimit:
                                Constants.characterLimitDescTextFormField,
                                initialValue: state.model.detailDescription,
                                showBorder: true,
                                textFormKey: Keys.incidentDescription,
                                hintText: Constants.informationhere,
                                isEnable: state.model.status != 2,
                                isDisableColor:
                                    state.model.status == 2 || disableForm,
                                onChange: (String value) {
                                  state.model.detailDescription = value;
                                  context
                                      .read<SstIncidentGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// IPB Area
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.ipbArea ??
                                      state.labels?.defaultLocale.ipbArea ??
                                      Constants.ipbArea,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue: state.model.ipbArea == null
                                    ? null
                                    : state.model.ipbArea == true
                                        ? 1
                                        : 0,
                                onChangedYes: disableForm
                                    ? null
                                    : (val) {
                                        state.model.ipbArea = true;
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .onCheckBoxChange(state.model);
                                      },
                                onChangedNo: disableForm
                                    ? null
                                    : (val) {
                                        state.model.ipbArea = false;
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .onCheckBoxChange(state.model);
                                      },
                              ),

                              ///Attachments
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.attachment ??
                                      state.labels?.defaultLocale.attachment ??
                                      Constants.attachments,
                                  Styles.textStyleBlack14),
                              widget.model == null
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),
                              if (state.model.status == 1 ||
                                  state.model.status == null) ...[
                                BaseImageUpload().uploadWidget(
                                  context: context,
                                  isDisabled: disableForm,
                                  loggedInUserDetails:
                                      state.loggedInUserDetails,
                                  getFiles: uploadFiles,
                                  onImageSelected: (ImageContent data) {
                                    List<ImageContent>? files = [];
                                    files.add(data);
                                    for (ImageContent image
                                        in uploadFiles ?? []) {
                                      files.add(image);
                                    }
                                    BlocProvider.of<
                                                SstIncidentGeneralInfoCubit>(
                                            context)
                                        .addAttachment(
                                      data: files,
                                      images: files,
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      /// Attachments
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: BaseImageUpload().getAttachment(
                          height: height,
                          attachments: state.uploadAttachments,
                          files: uploadFiles,
                          moduleCode: Constants.securitySystemModule,
                          isDisabled: disableForm,
                        ),
                      ),

                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      // if (showSystemIntegratorFields) ...[
                      //   CommonWidgets.textDisplay(
                      //       Constants.systemIntegratorForVendorAction,
                      //       Styles.textStyleBlack16),
                      //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                      // ],
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Column(
                          children: [
                            if (showSystemIntegratorFields) ...[
                              CommonWidgets.textDisplay(
                                  Constants.systemIntegratorForVendorAction,
                                  Styles.textStyleBlack16),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Acknowledge Integrator for Vendor Action
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.acknowledgeDateTime ??
                                      state.labels?.defaultLocale
                                          .acknowledgeDateTime ??
                                      Constants.acknowledgeDateAndTime,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              BaseDate().datePickerWidgetLoading(
                                isDisabled: true,
                                textController: acknowledgeDateController,
                                onlyDate: false,
                                showFutureDate: false,
                                onChange: (String value) {},
                                context: context,
                              ),

                              /// Vendor Ticket No
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.vendorTicketNo ??
                                      state.labels?.defaultLocale
                                          .vendorTicketNo ??
                                      Constants.vendorTicketNo,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 1,
                                controller: vendorTicketNoController,
                                textFormKey: Keys.claimantTextController,
                                hintText: Constants.informationhere,
                                focusNode: vendorPocFocusNode,
                                textCapitalization: false,
                                isEnable: false,
                                isDisableColor: true,
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                            ],

                            /// Onsite Visit Date and Time
                            if (showSystemIntegratorFields &&
                                state.model.status !=
                                    ConstantsIntValue
                                        .ticketLifeCycleSubmitStatus) ...[
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.onsiteVisitDT ??
                                      state.labels?.defaultLocale
                                          .onsiteVisitDT ??
                                      Constants.onsiteVisitDateAndTime,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              BaseDate().datePickerWidgetLoading(
                                isDisabled: true,
                                textController: onsiteVisitDateController,
                                onlyDate: false,
                                showFutureDate: false,
                                onChange: (String value) {},
                                context: context,
                              ),

                              /// critical Spare Used
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.criticalSpareUsed ??
                                      state.labels?.defaultLocale
                                          .criticalSpareUsed ??
                                      Constants.criticalSpareUsed,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue: state.model.criticalSpare == null
                                    ? null
                                    : state.model.criticalSpare == true
                                        ? 1
                                        : 0,
                                onChangedYes: disableForm
                                    ? null
                                    : (val) {
                                        state.model.criticalSpare = true;
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .onCheckBoxChange(state.model);
                                      },
                                onChangedNo: disableForm
                                    ? null
                                    : (val) {
                                        state.model.criticalSpare = false;
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .onCheckBoxChange(state.model);
                                      },
                              ),

                              /// Root Cause Analysis
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.rootCauseAnalysis ??
                                      state.labels?.defaultLocale
                                          .rootCauseAnalysis ??
                                      Constants.rootCauseAnalysis,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                characterLimit:
                                Constants.characterLimitDescTextFormField,
                                initialValue: state.model.rootCauseAnalysis,
                                showBorder: true,
                                textFormKey: Keys.incidentDescription,
                                hintText: Constants.informationhere,
                                isEnable: false,
                                isDisableColor: true,
                                onChange: (String value) {
                                  state.model.rootCauseAnalysis = value;
                                  context
                                      .read<SstIncidentGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Action Taken Mitigation Action
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.actionTakenMA ??
                                      state.labels?.defaultLocale
                                          .actionTakenMA ??
                                      Constants.actionTakenMitigationAction,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                characterLimit:
                                Constants.characterLimitDescTextFormField,
                                initialValue: state.model.actionTaken,
                                showBorder: true,
                                textFormKey: Keys.incidentDescription,
                                hintText: Constants.informationhere,
                                isEnable: false,
                                isDisableColor: true,
                                onChange: (String value) {
                                  state.model.actionTaken = value;
                                  context
                                      .read<SstIncidentGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Issue Type
                              CommonWidgets.textDisplay(
                                state.labels?.locale.issueType ??
                                    state.labels?.defaultLocale.issueType ??
                                    Constants.issueType,
                                isMandatory: false,
                                Styles.textStyleBlack14,
                              ),
                              BaseDropDown().getDropDown(
                                  isDisabled: true,
                                  textController: issueTypeController,
                                  items: issueTypeDropDownValues,
                                  initialValue:
                                      state.model.issueType.toString(),
                                  onTap: () {}),

                              /// Data Loss
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.dataLoss ??
                                      state.labels?.defaultLocale.dataLoss ??
                                      Constants.dataLoss,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue: state.model.dataLoss == null
                                      ? null
                                      : state.model.dataLoss == true
                                          ? 1
                                          : 0,
                                  onChangedYes: null,
                                  onChangedNo: null),

                              if (state.model.dataLoss == true) ...[
                                ///Data Loss Attachment
                                CommonWidgets.textDisplay(
                                    // state.labels?.locale.dataLoss ??
                                    //     state.labels?.defaultLocale.dataLoss ??
                                    Constants.dataLossAttachment,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                                BaseImageUpload().uploadWidget(
                                  context: context,
                                  isDisabled: true,
                                  loggedInUserDetails:
                                      state.loggedInUserDetails,
                                  getFiles: uploadFiles,
                                  onImageSelected: (ImageContent data) {
                                    List<ImageContent>? files = [];
                                    files.add(data);
                                    for (ImageContent image
                                        in uploadFiles ?? []) {
                                      files.add(image);
                                    }
                                    BlocProvider.of<
                                                SstIncidentGeneralInfoCubit>(
                                            context)
                                        .addAttachment(
                                      data: files,
                                      images: files,
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Attachments
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: BaseImageUpload().getAttachment(
                                    height: height,
                                    attachments: state.dataLossAttachments,
                                    files: uploadDocuments,
                                    moduleCode: Constants.securitySystemModule,
                                    isDisabled: true,
                                  ),
                                ),
                              ],

                              ///Attach the layout
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.attachDocumentsDesc ??
                                      state.labels?.defaultLocale
                                          .attachDocumentsDesc ??
                                      Constants.attachTheLayout,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              BaseImageUpload().uploadWidget(
                                context: context,
                                isDisabled: true,
                                loggedInUserDetails: state.loggedInUserDetails,
                                getFiles: uploadFiles,
                                onImageSelected: (ImageContent data) {
                                  List<ImageContent>? files = [];
                                  files.add(data);
                                  for (ImageContent image
                                      in uploadFiles ?? []) {
                                    files.add(image);
                                  }
                                  BlocProvider.of<SstIncidentGeneralInfoCubit>(
                                          context)
                                      .addAttachment(
                                    data: files,
                                    images: files,
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Attachments
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: BaseImageUpload().getAttachment(
                                  height: height,
                                  attachments: state.additionalAttachments,
                                  files: attachDocuments,
                                  moduleCode: Constants.securitySystemModule,
                                  isDisabled: true,
                                ),
                              ),
                            ],
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            if (showSolvedProposed) ...[
                              ///Solved proposed Date
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.solvedProposed ??
                                      state.labels?.defaultLocale
                                          .solvedProposed ??
                                      Constants.solvedProposedDate,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              BaseDate().datePickerWidgetLoading(
                                isDisabled: true,
                                textController: solvedProposedDateController,
                                onlyDate: false,
                                showFutureDate: false,
                                onChange: (String value) {},
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            if (state.model.status ==
                                ConstantsIntValue
                                    .ticketLifeCycleClosedStatus) ...[
                              ///Solved Complete
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.solvedComplete ??
                                      state.labels?.defaultLocale
                                          .solvedComplete ??
                                      Constants.solvedCompleteDate,
                                  isMandatory: false,
                                  Styles.textStyleBlack14),
                              BaseDate().datePickerWidgetLoading(
                                isDisabled: true,
                                textController: solvedProposedDateController,
                                onlyDate: false,
                                showFutureDate: false,
                                onChange: (String value) {},
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            if (state.model.reworkDate != null &&
                                state.model.status! >=
                                    ConstantsIntValue
                                        .ticketLifeCycleReworkStatus) ...[
                              /// Rework proposed Date
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.reworkDate ??
                                      state.labels?.defaultLocale.reworkDate ??
                                      Constants.reworkProposedDate,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              BaseDate().datePickerWidgetLoading(
                                isDisabled: true,
                                textController: reworkProposedDateController,
                                onlyDate: false,
                                showFutureDate: false,
                                onChange: (String value) {},
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            if (state.model.status != null &&
                                state.model.status !=
                                    ConstantsIntValue
                                        .ticketLifeCycleCreateStatus) ...[
                              ///Escalation 1
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.escalation1 ??
                                      state.labels?.defaultLocale.escalation1 ??
                                      Constants.escalation1,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              BaseDate().datePickerWidgetLoading(
                                isDisabled: true,
                                textController: escalation1Controller,
                                onlyDate: false,
                                showFutureDate: false,
                                onChange: (String value) {},
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Escalation 2
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.escalation2 ??
                                      state.labels?.defaultLocale.escalation2 ??
                                      Constants.escalation2,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              BaseDate().datePickerWidgetLoading(
                                isDisabled: true,
                                textController: escalation2Controller,
                                onlyDate: false,
                                showFutureDate: false,
                                onChange: (String value) {},
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Escalation 3
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.escalation3 ??
                                      state.labels?.defaultLocale.escalation3 ??
                                      Constants.escalation3,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              BaseDate().datePickerWidgetLoading(
                                isDisabled: true,
                                textController: escalation3Controller,
                                onlyDate: false,
                                showFutureDate: false,
                                onChange: (String value) {},
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                            if (showSLAOnsiteResponse) ...[
                              /// SLA Onsite Response
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.slaOnsiteResponse ??
                                      state.labels?.defaultLocale
                                          .slaOnsiteResponse ??
                                      Constants.slaOnSiteResponse,
                                  isMandatory: false,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 1,
                                controller: slaOnsiteResponseController,
                                // initialValue: state.model.escalation3Poc,
                                textFormKey: Keys.claimantTextController,
                                hintText: '',
                                isEnable: false,
                                isDisableColor: true,
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                            ],

                            if (state.model.status ==
                                ConstantsIntValue
                                    .ticketLifeCycleClosedStatus) ...[
                              /// Downtime(Hours)
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.downtime ??
                                      state.labels?.defaultLocale.downtime ??
                                      Constants.downTime,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 1,
                                controller: downTimeController,
                                // initialValue: state.model.escalation3Poc,
                                textFormKey: Keys.claimantTextController,
                                hintText: '',
                                isEnable: false,
                                isDisableColor: true,
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),

                              ///SLA Resolution Date
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.slaResolutionDate ??
                                      state.labels?.defaultLocale
                                          .slaResolutionDate ??
                                      Constants.slaResolutionDate,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 1,
                                controller: slaResolutionDateController,
                                // initialValue: state.model.escalation3Poc,
                                textFormKey: Keys.claimantTextController,
                                hintText: '',
                                isEnable: false,
                                isDisableColor: true,
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                            ],

                            /// Activity notes
                            if (showSystemIntegratorFields &&
                                state.model.status !=
                                    ConstantsIntValue
                                        .ticketLifeCycleSubmitStatus) ...[
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.activityNotes ??
                                      state.labels?.defaultLocale
                                          .activityNotes ??
                                      Constants.activityNotes,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              Column(
                                children: getActivityNotes(
                                    state.model.activityNotes ?? [],
                                    height,
                                    state),
                              ),
                            ],
                            if(state.model.id != null) ...[
                              /// Modified Date
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.date ??
                                //     state.labels?.defaultLocale.date ??
                                Constants.modifiedOn,
                                Styles.textStyleBlack14,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              datecreateWidgetdisplay(
                                  state.model.modifiedDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Modified By
                              CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.entrySecurity ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                  Constants.modifiedBy,
                                  isMandatory: true,
                                  state.model.modifiedBy ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                          ],
                        ),
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      // if(state.model.id != null) ...[
                      //   /// Modified Date
                      //   CommonWidgets.textDisplay(
                      //     // state.labels?.locale.date ??
                      //     //     state.labels?.defaultLocale.date ??
                      //     Constants.modifiedOn,
                      //     Styles.textStyleBlack14,
                      //     isMandatory: true,
                      //   ),
                      //   CommonWidgets.verticalSpacerWidget(
                      //       height * 0.001),
                      //   datecreateWidgetdisplay(
                      //       state.model.modifiedDate ?? ''),
                      //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                      //
                      //   /// Modified By
                      //   CommonWidgets.horizentaltextHandling(
                      //     // state.labels?.locale.entrySecurity ??
                      //     //     state.labels?.defaultLocale.entrySecurity ??
                      //       Constants.modifiedBy,
                      //       isMandatory: true,
                      //       state.model.modifiedBy ?? ''),
                      //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                      // ],
                      /// SubmitButton
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cancelButtonDisplay(),
                          if (!disableForm) ...[
                            submitButtonDisplay(onTap: () {
                              FocusScope.of(context).unfocus();
                              BlocProvider.of<SstIncidentGeneralInfoCubit>(
                                      context)
                                  .submitForm(
                                isSubmitOnly: true,
                                isSaveOnly: false,
                                isReworkOnly: false,
                              );
                            })
                          ],
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getStatusString(int status) {
    switch (status) {
      case 1:
        return 'Create';
      case 2:
        return 'Submit';
      case 3:
        return 'Acknowledge';
      case 4:
        return 'Hold';
      case 5:
        return 'Rework';
      case 6:
        return 'Review';
      case 7:
        return 'Solve Propose';
      case 8:
        return 'Quotes Reject';
      case 9:
        return 'Quotes Approve';
      case 10:
        return 'Po Raised';
      case 11:
        return 'Work Complete';
      case 12:
        return 'Invoice Request';
      case 13:
        return 'Invoice Submit';
      case 14:
        return 'Closed';
      case -1:
        return 'Cancelled';
      default:
        return '';
    }
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

  // Widget cancelButtonDisplay(SstIncidentGeneralInfoState state) {
  //   bool condition = widget.model?.id == null ||
  //       widget.model?.status == ConstantsIntValue.cancelledStatus ||
  //       widget.model?.status == 14;
  //   return AppButton(
  //     width: Constants.cancelButtonWidth,
  //     backgroundColor: Colors.white,
  //     key: const Key(Keys.cancelButton),
  //     buttonText: condition ? Constants.close : Constants.cancelRecord,
  //     buttonTextKey: Keys.cancelButton,
  //     onTap: () {
  //       if (condition) {
  //         Navigator.pop(context);
  //         return;
  //       }
  //       var dialog = CustomAlertDialog(
  //           title: Constants.cancelRecord,
  //           message: Constants.cancelRecordWarningMessage,
  //           onPositivePressed: () {
  //             var dialog = CustomAlertDialog(
  //                 title: Constants.cancelRecord,
  //                 message: Constants.cancelRecordWarningMessage,
  //                 onPositivePressed: () {
  //                   Navigator.pop(context);
  //                   Navigator.pop(context);
  //                   updateRecordStatus(state);
  //                 },
  //                 positiveBtnText: Constants.yes,
  //                 negativeBtnText: Constants.no);
  //             showDialog(
  //                 context: context, builder: (BuildContext context) => dialog);
  //           },
  //           positiveBtnText: Constants.yes,
  //           negativeBtnText: Constants.no);
  //       showDialog(context: context, builder: (BuildContext context) => dialog);
  //     },
  //   );
  // }

  // void updateRecordStatus(SstIncidentGeneralInfoState state) {
  //   if (state.model.id != null) {
  //     BlocProvider.of<SstIncidentGeneralInfoCubit>(context)
  //         .updateStatus(id: state.model.id.toString());
  //     Navigator.popAndPushNamed(context, sstIncidentDetailsRoute);
  //   } else {
  //     Navigator.pop(context);
  //   }
  // }

  List<Widget> getActivityNotes(List<ActivityNotes> list, double height,
      SstIncidentGeneralInfoState state) {
    log('-list--${list.length}--');
    List<Widget> widgets = [];

    for (ActivityNotes activityNotes in list) {
      TextEditingController activityNotesController = TextEditingController();
      TextEditingController dateController = TextEditingController();
      activityNotesController.text = activityNotes.activityNotes ?? '';
      dateController.text = activityNotes.submittedDate != null
          ? Utils.timestampToDateConversion(
              int.tryParse(activityNotes.submittedDate ?? '0'),
              Constants.fulldateFormat)
          : '';
      widgets.add(
        Align(
          alignment: Alignment.centerLeft,
          // Ensure content is aligned to the left
          child: Container(
            width: double.infinity,
            // Ensure container takes up full width
            decoration: BoxDecoration(
              color: AppColors.lightGreyBackground,
              borderRadius: BorderRadius.circular(5),
            ),
            margin: const EdgeInsets.only(bottom: 10.0),
            // Space between each note
            padding: const EdgeInsets.all(10.0),
            // Add padding for better spacing
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Align content to the start (left)
              children: [
                // Display the activity note
                // Text(
                //   activityNotes.activityNotes ?? '',
                //   style: const TextStyle(
                //     fontSize: 16,
                //     color: Colors.grey,
                //   ),
                // ),
                const SizedBox(height: 30),
                Text(
                  '${Constants.date} - ${dateController.text}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                FlutterInputField(
                  lineHeight: 6,
                  characterLimit:
                  Constants.characterLimitDescTextFormField,
                  initialValue: activityNotes.activityNotes ?? '',
                  showBorder: true,
                  textFormKey: Keys.incidentDescription,
                  hintText: Constants.informationhere,
                  isEnable: false,
                  isDisableColor: true,
                  onChange: (String value) {
                    state.model.detailDescription = value;
                    context
                        .read<SstIncidentGeneralInfoCubit>()
                        .onModelValueChange(state.model);
                  },
                  validateTextField: (String? user) {},
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (widgets.isNotEmpty) {
      return [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Ensure left alignment of all notes
          children: widgets,
        ),
      ];
    } else {
      return []; // Or provide a default list based on your requirements
    }
  }

  Widget submitButtonDisplay(
      {required Function onTap, String? label = Constants.submit}) {
    return AppButton(
      width: 150,
      buttonText: label,
      buttonTextKey: Keys.submitButton,
      onTap: onTap,
    );
  }

  // Widget submitButtonDisplay() {
  //   return AppButton(
  //     width: 150,
  //     key: const Key(Keys.submitButton),
  //     buttonText: Constants.submit,
  //     buttonTextKey: Keys.submitButton,
  //     onTap: () async {
  //       FocusScope.of(context).unfocus();
  //       BlocProvider.of<GeneralInfoCubit>(context)
  //           .submitForm(isSaveOnly: false);
  //     },
  //   );
  // }

  Widget locationWidgetdislay({
    required bool enabled,
    Locations? locations,
    required String selectedLocation,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        if (enabled) {
          selectLocation(
            locations: locations,
            onTap: onTap,
          );
        }
      },
      child: SelectedTileValueWidget(name: selectedLocation),
    );
  }

  void selectLocation({Locations? locations, Function? onTap}) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // print(state.getLocationsResponse);
        return CustomExpansionListTexts(
          locationList: locations,
          onTap: onTap,
        );
      },
    );
  }

  TextEditingController addEPOfficerController = TextEditingController();

  Widget datecreateWidgetdisplay(String date) {
    return FlutterInputField(
      textFormKey: Keys.dateofcreationTextController,
      initialValue: date,
      hintText: '',
      isEnable: false,
      isDisableColor: true,
      onChange: (String value) {},
      validateTextField: (String? user) {},
    );
  }
}
