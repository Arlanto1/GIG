import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/duty_post_name_master_details/cubits/duty_post_name_master_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/models/duty_post_name_master_model.dart';

import '../../../../../../../index.dart';
import '../cubits/shift_schedule_details_cubit.dart';

class AddReplacementPopUp extends StatefulWidget {
  const AddReplacementPopUp({
    super.key,
    required this.mainContext,
    required this.model,
  });

  final BuildContext mainContext;
  final DutyPostNameMasterModel? model;

  @override
  State<AddReplacementPopUp> createState() =>
      AddDutyPostLocationNamePopUpState();
}

class AddDutyPostLocationNamePopUpState
    extends State<AddReplacementPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dutyPostLocationNameController =
      TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController replacementForController = TextEditingController();
  TextEditingController replacementByController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundWhitecolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height / 1.5,
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
                      /// Replacement For
                      CommonWidgets.textDisplay(
                          // state.labels?.locale.guardRank ??
                          //    state.labels?.defaultLocale.guardRank ??
                          Constants.replacementFor,
                          isMandatory: true,
                          Styles.textStyleBlack14),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      BaseDropDown().getDropDown(
                          isDisabled: false,
                          textController: replacementForController,
                          items: shiftDutyTypeDropDownValues,
                          initialValue: '',
                          onTap: () {
                            BaseDropDown().assetTypeDialog(
                                context: context,
                                dropDownValues: shiftDutyTypeDropDownValues
                                    .map((label) => label.key)
                                    .toList(),
                                onTap: (String value) {
                                  Label? selectedLabel;
                                  selectedLabel =
                                      shiftDutyTypeDropDownValues.firstWhere(
                                    (label) => label.key == value,
                                    orElse: () =>
                                        const Label(key: '', value: ''),
                                  );
                                  BlocProvider.of<ShiftScheduleDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          dutyType: int.tryParse(
                                              selectedLabel.value));
                                });
                          }),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Replacement By
                      CommonWidgets.textDisplay(
                          // state.labels?.locale.guardRank ??
                          //    state.labels?.defaultLocale.guardRank ??
                          Constants.replacementBy,
                          isMandatory: true,
                          Styles.textStyleBlack14),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      BaseDropDown().getDropDown(
                          isDisabled: false,
                          textController: replacementByController,
                          items: shiftDutyTypeDropDownValues,
                          initialValue: '',
                          onTap: () {
                            BaseDropDown().assetTypeDialog(
                                context: context,
                                dropDownValues: shiftDutyTypeDropDownValues
                                    .map((label) => label.key)
                                    .toList(),
                                onTap: (String value) {
                                  Label? selectedLabel;
                                  selectedLabel =
                                      shiftDutyTypeDropDownValues.firstWhere(
                                    (label) => label.key == value,
                                    orElse: () =>
                                        const Label(key: '', value: ''),
                                  );
                                  BlocProvider.of<ShiftScheduleDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          dutyType: int.tryParse(
                                              selectedLabel.value));
                                });
                          }),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// From Date
                      CommonWidgets.textDisplay(
                        // state.labels?.locale.dateOfBirth ??
                        //  state.labels?.defaultLocale.dateOfBirth ??
                        Constants.fromDate,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),

                      BaseDate().datePickerWidgetLoading(
                        textController: fromDateController,
                        onlyDate: false,
                        showPastDate: false,
                        onChange: (String value) {
                          // state.model.fromDate = Utils().formatTime(value);
                          // BlocProvider.of<ShiftScheduleDetailsCubit>(
                          //     context)
                          //     .onModelValueChange(state.model);
                        },
                        context: context,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// To Date
                      CommonWidgets.textDisplay(
                        // state.labels?.locale.dateOfBirth ??
                        //   state.labels?.defaultLocale.dateOfBirth ??
                        Constants.toDate,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),

                      BaseDate().datePickerWidgetLoading(
                        textController: toDateController,
                        onlyDate: false,
                        showPastDate: false,
                        onChange: (String value) {
                          // state.model.toDate = Utils().formatTime(value);
                          // BlocProvider.of<ShiftScheduleDetailsCubit>(
                          //     context)
                          //     .onModelValueChange(state.model);
                        },
                        context: context,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      ///Reason
                      CommonWidgets.textDisplay(
                        Constants.reason,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      BaseDropDown().getDropDown(
                          isDisabled: false,
                          textController: replacementByController,
                          items: reasonDropDownValues,
                          initialValue: '',
                          onTap: () {
                            BaseDropDown().assetTypeDialog(
                                context: context,
                                dropDownValues: reasonDropDownValues
                                    .map((label) => label.key)
                                    .toList(),
                                onTap: (String value) {
                                  Label? selectedLabel;
                                  selectedLabel =
                                      reasonDropDownValues.firstWhere(
                                            (label) => label.key == value,
                                        orElse: () =>
                                        const Label(key: '', value: ''),
                                      );
                                  BlocProvider.of<ShiftScheduleDetailsCubit>(
                                      context)
                                      .updateDropdownValues(
                                      dutyType: int.tryParse(
                                          selectedLabel.value));
                                });
                          }),
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
      //mainAxisSize: MainAxisSize.min,
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
    return AppButton(
      width: width / 3.5,
      key: const Key(Keys.saveButton),
      buttonText: Constants.save,
      buttonTextKey: Keys.saveButtonText,
      backgroundColor: AppColors.navigationSkybluecolor,
      onTap: () {
        // widget.model?.dutyPostLocationName = dutyPostLocationNameController.text;
        BlocProvider.of<DutyPostNameMasterDetailsCubit>(widget.mainContext)
            .onAddDutyPostLocationName(dutyPostLocationNameController.text);
        Navigator.pop(context);
      },
    );
  }
}
