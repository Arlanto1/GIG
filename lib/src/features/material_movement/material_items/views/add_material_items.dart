// // import 'dart:ui';
// //
// // import '../../../../../index.dart';
// //
// // class AddMaterialDetailsPopUp extends StatefulWidget {
// //   const AddMaterialDetailsPopUp({
// //     super.key,
// //     required this.mainContext,
// //     required this.onSubmit,
// //   });
// //
// //   final BuildContext mainContext;
// //   final Function(String)? onSubmit;
// //
// //   @override
// //   State<AddMaterialDetailsPopUp> createState() =>
// //       AddMaterialDetailsPopUpState();
// // }
// //
// // class AddMaterialDetailsPopUpState extends State<AddMaterialDetailsPopUp> {
// //   final _formKey = GlobalKey<FormState>();
// //   TextEditingController rejectionCommentController = TextEditingController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Dialog(
// //       backgroundColor: Colors.transparent,
// //       insetPadding: const EdgeInsets.all(16),
// //       child: Builder(
// //         builder: (context) {
// //           final height = MediaQuery.of(context).size.height;
// //           final width = MediaQuery.of(context).size.width;
// //
// //           return ClipRRect(
// //             borderRadius: BorderRadius.circular(20),
// //             child: BackdropFilter(
// //               filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
// //               child: Container(
// //                 height: height / 4.2,
// //                 width: width,
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(20),
// //                   color: AppColors.lavender.withValues(alpha: 0.3), // Glass effect
// //                   border: Border.all(
// //                     color: Colors.white.withOpacity(0.9),
// //                   ),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black.withOpacity(0.15),
// //                       blurRadius: 20,
// //                       offset: const Offset(0, 10),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Form(
// //                   key: _formKey,
// //                   child: SingleChildScrollView(
// //                     padding: const EdgeInsets.all(16),
// //                     child: Column(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: <Widget>[
// //                         /// Rejection Comment
// //                     CommonWidgets.textDisplay(
// //                     // state.labels?.locale.materialDescription ??
// //                     // state.labels?.defaultLocale
// //                     //   .materialDescription ??
// //                       Constants.materialBriefDescription,
// //                       Styles.textStyleWhite16,
// //                     //   isMandatory: (state.model.status !=
// //                     //       ConstantsIntValue.mmStatusDraft &&
// //                     //       widget.model != null) ||
// //                     //       (widget.isInward == true)
// //                     //       ? true
// //                     //       : false,
// //                     // ),
// //                       CommonWidgets.verticalSpacerWidget(height * 0.001),
// //                       FlutterInputField(
// //                         showBorder: true,
// //                         lineHeight: 6,
// //                         characterLimit:
// //                         Constants.characterLimitDescTextFormField,
// //                         initialValue: state.model.materialDescription,
// //                         textFormKey: Keys.materialBreifDescKey,
// //                         hintText: Constants.informationhere,
// //                         // isEnable: state.model.status == 10 ||
// //                         //     state.model.status == -1 ||
// //                         //     state.model.status == 6 ||
// //                         //     state.model.status == 2 ||
// //                         //     state.model.status == 3 ||
// //                         //     state.model.status == 4 ||
// //                         //     state.model.status ==
// //                         //         ConstantsIntValue
// //                         //             .mmStatusInwardWaiting ||
// //                         //     !state.model.lock.isEmptyOrNull
// //                         //     ? false
// //                         //     : true,
// //                         // isDisableColor: state.model.status == 10 ||
// //                         //     state.model.status == -1 ||
// //                         //     state.model.status == 6 ||
// //                         //     state.model.status == 2 ||
// //                         //     state.model.status == 3 ||
// //                         //     state.model.status == 4 ||
// //                         //     !showSaveSubmitButtons ||
// //                         //     state.model.status ==
// //                         //         ConstantsIntValue
// //                         //             .mmStatusInwardWaiting ||
// //                         //     !state.model.lock.isEmptyOrNull
// //                         //     ? true
// //                         //     : false,
// //                         validateTextField: (String? user) {},
// //                         onChange: (String value) {
// //                           state.model.materialDescription = value;
// //                         },
// //                         textInputAction: TextInputAction.newline,
// //                         textInputType:
// //                         TextInputType.multiline, // Add this line
// //                       ),
// //
// //                       CommonWidgets.verticalSpacerWidget(height * 0.02),
// //
// //                       /// Quantity
// //                       CommonWidgets.textDisplay(
// //                         // state.labels?.locale.quantity ??
// //                         //     state.labels?.defaultLocale.quantity ??
// //                             Constants.quantity,
// //                         Styles.textStyleWhite16,
// //                       //   isMandatory: (state.model.status !=
// //                       //       ConstantsIntValue.mmStatusDraft &&
// //                       //       widget.model != null) ||
// //                       //       (widget.isInward == true)
// //                       //       ? true
// //                       //       : false,
// //                       // ),
// //                       CommonWidgets.verticalSpacerWidget(height * 0.001),
// //
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           SizedBox(
// //                             width: 120,
// //                             child: FlutterInputField(
// //                               characterLimit: 5,
// //                               textInputType:
// //                               const TextInputType.numberWithOptions(
// //                                 decimal: true,
// //                               ),
// //                               initialValue:
// //                               '${state.model.quantity ?? ''}',
// //                               textFormKey: Keys.quantityKey,
// //                               hintText: '',
// //                               // isEnable: state.model.status == 10 ||
// //                               //     state.model.status == -1 ||
// //                               //     state.model.status == 6 ||
// //                               //     state.model.status == 2 ||
// //                               //     state.model.status == 3 ||
// //                               //     state.model.status == 4 ||
// //                               //     state.model.status ==
// //                               //         ConstantsIntValue
// //                               //             .mmStatusInwardWaiting ||
// //                               //     !showSaveSubmitButtons ||
// //                               //     isReadOnly
// //                               //     ? false
// //                               //     : true,
// //                               // isDisableColor: state.model.status == 10 ||
// //                               //     state.model.status == -1 ||
// //                               //     state.model.status == 6 ||
// //                               //     state.model.status == 2 ||
// //                               //     state.model.status == 3 ||
// //                               //     state.model.status == 4 ||
// //                               //     !showSaveSubmitButtons ||
// //                               //     state.model.status ==
// //                               //         ConstantsIntValue
// //                               //             .mmStatusInwardWaiting ||
// //                               //     !state.model.lock.isEmptyOrNull
// //                               //     ? true
// //                               //     : false,
// //                               onChange: (String? value) {
// //                                 if (value != null) {
// //                                   state.model.quantity = int.parse(value);
// //                                 }
// //                                 context
// //                                     .read<MaterialMovementDetailsCubit>()
// //                                     .onModelValueChange(state.model);
// //                               },
// //                               validateTextField: (String? user) {},
// //                             ),
// //                           ),
// //                           TileWidget(
// //                             name: state.model.unit?.name ?? 'Unit',
// //                             width: 200,
// //                           ),
// //                           if (!isReadOnly) ...[
// //                             InkWell(
// //                               onTap: () {
// //                                 if (!isQuantityDisabled) {
// //                                   quantityUnitDialog(
// //                                     context: context,
// //                                     quantityUnits: state.quantityUnits,
// //                                   );
// //                                 }
// //                               },
// //                               child: AddButtonWidget(
// //                                 height: 50,
// //                               //   isDisableColor: state.model.status ==
// //                               //       10 ||
// //                               //       state.model.status == -1 ||
// //                               //       state.model.status == 6 ||
// //                               //       state.model.status == 2 ||
// //                               //       state.model.status == 3 ||
// //                               //       state.model.status == 4 ||
// //                               //       !showSaveSubmitButtons ||
// //                               //       state.model.status ==
// //                               //           ConstantsIntValue
// //                               //               .mmStatusInwardWaiting ||
// //                               //       !state.model.lock.isEmptyOrNull
// //                               //       ? true
// //                               //       : false,
// //                               ),
// //                             ),
// //                           ],
// //                         ],
// //                       ),
// //
// //                       // quantityUnitPopUp(state),
// //                       CommonWidgets.verticalSpacerWidget(height * 0.02),
// //
// //                       /// Outward Details Fields
// //                       if (!widget.isInward) ...[
// //                 /// Equipment No/Identification
// //                 CommonWidgets.textDisplay(
// //                 state.labels?.locale.modelInfo ??
// //                 state.labels?.defaultLocale.modelInfo ??
// //                   Constants.equipmentNo,
// //                   Styles.textStyleWhite16,
// //                   isMandatory: state.model.status !=
// //                       ConstantsIntValue.mmStatusDraft &&
// //                       widget.model != null
// //                       ? true
// //                       : false,
// //                 ),
// //                 CommonWidgets.verticalSpacerWidget(
// //                     height * 0.001),
// //                 FlutterInputField(
// //                   lineHeight: 6,
// //                   initialValue: state.model.modelInfo,
// //                   showBorder: true,
// //                   characterLimit:
// //                   Constants.characterLimitDescTextFormField,
// //                   textFormKey: Keys.equipmentNoKey,
// //                   hintText: '',
// //                   isEnable: state.model.status == 10 ||
// //                       state.model.status == -1 ||
// //                       state.model.status == 6 ||
// //                       state.model.status == 2 ||
// //                       state.model.status == 3 ||
// //                       state.model.status == 4 ||
// //                       state.model.status ==
// //                           ConstantsIntValue
// //                               .mmStatusInwardWaiting ||
// //                       isReadOnly
// //                       ? false
// //                       : true,
// //                   isDisableColor: state.model.status == 10 ||
// //                       state.model.status == -1 ||
// //                       state.model.status == 6 ||
// //                       state.model.status == 2 ||
// //                       state.model.status == 3 ||
// //                       state.model.status == 4 ||
// //                       !showSaveSubmitButtons ||
// //                       state.model.status ==
// //                           ConstantsIntValue
// //                               .mmStatusInwardWaiting ||
// //                       !state.model.lock.isEmptyOrNull
// //                       ? true
// //                       : false,
// //                   onChange: (String value) {
// //                     state.model.modelInfo = value;
// //                     context
// //                         .read<MaterialMovementDetailsCubit>()
// //                         .onModelValueChange(state.model);
// //                   },
// //                   textInputAction: TextInputAction.newline,
// //                   textInputType: TextInputType.multiline,
// //                   validateTextField: (String? user) {},
// //                 ),
// //                 CommonWidgets.verticalSpacerWidget(height * 0.02),
// //
// //                 CommonWidgets.verticalSpacerWidget(height * 0.02),
// //
// //                         buttonViews(widget.mainContext, width),
// //
// //                         CommonWidgets.verticalSpacerWidget(height * 0.08),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //
// //   }
// //
// //   Widget buttonViews(BuildContext context, double width) {
// //     return Row(
// //       //mainAxisSize: MainAxisSize.min,
// //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //       children: <Widget>[cancelButton(width), saveButton(width)],
// //     );
// //   }
// //
// //   Widget cancelButton(double width) {
// //     return AppButton(
// //       width: width / 3.5,
// //       key: const Key(Keys.cancelButton),
// //       buttonText: Constants.cancel,
// //       buttonTextKey: Keys.cancelButtonText,
// //       onTap: () {
// //         FocusScope.of(context).unfocus();
// //         Navigator.of(context).pop();
// //       },
// //     );
// //   }
// //
// //   Widget saveButton(double width) {
// //     return AppButton(
// //       width: width / 3.5,
// //       key: const Key(Keys.saveButton),
// //       buttonText: Constants.save,
// //       buttonTextKey: Keys.saveButtonText,
// //       backgroundColor: AppColors.navigationSkyBlueColor,
// //       onTap: () {
// //         if (!isFormValid.status) {
// //           Validator().showToast(
// //             context,
// //             isFormValid.message,
// //           );
// //           return;
// //         }
// //         if (rejectionCommentController.text.isEmptyOrNull) {}
// //         return widget.onSubmit!(rejectionCommentController.text);
// //       },
// //     );
// //   }
// //
// //   ErrorResponse get isFormValid {
// //     if (rejectionCommentController.text.isEmptyOrNull) {
// //       return const ErrorResponse(
// //           status: false, message: 'Please enter Rejection Comment');
// //     }
// //
// //     return const ErrorResponse(status: true, message: 'Form is Valid');
// //   }
// // }
//
// import 'dart:developer';
// import 'dart:ui';
// import '../../../../../index.dart';
// import '../../../../common_widgets/base_widget/base_add_organisation_dialog.dart';
//
// class AddMaterialDetailsPopUp extends StatefulWidget {
//   const AddMaterialDetailsPopUp({
//     super.key,
//     required this.mainContext,
//     required this.onSubmit,
//     required this.isInward,
//     this.model,
//   });
//
//   final BuildContext mainContext;
//   final Function(String)? onSubmit;
//   final bool isInward;
//   final MaterialMovementModel? model;
//
//
//   @override
//   State<AddMaterialDetailsPopUp> createState() =>
//       AddMaterialDetailsPopUpState();
// }
//
// class AddMaterialDetailsPopUpState extends State<AddMaterialDetailsPopUp> {
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     bool isReadOnly = false;
//     log('IsInward ${widget.model?.inwardMovement == false}');
//
//     return BlocBuilder<MaterialMovementDetailsCubit,
//         MaterialMovementDetailsState>(
//         builder: (context, state) {
//           bool isQuantityDisabled = state.model.status == 10 ||
//               state.model.status == -1 ||
//               state.model.status == 6 ||
//               state.model.status == 2 ||
//               state.model.status == 3 ||
//               state.model.status == 4 ||
//               state.model.status == ConstantsIntValue.mmStatusInwardWaiting ||
//               !state.model.lock.isEmptyOrNull;
//           return Dialog(
//             backgroundColor: Colors.transparent,
//             insetPadding: const EdgeInsets.all(16),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//                 child: Container(
//                   height: height * 0.75,
//                   width: width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: AppColors.lavender.withOpacity(0.3),
//                     border: Border.all(color: Colors.white.withOpacity(0.8)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.15),
//                         blurRadius: 20,
//                         offset: const Offset(0, 10),
//                       ),
//                     ],
//                   ),
//                   child: Form(
//                     key: _formKey,
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           /// Material Description
//                           CommonWidgets.textDisplay(
//                             Constants.materialBriefDescription,
//                             Styles.textStyleWhite16,
//                           ),
//
//                           CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                           FlutterInputField(
//                             showBorder: true,
//                             lineHeight: 6,
//                             characterLimit:
//                             Constants.characterLimitDescTextFormField,
//                             initialValue: state.model.materialDescription,
//                             textFormKey: Keys.materialBreifDescKey,
//                             hintText: Constants.informationhere,
//                             textInputType: TextInputType.multiline,
//                             textInputAction: TextInputAction.newline,
//                             onChange: (value) {
//                               state.model.materialDescription = value;
//                             },
//                             validateTextField: (_) {},
//                           ),
//
//                           CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                           /// Quantity
//                           CommonWidgets.textDisplay(
//                             Constants.quantity,
//                             Styles.textStyleWhite16,
//                           ),
//
//                           CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 120,
//                                 child: FlutterInputField(
//                                   characterLimit: 5,
//                                   textInputType:
//                                   const TextInputType.numberWithOptions(
//                                       decimal: true),
//                                   initialValue: '${state.model.quantity ?? ''}',
//                                   textFormKey: Keys.quantityKey,
//                                   onChange: (value) {
//                                     if (value != null && value.isNotEmpty) {
//                                       state.model.quantity =
//                                           int.tryParse(value);
//                                       context
//                                           .read<MaterialMovementDetailsCubit>()
//                                           .onModelValueChange(state.model);
//                                     }
//                                   },
//                                   validateTextField: (_) {},
//                                   hintText: '',
//                                 ),
//                               ),
//
//                               const SizedBox(width: 12),
//
//                               TileWidget(
//                                 name: state.model.unit?.name ?? 'Unit',
//                                 width: 160,
//                               ),
//
//                               if (!isReadOnly) ...[
//                                 const SizedBox(width: 8),
//                                 InkWell(
//                                   onTap: () {
//                                     if (!isQuantityDisabled) {
//                                       quantityUnitDialog(
//                                         context: context,
//                                         quantityUnits: state.quantityUnits,
//                                       );
//                                     }
//                                   },
//                                   child: const AddButtonWidget(height: 50),
//                                 ),
//                               ],
//                             ],
//                           ),
//
//                           CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                           /// Outward Fields
//                           // if (widget.model?.inwardMovement == false) ...[
//                           CommonWidgets.textDisplay(
//                             Constants.equipmentNo,
//                             Styles.textStyleWhite16,
//                           ),
//
//                           CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                           FlutterInputField(
//                             showBorder: true,
//                             lineHeight: 6,
//                             initialValue: state.model.modelInfo,
//                             characterLimit:
//                             Constants.characterLimitDescTextFormField,
//                             textFormKey: Keys.equipmentNoKey,
//                             textInputType: TextInputType.multiline,
//                             textInputAction: TextInputAction.newline,
//                             onChange: (value) {
//                               state.model.modelInfo = value;
//                               context
//                                   .read<MaterialMovementDetailsCubit>()
//                                   .onModelValueChange(state.model);
//                             },
//                             validateTextField: (_) {},
//                             hintText: '',
//                           ),
//
//                           CommonWidgets.verticalSpacerWidget(height * 0.03),
//                           // ],
//
//                           buttonViews(widget.mainContext, width),
//
//                           CommonWidgets.verticalSpacerWidget(height * 0.04),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }
//     );
//   }
//
//   quantityUnitDialog({
//     required BuildContext context,
//     required List<Organisation> quantityUnits,
//   }) {
//     showDialog(
//         context: context,
//         builder: (BuildContext dialogContext) {
//           return CustomListTexts(
//             duplicateQuantityUnitList: quantityUnits,
//             // leftImageName: AppIcon.addicon,
//             onLeftButtonTap: () {
//               Navigator.pop(context);
//               showDialog(
//                   barrierDismissible: false,
//                   context: context,
//                   builder: (BuildContext dialogContext) {
//                     return BaseAddOrganisationDialog(
//                       title: Constants.addQuantity,
//                       orgName: 'ATOM_MATERIAL_MOVEMENT_UNIT',
//                       functionToCall: () {
//                         // refresh the list
//                         BlocProvider.of<MaterialMovementDetailsCubit>(context)
//                             .refreshList();
//                       },
//                     );
//                   });
//             },
//             onTap: (Organisation unit) {
//               BlocProvider.of<MaterialMovementDetailsCubit>(context)
//                   .updateDropdownValues(quantityUnit: unit);
//             },
//           );
//         });
//   }
//   Widget buttonViews(BuildContext context, double width) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         cancelButton(width),
//         saveButton(width),
//       ],
//     );
//   }
//
//   Widget cancelButton(double width) {
//     return AppButton(
//       width: width / 3.5,
//       key: const Key(Keys.cancelButton),
//       buttonText: Constants.cancel,
//       buttonTextKey: Keys.cancelButtonText,
//       onTap: () {
//         FocusScope.of(context).unfocus();
//         Navigator.of(context).pop();
//       },
//     );
//   }
//
//   // Widget saveButton(double width) {
//   //   return AppButton(
//   //     width: width / 3.5,
//   //     key: const Key(Keys.saveButton),
//   //     buttonText: Constants.save,
//   //     buttonTextKey: Keys.saveButtonText,
//   //     backgroundColor: AppColors.navigationSkyBlueColor,
//   //     onTap: () {
//   //       widget.onSubmit?.call('');
//   //     },
//   //   );
//   // }
//   Widget saveButton(double width) {
//     return AppButton(
//       width: width / 3.5,
//       key: const Key(Keys.saveButton),
//       buttonText: Constants.save,
//       buttonTextKey: Keys.saveButtonText,
//       backgroundColor: AppColors.navigationSkyBlueColor,
//       onTap: () {
//         // 1️⃣ Save via Cubit
//         // context.read<MaterialMovementDetailsCubit>().saveMaterial();
//
//         // 2️⃣ Close popup
//         Navigator.of(context).pop();
//       },
//     );
//   }
//
// }
