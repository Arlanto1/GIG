import 'dart:developer';

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

    fromDateController.text = Utils.timestamptoDateConversion(
        int.parse(widget.payRate.fromDate ?? '0'), Constants.dateFormat);

    toDateController.text = Utils.timestamptoDateConversion(
        int.parse(widget.payRate.toDate ?? '0'), Constants.dateFormat);

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
                        Constants.monthlyCost,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: '${widget.payRate.total ?? ''}',
                        textInputType: TextInputType.number,
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
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: Utils()
                            .removeDecimalAndValuesAfterIt(widget.payRate.days),
                        textInputType: TextInputType.number,
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
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        controller: perHourController,
                        textInputType: TextInputType.number,
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

                      BaseDate().datePickerWidgetLoading(
                        textController: fromDateController,
                        isDisabled: false,
                        onlyDate: true,
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
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      BaseDate().datePickerWidgetLoading(
                        textController: toDateController,
                        onlyDate: true,
                        showPastDate: false,
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
