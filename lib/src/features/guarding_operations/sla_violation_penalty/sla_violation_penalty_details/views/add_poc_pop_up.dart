import '../../../../../../index.dart';

class AddPOCPopUp extends StatefulWidget {
  const AddPOCPopUp({
    super.key,
    required this.mainContext,
    required this.model,
  });

  final BuildContext mainContext;
  final SLAViolationPenaltyModel? model;

  @override
  State<AddPOCPopUp> createState() => AddPOCPopUpState();
}

class AddPOCPopUpState extends State<AddPOCPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController pocController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundWhiteColor,
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
                        Constants.guardingAgencyPOC,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        lineHeight: 1,
                        controller: pocController,
                        textFormKey: Keys.equipmentNoKey,
                        textCapitalization: false,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          pocController.text = value;
                        },
                        validateTextField: (String? value) {
                          if (!Validator.isValidEmail(value)) {
                            return Constants.enterValidEmail;
                          }
                        },
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
        widget.model?.poc = pocController.text;
        BlocProvider.of<SLAViolationPenaltyDetailsCubit>(widget.mainContext)
            .onAddPOC(pocController.text);
        Navigator.pop(context);
      },
    );
  }

  ErrorResponse get isFormValid {
    if (!pocController.text.isEmptyOrNull &&
        !Validator.isValidEmail(pocController.text)) {
      return const ErrorResponse(
          status: false,
          message: 'Please enter Valid Guarding Agency POC Email');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
