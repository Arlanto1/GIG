import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/base_department_dialog.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/models/responseModels/error_response_validation.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';

import '../../../../../common_widgets/base_widget/base_drop_down.dart';
import '../../../../../common_widgets/base_widget/base_list_tile_item.dart';
import '../../models/violation_penalty_model.dart';

class AddContactPopUp extends StatefulWidget {
  const AddContactPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.violation,
    required this.mainContext,
    required this.users,
  });

  final String title;
  final Function onSubmit;
  final ViolationPenaltyRecord violation;
  final List<Organisation> users;
  final BuildContext mainContext;

  @override
  State<AddContactPopUp> createState() => AddContactPopUpState();
}

class AddContactPopUpState extends State<AddContactPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController violationController = TextEditingController();
  TextEditingController staffCategoryController = TextEditingController();
  TextEditingController penaltyAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('---widget.users--len---${widget.users.length}--');

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
          height: height / 1.4,
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
                      ///Violation
                      Column(
                        children: [
                          CommonWidgets.textDisplay(
                            Constants.violation,
                            Styles.textStyleBlack14,
                            isMandatory: true,
                          ),
                          TextfieldAddButton(
                            title: widget.violation.violation?.name ?? '',
                            height: 70,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().departmentDialog(
                                context: context,
                                departments: widget.users,
                                onTap: (Organisation user) {
                                  violationController.text = user.name ?? '';

                                  widget.violation.violation ??= Organisation();
                                  widget.violation.violation = user;
                                  log('-widget.violation.violation?.name----${widget.violation.violation?.name}-');

                                  setState(() {});
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
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Staff Category
                      CommonWidgets.textDisplay(
                          Constants.staffCategory,
                          isMandatory: true,
                          Styles.textStyleBlack14),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),

                      BaseDropDown().getDropDown(
                          isDisabled: widget.violation != null,
                          textController: staffCategoryController,
                          items: staffCategoryDropDownValues,
                          initialValue: '',
                          onTap: () {
                            BaseDropDown().assetTypeDialog(
                                context: context,
                                dropDownValues: staffCategoryDropDownValues
                                    .map((label) => label.key)
                                    .toList(),
                                onTap: (int value) {
                                  Label? selectedLabel;
                                  selectedLabel =
                                      staffCategoryDropDownValues.firstWhere(
                                    (label) => label.key == value,
                                    orElse: () =>
                                        const Label(key: '', value: ''),
                                  );
                                  setState(() {
                                    //  widget.violation.staffCategory = value;
                                  });

                                  // BlocProvider.of<
                                  // ViolationPenaltyRecordBloc>(
                                  // context)
                                  // .updateDropdownValues(
                                  // staffCategoryDropDownValues: int.tryParse(
                                  //  selectedLabel.value));
                                });
                          }),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Total No of Violations
                      CommonWidgets.textDisplay(
                        Constants.totalNoOfViolations,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue:
                            '${widget.violation.totalViolations ?? ''}',
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          // widget.payRate.perHour = double.parse(value);
                          // BlocProvider.of<PayRateCubit>(widget.mainContext)
                          //     .onModelValueChange(widget.payRate);
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
                        initialValue:
                            '${widget.violation.totalViolations ?? ''}',
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          // widget.payRate.perHour = double.parse(value);
                          // BlocProvider.of<PayRateCubit>(widget.mainContext)
                          //     .onModelValueChange(widget.payRate);
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
        onSubmit(widget.violation);
      },
    );
  }

  ErrorResponse get isFormValid {
    if (widget.violation.violation == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Violation.');
    }
    if (widget.violation.staffCategory == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Staff Category.');
    }
    if (widget.violation.totalViolations == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Total No of Violations');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
