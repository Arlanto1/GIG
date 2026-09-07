// import 'dart:ui';
//
// import 'package:db_atom/index.dart';
//
// import '../../models/ticketing_system_model.dart';
// import '../cubits/ticketing_system_details_cubit.dart';
//
// class TicketingSystemDetailsView extends StatefulWidget {
//   final TicketingSystemModel? model;
//   final String title;
//
//   const TicketingSystemDetailsView({
//     super.key,
//     this.model,
//     required this.title,
//   });
//
//   @override
//   State<TicketingSystemDetailsView> createState() =>
//       _TicketingSystemDetailsView();
// }
//
// class _TicketingSystemDetailsView extends State<TicketingSystemDetailsView> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController statusController = TextEditingController();
//   TextEditingController trackerController = TextEditingController();
//   TextEditingController priorityTypController = TextEditingController();
//   TextEditingController ticketRaisedForController = TextEditingController();
//   TextEditingController ragStatusController = TextEditingController();
//   TextEditingController toDateController = TextEditingController();
//   User? userDetails;
//   bool isReadOnly = false;
//   bool showSaveSubmitButton = false;
//   List<ImageContent> uploadFiles = [];
//   List<ImageContent> getAttachments = [];
//
//   TextEditingController toDateTextController = TextEditingController();
//   TextEditingController startDateTextController = TextEditingController();
//   TextEditingController activityDateController = TextEditingController();
//
//   TextEditingController additionalInformationTextController =
//       TextEditingController();
//
//   get model => null;
//
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<TicketingSystemDetailsCubit>(context).initializeValues();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     double height = size.height;
//     return BlocConsumer<TicketingSystemDetailsCubit,
//         TicketingSystemDetailsState>(
//       listener: (context, state) {
//         Utils().formError(state, context);
//         Utils().errorAndLogout(state, context);
//         if (state.status == FormStatus.success) {
//           var dialog = CustomAlertDialog(
//             title: Constants.ticketingSystem,
//             message: state.message ?? '',
//             positiveBtnText: Constants.ok,
//             onPositivePressed: () {
//               // TODO: Need to improve this code
//               Navigator.pop(context);
//               Navigator.pop(context);
//               Navigator.popAndPushNamed(
//                 context,
//                 ticketingSystemListRoute,
//               );
//             },
//           );
//           showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) => dialog);
//         }
//       },
//       builder: (context, state) {
//         if (state.model.status == null) {
//           isReadOnly = false;
//         }
//
//         if (state.model.status == 2) {
//           isReadOnly = true;
//         }
//         showSaveSubmitButton = state.model.status != 5 &&
//             state.model.status != 2 &&
//             state.model.status != 9 &&
//             state.model.lock.isEmptyOrNull;
//         return Scaffold(
//           appBar: BaseAppBar().buildAppHeader(
//             context: context,
//             title: Constants.ticketingSystem,
//             showPopUp: false,
//             showSaveButton: false,
//             showSubmitButton:
//                 showSaveSubmitButton && state.status != FormStatus.loading
//                     ? true
//                     : false,
//             showDisLikeButton: false,
//             showLikeButton: false,
//             // pdfAPIName:
//             // '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.vipVisitorsDetailsModule}',
//             onTapSave: () {
//               // FocusScope.of(context).unfocus();
//               // BlocProvider.of<TicketingSystemDetailsCubit>(context)
//               //     .submitForm();
//             },
//             onTapSubmit: () {
//               FocusScope.of(context).unfocus();
//               BlocProvider.of<TicketingSystemDetailsCubit>(context).submitForm(
//                 isSaveOnly: false,
//               );
//             },
//           ),
//           backgroundColor: AppColors.newColor,
//           body: getBodybuilder(state, height),
//         );
//       },
//     ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
//   }
//
//   void initializeDates(TicketingSystemDetailsState state) {
//     startDateTextController.text = state.model.startDate != null
//         ? Utils.timestampToDateConversion(
//         int.tryParse(state.model.startDate ?? '0'),
//         Constants.fulldateFormat)
//         : Utils().getCurrentDate();
//
//     // toDateController.text = state.model.dueDate != null
//     //     ? Utils.timestampToDateConversion(
//     //     int.tryParse(state.model.dueDate ?? '') ??
//     //         DateTime.now()
//     //             .millisecondsSinceEpoch, // Use current timestamp if null
//     //     Constants.fulldateFormat)
//     //     : '';
//   }
//
//   getBodybuilder(TicketingSystemDetailsState state, height) {
//     initializeDates(state);
//     if (state.status == FormStatus.loading) {
//       return const BaseLoader();
//     }
//
//     if (state.status == FormStatus.addAttachment ||
//         state.status == FormStatus.initial) {
//       // uploadFiles = state.uploadAttachments;
//       uploadFiles = state.model.attachments ?? [];
//     }
//
//     List<Label> getDropDownValuesForStatus(int? status) {
//       switch (status) {
//         case 11:
//           return ticketOpenStatusDropDownValues;
//         case 3:
//           return ticketDevCompleteStatusDropDownValues;
//         case 4:
//           return ticketTestingStatusDropDownValues;
//         default:
//           return ticketOpenStatusDropDownValues;
//       }
//     }
//
//     return Stack(
//       children: [
//         //  Background Image
//         Positioned.fill(
//           child: Image.asset(
//             'assets/images/bg2.png',
//             fit: BoxFit.cover,
//           ),
//         ),
//
//         //  Blur Layer
//         Positioned.fill(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
//             child: Container(
//               color: Colors.black.withValues(alpha: 0.08), // optional tint
//             ),
//           ),
//         ),
//
//         SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 color: Colors.transparent,
//                 child: AbsorbPointer(
//                   absorbing: false,
//                   child: Form(
//                     key: _formKey,
//                     autovalidateMode: isReadOnly
//                         ? AutovalidateMode.disabled
//                         : AutovalidateMode.onUserInteraction,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20.0, right: 20),
//                           child: Column(
//                             children: [
//                               if (!state.model.lock.isEmptyOrNull) ...[
//                                 RecordLockedWidget(text: '${state.model.lock}'),
//                               ],
//                               CommonWidgets.verticalSpacerWidget(height * 0.02),
//                               Container(
//                                 alignment: Alignment.topLeft,
//                                 child: const Text(
//                                   Constants.generalinformation,
//                                   style: Styles.textStyleRegularNormalWhite18,
//                                 ),
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                               if (widget.model != null) ...[
//                                 /// Status
//                                 CommonWidgets.textDisplay(
//                                   // state.labels?.locale.status ??
//                                   //     state.labels?.defaultLocale.status ??
//                                   Constants.status,
//                                   isMandatory: true,
//                                   Styles.textStyleWhite14,
//                                 ),
//
//                                 CommonWidgets.verticalSpacerWidget(
//                                   height * 0.01,
//                                 ),
//
//                                 BaseDropDown().getDropDown(
//                                   isDisabled: false,
//                                   textController: statusController,
//                                   items: getDropDownValuesForStatus(
//                                       state.model.status),
//                                   initialValue: '${state.model.status ??= 1}',
//                                   onTap: () {
//                                     if (showSaveSubmitButton) {
//                                       final currentValues =
//                                           getDropDownValuesForStatus(
//                                               state.model.status);
//
//                                       BaseDropDown().assetTypeDialog(
//                                         context: context,
//                                         dropDownValues: currentValues
//                                             .map((label) => label.key)
//                                             .toList(),
//                                         onTap: (String value) {
//                                           Label selectedLabel =
//                                               currentValues.firstWhere(
//                                             (label) => label.key == value,
//                                             orElse: () =>
//                                                 const Label(key: '', value: ''),
//                                           );
//
//                                           BlocProvider.of<
//                                                       TicketingSystemDetailsCubit>(
//                                                   context)
//                                               .updateDropdownValues(
//                                             status: int.tryParse(
//                                                 selectedLabel.value),
//                                           );
//                                         },
//                                       );
//                                     }
//                                   },
//                                 ),
//
//                                 CommonWidgets.verticalSpacerWidget(
//                                     height * 0.02),
//                               ],
//
//                               /// Project
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.status ??
//                                 //     state.labels?.defaultLocale.status ??
//                                 Constants.project,
//                                 isMandatory: true,
//                                 Styles.textStyleWhite14,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                 height * 0.01,
//                               ),
//                               TextFieldAddButton(
//                                 title: state.model.project?.name,
//                                 height: 75,
//                                 isDisableColor: !showSaveSubmitButton,
//                                 onTap: () {
//                                   if (showSaveSubmitButton) {
//                                     BaseOrganisationDialog().departmentDialog(
//                                       context: context,
//                                       organisations: state.projects,
//                                       onTap: (Organisation projects) {
//                                         BlocProvider.of<
//                                                     TicketingSystemDetailsCubit>(
//                                                 context)
//                                             .updateDropdownValues(
//                                                 projects: projects);
//                                       },
//                                       leftImage: false,
//                                       functionToCall: () {
//                                         // refresh the list
//                                         BlocProvider.of<
//                                                     TicketingSystemDetailsCubit>(
//                                                 context)
//                                             .refreshList();
//                                       },
//                                     );
//                                   }
//                                 },
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                               /// Priority
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.status ??
//                                 //     state.labels?.defaultLocale.status ??
//                                 Constants.priorityType,
//                                 isMandatory: true,
//                                 Styles.textStyleWhite14,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                 height * 0.01,
//                               ),
//                               TextFieldAddButton(
//                                 title: state.model.priority?.name,
//                                 height: 75,
//                                 isDisableColor: !showSaveSubmitButton,
//                                 onTap: () {
//                                   if (showSaveSubmitButton) {
//                                     BaseOrganisationDialog().departmentDialog(
//                                       context: context,
//                                       organisations: state.priorities,
//                                       onTap: (Organisation priority) {
//                                         BlocProvider.of<
//                                                     TicketingSystemDetailsCubit>(
//                                                 context)
//                                             .updateDropdownValues(
//                                                 priority: priority);
//                                       },
//                                       leftImage: false,
//                                       functionToCall: () {
//                                         // refresh the list
//                                         BlocProvider.of<
//                                                     TicketingSystemDetailsCubit>(
//                                                 context)
//                                             .refreshList();
//                                       },
//                                     );
//                                   }
//                                 },
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                               /// Title
//                               CommonWidgets.textDisplay(
//                                   // state.labels?.locale.detailDes ??
//                                   //     state.labels?.defaultLocale.detailDes ??
//                                   Constants.title,
//                                   isMandatory: true,
//                                   Styles.textStyleWhite16),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.001),
//                               FlutterInputField(
//                                 // lineHeight: 6,
//                                 characterLimit:
//                                     Constants.characterLimitDescTextFormField,
//                                 initialValue: state.model.title,
//                                 showBorder: true,
//                                 textFormKey: Keys.incidentDescription,
//                                 hintText: '',
//                                 isEnable: showSaveSubmitButton,
//                                 isDisableColor: !showSaveSubmitButton,
//                                 onChange: (String value) {
//                                   state.model.title = value;
//                                   context
//                                       .read<TicketingSystemDetailsCubit>()
//                                       .onModelValueChange(state.model);
//                                 },
//                                 validateTextField: (String? user) {},
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                               // /// Ticket No.
//                               // CommonWidgets.horizontalTextHandling(
//                               //   // state.labels?.locale.slNo ??
//                               //   //     state.labels?.defaultLocale.slNo ??
//                               //   'Ticket No',
//                               //   isMandatory: true,
//                               //   state.model.ticketNo ?? '',
//                               // ),
//                               // CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                               /// Start date
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.startTime ??
//                                 //     state.labels?.defaultLocale.startTime ??
//                                 Constants.startDate,
//                                 isMandatory: true,
//                                 Styles.textStyleWhite16,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.001),
//                               BaseDate().datePickerWidgetLoading(
//                                 textController: startDateTextController,
//                                 isDisabled: isReadOnly,
//                                 onlyDate: false,
//                                 showPastDate: false,
//                                 showFutureDate: true,
//                                 onChange: (String value) {
//                                   startDateTextController.text = value;
//                                   state.model.startDate =
//                                       Utils().formatTime(value);
//                                   BlocProvider.of<TicketingSystemDetailsCubit>(
//                                           context)
//                                       .onModelValueChange(state.model);
//                                 },
//                                 context: context,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                               /// Due Date
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.inputDate ??
//                                 //     state.labels?.defaultLocale.inputDate ??
//                                 Constants.duedate,
//                                 isMandatory: true,
//                                 Styles.textStyleWhite14,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                 height * 0.01,
//                               ),
//                               // BaseDate().creationDateDisplay(
//                               //   state.model.dueDate ?? '',
//                               // ),
//                               KeyedSubtree(
//                                 key: ValueKey(state.model.dueDate),
//                                 child: BaseDate().creationDateDisplay(
//                                   state.model.dueDate ?? '',
//                                 ),
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                               /// Tracker
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.status ??
//                                 //     state.labels?.defaultLocale.status ??
//                                 Constants.tracker,
//                                 isMandatory: true,
//                                 Styles.textStyleWhite14,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                 height * 0.01,
//                               ),
//                               TextFieldAddButton(
//                                 title: state.model.tracker?.name,
//                                 height: 75,
//                                 isDisableColor: !showSaveSubmitButton,
//                                 onTap: () {
//                                   if (showSaveSubmitButton) {
//                                     BaseOrganisationDialog().departmentDialog(
//                                       context: context,
//                                       organisations: state.trackers,
//                                       onTap: (Organisation trackers) {
//                                         BlocProvider.of<
//                                                     TicketingSystemDetailsCubit>(
//                                                 context)
//                                             .updateDropdownValues(
//                                                 trackers: trackers);
//                                       },
//                                       leftImage: false,
//                                       functionToCall: () {
//                                         // refresh the list
//                                         BlocProvider.of<
//                                                     TicketingSystemDetailsCubit>(
//                                                 context)
//                                             .refreshList();
//                                       },
//                                     );
//                                   }
//                                 },
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                               /// Assignee
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.status ??
//                                 //     state.labels?.defaultLocale.status ??
//                                 Constants.assignee,
//                                 isMandatory: true,
//                                 Styles.textStyleWhite14,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.02),
//                               TextFieldAddButton(
//                                 title: state.model.id != null
//                                     ? '${state.model.assignee?.name}'
//                                     : 'Atom Support',
//                                 height: 75,
//                                 isDisableColor: showSaveSubmitButton &&
//                                         state.model.id != null
//                                     ? false
//                                     : true,
//                                 onTap: () {
//                                   if (state.model.id != null &&
//                                       showSaveSubmitButton) {
//                                     BaseOrganisationDialog().userDialog(
//                                       employeeId: false,
//                                       context: context,
//                                       users: state.assignee,
//                                       isDbUser: true,
//                                       onTap: (BaseUser user) {
//                                         BlocProvider.of<
//                                                     TicketingSystemDetailsCubit>(
//                                                 context)
//                                             .updateDropdownValues(
//                                           assignee: user,
//                                         );
//                                       },
//                                       roleName:
//                                           ConstantUserRoles.atomStaticUser,
//                                       locationId: 0,
//                                       functionToCall: (BaseUser user) {
//                                         BlocProvider.of<
//                                                     TicketingSystemDetailsCubit>(
//                                                 context)
//                                             .updateDropdownValues(
//                                           assignee: user,
//                                         );
//                                         // refresh the list
//                                         BlocProvider.of<
//                                                     TicketingSystemDetailsCubit>(
//                                                 context)
//                                             .refreshList();
//                                       },
//                                     );
//                                   }
//                                 },
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                               /// Description
//                               CommonWidgets.textDisplay(
//                                   // state.labels?.locale.detailDes ??
//                                   //     state.labels?.defaultLocale.detailDes ??
//                                   Constants.description,
//                                   isMandatory: true,
//                                   Styles.textStyleWhite16),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.001),
//                               FlutterInputField(
//                                 lineHeight: 6,
//                                 characterLimit:
//                                     Constants.characterLimitDescTextFormField,
//                                 initialValue: state.model.description,
//                                 showBorder: true,
//                                 textFormKey: Keys.incidentDescription,
//                                 hintText: Constants.informationhere,
//                                 isEnable: showSaveSubmitButton,
//                                 isDisableColor: !showSaveSubmitButton,
//                                 onChange: (String value) {
//                                   state.model.description = value;
//                                   context
//                                       .read<TicketingSystemDetailsCubit>()
//                                       .onModelValueChange(state.model);
//                                 },
//                                 validateTextField: (String? user) {},
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                               if (state.model.id != null) ...[
//                                 /// History
//                                 CommonWidgets.textDisplay(
//                                     // state.labels?.locale.detailDes ??
//                                     //     state.labels?.defaultLocale.detailDes ??
//                                     Constants.history,
//                                     isMandatory: true,
//                                     Styles.textStyleWhite16),
//                                 CommonWidgets.verticalSpacerWidget(
//                                     height * 0.001),
//                                 FlutterInputField(
//                                   lineHeight: 6,
//                                   characterLimit:
//                                       Constants.characterLimitDescTextFormField,
//                                   initialValue: state.model.history,
//                                   showBorder: true,
//                                   textFormKey: Keys.incidentDescription,
//                                   hintText: Constants.informationhere,
//                                   isEnable: false,
//                                   isDisableColor: true,
//                                   onChange: (String value) {
//                                     state.model.history = value;
//                                     context
//                                         .read<TicketingSystemDetailsCubit>()
//                                         .onModelValueChange(state.model);
//                                   },
//                                   validateTextField: (String? user) {},
//                                 ),
//                                 CommonWidgets.verticalSpacerWidget(
//                                     height * 0.02),
//                               ],
//
//                               if (state.model.id != 2 &&
//                                   state.model.id != null) ...[
//                                 /// Notes
//                                 CommonWidgets.textDisplay(
//                                     // state.labels?.locale.detailDes ??
//                                     //     state.labels?.defaultLocale.detailDes ??
//                                     Constants.notes,
//                                     isMandatory: true,
//                                     Styles.textStyleWhite16),
//                                 CommonWidgets.verticalSpacerWidget(
//                                     height * 0.001),
//                                 FlutterInputField(
//                                   lineHeight: 6,
//                                   characterLimit:
//                                       Constants.characterLimitDescTextFormField,
//                                   initialValue: state.model.notes,
//                                   showBorder: true,
//                                   textFormKey: Keys.incidentDescription,
//                                   hintText: Constants.informationhere,
//                                   isEnable: showSaveSubmitButton,
//                                   isDisableColor: !showSaveSubmitButton,
//                                   onChange: (String value) {
//                                     state.model.notes = value;
//                                     context
//                                         .read<TicketingSystemDetailsCubit>()
//                                         .onModelValueChange(state.model);
//                                   },
//                                   validateTextField: (String? user) {},
//                                 ),
//                                 CommonWidgets.verticalSpacerWidget(
//                                     height * 0.02),
//                               ],
//                               if (state.model.id != null) ...[
//                                 /// Modified By
//                                 // CommonWidgets.horizontalTextHandling(
//                                 //   // state.labels?.locale.entrySecurity ??
//                                 //   //     state.labels?.defaultLocale.entrySecurity ??
//                                 //   Constants.modifiedBy,
//                                 //   isMandatory: true,
//                                 //   '${state.model.modifiedBy}',
//                                 // ),
//                                 // CommonWidgets.verticalSpacerWidget(
//                                 //     height * 0.02),
//
//                                 /// Modified Date
//                                 CommonWidgets.textDisplay(
//                                   // state.labels?.locale.modifiedDate ??
//                                   //     state.labels?.defaultLocale.modifiedDate ??
//                                   Constants.modifiedDate,
//                                   isMandatory: true,
//                                   Styles.textStyleWhite14,
//                                 ),
//                                 CommonWidgets.verticalSpacerWidget(
//                                   height * 0.01,
//                                 ),
//                                 BaseDate().creationDateDisplay(
//                                   state.model.updatedOn ?? '',
//                                 ),
//                                 CommonWidgets.verticalSpacerWidget(
//                                     height * 0.02),
//                               ],
//
//                               /// Attachment
//                               CommonWidgets.textDisplay(Constants.attachments,
//                                   Styles.textStyleWhite16),
//                               BaseImageUpload().uploadWidget(
//                                 context: context,
//                                 isDisabled: !showSaveSubmitButton,
//                                 loggedInUserDetails:
//                                     state.loggedInUserDetails ?? User(),
//                                 getFiles: uploadFiles,
//                                 onImageSelected: (ImageContent data) {
//                                   List<ImageContent>? files = [];
//                                   files.add(data);
//                                   for (ImageContent image in uploadFiles) {
//                                     files.add(image);
//                                   }
//                                   BlocProvider.of<TicketingSystemDetailsCubit>(
//                                           context)
//                                       .addAttachment(
//                                     data: files,
//                                     images: files,
//                                   );
//                                 },
//                               ),
//
//                               /// Attachments
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 20.0),
//                                 child: BaseImageUpload().getAttachment(
//                                   height: height,
//                                   attachments: state.model.attachments,
//                                   files: uploadFiles,
//                                   moduleCode: '',
//                                   // isDisabled: disableForm,
//                                 ),
//                               ),
//
//                               CommonWidgets.verticalSpacerWidget(height * 0.01),
//                             ],
//                           ),
//                         ),
//                         CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                         /// SubmitButton
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             if (showSaveSubmitButton ? true : false) ...[
//                               cancelButtonDisplay(),
//                               submitButtonDisplay()
//                             ],
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               if ((!showSaveSubmitButton)) ...[
//                 Container(
//                   padding: const EdgeInsets.all(5.0),
//                   color: Colors.transparent,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       cancelButtonDisplay(),
//                     ],
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget cancelButtonDisplay() {
//     return AppButton(
//       width: Constants.cancelButtonWidth,
//       backgroundColor: Colors.white,
//       key: const Key(Keys.cancelButton),
//       buttonText: Constants.close,
//       buttonTextKey: Keys.cancelButton,
//       onTap: () {
//         Navigator.pop(context);
//         CommonServices().unlock();
//       },
//     );
//   }
//
//   Widget submitButtonDisplay() {
//     return AppButton(
//       width: 150,
//       key: const Key(Keys.submitButton),
//       buttonText: Constants.save,
//       buttonTextKey: Keys.submitButton,
//       onTap: () async {
//         FocusScope.of(context).unfocus();
//         BlocProvider.of<TicketingSystemDetailsCubit>(context).submitForm();
//       },
//     );
//   }
// }

import 'dart:ui';

import 'package:db_atom/index.dart';

import '../../models/ticketing_system_model.dart';
import '../cubits/ticketing_system_details_cubit.dart';

class TicketingSystemDetailsView extends StatefulWidget {
  final TicketingSystemModel? model;
  final String title;

  const TicketingSystemDetailsView({
    super.key,
    this.model,
    required this.title,
  });

  @override
  State<TicketingSystemDetailsView> createState() =>
      _TicketingSystemDetailsView();
}

class _TicketingSystemDetailsView extends State<TicketingSystemDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController statusController = TextEditingController();
  TextEditingController trackerController = TextEditingController();
  TextEditingController priorityTypController = TextEditingController();
  TextEditingController ticketRaisedForController = TextEditingController();
  TextEditingController ragStatusController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  User? userDetails;
  bool isReadOnly = false;
  bool showSaveSubmitButton = false;
  List<ImageContent> uploadFiles = [];
  List<ImageContent> getAttachments = [];

  TextEditingController toDateTextController = TextEditingController();
  TextEditingController startDateTextController = TextEditingController();
  TextEditingController activityDateController = TextEditingController();

  TextEditingController additionalInformationTextController =
  TextEditingController();

  // NOTE: This holds the status the ticket had when the screen was first
  // loaded from the server. `state.model.status` changes live as soon as the
  // user picks a new value in the status dropdown (see updateDropdownValues
  // in the cubit), so it must NEVER be used to decide isReadOnly /
  // showSaveSubmitButton. Doing so was the cause of the bug where selecting
  // "Done" (or any status whose numeric code collides with 2/5/9) instantly
  // hid the Save/Submit buttons and made every field read-only, even though
  // nothing had actually been submitted yet.
  int? originalStatus;
  bool _originalStatusCaptured = false;

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TicketingSystemDetailsCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<TicketingSystemDetailsCubit,
        TicketingSystemDetailsState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.ticketingSystem,
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                ticketingSystemListRoute,
              );
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
      },
      builder: (context, state) {
        // Capture the server-loaded status exactly once, the first time we
        // see a real value. Everything below that governs read-only /
        // save-submit visibility must key off THIS, not the live
        // state.model.status (which the dropdown mutates immediately on tap,
        // before anything is actually saved).
        if (!_originalStatusCaptured) {
          originalStatus = state.model.status;
          _originalStatusCaptured = true;
        }

        if (originalStatus == null) {
          isReadOnly = false;
        }

        if (originalStatus == 2) {
          isReadOnly = true;
        }
        showSaveSubmitButton = originalStatus != 5 &&
            originalStatus != 2 &&
            originalStatus != 9 &&
            state.model.lock.isEmptyOrNull;

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.ticketingSystem,
            showPopUp: false,
            showSaveButton: false,
            showSubmitButton:
            showSaveSubmitButton && state.status != FormStatus.loading
                ? true
                : false,
            showDisLikeButton: false,
            showLikeButton: false,
            // pdfAPIName:
            // '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.vipVisitorsDetailsModule}',
            onTapSave: () {
              // FocusScope.of(context).unfocus();
              // BlocProvider.of<TicketingSystemDetailsCubit>(context)
              //     .submitForm();
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<TicketingSystemDetailsCubit>(context).submitForm(
                isSaveOnly: false,
              );
            },
          ),
          backgroundColor: AppColors.newColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(TicketingSystemDetailsState state) {
    startDateTextController.text = state.model.startDate != null
        ? Utils.timestampToDateConversion(
        int.tryParse(state.model.startDate ?? '0'),
        Constants.fulldateFormat)
        : Utils().getCurrentDate();

    // toDateController.text = state.model.dueDate != null
    //     ? Utils.timestampToDateConversion(
    //     int.tryParse(state.model.dueDate ?? '') ??
    //         DateTime.now()
    //             .millisecondsSinceEpoch, // Use current timestamp if null
    //     Constants.fulldateFormat)
    //     : '';
  }

  getBodybuilder(TicketingSystemDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      // uploadFiles = state.uploadAttachments;
      uploadFiles = state.model.attachments ?? [];
    }

    List<Label> getDropDownValuesForStatus(int? status) {
      switch (status) {
        case 11:
          return ticketOpenStatusDropDownValues;
        case 3:
          return ticketDevCompleteStatusDropDownValues;
        case 4:
          return ticketTestingStatusDropDownValues;
        case 5:
          return ticketTestingStatusDropDownValues;
        default:
          return ticketOpenStatusDropDownValues;
      }
    }

    return Stack(
      children: [
        //  Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg2.png',
            fit: BoxFit.cover,
          ),
        ),

        //  Blur Layer
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child: Container(
              color: Colors.black.withValues(alpha: 0.08), // optional tint
            ),
          ),
        ),

        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
                child: AbsorbPointer(
                  absorbing: false,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: isReadOnly
                        ? AutovalidateMode.disabled
                        : AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(
                            children: [
                              if (!state.model.lock.isEmptyOrNull) ...[
                                RecordLockedWidget(text: '${state.model.lock}'),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  Constants.generalinformation,
                                  style: Styles.textStyleRegularNormalWhite18,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (widget.model != null) ...[
                                /// Status
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.status ??
                                  //     state.labels?.defaultLocale.status ??
                                  Constants.status,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),

                                CommonWidgets.verticalSpacerWidget(
                                  height * 0.01,
                                ),

                                BaseDropDown().getDropDown(
                                  isDisabled: false,
                                  textController: statusController,
                                  items: getDropDownValuesForStatus(
                                    // Use originalStatus here too, so the
                                    // list of selectable next-statuses is
                                    // derived from where the ticket
                                    // actually started, not from whatever
                                    // was last tapped in this session.
                                      originalStatus),
                                  initialValue: '${state.model.status ??= 1}',
                                  onTap: () {
                                    if (showSaveSubmitButton) {
                                      final currentValues =
                                      getDropDownValuesForStatus(
                                          originalStatus);

                                      BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues: currentValues
                                            .map((label) => label.key)
                                            .toList(),
                                        onTap: (String value) {
                                          Label selectedLabel =
                                          currentValues.firstWhere(
                                                (label) => label.key == value,
                                            orElse: () =>
                                            const Label(key: '', value: ''),
                                          );

                                          BlocProvider.of<
                                              TicketingSystemDetailsCubit>(
                                              context)
                                              .updateDropdownValues(
                                            status: int.tryParse(
                                                selectedLabel.value),
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              /// Project
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                Constants.project,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              TextFieldAddButton(
                                title: state.model.project?.name,
                                height: 75,
                                isDisableColor: true,
                                onTap: () {
                                  // if (showSaveSubmitButton) {
                                  //   BaseOrganisationDialog().departmentDialog(
                                  //     context: context,
                                  //     organisations: state.projects,
                                  //     onTap: (Organisation projects) {
                                  //       BlocProvider.of<
                                  //           TicketingSystemDetailsCubit>(
                                  //           context)
                                  //           .updateDropdownValues(
                                  //           projects: projects);
                                  //     },
                                  //     leftImage: false,
                                  //     functionToCall: () {
                                  //       // refresh the list
                                  //       BlocProvider.of<
                                  //           TicketingSystemDetailsCubit>(
                                  //           context)
                                  //           .refreshList();
                                  //     },
                                  //   );
                                  // }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Priority
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                Constants.priorityType,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              TextFieldAddButton(
                                title: state.model.priority?.name,
                                height: 75,
                                isDisableColor: !showSaveSubmitButton,
                                onTap: () {
                                  if (showSaveSubmitButton) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.priorities,
                                      onTap: (Organisation priority) {
                                        BlocProvider.of<
                                            TicketingSystemDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                            priority: priority);
                                      },
                                      leftImage: false,
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                            TicketingSystemDetailsCubit>(
                                            context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Title
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.detailDes ??
                                //     state.labels?.defaultLocale.detailDes ??
                                  Constants.title,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                // lineHeight: 6,
                                characterLimit:
                                Constants.characterLimitDescTextFormField,
                                initialValue: state.model.title,
                                showBorder: true,
                                textFormKey: Keys.incidentDescription,
                                hintText: '',
                                isEnable: showSaveSubmitButton,
                                isDisableColor: !showSaveSubmitButton,
                                onChange: (String value) {
                                  state.model.title = value;
                                  context
                                      .read<TicketingSystemDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              // /// Ticket No.
                              // CommonWidgets.horizontalTextHandling(
                              //   // state.labels?.locale.slNo ??
                              //   //     state.labels?.defaultLocale.slNo ??
                              //   'Ticket No',
                              //   isMandatory: true,
                              //   state.model.ticketNo ?? '',
                              // ),
                              // CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Start date
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.startTime ??
                                //     state.labels?.defaultLocale.startTime ??
                                Constants.startDate,
                                isMandatory: true,
                                Styles.textStyleWhite16,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDate().datePickerWidgetLoading(
                                textController: startDateTextController,
                                isDisabled: isReadOnly,
                                onlyDate: false,
                                showPastDate: false,
                                showFutureDate: true,
                                onChange: (String value) {
                                  startDateTextController.text = value;
                                  state.model.startDate =
                                      Utils().formatTime(value);
                                  BlocProvider.of<TicketingSystemDetailsCubit>(
                                      context)
                                      .onModelValueChange(state.model);
                                },
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Due Date
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.inputDate ??
                                //     state.labels?.defaultLocale.inputDate ??
                                Constants.duedate,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              // BaseDate().creationDateDisplay(
                              //   state.model.dueDate ?? '',
                              // ),
                              KeyedSubtree(
                                key: ValueKey(state.model.dueDate),
                                child: BaseDate().creationDateDisplay(
                                  state.model.dueDate ?? '',
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Tracker
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                Constants.tracker,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              TextFieldAddButton(
                                title: state.model.tracker?.name,
                                height: 75,
                                isDisableColor: !showSaveSubmitButton,
                                onTap: () {
                                  if (showSaveSubmitButton) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.trackers,
                                      onTap: (Organisation trackers) {
                                        BlocProvider.of<
                                            TicketingSystemDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                            trackers: trackers);
                                      },
                                      leftImage: false,
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                            TicketingSystemDetailsCubit>(
                                            context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Assignee
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                Constants.assignee,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                              TextFieldAddButton(
                                title: state.model.id != null
                                    ? '${state.model.assignee?.name}'
                                    : 'Atom Support',
                                height: 75,
                                isDisableColor: showSaveSubmitButton &&
                                    state.model.id != null
                                    ? false
                                    : true,
                                onTap: () {
                                  if (state.model.id != null &&
                                      showSaveSubmitButton) {
                                    BaseOrganisationDialog().userDialog(
                                      employeeId: false,
                                      context: context,
                                      users: state.assignee,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                            TicketingSystemDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                          assignee: user,
                                        );
                                      },
                                      roleName:
                                      ConstantUserRoles.atomStaticUser,
                                      locationId: 0,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                            TicketingSystemDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                          assignee: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<
                                            TicketingSystemDetailsCubit>(
                                            context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Description
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.detailDes ??
                                //     state.labels?.defaultLocale.detailDes ??
                                  Constants.description,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                characterLimit:
                                Constants.characterLimitDescTextFormField,
                                initialValue: state.model.description,
                                showBorder: true,
                                textFormKey: Keys.incidentDescription,
                                hintText: Constants.informationhere,
                                isEnable: showSaveSubmitButton,
                                isDisableColor: !showSaveSubmitButton,
                                onChange: (String value) {
                                  state.model.description = value;
                                  context
                                      .read<TicketingSystemDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (state.model.id != null) ...[
                                /// History
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.detailDes ??
                                  //     state.labels?.defaultLocale.detailDes ??
                                    Constants.history,
                                    isMandatory: true,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  lineHeight: 6,
                                  characterLimit:
                                  Constants.characterLimitDescTextFormField,
                                  initialValue: state.model.history,
                                  showBorder: true,
                                  textFormKey: Keys.incidentDescription,
                                  hintText: Constants.informationhere,
                                  isEnable: false,
                                  isDisableColor: true,
                                  onChange: (String value) {
                                    state.model.history = value;
                                    context
                                        .read<TicketingSystemDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              if (state.model.id != 2 &&
                                  state.model.id != null) ...[
                                /// Notes
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.detailDes ??
                                  //     state.labels?.defaultLocale.detailDes ??
                                    Constants.notes,
                                    isMandatory: true,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  lineHeight: 6,
                                  characterLimit:
                                  Constants.characterLimitDescTextFormField,
                                  initialValue: state.model.notes,
                                  showBorder: true,
                                  textFormKey: Keys.incidentDescription,
                                  hintText: Constants.informationhere,
                                  isEnable: showSaveSubmitButton,
                                  isDisableColor: !showSaveSubmitButton,
                                  onChange: (String value) {
                                    state.model.notes = value;
                                    context
                                        .read<TicketingSystemDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],
                              if (state.model.id != null) ...[
                                /// Modified By
                                // CommonWidgets.horizontalTextHandling(
                                //   // state.labels?.locale.entrySecurity ??
                                //   //     state.labels?.defaultLocale.entrySecurity ??
                                //   Constants.modifiedBy,
                                //   isMandatory: true,
                                //   '${state.model.modifiedBy}',
                                // ),
                                // CommonWidgets.verticalSpacerWidget(
                                //     height * 0.02),

                                /// Modified Date
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.modifiedDate ??
                                  //     state.labels?.defaultLocale.modifiedDate ??
                                  Constants.modifiedDate,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                  height * 0.01,
                                ),
                                BaseDate().creationDateDisplay(
                                  state.model.updatedOn ?? '',
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              /// Attachment
                              CommonWidgets.textDisplay(Constants.attachments,
                                  Styles.textStyleWhite16),
                              BaseImageUpload().uploadWidget(
                                context: context,
                                isDisabled: !showSaveSubmitButton,
                                loggedInUserDetails:
                                state.loggedInUserDetails ?? User(),
                                getFiles: uploadFiles,
                                onImageSelected: (ImageContent data) {
                                  List<ImageContent>? files = [];
                                  files.add(data);
                                  for (ImageContent image in uploadFiles) {
                                    files.add(image);
                                  }
                                  BlocProvider.of<TicketingSystemDetailsCubit>(
                                      context)
                                      .addAttachment(
                                    data: files,
                                    images: files,
                                  );
                                },
                              ),

                              /// Attachments
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: BaseImageUpload().getAttachment(
                                  height: height,
                                  attachments: state.model.attachments,
                                  files: uploadFiles,
                                  moduleCode: '',
                                  // isDisabled: disableForm,
                                ),
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.02),

                        /// SubmitButton
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (showSaveSubmitButton ? true : false) ...[
                              cancelButtonDisplay(),
                              submitButtonDisplay()
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if ((!showSaveSubmitButton)) ...[
                Container(
                  padding: const EdgeInsets.all(5.0),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cancelButtonDisplay(),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      width: Constants.cancelButtonWidth,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.close,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
        CommonServices().unlock();
      },
    );
  }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.save,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<TicketingSystemDetailsCubit>(context).submitForm();
      },
    );
  }
}