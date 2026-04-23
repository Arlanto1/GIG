// import '../../../../../../index.dart';
//
// class AddPOCPopUp extends StatefulWidget {
//   const AddPOCPopUp({
//     super.key,
//     required this.mainContext,
//     required this.model,
//   });
//
//   final BuildContext mainContext;
//   final SLAViolationPenaltyModel? model;
//
//   @override
//   State<AddPOCPopUp> createState() => AddPOCPopUpState();
// }
//
// class AddPOCPopUpState extends State<AddPOCPopUp> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController pocController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.symmetric(
//         horizontal: 12,
//       ),
//       elevation: 0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       contentPadding: EdgeInsets.zero,
//       content: Builder(
//         builder: (context) {
//           var height = MediaQuery.of(context).size.height;
//           var width = MediaQuery.of(context).size.width;
//
//           return Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.newColor3.withValues(alpha: 0.6),
//                     AppColors.newColor3.withValues(alpha: 0.5),
//                     AppColors.newColor3.withValues(alpha: 0.6),
//                     // Color(0xFF6474C6).withOpacity(0.14)
//                   ],
//                   stops: const [0.02, 0.35, 1],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//                 borderRadius: BorderRadius.circular(27),
//                 border: Border.all(
//                   color: Colors.white.withValues(alpha: 0.6),
//                   width: 0.7,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.newColor.withValues(alpha: 0.1),
//                     blurRadius: 62,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: SizedBox(
//                 height: height / 4.9,
//                 width: width,
//                 child: Column(
//                   // clipBehavior: Clip.none,
//                   children: <Widget>[
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Form(
//                           key: _formKey,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               /// Guarding Agency POC
//                               CommonWidgets.textDisplay(
//                                 Constants.guardingAgencyPOC,
//                                 Styles.textStyleWhite14,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                               FlutterInputField(
//                                 textInputType: TextInputType.text,
//                                 lineHeight: 1,
//                                 textCapitalization: false,
//                                 initialValue: pocController.text,
//                                 textFormKey: Keys.equipmentNoKey,
//                                 hintText: '',
//                                 isEnable: true,
//                                 isDisableColor: false,
//                                 onChange: (String value) {
//                                   pocController.text = value;
//                                 },
//                                 validateTextField: (String? value) {
//                                   if (!Validator.isValidEmail(value)) {
//                                     return Constants.enterValidEmail;
//                                   }
//                                 },
//                               ),
//
//                               CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                               buttonViews(widget.mainContext, width),
//                               // CommonWidgets.verticalSpacerWidget(height * 0.02),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ));
//         },
//       ),
//     );
//   }
//
//   Widget buttonViews(BuildContext context, double width) {
//     return Row(
//       //mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[cancelButton(width), saveButton(width)],
//     );
//   }
//
//   Widget cancelButton(double width) {
//     return PopButton(
//       width: width / 3.5,
//       key: const Key(Keys.cancelButton),
//       buttonText: Constants.cancel,
//       buttonTextKey: Keys.cancelButtonText,
//       foregroundColor: AppColors.white,
//       textStyle: Styles.styleHeaderGreyText16,
//       boarderColor: AppColors.white,
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         Navigator.of(context).pop();
//       },
//     );
//   }
//
//   Widget saveButton(double width) {
//     return PopButton(
//       width: width / 3.5,
//       key: const Key(Keys.saveButton),
//       buttonText: Constants.save,
//       buttonTextKey: Keys.saveButtonText,
//       textStyle: Styles.styleHeaderGreyText16,
//       backgroundColor: const Color(0xFF071130),
//       foregroundColor: Colors.white,
//       onTap: () {
//         if (!isFormValid.status) {
//           Validator().showToast(
//             context,
//             isFormValid.message,
//           );
//           return;
//         }
//         widget.model?.poc = pocController.text;
//         BlocProvider.of<SLAViolationPenaltyDetailsCubit>(widget.mainContext)
//             .onAddPOC(pocController.text);
//         Navigator.pop(context);
//       },
//     );
//   }
//
//   ErrorResponse get isFormValid {
//     if (!pocController.text.isEmptyOrNull &&
//         !Validator.isValidEmail(pocController.text)) {
//       return const ErrorResponse(
//           status: false,
//           message: 'Please enter Valid Guarding Agency POC Email');
//     }
//
//     return const ErrorResponse(status: true, message: 'Form is Valid');
//   }
// }

import '../../../../../../index.dart';
import 'dart:ui';

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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 12),
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(27),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.09),
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.09),
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
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            /// Guarding Agency POC
                            CommonWidgets.textDisplay(
                              Constants.guardingAgencyPOC,
                              Styles.textStyleWhite14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            FlutterInputField(
                              textInputType: TextInputType.text,
                              lineHeight: 1,
                              textCapitalization: false,
                              initialValue: pocController.text,
                              textFormKey: Keys.equipmentNoKey,
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

                            CommonWidgets.verticalSpacerWidget(height * 0.03),

                            buttonViews(widget.mainContext, width),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonViews(BuildContext context, double width) {
    return Row(
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
      foregroundColor: AppColors.white,
      textStyle: Styles.styleHeaderGreyText16,
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
      textStyle: Styles.styleHeaderGreyText16,
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