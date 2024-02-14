import '../../../../../index.dart';

class AddRejectionCommentPopUp extends StatefulWidget {
  const AddRejectionCommentPopUp({
    super.key,
    required this.mainContext,
    required this.model,
    required this.onSubmit,
  });

  final BuildContext mainContext;
  final MaterialMovementModel? model;
  final Function(String)? onSubmit;

  @override
  State<AddRejectionCommentPopUp> createState() =>
      AddRejectionCommentPopUpState();
}

class AddRejectionCommentPopUpState extends State<AddRejectionCommentPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController rejectionCommentController = TextEditingController();

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
          height: height / 4.9,
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
                      ///Guarding Agency POC
                      CommonWidgets.textDisplay(
                        Constants.rejectedComment,
                        Styles.textStyleBlack14,
                        isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        lineHeight: 1,
                        controller: rejectionCommentController,
                        textFormKey: Keys.equipmentNoKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          rejectionCommentController.text = value;
                        },
                        validateTextField: (String value) {},
                      ),
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
        if (!isFormValid.status) {
          Validator().showToast(
            context,
            isFormValid.message,
          );
          return;
        }
        if(rejectionCommentController.text.isEmptyOrNull) {

        }
        return widget.onSubmit!(rejectionCommentController.text);
      },
    );
  }
  ErrorResponse get isFormValid {
    if (rejectionCommentController.text.isEmptyOrNull) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Rejection Comment');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

}
