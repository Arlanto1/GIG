import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';

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
    log('------payRate--${widget.payRate.total}------');

    fromDateController.text = widget.payRate.fromDate != null
        ? Utils.timestampToDateConversion(
        int.parse(widget.payRate.fromDate ?? '0'), Constants.dateFormat)
        : '';

    toDateController.text = widget.payRate.fromDate != null
        ? Utils.timestampToDateConversion(
        int.parse(widget.payRate.toDate ?? '0'), Constants.dateFormat)
        : '';

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      title: null,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery
            .of(context)
            .size
            .height;
        var width = MediaQuery
            .of(context)
            .size
            .width;

        if (widget.payRate.perHour != null) {
          perHourController.text = widget.payRate.perHour.toString();
        }

        return Stack(
          children: [
            // 🔹 BLUR THE ENTIRE BACKGROUND PAGE
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: Colors.black.withOpacity(0.25), // dim + blur
              ),
            ),

            // 🔹 YOUR ALERT DIALOG
            Center(
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
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
                      height: height / 1.3,
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

                                    /// Monthly Cost
                                    CommonWidgets.textDisplay(
                                      Constants.monthlyCost,
                                      Styles.textStyleWhite14,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                    FlutterInputField(
                                      initialValue: '${widget.payRate.total ??
                                          ''}',
                                      textInputType: TextInputType.number,
                                      textFormKey: Keys.totalKey,
                                      hintText: '',
                                      isEnable: false,
                                      onChange: (String value) {
                                        if (value.isNotEmpty) {
                                          widget.payRate.total =
                                              num.parse(value);

                                          BlocProvider.of<PayRateCubit>(
                                              widget.mainContext)
                                              .onModelValueChange(
                                              widget.payRate);

                                          if (widget.payRate.days != null) {
                                            perHourController.text = ((widget
                                                .payRate.total)! /
                                                (8 * (widget.payRate
                                                    .days as num)))
                                                .toString();
                                          }
                                        }
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Days
                                    CommonWidgets.textDisplay(
                                      Constants.days,
                                      Styles.textStyleWhite14,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                    FlutterInputField(
                                      initialValue: Utils()
                                          .removeDecimalAndValuesAfterIt(
                                          widget.payRate.days),
                                      textInputType: TextInputType.number,
                                      textFormKey: Keys.daysKey,
                                      hintText: '',
                                      isEnable: false,
                                      onChange: (String value) {
                                        if (value.isNotEmpty &&
                                            widget.payRate.total != null) {
                                          widget.payRate.days =
                                              num.parse(value);

                                          perHourController.text = ((widget
                                              .payRate.total)! /
                                              (8 *
                                                  (widget.payRate.days as num)))
                                              .toString();

                                          widget.payRate.perHour =
                                              double.parse(
                                                  perHourController.text);
                                          BlocProvider.of<PayRateCubit>(
                                              widget.mainContext)
                                              .onModelValueChange(
                                              widget.payRate);
                                        }
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Per Hour
                                    CommonWidgets.textDisplay(
                                      Constants.perHour,
                                      Styles.textStyleWhite14,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                    FlutterInputField(
                                      controller: perHourController,
                                      textInputType: TextInputType.number,
                                      textFormKey: Keys.perHourKey,
                                      hintText: '',
                                      isEnable: false,
                                      isDisableColor: true,
                                      onChange: (String value) {
                                        widget.payRate.perHour =
                                            double.parse(value);
                                        BlocProvider.of<PayRateCubit>(
                                            widget.mainContext)
                                            .onModelValueChange(widget.payRate);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// From Date
                                    CommonWidgets.textDisplay(
                                      Constants.fromDate,
                                      Styles.textStyleWhite14,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    BaseDate().datePickerWidgetLoading(
                                      textController: fromDateController,
                                      isDisabled: true,
                                      onlyDate: true,
                                      onChange: (String value) {
                                        log('--fr-value-${fromDateController
                                            .text}------');
                                        // widget.payRate.fromDate = value;
                                        // BlocProvider.of<PayRateCubit>(widget.mainContext)
                                        //     .onModelValueChange(widget.payRate);
                                      },
                                      context: widget.mainContext,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// To Date
                                    CommonWidgets.textDisplay(
                                      Constants.toDate,
                                      Styles.textStyleWhite14,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    BaseDate().datePickerWidgetLoading(
                                      textController: toDateController,
                                      isDisabled: true,
                                      onlyDate: true,
                                      showPastDate: false,
                                      onChange: (String value) {
                                        // widget.payRate.toDate = value;
                                        // BlocProvider.of<PayRateCubit>(widget.mainContext)
                                        //     .onModelValueChange(widget.payRate);
                                      },
                                      context: widget.mainContext,
                                    ),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// To Comment
                                    CommonWidgets.textDisplay(
                                      Constants.comment,
                                      Styles.textStyleWhite14,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                    FlutterInputField(
                                      initialValue: widget.payRate.comment ??
                                          '',
                                      lineHeight: 6,
                                      textFormKey: Keys.commentKey,
                                      hintText: '',
                                      showBorder: true,
                                      isEnable: false,
                                      isDisableColor: false,
                                      onChange: (String value) {
                                        widget.payRate.comment = value;
                                        BlocProvider.of<PayRateCubit>(
                                            widget.mainContext)
                                            .onModelValueChange(widget.payRate);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                    buttonViews(widget.mainContext, width),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.02),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),)
          ],);
      }),
    );
  }

  Widget buttonViews(BuildContext context, double width) {
    return Container(
      color: Colors.transparent,
      child: Row(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          cancelButton(width),
          // saveButton(width, widget.onSubmit)
        ],
      ),
    );
  }

  Widget cancelButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.close,
      buttonTextKey: Keys.cancelButtonText,
      backgroundColor: AppColors.newColor,
      foregroundColor: AppColors.white,
      textStyle: Styles.styleHeaderGreyText16,
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
        // if (!isPayRateValid.status) {
        //   Validator().showToast(
        //     context,
        //     isPayRateValid.message,
        //   );
        //   return;
        // }
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
