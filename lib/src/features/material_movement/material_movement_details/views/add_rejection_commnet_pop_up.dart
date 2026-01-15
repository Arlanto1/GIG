import 'dart:ui';

import '../../../../../index.dart';

class AddRejectionCommentPopUp extends StatefulWidget {
  const AddRejectionCommentPopUp({
    super.key,
    required this.mainContext,
    required this.onSubmit,
  });

  final BuildContext mainContext;
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
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Builder(
        builder: (context) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;

          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                height: height / 4.2,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.lavender.withOpacity(0.1), // Glass effect
                  border: Border.all(
                    color: Colors.white.withOpacity(0.7),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        /// Rejection Comment
                        CommonWidgets.textDisplay(
                          Constants.rejectedComment,
                          Styles.textStyleBlack14.copyWith(
                            color: Colors.white,
                          ),
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

                        CommonWidgets.verticalSpacerWidget(height * 0.02),

                        buttonViews(widget.mainContext, width),

                        CommonWidgets.verticalSpacerWidget(height * 0.08),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
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
    return AppButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButtonText,
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
        if (rejectionCommentController.text.isEmptyOrNull) {}
        return widget.onSubmit!(rejectionCommentController.text);
      },
    );
  }

  ErrorResponse get isFormValid {
    if (rejectionCommentController.text.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Rejection Comment');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
