import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/key_issuance_process_record/bloc/key_issuance_process_record_bloc.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/services/key_management_issuance_services.dart';

class AddKeyIssuanceProcessPopUp extends StatefulWidget {
  const AddKeyIssuanceProcessPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.model,
    required this.parentStatus,
    required this.mainContext,
    required this.keyDescriptions,
    required this.selectedKeyDescription,
    this.extraProperties,
    this.lock,
  });

  final String title;
  final Function onSubmit;
  final KeyIssuanceProcessRecord model;
  final BuildContext mainContext;
  final List<Organisation> keyDescriptions;
  final Organisation? selectedKeyDescription;
  final int parentStatus;
  final ExtraProperties? extraProperties;
  final String? lock;

  @override
  State<AddKeyIssuanceProcessPopUp> createState() => AddContactPopUpState();
}

class AddContactPopUpState extends State<AddKeyIssuanceProcessPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController keyDescriptionController = TextEditingController();
  TextEditingController keyTypeController = TextEditingController();

  TextEditingController noOfKeysController = TextEditingController();
  TextEditingController alreadyIssuedKeysController = TextEditingController();
  TextEditingController availableKeysController = TextEditingController();

  TextEditingController numberOfKeysIssuedController = TextEditingController();
  TextEditingController returnedKeysController = TextEditingController();
  TextEditingController notReturnedKeysController = TextEditingController();
  TextEditingController lostKeysController = TextEditingController();
  TextEditingController damagedKeysController = TextEditingController();
  Organisation? selectedKeyDescription;

  late bool isReadOnly;
  @override
  void initState() {
    super.initState();

    isReadOnly = widget.lock.isEmptyOrNull ? false : true;
    log('--widget.model.available--111-${widget.model.available}-----');

    selectedKeyDescription = widget.selectedKeyDescription;
    log('--widget.model.available---${widget.model.available}-----');
    availableKeysController.text = widget.model.available == null
        ? '0'
        : widget.model.available.toString();
    widget.model.available = int.tryParse(availableKeysController.text);

    log('--selectedKeyDescription---${selectedKeyDescription?.noKeys}---');
    if (selectedKeyDescription != null) {
      keyDescriptionController.text = selectedKeyDescription!.keyDescription!;

      noOfKeysController.text = (selectedKeyDescription?.noKeys == null
          ? ''
          : selectedKeyDescription?.noKeys.toString())!;

      alreadyIssuedKeysController.text =
          (selectedKeyDescription?.noKeysIssued == null
              ? ''
              : selectedKeyDescription?.noKeysIssued.toString())!;

      // availableKeysController.text = (selectedKeyDescription!.noKeys! -
      //         selectedKeyDescription!.noKeysIssued!)
      //     .toString();

      // num sum =
      //     (widget.model.available ?? 0) - (widget.model.noKeysIssued ?? 0);
      // widget.model.available = sum.toInt();

      // availableKeysController.text = sum.toString();

      // availableKeysController.text = widget.model.available.toString();
      noOfKeysController.text =
          widget.selectedKeyDescription!.noKeys.toString();
      // noOfKeysIssuedController.text= widget.model.noKeysIssued.toString();
    }

    /// Key Type Dropdown
    if (widget.model.keyType != null) {
      Label matchingLabel = keyTypeDropDownValues.firstWhere(
          (label) => label.value == widget.model.keyType.toString());

      keyTypeController.text = matchingLabel.key;
    }
    // widget.model.noKeysIssued = int.tryParse(numberOfKeysIssuedController.text);

    // numberOfKeysIssuedController.text = widget.model.noKeysIssued == null
    //     ? '0'
    //     : widget.model.noKeysIssued.toString();
    // widget.model.noKeysIssued = int.tryParse(numberOfKeysIssuedController.text);

    numberOfKeysIssuedController.text = widget.model.returned == null
        ? '0'
        : widget.model.noKeysIssued.toString();
    // widget.model.returned = int.tryParse(numberOfKeysIssuedController.text);

    returnedKeysController.text =
        widget.model.returned == null ? '0' : widget.model.returned.toString();
    widget.model.returned = int.tryParse(returnedKeysController.text);

    notReturnedKeysController.text = widget.model.notReturned == null
        ? '0'
        : widget.model.notReturned.toString();

    widget.model.notReturned = int.tryParse(notReturnedKeysController.text);

    lostKeysController.text =
        widget.model.lost == null ? '0' : widget.model.lost.toString();
    widget.model.lost = int.tryParse(lostKeysController.text);

    damagedKeysController.text =
        widget.model.damaged == null ? '0' : widget.model.damaged.toString();
    widget.model.damaged = int.tryParse(damagedKeysController.text);
  }

  @override
  Widget build(BuildContext context) {
    KeyIssuanceProcessRecordState state = const KeyIssuanceProcessRecordState();
    log('no of keys issued ${widget.model.noKeysIssued}---');
    log('--keyDescriptions----${widget.keyDescriptions.length}--');
    log('no of keys not returned ${widget.model.notReturned}---');

    bool editableFieldsHandOverStatus;
    editableFieldsHandOverStatus = widget.parentStatus !=
            ConstantsIntValue.issuanceDraftStatus &&
        widget.parentStatus != ConstantsIntValue.issuanceClosedDamagedStatus &&
        widget.parentStatus != ConstantsIntValue.issuanceClosedLostStatus &&
        widget.parentStatus !=
            ConstantsIntValue.issuanceClosedLostDamagedStatus &&
        widget.parentStatus != ConstantsIntValue.issuanceLostDamagedStatus &&
        widget.parentStatus != ConstantsIntValue.issuanceClosedStatus &&
        !(widget.extraProperties != null &&
            !widget.extraProperties!.hasWritePermission!);

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      title: null,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.newColor3.withValues(alpha: 0.7),
                  AppColors.newColor,
                  AppColors.newColor3.withValues(alpha: 0.7),
                  // Color(0xFF6474C6).withOpacity(0.14)
                ],
                stops: [0.02, 0.35, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(27),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.6),
                width: 0.7,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.0),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SizedBox(
              height: height / 1.8,
              width: width,
              child: Column(
                // clipBehavior: Clip.none,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.title,
                      style: Styles.textFontSet(
                          18,
                          AppColors.white,
                          FontWeight.normal,
                          Constants.customFontSemiBoldFamily),
                    ),
                  ),
                  CommonWidgets.verticalSpacerWidget(height * 0.01),
                  const Divider(
                    thickness: 0.5,
                  ),
                  CommonWidgets.verticalSpacerWidget(height * 0.01),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ///Key Description
                            Column(
                              children: [
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.keyDescription ??
                                      state.labels?.defaultLocale
                                          .keyDescription ??
                                      Constants.keyDescription,
                                  Styles.textStyleWhite14,
                                  isMandatory: true,
                                ),
                                TextFieldAddButton(
                                  title: keyDescriptionController.text,
                                  height: 70,
                                  isDisableColor: !(widget.parentStatus == 0 &&
                                      !(widget.extraProperties != null &&
                                          !widget.extraProperties!
                                              .hasWritePermission! &&
                                          widget.lock.isEmptyOrNull)),
                                  onTap: () {
                                    if (isReadOnly) {
                                      return;
                                    }
                                    if (widget.parentStatus == 0 &&
                                        !(widget.extraProperties != null &&
                                            !widget.extraProperties!
                                                .hasWritePermission! &&
                                            widget.lock.isEmptyOrNull)) {
                                      BaseOrganisationDialog().departmentDialog(
                                        context: context,
                                        organisations: widget.keyDescriptions,
                                        onTap: (Organisation org) {
                                          selectedKeyDescription = org;
                                          keyDescriptionController.text =
                                              org.keyDescription ?? '';
                                          widget.model.kmId = org.id;

                                          //TODO: need to set key description in model
                                          // widget.model.
                                          log('-org.keyName----${org.id}-');
                                          log('-org.keyName----${org.keyDescription}-');
                                          log('-org.keyName----${org.noKeys}-');
                                          log('-org.keyName----${org.noKeysIssued}-');

                                          keyDescriptionController.text =
                                              org.keyDescription ?? '';

                                          setState(() {
                                            log('-setstate-');
                                            keyDescriptionController.text =
                                                org.keyDescription ?? '';
                                            selectedKeyDescription = org;
                                            keyTypeController.clear();
                                            noOfKeysController.clear();
                                            alreadyIssuedKeysController.clear();
                                            availableKeysController.clear();
                                            numberOfKeysIssuedController
                                                .clear();
                                          });
                                        },
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Key Type
                            CommonWidgets.textDisplay(
                                state.labels?.locale.keyType ??
                                    state.labels?.defaultLocale.keyType ??
                                    Constants.keyType,
                                isMandatory: true,
                                Styles.textStyleWhite14),
                            CommonWidgets.verticalSpacerWidget(height * 0.002),

                            BaseDropDown().getDropDown(
                              isDisabled: !(widget.parentStatus == 0 &&
                                  !(widget.extraProperties != null &&
                                      !widget.extraProperties!
                                          .hasWritePermission!)),
                              textController: keyTypeController,
                              items: keyTypeDropDownValues,
                              onTap: () {
                                if (isReadOnly) {
                                  return;
                                }
                                if (widget.parentStatus == 0 &&
                                    !(widget.extraProperties != null &&
                                        !widget.extraProperties!
                                            .hasWritePermission!)) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: keyTypeDropDownValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) async {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          keyTypeDropDownValues.firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      keyTypeController.text =
                                          selectedLabel.key;
                                      widget.model.keyType =
                                          int.tryParse(selectedLabel.value);
                                      // Call the API
                                      bool isMasterKey =
                                          selectedLabel.value == '1'
                                              ? false
                                              : true;
                                      // Call the API

                                      log('---selectedKeyDescription---$selectedKeyDescription---');

                                      if (selectedKeyDescription != null) {
                                        Organisation keyDescription =
                                            await KeyManagementIssuanceServices()
                                                .getKeyDescById(
                                                    id: selectedKeyDescription!
                                                            .id ??
                                                        0,
                                                    isMasterKey: isMasterKey);

                                        setState(() {
                                          widget.model.available =
                                              keyDescription.available;

                                          noOfKeysController.text =
                                              keyDescription.noKeys.toString();

                                          widget.model.noKeysIssued =
                                              keyDescription.noKeysIssued;
                                          alreadyIssuedKeysController.text =
                                              keyDescription.noKeysIssued
                                                  .toString();

                                          // widget.model.available =
                                          //     keyDescription.noKeys! -
                                          //         keyDescription.noKeysIssued!;

                                          // availableKeysController.text =
                                          //     (keyDescription.noKeys! -
                                          //             keyDescription.noKeysIssued!)
                                          //         .toString();
                                          widget.model.available =
                                              keyDescription.available;
                                          availableKeysController.text =
                                              keyDescription.available
                                                  .toString();
                                        });
                                      }
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// No of Keys
                            CommonWidgets.textDisplay(
                              state.labels?.locale.noKeys ??
                                  state.labels?.defaultLocale.noKeys ??
                                  Constants.noOfKeys,
                              Styles.textStyleWhite14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.phoneNumberKey,
                              controller: noOfKeysController,
                              hintText: '',
                              isEnable: false,
                              isDisableColor: true,
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Already Issued Keys
                            CommonWidgets.textDisplay(
                              state.labels?.locale.alreadyIssued ??
                                  state.labels?.defaultLocale.alreadyIssued ??
                                  Constants.alreadyIssuedKeys,
                              Styles.textStyleWhite14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.phoneNumberKey,
                              controller: alreadyIssuedKeysController,
                              hintText: '',
                              isEnable: false,
                              isDisableColor: true,
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Keys Available
                            CommonWidgets.textDisplay(
                              state.labels?.locale.keysAvailable ??
                                  state.labels?.defaultLocale.keysAvailable ??
                                  Constants.keysAvailable,
                              Styles.textStyleWhite14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.aprrover1DepartmentKey,
                              controller: availableKeysController,
                              hintText: '',
                              isEnable: false,
                              isDisableColor: true,
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// No. Keys Issued
                            CommonWidgets.textDisplay(
                              state.labels?.locale.noKeysIssued ??
                                  state.labels?.defaultLocale.noKeysIssued ??
                                  Constants.noKeysIssued,
                              Styles.textStyleWhite14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.bu2ContactNOKey,
                              controller: numberOfKeysIssuedController,
                              hintText: '',
                              isEnable: widget.parentStatus == 0 &&
                                  !(widget.extraProperties != null &&
                                      !widget.extraProperties!
                                          .hasWritePermission!),
                              isDisableColor: true,
                              onChange: (String value) {
                                widget.model.noKeysIssued = int.tryParse(value);
                                // num sum = (selectedKeyDescription!.noKeys ?? 0) -
                                //     (widget.model.noKeysIssued ?? 0);
                                // availableKeysController.text = sum.toString();
                                // widget.model.available = sum.toInt();
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// keys Returned
                            CommonWidgets.textDisplay(
                              state.labels?.locale.keysReturned ??
                                  state.labels?.defaultLocale.keysReturned ??
                                  Constants.keysReturned,
                              Styles.textStyleWhite14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.bu2ContactNOKey,
                              controller: returnedKeysController,
                              hintText: '',
                              isEnable: editableFieldsHandOverStatus &&
                                  widget.lock.isEmptyOrNull,
                              isDisableColor: true,
                              onChange: (String value) {
                                widget.model.returned = int.tryParse(value);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// keys Not Returned
                            CommonWidgets.textDisplay(
                              state.labels?.locale.keysNotReturned ??
                                  state.labels?.defaultLocale.keysNotReturned ??
                                  Constants.keysNotReturned,
                              Styles.textStyleWhite14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.addressKey,
                              controller: notReturnedKeysController,
                              hintText: '',
                              isEnable: editableFieldsHandOverStatus &&
                                  widget.lock.isEmptyOrNull,
                              isDisableColor: true,
                              onChange: (String value) {
                                widget.model.notReturned = int.tryParse(value);
                                notReturnedKeysController.text = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// keys Lost
                            CommonWidgets.textDisplay(
                              state.labels?.locale.keysLost ??
                                  state.labels?.defaultLocale.keysLost ??
                                  Constants.keysLost,
                              Styles.textStyleWhite14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.phoneNumberKey,
                              controller: lostKeysController,
                              hintText: '',
                              isEnable: editableFieldsHandOverStatus &&
                                  widget.lock.isEmptyOrNull,
                              isDisableColor: true,
                              onChange: (String value) {
                                widget.model.lost = int.tryParse(value);
                                lostKeysController.text = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// keys Damaged
                            CommonWidgets.textDisplay(
                              state.labels?.locale.keysDamaged ??
                                  state.labels?.defaultLocale.keysDamaged ??
                                  Constants.keysDamaged,
                              Styles.textStyleWhite14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.phoneNumberKey,
                              controller: damagedKeysController,
                              hintText: '',
                              isEnable: editableFieldsHandOverStatus &&
                                  widget.lock.isEmptyOrNull,
                              isDisableColor: true,
                              onChange: (String value) {
                                widget.model.damaged = int.tryParse(value);
                                damagedKeysController.text = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            buttonViews(widget.mainContext, width, state),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      }),
    );
  }

  Widget buttonViews(
      BuildContext context, double width, KeyIssuanceProcessRecordState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        cancelButton(width),
        if (widget.parentStatus !=
                ConstantsIntValue.issuanceClosedDamagedStatus &&
            widget.parentStatus != ConstantsIntValue.issuanceClosedLostStatus &&
            widget.parentStatus !=
                ConstantsIntValue.issuanceClosedLostDamagedStatus &&
            widget.parentStatus !=
                ConstantsIntValue.issuanceLostDamagedStatus &&
            widget.parentStatus != ConstantsIntValue.issuanceClosedStatus &&
            !(widget.extraProperties != null &&
                !widget.extraProperties!.hasWritePermission!) &&
            !isReadOnly) ...[saveButton(width, widget.onSubmit)],
      ],
    );
  }

  Widget cancelButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.close,
      buttonTextKey: Keys.cancelButtonText,
      foregroundColor: AppColors.white,
      textStyle: Styles.styleHeaderGreyText16,
      backgroundColor: AppColors.newColor,
      boarderColor: AppColors.white,
      onTap: () {
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      },
    );
  }

  Widget saveButton(double width, Function onSubmit) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.saveButton),
      buttonText: Constants.save,
      buttonTextKey: Keys.saveButtonText,
      boarderColor: AppColors.navigationSkyBlueColor,
      backgroundColor: AppColors.navigationSkyBlueColor,
      foregroundColor: Colors.white,
      textStyle: Styles.textStyleSemiBold16White,
      onTap: () {
        if (!isFormValid.status) {
          Validator().showToast(
            context,
            isFormValid.message,
          );
          return;
        }

        // log('-widget.model.totalPenaltyAmount--${widget.model.totalPenaltyAmount}-----');
        onSubmit(widget.model);
        Navigator.pop(context);
      },
    );
  }

  ErrorResponse get isFormValid {
    // TODO: Uncomment this after testing
    // if (widget.model.kmId == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter No. of Keys Description.');
    // }
    // if (widget.model.keyType == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Key Type');
    // }
    // if (widget.model.noKeysIssued == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter No. of Keys Issued.');
    // }
    //
    // if (widget.model.noKeysIssued != null &&
    //     widget.model.noKeysIssued! > int.parse(noOfKeysController.text)) {
    //   return const ErrorResponse(
    //     status: false,
    //     message: 'Please enter valid Number of Keys Issued',
    //   );
    // }
    //
    // if (widget.parentStatus == ConstantsIntValue.issuanceDraftStatus &&
    //     widget.model.noKeysIssued == 0) {
    //   return const ErrorResponse(
    //     status: false,
    //     message: 'Please enter valid Number of Keys Issued',
    //   );
    // }
    // if (widget.parentStatus == ConstantsIntValue.issuanceHandedOverStatus &&
    //     widget.model.noKeysIssued !=
    //         (widget.model.returned! +
    //             widget.model.notReturned! +
    //             widget.model.lost! +
    //             widget.model.damaged!)) {
    //   return const ErrorResponse(
    //     status: false,
    //     message: 'Values not matching with no of keys issued',
    //   );
    // }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
