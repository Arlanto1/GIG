import 'dart:developer';

import 'package:db_atom/index.dart';

class AddContactPopUp extends StatefulWidget {
  const AddContactPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.model,
    required this.mainContext,
    required this.users,
    required this.staffCategoriesValues,
  });

  final String title;
  final Function onSubmit;
  final ViolationPenaltyRecord model;
  final List<Organisation> users;
  final BuildContext mainContext;
  final Map<String, dynamic> staffCategoriesValues;

  @override
  State<AddContactPopUp> createState() => AddContactPopUpState();
}

class AddContactPopUpState extends State<AddContactPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController violationController = TextEditingController();
  TextEditingController staffCategoryController = TextEditingController();
  TextEditingController penaltyAmountController = TextEditingController();
  TextEditingController totalPenaltyAmountController = TextEditingController();
  TextEditingController numberOfViolationsAmountController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    penaltyAmountController.text = widget.model.penaltyAmount == null
        ? ''
        : widget.model.penaltyAmount.toString();

    num? sum = (widget.model.totalPenaltyAmount ??
        (widget.model.penaltyAmount ?? 0) *
            (widget.model.totalViolations ?? 0));
    totalPenaltyAmountController.text = sum.toString();
    numberOfViolationsAmountController.text = widget.model.totalViolations == null
        ? ''
        : widget.model.totalViolations.toString();
    updateStaffCategoryText();
  }

  void updateStaffCategoryText() {
    String staffCategoryValue = widget.model.staffCategory.toString();
    log('--staffCategoryValue---$staffCategoryValue--');
    Label? matchingLabel = staffCategoryDropDownValues
        .firstOrNullWhere((element) => element.value == staffCategoryValue);

    log('--matchingLabel?.value---${matchingLabel?.value}--');

    staffCategoryController.text = matchingLabel?.key ?? '';
    log('--staffCategoryController.text---${staffCategoryController.text}--');
  }

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
                      /// Violation
                      Column(
                        children: [
                          CommonWidgets.textDisplay(
                            Constants.violation,
                            Styles.textStyleBlack14,
                            isMandatory: true,
                          ),
                          TextfieldAddButton(
                            title: widget.model.violation?.name ?? '',
                            height: 70,
                            isDisableColor: false,
                            onTap: () {
                              BaseOrganisationDialog().departmentDialog(
                                context: context,
                                organisations: widget.users,
                                onTap: (Organisation org) {
                                  violationController.text = org.name ?? '';

                                  log('-org.keyName----${org.keyName}-');

                                  penaltyAmountController.text =
                                      org.keyName ?? ''; // Penalty Amount
                                  widget.model.violation ??= Organisation();
                                  widget.model.violation = org;
                                  widget.model.penaltyAmount =
                                      double.tryParse(org.keyName ?? '0');
                                  log('-widget.violation.violation?.name----${widget.model.violation?.name}-');

                                  if (!numberOfViolationsAmountController
                                      .text.isEmptyOrNull) {
                                    penaltyAmountController
                                        .text = ((penaltyAmountController.text
                                                    .toDoubleOrNull() ??
                                                0) *
                                            (widget.model.totalViolations ?? 0))
                                        .toString();
                                  }

                                  setState(() {
                                    log('-setstate-');
                                    penaltyAmountController.text =
                                        org.keyName ?? '';
                                  });
                                },
                              );
                            },
                          )
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Penalty Amount
                      CommonWidgets.textDisplay(
                        Constants.penaltyAmount,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      FlutterInputField(
                        // initialValue: '${widget.model.penaltyAmount}',
                        textFieldController: penaltyAmountController,
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable: false,
                        isDisableColor: true,
                        onChange: (String value) {
                          // widget.payRate.perHour = double.parse(value);
                          // BlocProvider.of<PayRateCubit>(widget.mainContext)
                          //     .onModelValueChange(widget.payRate);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Staff Category
                      CommonWidgets.textDisplay(
                          Constants.staffCategory,
                          isMandatory: true,
                          Styles.textStyleBlack14),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),

                      BaseDropDown().getDropDown(
                        isDisabled: false,
                        textController: staffCategoryController,
                        items: staffCategoryDropDownValues,
                        onTap: () {
                          BaseDropDown().assetTypeDialog(
                            context: context,
                            dropDownValues: staffCategoryDropDownValues
                                .map((label) => label.key)
                                .toList(),
                            onTap: (String value) {
                              Label? selectedLabel;
                              selectedLabel =
                                  staffCategoryDropDownValues.firstWhere(
                                (label) => label.key == value,
                                orElse: () => const Label(key: '', value: ''),
                              );
                              staffCategoryController.text = selectedLabel.key;
                              widget.model.staffCategory =
                                  int.tryParse(selectedLabel.value);

                              int? staffCategoriesValue = widget
                                  .staffCategoriesValues[selectedLabel.key];
                              log('--staffCategoriesValue----$staffCategoriesValue---');
                              if (staffCategoriesValue != null) {
                                numberOfViolationsAmountController.text =
                                    staffCategoriesValue.toString();
                              }
                              if (selectedLabel.value == '1') {
                                numberOfViolationsAmountController.text = '1';
                                widget.model.totalViolations = 1;
                                totalPenaltyAmountController.text = '${(widget.model.penaltyAmount??0) * (widget.model.totalViolations??0)}';
                                widget.model.totalPenaltyAmount = (widget.model.penaltyAmount??0) * (widget.model.totalViolations??0);
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

                      /// Total No of Violations
                      CommonWidgets.textDisplay(
                        Constants.totalNoOfViolations,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        // initialValue: '${widget.model.totalViolations ?? ''}',
                        keyboardType: TextInputType.number,
                        textFieldController: numberOfViolationsAmountController,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable:  staffCategoryController.text == "Guarding Agency" ? false : true,
                        isDisableColor: false,
                        onChange: (String value) {
                          widget.model.totalViolations = num.parse(value);

                          num sum = (widget.model.penaltyAmount ?? 0) *
                              num.parse(value);
                          log('--sum-----$sum---');
                          totalPenaltyAmountController.text = sum.toString();

                          widget.model.totalPenaltyAmount = sum;
                          numberOfViolationsAmountController.text = value;
                          log('--totalPenaltyAmountController.text-----${totalPenaltyAmountController.text}---');

                          setState(() {
                            // totalPenaltyAmountController.text = sum.toString();
                          });
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Total Penalty Amount
                      CommonWidgets.textDisplay(
                        Constants.totalPenaltyAmount,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        textFieldController: totalPenaltyAmountController,
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

        log('-widget.model.totalPenaltyAmount--${widget.model.totalPenaltyAmount}-----');
        onSubmit(widget.model);
        Navigator.pop(context);
      },
    );
  }

  ErrorResponse get isFormValid {
    if (widget.model.violation == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Violation.');
    }
    if (widget.model.staffCategory == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Staff Category.');
    }
    if (widget.model.totalViolations == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Total No of Violations');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
