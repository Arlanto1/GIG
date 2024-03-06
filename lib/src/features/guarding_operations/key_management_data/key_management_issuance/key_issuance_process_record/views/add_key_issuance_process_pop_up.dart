import 'dart:developer';

import 'package:db_atom/index.dart';
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
  });

  final String title;
  final Function onSubmit;
  final KeyIssuanceProcessRecord model;
  final BuildContext mainContext;
  final List<Organisation> keyDescriptions;
  final Organisation? selectedKeyDescription;
  final int parentStatus;

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

  @override
  void initState() {
    super.initState();

    selectedKeyDescription = widget.selectedKeyDescription;

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
      availableKeysController.text = widget.model.available.toString();
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

    numberOfKeysIssuedController.text =
    widget.model.returned == null ? '0' : widget.model.noKeysIssued.toString();
    widget.model.returned = int.tryParse(numberOfKeysIssuedController.text);

    returnedKeysController.text =
        widget.model.returned == null ? '0' : widget.model.returned.toString();
    widget.model.returned = int.tryParse(returnedKeysController.text);

    notReturnedKeysController.text = widget.model.returned == null
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
    log('no of keys issued ${widget.model.noKeysIssued}---');
    log('--keyDescriptions----${widget.keyDescriptions.length}--');
    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: Styles.textFontSet(18, AppColors.textgreyThemecolor,
              FontWeight.normal, Constants.customFontSemiBoldFamily),
        ),
      ),
      backgroundColor: AppColors.backgroundWhitecolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return SizedBox(
          height: height / 1.8,
          width: width,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ///Key Description
                      Column(
                        children: [
                          CommonWidgets.textDisplay(
                            Constants.keyDescription,
                            Styles.textStyleBlack14,
                            isMandatory: true,
                          ),
                          TextFieldAddButton(
                            title: keyDescriptionController.text,
                            height: 70,
                            isDisableColor: false,
                            onTap: () {
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
                                  });
                                },
                              );
                            },
                          )
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Key Type
                      CommonWidgets.textDisplay(
                          Constants.keyType,
                          isMandatory: true,
                          Styles.textStyleBlack14),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),

                      BaseDropDown().getDropDown(
                        isDisabled: false,
                        textController: keyTypeController,
                        items: keyTypeDropDownValues,
                        onTap: () {
                          BaseDropDown().assetTypeDialog(
                            context: context,
                            dropDownValues: keyTypeDropDownValues
                                .map((label) => label.key)
                                .toList(),
                            onTap: (String value) async {
                              Label? selectedLabel;
                              selectedLabel = keyTypeDropDownValues.firstWhere(
                                (label) => label.key == value,
                                orElse: () => const Label(key: '', value: ''),
                              );
                              keyTypeController.text = selectedLabel.key;
                              widget.model.keyType =
                                  int.tryParse(selectedLabel.value);
                              // Call the API
                              bool isMasterKey =
                                  selectedLabel.value == '1' ? false : true;
                              // Call the API

                              log('---selectedKeyDescription---$selectedKeyDescription---');

                              if (selectedKeyDescription != null) {
                                Organisation keyDescription =
                                    await KeyManagementIssuanceServices()
                                        .getKeyDescById(
                                            id: selectedKeyDescription!.id ?? 0,
                                            isMasterKey: isMasterKey);

                                setState(() {
                                  widget.model.notReturned =
                                      keyDescription.notReturned;

                                  noOfKeysController.text =
                                      keyDescription.noKeys.toString();

                                  widget.model.noKeysIssued =
                                      keyDescription.noKeysIssued;
                                  alreadyIssuedKeysController.text =
                                      keyDescription.noKeysIssued.toString();

                                  widget.model.available =
                                      keyDescription.noKeys! -
                                          keyDescription.noKeysIssued!;
                                  availableKeysController.text =
                                      (keyDescription.noKeys! -
                                              keyDescription.noKeysIssued!)
                                          .toString();

                                  widget.model.notReturned =
                                      keyDescription.notReturned;
                                  notReturnedKeysController.text =
                                      keyDescription.notReturned.toString();
                                });
                              }
                            },
                          );
                        },
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// No of Keys
                      CommonWidgets.textDisplay(
                        Constants.noOfKeys,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
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
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Already Issued Keys
                      CommonWidgets.textDisplay(
                        Constants.alreadyIssuedKeys,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
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
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Keys Available
                      CommonWidgets.textDisplay(
                        Constants.keysAvailable,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
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
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// No. Keys Issued
                      CommonWidgets.textDisplay(
                        Constants.noKeysIssued,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      // FlutterInputField(
                      //   // initialValue: '${widget.model.totalViolations ?? ''}',
                      //   textInputType: TextInputType.number,
                      //   controller: numberOfKeysController,
                      //   textFormKey: Keys.phoneNumberKey,
                      //   hintText: '',
                      //   isEnable: widget.parentStatus == 0,
                      //
                      //   isDisableColor: false,
                      //   onChange: (String value) {
                      //     // widget.model.totalViolations = num.parse(value);
                      //     //
                      //     // num sum = (widget.model.penaltyAmount ?? 0) *
                      //     //     num.parse(value);
                      //     // log('--sum-----$sum---');
                      //     // totalPenaltyAmountController.text = sum.toString();
                      //     //
                      //     // widget.model.totalPenaltyAmount = sum;
                      //     // numberOfKeysController.text = value;
                      //     // log('--totalPenaltyAmountController.text-----${totalPenaltyAmountController.text}---');
                      //     //
                      //     // setState(() {
                      //     //   // totalPenaltyAmountController.text = sum.toString();
                      //     // });
                      //   },
                      //   validateTextField: (String? user) {},
                      // ),
                      // CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        textInputType: TextInputType.number,
                        textFormKey: Keys.bu2ContactNOKey,
                        controller: numberOfKeysIssuedController,
                        hintText: '',
                        isEnable: widget.parentStatus == 0,
                        isDisableColor: true,
                        onChange: (String value) {
                          widget.model.noKeysIssued = int.tryParse(value);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),


                      /// keys Returned
                      CommonWidgets.textDisplay(
                        Constants.keysReturned,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        textInputType: TextInputType.number,
                        textFormKey: Keys.bu2ContactNOKey,
                        controller: returnedKeysController,
                        hintText: '',
                        isEnable: widget.parentStatus == 1,
                        isDisableColor: true,
                        onChange: (String value) {
                          widget.model.returned = int.tryParse(value);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// keys Not Returned
                      CommonWidgets.textDisplay(
                        Constants.keysNotReturned,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        textInputType: TextInputType.number,
                        textFormKey: Keys.addressKey,
                        controller: notReturnedKeysController,
                        hintText: '',
                        isEnable: widget.parentStatus == 1,
                        isDisableColor: true,
                        onChange: (String value) {
                          widget.model.notReturned = int.tryParse(value);
                          notReturnedKeysController.text = value;
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// keys Lost
                      CommonWidgets.textDisplay(
                        Constants.keysLost,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        textInputType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        controller: lostKeysController,
                        hintText: '',
                        isEnable: widget.parentStatus == 1,
                        isDisableColor: true,
                        onChange: (String value) {
                          widget.model.lost = int.tryParse(value);
                          lostKeysController.text = value;
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// keys Damaged
                      CommonWidgets.textDisplay(
                        Constants.keysDamaged,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        textInputType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        controller: damagedKeysController,
                        hintText: '',
                        isEnable: widget.parentStatus == 1,
                        isDisableColor: true,
                        onChange: (String value) {
                          widget.model.damaged = int.tryParse(value);
                          damagedKeysController.text = value;
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      buttonViews(widget.mainContext, width),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buttonViews(BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        cancelButton(width),
        saveButton(width, widget.onSubmit)
      ],
    );
  }

  Widget cancelButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButtonText,
      foregroundColor: AppColors.textgreyThemecolor,
      textStyle: Styles.styleHeaderGreyText16,
      backgroundColor: AppColors.white,
      boarderColor: AppColors.textgreyThemecolor,
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
      boarderColor: AppColors.navigationSkybluecolor,
      backgroundColor: AppColors.navigationSkybluecolor,
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
    if (widget.model.kmId == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter No. of Keys Description.');
    }
    if (widget.model.keyType == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Key Type');
    }
    if (widget.model.noKeysIssued == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter No. of Keys Issued.');
    }

    if (widget.model.noKeysIssued != null && widget.model.noKeysIssued! > selectedKeyDescription!.noKeys!) {
      return const ErrorResponse(
          status: false, message: 'Please enter valid Number of Keys Issued');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
