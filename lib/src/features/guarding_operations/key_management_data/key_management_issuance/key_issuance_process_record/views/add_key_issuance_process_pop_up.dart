import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_issuance/models/key_issuance_process_model.dart';

import '../../../../../../models/keyDescription.dart';

class AddKeyIssuanceProcessPopUp extends StatefulWidget {
  const AddKeyIssuanceProcessPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.model,
    required this.mainContext,
    required this.users,
    required this.getKeyDescriptionValues,
  });

  final String title;
  final Function onSubmit;
  final KeyIssuanceProcessRecord model;
  final List<Organisation> users;
  final BuildContext mainContext;
  final Map<String, dynamic> getKeyDescriptionValues;

  @override
  State<AddKeyIssuanceProcessPopUp> createState() => AddContactPopUpState();
}

class AddContactPopUpState extends State<AddKeyIssuanceProcessPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController keyDescriptionController = TextEditingController();
  TextEditingController keysController = TextEditingController();
  TextEditingController noOfKeysIssuedController = TextEditingController();
  TextEditingController keysAvailableController = TextEditingController();
  TextEditingController numberOfKeysController = TextEditingController();
  TextEditingController keysReturnedController = TextEditingController();
  TextEditingController keysNotReturnedController = TextEditingController();
  TextEditingController keysLostController = TextEditingController();
  TextEditingController keysDamagedController = TextEditingController();

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

  // void updateStaffCategoryText() {
  //  // String staffCategoryValue = widget.model.staffCategory.toString();
  //   log('--staffCategoryValue---$staffCategoryValue--');
  //   Label? matchingLabel = staffCategoryDropDownValues
  //       .firstOrNullWhere((element) => element.value == staffCategoryValue);
  //
  //   log('--matchingLabel?.value---${matchingLabel?.value}--');
  //
  //   keysController.text = matchingLabel?.key ?? '';
  //   log('--staffCategoryController.text---${keysController.text}--');
  // }

  @override
  Widget build(BuildContext context) {
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
                            title: widget.model.keyDescription?.name ?? '',
                            height: 70,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().departmentDialog(
                                context: context,
                                departments: widget.users,
                                onTap: (Organisation org) {
                                  keyDescriptionController.text =
                                      org.name ?? '';

                                  log('-org.keyName----${org.keyName}-');

                                  keyDescriptionController.text =
                                      org.keyName ?? ''; // Penalty Amount
                                  // widget.model.violation ??= Organisation();
                                  // widget.model.violation = org;
                                  // widget.model.penaltyAmount =
                                  // double.tryParse(org.keyName ?? '0');
                                  // log('-widget.violation.violation?.name----${widget.model.violation?.name}-');

                                  if (!numberOfKeysController
                                      .text.isEmptyOrNull) {
                                    // penaltyAmountController
                                    //     .text = ((penaltyAmountController.text
                                    //                 .toDoubleOrNull() ??
                                    //             0) *
                                    //         (widget.model.totalViolations ?? 0))
                                    //     .toString();
                                  }

                                  setState(() {
                                    log('-setstate-');
                                    keyDescriptionController.text =
                                        org.keyName ?? '';
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
                            onTap: (String value) {
                              Label? selectedLabel;
                              selectedLabel = keysDropDownValues.firstWhere(
                                (label) => label.key == value,
                                orElse: () => const Label(key: '', value: ''),
                              );
                              keysController.text = selectedLabel.key;
                              // widget.model.staffCategory =
                              //     int.tryParse(selectedLabel.value);

                              // int? getKeyDescriptionValues = widget
                              //     .getKeyDescriptionValues[selectedLabel.key];
                              // log('--staffCategoriesValue----$getKeyDescriptionValues---');
                              // if (getKeyDescriptionValues != null) {
                              //   numberOfKeysController.text =
                              //       getKeyDescriptionValues.toString();
                              // }
                              if (selectedLabel.value == '1') {
                                // numberOfKeysController.text = '1';
                                // widget.model.totalViolations = 1;
                                // totalPenaltyAmountController.text =
                                //     '${(widget.model.penaltyAmount ?? 0) * (widget.model.totalViolations ?? 0)}';
                                // widget.model.totalPenaltyAmount =
                                //     (widget.model.penaltyAmount ?? 0) *
                                //         (widget.model.totalViolations ?? 0);
                              }
                              setState(() {});

                              // BlocProvider.of<
                              // ViolationPenaltyRecordBloc>(
                              // context)
                              // .updateDropdownValues(
                              // staffCategoryDropDownValues: int.tryParse(
                              //  selectedLabel.value));
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
                        textFieldController: numberOfKeysController,
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
                        textFieldController: noOfKeysIssuedController,
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
                        textFormKey: Keys.phoneNumberKey,
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
                        textFormKey: Keys.phoneNumberKey,
                        textFieldController: keysReturnedController,
                        hintText: '',
                        isEnable: false,
                        isDisableColor: true,
                        onChange: (String value) {},
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
                        textFormKey: Keys.phoneNumberKey,
                        textFieldController: keysNotReturnedController,
                        hintText: '',
                        isEnable: false,
                        isDisableColor: true,
                        onChange: (String value) {},
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
                        onChange: (String value) {},
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
