import 'dart:developer';

import 'package:db_atom/index.dart';

class AddReplacementPopUp extends StatefulWidget {
  const AddReplacementPopUp({
    super.key,
    required this.mainContext,
    required this.model,
    required this.availableGuards,
    required this.selectedGuards,
  });

  final BuildContext mainContext;
  final Replacement model;
  final List<BaseUser> availableGuards;
  final List<BaseUser> selectedGuards;

  @override
  State<AddReplacementPopUp> createState() => AddReplacementPopUpState();
}

class AddReplacementPopUpState extends State<AddReplacementPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController replacementForController = TextEditingController();
  TextEditingController replacementByController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.model.id != null) {
      log('--widget.model?.replacementBy?.name------${widget.model.replacementBy?.name}--');
      replacementForController.text = widget.model.replacedFor?.name ?? '';
      replacementByController.text = widget.model.replacementBy?.name ?? '';
      fromDateController.text = Utils.timestamptoDateConversion(
          int.parse(widget.model.fromDate ?? '0'), Constants.dateFormat);

      toDateController.text = Utils.timestamptoDateConversion(
          int.parse(widget.model.toDate ?? '0'), Constants.dateFormat);
    }

    if (widget.model.status != null) {
      Label matchingLabel = reasonDropDownValues
          .firstWhere((label) => label.value == widget.model.status.toString());

      reasonController.text = matchingLabel.key;
    }
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
          height: height / 1.9,
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
                      TextfieldAddButton(
                        title: replacementForController.text,
                        height: 60,
                        isDisableColor: false,
                        onTap: () {
                          BaseOrganisationDialog().userDialog(
                            context: context,
                            users: widget.selectedGuards,
                            onTap: (BaseUser user) {
                              // BlocProvider.of<ShiftScheduleDetailsCubit>(context)
                              //     .updateDropdownValuesReplacement(
                              //   replacementFor: user,
                              // );
                              replacementForController.text = user.name ?? '';
                              widget.model.replacedFor = user;
                              BlocProvider.of<ShiftScheduleDetailsCubit>(
                                      widget.mainContext)
                                  .updateReplacement(widget.model);

                              setState(() {
                                log('-setstate-');
                                replacementForController.text = user.name ?? '';
                              });
                            },
                          );
                        },
                      ),
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
                      TextfieldAddButton(
                        title: replacementByController.text,
                        height: 60,
                        isDisableColor: false,
                        onTap: () {
                          BaseOrganisationDialog().userDialog(
                            context: context,
                            users: widget.availableGuards,
                            onTap: (BaseUser user) {
                              replacementByController.text = user.name ?? '';
                              widget.model.replacedFor = user;
                              BlocProvider.of<ShiftScheduleDetailsCubit>(
                                      widget.mainContext)
                                  .updateReplacement(widget.model);

                              setState(() {
                                replacementByController.text = user.name ?? '';
                              });
                            },
                          );
                        },
                      ),

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
                        onlyDate: true,
                        showPastDate: false,
                        onChange: (String value) {
                          // state.model.fromDate = Utils().formatTime(value);
                          // BlocProvider.of<ShiftScheduleDetailsCubit>(
                          //     context)
                          //     .onModelValueChange(state.model);

                          widget.model.fromDate = Utils().formatTime(value);
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
                        onlyDate: true,
                        showPastDate: false,
                        onChange: (String value) {
                          widget.model.toDate = Utils().formatTime(value);
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
                          textController: reasonController,
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
                                  widget.model.status =
                                      int.tryParse(selectedLabel.value);
                                  reasonController.text = selectedLabel.key;
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
        BlocProvider.of<ShiftScheduleDetailsCubit>(widget.mainContext)
            .updateReplacement(widget.model);
        Navigator.pop(context);
      },
    );
  }
}
