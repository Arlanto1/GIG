import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/date_picker_dialog.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/models/general_info_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';

import '../../../../../../index.dart';

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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return AlertDialog(
      backgroundColor: AppColors.backgroundWhitecolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        return SizedBox(
          height: height / 2.9,
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
                      CommonWidgets.textDisplay(
                        Constants.powerFailureDate,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      BaseDate().datePickerWidgetLoading(
                        textController: powerFailureStartDateController,
                        isDisabled: false,
                        onlyDate: false,
                        showFutureDate: false,
                        onChange: (String value) {
                          log('--fr-value-${powerFailureStartDateController.text}------');
                          powerFailureStartDateController.text = value;
                        },
                        context: widget.mainContext,
                      ),
                      CommonWidgets.textDisplay(
                        Constants.powerFailureEndDate,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      BaseDate().datePickerWidgetLoading(
                        textController: powerFailureEndDateController,
                        isDisabled: false,
                        onlyDate: false,
                        showFutureDate: false,
                        onChange: (String value) {
                          log('--fr-value-${powerFailureEndDateController.text}------');
                          powerFailureEndDateController.text = value;
                        },
                        context: widget.mainContext,
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
        saveButton(width),
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
      boarderColor: AppColors.textgreyThemecolor,
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
      boarderColor: AppColors.navigationSkybluecolor,
      backgroundColor: AppColors.navigationSkybluecolor,
      foregroundColor: Colors.white,
      textStyle: Styles.textStyleSemiBold16White,
      onTap: () {
        PowerFailure powerFailure = PowerFailure();
        String powerFailureStartDate = powerFailureStartDateController.text;
        String powerFailureEndDate = powerFailureEndDateController.text;
        powerFailure.powerFailureStartDate = Utils().formatTime(powerFailureStartDate);
        powerFailure.powerFailureEndDate = Utils().formatTime(powerFailureEndDate);
        // powerFailure.powerFailureEndDate = powerFailureEndDate;
        widget.onSubmit(powerFailure);
        Navigator.pop(context);
      },
      // onTap: () {
      //   PowerFailure powerFailure = PowerFailure();
      //
      //
      //   String powerFailureStartDate = powerFailureStartDateController.text;
      //   String powerFailureEndDate = powerFailureEndDateController.text;
      //
      //   powerFailure.powerFailureStartDate = powerFailureStartDate;
      //   powerFailure.powerFailureEndDate = powerFailureEndDate;
      //
      //
      //   if (powerFailureStartDate.isNotEmpty) {
      //     // Create a PowerFailures object from the text field value
      //     powerFailure =
      //         PowerFailure(powerFailureStartDate: powerFailureStartDate);
      //
      //     BlocProvider.of<OccurrenceGeneralInfoCubit>(widget.mainContext)
      //         .onAddPowerFailureDate(powerFailure);
      //     Navigator.pop(context);
      //   } else if (powerFailureEndDate.isNotEmpty) {
      //     PowerFailure powerFailure =
      //         PowerFailure(powerFailureEndDate: powerFailureEndDate);
      //     BlocProvider.of<OccurrenceGeneralInfoCubit>(widget.mainContext)
      //         .onAddPowerFailureDate(powerFailure);
      //     Navigator.pop(context);
      //   }
      // },
    );
  }
}
