import 'package:db_atom/index.dart';

import '../../models/vvip_visitor_record_model.dart';

class AddVVIPVisitorsPopUp extends StatefulWidget {
  const AddVVIPVisitorsPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.model,
    required this.mainContext,
  });

  final String title;
  final Function onSubmit;
  final VIVPVisitorRecordModel model;
  final BuildContext mainContext;

  @override
  State<AddVVIPVisitorsPopUp> createState() => AddVVIPVisitorsPopUpState();
}

class AddVVIPVisitorsPopUpState extends State<AddVVIPVisitorsPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController purposeOfVisitController = TextEditingController();
  TextEditingController baseLocationOfVisitorsController =
      TextEditingController();
  TextEditingController startDateVisitController = TextEditingController();
  TextEditingController endDateVisitController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.model.id != null) {
      nameController.text = widget.model.name!;
      emailIdController.text = widget.model.email!;
      designationController.text = widget.model.designation!;
      purposeOfVisitController.text = widget.model.purpose!;
      baseLocationOfVisitorsController.text = widget.model.baseLocation!;
      startDateVisitController.text =
          Utils().formatUnixTimestamp(widget.model.startDateVisit!);
      endDateVisitController.text =
          Utils().formatUnixTimestamp(widget.model.endDateVisit!);
    }
  }

  @override
  Widget build(BuildContext context) {
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

        return SizedBox(
          height: height / 1.8,
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
                      /// Visitors Name
                      CommonWidgets.textDisplay(
                        Constants.visitorsName,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      FlutterInputField(
                        initialValue: widget.model.name,
                        textFieldController: nameController,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.visitorsNameKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          widget.model.name = value;
                          nameController.text = value;
                          // BlocProvider.of<PayRateCubit>(widget.mainContext)
                          //     .onModelValueChange(widget.payRate);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// Visitors Email Id
                      CommonWidgets.textDisplay(
                        Constants.visitorsEmailId,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      FlutterInputField(
                        initialValue: widget.model.email,
                        textFieldController: emailIdController,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.visitorsEmailIdKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          widget.model.email = value;
                          emailIdController.text = value;
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// Visitors Designation
                      CommonWidgets.textDisplay(
                        Constants.visitorsDesignation,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      FlutterInputField(
                        initialValue: widget.model.designation,
                        textFieldController: designationController,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.visitorsDesignationKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          widget.model.designation = value;
                          designationController.text = value;
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// Purpose Of Visit
                      CommonWidgets.textDisplay(
                        Constants.purposeOfVisit,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      FlutterInputField(
                        initialValue: widget.model.purpose,
                        textFieldController: purposeOfVisitController,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.purposeOfVisitKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          widget.model.purpose = value;
                          purposeOfVisitController.text = value;
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// Base Location Of Visitors
                      CommonWidgets.textDisplay(
                        Constants.baseLocationOfVisitors,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      FlutterInputField(
                        initialValue: widget.model.baseLocation,
                        textFieldController: baseLocationOfVisitorsController,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.baseLocationOfVisitorKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          widget.model.baseLocation = value;
                          baseLocationOfVisitorsController.text = value;
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// Start Date of Visit
                      CommonWidgets.textDisplay(
                        Constants.startDateVisit,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      BaseDate().datePickerWidgetLoading(
                        textController: startDateVisitController,
                        isDisabled: false,
                        showPastDate: false,
                        onChange: (String value) {
                          // widget.model.startDateVisit = value;
                          widget.model.startDateVisit =
                              Utils().formatTime(value);
                        },
                        context: widget.mainContext,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// End Date of Visit
                      CommonWidgets.textDisplay(
                        Constants.endDateVisit,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      BaseDate().datePickerWidgetLoading(
                        textController: endDateVisitController,
                        isDisabled: false,
                        showPastDate: false,
                        onChange: (String value) {
                          widget.model.endDateVisit = Utils().formatTime(value);
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
        saveButton(width, widget.onSubmit)
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
      backgroundColor: AppColors.white,
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
        if (!isFormValid.status) {
          Validator().showToast(
            context,
            isFormValid.message,
          );
          return;
        }

        onSubmit(widget.model);
        Navigator.pop(context);
      },
    );
  }

  ErrorResponse get isFormValid {
    // if (widget.model.violation == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Violation.');
    // }
    // if (widget.model.staffCategory == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Staff Category.');
    // }
    // if (widget.model.totalViolations == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Total No of Violations');
    // }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
