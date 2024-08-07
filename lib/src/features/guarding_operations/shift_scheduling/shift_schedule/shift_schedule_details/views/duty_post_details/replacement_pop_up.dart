import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/services/shift_schedule_services.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/cubits/duty_post_details_cubit.dart';

class AddReplacementPopUp extends StatefulWidget {
  const AddReplacementPopUp({
    super.key,
    required this.mainContext,
    required this.model,
    required this.availableGuards,
    required this.selectedGuards,
    this.dutyPostId,
    this.rankId,
    this.shiftId,
  });

  final BuildContext mainContext;
  final Replacement model;
  final List<BaseUser> availableGuards;
  final List<BaseUser> selectedGuards;
  final int? dutyPostId;
  final int? rankId;
  final int? shiftId;

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
      if (widget.model.replacedFor != null) {
        setDateRange(widget.model.replacedFor!);
      }
      replacementForController.text = widget.model.replacedFor?.name ?? '';
      replacementByController.text = widget.model.replacementBy?.name ?? '';
      fromDateController.text = Utils.timestampToDateConversion(
          int.parse(widget.model.fromDate ?? '0'), Constants.dateFormat);

      toDateController.text = Utils.timestampToDateConversion(
          int.parse(widget.model.toDate ?? '0'), Constants.dateFormat);
    }

    log('widget.model.status--${widget.model.status}----');
    if (widget.model.status != null) {
      Label matchingLabel = reasonDropDownValues
          .firstWhere((label) => label.value == widget.model.status.toString());

      reasonController.text = matchingLabel.key;
    }
    log('reasonController.text---${reasonController.text}----');
  }

  Future<void> setDateRange(BaseUser user) async {
    dates = await ShiftScheduleServices().getNextAvailableReplacementDates(
      rankId: widget.rankId!,
      userId: user.id!,
      dutyPostId: widget.dutyPostId!,
      shiftId: widget.shiftId!,
    );
    setState(() {});
  }

  NextAvailableDateRange? dates;
  bool reasonConditions = false;

  @override
  Widget build(BuildContext context) {
    Label? selectedReason;

    return AlertDialog(
      backgroundColor: AppColors.backgroundWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height / 1.65,
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
                      TextFieldAddButton(
                        title: replacementForController.text,
                        height: 60,
                        isDisableColor: false,
                        onTap: () {
                          BaseOrganisationDialog().userDialog(
                            context: context,
                            users: widget.selectedGuards,
                            onTap: (BaseUser user) async {
                              // BlocProvider.of<ShiftScheduleDetailsCubit>(context)
                              //     .updateDropdownValuesReplacement(
                              //   replacementFor: user,
                              // );
                              replacementForController.text = user.name ?? '';
                              widget.model.replacedFor = user;
                              // BlocProvider.of<ShiftScheduleDetailsCubit>(
                              //         widget.mainContext)
                              //     .updateReplacement(widget.model);

                              if (widget.rankId != null) {
                                showLoadingDialog(context);

                                dates = await ShiftScheduleServices()
                                    .getNextAvailableReplacementDates(
                                  rankId: widget.rankId!,
                                  userId: user.id!,
                                  dutyPostId: widget.dutyPostId!,
                                  shiftId: widget.shiftId!,
                                );
                                dismissLoadingDialog(context);
                              }

                              // BlocProvider.of<DutyPostDetailsCubit>(
                              //         widget.mainContext)
                              //     .getNextAvailableReplacementDates(
                              //         userId: user.id!);

                              setState(() {
                                log('-setstate-');
                                replacementForController.text = user.name ?? '';
                              });
                            },
                            locationId: 0,
                          );
                        },
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Reason
                      CommonWidgets.textDisplay(
                        Constants.reason,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      BaseDropDown().getDropDown(
                        isDisabled: false,
                        textController: reasonController,
                        items: reasonDropDownValues,
                        onTap: () {
                          if (!isReplacedForSelected.status) {
                            Validator().showToast(
                              context,
                              isReplacedForSelected.message,
                            );
                            return;
                          }
                          BaseDropDown().assetTypeDialog(
                            context: context,
                            dropDownValues: reasonDropDownValues
                                .map((label) => label.key)
                                .toList(),
                            onTap: (String value) {
                              selectedReason = reasonDropDownValues.firstWhere(
                                (label) => label.key == value,
                                orElse: () => const Label(key: '', value: ''),
                              );
                              setState(() {
                                reasonConditions = (selectedReason != null &&
                                    (selectedReason!.value == '1' ||
                                        selectedReason!.value == '2'));
                              });
                              log('--reasonConditions-$reasonConditions-');

                              widget.model.status =
                                  int.tryParse(selectedReason!.value);
                              reasonController.text = selectedReason!.key;
                            },
                          );
                        },
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),

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
                        fromDate: dates?.fromDate,
                        toDate: dates?.toDate,
                        onChange: (String value) {

                          if (!isReplacedForSelected.status) {
                            Validator().showToast(
                              context,
                              isReplacedForSelected.message,
                            );
                            return;
                          }
                          // state.model.fromDate = Utils().formatTime(value);
                          // BlocProvider.of<ShiftScheduleDetailsCubit>(
                          //     context)
                          //     .onModelValueChange(state.model);

                          widget.model.fromDate = Utils().formatTime(value);
                          log('--widget.model.status-${widget.model.status}---');

                          log('--selectedReason-${selectedReason?.value}---');

                          if (widget.model.status == 2 || reasonConditions) {
                            toDateController.text = fromDateController.text;
                            widget.model.toDate = Utils().formatTime(value);
                          }
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

                      // Text('-reasonConditions--$reasonConditions-'),
                      BaseDate().datePickerWidgetLoading(
                        textController: toDateController,
                        onlyDate: true,
                        showPastDate: false,
                        fromDate: dates?.fromDate,
                        isDisabled: reasonConditions,
                        toDate: dates?.toDate,
                        onChange: (String value) {
                          widget.model.toDate = Utils().formatTime(value);
                        },
                        context: context,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Replacement By
                      CommonWidgets.textDisplay(
                          // state.labels?.locale.guardRank ??
                          //    state.labels?.defaultLocale.guardRank ??
                          Constants.replacementBy,
                          isMandatory: true,
                          Styles.textStyleBlack14),

                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      TextFieldAddButton(
                        title: replacementByController.text,
                        height: 60,
                        isDisableColor: false,
                        onTap: () {
                          BaseOrganisationDialog().userDialog(
                            context: context,
                            users: widget.availableGuards,
                            onTap: (BaseUser user) {
                              replacementByController.text = user.name ?? '';
                              widget.model.replacementBy = user;
                              // BlocProvider.of<ShiftScheduleDetailsCubit>(
                              //         widget.mainContext)
                              //     .updateReplacement(widget.model);

                              setState(() {
                                replacementByController.text = user.name ?? '';
                              });
                            },
                            locationId: 0,
                          );
                        },
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
      foregroundColor: AppColors.textGreyThemeColor,
      textStyle: Styles.styleHeaderGreyText16,
      boarderColor: AppColors.textGreyThemeColor,
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
      backgroundColor: AppColors.navigationSkyBlueColor,
      onTap: () {

        if (!isFormValid.status) {
          Validator().showToast(
            context,
            isFormValid.message,
          );
          return;
        }

        // widget.model?.dutyPostLocationName = dutyPostLocationNameController.text;
        BlocProvider.of<DutyPostDetailsCubit>(widget.mainContext)
            .updateReplacement(widget.model);
        Navigator.pop(context);
      },
    );
  }


  ErrorResponse get isReplacedForSelected {
    if (replacementForController.text.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter Replacement For');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }


  ErrorResponse get isFormValid {
    if (replacementForController.text.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter Replacement For');
    }

    if (reasonController.text.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Reason');
    }
    if (fromDateController.text.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter From Date');
    }
    if (toDateController.text.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter To Date');
    }
    if (replacementByController.text.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter Replacement By');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

}
