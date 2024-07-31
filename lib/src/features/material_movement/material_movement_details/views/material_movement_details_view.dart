import 'dart:convert';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_add_organisation_dialog.dart';

import 'add_rejection_commnet_pop_up.dart';

class MaterialMovementDetailsView extends StatefulWidget {
  final MaterialMovementModel? model;
  final bool isInward;
  final String title;
  final ExtraProperties? extraProperties;

  const MaterialMovementDetailsView({
    super.key,
    this.model,
    required this.isInward,
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

  final FocusNode requestorEmployeeIdFocusNode = FocusNode();
  final FocusNode receivedForEmployeeIdFocusNode = FocusNode();
  final FocusNode sentToFocusNode = FocusNode();
  final FocusNode receivedByFocusNode = FocusNode();

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
    //initializeDates(state);
  }

  static const String moduleCode = Constants.materialMovementModuleCode;

  @override
  void dispose() {
    receiverSignatureController.dispose();
    securitySignatureController.dispose();
    super.dispose();
  }

  bool showSaveSubmitButtons = false;

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
                  context, materialMovementInwardsOutwardsRoute,
                  arguments: {"isInward": widget.isInward});
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);

          // Utils.dynamicAlert(
          //     context, state.message ?? '', 'Material Movement', '');
        }
      },
      builder: (context, state) {
        if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 10 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == -1 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 3 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 4 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 5 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == null) {
          isReadOnly = false;
        }
        if (state.model.status == ConstantsIntValue.businessUserReview) {
          isReadOnly = state.isReadOnly ?? false;
        }
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isReadOnly = true;
        // }

        showSaveSubmitButtons = (state.model.status == 0 ||
                state.model.status == 8 ||
                // state.model.status == 1 ||
                state.model.status == 6 ||
                state.model.status == 7 ||
                state.model.status == 9 ||
                state.model.status == null ||
                isReadOnly == false) &&
            state.model.lock.isEmptyOrNull;
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: showSaveSubmitButtons,
            pdfAPIName:
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=$moduleCode',
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
            showSubmitButton: showSaveSubmitButtons,
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
            showLikeButton: state.model.status == 3 &&
                    !isReadOnly &&
                    state.model.lock.isEmptyOrNull
                ? true
                : false,
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
            showDisLikeButton: state.model.status == 3 &&
                    !isReadOnly &&
                    state.model.lock.isEmptyOrNull
                ? true
                : false,
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
          backgroundColor: AppColors.backgroundWhiteColor,
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
    actualDateOfReturnController.text = Utils.timestampToDateConversion(
        int.tryParse(widget.model?.actualDateOfReturn ?? '0'),
        Constants.dateFormat);
    takenOutOnDateController.text = Utils.timestampToDateConversion(
        int.tryParse(widget.model?.takenOutDate ?? '0'), Constants.dateFormat);
  }

  getBodybuilder(MaterialMovementDetailsState state, height) {
    initializeDates(state);
    log('-state.materialMovement.status---${state.model.status}--');
    log('-rejection Comment---${widget.model?.rejectionComment}--');

    returnableTextController.text =
        state.model.returnable! ? 'Returnable' : 'Non Returnable';

    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      getFiles = state.loadAttachments ?? [];
    }
    bool isQuantityDisabled = (state.model.status == 10 ||
        state.model.status == -1 ||
        state.model.status == 6 ||
        state.model.status == 2);
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
                        absorbing: !showSaveSubmitButtons,
                        child: Column(
                          children: [
                            if (!state.model.lock.isEmptyOrNull) ...[
                              RecordLockedWidget(text: '${state.model.lock}'),
                            ],
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.generalinformation,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Material Movement Type
                            CommonWidgets.textDisplay(
                              state.labels?.locale.type ??
                                  state.labels?.defaultLocale.type ??
                                  'Material Movement Type',
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.001),
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
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Non Returnable
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                              isDisabled: state.model.status != 6,
                              textController: returnableTextController,
                              onTap: () {
                                if ((!isReadOnly && !widget.isInward) &&
                                    (state.model.status == 0 ||
                                        state.model.status == null)) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: returnableDropDownValues,
                                    onTap: (String value) {
                                      bool isReturnable =
                                          value == 'Returnable' ? true : false;
                                      state.model.returnable = isReturnable;
                                      BlocProvider.of<
                                                  MaterialMovementDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                              isReturnable: isReturnable);
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Status
                            CommonWidgets.textDisplay(
                              state.labels?.locale.status ??
                                  state.labels?.defaultLocale.status ??
                                  Constants.status,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                              isDisabled: true,
                              textController: statusController,
                              items: materialMovementStatusValues,
                              initialValue: '${state.model.status ?? 0}',
                              onTap: () {
                                if (isReadOnly) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: materialMovementStatusValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          materialMovementStatusValues
                                              .firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      BlocProvider.of<
                                                  MaterialMovementDetailsCubit>(
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

                            /// Created By
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                isMandatory: true,
                                '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location
                            CommonWidgets.textDisplay(
                              state.labels?.locale.location ??
                                  state.labels?.defaultLocale.location ??
                                  Constants.location,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            // locationWidgetdislay(state),
                            BaseLocationDropdown().locationWidgetDisplay(
                                isEnabled: !isReadOnly,
                                context: context,
                                locations: state.locations ?? Locations(),
                                selectedLocationName:
                                    state.model.location?.name ?? '',
                                onTap: (Organisation? location) {
                                  BlocProvider.of<MaterialMovementDetailsCubit>(
                                          context)
                                      .updateLocationDropdownValue(
                                          location: location);
                                }),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                              state.labels?.locale.inputDate ??
                                  state.labels?.defaultLocale.inputDate ??
                                  Constants.dateofcreation,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Sl No.
                            CommonWidgets.horizentaltextHandling(
                              state.labels?.locale.slNo ??
                                  state.labels?.defaultLocale.slNo ??
                                  Constants.slno,
                              state.model.slNo ?? '',
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Challan/ Invoice Nos/ Gate Pass
                            CommonWidgets.textDisplay(
                              state.labels?.locale.challanNo ??
                                  state.labels?.defaultLocale.challanNo ??
                                  Constants.challan,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
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
                                      !state.model.lock.isEmptyOrNull
                                  ? false
                                  : true,
                              isDisableColor: state.model.status == 10 ||
                                  state.model.status == -1 ||
                                  state.model.status == 6 ||
                                  state.model.status == 2 ||
                                  state.model.status == 3 ||
                                  state.model.status == 5 ||
                                  state.model.status == 1 ||
                                  !state.model.lock.isEmptyOrNull,
                              onChange: (String value) {
                                state.model.challanNo = value;
                                context
                                    .read<MaterialMovementDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            if (widget.isInward) ...[
                              /// PO Number
                              CommonWidgets.textDisplay(
                                state.labels?.locale.poNumber ??
                                    state.labels?.defaultLocale.poNumber ??
                                    Constants.poNumber,
                                Styles.textStyleBlack14,
                              ),
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
                                        !state.model.lock.isEmptyOrNull
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            /// Material Brief Description
                            CommonWidgets.textDisplay(
                              state.labels?.locale.materialDescription ??
                                  state.labels?.defaultLocale
                                      .materialDescription ??
                                  Constants.materialBriefDescription,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              showBorder: true,
                              lineHeight: 6,
                              initialValue: state.model.materialDescription,
                              textFormKey: Keys.materialBreifDescKey,
                              hintText: Constants.informationhere,
                              isEnable: state.model.status == 10 ||
                                      state.model.status == -1 ||
                                      state.model.status == 6 ||
                                      state.model.status == 2 ||
                                      state.model.status == 3 ||
                                      state.model.status == 4 ||
                                      state.model.status == 5 ||
                                      !state.model.lock.isEmptyOrNull
                                  ? false
                                  : true,
                              isDisableColor: state.model.status == 10 ||
                                  state.model.status == -1 ||
                                  state.model.status == 6 ||
                                  state.model.status == 2 ||
                                  state.model.status == 3 ||
                                  state.model.status == 4 ||
                                  state.model.status == 5 ||
                                  isReadOnly,
                              validateTextField: (String? user) {},
                              onChange: (String value) {
                                state.model.materialDescription = value;
                              },
                              textInputAction: TextInputAction.newline,
                              textInputType:
                                  TextInputType.multiline, // Add this line
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Quantity
                            CommonWidgets.textDisplay(
                              state.labels?.locale.quantity ??
                                  state.labels?.defaultLocale.quantity ??
                                  Constants.quantity,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: FlutterInputField(
                                    characterLimit: 3,
                                    textInputType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    initialValue:
                                        '${state.model.quantity ?? ''}',
                                    textFormKey: Keys.quantityKey,
                                    hintText: '',
                                    isEnable: state.model.status == 10 ||
                                            state.model.status == -1 ||
                                            state.model.status == 6 ||
                                            state.model.status == 2 ||
                                            state.model.status == 3 ||
                                            state.model.status == 4 ||
                                            state.model.status == 5 ||
                                            isReadOnly
                                        ? false
                                        : true,
                                    isDisableColor: state.model.status == 10 ||
                                        state.model.status == -1 ||
                                        state.model.status == 6 ||
                                        state.model.status == 2 ||
                                        state.model.status == 3 ||
                                        state.model.status == 4 ||
                                        state.model.status == 5 ||
                                        isReadOnly,
                                    onChange: (String? value) {
                                      if (value != null) {
                                        state.model.quantity = int.parse(value);
                                      }
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                ),
                                TileWidget(
                                  name: state.model.unit?.name ?? 'Unit',
                                  width: 200,
                                ),
                                if (!isReadOnly) ...[
                                  InkWell(
                                    onTap: () {
                                      if (!isQuantityDisabled) {
                                        quantityUnitDialog(
                                          context: context,
                                          quantityUnits: state.quantityUnits,
                                        );
                                      }
                                    },
                                    child: AddButtonWidget(
                                      height: 50,
                                      isDisableColor:
                                          state.model.status == 10 ||
                                                  state.model.status == -1 ||
                                                  state.model.status == 6 ||
                                                  state.model.status == 2 ||
                                                  state.model.status == 3 ||
                                                  state.model.status == 4 ||
                                                  state.model.status == 5
                                              ? true
                                              : false,
                                    ),
                                  ),
                                ],
                              ],
                            ),

                            // quantityUnitPopUp(state),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Outward Details Fields
                            if (!widget.isInward) ...[
                              /// Equipment No/Identification
                              CommonWidgets.textDisplay(
                                state.labels?.locale.modelInfo ??
                                    state.labels?.defaultLocale.modelInfo ??
                                    Constants.equipmentNo,
                                Styles.textStyleBlack14,
                                isMandatory:
                                    widget.model == null ? false : true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                initialValue: state.model.modelInfo,
                                showBorder: true,
                                textFormKey: Keys.equipmentNoKey,
                                hintText: '',
                                isEnable: state.model.status == 10 ||
                                        state.model.status == -1 ||
                                        state.model.status == 6 ||
                                        state.model.status == 2 ||
                                        state.model.status == 3 ||
                                        state.model.status == 4 ||
                                        state.model.status == 5 ||
                                        isReadOnly
                                    ? false
                                    : true,
                                isDisableColor: state.model.status == 10 ||
                                    state.model.status == -1 ||
                                    state.model.status == 6 ||
                                    state.model.status == 2 ||
                                    state.model.status == 3 ||
                                    state.model.status == 4 ||
                                    state.model.status == 5 ||
                                    isReadOnly,
                                onChange: (String value) {
                                  state.model.modelInfo = value;
                                  context
                                      .read<MaterialMovementDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                textInputAction: TextInputAction.newline,
                                textInputType: TextInputType.multiline,
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Sent to Address
                              CommonWidgets.textDisplay(
                                state.labels?.locale.address ??
                                    state.labels?.defaultLocale.address ??
                                    Constants.address,
                                Styles.textStyleBlack14,
                                isMandatory:
                                    widget.model == null ? false : true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                initialValue: state.model.address,
                                showBorder: true,
                                textFormKey: Keys.addressKey,
                                hintText: '',
                                isEnable: state.model.status == 10 ||
                                        state.model.status == -1 ||
                                        state.model.status == 6 ||
                                        state.model.status == 2 ||
                                        state.model.status == 3 ||
                                        state.model.status == 4 ||
                                        state.model.status == 5 ||
                                        !state.model.lock.isEmptyOrNull
                                    ? false
                                    : true,
                                isDisableColor: state.model.status == 10 ||
                                    state.model.status == -1 ||
                                    state.model.status == 6 ||
                                    state.model.status == 2 ||
                                    state.model.status == 3 ||
                                    state.model.status == 4 ||
                                    state.model.status == 5 ||
                                    isReadOnly,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Requestor Email
                              Column(
                                children: [
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.requestorEmail ??
                                        state.labels?.defaultLocale
                                            .requestorEmail ??
                                        Constants.requestorEmail,
                                    Styles.textStyleBlack14,
                                    isMandatory: true,
                                  ),
                                  widget.model?.status != 6 ||
                                          state.model.status == 1
                                      ? TextFieldAddButton(
                                          title: state.model.requestorEmail,
                                          height: 70,
                                          isDisableColor:
                                              state.model.status == 10 ||
                                                  state.model.status == -1 ||
                                                  state.model.status == 6 ||
                                                  state.model.status == 2 ||
                                                  state.model.status == 3 ||
                                                  state.model.status == 4 ||
                                                  state.model.status == 5 ||
                                                  state.model.status == 1,
                                          onTap: () {
                                            if (state.model.status == 10 ||
                                                    state.model.status == -1 ||
                                                    state.model.status == 6 ||
                                                    state.model.status == 2 ||
                                                    state.model.status == 3 ||
                                                    state.model.status == 5 ||
                                                    state.model.status == 4 ||
                                                    state.model.status == 1 ||
                                                    !state.model.lock
                                                        .isEmptyOrNull
                                                ? false
                                                : true) {
                                              BaseOrganisationDialog()
                                                  .userDialog(
                                                context: context,
                                                users: state.emailUsers!,
                                                onTap: (BaseUser user) {
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .updateApproverEmailsValue(
                                                          requesterEmailUser:
                                                              user);
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          requestorEmployeeIdFocusNode);
                                                },
                                                locationId:
                                                    state.model.location!.id!,
                                                functionToCall: () {
                                                  // refresh the list
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .refreshList();
                                                },
                                              );
                                            }
                                          })
                                      : FlutterInputField(
                                          initialValue:
                                              state.model.requestorEmail,
                                          textFormKey: Keys.requesterEmailKey,
                                          hintText: '',
                                          isEnable: state.model.status == 10 ||
                                                  state.model.status == -1 ||
                                                  state.model.status == 6 ||
                                                  state.model.status == 2 ||
                                                  state.model.status == 3 ||
                                                  state.model.status == 4 ||
                                                  state.model.status == 5 ||
                                                  state.model.status == 1 ||
                                                  !state
                                                      .model.lock.isEmptyOrNull
                                              ? false
                                              : true,
                                          isDisableColor:
                                              state.model.status == 10 ||
                                                  state.model.status == -1 ||
                                                  state.model.status == 6 ||
                                                  state.model.status == 2 ||
                                                  state.model.status == 3 ||
                                                  state.model.status == 4 ||
                                                  state.model.status == 5 ||
                                                  state.model.status == 1,
                                          onChange: (String username) {},
                                          validateTextField: (String? user) {},
                                        ),
                                ],
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Requestor Employee Id
                              CommonWidgets.textDisplay(
                                state.labels?.locale.requestorEmployeeId ??
                                    state.labels?.defaultLocale
                                        .requestorEmployeeId ??
                                    Constants.requestorEmployeeId,
                                Styles.textStyleBlack14,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              FlutterInputField(
                                textInputType: TextInputType.number,
                                initialValue: state.model.requestorEmployeeId,
                                textFormKey: Keys.requestorEmployeeKey,
                                hintText: '',
                                focusNode: requestorEmployeeIdFocusNode,
                                isEnable: state.model.status == 10 ||
                                        state.model.status == -1 ||
                                        state.model.status == 6 ||
                                        state.model.status == 2 ||
                                        state.model.status == 3 ||
                                        state.model.status == 4 ||
                                        state.model.status == 5 ||
                                        state.model.status == 1 ||
                                        !state.model.lock.isEmptyOrNull
                                    ? false
                                    : true,
                                isDisableColor: state.model.status == 10 ||
                                    state.model.status == -1 ||
                                    state.model.status == 6 ||
                                    state.model.status == 2 ||
                                    state.model.status == 3 ||
                                    state.model.status == 4 ||
                                    state.model.status == 5 ||
                                    state.model.status == 1,
                                onChange: (String value) {
                                  state.model.requestorEmployeeId = value;
                                  context
                                      .read<MaterialMovementDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Requester Department
                              CommonWidgets.textDisplay(
                                state.labels?.locale.requestorDepartment ??
                                    state.labels?.defaultLocale
                                        .requestorDepartment ??
                                    Constants.requestorDepartment,
                                Styles.textStyleBlack14,
                                isMandatory:
                                    widget.model == null ? false : true,
                              ),
                              widget.model?.status == 6
                                  ? FlutterInputField(
                                      initialValue:
                                          state.model.requestorDepartment?.name,
                                      textFormKey: Keys.requesterDepartmentKey,
                                      hintText: '',
                                      isEnable: state.model.status != 6 ||
                                          state.model.status != -1 ||
                                          state.model.status != 10 ||
                                          state.model.status != 2 ||
                                          state.model.status != 3 ||
                                          state.model.status == 4 ||
                                          state.model.status != 5 ||
                                          state.model.lock.isEmptyOrNull,
                                      isDisableColor: state.model.status == 6 ||
                                          state.model.status == -1 ||
                                          state.model.status == 10 ||
                                          state.model.status == 2 ||
                                          state.model.status == 3 ||
                                          state.model.status == 5 ||
                                          isReadOnly,
                                      onChange: (String value) {
                                        state.model.requestorDepartment?.name =
                                            value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(state.model);
                                      },
                                      validateTextField: (String? user) {},
                                    )
                                  : TextFieldAddButton(
                                      title:
                                          state.model.requestorDepartment?.name,
                                      height: 70,
                                      isDisableColor:
                                          (state.model.status == 6 ||
                                                  state.model.status == -1 ||
                                                  state.model.status == 10 ||
                                                  state.model.status == 2 ||
                                                  state.model.status == 3 ||
                                                  state.model.status == 4 ||
                                                  state.model.status == 5 ||
                                                  isReadOnly)
                                              ? true
                                              : false,
                                      onTap: () {
                                        if (state.model.status == 6 ||
                                                state.model.status == 10 ||
                                                state.model.status == -1 ||
                                                state.model.status == 2 ||
                                                state.model.status == 3 ||
                                                state.model.status == 4 ||
                                                state.model.status == 5 ||
                                                !state.model.lock.isEmptyOrNull
                                            ? false
                                            : true) {
                                          BaseOrganisationDialog()
                                              .departmentDialog(
                                                  context: context,
                                                  organisations:
                                                      state.departments,
                                                  onTap: (Organisation
                                                      department) {
                                                    state
                                                            .model
                                                            .requestorDepartment
                                                            ?.name =
                                                        department.name;

                                                    BlocProvider.of<
                                                                MaterialMovementDetailsCubit>(
                                                            context)
                                                        .updateDropdownValues(
                                                            requesterDepartment:
                                                                department);
                                                  },
                                                  orgName:
                                                      'EMPLOYEE_DEPARTMENTS',
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Sent To
                              CommonWidgets.textDisplay(
                                state.labels?.locale.sentTo ??
                                    state.labels?.defaultLocale.sentTo ??
                                    Constants.sentTo,
                                Styles.textStyleBlack14,
                                isMandatory:
                                    widget.model == null ? false : true,
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
                                        state.model.status == 5 ||
                                        isReadOnly
                                    ? false
                                    : true,
                                isDisableColor: state.model.status == 10 ||
                                    state.model.status == -1 ||
                                    state.model.status == 6 ||
                                    state.model.status == 2 ||
                                    state.model.status == 3 ||
                                    state.model.status == 4 ||
                                    state.model.status == 5 ||
                                    isReadOnly,
                                onChange: (String value) {
                                  state.model.sentTo = value;
                                  context
                                      .read<MaterialMovementDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Purpose
                              CommonWidgets.textDisplay(
                                state.labels?.locale.purpose ??
                                    state.labels?.defaultLocale.purpose ??
                                    Constants.purpose,
                                Styles.textStyleBlack14,
                                isMandatory:
                                    widget.model == null ? false : true,
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
                                        state.model.status == 5 ||
                                        isReadOnly
                                    ? false
                                    : true,
                                isDisableColor: state.model.status == 10 ||
                                    state.model.status == -1 ||
                                    state.model.status == 6 ||
                                    state.model.status == 2 ||
                                    state.model.status == 3 ||
                                    state.model.status == 4 ||
                                    state.model.status == 5 ||
                                    isReadOnly,
                                onChange: (String value) {
                                  state.model.purpose = value;
                                  context
                                      .read<MaterialMovementDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Prepared By
                              CommonWidgets.textDisplay(
                                state.labels?.locale.preparedBy ??
                                    state.labels?.defaultLocale.preparedBy ??
                                    Constants.preparedBy,
                                Styles.textStyleBlack14,
                                isMandatory: true,
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
                                        state.model.status == 5 ||
                                        isReadOnly
                                    ? false
                                    : true,
                                isDisableColor: state.model.status == 10 ||
                                    state.model.status == -1 ||
                                    state.model.status == 6 ||
                                    state.model.status == 2 ||
                                    state.model.status == 3 ||
                                    state.model.status == 4 ||
                                    state.model.status == 5 ||
                                    isReadOnly,
                                onChange: (String value) {
                                  state.model.preparedBy = value;
                                  BlocProvider.of<MaterialMovementDetailsCubit>(
                                          context)
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Prepared By Department
                              CommonWidgets.textDisplay(
                                state.labels?.locale.preparedByDepartment ??
                                    state.labels?.defaultLocale
                                        .preparedByDepartment ??
                                    Constants.preparedByDepartment,
                                Styles.textStyleBlack14,
                                isMandatory:
                                    widget.model == null ? false : true,
                              ),
                              widget.model?.status == 6
                                  ? FlutterInputField(
                                      initialValue: state
                                          .model.preparedByDepartment?.name,
                                      textFormKey: Keys.preparedByDepartmentKey,
                                      hintText: '',
                                      isEnable: state.model.status == 10 ||
                                              state.model.status == -1 ||
                                              state.model.status == 6 ||
                                              state.model.status == 2 ||
                                              state.model.status == 3 ||
                                              state.model.status == 4 ||
                                              state.model.status == 5 ||
                                              isReadOnly
                                          ? false
                                          : true,
                                      isDisableColor:
                                          state.model.status == 10 ||
                                              state.model.status == -1 ||
                                              state.model.status == 6 ||
                                              state.model.status == 2 ||
                                              state.model.status == 3 ||
                                              state.model.status == 4 ||
                                              state.model.status == 5 ||
                                              isReadOnly,
                                      onChange: (String value) {
                                        state.model.preparedByDepartment?.name =
                                            value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(state.model);
                                      },
                                      validateTextField: (String? user) {},
                                    )
                                  : TextFieldAddButton(
                                      title: state
                                          .model.preparedByDepartment?.name,
                                      height: 70,
                                      isDisableColor:
                                          state.model.status == 10 ||
                                              state.model.status == -1 ||
                                              state.model.status == 6 ||
                                              state.model.status == 2 ||
                                              state.model.status == 3 ||
                                              state.model.status == 4 ||
                                              state.model.status == 5 ||
                                              isReadOnly,
                                      onTap: () {
                                        if ((state.model.status == 6 ||
                                                state.model.status == -1 ||
                                                state.model.status == 10 ||
                                                state.model.status == 2 ||
                                                state.model.status == 3 ||
                                                state.model.status == 4 ||
                                                state.model.status == 5 ||
                                                isReadOnly)
                                            ? false
                                            : true) {
                                          BaseOrganisationDialog()
                                              .departmentDialog(
                                                  context: context,
                                                  organisations:
                                                      state.departments,
                                                  onTap: (Organisation
                                                      department) {
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
                                                  orgName:
                                                      'EMPLOYEE_DEPARTMENTS',
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Approver1 Email
                              Column(
                                children: [
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.approver1Email ??
                                        state.labels?.defaultLocale
                                            .approver1Email ??
                                        Constants.approver1Email,
                                    Styles.textStyleBlack14,
                                    isMandatory: true,
                                  ),
                                  widget.model?.status != 6
                                      ? TextFieldAddButton(
                                          title: state.model.approver1Email,
                                          height: 70,
                                          isDisableColor: (state.model.status ==
                                                      6 ||
                                                  state.model.status == -1 ||
                                                  state.model.status == 10 ||
                                                  state.model.status == 2 ||
                                                  state.model.status == 3 ||
                                                  state.model.status == 4 ||
                                                  state.model.status == 5 ||
                                                  state.model.status == 1)
                                              ? true
                                              : false,
                                          onTap: () {
                                            if ((state.model.status == 6 ||
                                                    state.model.status == -1 ||
                                                    state.model.status == 10 ||
                                                    state.model.status == 2 ||
                                                    state.model.status == 3 ||
                                                    state.model.status == 4 ||
                                                    state.model.status == 5 ||
                                                    state.model.status == 1 ||
                                                    !state.model.lock
                                                        .isEmptyOrNull)
                                                ? false
                                                : true) {
                                              BaseOrganisationDialog()
                                                  .userDialog(
                                                context: context,
                                                users: state.approver1Users!,
                                                onTap: (BaseUser user) {
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .updateApproverEmailsValue(
                                                          approver1EmailUser:
                                                              user);
                                                },
                                                locationId:
                                                    state.model.location!.id!,
                                                functionToCall: () {
                                                  // refresh the list
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .refreshList();
                                                },
                                              );
                                            }
                                          })
                                      : FlutterInputField(
                                          initialValue:
                                              state.model.approver1Email,
                                          textFormKey: Keys.approver1EmailKey,
                                          hintText: '',
                                          isEnable: state.model.status != 6 ||
                                              state.model.status != -1 ||
                                              state.model.status != 10 ||
                                              state.model.status != 2 ||
                                              state.model.status != 3 ||
                                              state.model.status != 4 ||
                                              state.model.status != 5 ||
                                              state.model.status != 1 ||
                                              state.model.lock.isEmptyOrNull,
                                          isDisableColor:
                                              state.model.status == 6 ||
                                                  state.model.status == 10 ||
                                                  state.model.status == -1 ||
                                                  state.model.status == 2 ||
                                                  state.model.status == 3 ||
                                                  state.model.status == 4 ||
                                                  state.model.status == 5 ||
                                                  state.model.status == 1,
                                          onChange: (String username) {},
                                          validateTextField: (String? user) {},
                                        ),
                                ],
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Approver1 By Department
                              CommonWidgets.textDisplay(
                                state.labels?.locale.approver1Department ??
                                    state.labels?.defaultLocale
                                        .approver1Department ??
                                    Constants.approver1Department,
                                Styles.textStyleBlack14,
                                isMandatory: true,
                              ),
                              widget.model?.status == 6
                                  ? FlutterInputField(
                                      initialValue:
                                          state.model.approver1Department?.name,
                                      textFormKey: Keys.aprrover1DepartmentKey,
                                      hintText: '',
                                      isEnable: state.model.status != 6 ||
                                          state.model.status != 10 ||
                                          state.model.status != -1 ||
                                          state.model.status != 2 ||
                                          state.model.status != 3 ||
                                          state.model.status != 4 ||
                                          state.model.status != 5 ||
                                          state.model.status != 1 ||
                                          state.model.lock.isEmptyOrNull,
                                      isDisableColor: state.model.status == 6 ||
                                          state.model.status == 1,
                                      onChange: (String value) {
                                        state.model.approver1Department?.name =
                                            value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(state.model);
                                      },
                                      validateTextField: (String? user) {},
                                    )
                                  : TextFieldAddButton(
                                      title:
                                          state.model.approver1Department?.name,
                                      height: 70,
                                      isDisableColor:
                                          (state.model.status == 6 ||
                                                  state.model.status == -1 ||
                                                  state.model.status == 10 ||
                                                  state.model.status == 2 ||
                                                  state.model.status == 3 ||
                                                  state.model.status == 4 ||
                                                  state.model.status == 5 ||
                                                  state.model.status == 1)
                                              ? true
                                              : false,
                                      onTap: () {
                                        if ((state.model.status == 6 ||
                                                state.model.status == -1 ||
                                                state.model.status == 10 ||
                                                state.model.status == 2 ||
                                                state.model.status == 3 ||
                                                state.model.status == 4 ||
                                                state.model.status == 5 ||
                                                state.model.status == 1 ||
                                                !state.model.lock.isEmptyOrNull)
                                            ? false
                                            : true) {
                                          BaseOrganisationDialog()
                                              .departmentDialog(
                                                  context: context,
                                                  organisations:
                                                      state.departments,
                                                  onTap: (Organisation
                                                      department) {
                                                    state
                                                            .model
                                                            .approver1Department
                                                            ?.name =
                                                        department.name;

                                                    BlocProvider.of<
                                                                MaterialMovementDetailsCubit>(
                                                            context)
                                                        .updateDropdownValues(
                                                            approver1Department:
                                                                department);
                                                  },
                                                  orgName:
                                                      'EMPLOYEE_DEPARTMENTS',
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Approver2 Email
                              Column(
                                children: [
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.approver2Email ??
                                        state.labels?.defaultLocale
                                            .approver2Email ??
                                        Constants.approver2Email,
                                    Styles.textStyleBlack14,
                                    isMandatory: true,
                                  ),
                                  widget.model?.status != 6
                                      ? TextFieldAddButton(
                                          title: state.model.approver2Email,
                                          height: 70,
                                          isDisableColor: (state.model.status ==
                                                      6 ||
                                                  state.model.status == 10 ||
                                                  state.model.status == -1 ||
                                                  state.model.status == 2 ||
                                                  state.model.status == 3 ||
                                                  state.model.status == 4 ||
                                                  state.model.status == 5 ||
                                                  state.model.status == 1)
                                              ? true
                                              : false,
                                          onTap: () {
                                            if ((state.model.status == 6 ||
                                                    state.model.status == -1 ||
                                                    state.model.status == 10 ||
                                                    state.model.status == 2 ||
                                                    state.model.status == 3 ||
                                                    state.model.status == 4 ||
                                                    state.model.status == 5 ||
                                                    state.model.status == 1 ||
                                                    !state.model.lock
                                                        .isEmptyOrNull)
                                                ? false
                                                : true) {
                                              BaseOrganisationDialog()
                                                  .userDialog(
                                                context: context,
                                                users: state.approver2Users!,
                                                onTap: (BaseUser user) {
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .updateApproverEmailsValue(
                                                          approver2EmailUser:
                                                              user);
                                                },
                                                locationId:
                                                    state.model.location!.id!,
                                                functionToCall: () {
                                                  // refresh the list
                                                  BlocProvider.of<
                                                              MaterialMovementDetailsCubit>(
                                                          context)
                                                      .refreshList();
                                                },
                                              );
                                            }
                                          })
                                      : FlutterInputField(
                                          initialValue:
                                              state.model.approver2Email,
                                          textFormKey: Keys.approver2EmailKey,
                                          hintText: '',
                                          isEnable: state.model.status != 6 ||
                                              state.model.status != 10 ||
                                              state.model.status != -1 ||
                                              state.model.status != 2 ||
                                              state.model.status != 3 ||
                                              state.model.status != 4 ||
                                              state.model.status != 5 ||
                                              state.model.status != 1 ||
                                              state.model.lock.isEmptyOrNull,
                                          isDisableColor:
                                              state.model.status == 6 ||
                                                  state.model.status == 10 ||
                                                  state.model.status == -1 ||
                                                  state.model.status == 2 ||
                                                  state.model.status == 3 ||
                                                  state.model.status == 4 ||
                                                  state.model.status == 5 ||
                                                  state.model.status == 1,
                                          onChange: (String username) {},
                                          validateTextField: (String? user) {},
                                        ),
                                ],
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Approver2 By Department
                              CommonWidgets.textDisplay(
                                state.labels?.locale.approver2Department ??
                                    state.labels?.defaultLocale
                                        .approver2Department ??
                                    Constants.approver2Department,
                                Styles.textStyleBlack14,
                                isMandatory: true,
                              ),
                              widget.model?.status == 6
                                  ? FlutterInputField(
                                      initialValue:
                                          state.model.approver2Department?.name,
                                      textFormKey: Keys.approver2EmailKey,
                                      hintText: '',
                                      isEnable: state.model.status != 6 ||
                                          state.model.status != 10 ||
                                          state.model.status != 1 ||
                                          state.model.status != 2 ||
                                          state.model.status != 3 ||
                                          state.model.status != 4 ||
                                          state.model.status != 5 ||
                                          state.model.status != 1 ||
                                          state.model.lock.isEmptyOrNull,
                                      isDisableColor: state.model.status == 6 ||
                                          state.model.status == 10 ||
                                          state.model.status == -1 ||
                                          state.model.status == 2 ||
                                          state.model.status == 3 ||
                                          state.model.status == 4 ||
                                          state.model.status == 5 ||
                                          state.model.status == 1,
                                      onChange: (String value) {
                                        state.model.approver2Department?.name =
                                            value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(state.model);
                                      },
                                      validateTextField: (String? user) {},
                                    )
                                  : TextFieldAddButton(
                                      title:
                                          state.model.approver2Department?.name,
                                      height: 70,
                                      isDisableColor:
                                          (state.model.status == 6 ||
                                                  state.model.status == 10 ||
                                                  state.model.status == -1 ||
                                                  state.model.status == 2 ||
                                                  state.model.status == 3 ||
                                                  state.model.status == 4 ||
                                                  state.model.status == 5 ||
                                                  state.model.status == 1)
                                              ? true
                                              : false,
                                      onTap: () {
                                        if ((state.model.status == 6 ||
                                                state.model.status == 10 ||
                                                state.model.status == -1 ||
                                                state.model.status == 2 ||
                                                state.model.status == 3 ||
                                                state.model.status == 4 ||
                                                state.model.status == 5 ||
                                                state.model.status == 1 ||
                                                !state.model.lock.isEmptyOrNull)
                                            ? false
                                            : true) {
                                          BaseOrganisationDialog()
                                              .departmentDialog(
                                                  context: context,
                                                  organisations:
                                                      state.departments,
                                                  onTap: (Organisation
                                                      department) {
                                                    state
                                                            .model
                                                            .approver2Department
                                                            ?.name =
                                                        department.name;

                                                    BlocProvider.of<
                                                                MaterialMovementDetailsCubit>(
                                                            context)
                                                        .updateDropdownValues(
                                                            approver2Department:
                                                                department);
                                                  },
                                                  orgName:
                                                      'EMPLOYEE_DEPARTMENTS',
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              // if (widget.materialMovement?.status == 5) ...[
                              //   /// Rejection Comment
                              //   CommonWidgets.textDisplay(
                              //     state.labels?.locale.rejectionComment ??
                              //         state.labels?.defaultLocale
                              //             .rejectionComment ??
                              //         Constants.rejectionComment,
                              //     Styles.textStyleBlack14,
                              //     isMandatory: true,
                              //   ),
                              //   FlutterInputField(
                              //     initialValue: state.model.rejectionComment,
                              //     textFormKey: Keys.claimantEmpIdTextController,
                              //     hintText: '',
                              //     isEnable: false,
                              //     isDisableColor: true,
                              //     onChange: (String value) {
                              //       state.model.rejectionComment = value;
                              //       context
                              //           .read<MaterialMovementDetailsCubit>()
                              //           .onModelValueChange(state.model);
                              //     },
                              //     validateTextField: (String? user) {},
                              //   ),
                              //   CommonWidgets.verticalSpacerWidget(height * 0.01),
                              // ],

                              if (state.model.status == 5) ...[
                                /// Rejection Comment
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.rejectionComment ??
                                      state.labels?.defaultLocale
                                          .rejectionComment ??
                                      Constants.rejectionComment,
                                  Styles.textStyleBlack14,
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
                                  isEnable: state.model.status == 5 &&
                                          state.model.lock.isEmptyOrNull
                                      ? true
                                      : false,
                                  isDisableColor: state.model.status == 5,
                                  onChange: (String value) {
                                    state.model.rejectionComment = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Rejected By
                                CommonWidgets.horizentaltextHandling(
                                    state.labels?.locale.rejectedBy ??
                                        state
                                            .labels?.defaultLocale.rejectedBy ??
                                        Constants.rejectedBy,
                                    isMandatory: true,
                                    '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Rejected Date
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.rejectedDate ??
                                      state
                                          .labels?.defaultLocale.rejectedDate ??
                                      Constants.rejectedDate,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                datecreateWidgetdisplay(
                                    state.model.rejectedDate ?? ''),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                                //],
                              ],

                              if (state.model.returnable == true) ...[
                                /// Expected Date Of Return
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.expectedDateOfReturn ??
                                      state.labels?.defaultLocale
                                          .expectedDateOfReturn ??
                                      Constants.expectedDateOfReturn,
                                  Styles.textStyleBlack14,
                                  isMandatory:
                                      widget.model == null ? false : true,
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
                                    height * 0.01),
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
                                  ///Expected Date of Return

                                  /// Approved By
                                  CommonWidgets.verticalTextHandling(
                                      state.labels?.locale.approvedBy ??
                                          state.labels?.defaultLocale
                                              .approvedBy ??
                                          Constants.approvedBy,
                                      state.model.approvedBy ?? ''),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Approved Date
                                  CommonWidgets.verticalTextHandling(
                                      state.labels?.locale.approvedDate ??
                                          state.labels?.defaultLocale
                                              .approvedDate ??
                                          Constants.approvedDate,
                                      state.model.approvedDate ?? ''),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Taken Out By
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.takenOutName ??
                                        state.labels?.defaultLocale
                                            .takenOutName ??
                                        Constants.takenOutBy,
                                    Styles.textStyleBlack14,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  FlutterInputField(
                                    initialValue: state.model.takenOutEmail,
                                    textFormKey: Keys.takenOutByKey,
                                    hintText: '',
                                    isEnable: state.model.status == 6,
                                    isDisableColor: state.model.status != 6,
                                    onChange: (String value) {
                                      state.model.takenOutEmail = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Taken Out By Contact No.
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.takenOutContactNo ??
                                        state.labels?.defaultLocale
                                            .takenOutContactNo ??
                                        Constants.takenOutByContactNo,
                                    Styles.textStyleBlack14,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  FlutterInputField(
                                    initialValue: state.model.takenOutContactNo,
                                    textFormKey: Keys.takenOutContactKey,
                                    hintText: '',
                                    isEnable: state.model.status == 6 &&
                                        state.model.lock.isEmptyOrNull,
                                    isDisableColor: state.model.status != 6 ||
                                        !state.model.lock.isEmptyOrNull,
                                    onChange: (String value) {
                                      state.model.takenOutContactNo = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Taken Out Address
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.takenOutAddress ??
                                        state.labels?.defaultLocale
                                            .takenOutAddress ??
                                        Constants.takenOutAddress,
                                    Styles.textStyleBlack14,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  FlutterInputField(
                                    initialValue: state.model.takenOutAddress,
                                    textFormKey: Keys.takenOutAddressKey,
                                    hintText: '',
                                    showBorder: true,
                                    isEnable: state.model.status == 6 &&
                                        state.model.lock.isEmptyOrNull,
                                    isDisableColor: state.model.status != 6 ||
                                        !state.model.lock.isEmptyOrNull,
                                    onChange: (String value) {
                                      state.model.takenOutAddress = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  //if (state.materialMovement.status == 2 && state.isInward == false) ...[
                                  /// Taken Out On
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale.takenOutDate ??
                                        state.labels?.defaultLocale
                                            .takenOutDate ??
                                        Constants.takenOutOn,
                                    Styles.textStyleBlack14,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  BaseDate().datePickerWidgetLoading(
                                    textController: takenOutOnDateController,
                                    onlyDate: true,
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
                                      height * 0.01),
                                ]
                              ],

                              /// If Status is Rejected(status=7)
                              if (state.model.status == 7) ...[
                                /// Rejected By
                                CommonWidgets.verticalTextHandling(
                                    state.labels?.locale.rejectedBy ??
                                        state
                                            .labels?.defaultLocale.rejectedBy ??
                                        Constants.rejectedBy,
                                    state.model.rejectedBy ?? ''),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Rejected Date
                                CommonWidgets.verticalTextHandling(
                                    state.labels?.locale.rejectedDate ??
                                        state.labels?.defaultLocale
                                            .rejectedDate ??
                                        Constants.rejectedDate,
                                    state.model.rejectedDate ?? ''),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Rejected Comment
                                CommonWidgets.verticalTextHandling(
                                    state.labels?.locale.rejectionComment ??
                                        state.labels?.defaultLocale
                                            .rejectionComment ??
                                        Constants.rejectedComment,
                                    state.model.rejectionComment ?? ''),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],
                            ],

                            if (widget.isInward) ...[
                              /// Senders Name
                              CommonWidgets.textDisplay(
                                state.labels?.locale.materialComingFrom ??
                                    state.labels?.defaultLocale
                                        .materialComingFrom ??
                                    Constants.sendersName,
                                Styles.textStyleBlack14,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.text,
                                initialValue: state.model.materialComingFrom,
                                textFormKey: Keys.sendersKey,
                                hintText: '',
                                isEnable: !isReadOnly,
                                isDisableColor: isReadOnly,
                                onChange: (String value) {
                                  state.model.materialComingFrom = value;
                                  context
                                      .read<MaterialMovementDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Material Coming From Address
                              CommonWidgets.textDisplay(
                                state.labels?.locale.materialComingFromAddress ??
                                    state.labels?.defaultLocale
                                        .materialComingFromAddress ??
                                    Constants
                                        .materialComingFromBriefDescription,
                                Styles.textStyleBlack14,
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
                                isEnable: (state.model.status != 6 ||
                                        state.model.status != 10 ||
                                        state.model.status != -1) &&
                                    state.model.lock.isEmptyOrNull,
                                isDisableColor: state.model.status == 6 ||
                                    state.model.status == 10 ||
                                    state.model.status == 1 ||
                                    !state.model.lock.isEmptyOrNull,
                                validateTextField: (String? user) {},
                                onChange: (String value) {
                                  state.model.materialFromAddress = value;
                                },
                                textInputAction: TextInputAction.newline,
                                textInputType: TextInputType.multiline, //
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Is original receiver receiving
                              CommonWidgets.textDisplay(
                                state.labels?.locale.originalReceiver ??
                                    state.labels?.defaultLocale
                                        .originalReceiver ??
                                    Constants.isOriginalReceiverReceiving,
                                Styles.textStyleBlack14,
                                isMandatory: true,
                              ),
                              RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.originalReceiver ? 1 : 0,
                                onChangedYes: widget.model?.status == 6 ||
                                        widget.model?.status == -1 ||
                                        widget.model?.status == 10 ||
                                        !state.model.lock.isEmptyOrNull
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
                                      },
                                onChangedNo: widget.model?.status == 6 ||
                                        widget.model?.status == -1 ||
                                        widget.model?.status == 10 ||
                                        !state.model.lock.isEmptyOrNull
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
                                      },
                              ),

                              if (state.model.originalReceiver == false) ...[
                                /// Received For
                                Column(
                                  children: [
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.otherReceiverName ??
                                          state.labels?.defaultLocale
                                              .otherReceiverName ??
                                          Constants.receivedFor,
                                      Styles.textStyleBlack14,
                                      isMandatory: true,
                                    ),
                                    TextFieldAddButton(
                                        title: state.model.receiverEmail,
                                        height: 70,
                                        isDisableColor: isReadOnly,
                                        onTap: () {
                                          if (!isReadOnly) {
                                            BaseOrganisationDialog().userDialog(
                                              context: context,
                                              users: state.emailUsers!,
                                              onTap: (BaseUser user) {
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateDropdownValues(
                                                        receiverEmailUser:
                                                            user);
                                                FocusScope.of(context).requestFocus(
                                                    receivedForEmployeeIdFocusNode);
                                              },
                                              locationId:
                                                  state.model.location!.id!,
                                              functionToCall: () {
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
                                        height * 0.01),
                                  ],
                                ),

                                /// Received for Employee Id
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.receiverEmployeeId ??
                                      state.labels?.defaultLocale
                                          .receiverEmployeeId ??
                                      Constants.receivedForEmployeeId,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                                FlutterInputField(
                                  initialValue: state.model.receiverEmployeeId,
                                  textInputType: TextInputType.number,
                                  textFormKey: Keys.claimantEmpIdTextController,
                                  isEnable: !isReadOnly,
                                  isDisableColor: isReadOnly,
                                  focusNode: receivedForEmployeeIdFocusNode,
                                  hintText: '',
                                  onChange: (String value) {
                                    state.model.receiverEmployeeId = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              /// Receiver Department
                              CommonWidgets.textDisplay(
                                state.labels?.locale.receiverDepartment ??
                                    state.labels?.defaultLocale
                                        .receiverDepartment ??
                                    Constants.receiverDepartment,
                                Styles.textStyleBlack14,
                                isMandatory: true,
                              ),
                              TextFieldAddButton(
                                title: state.model.receiverDepartmenttName,
                                height: 70,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  if (!isReadOnly) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    BaseOrganisationDialog().departmentDialog(
                                        context: context,
                                        organisations: state.departments,
                                        onTap: (Organisation department) {
                                          state.model.receiverDepartmenttName =
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              if (state.model.originalReceiver == true) ...[
                                /// Received by
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.receiverName ??
                                      state
                                          .labels?.defaultLocale.receiverName ??
                                      Constants.receivedBy,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                TextFieldAddButton(
                                  title: state.model.receiverEmail,
                                  height: 70,
                                  isDisableColor: isReadOnly,
                                  onTap: () {
                                    if (!isReadOnly) {
                                      BaseOrganisationDialog().userDialog(
                                        context: context,
                                        users: state.emailUsers!,
                                        onTap: (BaseUser user) {
                                          BlocProvider.of<
                                                      MaterialMovementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  receiverEmail: user);
                                        },
                                        locationId: state.model.location!.id!,
                                        functionToCall: () {
                                          // refresh the list
                                          BlocProvider.of<
                                                      MaterialMovementDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              if (state.model.originalReceiver == false) ...[
                                /// Received by
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.receiverName ??
                                      state
                                          .labels?.defaultLocale.receiverName ??
                                      Constants.receivedBy,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),

                                FlutterInputField(
                                  initialValue: state.model.otherReceiverName,
                                  textFormKey: Keys.claimantEmpIdTextController,
                                  isEnable: !isReadOnly,
                                  isDisableColor: isReadOnly,
                                  hintText: '',
                                  focusNode: receivedByFocusNode,
                                  onChange: (String value) {
                                    state.model.otherReceiverName = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),

                                /// Received by Employee Id
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.otherReceiverEmployeeId ??
                                      state.labels?.defaultLocale
                                          .otherReceiverEmployeeId ??
                                      Constants.receiverEmployeeId,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),

                                FlutterInputField(
                                  initialValue:
                                      state.model.otherReceiverEmployeeId,
                                  textFormKey: Keys.claimantEmpIdTextController,
                                  textInputType: TextInputType.number,
                                  isEnable: !isReadOnly,
                                  isDisableColor: isReadOnly,
                                  hintText: '',
                                  onChange: (String value) {
                                    state.model.otherReceiverEmployeeId = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              //],
                              if (state.model.originalReceiver == true) ...[
                                /// Received by Employee Id
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.otherReceiverEmployeeId ??
                                      state.labels?.defaultLocale
                                          .otherReceiverEmployeeId ??
                                      Constants.receiverEmployeeId,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                                FlutterInputField(
                                  initialValue: state.model.receiverEmployeeId,
                                  textFormKey: Keys.claimantEmpIdTextController,
                                  isEnable: !isReadOnly,
                                  isDisableColor: isReadOnly,
                                  textInputType: TextInputType.number,
                                  hintText: '',
                                  onChange: (String value) {
                                    state.model.receiverEmployeeId = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              /// Receiver Signature test
                              buildSignature(
                                controller: receiverSignatureController,
                                label: state.labels?.locale.receiverSign ??
                                    state.labels?.defaultLocale.receiverSign ??
                                    Constants.receiverSignature,
                                spaceHeight: height,
                                state: state,
                              ),

                              /// Security Signature
                              buildSignature(
                                  controller: securitySignatureController,
                                label: state.labels?.locale.entrySecuritySign ??
                                    state.labels?.defaultLocale
                                        .entrySecuritySign ??
                                    Constants.securitySignature,
                                spaceHeight: height,
                                state: state,
                              ),
                              // CommonWidgets.textDisplay(
                              //     Constants.securitySignature,
                              //     Styles.textStyleBlack14,),
                              // CommonWidgets.verticalSpacerWidget(
                              //     height * 0.001),
                              // ElevatedButton(
                              //   onPressed: () {
                              //     // Navigate to the new page when the button is clicked
                              //     Navigator.of(context).push(
                              //       MaterialPageRoute(
                              //         builder: (context) =>
                              //             const SignatureHomePage(),
                              //       ),
                              //     );
                              //   },
                              //   child: const Text('Give Signature'),
                              // ),
                              // CommonWidgets.verticalSpacerWidget(
                              //     height * 0.01),
                            ],
                            if (widget.isInward) ...[
                              /// Is Material Physically Checked
                              CommonWidgets.textDisplay(
                                state.labels?.locale.materialPhysicallyChecked ??
                                    state.labels?.defaultLocale
                                        .materialPhysicallyChecked ??
                                    Constants.isPhysicallyChecked,
                                Styles.textStyleBlack14,
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
                                  onChangedNo: widget.model?.status == 6 ||
                                          widget.model?.status == 10 ||
                                          widget.model?.status == -1 ||
                                          !state.model.lock.isEmptyOrNull
                                      ? null
                                      : (val) {
                                          BlocProvider.of<
                                                      MaterialMovementDetailsCubit>(
                                                  context)
                                              .showFields(
                                            isMaterialPhysicallyChecked: false,
                                            // materialMovement: materialMovement,
                                          );
                                        }),
                            ],

                            if (!widget.isInward && (widget.model?.status == ConstantsIntValue.mmStatusApproved || widget.model?.status == ConstantsIntValue.mmStatusInwardWaiting || widget.model?.status == ConstantsIntValue.mmStatusClosed)) ...[
                              /// Is Material Physically Checked
                              CommonWidgets.textDisplay(
                                state.labels?.locale.materialPhysicallyChecked ??
                                    state.labels?.defaultLocale
                                        .materialPhysicallyChecked ??
                                    Constants.isPhysicallyChecked,
                                Styles.textStyleBlack14,
                                isMandatory: true,
                              ),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.materialPhysicallyChecked
                                          ? 1
                                          : 0,
                                  onChangedYes: (
                                              widget.model?.status != ConstantsIntValue.mmStatusApproved  ||
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
                                  onChangedNo:
                                  widget.model?.status != ConstantsIntValue.mmStatusApproved  ||
                                          !state.model.lock.isEmptyOrNull
                                      ? null
                                      : (val) {
                                          BlocProvider.of<
                                                      MaterialMovementDetailsCubit>(
                                                  context)
                                              .showFields(
                                            isMaterialPhysicallyChecked: false,
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
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                FlutterInputField(
                                  initialValue:
                                  state.model.materialNotCheckedComment,
                                  textFormKey: Keys.claimantEmpIdTextController,
                                  hintText: '',
                                  isEnable: state.model.status == 6,
                                  isDisableColor: state.model.status != 6 ,
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
                                    height * 0.01),
                              ],
                            ],
                            if (
                            (state.model.status == ConstantsIntValue.mmStatusInwardWaiting ||state.model.status == ConstantsIntValue.mmStatusClosed)  &&
                                !widget.isInward) ...[
                              /// Security Signature
                              buildSignature(
                                controller: securitySignatureController,
                                label: state.labels?.locale.entrySecuritySign ??
                                    state.labels?.defaultLocale
                                        .entrySecuritySign ??
                                    Constants.securitySignature,
                                spaceHeight: height,
                                state: state,
                              ),
                              /// Actual Date Of Return
                              CommonWidgets.textDisplay(
                                state.labels?.locale.actualDateOfReturn ??
                                    state.labels?.defaultLocale
                                        .actualDateOfReturn ??
                                    Constants.actualDateOfReturn,
                                Styles.textStyleBlack14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDate().datePickerWidgetLoading(
                                textController: actualDateOfReturnController,
                                onlyDate: true,
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
                                  height * 0.01),

                              ///Material Returned Challan No
                              CommonWidgets.textDisplay(
                                state.labels?.locale
                                    .materialReturnedChallanNo ??
                                    state.labels?.defaultLocale
                                        .materialReturnedChallanNo ??
                                    Constants.materialReturnedChallanNo,
                                Styles.textStyleBlack14,
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
                                isEnable: state.model.status == ConstantsIntValue.mmStatusInwardWaiting
                                    ? true
                                    : false,
                                isDisableColor: state.model.status != ConstantsIntValue.mmStatusInwardWaiting ||
                                    !state.model.lock.isEmptyOrNull
                                    ? true
                                    : false,
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
                                  height * 0.01),

                              ///Return Receiver Email
                              Column(
                                children: [
                                  CommonWidgets.textDisplay(
                                    state.labels?.locale
                                        .returnReceiverMailId ??
                                        state.labels?.defaultLocale
                                            .returnReceiverMailId ??
                                        Constants.returnReceiverEmail,
                                    Styles.textStyleBlack14,
                                    isMandatory: true,
                                  ),
                                  widget.model?.status != 6
                                      ? TextFieldAddButton(
                                    title: state
                                        .model.returnReceiverMailId,
                                    height: 70,
                                    isDisableColor: state.model.status != ConstantsIntValue.mmStatusInwardWaiting ||
                                        !state.model.lock.isEmptyOrNull
                                        ? true
                                        : false,
                                    onTap: () {
                                      if ((state.model.status == ConstantsIntValue.mmStatusInwardWaiting) &&
                                          state.model.lock
                                              .isEmptyOrNull) {
                                        BaseOrganisationDialog()
                                            .userDialog(
                                          context: context,
                                          users: state.emailUsers!,
                                          onTap: (BaseUser user) {
                                            BlocProvider.of<
                                                MaterialMovementDetailsCubit>(
                                                context)
                                                .updateDropdownValues(
                                                returnReceiverMailId:
                                                user);
                                          },
                                          locationId:  state.model.location!.id!,
                                          functionToCall: () {
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
                                    isEnable: state.model.status == ConstantsIntValue.mmStatusInwardWaiting
                                        ? true
                                        : false,
                                    isDisableColor: state.model.status != ConstantsIntValue.mmStatusInwardWaiting ||
                                        !state.model.lock.isEmptyOrNull
                                        ? true
                                        : false,
                                    onChange: (String username) {},
                                    validateTextField:
                                        (String? user) {},
                                  ),
                                ],
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),

                              ///Returned Quantity
                              CommonWidgets.textDisplay(
                                state.labels?.locale.returnQuantity ??
                                    state.labels?.defaultLocale
                                        .returnQuantity ??
                                    Constants.returnedQuantity,
                                Styles.textStyleBlack14,
                                isMandatory: true,
                              ),
                              FlutterInputField(
                                initialValue:
                                '${state.model.returnQuantity ?? ''}',
                                textFormKey:
                                Keys.returnQuantityTextController,
                                isEnable: state.model.status == ConstantsIntValue.mmStatusInwardWaiting
                                    ? true
                                    : false,
                                isDisableColor: state.model.status != ConstantsIntValue.mmStatusInwardWaiting ||
                                    !state.model.lock.isEmptyOrNull
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
                                  height * 0.01),

                            /// Comment
                              CommonWidgets.textDisplay(
                                state.labels?.locale
                                    .materialNotCheckedComment ??
                                    state.labels?.defaultLocale
                                        .materialNotCheckedComment ??
                                    Constants.comment,
                                Styles.textStyleBlack14,
                                isMandatory: false,
                              ),
                              FlutterInputField(
                                initialValue:
                                state.model.materialNotCheckedComment,
                                textFormKey: Keys.claimantEmpIdTextController,
                                hintText: '',
                                isEnable: state.model.status == ConstantsIntValue.mmStatusInwardWaiting
                                    ? true
                                    : false,
                                isDisableColor: state.model.status != ConstantsIntValue.mmStatusInwardWaiting ||
                                    !state.model.lock.isEmptyOrNull
                                    ? true
                                    : false,
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
                                  height * 0.01),
                            ],
                            /// upload
                            widget.model?.status == null ||
                                    widget.model?.status == 0 ||
                                    widget.model?.status == 1
                                ? CommonWidgets.textDisplay(
                                    Constants.upload, Styles.textStyleBlack14)
                                : Container(),
                            widget.model?.status == null ||
                                    widget.model?.status == 0 ||
                                    widget.model?.status == 1
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            (widget.model?.status == null ||
                                        widget.model?.status == 0 ||
                                        widget.model?.status == 1) &&
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
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// SubmitButton
                      if ((state.model.status == 0 ||
                              state.model.status == 8 ||
                              state.model.status == 1 ||
                              state.model.status == 6 ||
                              state.model.status == 7 ||
                              state.model.status == 9 ||
                              state.model.status == null)
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
                state.model.status == 5 ||
                state.model.status == 10 ||
                state.model.status == -1)) ...[
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
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

    log('---------');
    return AbsorbPointer(
      absorbing: !state.model.lock.isEmptyOrNull ||
          state.model.status == -1 ||
          state.model.status == 10,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidgets.textDisplay(
                label,
                Styles.textStyleBlack14,
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
                    color: Colors.grey,
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
                borderRadius: BorderRadius.circular(2.0),
                border: Border.all(
                  color: AppColors.geryLightBackground,
                  width: 1, // Border width
                ),
              ),
              height: 100,
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
                      backgroundColor: Colors.white,
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
            leftImageName: AppIcon.addicon,
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
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.close,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  // Widget cancelButtonDisplay(MaterialMovementDetailsState state) {
  //   bool condition = state.model.id == null ||
  //       state.model.status == ConstantsIntValue.cancelledStatus ||
  //       state.model.status == 10 ||
  //       !state.model.lock.isEmptyOrNull;
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
  //             Navigator.pop(context);
  //             Navigator.pop(context);
  //             updateRecordStatus(state);
  //           },
  //           positiveBtnText: Constants.yes,
  //           negativeBtnText: Constants.no);
  //       showDialog(context: context, builder: (BuildContext context) => dialog);
  //     },
  //   );
  // }

  // void updateRecordStatus(MaterialMovementDetailsState state) {
  //   log('---updateRecordStatus---');
  //   if (state.model.id != null) {
  //     BlocProvider.of<MaterialMovementDetailsCubit>(context)
  //         .updateStatus(id: state.model.id.toString());
  //     Navigator.popAndPushNamed(context, materialMovementInwardsOutwardsRoute,
  //         arguments: {"isInward": widget.isInward});
  //   } else {
  //     Navigator.pop(context);
  //   }
  // }

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
                    fixedSize: const Size(140, 50),
                    backgroundColor: !isReadOnly
                        ? AppColors.navigationSkyBlueColor
                        : AppColors.geryLightBackground,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return UploadAttachment(
                            userdetails: state.loggedInUserDetails ?? User(),
                            getFiles: getFiles,
                            inwardState: state,
                            onImageSelected: (ImageContent data) {
                              log('-------function---onImageSelected---------');
                              List<ImageContent>? files = [];
                              files.add(data);
                              for (ImageContent image in getFiles.toList()) {
                                files.add(image);
                              }
                              BlocProvider.of<MaterialMovementDetailsCubit>(
                                      context)
                                  .addAttchment(files);
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
