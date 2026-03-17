import 'dart:ui';

import '../../../../../../index.dart';

class AddCommentPopUp extends StatefulWidget {
  const AddCommentPopUp({
    super.key,
    required this.mainContext,
    required this.onSubmit,
  });

  final BuildContext mainContext;
  final Function(String)? onSubmit;

  @override
  State<AddCommentPopUp> createState() => AddCommentPopUpState();
}

class AddCommentPopUpState extends State<AddCommentPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔹 BLUR THE ENTIRE BACKGROUND PAGE
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: Colors.black.withValues(alpha: 0.25), // dim + blur
          ),
        ),

        // 🔹 YOUR ALERT DIALOG
        Center(
          child: AlertDialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Builder(builder: (context) {
              // Get available height and width of the build area of this widget. Make a choice depending on the size.
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;
              return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.newColor3.withValues(alpha: 0.7),
                        AppColors.newColor,
                        AppColors.newColor3.withValues(alpha: 0.7),
                        // Color(0xFF6474C6).withOpacity(0.14)
                      ],
                      stops: const [0.02, 0.35, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(27),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.6),
                      width: 0.7,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.0),
                        blurRadius: 12,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SizedBox(
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
                                ///Comments
                                CommonWidgets.textDisplay(
                                  Constants.comments,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                                FlutterInputField(
                                  lineHeight: 1,
                                  controller: commentController,
                                  textFormKey: Keys.equipmentNoKey,
                                  hintText: '',
                                  isEnable: true,
                                  isDisableColor: false,
                                  onChange: (String value) {
                                    commentController.text = value;
                                  },
                                  validateTextField: (String value) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                                buttonViews(widget.mainContext, width),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            }),
          ),
        ),
      ],
    );
  }

  Widget buttonViews(BuildContext context, double width) {
    return Row(
      //mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[cancelButton(width), saveButton(width, context)],
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

  Widget saveButton(double width, BuildContext dialogContext) {
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
        if (commentController.text.isEmptyOrNull) {
          return;
        }
        return widget.onSubmit!(commentController.text);
      },
    );
  }

  ErrorResponse get isFormValid {
    if (commentController.text.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Comment');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
