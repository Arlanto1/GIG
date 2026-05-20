import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_add_organisation_dialog.dart';
import '../../models/quantity_units.dart';
import 'add_rejection_commnet_pop_up.dart';

class MaterialMovementDetailsView extends StatefulWidget {
  final MaterialMovementModel? model;
  final bool isInward;
  final bool? returnable;
  final String title;
  final ExtraProperties? extraProperties;

  const MaterialMovementDetailsView({
    super.key,
    this.model,
    required this.isInward,
    required this.returnable,
    required this.title,
    this.extraProperties,
  });

  @override
  State<MaterialMovementDetailsView> createState() =>
      _MaterialMovementDetailsViewState();
}

class _MaterialMovementDetailsViewState
    extends State<MaterialMovementDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController returnableTextController = TextEditingController();
  User? userDetails;
  List<ImageContent> getFiles = [];
  TextEditingController takenOutOnDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController expectedDateOfReturnController =
      TextEditingController();
  TextEditingController actualDateOfReturnController = TextEditingController();
  bool isReadOnly = false;
  List<String> returnableDropDownValues = const [
    "Returnable",
    "Non Returnable"
  ];
  TextEditingController materialBriefDescriptionController =
      TextEditingController();
  SignatureController receiverSignatureController = SignatureController();
  SignatureController securitySignatureController = SignatureController();
  TextEditingController materialComingFromBriefDescriptionController =
      TextEditingController();
  TextEditingController receiverEmailController = TextEditingController();
  TextEditingController receiverByEmailController = TextEditingController();
  TextEditingController requesterEmailController = TextEditingController();
  TextEditingController requester2EmailController = TextEditingController();
  final FocusNode requestorEmployeeIdFocusNode = FocusNode();
  final FocusNode receivedForEmployeeIdFocusNode = FocusNode();
  final FocusNode sentToFocusNode = FocusNode();
  final FocusNode receivedByFocusNode = FocusNode();
  List<MaterialItem>? materials;

  @override
  void initState() {
    super.initState();
    receiverSignatureController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white);

    securitySignatureController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white);
    BlocProvider.of<MaterialMovementDetailsCubit>(context).initializeValues();
  }

  static const String moduleCode = Constants.materialMovementModuleCode;

  @override
  void dispose() {
    receiverSignatureController.dispose();
    securitySignatureController.dispose();
    super.dispose();
  }

  bool showSaveSubmitButtons = false;
  bool showLikeAndDislikeButton = false;
  bool editByRequester = false;
  bool editByCreatedByUser = false;
  bool lock = false;
  bool isApproverRequesterEmailDepartment = false;
  bool isEligibleToEdit = false;
  bool showApprovalLikeAndDislikeButton = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<MaterialMovementDetailsCubit,
        MaterialMovementDetailsState>(
      listener: (context, state) {
        log('-state.status--${state.status}--');

        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: widget.isInward
                ? 'Inward Material Movement'
                : 'Outward Material Movement',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                  context, materialMovementInwardsOutwardsRoute, arguments: {
                "isInward": widget.isInward,
                "returnable": widget.returnable
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
        receiverEmailController.text = state.model.receiverEmail ?? '';
        receiverByEmailController.text = state.model.otherReceiverName ?? '';
        requesterEmailController.text = state.model.requestorEmail ?? '';
        requester2EmailController.text = state.model.requestor2Email ?? '';

        if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 10 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == -1 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 0 && state.model.lock.isEmptyOrNull) {
          isReadOnly = false;
        }
        if (state.model.status == 4 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 12 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status != ConstantsIntValue.mmStatusInwardWaiting &&
            (state.model.status == null || state.model.status == 0)) {
          isApproverRequesterEmailDepartment = true;
        }

        if (state.model.status == null) {
          isReadOnly = false;
        }
        if (state.model.isEligibleToEdit) {
          isEligibleToEdit = true;
        }
        String? requesterEmailUser = state.model.requestorEmail;
        String? requester2EmailUser = state.model.requestor2Email;

        log('123 ${state.model.requestorEmail}');
        if ((
                state.model.status == ConstantsIntValue.mmStatusLSMRejected) &&
            (requesterEmailUser != null &&
                requesterEmailUser ==
                    '${state.loggedInUserDetails?.firstName} ${state.loggedInUserDetails?.lastName} (${state.loggedInUserDetails?.email})') &&
            (requester2EmailUser != null &&
                requester2EmailUser ==
                    '${state.loggedInUserDetails?.firstName} ${state.loggedInUserDetails?.lastName} (${state.loggedInUserDetails?.email})')) {
          isReadOnly = false;
        }

        if (!state.model.lock.isEmptyOrNull) {
          lock = true;
        }

        showLikeAndDislikeButton =
            (state.model.status == ConstantsIntValue.mmStatusLSMReview) &&
                (state.model.entrySecurity!.email
                    .equalsIgnoreCase(state.loggedInUserDetails?.email));

        log('showApprovalLikeAndDislikeButton ${showApprovalLikeAndDislikeButton}');
        log('state.model.status == ConstantsIntValue.mmStatusLSMApproved ${state.model.status == ConstantsIntValue.mmStatusLSMApproved}');
        log('1 ${state.model.approver1Email
            .equalsIgnoreCase(state.loggedInUserDetails?.email)}');
        log('2 ${state.model.approver2Email
            .equalsIgnoreCase(state.loggedInUserDetails?.email)}');
        log('111 ${state.model.approver1Email
        }');
        log('222 ${state.model.approver2Email
           }');
        showApprovalLikeAndDislikeButton = state.model.status == ConstantsIntValue.mmStatusLSMApproved && (state.model.approver1Email
            .equalsIgnoreCase(state.loggedInUserDetails?.email) || state.model.approver2Email
            .equalsIgnoreCase(state.loggedInUserDetails?.email));
        editByRequester = ((state.model.status ==
                    ConstantsIntValue.businessUserReview ||
                state.model.status == ConstantsIntValue.mmStatusLSMRejected) &&
            ((requesterEmailUser != null &&
                    requesterEmailUser ==
                        '${state.loggedInUserDetails?.firstName} ${state.loggedInUserDetails?.lastName} (${state.loggedInUserDetails?.email})') ||
                (requester2EmailUser != null &&
                    requester2EmailUser ==
                        '${state.loggedInUserDetails?.firstName} ${state.loggedInUserDetails?.lastName} (${state.loggedInUserDetails?.email})')));

        log('editByRequester ${requesterEmailUser != null && requesterEmailUser == '${state.loggedInUserDetails?.firstName} ${state.loggedInUserDetails?.lastName} (${state.loggedInUserDetails?.email})'}');
        log('editByCreater ${requesterEmailUser == '${state.loggedInUserDetails?.firstName} ${state.loggedInUserDetails?.lastName} (${state.loggedInUserDetails?.email})'}');

        log('req $requesterEmailUser');
        log('req1 ${state.loggedInUserDetails?.firstName} ${state.loggedInUserDetails?.lastName} (${state.loggedInUserDetails?.email})');
        editByCreatedByUser = ((state.model.status ==
                    ConstantsIntValue.mmStatusApproved ||
                state.model.status == ConstantsIntValue.mmStatusInwardWaiting ||
                state.model.status == ConstantsIntValue.mmStatusOverDue || state.model.status == ConstantsIntValue.mmStatusInwardPending) &&
            ((state.model.entrySecurity!.email
                    .equalsIgnoreCase(state.loggedInUserDetails?.email)) ||
                isEligibleToEdit));

        showSaveSubmitButtons = widget.model == null ||
            state.model.status == 0 ||
            ((state.model.status != ConstantsIntValue.mmStatusLSMApproved &&
                    state.model.status !=
                        ConstantsIntValue.mmStatusLSMReview) &&
                (editByRequester || editByCreatedByUser));

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: showSaveSubmitButtons &&
                state.model.status != ConstantsIntValue.mmStatusClosed &&
                !lock &&
                state.status != FormStatus.loading,
            pdfAPIName:
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=$moduleCode',
            gatePassPdf: '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=GMM',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<MaterialMovementDetailsCubit>(context).submitForm(
                isSaveOnly: true,
                isRejectOnly: false,
                isApprovedOnly: false,
                receiverSignatureController: receiverSignatureController,
                securitySignatureController: securitySignatureController,
              );
            },
            showSubmitButton: showSaveSubmitButtons &&
                state.model.status != ConstantsIntValue.mmStatusClosed &&
                !lock &&
                state.status != FormStatus.loading,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<MaterialMovementDetailsCubit>(context).submitForm(
                isSaveOnly: false,
                isRejectOnly: false,
                isApprovedOnly: false,
                receiverSignatureController: receiverSignatureController,
                securitySignatureController: securitySignatureController,
              );
            },
            showLikeButton: (showLikeAndDislikeButton || isEligibleToEdit) &&
                !lock &&
                state.status != FormStatus.loading,
            onTapLikeButton: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<MaterialMovementDetailsCubit>(context).submitForm(
                isApprovedOnly: true,
                isSaveOnly: false,
                isRejectOnly: false,
                receiverSignatureController: receiverSignatureController,
                securitySignatureController: securitySignatureController,
              );
            },
            showDisLikeButton: (showLikeAndDislikeButton  ) ,
            onTapDislikeButton: () {
              // FocusScope.of(context).unfocus();
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AddRejectionCommentPopUp(
                    mainContext: context,
                    onSubmit: (value) {
                      log('--value--$value--');
                      state.model.rejectionComment = value;
                      BlocProvider.of<MaterialMovementDetailsCubit>(context)
                          .onAddRejectionComment(value);

                      BlocProvider.of<MaterialMovementDetailsCubit>(context)
                          .submitForm(
                        isRejectOnly: true,
                        isSaveOnly: false,
                        isApprovedOnly: false,
                        receiverSignatureController:
                            receiverSignatureController,
                        securitySignatureController:
                            securitySignatureController,
                      );
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
          backgroundColor: Colors.transparent,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(MaterialMovementDetailsState state) {
    log('-widget.materialMovement?.expectedDateOfReturn--${widget.model?.expectedDateOfReturn}--');
    if (state.model.expectedDateOfReturn != null) {
      expectedDateOfReturnController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.expectedDateOfReturn ?? '0'),
          Constants.dateFormat);
    }
    if (state.model.actualDateOfReturn != null) {
      actualDateOfReturnController.text = Utils.timestampToDateConversion(
          int.tryParse(widget.model?.actualDateOfReturn ?? '0'),
          Constants.fulldateFormat);
    }

    if (state.model.takenOutDate != null) {
      takenOutOnDateController.text = Utils.timestampToDateConversion(
          int.tryParse(widget.model?.takenOutDate ?? '0'),
          Constants.fulldateFormat);
    }
  }

  getBodybuilder(MaterialMovementDetailsState state, height) {
    initializeDates(state);
    log('-state.materialMovement.status---${state.model.status}--');
    log('-rejection Comment---${widget.model?.rejectionComment}--');
    log('widget.returnable ${widget.returnable}');

    returnableTextController.text =
        widget.returnable == true ? 'Returnable' : 'Non Returnable';
    returnableTextController.text =
    state.model.returnable == true ? 'Returnable' : 'Non Returnable';

    if (widget.returnable == true) {
      returnableTextController.text == 'Returnable';
    } else {
      returnableTextController.text == 'Non Returnable';
    }
    // ((state.model.returnable ?? false) || (widget.returnable ?? false))
    //     ? 'Returnable'
    //     : 'Non Returnable';
    if (returnableTextController.text == 'Returnable') {
      if (widget.returnable ?? true) {
        state.model.returnable = true;
      }
    } else {
      state.model.returnable = false;
    }
    // state.model.returnable ??= false ;
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      getFiles = state.loadAttachments ?? [];
    }
    // bool isQuantityDisabled = (state.model.status == 10 ||
    //     state.model.status == -1 ||
    //     state.model.status == 6 ||
    //     state.model.status == 2);

    bool isQuantityDisabled = state.model.status == 10 ||
        state.model.status == -1 ||
        state.model.status == 6 ||
        state.model.status == 2 ||
        state.model.status == 3 ||
        state.model.status == 4 ||
        !showSaveSubmitButtons ||
        state.model.status == ConstantsIntValue.mmStatusInwardWaiting ||
        !state.model.lock.isEmptyOrNull;
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
                child: Form(
                  key: _formKey,
                  autovalidateMode: isReadOnly
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AbsorbPointer(
                          absorbing: !showSaveSubmitButtons || lock,
                          child: Column(
                            children: [
                              if (!state.model.lock.isEmptyOrNull) ...[
                                RecordLockedWidget(text: '${state.model.lock}'),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  Constants.generalinformation,
                                  style: Styles.textStyleRegularNormalWhite18,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Material Movement Type
                              CommonWidgets.textDisplay(
                                state.labels?.locale.type ??
                                    state.labels?.defaultLocale.type ??
                                    'Material Movement Type',
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),

                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue:
                                    widget.isInward ? 'Inward' : 'Outward',
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Returnable/Non Returnable
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: returnableTextController,
                                // initialValue: state.model.returnable.toString(),
                                onTap: () {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Status
                              CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: statusController,
                                items: materialMovementStatusValues,
                                initialValue: '${state.model.status ?? 0}',
                                onTap: () {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Created By
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.createdby,
                                  isMandatory: true,
                                  '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Location
                              CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              // locationWidgetdislay(state),
                              BaseLocationDropdown().locationWidgetDisplay(
                                  isEnabled: (state.model.status ==
                                              ConstantsIntValue.mmStatusDraft ||
                                          state.model.status == null) &&
                                      !lock,
                                  context: context,
                                  locations: state.locations ?? Locations(),
                                  selectedLocationName:
                                      state.model.location?.name ?? '',
                                  onTap: (Organisation? location) {
                                    BlocProvider.of<
                                                MaterialMovementDetailsCubit>(
                                            context)
                                        .updateLocationDropdownValue(
                                            location: location);
                                  }),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Date of creation
                              CommonWidgets.textDisplay(
                                state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              datecreateWidgetdisplay(
                                  state.model.inputDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Sl No.
                              CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.slNo ??
                                //     state.labels?.defaultLocale.slNo ??
                                widget.isInward
                                    ? Constants.slno
                                    : 'Gate Pass No',
                                state.model.slNo ?? '',
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (widget.isInward) ...[
                                /// Challan/ Invoice Nos/ Gate Pass
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.challanNo ??
                                      state.labels?.defaultLocale.challanNo ??
                                      Constants.challan,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  textFormKey: Keys.challanKey,
                                  initialValue: state.model.challanNo,
                                  characterLimit:
                                      Constants.characterLimitIdTextFormField,
                                  hintText: '',
                                  isEnable: state.model.status == 10 ||
                                          state.model.status == -1 ||
                                          state.model.status == 6 ||
                                          state.model.status == 2 ||
                                          state.model.status == 3 ||
                                          state.model.status == 4 ||
                                          state.model.status == 5 ||
                                          state.model.status == 1 ||
                                          state.model.status == 7 ||
                                          state.model.status ==
                                              ConstantsIntValue
                                                  .mmStatusInwardWaiting ||
                                          !state.model.lock.isEmptyOrNull ||
                                          state.model.status ==
                                              ConstantsIntValue.mmStatusOverDue || state.model.status == ConstantsIntValue.mmStatusInwardPending
                                      ? false
                                      : true,
                                  isDisableColor: state.model.status == 10 ||
                                      state.model.status == -1 ||
                                      state.model.status == 6 ||
                                      state.model.status == 2 ||
                                      state.model.status == 3 ||
                                      state.model.status == 5 ||
                                      state.model.status == 1 ||
                                      state.model.status == 7 ||
                                      state.model.status ==
                                          ConstantsIntValue
                                              .mmStatusInwardWaiting ||
                                      !state.model.lock.isEmptyOrNull ||
                                      state.model.status !=
                                          ConstantsIntValue.mmStatusOverDue,
                                  onChange: (String value) {
                                    state.model.challanNo = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// PO Number
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.poNumber ??
                                        state.labels?.defaultLocale.poNumber ??
                                        Constants.poNumber,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  initialValue: state.model.poNumber,
                                  textFormKey: Keys.poNumberKey,
                                  hintText: '',
                                  isEnable: state.model.status == 10 ||
                                          state.model.status == -1 ||
                                          state.model.status == 6 ||
                                          state.model.status == 3 ||
                                          state.model.status == 4 ||
                                          state.model.status == 5 ||
                                          !state.model.lock.isEmptyOrNull ||
                                          state.model.status ==
                                              ConstantsIntValue.mmStatusOverDue ||state.model.status == ConstantsIntValue.mmStatusInwardPending
                                      ? false
                                      : true,
                                  isDisableColor: state.model.status == 10 ||
                                      state.model.status == -1 ||
                                      state.model.status == 6 ||
                                      state.model.status == 3 ||
                                      state.model.status == 4 ||
                                      state.model.status == 5 ||
                                      !state.model.lock.isEmptyOrNull,
                                  onChange: (String value) {
                                    state.model.poNumber = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              /// Material Items Description
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Material Items Description',
                                  style: Styles.styleHeaderWhiteText16,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              GestureDetector(
                                onTap: () async {
                                  NavigatorState nav = Navigator.of(context);
                                  if (state.model.status == 0 ||
                                      state.model.status == null) {
                                    bool isSaveSuccess = await BlocProvider.of<
                                                MaterialMovementDetailsCubit>(
                                            context)
                                        .submitForm(
                                      isSaveOnly: true,
                                      navigateToNextScreen: true,
                                      receiverSignatureController:
                                          receiverSignatureController,
                                      securitySignatureController:
                                          securitySignatureController,
                                    );

                                    if (!isSaveSuccess) {
                                      return;
                                    }
                                    log('--state.model.id---${state.model.id}--');
                                  }

                                  List<Organisation> units =
                                      await CommonServices().getOrganisations(
                                          name: 'ATOM_MATERIAL_MOVEMENT_UNIT');
                                  nav.pushNamed(
                                    materialItemsRoute,
                                    arguments: {
                                      ConstantsArgument.title:
                                          'Material Items Description',
                                      ConstantsArgument.id: state.model.id,
                                      ConstantsArgument.isLocked:
                                          state.model.lock,
                                      ConstantsArgument.parentStatus:
                                          state.model.status,
                                      ConstantsArgument.unit:
                                          'ATOM_MATERIAL_MOVEMENT_UNIT',
                                      ConstantsArgument.units: units,
                                      ConstantsArgument.isInward:
                                          state.model.inwardMovement
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      AppIcon.pluscircle,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.white,
                                        BlendMode.srcIn,
                                      ),
                                      // color: AppColors.navigationSkyBlueColor,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Add/View Material Items Description',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// Outward Details Fields
                              if (!widget.isInward ||
                                  (widget.isInward &&
                                      state.model.status != null &&
                                      state.model.status != 0)) ...[
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Sent to Address
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.address ??
                                      state.labels?.defaultLocale.address ??
                                      Constants.address,
                                  Styles.textStyleWhite16,
                                  isMandatory: state.model.status !=
                                              ConstantsIntValue.mmStatusDraft &&
                                          widget.model != null
                                      ? true
                                      : false,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue: state.model.address,
                                  showBorder: true,
                                  textFormKey: Keys.addressKey,
                                  characterLimit:
                                      Constants.characterLimitDescTextFormField,
                                  hintText: '',
                                  isEnable: state.model.status == 10 ||
                                          state.model.status == -1 ||
                                          state.model.status == 6 ||
                                          state.model.status == 2 ||
                                          state.model.status == 3 ||
                                          state.model.status == 4 ||
                                          state.model.status ==
                                              ConstantsIntValue
                                                  .mmStatusInwardWaiting ||
                                          !state.model.lock.isEmptyOrNull
                                      ? false
                                      : true,
                                  isDisableColor: state.model.status == 10 ||
                                          state.model.status == -1 ||
                                          state.model.status == 6 ||
                                          state.model.status == 2 ||
                                          state.model.status == 3 ||
                                          state.model.status == 4 ||
                                          !showSaveSubmitButtons ||
                                          state.model.status ==
                                              ConstantsIntValue
                                                  .mmStatusInwardWaiting ||
                                          !state.model.lock.isEmptyOrNull
                                      ? true
                                      : false,
                                  onChange: (String value) {
                                    state.model.address = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  textInputAction: TextInputAction.newline,
                                  textInputType: TextInputType.multiline,
                                  //
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Sent To
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.sentTo ??
                                      state.labels?.defaultLocale.sentTo ??
                                      Constants.sentTo,
                                  Styles.textStyleWhite16,
                                  isMandatory: state.model.status !=
                                              ConstantsIntValue.mmStatusDraft &&
                                          widget.model != null
                                      ? true
                                      : false,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  initialValue: state.model.sentTo,
                                  textFormKey: Keys.sentToKey,
                                  hintText: '',
                                  focusNode: sentToFocusNode,
                                  isEnable: state.model.status == 10 ||
                                          state.model.status == -1 ||
                                          state.model.status == 6 ||
                                          state.model.status == 2 ||
                                          state.model.status == 3 ||
                                          state.model.status == 4 ||
                                          state.model.status ==
                                              ConstantsIntValue
                                                  .mmStatusInwardWaiting ||
                                          !state.model.lock.isEmptyOrNull
                                      ? false
                                      : true,
                                  isDisableColor: state.model.status == 10 ||
                                          state.model.status == -1 ||
                                          state.model.status == 6 ||
                                          state.model.status == 2 ||
                                          state.model.status == 3 ||
                                          state.model.status == 4 ||
                                          !showSaveSubmitButtons ||
                                          state.model.status ==
                                              ConstantsIntValue
                                                  .mmStatusInwardWaiting ||
                                          !state.model.lock.isEmptyOrNull
                                      ? true
                                      : false,
                                  onChange: (String value) {
                                    state.model.sentTo = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (widget.isInward) ...[
                                /// Senders Name
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.materialComingFrom ??
                                      state.labels?.defaultLocale
                                          .materialComingFrom ??
                                      Constants.sendersName,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  initialValue: state.model.materialComingFrom,
                                  textFormKey: Keys.sendersKey,
                                  hintText: '',
                                  isEnable: !isReadOnly && state.model.status != ConstantsIntValue.businessUserReview && state.model.status != ConstantsIntValue.mmStatusInwardPending ,
                                  isDisableColor: isReadOnly ||state.model.status == ConstantsIntValue.businessUserReview || state.model.status == ConstantsIntValue.mmStatusInwardPending ,
                                  onChange: (String value) {
                                    state.model.materialComingFrom = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Material Coming From Address
                                CommonWidgets.textDisplay(
                                  state.labels?.locale
                                          .materialComingFromAddress ??
                                      state.labels?.defaultLocale
                                          .materialComingFromAddress ??
                                      Constants
                                          .materialComingFromBriefDescription,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  showBorder: true,
                                  lineHeight: 6,
                                  initialValue: state.model.materialFromAddress,
                                  characterLimit:
                                      Constants.characterLimitDescTextFormField,
                                  textFormKey: Keys.materialComingFromKey,
                                  hintText: Constants.informationhere,
                                  isEnable: !isReadOnly && state.model.status != ConstantsIntValue.mmStatusInwardPending && state.model.status != ConstantsIntValue.businessUserReview ,
                              isDisableColor: isReadOnly ||state.model.status == ConstantsIntValue.businessUserReview ,
                                  // isEnable: true,
                                  // isDisableColor: state.model.status == 6 ||
                                  //     state.model.status == 10 ||
                                  //     state.model.status == 1 ||
                                  //     !state.model.lock.isEmptyOrNull,
                                  validateTextField: (String? user) {},
                                  onChange: (String value) {
                                    state.model.materialFromAddress = value;
                                  },
                                  textInputAction: TextInputAction.newline,
                                  textInputType: TextInputType.multiline, //
                                ),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Is original receiver receiving
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.originalReceiver ??
                                      state.labels?.defaultLocale
                                          .originalReceiver ??
                                      Constants.isOriginalReceiverReceiving,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.originalReceiver ? 1 : 0,
                                  onChangedYes: widget.model?.status == 6 ||
                                          widget.model?.status == -1 ||
                                          widget.model?.status == 10 ||
                                          !state.model.lock.isEmptyOrNull || state.model.status == ConstantsIntValue.mmStatusInwardPending ||state.model.status == ConstantsIntValue.businessUserReview
                                      ? null
                                      : (val) {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          BlocProvider.of<
                                                      MaterialMovementDetailsCubit>(
                                                  context)
                                              .showFields(
                                            isOriginalReceiverReceiving: true,
                                          );
                                          state.model.receiverEmail = null;
                                          state.model.receiverEmployeeId = null;
                                          state.model.otherReceiverEmployeeId =
                                              null;
                                          state.model.receiverDepartmenttName =
                                              null;
                                        },
                                  onChangedNo: widget.model?.status == 6 ||
                                          widget.model?.status == -1 ||
                                          widget.model?.status == 10 ||
                                          !state.model.lock.isEmptyOrNull || state.model.status == ConstantsIntValue.mmStatusInwardPending ||state.model.status == ConstantsIntValue.businessUserReview
                                      ? null
                                      : (val) {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          BlocProvider.of<
                                                      MaterialMovementDetailsCubit>(
                                                  context)
                                              .showFields(
                                            isOriginalReceiverReceiving: false,
                                          );
                                          state.model.receiverEmail = null;
                                          state.model.receiverEmployeeId = null;
                                          state.model.otherReceiverEmployeeId =
                                              null;
                                          state.model.receiverDepartmenttName =
                                              null;
                                        },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                if (state.model.originalReceiver == false) ...[
                                  ///Received For Employee Id
                                  Column(
                                    children: [
                                      CommonWidgets.textDisplay(
                                        state.labels?.locale
                                                .receiverEmployeeId ??
                                            state.labels?.defaultLocale
                                                .receiverEmployeeId ??
                                            Constants.receivedForEmployeeId,
                                        Styles.textStyleWhite16,
                                        isMandatory: true,
                                      ),
                                      TextFieldAddButton(
                                          title: state.model.receiverEmployeeId,
                                          height: 70,
                                          isDisableColor: isReadOnly || state.model.status == ConstantsIntValue.mmStatusInwardPending ||state.model.status == ConstantsIntValue.businessUserReview,
                                          onTap: () {
                                            if (!isReadOnly && state.model.status != ConstantsIntValue.mmStatusInwardPending && state.model.status != ConstantsIntValue.businessUserReview) {
                                              BaseOrganisationDialog()
                                                  .userDialog(
                                                employeeId: true,
                                                context: context,
                                                users:
                                                    state.receiverEmailUsers!,
                                                isDbUser: true,
                                                onTap: (BaseUser user) {
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .updateDropdownValues(
                                                          receiverEmailUser:
                                                              user);
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          receivedForEmployeeIdFocusNode);
                                                },
                                                roleName: ConstantUserRoles
                                                    .atomStaticUser,
                                                locationId:
                                                    state.model.location!.id!,
                                                functionToCall:
                                                    (BaseUser user) {
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .updateDropdownValues(
                                                          receiverEmailUser:
                                                              user);
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          receivedForEmployeeIdFocusNode);
                                                  // refresh the list
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .refreshList();
                                                },
                                              );
                                            }
                                          }),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.02),
                                    ],
                                  ),

                                  /// Received for
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.otherReceiverName ??
                                        state.labels?.defaultLocale
                                            .otherReceiverName ??
                                        Constants.receivedFor,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                  FlutterInputField(
                                    controller: receiverEmailController,
                                    textInputType: TextInputType.number,
                                    textFormKey:
                                        Keys.claimantEmpIdTextController,
                                    isEnable: false,
                                    isDisableColor: true,
                                    focusNode: receivedForEmployeeIdFocusNode,
                                    hintText: '',
                                    onChange: (String value) {
                                      // state.model.receiverEmployeeId = value;
                                      // context
                                      //     .read<MaterialMovementDetailsCubit>()
                                      //     .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ],

                                /// Receiver Department
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.receiverDepartment ??
                                      state.labels?.defaultLocale
                                          .receiverDepartment ??
                                      Constants.receiverDepartment,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                TextFieldAddButton(
                                  title: state.model.receiverDepartmenttName,
                                  height: 70,
                                  isDisableColor: isReadOnly ||state.model.status == ConstantsIntValue.mmStatusInwardPending||state.model.status == ConstantsIntValue.businessUserReview,
                                  onTap: () {
                                    if (!isReadOnly && state.model.status != ConstantsIntValue.mmStatusInwardPending && state.model.status != ConstantsIntValue.businessUserReview) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());

                                      BaseOrganisationDialog().departmentDialog(
                                          context: context,
                                          organisations: state.departments,
                                          onTap: (Organisation department) {
                                            state.model
                                                    .receiverDepartmenttName =
                                                department.name;

                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .updateDropdownValues(
                                                    receiverDepartment:
                                                        department);
                                            FocusScope.of(context).requestFocus(
                                                receivedByFocusNode);
                                          },
                                          orgName: 'EMPLOYEE_DEPARTMENTS',
                                          createEntity: false,
                                          title: 'Add Department',
                                          functionToCall: () {
                                            // refresh the list
                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .refreshList();
                                          });
                                      // leodepartmentsDialog(stat
                                    }
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                                if (state.model.originalReceiver == true) ...[
                                  /// Received by Employee Id
                                  Column(
                                    children: [
                                      CommonWidgets.textDisplay(
                                        state.labels?.locale
                                                .otherReceiverEmployeeId ??
                                            state.labels?.defaultLocale
                                                .otherReceiverEmployeeId ??
                                            Constants.receiverEmployeeId,
                                        Styles.textStyleWhite16,
                                        isMandatory: true,
                                      ),
                                      TextFieldAddButton(
                                          title: state.model.receiverEmployeeId,
                                          height: 70,
                                          isDisableColor: isReadOnly ||state.model.status == ConstantsIntValue.mmStatusInwardPending || state.model.status == ConstantsIntValue.businessUserReview,
                                          onTap: () {
                                            if (!isReadOnly && state.model.status != ConstantsIntValue.mmStatusInwardPending &&state.model.status != ConstantsIntValue.businessUserReview) {
                                              BaseOrganisationDialog()
                                                  .userDialog(
                                                employeeId: true,
                                                context: context,
                                                users:
                                                    state.receiverEmailUsers!,
                                                isDbUser: true,
                                                onTap: (BaseUser user) {
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .updateDropdownValues(
                                                          receiverEmailUser:
                                                              user);
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          receivedForEmployeeIdFocusNode);
                                                },
                                                roleName: ConstantUserRoles
                                                    .atomStaticUser,
                                                locationId:
                                                    state.model.location!.id!,
                                                functionToCall:
                                                    (BaseUser user) {
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .updateDropdownValues(
                                                          receiverEmailUser:
                                                              user);
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          receivedForEmployeeIdFocusNode);
                                                  // refresh the list
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .refreshList();
                                                },
                                              );
                                            }
                                          }),
                                    ],
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Received by
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.receiverName ??
                                        state.labels?.defaultLocale
                                            .receiverName ??
                                        Constants.receivedBy,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),

                                  FlutterInputField(
                                    controller: receiverEmailController,
                                    // initialValue: state.model.receiverEmail,
                                    textFormKey:
                                        Keys.claimantEmpIdTextController,
                                    isEnable: false,
                                    isDisableColor: true,
                                    hintText: '',
                                    focusNode: receivedByFocusNode,
                                    onChange: (String value) {
                                      // state.model.receiverEmail = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                ],
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                if (state.model.originalReceiver == false) ...[
                                  ///Received Employee Id
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale
                                            .otherReceiverEmployeeId ??
                                        state.labels?.defaultLocale
                                            .otherReceiverEmployeeId ??
                                        Constants.receiverEmployeeId,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                  FlutterInputField(
                                    initialValue:
                                        state.model.otherReceiverEmployeeId,
                                    textFormKey:
                                        Keys.claimantEmpIdTextController,
                                    isEnable: !isReadOnly && state.model.status != ConstantsIntValue.mmStatusInwardPending,
                                    isDisableColor: isReadOnly ||state.model.status == ConstantsIntValue.mmStatusInwardPending,
                                    textInputType: TextInputType.number,
                                    hintText: '',
                                    onChange: (String value) {
                                      state.model.otherReceiverEmployeeId =
                                          value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  ///Received By
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.receiverName ??
                                        state.labels?.defaultLocale
                                            .receiverName ??
                                        Constants.receivedBy,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                  FlutterInputField(
                                    initialValue: state.model.otherReceiverName,
                                    textFormKey:
                                        Keys.claimantEmpIdTextController,
                                    isEnable: !isReadOnly && state.model.status != ConstantsIntValue.mmStatusInwardPending,
                                    isDisableColor: isReadOnly,
                                    textInputType: TextInputType.text,
                                    hintText: '',
                                    onChange: (String value) {
                                      state.model.otherReceiverName = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ],

                                /// Receiver Signature test
                                buildSignature(
                                  controller: receiverSignatureController,
                                  label: state.labels?.locale.receiverSign ??
                                      state
                                          .labels?.defaultLocale.receiverSign ??
                                      Constants.receiverSignature,
                                  spaceHeight: height,
                                  state: state,
                                ),

                                /// Security Signature
                                buildSignature(
                                  controller: securitySignatureController,
                                  label:
                                      state.labels?.locale.entrySecuritySign ??
                                          state.labels?.defaultLocale
                                              .entrySecuritySign ??
                                          Constants.securitySignature,
                                  spaceHeight: height,
                                  state: state,
                                ),

                                /// Is Material Physically Checked
                                CommonWidgets.textDisplay(
                                  state.labels?.locale
                                          .materialPhysicallyChecked ??
                                      state.labels?.defaultLocale
                                          .materialPhysicallyChecked ??
                                      Constants.isPhysicallyChecked,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                RadioButtonsYesNo(
                                    status: state.model.status ?? 0,
                                    selectedValue:
                                        state.model.materialPhysicallyChecked
                                            ? 1
                                            : 0,
                                    onChangedYes: ((widget.model?.status == 6 ||
                                                widget.model?.status == 10 ||
                                                widget.model?.status == -1) ||
                                            !state.model.lock.isEmptyOrNull || state.model.status == ConstantsIntValue.mmStatusInwardPending ||state.model.status == ConstantsIntValue.businessUserReview)
                                        ? null
                                        : (val) {
                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .showFields(
                                              isMaterialPhysicallyChecked: true,
                                              // materialMovement: materialMovement,
                                            );
                                          },
                                    onChangedNo: widget.model?.status == 6 ||
                                            widget.model?.status == 10 ||
                                            widget.model?.status == -1 ||
                                            !state.model.lock.isEmptyOrNull ||state.model.status == ConstantsIntValue.mmStatusInwardPending ||state.model.status == ConstantsIntValue.businessUserReview
                                        ? null
                                        : (val) {
                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .showFields(
                                              isMaterialPhysicallyChecked:
                                                  false,
                                              // materialMovement: materialMovement,
                                            );
                                          }),

                                /// Comment
                                if (!state.model.materialPhysicallyChecked) ...[
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale
                                            .materialNotCheckedComment ??
                                        state.labels?.defaultLocale
                                            .materialNotCheckedComment ??
                                        Constants.comment,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),
                                  FlutterInputField(
                                    initialValue:
                                        state.model.materialNotCheckedComment,
                                    textFormKey:
                                        Keys.claimantEmpIdTextController,
                                    hintText: '',
                                    isEnable: state.model.status == 0 ||
                                        state.model.status == null,
                                    isDisableColor: state.model.status != 0 &&
                                        state.model.status != null,
                                    onChange: (String value) {
                                      state.model.materialNotCheckedComment =
                                          value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ],
                                // if (state.model.returnable == true) ...[
                                //   /// Expected Date Of Return
                                //   CommonWidgets.textDisplay(
                                //     state.labels?.locale.expectedDateOfReturn ??
                                //         state.labels?.defaultLocale
                                //             .expectedDateOfReturn ??
                                //         Constants.expectedDateOfReturn,
                                //     Styles.textStyleWhite16,
                                //     isMandatory:  true,
                                //   ),
                                //   CommonWidgets.verticalSpacerWidget(
                                //       height * 0.001),
                                //   // datecreateWidgetdisplay(
                                //   //     state.model.expectedDateOfReturn ?? ''),
                                //   BaseDate().datePickerWidgetLoading(
                                //     showPastDate: false,
                                //     textController:
                                //         expectedDateOfReturnController,
                                //     onlyDate: true,
                                //     fromDate: null,
                                //     isDisabled: (!showSaveSubmitButtons ||
                                //             state.model.status ==
                                //                 ConstantsIntValue
                                //                     .mmStatusClosed ||
                                //             state.model.status ==
                                //                 ConstantsIntValue
                                //                     .mmStatusApproved ||
                                //             lock) && state.model.status !=
                                //         ConstantsIntValue
                                //             .mmStatusOverDue
                                //         ? true
                                //         : false,
                                //     // isDisabled: true,
                                //     onChange: (String value) {
                                //       state.model.expectedDateOfReturn =
                                //           Utils().formatTime(value);
                                //       BlocProvider.of<
                                //                   MaterialMovementDetailsCubit>(
                                //               context)
                                //           .onModelValueChange(state.model);
                                //     },
                                //     context: context,
                                //   ),
                                //   CommonWidgets.verticalSpacerWidget(
                                //       height * 0.02),
                                // ],
                              ],

                              if ((!widget.isInward) ||
                                  (state.model.returnable == true &&
                                      widget.isInward &&
                                      state.model.status != 0 &&
                                      state.model.status != null)) ...[
                                /// Requester 1 Employee Id
                                Column(
                                  children: [
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.requestorEmployeeId ??
                                          state.labels?.defaultLocale
                                              .requestorEmployeeId ??
                                          Constants.requestor1EmployeeId,
                                      Styles.textStyleWhite16,
                                      isMandatory: true,
                                    ),
                                    TextFieldAddButton(
                                        title: state.model.requestorEmployeeId,
                                        height: 70,
                                        // isDisableColor: (state.model.status ==
                                        //             10 ||
                                        //         state.model.status == -1 ||
                                        //         state.model.status == 6 ||
                                        //         state.model.status == 2 ||
                                        //         state.model.status == 3 ||
                                        //         state.model.status == 4 ||
                                        //         state.model.status == 5 ||
                                        //         state.model.status == 1 ||
                                        //         state.model.status == 7 ||
                                        //         state.model.status ==
                                        //             ConstantsIntValue
                                        //                 .mmStatusInwardWaiting) ||
                                        //     lock,
                                        isDisableColor:
                                        ((isApproverRequesterEmailDepartment &&
                                            !lock) ||
                                            (state.model.returnable ==
                                                true &&
                                                widget.isInward &&
                                                (state.model.status ==
                                                    11 ||
                                                    state.model
                                                        .status ==
                                                        12))
                                            ? false
                                            : true),
                                        onTap: () {
                                          if ((isApproverRequesterEmailDepartment &&
                                              !lock) ||
                                              (state.model.returnable ==
                                                  true &&
                                                  widget.isInward &&
                                                  state.model.status ==
                                                      12 ||
                                                  state.model.status == 11)
                                              ? true
                                              : false) {
                                            BaseOrganisationDialog().userDialog(
                                              employeeId: false,
                                              context: context,
                                              users: state.requestorEmailUsers!,
                                              isDbUser: true,
                                              onTap: (BaseUser user) {
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateApproverEmailsValue(
                                                        requesterEmailUser:
                                                            user);
                                                FocusScope.of(context).requestFocus(
                                                    requestorEmployeeIdFocusNode);
                                              },
                                              roleName: ConstantUserRoles
                                                  .atomStaticUser,
                                              locationId:
                                                  state.model.location!.id!,
                                              functionToCall: (BaseUser user) {
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateApproverEmailsValue(
                                                        requesterEmailUser:
                                                            user);
                                                FocusScope.of(context).requestFocus(
                                                    requestorEmployeeIdFocusNode);

                                                // refresh the list
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .refreshList();
                                              },
                                            );
                                          }
                                        })
                                  ],
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Requestor 1 Email
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.requestorEmail ??
                                      state.labels?.defaultLocale
                                          .requestorEmail ??
                                      Constants.requestor1EmployeeId,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                FlutterInputField(
                                  controller: requesterEmailController,
                                  textInputType: TextInputType.number,
                                  textFormKey: Keys.requestorEmployeeKey,
                                  hintText: '',
                                  focusNode: requestorEmployeeIdFocusNode,
                                  isEnable: false,
                                  isDisableColor: true,
                                  onChange: (String value) {
                                    state.model.requestorEmployeeId = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Requester 1 Department
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.requestorDepartment ??
                                      state.labels?.defaultLocale
                                          .requestorDepartment ??
                                      Constants.requestor1Department,
                                  Styles.textStyleWhite16,
                                  isMandatory: state.model.status !=
                                              ConstantsIntValue.mmStatusDraft &&
                                          widget.model != null
                                      ? true
                                      : false,
                                ),
                                TextFieldAddButton(
                                  title: state.model.requestorDepartment?.name,
                                  height: 70,
                                  isDisableColor: state.model.status == 10 ||
                                          state.model.status == -1 ||
                                          state.model.status == 6 ||
                                          state.model.status == 2 ||
                                          state.model.status == 3 ||
                                          state.model.status == 4 ||
                                          !showSaveSubmitButtons ||
                                          state.model.status ==
                                              ConstantsIntValue
                                                  .mmStatusInwardWaiting ||
                                          !state.model.lock.isEmptyOrNull
                                      ? true
                                      : false,
                                  onTap: () {
                                    if (state.model.status == 6 ||
                                            state.model.status == 10 ||
                                            state.model.status == -1 ||
                                            state.model.status == 2 ||
                                            state.model.status == 3 ||
                                            state.model.status == 4 ||
                                            state.model.status ==
                                                ConstantsIntValue
                                                    .mmStatusInwardWaiting ||
                                            !state.model.lock.isEmptyOrNull
                                        ? false
                                        : true) {
                                      BaseOrganisationDialog().departmentDialog(
                                          context: context,
                                          organisations: state.departments,
                                          onTap: (Organisation department) {
                                            state.model.requestorDepartment
                                                ?.name = department.name;

                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .updateDropdownValues(
                                                    requesterDepartment:
                                                        department);
                                          },
                                          orgName: 'EMPLOYEE_DEPARTMENTS',
                                          createEntity: false,
                                          title: 'Add Key Type',
                                          functionToCall: () {
                                            // refresh the list
                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .refreshList();
                                          });
                                      FocusScope.of(context)
                                          .requestFocus(sentToFocusNode);
                                    }
                                  },
                                ),

                                // dbwanttodepartmentaddButtonwidgetLoading(state),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Requester 2 Employee Id
                                Column(
                                  children: [
                                    CommonWidgets.textDisplay(
                                      // state.labels?.locale.requestorEmployeeId ??
                                      //     state.labels?.defaultLocale
                                      //         .requestorEmployeeId ??
                                      Constants.requestor2EmployeeId,
                                      Styles.textStyleWhite16,
                                      isMandatory: true,
                                    ),
                                    TextFieldAddButton(
                                        title: state.model.requestor2EmployeeId,
                                        height: 70,
                                        // isDisableColor: (state.model.status ==
                                        //             10 ||
                                        //         state.model.status == -1 ||
                                        //         state.model.status == 6 ||
                                        //         state.model.status == 2 ||
                                        //         state.model.status == 3 ||
                                        //         state.model.status == 4 ||
                                        //         state.model.status == 5 ||
                                        //         state.model.status == 1 ||
                                        //         state.model.status == 7 ||
                                        //         state.model.status ==
                                        //             ConstantsIntValue
                                        //                 .mmStatusInwardWaiting) ||
                                        //     lock,
                                        isDisableColor:
                                        ((isApproverRequesterEmailDepartment &&
                                            !lock) ||
                                            (state.model.returnable ==
                                                true &&
                                                widget.isInward &&
                                                (state.model.status ==
                                                    11 ||
                                                    state.model
                                                        .status ==
                                                        12))
                                            ? false
                                            : true),
                                        onTap: () {
                                          if ((isApproverRequesterEmailDepartment &&
                                                      !lock) ||
                                                  (state.model.returnable ==
                                                              true &&
                                                          widget.isInward &&
                                                          state.model.status ==
                                                              12 ||
                                                      state.model.status == 11)
                                              ? true
                                              : false) {
                                            BaseOrganisationDialog().userDialog(
                                              employeeId: false,
                                              context: context,
                                              users: state.requestorEmailUsers!,
                                              isDbUser: true,
                                              onTap: (BaseUser user) {
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateApproverEmailsValue(
                                                        requester2EmailUser:
                                                            user);
                                                FocusScope.of(context).requestFocus(
                                                    requestorEmployeeIdFocusNode);
                                              },
                                              roleName: ConstantUserRoles
                                                  .atomStaticUser,
                                              locationId:
                                                  state.model.location!.id!,
                                              functionToCall: (BaseUser user) {
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateApproverEmailsValue(
                                                        requester2EmailUser:
                                                            user);
                                                FocusScope.of(context).requestFocus(
                                                    requestorEmployeeIdFocusNode);

                                                // refresh the list
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .refreshList();
                                              },
                                            );
                                          }
                                        })
                                  ],
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Requestor 2 Email
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.requestorEmail ??
                                  //     state
                                  //         .labels?.defaultLocale.requestorEmail ??
                                  Constants.requestor2Email,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                FlutterInputField(
                                  controller: requester2EmailController,
                                  textInputType: TextInputType.number,
                                  textFormKey: Keys.requestorEmployeeKey,
                                  hintText: '',
                                  focusNode: requestorEmployeeIdFocusNode,
                                  isEnable: false,
                                  isDisableColor: true,
                                  onChange: (String value) {
                                    state.model.requestor2EmployeeId = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Requester 2 Department
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.requestorDepartment ??
                                  //     state.labels?.defaultLocale
                                  //         .requestorDepartment ??
                                  Constants.requestor2Department,
                                  Styles.textStyleWhite16,
                                  isMandatory: state.model.status !=
                                              ConstantsIntValue.mmStatusDraft &&
                                          widget.model != null
                                      ? true
                                      : false,
                                ),
                                TextFieldAddButton(
                                  title: state.model.requestor2Department?.name,
                                  height: 70,
                                  isDisableColor: state.model.status == 10 ||
                                          state.model.status == -1 ||
                                          state.model.status == 6 ||
                                          state.model.status == 2 ||
                                          state.model.status == 3 ||
                                          state.model.status == 4 ||
                                          !showSaveSubmitButtons ||
                                          state.model.status ==
                                              ConstantsIntValue
                                                  .mmStatusInwardWaiting ||
                                          !state.model.lock.isEmptyOrNull
                                      ? true
                                      : false,
                                  onTap: () {
                                    if (state.model.status == 6 ||
                                            state.model.status == 10 ||
                                            state.model.status == -1 ||
                                            state.model.status == 2 ||
                                            state.model.status == 3 ||
                                            state.model.status == 4 ||
                                            state.model.status ==
                                                ConstantsIntValue
                                                    .mmStatusInwardWaiting ||
                                            !state.model.lock.isEmptyOrNull
                                        ? false
                                        : true) {
                                      BaseOrganisationDialog().departmentDialog(
                                          context: context,
                                          organisations: state.departments,
                                          onTap: (Organisation department) {
                                            state.model.requestor2Department
                                                ?.name = department.name;

                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .updateDropdownValues(
                                                    requester2Department:
                                                        department);
                                          },
                                          orgName: 'EMPLOYEE_DEPARTMENTS',
                                          createEntity: false,
                                          title: 'Add Key Type',
                                          functionToCall: () {
                                            // refresh the list
                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .refreshList();
                                          });
                                      FocusScope.of(context)
                                          .requestFocus(sentToFocusNode);
                                    }
                                  },
                                ),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                if (widget.isInward == false) ...[
                                  // /// Sent To
                                  // CommonWidgets.textDisplay(
                                  //   state.labels?.locale.sentTo ??
                                  //       state.labels?.defaultLocale.sentTo ??
                                  //       Constants.sentTo,
                                  //   Styles.textStyleWhite16,
                                  //   isMandatory: state.model.status !=
                                  //               ConstantsIntValue
                                  //                   .mmStatusDraft &&
                                  //           widget.model != null
                                  //       ? true
                                  //       : false,
                                  // ),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //     height * 0.001),
                                  //
                                  // FlutterInputField(
                                  //   textInputType: TextInputType.text,
                                  //   initialValue: state.model.sentTo,
                                  //   textFormKey: Keys.sentToKey,
                                  //   hintText: '',
                                  //   focusNode: sentToFocusNode,
                                  //   isEnable: state.model.status == 10 ||
                                  //           state.model.status == -1 ||
                                  //           state.model.status == 6 ||
                                  //           state.model.status == 2 ||
                                  //           state.model.status == 3 ||
                                  //           state.model.status == 4 ||
                                  //           state.model.status ==
                                  //               ConstantsIntValue
                                  //                   .mmStatusInwardWaiting ||
                                  //           isReadOnly ||
                                  //           !showSaveSubmitButtons
                                  //       ? false
                                  //       : true,
                                  //   isDisableColor: state.model.status == 10 ||
                                  //           state.model.status == -1 ||
                                  //           state.model.status == 6 ||
                                  //           state.model.status == 2 ||
                                  //           state.model.status == 3 ||
                                  //           state.model.status == 4 ||
                                  //           !showSaveSubmitButtons ||
                                  //           state.model.status ==
                                  //               ConstantsIntValue
                                  //                   .mmStatusInwardWaiting ||
                                  //           !state.model.lock.isEmptyOrNull
                                  //       ? true
                                  //       : false,
                                  //   onChange: (String value) {
                                  //     state.model.sentTo = value;
                                  //     context
                                  //         .read<MaterialMovementDetailsCubit>()
                                  //         .onModelValueChange(state.model);
                                  //   },
                                  //   validateTextField: (String? user) {},
                                  // ),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //     height * 0.02),

                                  /// Purpose
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.purpose ??
                                        state.labels?.defaultLocale.purpose ??
                                        Constants.purpose,
                                    Styles.textStyleWhite16,
                                    isMandatory: state.model.status !=
                                                ConstantsIntValue
                                                    .mmStatusDraft &&
                                            widget.model != null
                                        ? true
                                        : false,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  FlutterInputField(
                                    textInputType: TextInputType.text,
                                    initialValue: state.model.purpose,
                                    textFormKey: Keys.purposeKey,
                                    hintText: '',
                                    isEnable: state.model.status == 10 ||
                                            state.model.status == -1 ||
                                            state.model.status == 6 ||
                                            state.model.status == 2 ||
                                            state.model.status == 3 ||
                                            state.model.status == 4 ||
                                            state.model.status ==
                                                ConstantsIntValue
                                                    .mmStatusInwardWaiting ||
                                            !showSaveSubmitButtons ||
                                            isReadOnly
                                        ? false
                                        : true,
                                    isDisableColor: state.model.status == 10 ||
                                            state.model.status == -1 ||
                                            state.model.status == 6 ||
                                            state.model.status == 2 ||
                                            state.model.status == 3 ||
                                            state.model.status == 4 ||
                                            !showSaveSubmitButtons ||
                                            state.model.status ==
                                                ConstantsIntValue
                                                    .mmStatusInwardWaiting ||
                                            !state.model.lock.isEmptyOrNull
                                        ? true
                                        : false,
                                    onChange: (String value) {
                                      state.model.purpose = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Prepared By
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.preparedBy ??
                                        state
                                            .labels?.defaultLocale.preparedBy ??
                                        Constants.preparedBy,
                                    Styles.textStyleWhite16,
                                    isMandatory: state.model.status !=
                                                ConstantsIntValue
                                                    .mmStatusDraft &&
                                            widget.model != null
                                        ? true
                                        : false,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  FlutterInputField(
                                    // keyboardType: TextInputType.number,
                                    initialValue: state.model.preparedBy,
                                    textFormKey: Keys.preparedByKey,
                                    hintText: '',
                                    isEnable: state.model.status == 10 ||
                                            state.model.status == -1 ||
                                            state.model.status == 6 ||
                                            state.model.status == 2 ||
                                            state.model.status == 3 ||
                                            state.model.status == 4 ||
                                            state.model.status ==
                                                ConstantsIntValue
                                                    .mmStatusInwardWaiting ||
                                            !showSaveSubmitButtons ||
                                            isReadOnly
                                        ? false
                                        : true,
                                    isDisableColor: state.model.status == 10 ||
                                            state.model.status == -1 ||
                                            state.model.status == 6 ||
                                            state.model.status == 2 ||
                                            state.model.status == 3 ||
                                            state.model.status == 4 ||
                                            !showSaveSubmitButtons ||
                                            state.model.status ==
                                                ConstantsIntValue
                                                    .mmStatusInwardWaiting ||
                                            !state.model.lock.isEmptyOrNull
                                        ? true
                                        : false,
                                    onChange: (String value) {
                                      state.model.preparedBy = value;
                                      BlocProvider.of<
                                                  MaterialMovementDetailsCubit>(
                                              context)
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Prepared By Department
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.preparedByDepartment ??
                                        state.labels?.defaultLocale
                                            .preparedByDepartment ??
                                        Constants.preparedByDepartment,
                                    Styles.textStyleWhite16,
                                    isMandatory: state.model.status !=
                                                ConstantsIntValue
                                                    .mmStatusDraft &&
                                            widget.model != null
                                        ? true
                                        : false,
                                  ),
                                  TextFieldAddButton(
                                    title:
                                        state.model.preparedByDepartment?.name,
                                    height: 70,
                                    isDisableColor: state.model.status == 10 ||
                                            state.model.status == -1 ||
                                            state.model.status == 6 ||
                                            state.model.status == 2 ||
                                            state.model.status == 3 ||
                                            state.model.status == 4 ||
                                            !showSaveSubmitButtons ||
                                            state.model.status ==
                                                ConstantsIntValue
                                                    .mmStatusInwardWaiting ||
                                            !state.model.lock.isEmptyOrNull
                                        ? true
                                        : false,
                                    onTap: () {
                                      if ((state.model.status == 6 ||
                                              state.model.status == -1 ||
                                              state.model.status == 10 ||
                                              state.model.status == 2 ||
                                              state.model.status == 3 ||
                                              state.model.status == 4 ||
                                              state.model.status ==
                                                  ConstantsIntValue
                                                      .mmStatusInwardWaiting ||
                                              isReadOnly)
                                          ? false
                                          : true) {
                                        BaseOrganisationDialog()
                                            .departmentDialog(
                                                context: context,
                                                organisations:
                                                    state.departments,
                                                onTap:
                                                    (Organisation department) {
                                                  state
                                                      .model
                                                      .preparedByDepartment
                                                      ?.name = department.name;

                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .updateDropdownValues(
                                                          preparedByDepartment:
                                                              department);
                                                },
                                                orgName: 'EMPLOYEE_DEPARTMENTS',
                                                createEntity: false,
                                                title: 'Add Department',
                                                functionToCall: () {
                                                  // refresh the list
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .refreshList();
                                                });
                                        // leodepartmentsDialog(state);
                                      }
                                    },
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ],

                                /// Approver1 Email
                                Column(
                                  children: [
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.approver1Email ??
                                          state.labels?.defaultLocale
                                              .approver1Email ??
                                          Constants.approver1Email,
                                      Styles.textStyleWhite16,
                                      isMandatory: true,
                                    ),
                                    TextFieldAddButton(
                                        title: state.model.approver1Email,
                                        height: 70,
                                        // isDisableColor: (state.model.status ==
                                        //                 6 ||
                                        //             state.model.status == -1 ||
                                        //             state.model.status == 10 ||
                                        //             state.model.status == 2 ||
                                        //             state.model.status == 3 ||
                                        //             state.model.status == 4 ||
                                        //             state.model.status == 5 ||
                                        //             state.model.status == 1 ||
                                        //             state.model.status == 7 ||
                                        //             state.model.status ==
                                        //                 ConstantsIntValue
                                        //                     .mmStatusInwardWaiting) ||
                                        //         lock
                                        //     ? true
                                        //     : false,
                                        isDisableColor:
                                        ((isApproverRequesterEmailDepartment &&
                                            !lock) ||
                                            (state.model.returnable ==
                                                true &&
                                                widget.isInward &&
                                                (state.model.status ==
                                                    11 ||
                                                    state.model
                                                        .status ==
                                                        12))
                                            ? false
                                            : true),
                                        onTap: () {
                                          if ((isApproverRequesterEmailDepartment &&
                                                      !lock) ||
                                                  (state.model.returnable ==
                                                              true &&
                                                          widget.isInward &&
                                                          state.model.status ==
                                                              12 ||
                                                      state.model.status == 11)
                                              ? true
                                              : false) {
                                            BaseOrganisationDialog().userDialog(
                                              context: context,
                                              users: state.approver1Users!,
                                              isDbUser: true,
                                              onTap: (BaseUser user) {
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateApproverEmailsValue(
                                                        approver1EmailUser:
                                                            user);
                                              },
                                              roleName: ConstantUserRoles
                                                  .atomStaticUser,
                                              locationId:
                                                  state.model.location!.id!,
                                              functionToCall: (BaseUser user) {
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateApproverEmailsValue(
                                                        approver1EmailUser:
                                                            user);
                                                // refresh the list
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .refreshList();
                                              },
                                            );
                                          }
                                        })
                                  ],
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Approver1 By Department
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.approver1Department ??
                                      state.labels?.defaultLocale
                                          .approver1Department ??
                                      Constants.approver1Department,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                TextFieldAddButton(
                                  title: state.model.approver1Department?.name,
                                  height: 70,
                                  // isDisableColor: (state.model.status == 6 ||
                                  //             state.model.status == -1 ||
                                  //             state.model.status == 10 ||
                                  //             state.model.status == 2 ||
                                  //             state.model.status == 3 ||
                                  //             state.model.status == 4 ||
                                  //             state.model.status == 5 ||
                                  //             state.model.status == 1 ||
                                  //             state.model.status == 7 ||
                                  //             state.model.status ==
                                  //                 ConstantsIntValue
                                  //                     .mmStatusInwardWaiting) ||
                                  //         lock
                                  //     ? true
                                  //     : false,
                                  isDisableColor: ((isApproverRequesterEmailDepartment &&
                                      !lock) ||
                                      (state.model.returnable ==
                                          true &&
                                          widget.isInward &&
                                          (state.model.status ==
                                              11 ||
                                              state.model
                                                  .status ==
                                                  12))
                                      ? false
                                      : true),
                                  onTap: () {
                                    if ((isApproverRequesterEmailDepartment &&
                                                !lock) ||
                                            (state.model.returnable == true &&
                                                    widget.isInward &&
                                                    state.model.status == 12 ||
                                                state.model.status == 11)
                                        ? true
                                        : false) {
                                      BaseOrganisationDialog().departmentDialog(
                                          context: context,
                                          organisations: state.departments,
                                          onTap: (Organisation department) {
                                            state.model.approver1Department
                                                ?.name = department.name;

                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .updateDropdownValues(
                                                    approver1Department:
                                                        department);
                                          },
                                          orgName: 'EMPLOYEE_DEPARTMENTS',
                                          createEntity: false,
                                          title: 'Add Department',
                                          functionToCall: () {
                                            // refresh the list
                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .refreshList();
                                          });
                                      // leodepartmentsDialog(state);
                                    }
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Approver2 Email
                                Column(
                                  children: [
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.approver2Email ??
                                          state.labels?.defaultLocale
                                              .approver2Email ??
                                          Constants.approver2Email,
                                      Styles.textStyleWhite16,
                                      isMandatory: true,
                                    ),
                                    TextFieldAddButton(
                                        title: state.model.approver2Email,
                                        height: 70,
                                        // isDisableColor: (state.model.status ==
                                        //                 6 ||
                                        //             state.model.status == 10 ||
                                        //             state.model.status == -1 ||
                                        //             state.model.status == 2 ||
                                        //             state.model.status == 3 ||
                                        //             state.model.status == 4 ||
                                        //             state.model.status == 5 ||
                                        //             state.model.status == 1 ||
                                        //             state.model.status == 7 ||
                                        //             state.model.status ==
                                        //                 ConstantsIntValue
                                        //                     .mmStatusInwardWaiting) ||
                                        //         lock
                                        //     ? true
                                        //     : false,
                                        isDisableColor:  ((isApproverRequesterEmailDepartment &&
                                            !lock) ||
                                            (state.model.returnable ==
                                                true &&
                                                widget.isInward &&
                                                (state.model.status ==
                                                    11 ||
                                                    state.model
                                                        .status ==
                                                        12))
                                            ? false
                                            : true),
                                        onTap: () {
                                          if ((isApproverRequesterEmailDepartment &&
                                                      !lock) ||
                                                  (state.model.returnable ==
                                                          true &&
                                                      widget.isInward &&
                                                      (state.model.status ==
                                                              11 ||
                                                          state.model.status ==
                                                              12))
                                              ? true
                                              : false) {
                                            BaseOrganisationDialog().userDialog(
                                              context: context,
                                              users: state.approver2Users!,
                                              isDbUser: true,
                                              onTap: (BaseUser user) {
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateApproverEmailsValue(
                                                        approver2EmailUser:
                                                            user);
                                              },
                                              roleName: ConstantUserRoles
                                                  .atomStaticUser,
                                              locationId:
                                                  state.model.location!.id!,
                                              functionToCall: (BaseUser user) {
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateApproverEmailsValue(
                                                        approver2EmailUser:
                                                            user);
                                                // refresh the list
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .refreshList();
                                              },
                                            );
                                          }
                                        })
                                  ],
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Approver2 By Department
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.approver2Department ??
                                      state.labels?.defaultLocale
                                          .approver2Department ??
                                      Constants.approver2Department,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                TextFieldAddButton(
                                  title: state.model.approver2Department?.name,
                                  height: 70,
                                  // isDisableColor: (state.model.status == 6 ||
                                  //             state.model.status == 10 ||
                                  //             state.model.status == -1 ||
                                  //             state.model.status == 2 ||
                                  //             state.model.status == 3 ||
                                  //             state.model.status == 4 ||
                                  //             state.model.status == 5 ||
                                  //             state.model.status == 1 ||
                                  //             state.model.status == 7 ||
                                  //             state.model.status ==
                                  //                 ConstantsIntValue
                                  //                     .mmStatusInwardWaiting) ||
                                  //         lock
                                  //     ? true
                                  //     : false,
                                  isDisableColor:  ((isApproverRequesterEmailDepartment &&
                                      !lock) ||
                                      (state.model.returnable ==
                                          true &&
                                          widget.isInward &&
                                          (state.model.status ==
                                              11 ||
                                              state.model
                                                  .status ==
                                                  12))
                                      ? false
                                      : true),
                                  onTap: () {
                                    if ((isApproverRequesterEmailDepartment &&
                                                !lock) ||
                                            (state.model.returnable == true &&
                                                widget.isInward &&
                                                (state.model.status == 11 ||
                                                    state.model.status == 12))
                                        ? true
                                        : false) {
                                      BaseOrganisationDialog().departmentDialog(
                                          context: context,
                                          organisations: state.departments,
                                          onTap: (Organisation department) {
                                            state.model.approver2Department
                                                ?.name = department.name;

                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .updateDropdownValues(
                                                    approver2Department:
                                                        department);
                                          },
                                          orgName: 'EMPLOYEE_DEPARTMENTS',
                                          createEntity: false,
                                          title: 'Add Department',
                                          functionToCall: () {
                                            // refresh the list
                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .refreshList();
                                          });
                                      // leodepartmentsDialog(state);
                                    }
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                if (state.model.status == 5) ...[
                                  /// Rejection Comment
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.rejectionComment ??
                                        state.labels?.defaultLocale
                                            .rejectionComment ??
                                        Constants.rejectionComment,
                                    Styles.textStyleWhite16,
                                    isMandatory:
                                        widget.model == null ? false : true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  FlutterInputField(
                                    textInputType: TextInputType.text,
                                    initialValue: state.model.rejectionComment,
                                    textFormKey: Keys.purposeKey,
                                    hintText: '',
                                    isEnable: false,
                                    isDisableColor: true,
                                    onChange: (String value) {
                                      state.model.rejectionComment = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Rejected By
                                  CommonWidgets.horizentaltextHandling(
                                      state.labels?.locale.rejectedBy ??
                                          state.labels?.defaultLocale
                                              .rejectedBy ??
                                          Constants.rejectedBy,
                                      isMandatory: true,
                                      '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Rejected Date
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.rejectedDate ??
                                        state.labels?.defaultLocale
                                            .rejectedDate ??
                                        Constants.rejectedDate,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  datecreateWidgetdisplay(
                                      state.model.rejectedDate ?? ''),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                  //],
                                ],

                                /// If Status is Approved(status=6), Inward Pending(status=9), Submitted(status=2)
                                if (state.model.status == 6 ||
                                    state.model.status == 9 ||
                                    state.model.status == 2 ||
                                    state.model.status == 10) ...[
                                  /// If Status is Approved(status=6) and Inward Pending(status=9)
                                  if (state.model.status == 6 ||
                                      state.model.status == 9 ||
                                      state.model.status == 10) ...[
                                    /// Approved By
                                    CommonWidgets.horizentaltextHandling(
                                        state.labels?.locale.approvedBy ??
                                            state.labels?.defaultLocale
                                                .approvedBy ??
                                            Constants.approvedBy,
                                        state.model.approvedBy ?? ''),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Approved Date

                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.approvedDate ??
                                          state.labels?.defaultLocale
                                              .approvedDate ??
                                          Constants.dateofcreation,
                                      Styles.textStyleWhite16,
                                      isMandatory: true,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    datecreateWidgetdisplay(
                                        state.model.approvedDate ?? ''),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Taken Out By
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.takenOutName ??
                                          state.labels?.defaultLocale
                                              .takenOutName ??
                                          Constants.takenOutBy,
                                      Styles.textStyleWhite16,
                                      isMandatory: true,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),

                                    FlutterInputField(
                                      initialValue: state.model.takenOutEmail,
                                      textFormKey: Keys.takenOutByKey,
                                      hintText: '',
                                      isEnable: showSaveSubmitButtons &&
                                          state.model.status !=
                                              ConstantsIntValue
                                                  .mmStatusClosed &&
                                          state.model.status !=
                                              ConstantsIntValue
                                                  .mmStatusInwardWaiting,
                                      isDisableColor: !showSaveSubmitButtons,
                                      onChange: (String value) {
                                        state.model.takenOutEmail = value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(state.model);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.02),

                                    /// Taken Out By Contact No.
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.takenOutContactNo ??
                                          state.labels?.defaultLocale
                                              .takenOutContactNo ??
                                          Constants.takenOutByContactNo,
                                      Styles.textStyleWhite16,
                                      isMandatory: true,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),

                                    FlutterInputField(
                                      initialValue:
                                          state.model.takenOutContactNo,
                                      textFormKey: Keys.takenOutContactKey,
                                      hintText: '',
                                      textInputType: TextInputType.number,
                                      characterLimit:
                                          Constants.characterLimitContactNo,
                                      isEnable: showSaveSubmitButtons &&
                                          state.model.status !=
                                              ConstantsIntValue
                                                  .mmStatusClosed &&
                                          state.model.status !=
                                              ConstantsIntValue
                                                  .mmStatusInwardWaiting,
                                      isDisableColor:
                                          showSaveSubmitButtons ? false : true,
                                      onChange: (String value) {
                                        state.model.takenOutContactNo = value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(state.model);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.02),

                                    /// Taken Out Address
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.takenOutAddress ??
                                          state.labels?.defaultLocale
                                              .takenOutAddress ??
                                          Constants.takenOutAddress,
                                      Styles.textStyleWhite16,
                                      isMandatory: true,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),

                                    FlutterInputField(
                                      initialValue: state.model.takenOutAddress,
                                      textFormKey: Keys.takenOutAddressKey,
                                      hintText: '',
                                      showBorder: false,
                                      isEnable: showSaveSubmitButtons &&
                                          state.model.status !=
                                              ConstantsIntValue
                                                  .mmStatusClosed &&
                                          state.model.status !=
                                              ConstantsIntValue
                                                  .mmStatusInwardWaiting,
                                      isDisableColor:
                                          showSaveSubmitButtons ? false : true,
                                      onChange: (String value) {
                                        state.model.takenOutAddress = value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(state.model);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.02),

                                    //if (state.materialMovement.status == 2 && state.isInward == false) ...[
                                    /// Taken Out On
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.takenOutDate ??
                                          state.labels?.defaultLocale
                                              .takenOutDate ??
                                          Constants.takenOutOn,
                                      Styles.textStyleWhite16,
                                      isMandatory: true,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),

                                    BaseDate().datePickerWidgetLoading(
                                      textController: takenOutOnDateController,
                                      isDisabled: showSaveSubmitButtons &&
                                              state.model.status !=
                                                  ConstantsIntValue
                                                      .mmStatusClosed &&
                                              state.model.status !=
                                                  ConstantsIntValue
                                                      .mmStatusInwardWaiting
                                          ? false
                                          : true,
                                      onlyDate: false,
                                      showFutureDate: false,
                                      showPastDate: false,
                                      onChange: (String value) {
                                        state.model.takenOutDate =
                                            Utils().formatTime(value);
                                        BlocProvider.of<
                                                    MaterialMovementDetailsCubit>(
                                                context)
                                            .onModelValueChange(state.model);
                                      },
                                      context: context,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.02),
                                  ],
                                ],

                                /// If Status is Rejected(status=7)
                                if (state.model.status == 7) ...[
                                  /// Rejected By
                                  CommonWidgets.horizentaltextHandling(
                                      state.labels?.locale.rejectedBy ??
                                          state.labels?.defaultLocale
                                              .rejectedBy ??
                                          Constants.rejectedBy,
                                      state.model.rejectedBy ?? ''),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Rejected Date
                                  CommonWidgets.horizentaltextHandling(
                                      state.labels?.locale.rejectedDate ??
                                          state.labels?.defaultLocale
                                              .rejectedDate ??
                                          Constants.rejectedDate,
                                      state.model.rejectedDate ?? ''),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Rejected Comment
                                  CommonWidgets.horizentaltextHandling(
                                      state.labels?.locale.rejectionComment ??
                                          state.labels?.defaultLocale
                                              .rejectionComment ??
                                          Constants.rejectedComment,
                                      state.model.rejectionComment ?? ''),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                ],
                              ],

                              if (!widget.isInward &&
                                  (widget.model?.status ==
                                          ConstantsIntValue.mmStatusApproved ||
                                      widget.model?.status ==
                                          ConstantsIntValue
                                              .mmStatusInwardWaiting ||
                                      widget.model?.status ==
                                          ConstantsIntValue
                                              .mmStatusClosed)) ...[
                                /// Is Material Physically Checked
                                CommonWidgets.textDisplay(
                                  state.labels?.locale
                                          .materialPhysicallyChecked ??
                                      state.labels?.defaultLocale
                                          .materialPhysicallyChecked ??
                                      Constants.isPhysicallyChecked,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                RadioButtonsYesNo(
                                    status: state.model.status ?? 0,
                                    selectedValue:
                                        state.model.materialPhysicallyChecked
                                            ? 1
                                            : 0,
                                    onChangedYes: (widget.model?.status !=
                                                ConstantsIntValue
                                                    .mmStatusApproved ||
                                            !state.model.lock.isEmptyOrNull)
                                        ? null
                                        : (val) {
                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .showFields(
                                              isMaterialPhysicallyChecked: true,
                                              // materialMovement: materialMovement,
                                            );
                                          },
                                    onChangedNo: widget.model?.status !=
                                                ConstantsIntValue
                                                    .mmStatusApproved ||
                                            !state.model.lock.isEmptyOrNull
                                        ? null
                                        : (val) {
                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .showFields(
                                              isMaterialPhysicallyChecked:
                                                  false,
                                              // materialMovement: materialMovement,
                                            );
                                          }),

                                /// Comment
                                if (!state.model.materialPhysicallyChecked) ...[
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale
                                            .materialNotCheckedComment ??
                                        state.labels?.defaultLocale
                                            .materialNotCheckedComment ??
                                        Constants.comment,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),
                                  FlutterInputField(
                                    initialValue:
                                        state.model.materialNotCheckedComment,
                                    textFormKey:
                                        Keys.claimantEmpIdTextController,
                                    hintText: '',
                                    isEnable: state.model.status == 6,
                                    isDisableColor:
                                        showSaveSubmitButtons ? false : true,
                                    onChange: (String value) {
                                      state.model.materialNotCheckedComment =
                                          value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ],

                                /// Security Signature
                                buildSignature(
                                  controller: securitySignatureController,
                                  label:
                                      state.labels?.locale.entrySecuritySign ??
                                          state.labels?.defaultLocale
                                              .entrySecuritySign ??
                                          Constants.securitySignature,
                                  spaceHeight: height,
                                  state: state,
                                ),
                              ],

                              if ((state.model.status ==
                                          ConstantsIntValue
                                              .mmStatusInwardWaiting ||
                                      state.model.status ==
                                          ConstantsIntValue.mmStatusClosed) &&
                                  !widget.isInward &&
                                  state.model.returnable == true) ...[
                                /// Actual Date Of Return
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.actualDateOfReturn ??
                                      state.labels?.defaultLocale
                                          .actualDateOfReturn ??
                                      Constants.actualDateOfReturn,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                BaseDate().datePickerWidgetLoading(
                                  textController: actualDateOfReturnController,
                                  isDisabled: state.model.status ==
                                          ConstantsIntValue.mmStatusClosed ||
                                      !showSaveSubmitButtons ||
                                      lock,
                                  onlyDate: false,
                                  showFutureDate: false,
                                  showPastDate: true,
                                  onChange: (String value) {
                                    state.model.actualDateOfReturn =
                                        Utils().formatTime(value);
                                    BlocProvider.of<
                                                MaterialMovementDetailsCubit>(
                                            context)
                                        .onModelValueChange(state.model);
                                  },
                                  context: context,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///Material Returned Challan No
                                CommonWidgets.textDisplay(
                                  state.labels?.locale
                                          .materialReturnedChallanNo ??
                                      state.labels?.defaultLocale
                                          .materialReturnedChallanNo ??
                                      Constants.materialReturnedChallanNo,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  textFormKey: Keys.returnChallanKey,
                                  initialValue:
                                      state.model.materialReturnedChallanNo,
                                  hintText: '',
                                  isEnable: showSaveSubmitButtons && !lock
                                      ? true
                                      : false,
                                  isDisableColor: showSaveSubmitButtons || !lock
                                      ? false
                                      : true,
                                  onChange: (String value) {
                                    log('--value---$value');

                                    state.model.materialReturnedChallanNo =
                                        value;

                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///Return Receiver Email
                                Column(
                                  children: [
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale
                                              .returnReceiverMailId ??
                                          state.labels?.defaultLocale
                                              .returnReceiverMailId ??
                                          Constants.returnReceiverEmail,
                                      Styles.textStyleWhite16,
                                      isMandatory: true,
                                    ),
                                    widget.model?.status != 6
                                        ? TextFieldAddButton(
                                            title: state
                                                .model.returnReceiverMailId,
                                            height: 70,
                                            isDisableColor:
                                                !showSaveSubmitButtons || lock
                                                    ? true
                                                    : false,
                                            onTap: () {
                                              if ((state.model.status ==
                                                      ConstantsIntValue
                                                          .mmStatusInwardWaiting) &&
                                                  state.model.lock
                                                      .isEmptyOrNull) {
                                                BaseOrganisationDialog()
                                                    .userDialog(
                                                  context: context,
                                                  users: state
                                                      .returnReceiverEmailId!,
                                                  onTap: (BaseUser user) {
                                                    BlocProvider.of<
                                                                MaterialMovementDetailsCubit>(
                                                            context)
                                                        .updateDropdownValues(
                                                            returnReceiverMailId:
                                                                user);
                                                  },
                                                  roleName: ConstantUserRoles
                                                      .atomStaticUser,
                                                  locationId:
                                                      state.model.location!.id!,
                                                  functionToCall:
                                                      (BaseUser user) {
                                                    BlocProvider.of<
                                                                MaterialMovementDetailsCubit>(
                                                            context)
                                                        .updateDropdownValues(
                                                            returnReceiverMailId:
                                                                user);
                                                    // refresh the list
                                                    BlocProvider.of<
                                                                MaterialMovementDetailsCubit>(
                                                            context)
                                                        .refreshList();
                                                  },
                                                );
                                              }
                                            },
                                          )
                                        : FlutterInputField(
                                            initialValue: state
                                                .model.returnReceiverMailId,
                                            textFormKey:
                                                Keys.returnReceiverEmailKey,
                                            hintText: '',
                                            isEnable: state.model.status ==
                                                    ConstantsIntValue
                                                        .mmStatusInwardWaiting
                                                ? true
                                                : false,
                                            isDisableColor:
                                                !showSaveSubmitButtons || lock
                                                    ? true
                                                    : false,
                                            onChange: (String username) {},
                                            validateTextField:
                                                (String? user) {},
                                          ),
                                  ],
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///Returned Quantity
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.returnQuantity ??
                                      state.labels?.defaultLocale
                                          .returnQuantity ??
                                      Constants.returnedQuantity,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                FlutterInputField(
                                  initialValue:
                                      '${state.model.returnQuantity ?? ''}',
                                  textFormKey:
                                      Keys.returnQuantityTextController,
                                  isEnable: showSaveSubmitButtons && !lock
                                      ? true
                                      : false,
                                  isDisableColor: !showSaveSubmitButtons || lock
                                      ? true
                                      : false,
                                  hintText: '',
                                  onChange: (String? value) {
                                    if (value != null) {
                                      state.model.returnQuantity =
                                          int.parse(value);
                                    }
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  // validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Comment
                                CommonWidgets.textDisplay(
                                  state.labels?.locale
                                          .materialNotCheckedComment ??
                                      state.labels?.defaultLocale
                                          .materialNotCheckedComment ??
                                      Constants.comment,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                FlutterInputField(
                                  initialValue: state.model.comment,
                                  textFormKey: Keys.claimantEmpIdTextController,
                                  hintText: '',
                                  isEnable: showSaveSubmitButtons && !lock
                                      ? true
                                      : false,
                                  isDisableColor:
                                      !showSaveSubmitButtons ? true : false,
                                  onChange: (String value) {
                                    state.model.comment = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              if (state.model.returnable == true) ...[
                                /// Expected Date Of Return
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.expectedDateOfReturn ??
                                      state.labels?.defaultLocale
                                          .expectedDateOfReturn ??
                                      Constants.expectedDateOfReturn,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                // datecreateWidgetdisplay(
                                //     state.model.expectedDateOfReturn ?? ''),
                                BaseDate().datePickerWidgetLoading(
                                  showPastDate: false,
                                  textController:
                                      expectedDateOfReturnController,
                                  onlyDate: true,
                                  isDisabled: !showSaveSubmitButtons ||
                                          state.model.status ==
                                              ConstantsIntValue
                                                  .mmStatusClosed ||
                                          // state.model.status ==
                                          //     ConstantsIntValue
                                          //         .mmStatusInwardWaiting ||
                                          state.model.status ==
                                              ConstantsIntValue
                                                  .mmStatusApproved ||
                                          state.model.status ==
                                              ConstantsIntValue
                                                  .mmStatusOverDue ||  state.model.status ==
                                      ConstantsIntValue
                                          .mmStatusInwardPending ||
                                          lock
                                      ? true
                                      : false,
                                  // isDisabled: true,
                                  onChange: (String value) {
                                    state.model.expectedDateOfReturn =
                                        Utils().formatTime(value);
                                    BlocProvider.of<
                                                MaterialMovementDetailsCubit>(
                                            context)
                                        .onModelValueChange(state.model);
                                  },
                                  context: context,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              /// upload
                              widget.model?.status == null ||
                                      widget.model?.status == 0
                                  ? CommonWidgets.textDisplay(
                                      Constants.upload, Styles.textStyleWhite16)
                                  : Container(),
                              widget.model?.status == null ||
                                      widget.model?.status == 0
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),
                              (widget.model?.status == null ||
                                          widget.model?.status == 0) &&
                                      state.model.lock.isEmptyOrNull
                                  ? uploadWidget(state)
                                  : Container(),
                            ],
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.02),

                        /// Attachments
                        BaseImageUpload().getAttachment(
                          height: height,
                          attachments: state.loadAttachments,
                          files: getFiles,
                          moduleCode: moduleCode,
                          isDisabled: isReadOnly,
                          showDeleteIcon: state.model.status == null ||
                              state.model.status ==
                                  ConstantsIntValue.mmStatusDraft,
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.02),

                        if (state.model.id != null) ...[
                          /// Modified Date
                          CommonWidgets.textDisplay(
                            // state.labels?.locale.date ??
                            //     state.labels?.defaultLocale.date ??
                            Constants.modifiedOn,
                            Styles.textStyleWhite16,
                            isMandatory: true,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
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

                        /// SubmitButton
                        if (((state.model.status == 0 ||
                                    state.model.status == 8 ||
                                    state.model.status == 1 ||
                                    state.model.status == 6 ||
                                    state.model.status == 7 ||
                                    state.model.status == 5 ||
                                    state.model.status == 9 ||
                                    state.model.status == 11 ||
                                    state.model.status == null) &&
                                !lock)
                            ? true
                            : false) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cancelButtonDisplay(),
                              if (showSaveSubmitButtons) ...[
                                submitButtonDisplay(state)
                              ],
                            ],
                          ),
                        ],
                        CommonWidgets.verticalSpacerWidget(height * 0.04),
                      ],
                    ),
                  ),
                ),
              ),
              if ((state.model.status == 2 ||
                      state.model.status == 3 ||
                      state.model.status == 4 ||
                      state.model.status == 10 ||
                      state.model.status == -1) ||
                  lock) ...[
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: const ShapeDecoration(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(00.0)),
                    ),
                  ),
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

  AbsorbPointer buildSignature({
    required SignatureController controller,
    required String label,
    required double spaceHeight,
    required MaterialMovementDetailsState state,
  }) {
    bool isEditable = false;
    bool isSigned = false;
    bool isReceiver = label.equalsIgnoreCase(Constants.receiverSignature);
    if (isReceiver) {
      isSigned = state.model.receiverSign != null &&
          !state.model.receiverSign!.imageContent.isEmptyOrNull;
      isEditable = state.isReceiverSignEditable;
    } else {
      isSigned = state.model.entrySecuritySign != null &&
          !state.model.entrySecuritySign!.imageContent.isEmptyOrNull;
      isEditable = state.isEntrySecuritySignatureSignEditable;
    }

    return AbsorbPointer(
      absorbing: state.model.lock.isEmptyOrNull &&
          state.model.status != 0 && state.model.status != null ,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidgets.textDisplay(
                label,
                Styles.textStyleWhite16,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.clear();
                      if (isReceiver) {
                        BlocProvider.of<MaterialMovementDetailsCubit>(context)
                            .makeSignEditable(receiverSign: true);
                      } else {
                        BlocProvider.of<MaterialMovementDetailsCubit>(context)
                            .makeSignEditable(
                                entrySecuritySignatureSignEditable: true);
                      }
                    },
                    iconSize: 20,
                    color: Colors.white,
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(spaceHeight * 0.001),
          ClipRect(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: AppColors.geryLightBackground,
                  width: 1, // Border width
                ),
              ),
              height: 150,
              width: double.infinity,
              child: (!isEditable && isSigned)
                  ? Image.memory(
                      Uint8List.fromList(
                        base64Decode(
                          isReceiver
                              ? state.model.receiverSign!.imageContent ?? ''
                              : state.model.entrySecuritySign!.imageContent ??
                                  '',
                        ),
                      ),
                      fit: BoxFit.none,
                    )
                  : Signature(
                      controller: controller,
                      backgroundColor: Colors.transparent,
                    ),
            ),
          ),
          CommonWidgets.verticalSpacerWidget(spaceHeight * 0.01),
        ],
      ),
    );
  }

  Widget quantityUnitPopUp(MaterialMovementDetailsState state) {
    return TextFieldAddButton(
      title: state.labels?.locale.quantity ??
          state.labels?.locale.quantity ??
          Constants.quantity,
      height: 70,
      isDisableColor: state.model.quantity == null ? false : true,
      onTap: () {
        if ((state.model.status != 6 ||
            state.model.status != -1 ||
            state.model.status != 10)) {
          quantityUnitDialog(
              context: context, quantityUnits: state.quantityUnits);
        }
      },
    );
  }

  quantityUnitDialog({
    required BuildContext context,
    required List<Organisation> quantityUnits,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateQuantityUnitList: quantityUnits,
            // leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return BaseAddOrganisationDialog(
                      title: Constants.addQuantity,
                      orgName: 'ATOM_MATERIAL_MOVEMENT_UNIT',
                      functionToCall: () {
                        // refresh the list
                        BlocProvider.of<MaterialMovementDetailsCubit>(context)
                            .refreshList();
                      },
                    );
                  });
            },
            onTap: (Organisation unit) {
              BlocProvider.of<MaterialMovementDetailsCubit>(context)
                  .updateDropdownValues(quantityUnit: unit);
            },
          );
        });
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      width: Constants.cancelButtonWidth,
      backgroundColor: AppColors.lavender,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.close,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
        CommonServices().unlock();
      },
    );
  }

  Widget submitButtonDisplay(MaterialMovementDetailsState state) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<MaterialMovementDetailsCubit>(context).submitForm(
          receiverSignatureController: receiverSignatureController,
          securitySignatureController: securitySignatureController,
        );
      },
    );
  }

  Widget uploadWidget(MaterialMovementDetailsState state) {
    return widget.model?.status == null ||
            widget.model?.status == 0 ||
            widget.model?.status == 1
        ? Container(
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFCACACA),
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 50),
                    backgroundColor: !isReadOnly && showSaveSubmitButtons
                        ? AppColors.newColor.withValues(alpha: 0.4)
                        : AppColors.lightLavender,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return UploadAttachment(
                            // userdetails: state.loggedInUserDetails ?? User(),
                            // getFiles: getFiles,
                            // inwardState: state,
                            onImageSelected: (ImageContent data) {
                              log('-------function---onImageSelected---------');
                              List<ImageContent>? files = [];
                              files.add(data);
                              for (ImageContent image in getFiles.toList()) {
                                files.add(image);
                              }
                              BlocProvider.of<MaterialMovementDetailsCubit>(
                                      context)
                                  .addAttachment(files);
                            },
                          );
                        });
                  },

                  icon: SvgPicture.asset(
                    //AppIcon.dropdownicon,
                    AppIcon.uploadicon,
                    //fit: BoxFit.,
                    colorFilter: const ColorFilter.mode(
                      AppColors.backgroundWhiteColor,
                      BlendMode.srcIn,
                    ),
                    // color: AppColors.backgroundWhiteColor,
                    width: 13,
                    height: 13,
                    key: const Key(Keys.userIcon),
                  ),
                  label: const Text(
                    Constants.clicktoupload,
                    style: Styles.textStyleRegularNormalWhite12,
                  ), // <-- Text
                ),
              ),
            ]),
          )
        : Container();
  }

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
