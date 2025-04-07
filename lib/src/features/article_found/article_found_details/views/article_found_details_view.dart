// import 'dart:developer';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/article_found/article_found_details/cubits/article_found_details_cubit.dart';
// import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
//
//
// class ArticleFoundDetailsView extends StatefulWidget {
//   final ArticleFoundModel? model;
//   final String title;
//   final ExtraProperties? extraProperties;
//
//   const ArticleFoundDetailsView({
//     super.key,
//     this.model,
//     required this.title,
//     this.extraProperties,
//   });
//
//   @override
//   State<ArticleFoundDetailsView> createState() =>
//       _ArticleFoundDetailsViewState();
// }
//
// class _ArticleFoundDetailsViewState
//     extends State<ArticleFoundDetailsView> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController returnableTextController = TextEditingController();
//
//   User? userDetails;
//   List<ImageContent> getFiles = [];
//   TextEditingController takenOutOnDateController = TextEditingController();
//   TextEditingController statusController = TextEditingController();
//   TextEditingController expectedDateOfReturnController =
//   TextEditingController();
//   TextEditingController passValidFromController = TextEditingController();
//   TextEditingController passValidUntilController= TextEditingController();
//   bool isReadOnly = false;
//   TextEditingController passTypeController =
//   TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController companyNameController =TextEditingController();
//   TextEditingController dbSponsorController = TextEditingController();
//   TextEditingController hostController = TextEditingController();
//   TextEditingController updateStatusTextController = TextEditingController();
//   TextEditingController employeeIdController = TextEditingController();
//   TextEditingController returnedTimeController = TextEditingController();
//
//   final FocusNode sentToFocusNode = FocusNode();
//
//   List<ImageContent> uploadFiles = [];
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<ArticleFoundDetailsCubit>(context).initializeValues();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   bool showSaveSubmitButtons = false;
//   bool lock = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     double height = size.height;
//     return BlocConsumer<ArticleFoundDetailsCubit,
//         ArticleFoundDetailsState>(
//       listener: (context, state) {
//         log('-state.status--${state.status}--');
//         log('123 ${state.message}--');
//         Utils().formError(state, context);
//         Utils().errorAndLogout(state, context);
//         if (state.status == FormStatus.success) {
//           var dialog = CustomAlertDialog(
//             title: Constants.dayPassManagementTitle,
//             message: state.message,
//             positiveBtnText: Constants.ok,
//             onPositivePressed: () {
//               // TODO: Need to improve this code
//               Navigator.pop(context);
//               Navigator.pop(context);
//               Navigator.popAndPushNamed(
//                   context, dayPassManagementListRoute, arguments: {
//               });
//             },
//           );
//           showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) => dialog);
//         }
//       },
//       builder: (context, state) {
//         // nameController.text = state.model.employee !=null ? '${state.model.employee?.firstName ?? ''} ${state.model.employee?.lastName ?? ''}': state.model.employeeName ??'';
//         // dbSponsorController.text = '${state.model.host?.firstName ?? ''} ${state.model.host?.lastName ?? ''}';
//         // hostController.text = state.model.host?.name ?? '';
//         // employeeIdController.text = state.model.employeeId??'';
//         // companyNameController.text= state.model.companyType?.name != 'FTE'? state.model.companyName ??'' : 'Deutsche Bank';
//         // if (state.model.status == 0 && !state.model.lock.isEmptyOrNull) {
//         //   isReadOnly = true;
//         // }
//         // if (state.model.status == 1 && !state.model.lock.isEmptyOrNull) {
//         //   isReadOnly = true;
//         // }
//         //
//         // if(state.model.status != null && state.model.status !=0){
//         //   isReadOnly = true;
//         // }
//
//         showSaveSubmitButtons = (widget.model == null ||
//             state.model.status == 0 ||state.model.status == 1) && state.model.lock.isEmptyOrNull;
//
//         return Scaffold(
//           appBar: BaseAppBar().buildAppHeader(
//             context: context,
//             title: widget.title,
//             showPopUp: false,
//             showSaveButton: (widget.model == null ||
//                 state.model.status == 0) && state.status != FormStatus.loading,
//             pdfAPIName:
//             '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.passManagementModuleCode}',
//             onTapSave: () {
//               FocusScope.of(context).unfocus();
//               BlocProvider.of<ArticleFoundDetailsCubit>(context).submitForm(
//                 isSaveOnly: true,
//               );
//             },
//             showSubmitButton: showSaveSubmitButtons && state.status != FormStatus.loading,
//             onTapSubmit: () {
//               FocusScope.of(context).unfocus();
//               BlocProvider.of<ArticleFoundDetailsCubit>(context).submitForm(
//                 isSaveOnly: false,
//               );
//             },
//             showLikeButton: false,
//             showDisLikeButton: false,
//           ),
//           backgroundColor: AppColors.backgroundWhiteColor,
//           body: getBodybuilder(state, height),
//         );
//       },
//     ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
//   }
//
//   void initializeDates(ArticleFoundDetailsState state) {
//
//     // passValidFromController.text = state.model.startTime == null
//     //     ? Utils.timestampToDateConversion(
//     //     DateTime.now().millisecondsSinceEpoch,
//     //     Constants.fulldateFormat) : Utils.timestampToDateConversion(
//     //     int.tryParse(state.model.startTime ?? '') ??
//     //         DateTime.now().millisecondsSinceEpoch,
//     //     Constants.fulldateFormat);
//     //
//     // passValidUntilController.text = state.model.endTime != null
//     //     ? Utils.timestampToDateConversion(
//     //     int.tryParse(state.model.endTime ?? '') ??
//     //         DateTime.now().millisecondsSinceEpoch, // Fallback to current timestamp
//     //     Constants.fulldateFormat) :Utils.timestampToDateConversion(
//     //     DateTime.now().add(const Duration(hours: 12)).millisecondsSinceEpoch, // One day ahead
//     //     Constants.fulldateFormat);
//     //
//     // if( (state.model.status == 2||state.model.status == 8 || state.model.status == 9)) {
//     //   returnedTimeController.text = state.model.returnedTime != null
//     //       ? Utils.timestampToDateConversion(
//     //       int.tryParse(state.model.returnedTime ?? '') ??
//     //           DateTime
//     //               .now()
//     //               .millisecondsSinceEpoch, // Fallback to current timestamp
//     //       Constants.fulldateFormat) : '';
//     // }
//     // state.model.startTime == passValidFromController.text;
//     // state.model.endTime == passValidUntilController.text;
//
//   }
//
//   getBodybuilder(ArticleFoundDetailsState state, height) {
//     initializeDates(state);
//     if (state.status == FormStatus.loading) {
//       return const BaseLoader();
//     }
//
//     // if (state.status == FormStatus.addAttachment ||
//     //     state.status == FormStatus.initial) {
//     //   uploadFiles = state.uploadAttachments;
//     //   uploadFiles = state.model.evidenceDocuments ?? [];
//     // }
//
//     return Container(
//       color: AppColors.navigationSkyBlueColor,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: height * 0.01,
//               color: AppColors.navigationSkyBlueColor,
//             ),
//             Container(
//               decoration: const ShapeDecoration(
//                   color: AppColors.backgroundWhiteColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius:
//                     BorderRadius.vertical(top: Radius.circular(20.0)),
//                   )),
//               child: Form(
//                 key: _formKey,
//                 autovalidateMode: isReadOnly
//                     ? AutovalidateMode.disabled
//                     : AutovalidateMode.onUserInteraction,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20.0, right: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       AbsorbPointer(
//                         absorbing: !showSaveSubmitButtons && IgnorePointer == false,
//                         child: Column(
//                           children: [
//                             // if (!state.model.lock.isEmptyOrNull) ...[
//                             //   RecordLockedWidget(text: '${state.model.lock}'),
//                             // ],
//                             Container(
//                               alignment: Alignment.topLeft,
//                               child: Text(
//                                 Constants.generalinformation,
//                                 style: Styles.styleHeaderGreyText16,
//                               ),
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             /// Status
//                             CommonWidgets.textDisplay(
//                               state.labels?.locale.status ??
//                                   state.labels?.defaultLocale.status ??
//                                   Constants.status,
//                               Styles.textStyleBlack14,
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//                             BaseDropDown().getDropDown(
//                               isDisabled: true,
//                               textController: statusController,
//                               items: passManagementStatusValues,
//                               initialValue: '${state.model.status ?? 0}',
//                               onTap: () {
//                               },
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             /// Created By
//                             CommonWidgets.horizentaltextHandling(
//                                 state.labels?.locale.entrySecurity ??
//                                     state.labels?.defaultLocale.entrySecurity ??
//                                     Constants.createdby,
//                                 isMandatory: true,
//                                 '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//
//                             /// Location
//                             CommonWidgets.textDisplay(
//                               state.labels?.locale.location ??
//                                   state.labels?.defaultLocale.location ??
//                                   Constants.location,
//                               Styles.textStyleBlack14,
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//                             BaseLocationDropdown().locationWidgetDisplay(
//                                 isEnabled: (!isReadOnly) &&
//                                     !lock,
//                                 context: context,
//                                 locations: state.locations ?? Locations(),
//                                 selectedLocationName:
//                                 state.model.location?.name ?? '',
//                                 onTap: (Organisation? location) {
//                                   BlocProvider.of<ArticleFoundDetailsCubit>(
//                                       context)
//                                       .updateLocationDropdownValue(
//                                       location: location);
//                                 }),
//
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             /// Date of creation
//                             CommonWidgets.textDisplay(
//                               state.labels?.locale.inputDate ??
//                                   state.labels?.defaultLocale.inputDate ??
//                                   Constants.dateofcreation,
//                               Styles.textStyleBlack14,
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//                             dateCreateWidgetDisplay(
//                                 state.model.inputDate ?? ''),
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             /// Sl No.
//                             CommonWidgets.horizentaltextHandling(
//                               state.labels?.locale.slNo ??
//                                   state.labels?.defaultLocale.slNo ??
//                                   Constants.slno,
//                               state.model.slNo ?? '',
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             // /// Pass Type
//                             // CommonWidgets.textDisplay(
//                             //     state.labels?.locale.passType ??
//                             //         state.labels?.defaultLocale
//                             //             .passType ??
//                             //         Constants.passtype,
//                             //     Styles.textStyleBlack14,
//                             //     isMandatory: true),
//                             // TextFieldAddButton(
//                             //   title: state.model.passTypeName,
//                             //   height: 70,
//                             //   isDisableColor:  isReadOnly,
//                             //   onTap: () {
//                             //     if(!isReadOnly) {
//                             //       BaseOrganisationDialog().departmentDialog(
//                             //         context: context,
//                             //         organisations: state.passType!,
//                             //         onTap: (Organisation passType) {
//                             //           state.model.passTypeName = passType.name;
//                             //           BlocProvider.of<
//                             //               ArticleFoundDetailsCubit>(
//                             //               context)
//                             //               .updateDropdownValues(
//                             //               passType: passType);
//                             //         },
//                             //         leftImage: false,
//                             //         functionToCall: () {
//                             //           // refresh the list
//                             //           BlocProvider.of<
//                             //               ArticleFoundDetailsCubit>(
//                             //               context)
//                             //               .refreshList();
//                             //         },
//                             //       );
//                             //     }
//                             //   },
//                             // ),
//                             // CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             /// Company Type
//                             CommonWidgets.textDisplay(
//                                 state.labels?.locale.companyType ??
//                                     state.labels?.defaultLocale
//                                         .companyType ??
//                                     Constants.companyType,
//                                 Styles.textStyleBlack14,
//                                 isMandatory: true),
//                             TextFieldAddButton(
//                               title: 'state.model.typeOfAsset',
//                               height: 70,
//                               isDisableColor: isReadOnly,
//                               onTap: () {
//                                 if(!isReadOnly) {
//                                   BaseOrganisationDialog().departmentDialog(
//                                     context: context,
//                                     organisations: state.getCompanyTypeResponse,
//                                     onTap: (Organisation companyType) {
//                                       BlocProvider.of<
//                                           ArticleFoundDetailsCubit>(
//                                           context)
//                                           .updateDropdownValues(
//                                           companyType: companyType);
//                                     },
//                                     leftImage: false,
//                                     functionToCall: () {
//                                       // refresh the list
//                                       BlocProvider.of<
//                                           ArticleFoundDetailsCubit>(
//                                           context)
//                                           .refreshList();
//                                     },
//                                   );
//                                 }
//                               },
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             /// Found Location
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.companyName ??
//                               //     state.labels?.defaultLocale.companyName ??
//                                   Constants.foundlocation,
//                               Styles.textStyleBlack14,
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//                             FlutterInputField(
//                               textInputType: TextInputType.text,
//                               textFormKey: Keys.challanKey,
//                               controller: companyNameController,
//                               characterLimit:
//                               Constants.characterLimitIdTextFormField,
//                               hintText: '',
//                               isEnable:  true,
//                               isDisableColor:false,
//                               onChange: (String value) {
//                                 state.model.foundLocation = value;
//                                 context
//                                     .read<ArticleFoundDetailsCubit>()
//                                     .onModelValueChange(state.model);
//                               },
//                               validateTextField: (String? user) {},
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//
//                               /// Employee Id
//                               CommonWidgets.textDisplay(
//                                   state.labels?.locale.employeeId ??
//                                       state.labels?.defaultLocale
//                                           .employeeId ??
//                                       Constants.employeeid,
//                                   Styles.textStyleBlack14,
//                                   isMandatory: true),
//                               TextFieldAddButton(
//                                 title: state.model.employee?.employeeId,
//                                 height: 60,
//                                 isDisableColor: isReadOnly,
//                                 onTap: () {
//                                   if (!isReadOnly) {
//                                     BaseOrganisationDialog().userDialog(
//                                       employeeId: true,
//                                       context: context,
//                                       users: state.employee!,
//                                       isDbUser: true,
//                                       onTap: (BaseUser user) {
//                                         BlocProvider.of<
//                                             ArticleFoundDetailsCubit>(
//                                             context)
//                                             .updateDropdownValues(
//                                           employee: user,
//                                         );
//                                       },
//                                       roleName:
//                                       ConstantUserRoles.atomStaticUser,
//                                       locationId: state.model.location!.id!,
//                                       functionToCall: (BaseUser user) {
//                                         BlocProvider.of<
//                                             ArticleFoundDetailsCubit>(
//                                             context)
//                                             .updateDropdownValues(
//                                           employee: user,
//                                         );
//                                         // refresh the list
//                                         BlocProvider.of<
//                                             ArticleFoundDetailsCubit>(
//                                             context)
//                                             .refreshList();
//                                       },
//                                     );
//                                   }
//                                 },
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.01),
//
//                             if(state.model.companyType?.name == 'CWR T2' )...[
//                               ///EmployeeId
//                               CommonWidgets.textDisplay(
//                                   state.labels?.locale.employeeId ??
//                                       state.labels?.defaultLocale
//                                           .employeeId ??
//                                       Constants.employeeid,
//                                   isMandatory: true,
//                                   Styles.textStyleBlack14),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.001),
//                               FlutterInputField(
//                                 textInputType: TextInputType.number,
//                                 textFormKey: Keys.contactNoKey,
//                                 controller: employeeIdController,
//                                 hintText: '',
//                                 isEnable: state.model.companyType?.name == 'CWR T2' && !isReadOnly? true : false,
//                                 isDisableColor: true,
//                                 onChange: (String value) {
//                                   state.model.employeeId = value;
//                                 },
//                                 validateTextField: (String? user) {},
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.01),
//                             ],
//
//                             ///Name
//                             CommonWidgets.textDisplay(
//                                 state.labels?.locale.employeeName ??
//                                     state.labels?.defaultLocale
//                                         .employeeName ??
//                                     Constants.name,
//                                 isMandatory: true,
//                                 Styles.textStyleBlack14),
//                             CommonWidgets.verticalSpacerWidget(
//                                 height * 0.001),
//                             FlutterInputField(
//                               controller: nameController,
//                               textInputType: TextInputType.text,
//                               textFormKey: Keys.contactNoKey,
//                               hintText: '',
//                               isEnable: (state.model.companyType?.name == 'Exceptions' || state.model.companyType?.name == 'CWR T2') && (state.model.status == null ||state.model.status == 0) ? true : false,
//                               isDisableColor: true,
//                               onChange: (String value) {
//                                 state.model.employeeName = value;
//                                 state.model.employee?.name = value;
//                               },
//                               validateTextField: (String? user) {},
//                             ),
//                             CommonWidgets.verticalSpacerWidget(
//                                 height * 0.01),
//
//                             if(state.model.companyType?.name == 'CWR T1' ||state.model.companyType?.name == 'CWR T2' )...[
//                               ///Db Sponsor Employee Id
//                               CommonWidgets.textDisplay(
//                                   state.labels?.locale.cwrSponsorEmployeeId ??
//                                       state.labels?.defaultLocale
//                                           .cwrSponsorEmployeeId ??
//                                       Constants.dbSponsorEmployeeId,
//                                   Styles.textStyleBlack14,
//                                   isMandatory: true),
//                               TextFieldAddButton(
//                                 title: state.model.host?.employeeId,
//                                 height: 60,
//                                 isDisableColor: isReadOnly,
//                                 onTap: () {
//                                   if (!isReadOnly) {
//                                     BaseOrganisationDialog().userDialog(
//                                       employeeId: true,
//                                       context: context,
//                                       users: state.host!,
//                                       isDbUser: true,
//                                       onTap: (BaseUser user) {
//                                         BlocProvider.of<
//                                             ArticleFoundDetailsCubit>(
//                                             context)
//                                             .updateDropdownValues(
//                                           host: user,
//                                         );
//                                       },
//                                       roleName:
//                                       ConstantUserRoles.atomStaticUser,
//                                       locationId: state.model.location!.id!,
//                                       functionToCall: (BaseUser user) {
//                                         BlocProvider.of<
//                                             ArticleFoundDetailsCubit>(
//                                             context)
//                                             .updateDropdownValues(
//                                           host: user,
//                                         );
//                                         // refresh the list
//                                         BlocProvider.of<
//                                             ArticleFoundDetailsCubit>(
//                                             context)
//                                             .refreshList();
//                                       },
//                                     );
//                                   }
//                                 },
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.01),
//                               ///DB Sponsor
//                               CommonWidgets.textDisplay(
//                                   state.labels?.locale.cwrSponsor ??
//                                       state.labels?.defaultLocale
//                                           .cwrSponsor ??
//                                       Constants.dbSponsor,
//                                   isMandatory: true,
//                                   Styles.textStyleBlack14),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.001),
//                               FlutterInputField(
//                                 controller: dbSponsorController,
//                                 textInputType: TextInputType.text,
//                                 textFormKey: Keys.contactNoKey,
//                                 hintText: '',
//                                 isEnable: false,
//                                 isDisableColor: true,
//                                 onChange: (String value) {},
//                                 validateTextField: (String? user) {},
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.01),
//                             ///  Department
//                             CommonWidgets.textDisplay(
//                               state.labels?.locale.department ??
//                                   state.labels?.defaultLocale
//                                       .department ??
//                                   Constants.department,
//                               Styles.textStyleBlack14,
//                               isMandatory: true,
//                             ),
//                             TextFieldAddButton(
//                               title: state.model.department?.name,
//                               height: 70,
//                               isDisableColor: isReadOnly,
//                               onTap: () {
//                                 if (!isReadOnly) {
//                                   BaseOrganisationDialog().departmentDialog(
//                                       context: context,
//                                       organisations: state.departments,
//                                       onTap: (Organisation department) {
//                                         state.model.department
//                                             ?.name = department.name;
//                                         BlocProvider.of<
//                                             ArticleFoundDetailsCubit>(
//                                             context)
//                                             .updateDropdownValues(
//                                             department:
//                                             department);
//                                       },
//                                       createEntity: false,
//                                       functionToCall: () {
//                                         // refresh the list
//                                         BlocProvider.of<
//                                             ArticleFoundDetailsCubit>(
//                                             context)
//                                             .refreshList();
//                                       });
//                                   FocusScope.of(context)
//                                       .requestFocus(sentToFocusNode);
//                                 }
//                               },
//                             ),
//
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
// ],
//
//                               CommonWidgets.textDisplay(
//                                   state.labels?.locale.exceptionalApproval ??
//                                       state.labels?.defaultLocale
//                                           .exceptionalApproval ??
//                                       Constants.exceptionalApproval,
//                                   isMandatory: true,
//                                   Styles.textStyleBlack14),
//                               RadioButtonsYesNo(
//                                   status: state.model.status ?? 0,
//                                   selectedValue:
//                                   state.model.exceptionalApproval ? 1 : 0,
//                                   onChangedYes: isReadOnly
//                                       ? null
//                                       : (val) {
//                                     state.model.exceptionalApproval= true;
//                                     BlocProvider.of<
//                                         DayPassManagementDetailsCubit>(
//                                         context)
//                                         .onCheckBoxChange(state.model);
//                                   },
//                                   onChangedNo: isReadOnly
//                                       ? null
//                                       : (val) {
//                                     state.model.exceptionalApproval = false;
//                                     BlocProvider.of<
//                                         ArticleFoundDetailsCubit>(
//                                         context)
//                                         .onCheckBoxChange(state.model);
//                                   }),
//                               CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             ///Attachments
//                             CommonWidgets.textDisplay(
//                                 state.labels?.locale.evidenceInfo ??
//                                     state.labels?.defaultLocale.evidenceInfo ??
//                                     Constants.evidenceDocuments,
//                                 Styles.textStyleBlack14),
//                             widget.model == null
//                                 ? CommonWidgets.verticalSpacerWidget(
//                                 height * 0.001)
//                                 : Container(),
//                             if (state.model.status == 0 ||
//                                 state.model.status == null) ...[
//                               BaseImageUpload().uploadWidget(
//                                 context: context,
//                                 isDisabled: isReadOnly,
//                                 loggedInUserDetails:
//                                 state.loggedInUserDetails!,
//                                 getFiles: uploadFiles,
//                                 onImageSelected: (ImageContent data) {
//                                   List<ImageContent>? files = [];
//                                   files.add(data);
//                                   for (ImageContent image
//                                   in uploadFiles) {
//                                     files.add(image);
//                                   }
//                                   BlocProvider.of<
//                                       ArticleFoundDetailsCubit>(
//                                       context)
//                                       .addAttachment(
//                                     data: files,
//                                     images: files,
//                                   );
//                                 },
//                               ),
//                             ],
//                             /// Attachments
//                             IgnorePointer(
//                               ignoring: false,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 20.0),
//                                 child: BaseImageUpload().getAttachment(
//                                   height: height,
//                                   attachments: state.uploadAttachments,
//                                   files: uploadFiles,
//                                   moduleCode: Constants.dayPassManagementModule,
//                                   isDisabled: false,
//                                   showDeleteIcon: state.model.status == null || state.model.status == 0 ,
//                                 ),
//                               ),
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             /// SubmitButton
//                             if (showSaveSubmitButtons) ...[
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   cancelButtonDisplay(),
//                                   if (showSaveSubmitButtons) ...[
//                                     submitButtonDisplay(state)
//                                   ],
//                                 ],
//                               ),
//                             ],
//                             CommonWidgets.verticalSpacerWidget(height * 0.04),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),),),
//             if (!showSaveSubmitButtons) ...[
//               Container(
//                 padding: const EdgeInsets.all(5.0),
//                 decoration: const ShapeDecoration(
//                   color: AppColors.backgroundWhiteColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius:
//                     BorderRadius.vertical(top: Radius.circular(00.0)),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     cancelButtonDisplay(),
//                   ],
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
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
//   Widget submitButtonDisplay(ArticleFoundDetailsState state) {
//     return AppButton(
//       width: 150,
//       key: const Key(Keys.submitButton),
//       buttonText: Constants.submit,
//       buttonTextKey: Keys.submitButton,
//       onTap: () async {
//         FocusScope.of(context).unfocus();
//         BlocProvider.of<ArticleFoundDetailsCubit>(context).submitForm(
//         );
//       },
//     );
//   }
//
//   Widget dateCreateWidgetDisplay(String date) {
//     return FlutterInputField(
//       textFormKey: Keys.dateofcreationTextController,
//       initialValue: date,
//       hintText: '',
//       isEnable: false,
//       isDisableColor: true,
//       onChange: (String value) {},
//       validateTextField: (String? user) {},
//     );
//   }
// }
