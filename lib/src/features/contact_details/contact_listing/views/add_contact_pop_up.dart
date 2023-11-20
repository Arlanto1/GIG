import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/base_department_dialog.dart';
import 'package:db_atom/src/common_widgets/base_widget/date_picker_dialog.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rate_details/pay_rates/cubits/pay_rate_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/models/base_user.dart';
import 'package:db_atom/src/models/responseModels/error_response_validation.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactPopUp extends StatefulWidget {
  const AddContactPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.payRate,
    required this.mainContext,
    required this.users,
  });

  final String title;
  final Function onSubmit;
  final PayRate payRate;
  final List<BaseUser> users;
  final BuildContext mainContext;

  @override
  State<AddContactPopUp> createState() => AddContactPopUpState();
}

class AddContactPopUpState extends State<AddContactPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController perHourController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('---users-${widget.users.length}--');

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

        if (widget.payRate.perHour != null) {
          perHourController.text = widget.payRate.perHour.toString();
        }

        return SizedBox(
          height: height / 1.3,
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
                      /// Monthly Cost
                      CommonWidgets.textDisplay(
                        Constants.rank,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      Column(
                        children: [
                          CommonWidgets.textDisplay(
                            Constants.approver1Email,
                            Styles.textStyleBlack14,
                            isMandatory: true,
                          ),
                          TextfieldAddButton(
                            title: 'Rank',
                            height: 70,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: widget.users,
                                onTap: (BaseUser user) {
                                  // BlocProvider.of<ContactListingBloc>(context)
                                  //     .updateApproverEmailsValue(
                                  //         approver1EmailUser: user);
                                },
                              );
                            },
                          )
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: '${widget.payRate.total ?? ''}',
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.totalKey,
                        hintText: '',
                        onChange: (String value) {
                          if (value.isNotEmpty) {
                            widget.payRate.total = num.parse(value);

                            BlocProvider.of<PayRateCubit>(widget.mainContext)
                                .onModelValueChange(widget.payRate);

                            if (widget.payRate.days != null) {
                              perHourController.text =
                                  ((widget.payRate.total)! /
                                          (8 * (widget.payRate.days as num)))
                                      .toString();
                            }
                          }
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Days
                      CommonWidgets.textDisplay(
                        Constants.days,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: Utils()
                            .removeDecimalAndValuesAfterIt(widget.payRate.days),
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.daysKey,
                        hintText: '',
                        onChange: (String value) {
                          if (value.isNotEmpty &&
                              widget.payRate.total != null) {
                            widget.payRate.days = num.parse(value);

                            perHourController.text = ((widget.payRate.total)! /
                                    (8 * (widget.payRate.days as num)))
                                .toString();

                            widget.payRate.perHour =
                                double.parse(perHourController.text);
                            BlocProvider.of<PayRateCubit>(widget.mainContext)
                                .onModelValueChange(widget.payRate);
                          }
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Per Hour
                      CommonWidgets.textDisplay(
                        Constants.perHour,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        textFieldController: perHourController,
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.perHourKey,
                        hintText: '',
                        isEnable: false,
                        isDisableColor: true,
                        onChange: (String value) {
                          widget.payRate.perHour = double.parse(value);
                          BlocProvider.of<PayRateCubit>(widget.mainContext)
                              .onModelValueChange(widget.payRate);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// From Date
                      CommonWidgets.textDisplay(
                        Constants.fromDate,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      BaseDate().datePickerWidgetLoading(
                        textController: fromDateController,
                        isDisabled: false,
                        onChange: (String value) {
                          log('--fr-value-${fromDateController.text}------');
                          widget.payRate.fromDate = value;
                          BlocProvider.of<PayRateCubit>(widget.mainContext)
                              .onModelValueChange(widget.payRate);
                        },
                        context: widget.mainContext,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// To Date
                      CommonWidgets.textDisplay(
                        Constants.toDate,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      BaseDate().datePickerWidgetLoading(
                        textController: toDateController,
                        showBackDate: false,
                        onChange: (String value) {
                          widget.payRate.toDate = value;
                          BlocProvider.of<PayRateCubit>(widget.mainContext)
                              .onModelValueChange(widget.payRate);
                        },
                        context: widget.mainContext,
                      ),

                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// To Comment
                      CommonWidgets.textDisplay(
                        Constants.comment,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: widget.payRate.comment ?? '',
                        lineHeight: 6,
                        textFormKey: Keys.commentKey,
                        hintText: '',
                        showBorder: true,
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          widget.payRate.comment = value;
                          BlocProvider.of<PayRateCubit>(widget.mainContext)
                              .onModelValueChange(widget.payRate);
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
    return Container(
      color: AppColors.backgroundWhitecolor,
      child: Row(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          cancelButton(width),
          saveButton(width, widget.onSubmit)
        ],
      ),
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
      boardercolor: AppColors.textgreyThemecolor,
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
      boardercolor: AppColors.navigationSkybluecolor,
      backgroundColor: AppColors.navigationSkybluecolor,
      foregroundColor: Colors.white,
      textStyle: Styles.textStyleSemiBold16White,
      onTap: () {
        if (!isPayRateValid.status) {
          Validator().showToast(
            context,
            isPayRateValid.message,
          );
          return;
        }
        onSubmit(widget.payRate);
      },
    );
  }

  ErrorResponse get isPayRateValid {
    if (widget.payRate.total == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Monthly Cost.');
    }
    if (widget.payRate.days == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter number of days.');
    }
    if (widget.payRate.fromDate == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter From Date.');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
