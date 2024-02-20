import 'package:db_atom/index.dart';

import '../../models/vvip_visitor_record_model.dart';
import '../../models/vvip_visitor_response_model.dart';

class AddVVIPVisitorsPopUp extends StatefulWidget {
  const AddVVIPVisitorsPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.model,
    required this.mainContext,
    this.vvipModel,
  });

  final String title;
  final Function onSubmit;
  final VIVPVisitorRecordModel model;
  final BuildContext mainContext;
  final VIVPVisitorModel? vvipModel;

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
                        controller: nameController,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.visitorsNameKey,
                        hintText: '',
                        isEnable: widget.vvipModel?.status==0||widget.vvipModel?.status ==null? true:false,
                        isDisableColor: widget.vvipModel?.status==0||widget.vvipModel?.status ==null? false:true,
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
                        controller: emailIdController,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.visitorsEmailIdKey,
                        textCapitalization: false,
                        hintText: '',
                        isEnable: widget.vvipModel?.status==0||widget.vvipModel?.status ==null? true:false,
                        isDisableColor: widget.vvipModel?.status==0||widget.vvipModel?.status ==null? false:true,
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
                        controller: designationController,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.visitorsDesignationKey,
                        hintText: '',
                        isEnable: widget.vvipModel?.status==0||widget.vvipModel?.status ==null? true:false,
                        isDisableColor: widget.vvipModel?.status==0||widget.vvipModel?.status ==null? false:true,
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
                        controller: purposeOfVisitController,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.purposeOfVisitKey,
                        hintText: '',
                        isEnable: widget.vvipModel?.status==0||widget.vvipModel?.status ==null? true:false,
                        isDisableColor: widget.vvipModel?.status==0||widget.vvipModel?.status ==null? false:true,
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
                        controller: baseLocationOfVisitorsController,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.baseLocationOfVisitorKey,
                        hintText: '',
                        isEnable: widget.vvipModel?.status==0||widget.vvipModel?.status ==null? true:false,
                        isDisableColor: widget.vvipModel?.status==0||widget.vvipModel?.status ==null? false:true,
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
                        isDisabled:  widget.vvipModel?.status==0 ||widget.vvipModel?.status ==null ? false:true,
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
                        isDisabled:  widget.vvipModel?.status==0 ||widget.vvipModel?.status ==null ? false:true,
                        showPastDate: false,
                        showFutureDate: true,
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
        if(widget.vvipModel?.status ==0||widget.vvipModel?.status ==null )...[
        saveButton(width, widget.onSubmit)
    ]
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
    if (widget.model.email != null &&
        !Validator.isValidEmail(widget.model.email)) {
      return const ErrorResponse(
          status: false, message: 'Invalid Email Address');
    }

    if (widget.model.name == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Visitor Name.');
    }
    if (widget.model.email == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Visitor Email ID.');
    }

    if (widget.model.designation == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Visitor Designation.');
    }

    if (widget.model.purpose == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Purpose of Visit.');
    }

    if (widget.model.baseLocation == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Base Location of Visitors.');
    }
    if (widget.model.startDateVisit == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Start Date of Visit.');
    }

    if (widget.model.endDateVisit == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter End Date of Visit.');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
