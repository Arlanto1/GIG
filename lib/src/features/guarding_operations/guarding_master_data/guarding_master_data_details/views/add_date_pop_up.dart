import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/date_picker_dialog.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/guarding_master_data_details/cubits/guarding_master_data_details_cubit.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/util.dart';
import '../../../../../utils/validators/validator.dart';
import '../../../../material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import '../../models/guarding_master_data_model.dart';

class AddDatePopUp extends StatefulWidget {
  const AddDatePopUp({
    super.key,
    required this.onSubmit,
    required this.mainContext,
    required this.guardingMasterData,
  });

  final Function onSubmit;
  final BuildContext mainContext;
  final GuardingMastersDataModel? guardingMasterData;

  @override
  State<AddDatePopUp> createState() => AddDatePopUpState();
}

class AddDatePopUpState extends State<AddDatePopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    dateController.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.csrParticipationDates ?? '0'),
        Constants.dateFormat);

    return AlertDialog(
      backgroundColor: AppColors.backgroundWhitecolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height /3.9,
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

                      ///CSR Participation Date
                      CommonWidgets.textDisplay(
                        Constants.csrParticipationDates,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      BaseDate().datePickerWidgetLoading(
                        textController: dateController,
                        isDisabled: false,
                        onChange: (String value) {
                          log('--fr-value-${dateController.text}------');
                          widget.guardingMasterData?.csrParticipationDates = value;
                          BlocProvider.of<GuardingMasterDataDetailsCubit>(widget.mainContext)
                           .onModelValueChange(widget.guardingMasterData!);
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
        if (!isParticipationDateValid.status) {
          Validator().showToast(
            context,
            isParticipationDateValid.message,
          );
          return;
        }
        onSubmit(widget.guardingMasterData);
      },
    );
  }
  ErrorResponse get isParticipationDateValid {
    if (widget.guardingMasterData?.csrParticipationDates == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter CSR Participation Date.');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}

