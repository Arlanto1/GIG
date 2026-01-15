import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:intl/intl.dart';

class AddDatePopUp extends StatefulWidget {
  const AddDatePopUp({
    super.key,
    required this.onSubmit,
    required this.mainContext,
  });

  final Function onSubmit;
  final BuildContext mainContext;

  @override
  State<AddDatePopUp> createState() => AddDatePopUpState();
}

class AddDatePopUpState extends State<AddDatePopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController powerFailureStartDateController =
      TextEditingController();
  TextEditingController powerFailureEndDateController = TextEditingController();
  String? selectedStartDate;
  String? startToDate;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // return AlertDialog(
    //   backgroundColor: AppColors.lavender,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //   content: Builder(builder: (context) {
    //     return SizedBox(
    //       height: height / 2.9,
    //       width: width,
    //       child: Stack(
    //         clipBehavior: Clip.none,
    //         children: <Widget>[
    //           Form(
    //             key: _formKey,
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: <Widget>[
    //                   CommonWidgets.textDisplay(
    //                     Constants.powerFailureDate,
    //                     Styles.textStyleWhite14,
    //                   ),
    //                   CommonWidgets.verticalSpacerWidget(height * 0.01),
    //                   BaseDate().datePickerWidgetLoading(
    //                     textController: powerFailureStartDateController,
    //                     isDisabled: false,
    //                     onlyDate: false,
    //                     showFutureDate: false,
    //                     notFlagDate: true,
    //                     onChange: (String value) {
    //                       log('--value----$value------');
    //                       powerFailureStartDateController.text = value;
    //                       selectedStartDate = DateFormat('dd/MM/yyyy HH:mm:ss')
    //                           .parse(value)
    //                           .toString();
    //                       DateTime parsedDate =
    //                           DateFormat('dd/MM/yyyy HH:mm:ss').parse(value);
    //
    //                       // Add two days to the parsed date
    //                       DateTime newDate =
    //                           parsedDate.add(const Duration(days: 1));
    //
    //                       // Format the new date back into the desired string format
    //                       startToDate = newDate.toString();
    //
    //                       setState(() {});
    //                     },
    //                     context: widget.mainContext,
    //                   ),
    //                   CommonWidgets.verticalSpacerWidget(height * 0.01),
    //
    //                   CommonWidgets.textDisplay(
    //                     Constants.powerFailureEndDate,
    //                     Styles.textStyleWhite14,
    //                   ),
    //                   CommonWidgets.verticalSpacerWidget(height * 0.01),
    //                   BaseDate().datePickerWidgetLoading(
    //                     textController: powerFailureEndDateController,
    //                     isDisabled: false,
    //                     // notFlagDate: true,
    //                     showPastDate: false,
    //                     onlyDate: false,
    //                     startDate: selectedStartDate,
    //                     fromDate: selectedStartDate,
    //                     toDate: startToDate.isEmptyOrNull ? '' : startToDate,
    //
    //                     showFutureDate: false,
    //                     onChange: (String value) {
    //                       log('--fr-value-${powerFailureEndDateController.text}------');
    //                       powerFailureEndDateController.text = value;
    //                     },
    //                     context: widget.mainContext,
    //                   ),
    //                   CommonWidgets.verticalSpacerWidget(height * 0.02),
    //                   buttonViews(widget.mainContext, width),
    //                   CommonWidgets.verticalSpacerWidget(height * 0.02),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   }),
    // );
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      backgroundColor: Colors.transparent,
      elevation: 0,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.newColor3.withValues(alpha: 0.7),
                  AppColors.newColor,
                  AppColors.newColor3.withValues(alpha: 0.7),
                  // Color(0xFF6474C6).withOpacity(0.14)
                ],
                stops: [0.02, 0.35, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
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
              height: height / 2.9,
              width: width,
              child: Column(
                // clipBehavior: Clip.none,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CommonWidgets.textDisplay(
                            Constants.powerFailureDate,
                            Styles.textStyleWhite14,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          BaseDate().datePickerWidgetLoading(
                            textController: powerFailureStartDateController,
                            isDisabled: false,
                            onlyDate: false,
                            showFutureDate: false,
                            notFlagDate: true,
                            onChange: (String value) {
                              log('--value----$value------');
                              powerFailureStartDateController.text = value;
                              selectedStartDate = DateFormat(
                                'dd/MM/yyyy HH:mm:ss',
                              ).parse(value).toString();

                              DateTime parsedDate = DateFormat(
                                'dd/MM/yyyy HH:mm:ss',
                              ).parse(value);

                              DateTime newDate = parsedDate.add(
                                const Duration(days: 1),
                              );

                              startToDate = newDate.toString();
                              setState(() {});
                            },
                            context: widget.mainContext,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          CommonWidgets.textDisplay(
                            Constants.powerFailureEndDate,
                            Styles.textStyleWhite14,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          BaseDate().datePickerWidgetLoading(
                            textController: powerFailureEndDateController,
                            isDisabled: false,
                            onlyDate: false,
                            showPastDate: false,
                            startDate: selectedStartDate,
                            fromDate: selectedStartDate,
                            toDate: startToDate.isEmptyOrNull
                                ? ''
                                : startToDate,
                            showFutureDate: false,
                            onChange: (String value) {
                              log(
                                '--fr-value-${powerFailureEndDateController.text}------',
                              );
                              powerFailureEndDateController.text = value;
                            },
                            context: widget.mainContext,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.02),
                          buttonViews(widget.mainContext, width),
                          CommonWidgets.verticalSpacerWidget(height * 0.02),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buttonViews(BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[cancelButton(width), saveButton(width)],
    );
  }

  Widget cancelButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButtonText,
      foregroundColor: AppColors.white,
      textStyle: Styles.styleHeaderGreyText16,
      boarderColor: AppColors.white,
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      },
    );
  }

  Widget saveButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.saveButton),
      buttonText: Constants.save,
      buttonTextKey: Keys.saveButtonText,
      boarderColor: AppColors.white,
      backgroundColor: const Color(0xFF071130),
      foregroundColor: Colors.white,
      textStyle: Styles.textStyleSemiBold16White,
      onTap: () {
        PowerFailureModel powerFailure = PowerFailureModel();
        String powerFailureStartDate = powerFailureStartDateController.text;
        String powerFailureEndDate = powerFailureEndDateController.text;
        if (!powerFailureStartDate.isEmptyOrNull) {
          powerFailure.powerFailureStartDate = Utils().formatTime(
            powerFailureStartDate,
          );
        }
        if (!powerFailureEndDate.isEmptyOrNull) {
          powerFailure.powerFailureEndDate = Utils().formatTime(
            powerFailureEndDate,
          );
        }
        // powerFailure.powerFailureEndDate = powerFailureEndDate;
        widget.onSubmit(powerFailure);
        Navigator.pop(context);
      },
    );
  }
}
