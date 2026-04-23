import 'dart:ui';

import 'package:db_atom/index.dart';

class AddPOCPopUp extends StatefulWidget {
  const AddPOCPopUp({
    super.key,
    required this.mainContext,
    required this.model,
  });

  final BuildContext mainContext;
  final ShiftScheduleModel? model;

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

  // @override
  // Widget build(BuildContext context) {
  //   return AlertDialog(
  //     insetPadding: const EdgeInsets.symmetric(
  //       horizontal: 12,
  //     ),
  //     backgroundColor: Colors.transparent,
  //     elevation: 0,
  //     contentPadding: EdgeInsets.zero,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     content: Builder(
  //       builder: (context) {
  //         var height = MediaQuery.of(context).size.height;
  //         var width = MediaQuery.of(context).size.width;
  //
  //         return Container(
  //           padding: const EdgeInsets.all(16),
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               colors: [
  //                 AppColors.newColor3.withValues(alpha: 2),
  //                 AppColors.newColor,
  //                 AppColors.newColor3.withValues(alpha: 2),
  //                 // Color(0xFF6474C6).withOpacity(0.14)
  //               ],
  //               stops: const [0.02, 0.35, 1],
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //             ),
  //             borderRadius: BorderRadius.circular(27),
  //             border: Border.all(
  //               color: Colors.white.withValues(alpha: 0.6),
  //               width: 0.7,
  //             ),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.white.withValues(alpha: 0.0),
  //                 blurRadius: 12,
  //                 offset: const Offset(0, 2),
  //               ),
  //             ],
  //           ),
  //           child: SizedBox(
  //             height: height / 4.9,
  //             width: width,
  //             child: Stack(
  //               clipBehavior: Clip.none,
  //               children: <Widget>[
  //                 Expanded(
  //                   child: SingleChildScrollView(
  //                     child: Form(
  //                       key: _formKey,
  //                       child: Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: <Widget>[
  //                           /// POC label
  //                           CommonWidgets.textDisplay(
  //                             Constants.poc,
  //                             Styles.textStyleWhite14,
  //                           ),
  //                           CommonWidgets.verticalSpacerWidget(height * 0.01),
  //
  //                           /// Input field
  //                           FlutterInputField(
  //                             lineHeight: 1,
  //                             controller: pocController,
  //                             textFormKey: Keys.equipmentNoKey,
  //                             textCapitalization: false,
  //                             hintText: '',
  //                             isEnable: true,
  //                             isDisableColor: false,
  //                             onChange: (String value) {
  //                               pocController.text = value;
  //                             },
  //                             validateTextField: (String value) {},
  //                           ),
  //                           CommonWidgets.verticalSpacerWidget(height * 0.01),
  //
  //                           /// Buttons
  //                           buttonViews(widget.mainContext, width),
  //                           CommonWidgets.verticalSpacerWidget(height * 0.02),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  //
  //
  //
  // Widget cancelButton(double width) {
  //   return PopButton(
  //     width: width / 3.5,
  //     key: const Key(Keys.cancelButton),
  //     buttonText: Constants.cancel,
  //     buttonTextKey: Keys.cancelButtonText,
  //     foregroundColor: Colors.white,
  //     textStyle: Styles.styleHeaderWhiteText16,
  //     boarderColor: AppColors.white,
  //     onTap: () {
  //       FocusScope.of(context).unfocus();
  //       Navigator.of(context).pop();
  //     },
  //   );
  // }
  //
  // Widget saveButton(double width) {
  //   return PopButton(
  //     width: width / 3.5,
  //     key: const Key(Keys.saveButton),
  //     buttonText: Constants.save,
  //     buttonTextKey: Keys.saveButtonText,
  //     backgroundColor: const Color(0xFF071130),
  //     foregroundColor: Colors.white,
  //     onTap: () {
  //       if (!isFormValid.status) {
  //         Validator().showToast(
  //           context,
  //           isFormValid.message,
  //         );
  //         return;
  //       }
  //       widget.model?.poc = pocController.text;
  //       BlocProvider.of<ShiftScheduleDetailsCubit>(widget.mainContext)
  //           .onAddPOC(pocController.text);
  //       Navigator.pop(context);
  //     },
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      backgroundColor: Colors.transparent,
      elevation: 0,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                decoration: BoxDecoration(
                  color: const Color(0x321E263C), // ~20% opacity dark navy
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: SizedBox(
                  width: width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// POC label
                        const Text(
                          Constants.poc,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(height: height * 0.012),

                        /// Input field with inner dark container
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.14),
                              width: 0.7,
                            ),
                          ),
                          child: FlutterInputField(
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
                            validateTextField: (String value) {},
                          ),
                        ),
                        SizedBox(height: height * 0.02),

                        /// Buttons
                        buttonViews(widget.mainContext, width),
                        SizedBox(height: height * 0.01),
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
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButtonText,
      foregroundColor: Colors.white,
      textStyle: Styles.styleHeaderWhiteText16,
      boarderColor: AppColors.white,
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      },
    );
  }

  Widget saveButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.saveButton),
      buttonText: Constants.save,
      buttonTextKey: Keys.saveButtonText,
      backgroundColor: const Color(0xFF071130),
      foregroundColor: Colors.white,
      onTap: () {
        if (!isFormValid.status) {
          Validator().showToast(
            context,
            isFormValid.message,
          );
          return;
        }
        widget.model?.poc = pocController.text;
        BlocProvider.of<ShiftScheduleDetailsCubit>(widget.mainContext)
            .onAddPOC(pocController.text);
        Navigator.pop(context);
      },
    );
  }

  ErrorResponse get isFormValid {
    if (!pocController.text.isEmptyOrNull &&
        !Validator.isValidEmail(pocController.text)) {
      return const ErrorResponse(
          status: false, message: 'Please enter Valid POC Email');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
