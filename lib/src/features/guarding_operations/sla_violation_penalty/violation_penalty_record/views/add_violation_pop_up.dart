import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/violation_penalty_record/bloc/violation_penalty_record_bloc.dart';

class AddContactPopUp extends StatefulWidget {
  const AddContactPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.model,
    required this.mainContext,
    required this.users,
    required this.staffCategoriesValues,
    required this.isLocked,
    this.parentStatus,
  });

  final String title;
  final Function onSubmit;
  final ViolationPenaltyRecord model;
  final List<Organisation> users;
  final BuildContext mainContext;
  final Map<String, dynamic> staffCategoriesValues;
  final int? parentStatus;
  final bool isLocked;

  @override
  State<AddContactPopUp> createState() => AddContactPopUpState();
}

class AddContactPopUpState extends State<AddContactPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController violationController = TextEditingController();
  TextEditingController staffCategoryController = TextEditingController();
  TextEditingController penaltyAmountController = TextEditingController();
  TextEditingController totalPenaltyAmountController = TextEditingController();
  TextEditingController totalNoOfViolationsController = TextEditingController();
  bool isReadonly = false;

  @override
  void initState() {
    super.initState();
    penaltyAmountController.text = widget.model.penaltyAmount == null
        ? ''
        : widget.model.penaltyAmount.toString();

    num? sum = (widget.model.totalPenaltyAmount ??
        (widget.model.penaltyAmount ?? 0) *
            (widget.model.totalViolations ?? 0));
    totalPenaltyAmountController.text =
        widget.model.penaltyAmount == null ? '' : sum.toString();
    totalNoOfViolationsController.text = widget.model.totalViolations == null
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
    ViolationPenaltyRecordState state = const ViolationPenaltyRecordState();
    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: Styles.textFontSet(18, AppColors.textGreyThemeColor,
              FontWeight.normal, Constants.customFontSemiBoldFamily),
        ),
      ),
      backgroundColor: AppColors.backgroundWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        if (widget.parentStatus == ConstantsIntValue.slaStatusFinalized ||
            widget.parentStatus == ConstantsIntValue.cancelledStatus) {
          isReadonly = true;
        }
        if (widget.isLocked) {
          isReadonly = true;
        }
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
                            state.labels?.locale.violation ??
                                state.labels?.defaultLocale.violation ??
                                Constants.violation,
                            Styles.textStyleBlack14,
                            //isMandatory: true,
                          ),
                          TextFieldAddButton(
                              title: widget.model.violation?.name ?? '',
                              height: 70,
                              isDisableColor: isReadonly,
                              onTap: () {
                                if (!isReadonly) {
                                  BaseOrganisationDialog().departmentDialog(
                                    context: context,
                                    organisations: widget.users,
                                    onTap: (Organisation org) {
                                      violationController.text = org.name ?? '';
                                      staffCategoryController.clear();
                                      penaltyAmountController.clear();
                                      totalPenaltyAmountController.clear();
                                      totalNoOfViolationsController.clear();
                                      log('-org.keyName----${org.keyName}-');

                                      penaltyAmountController.text =
                                          org.keyName ?? ''; // Penalty Amount
                                      widget.model.violation ??= Organisation();
                                      widget.model.violation = org;
                                      widget.model.penaltyAmount =
                                          double.tryParse(org.keyName ?? '0');
                                      log('-widget.violation.violation?.name----${widget.model.violation?.name}-');

                                      if (!totalNoOfViolationsController
                                          .text.isEmptyOrNull) {
                                        penaltyAmountController.text =
                                            ((penaltyAmountController.text
                                                            .toDoubleOrNull() ??
                                                        0) *
                                                    (widget.model
                                                            .totalViolations ??
                                                        0))
                                                .toString();
                                      }

                                      setState(() {
                                        log('-setstate-');
                                        penaltyAmountController.text =
                                            org.keyName ?? '';
                                      });
                                    },
                                  );
                                }
                              })
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Penalty Amount
                      CommonWidgets.textDisplay(
                        state.labels?.locale.penaltyAmount ??
                            state.labels?.defaultLocale.penaltyAmount ??
                            Constants.penaltyAmount,
                        //isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      FlutterInputField(
                        // initialValue: '${widget.model.penaltyAmount}',
                        controller: penaltyAmountController,
                        textInputType: TextInputType.number,
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
                          state.labels?.locale.staffCategory ??
                              state.labels?.defaultLocale.staffCategory ??
                              Constants.staffCategory,
                          //isMandatory: true,
                          Styles.textStyleBlack14),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),

                      BaseDropDown().getDropDown(
                          isDisabled: isReadonly,
                          textController: staffCategoryController,
                          items: staffCategoryDropDownValues,
                          onTap: () {
                            if (!isReadonly) {
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
                                    orElse: () =>
                                        const Label(key: '', value: ''),
                                  );

                                  log('-selectedLabel.value--${selectedLabel.value}--');
                                  // selectedLabel = staffCategoryDropDownValues.firstWhere(
                                  //       (label) => label.key.toLowerCase() == value.toLowerCase(),
                                  //   orElse: () => const Label(key: '', value: ''),
                                  // );

                                  staffCategoryController.text =
                                      selectedLabel.key;
                                  widget.model.staffCategory =
                                      int.tryParse(selectedLabel.value);

                                  int? staffCategoriesValue = widget
                                      .staffCategoriesValues[selectedLabel.key];
                                  // log('--staffCategoriesValue----$widget.staffCategoriesValues[selectedLabel.key]---');
                                  log('--staffCategoriesValue----${widget.staffCategoriesValues}---');
                                  // log('Selected Label: ${selectedLabel.key}, Value: ${selectedLabel.value}');

                                  if (staffCategoriesValue == null) {
                                    log('No matching value found for key: ${selectedLabel.key}');
                                  }

                                  if (staffCategoriesValue != null) {
                                    totalNoOfViolationsController.text =
                                        staffCategoriesValue.toString();
                                  }
                                  if (selectedLabel.value == '0') {
                                    totalNoOfViolationsController.text = '1';
                                    widget.model.totalViolations = 1;
                                    totalPenaltyAmountController.text =
                                        '${(widget.model.penaltyAmount ?? 0) * (widget.model.totalViolations ?? 0)}';
                                    widget.model.totalPenaltyAmount =
                                        (widget.model.penaltyAmount ?? 0) *
                                            (widget.model.totalViolations ?? 0);
                                  } else {
                                    totalNoOfViolationsController.clear();
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
                            }
                          }),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Total No of Violations
                      CommonWidgets.textDisplay(
                        state.labels?.locale.totalViolations ??
                            state.labels?.defaultLocale.totalViolations ??
                            Constants.totalNoOfViolations,
                        Styles.textStyleBlack14,
                        //isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        // initialValue: '${widget.model.totalViolations ?? ''}',
                        textInputType: TextInputType.number,
                        controller: totalNoOfViolationsController,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable: !isReadonly,
                        isDisableColor: false,
                        onChange: (String value) {
                          widget.model.totalViolations = num.parse(value);

                          num sum = (widget.model.penaltyAmount ?? 0) *
                              num.parse(value);
                          log('--sum-----$sum---');
                          totalPenaltyAmountController.text = sum.toString();

                          widget.model.totalPenaltyAmount = sum;
                          totalNoOfViolationsController.text = value;
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
                        state.labels?.locale.totalPenaltyAmount ??
                            state.labels?.defaultLocale.totalPenaltyAmount ??
                            Constants.totalPenaltyAmount,
                        Styles.textStyleBlack14,
                        //isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        textInputType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        controller: totalPenaltyAmountController,
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
        if (!isReadonly) ...[saveButton(width, widget.onSubmit)]
      ],
    );
  }

  Widget cancelButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.close,
      buttonTextKey: Keys.cancelButtonText,
      foregroundColor: AppColors.textGreyThemeColor,
      textStyle: Styles.styleHeaderGreyText16,
      backgroundColor: AppColors.white,
      boarderColor: AppColors.textGreyThemeColor,
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

        log('-widget.model.totalPenaltyAmount--${widget.model.totalPenaltyAmount}-----');
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
