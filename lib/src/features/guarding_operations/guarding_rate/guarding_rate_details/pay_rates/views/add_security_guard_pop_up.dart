import 'dart:developer';

import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rate_details/pay_rates/cubits/pay_rate_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../common_widgets/date_time_picker.dart';
import '../../../../../../constants/app_icon.dart';

class AddSecurityGuardPopUp extends StatefulWidget {
  const AddSecurityGuardPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.payRate,
    required this.mainContext,
  });

  final String title;
  final Function onSubmit;
  final PayRate payRate;
  final BuildContext mainContext;

  @override
  State<AddSecurityGuardPopUp> createState() => AddSecurityGuardPopUpState();
}

class AddSecurityGuardPopUpState extends State<AddSecurityGuardPopUp> {
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
    log('------payRate--${widget.payRate}------');
    final size = MediaQuery.of(context).size;
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
          height: height / .9,
          width: width,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    /// Monthly Cost
                    CommonWidgets.textDisplay(
                      Constants.monthlyCost,
                      Styles.textStyleBlack14,
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
                            perHourController.text = ((widget.payRate.total)! /
                                    (widget.payRate.days as num))
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
                      Styles.textStyleBlack14,
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.01),
                    FlutterInputField(
                      initialValue: '${widget.payRate.days ?? ''}',
                      keyboardType: TextInputType.number,
                      textFormKey: Keys.daysKey,
                      hintText: '',
                      onChange: (String value) {
                        if (value.isNotEmpty && widget.payRate.total != null) {
                          widget.payRate.days = double.parse(value);


                          perHourController.text = ((widget.payRate.total)! /
                                  (widget.payRate.days as num))
                              .toString();

                          widget.payRate.perHour = double.parse(perHourController.text);
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
                      Styles.textStyleBlack14,
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.01),

                    datePickerWidgetLoading(
                      textfiled: fromDateController,
                      onChange: (String value) {
                        log('--fr-value-${fromDateController.text}------');
                        widget.payRate.fromDate = value;
                        BlocProvider.of<PayRateCubit>(widget.mainContext)
                            .onModelValueChange(widget.payRate);
                      },
                    ),
                    // FlutterInputField(
                    //   initialValue: widget.payRate.fromDate??'',
                    //   textFormKey: Keys.fromDate,
                    //   hintText: '',
                    //   onChange: (String value) {
                    //     widget.payRate.fromDate = value;
                    //     BlocProvider.of<PayRateCubit>(widget.mainContext).onModelValueChange(widget.payRate);
                    //   },
                    //   validateTextField: (String? user) {},
                    // ),
                    CommonWidgets.verticalSpacerWidget(height * 0.01),

                    /// To Date
                    CommonWidgets.textDisplay(
                      Constants.toDate,
                      Styles.textStyleBlack14,
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.01),

                    datePickerWidgetLoading(
                      textfiled: toDateController,
                      onChange: (String value) {
                        widget.payRate.toDate = value;
                        BlocProvider.of<PayRateCubit>(widget.mainContext)
                            .onModelValueChange(widget.payRate);
                      },
                    ),
                    // FlutterInputField(
                    //   initialValue: widget.payRate.toDate??'',
                    //   textFormKey: Keys.toDateKey,
                    //   hintText: '',
                    //   onChange: (String value) {
                    //     widget.payRate.toDate = value;
                    //     BlocProvider.of<PayRateCubit>(widget.mainContext).onModelValueChange(widget.payRate);
                    //   },
                    //   validateTextField: (String? user) {},
                    // ),
                    // CommonWidgets.verticalSpacerWidget(height * 0.01),

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

                    const Spacer(),
                    buttonViews(context, width),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Widget datepickerWidgetLoading({
  //   required TextEditingController textfiled,
  //   bool isDisabled = false,
  //   required Function onChange,
  // }) {
  //   return GestureDetector(
  //     onTap: () {
  //       if (!isDisabled) {
  //         datePickerDialog(textfiled);
  //       }
  //     },
  //     child: FlutterInputField(
  //       textFieldController: textfiled,
  //       textFormKey: textfiled == textfiled
  //           ? Keys.founddateTextController
  //           : Keys.handedoverdateTextController,
  //       hintText: '',
  //       isEnable: !isDisabled,
  //       isDisableColor: isDisabled,
  //       onChange: onChange,
  //       validateTextField: (String? user) {},
  //       suffixWidget: GestureDetector(
  //         onTap: () async {
  //           if (textfiled.text.isEmpty) {
  //             textfiled.text = await datePickerDialog(textfiled);
  //             log('--textfiled.text-${textfiled.text}------');
  //             // state.materialMovement.tak
  //           }
  //         },
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: SvgPicture.asset(
  //             AppIcon.calendaricon,
  //             color: AppColors.textgreyThemecolor,
  //             width: 20,
  //             key: const Key(Keys.userIcon),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget datePickerWidgetLoading({
    required TextEditingController textfiled,
    bool isDisabled = false,
    required Function(String) onChange, // Updated the parameter type to accept a String
  }) {
    return GestureDetector(
      onTap: () {
        if (!isDisabled) {
          datePickerDialog(textfiled, onChange);
        }
      },
      child: FlutterInputField(
        textFieldController: textfiled,
        textFormKey: textfiled == textfiled
            ? Keys.founddateTextController
            : Keys.handedoverdateTextController,
        hintText: '',
        isEnable: !isDisabled,
        isDisableColor: isDisabled,
        onChange: onChange, // Pass the onChange callback to FlutterInputField
        validateTextField: (String? user) {},
        suffixWidget: GestureDetector(
          onTap: () async {
            if (textfiled.text.isEmpty) {
              textfiled.text = await datePickerDialog(textfiled, onChange);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              AppIcon.calendaricon,
              color: AppColors.textgreyThemecolor,
              width: 20,
              key: const Key(Keys.userIcon),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> datePickerDialog(
      TextEditingController textfield,
      Function(String) onChange, // Updated the parameter type to accept a String
      ) async {
    DateTime? pickedDate = await showDateTimePicker(
      context: widget.mainContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    String formattedDate = DateFormat(Constants.fulldateFormat)
        .format(pickedDate ?? DateTime.now());

    textfield.text = formattedDate; // Update the text field value
    onChange(formattedDate); // Call the onChange callback with the selected date
    return formattedDate;
  }


  // Future<String> datePickerDialog(TextEditingController textfield) async {
  //   DateTime? pickedDate = await showDateTimePicker(
  //     context: widget.mainContext,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //
  //   String formattedDate = DateFormat(Constants.fulldateFormat)
  //       .format(pickedDate ?? DateTime.now());
  //
  //   log('--formattedDate-$formattedDate------');
  //   return formattedDate;
  // }

  Widget buttonViews(BuildContext context, double width) {
    return Container(
      color: AppColors.backgroundWhitecolor,
      child: Row(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[cancelButton(width), saveButton(width)],
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
        try {
          // final ValidLoginDetails validLoginDetails =
          //     ValidLoginDetails(userName: username, password: password);
          // widget.onValidLogin(validLoginDetails);
          //Navigator.pushNamed(context, homePageRoute);
          Navigator.of(context).pop();
        } catch (e) {
          // present userwith error message
        }
      },
    );
  }

  Widget saveButton(double width) {
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
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();

        log('--total-tap-${widget.payRate.total}------');
        log('--fr-tap-${widget.payRate.fromDate}------');
        log('--fr-controller tap-${fromDateController.text}------');

        BlocProvider.of<PayRateCubit>(widget.mainContext)
            .onSave(isSubmit: false, newPayRate: widget.payRate);
      },
    );
  }
}
