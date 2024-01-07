import 'dart:developer';

import 'package:db_atom/index.dart';

import '../../services/key_management_issuance_services.dart';

class AddKeyIssuanceProcessPopUp extends StatefulWidget {
  const AddKeyIssuanceProcessPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.model,
    required this.mainContext,
    required this.keyDescriptions,
  });

  final String title;
  final Function onSubmit;
  final KeyIssuanceProcessRecord model;
  final BuildContext mainContext;
  final List<Organisation> keyDescriptions;

  @override
  State<AddKeyIssuanceProcessPopUp> createState() => AddContactPopUpState();
}

class AddContactPopUpState extends State<AddKeyIssuanceProcessPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController keyDescriptionController = TextEditingController();
  TextEditingController keysController = TextEditingController();

  TextEditingController noOfKeysIssuedController = TextEditingController();
  TextEditingController alreadyIssuedKeysController = TextEditingController();
  TextEditingController keysAvailableController = TextEditingController();

  TextEditingController numberOfKeysController = TextEditingController();
  TextEditingController keysReturnedController = TextEditingController();
  TextEditingController keysNotReturnedController = TextEditingController();
  TextEditingController keysLostController = TextEditingController();
  TextEditingController keysDamagedController = TextEditingController();
  Organisation? selectedKeyDescription;

  @override
  void initState() {
    super.initState();
    // penaltyAmountController.text = widget.model.penaltyAmount == null
    //     ? ''
    //     : widget.model.penaltyAmount.toString();
    //
    // num? sum = (widget.model.totalPenaltyAmount ??
    //     (widget.model.penaltyAmount ?? 0) *
    //         (widget.model.totalViolations ?? 0));
    // totalPenaltyAmountController.text = sum.toString();
    // numberOfKeysController.text = widget.model.totalViolations == null
    //     ? ''
    //     : widget.model.totalViolations.toString();
    // updateStaffCategoryText();
  }

  @override
  Widget build(BuildContext context) {
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
                          TextfieldAddButton(
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

                      /// Keys
                      CommonWidgets.textDisplay(
                          Constants.keys,
                          isMandatory: true,
                          Styles.textStyleBlack14),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),

                      BaseDropDown().getDropDown(
                        isDisabled: false,
                        textController: keysController,
                        items: keysDropDownValues,
                        onTap: () {
                          BaseDropDown().assetTypeDialog(
                            context: context,
                            dropDownValues: keysDropDownValues
                                .map((label) => label.key)
                                .toList(),
                            onTap: (String value) async {
                              Label? selectedLabel;
                              selectedLabel = keysDropDownValues.firstWhere(
                                (label) => label.key == value,
                                orElse: () => const Label(key: '', value: ''),
                              );
                              keysController.text = selectedLabel.key;
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

                                  widget.model.available = keyDescription.noKeys! -
                                      keyDescription.noKeysIssued!;

                                  widget.model.notReturned = keyDescription.notReturned;

                                  noOfKeysIssuedController.text =
                                      keyDescription.noKeys.toString();

                                  alreadyIssuedKeysController.text =
                                      keyDescription.noKeysIssued.toString();

                                  keysAvailableController.text =
                                      (keyDescription.noKeys! -
                                              keyDescription.noKeysIssued!)
                                          .toString();
                                  keysNotReturnedController.text =
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
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        textFieldController: noOfKeysIssuedController,
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
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        textFieldController: alreadyIssuedKeysController,
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
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.aprrover1DepartmentKey,
                        textFieldController: keysAvailableController,
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
                      FlutterInputField(
                        // initialValue: '${widget.model.totalViolations ?? ''}',
                        keyboardType: TextInputType.number,
                        textFieldController: numberOfKeysController,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          // widget.model.totalViolations = num.parse(value);
                          //
                          // num sum = (widget.model.penaltyAmount ?? 0) *
                          //     num.parse(value);
                          // log('--sum-----$sum---');
                          // totalPenaltyAmountController.text = sum.toString();
                          //
                          // widget.model.totalPenaltyAmount = sum;
                          // numberOfKeysController.text = value;
                          // log('--totalPenaltyAmountController.text-----${totalPenaltyAmountController.text}---');
                          //
                          // setState(() {
                          //   // totalPenaltyAmountController.text = sum.toString();
                          // });
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
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.bu2ContactNOKey,
                        textFieldController: keysReturnedController,
                        hintText: '',
                        isEnable: false,
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
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.addressKey,
                        textFieldController: keysNotReturnedController,
                        hintText: '',
                        isEnable: false,
                        isDisableColor: true,
                        onChange: (String value) {
                          widget.model.notReturned = int.tryParse(value);
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
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        textFieldController: keysLostController,
                        hintText: '',
                        isEnable: false,
                        isDisableColor: true,
                        onChange: (String value) {
                          widget.model.lost = int.tryParse(value);
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
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        textFieldController: keysDamagedController,
                        hintText: '',
                        isEnable: false,
                        isDisableColor: true,
                        onChange: (String value) {},
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
    // if (widget.model.violation == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Violation.');
    // }
    // if (widget.model.staffCategory == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Staff Category.');
    // }
    // if (widget.model.totalViolations == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Total No of Violations');
    // }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
