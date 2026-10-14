// // import 'dart:convert';
// // import 'dart:developer';
// // import 'dart:ui';
// //
// // import 'package:db_atom/index.dart';
// // import 'package:db_atom/src/features/article_found/article_found_details/cubits/article_found_details_cubit.dart';
// // import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
// //
// // class ArticleFoundDetailsView extends StatefulWidget {
// //   final ArticleFoundModel? model;
// //   final String title;
// //   final ExtraProperties? extraProperties;
// //   final int? eventId; // For creating Article Found inside Event Protection
// //   final String?
// //   eventProtectionId; // For creating Article Found inside Event Protection
// //   final Organisation? eventProtectionLocation;
// //   final bool viaEvent;
// //
// //   const ArticleFoundDetailsView({
// //     super.key,
// //     this.model,
// //     required this.title,
// //     this.extraProperties,
// //     this.eventId,
// //     this.eventProtectionId,
// //     this.eventProtectionLocation,
// //     required this.viaEvent,
// //   });
// //
// //   @override
// //   State<ArticleFoundDetailsView> createState() =>
// //       _ArticleFoundDetailsViewState();
// // }
// //
// // class _ArticleFoundDetailsViewState extends State<ArticleFoundDetailsView> {
// //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// //   TextEditingController returnableTextController = TextEditingController();
// //
// //   User? userDetails;
// //   List<ImageContent> getFiles = [];
// //   TextEditingController takenOutOnDateController = TextEditingController();
// //   TextEditingController statusController = TextEditingController();
// //   TextEditingController expectedDateOfReturnController =
// //   TextEditingController();
// //   TextEditingController foundDateController = TextEditingController();
// //   TextEditingController passValidUntilController = TextEditingController();
// //   bool isReadOnly = false;
// //   TextEditingController passTypeController = TextEditingController();
// //   TextEditingController colorController = TextEditingController();
// //   TextEditingController foundLocationController = TextEditingController();
// //   TextEditingController quantityController = TextEditingController();
// //   TextEditingController depositorController = TextEditingController();
// //   TextEditingController depositorTextController = TextEditingController();
// //   TextEditingController employeeIdController = TextEditingController();
// //   TextEditingController returnedTimeController = TextEditingController();
// //   TextEditingController claimantController = TextEditingController();
// //   TextEditingController claimantTextController = TextEditingController();
// //   TextEditingController safeStoragePlaceController = TextEditingController();
// //   SignatureController claimantSignatureController = SignatureController();
// //   TextEditingController assetTypeController=TextEditingController();
// //   final FocusNode sentToFocusNode = FocusNode();
// //   bool ignorePointer = false;
// //   List<ImageContent> uploadFiles = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     BlocProvider.of<ArticleFoundDetailsCubit>(context).initializeValues();
// //   }
// //
// //   @override
// //   void dispose() {
// //     super.dispose();
// //     returnableTextController.dispose();
// //     takenOutOnDateController.dispose();
// //     statusController.dispose();
// //     expectedDateOfReturnController.dispose();
// //     foundDateController.dispose();
// //     passValidUntilController.dispose();
// //     passTypeController.dispose();
// //     colorController.dispose();
// //     foundLocationController.dispose();
// //     quantityController.dispose();
// //     depositorController.dispose();
// //     depositorTextController.dispose();
// //     employeeIdController.dispose();
// //     returnedTimeController.dispose();
// //     claimantController.dispose();
// //     claimantTextController.dispose();
// //     safeStoragePlaceController.dispose();
// //     claimantSignatureController.dispose();
// //     assetTypeController.dispose();
// //   }
// //
// //   bool showSaveSubmitButtons = false;
// //   bool lock = false;
// //   bool editFields = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     log('---viaEvent-----${widget.viaEvent}-----');
// //     final size = MediaQuery.of(context).size;
// //     double height = size.height;
// //     return BlocConsumer<ArticleFoundDetailsCubit, ArticleFoundDetailsState>(
// //       listener: (context, state) {
// //         log('-state.status--${state.status}--');
// //         log('123 ${state.message}--');
// //         Utils().formError(state, context);
// //         Utils().errorAndLogout(state, context);
// //         // if (widget.eventId != null && state.status == FormStatus.success && widget.viaEvent) {
// //         //   // Navigator.pop(context);
// //         //   Navigator.popAndPushNamed(
// //         //     context,
// //         //     eventInfoRoute,
// //         //     arguments: {
// //         //       ConstantsArgument.title: Constants.afterEventInformation,
// //         //       ConstantsArgument.id: widget.eventProtectionId.toString(),
// //         //       'eventDuration': 2,
// //         //
// //         //       /// 2 is for After the Event
// //         //       ConstantsArgument.editForm: true,
// //         //       ConstantsArgument.isEventProtection: true,
// //         //     },
// //         //   );
// //         //   return;
// //         // }
// //
// //         // if (widget.eventId != null && state.status == FormStatus.success && widget.viaEvent) {
// //         //   var dialog = CustomAlertDialog(
// //         //     title: Constants.articleFoundRegisterListTitle,
// //         //     message: state.message,
// //         //     positiveBtnText: Constants.ok,
// //         //     onPositivePressed: () {
// //         //       Navigator.pop(context); // close the dialog
// //         //       if (!context.mounted) return;
// //         //       Navigator.pop(context); // pop this page — back to the existing EventInfoView underneath
// //         //     },
// //         //   );
// //         //   showDialog(
// //         //       context: context,
// //         //       barrierDismissible: false,
// //         //       builder: (BuildContext context) => dialog);
// //         //   return;
// //         // }
// //         // if (state.status == FormStatus.success && !widget.viaEvent) {
// //         //   var dialog = CustomAlertDialog(
// //         //     title: Constants.articleFoundRegisterListTitle,
// //         //     message: state.message,
// //         //     positiveBtnText: Constants.ok,
// //         //     onPositivePressed: () {
// //         //       // TODO: Need to improve this code
// //         //       Navigator.pop(context);
// //         //       Navigator.pop(context);
// //         //       Navigator.popAndPushNamed(context, articleFoundNewListRoute,
// //         //           arguments: {});
// //         //     },
// //         //   );
// //         //   showDialog(
// //         //       context: context,
// //         //       barrierDismissible: false,
// //         //       builder: (BuildContext context) => dialog);
// //         // }
// //
// //
// //         // if (state.status == FormStatus.success) {
// //         //   var dialog = CustomAlertDialog(
// //         //     title: Constants.articleFoundRegisterListTitle,
// //         //     message: state.message,
// //         //     positiveBtnText: Constants.ok,
// //         //     onPositivePressed: () {
// //         //       Navigator.pop(context); // close the dialog
// //         //
// //         //       if (!context.mounted) return;
// //         //
// //         //       if (widget.viaEvent) {
// //         //         // Came from Event Protection flow — go back to the EventInfoView
// //         //         // that's already underneath on the stack.
// //         //         Navigator.pop(context);
// //         //       } else {
// //         //         // Came from the standalone Article Found list flow.
// //         //         Navigator.pop(context);
// //         //         Navigator.pop(context);
// //         //         Navigator.popAndPushNamed(context, articleFoundNewListRoute,
// //         //             arguments: {
// //         //             });
// //         //       }
// //         //     },
// //         //   );
// //         //   showDialog(
// //         //     context: context,
// //         //     barrierDismissible: false,
// //         //     builder: (BuildContext context) => dialog,
// //         //   );
// //         //   return;
// //         // }
// //
// //         if (state.status == FormStatus.success) {
// //           var dialog = CustomAlertDialog(
// //             title: Constants.articleFoundRegisterListTitle,
// //             message: state.message,
// //             positiveBtnText: Constants.ok,
// //             onPositivePressed: () {
// //               Navigator.pop(context); // close the dialog
// //
// //               // if (!context.mounted) return;
// //
// //               if (widget.viaEvent) {
// //                 Navigator.pop(context);
// //               } else {
// //                 Navigator.pop(context);
// //                 Navigator.pop(context);
// //                 // Navigator.popAndPushNamed(
// //                 //   context,
// //                 //   articleFoundNewListRoute,
// //                 //   arguments: {
// //                 //
// //                 //   },
// //                 // );
// //                 Navigator.pushNamed(context, articleFoundNewListRoute);
// //               }
// //             },
// //           );
// //           showDialog(
// //             context: context,
// //             barrierDismissible: false,
// //             builder: (BuildContext context) => dialog,
// //           );
// //           return;
// //         }
// //       },
// //       // },
// //       builder: (context, state) {
// //         depositorController.text =
// //         '${state.model.depositor?.firstName ?? ''} ${state.model.depositor?.lastName ?? ''}';
// //         depositorTextController.text = state.model.depositorName ?? '';
// //         colorController.text = state.model.color ?? '';
// //         foundLocationController.text = state.model.foundLocation ?? '';
// //         claimantController.text =
// //         '${state.model.claimant?.firstName ?? ''} ${state.model.claimant?.lastName ?? ''}';
// //         claimantTextController.text = state.model.claimantName ?? '';
// //         safeStoragePlaceController.text = state.model.safeStoragePlace ?? '';
// //         // assetTypeController.text = '${state.model.typeOfAsset ?? 0}';
// //
// //         if (state.model.status == 0 && !state.model.lock.isEmptyOrNull) {
// //           isReadOnly = true;
// //         }
// //         if (state.model.status == 1 && !state.model.lock.isEmptyOrNull) {
// //           isReadOnly = true;
// //         }
// //
// //         if (state.model.status != null &&
// //             state.model.status != 0 &&
// //             state.model.status != 1) {
// //           isReadOnly = true;
// //         }
// //         if (state.model.status == 1) {
// //           isReadOnly = true;
// //         }
// //
// //         showSaveSubmitButtons = (widget.model == null ||
// //             state.model.status == 0 ||
// //             state.model.status == 1) &&
// //             state.model.lock.isEmptyOrNull;
// //
// //         editFields= (widget.model == null ||  state.model.status == 0) &&  state.model.lock.isEmptyOrNull;
// //
// //         /// Builds a "Name (email)" display string, but only shows the parts that
// //         /// actually have data — avoids literal "null" text when the value or its
// //         /// fields are empty/null.
// //
// //         return Scaffold(
// //           appBar: BaseAppBar().buildAppHeader(
// //             context: context,
// //             title: widget.title,
// //             showPopUp: false,
// //             showSaveButton:
// //             showSaveSubmitButtons && state.status != FormStatus.loading,
// //             pdfAPIName:
// //             '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.articleFoundModuleCode}',
// //             onTapSave: () {
// //               FocusScope.of(context).unfocus();
// //               BlocProvider.of<ArticleFoundDetailsCubit>(context).submitForm(
// //                 claimantSignatureController:claimantSignatureController,
// //                 isSaveOnly: true,
// //               );
// //             },
// //             showSubmitButton:
// //             showSaveSubmitButtons && state.status != FormStatus.loading,
// //             onTapSubmit: () {
// //               FocusScope.of(context).unfocus();
// //               BlocProvider.of<ArticleFoundDetailsCubit>(context).submitForm(
// //                   isSaveOnly: false,
// //                   claimantSignatureController:claimantSignatureController
// //               );
// //             },
// //             showLikeButton: false,
// //             showDisLikeButton: false,
// //           ),
// //           backgroundColor: AppColors.white,
// //           body: getBodybuilder(state, height),
// //         );
// //       },
// //     ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
// //   }
// //
// //   void initializeDates(ArticleFoundDetailsState state) {
// //     foundDateController.text = state.model.foundDate != null
// //         ? Utils.timestampToDateConversion(
// //         int.tryParse(state.model.foundDate ?? '') ??
// //             DateTime.now()
// //                 .millisecondsSinceEpoch, // Use current timestamp if null
// //         Constants.fulldateFormat)
// //         : '';
// //   }
// //
// //   Widget getBodybuilder(ArticleFoundDetailsState state, height) {
// //     initializeDates(state);
// //     final name = state.model.typeOfArticle?.name?.toLowerCase() ?? '';
// //
// //
// //     if (state.status == FormStatus.loading) {
// //       return const BaseLoader();
// //     }
// //
// //     if (state.status == FormStatus.addAttachment ||
// //         state.status == FormStatus.initial) {
// //       uploadFiles = state.uploadAttachments;
// //       uploadFiles = state.model.images ?? [];
// //     }
// //     String _displayNameEmail(String? name, String? email) {
// //       final hasName = name != null && name.trim().isNotEmpty;
// //       final hasEmail = email != null && email.trim().isNotEmpty;
// //
// //       if (!hasName && !hasEmail) return '';
// //       if (hasName && hasEmail) return '$name ($email)';
// //       if (hasName) return name;
// //       return email!;
// //     }
// //
// //     return Stack(children: [
// //       //  Background Image
// //       // Positioned.fill(
// //       //   child: Image.asset(
// //       //     'assets/images/bg2.png',
// //       //     fit: BoxFit.cover,
// //       //   ),
// //       // ),
// //
// //       // //  Blur Layer
// //       // Positioned.fill(
// //       //   child: BackdropFilter(
// //       //     filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
// //       //     child: Container(
// //       //       color: Colors.black.withValues(alpha: 0.1), // optional tint
// //       //     ),
// //       //   ),
// //       // ),
// //
// //       // color: AppColors.newColor3,
// //       // color: AppColors.navigationSkyBlueColor,
// //       SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             Container(
// //               color: Colors.transparent,
// //               // decoration: const ShapeDecoration(
// //               //     color: AppColors.backgroundWhiteColor,
// //               //     shape: RoundedRectangleBorder(
// //               //       borderRadius:
// //               //           BorderRadius.vertical(top: Radius.circular(20.0)),
// //               //     )),
// //               child: Form(
// //                 key: _formKey,
// //                 autovalidateMode: isReadOnly
// //                     ? AutovalidateMode.disabled
// //                     : AutovalidateMode.onUserInteraction,
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(left: 20.0, right: 20),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     mainAxisSize: MainAxisSize.max,
// //                     children: [
// //                       AbsorbPointer(
// //                         absorbing:
// //                         !showSaveSubmitButtons && !ignorePointer ,
// //                         child: Column(
// //                           children: [
// //                             if (!state.model.lock.isEmptyOrNull) ...[
// //                               RecordLockedWidget(text: '${state.model.lock}'),
// //                             ],
// //                             CommonWidgets.verticalSpacerWidget(height * 0.01),
// //                             Container(
// //                               alignment: Alignment.topLeft,
// //                               child: const Text(
// //                                 Constants.generalinformation,
// //                                 style: Styles.textStyleBlack16,
// //                               ),
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.01),
// //
// //                             /// Status
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.status ??
// //                               //     state.labels?.defaultLocale.status ??
// //                               Constants.status,
// //                               Styles.textStyleBlack16,
// //                               isMandatory: true,
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.001),
// //                             BaseDropDown().getDropDown(
// //                               isDisabled: false,
// //                               textController: statusController,
// //                               items: articleFoundStatus,
// //                               initialValue: '${state.model.status ?? 0}',
// //                               onTap: () {},
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                             /// Created By
// //                             CommonWidgets.horizontalTextHandling(
// //                               // state.labels?.locale.entrySecurity ??
// //                               //     state.labels?.defaultLocale.entrySecurity ??
// //                                 Constants.createdby,
// //                                 isMandatory: true,
// //                                 '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.02),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.01),
// //
// //                             /// Location
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.location ??
// //                               //     state.labels?.defaultLocale.location ??
// //                               Constants.location,
// //                               Styles.textStyleWhite16,
// //                               isMandatory: true,
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.001),
// //                             BaseLocationDropdown().locationWidgetDisplay(
// //                                 isEnabled: (!isReadOnly) && !lock && !widget.viaEvent,
// //                                 context: context,
// //                                 locations: state.locations ?? Locations(),
// //                                 selectedLocationName:
// //                                 state.model.location?.name ?? '',
// //                                 onTap: (Organisation? location) {
// //                                   BlocProvider.of<ArticleFoundDetailsCubit>(
// //                                       context)
// //                                       .updateLocationDropdownValue(
// //                                       location: location);
// //                                 }),
// //
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //
// //                             /// Location Type
// //                             CommonWidgets.textDisplay(
// //                               Constants.locationType,
// //                               Styles.textStyleWhite16,
// //                               isMandatory: true,
// //                             ),
// //                             TextFieldAddButton(
// //                               title: state.model.locationType?.name,
// //                               height: 75,
// //                               isDisableColor: isReadOnly,
// //                               onTap: () {
// //                                 if (!isReadOnly) {
// //                                   BaseOrganisationDialog().departmentDialog(
// //                                     context: context,
// //                                     organisations: state.getLocationType.getLocationType ?? [],
// //                                     onTap: (Organisation locationType) {
// //                                       BlocProvider.of<ArticleFoundDetailsCubit>(context)
// //                                           .updateDropdownValues(locationType: locationType);
// //                                     },
// //                                     leftImage: false,
// //                                     createEntity: false,
// //                                     functionToCall: () {
// //                                       BlocProvider.of<ArticleFoundDetailsCubit>(context).refreshList();
// //                                     },
// //                                   );
// //                                 }
// //                               },
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                             /// Date of creation
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.inputDate ??
// //                               //     state.labels?.defaultLocale.inputDate ??
// //                               Constants.dateofcreation,
// //                               Styles.textStyleWhite16,
// //                               isMandatory: true,
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.001),
// //                             dateCreateWidgetDisplay(
// //                                 state.model.inputDate ?? ''),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                             /// Sl No.
// //                             CommonWidgets.horizontalTextHandling(
// //                               // state.labels?.locale.slltLocale.slNo ??
// //                               Constants.slno,
// //                               state.model.slNo ?? '',
// //                               isMandatory: true,
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                             /// Safe Storage Place
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.coNo ??
// //                               //     //     state.labels?.defaumpanyName ??
// //                               //     state.labels?.defaultLocale.companyName ??
// //                               Constants.safeStoragePlace,
// //                               Styles.textStyleWhite16,
// //                               isMandatory: true,
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.001),
// //                             FlutterInputField(
// //                               textInputType: TextInputType.text,
// //                               textFormKey: Keys.challanKey,
// //                               controller: safeStoragePlaceController,
// //                               characterLimit:
// //                               Constants.characterLimitIdTextFormField,
// //                               hintText: '',
// //                               isEnable: showSaveSubmitButtons,
// //                               isDisableColor: !showSaveSubmitButtons,
// //                               onChange: (String value) {
// //                                 state.model.safeStoragePlace = value;
// //                                 context
// //                                     .read<ArticleFoundDetailsCubit>()
// //                                     .onModelValueChange(state.model);
// //                               },
// //                               validateTextField: (String? user) {},
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                             /// Article Type
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.companyType ??
// //                               //     state.labels?.defaultLocale
// //                               //         .companyType ??
// //                                 Constants.articleType,
// //                                 Styles.textStyleWhite16,
// //                                 isMandatory: true),
// //                             TextFieldAddButton(
// //                               title: state.model.typeOfArticle?.name,
// //                               height: 75,
// //                               isDisableColor: isReadOnly,
// //                               onTap: () {
// //                                 if (!isReadOnly) {
// //                                   BaseOrganisationDialog().departmentDialog(
// //                                     context: context,
// //                                     organisations: state.articleType,
// //                                     onTap: (Organisation articleType) {
// //                                       BlocProvider.of<ArticleFoundDetailsCubit>(
// //                                           context)
// //                                           .updateDropdownValues(
// //                                           articleType: articleType);
// //                                     },
// //                                     leftImage: false,
// //                                     functionToCall: () {
// //                                       // refresh the list
// //                                       BlocProvider.of<ArticleFoundDetailsCubit>(
// //                                           context)
// //                                           .refreshList();
// //                                     },
// //                                   );
// //                                 }
// //                               },
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                             /// Asset Type
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.companyType ??
// //                               //     state.labels?.defaultLocale
// //                               //         .companyType ??
// //                                 Constants.assetType,
// //                                 Styles.textStyleWhite16,
// //                                 isMandatory: true),
// //                             BaseDropDown().getDropDown(
// //                               isDisabled:isReadOnly ? true : true,
// //                               textController: assetTypeController,
// //                               items: assetTypeValues,
// //                               initialValue:
// //                               '${state.model.typeOfAsset ?? 0}',
// //                               onTap: () {
// //                                 if(!isReadOnly){
// //                                   BaseDropDown().assetTypeDialog(
// //                                     context: context,
// //                                     dropDownValues: assetTypeValues
// //                                         .map((label) => label.key)
// //                                         .toList(),
// //                                     onTap: (String value) {
// //                                       Label? selectedLabel;
// //                                       selectedLabel =
// //                                           assetTypeValues.firstWhere(
// //                                                 (label) => label.key == value,
// //                                             orElse: () =>
// //                                             const Label(key: '', value: ''),
// //                                           );
// //
// //                                       BlocProvider.of<
// //                                           ArticleFoundDetailsCubit>(
// //                                           context)
// //                                           .updateDropdownValues(
// //                                           assetType: int.tryParse(
// //                                               selectedLabel.value));
// //                                       widget.model?.typeOfAsset =
// //                                           int.tryParse(selectedLabel.value);
// //                                       // assetTypeController.text =
// //                                       //     selectedLabel.key;
// //                                       // setState(() {});
// //                                     },
// //                                   );}
// //                               },
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                             if (name.contains('id')||name.contains('card')) ...[
// //                               ///Manager Name
// //                               CommonWidgets.textDisplay(
// //                                 // state.labels?.locale.employeeId ??
// //                                 //     state.labels?.defaultLocale
// //                                 //         .employeeId ??
// //                                   Constants.managerName,
// //                                   Styles.textStyleWhite16,
// //                                   isMandatory: true),
// //                               TextFieldAddButton(
// //                                 // title: '${state.model.idCardManager?.name} (${state.model.idCardManager?.email})',
// //                                 title: _displayNameEmail(
// //                                   state.model.idCardManager?.userInfo,
// //                                   state.model.idCardManager?.email,
// //                                 ),
// //                                 height: 75,
// //                                 isDisableColor: !editFields,
// //                                 onTap: () {
// //                                   if (editFields) {
// //                                     BaseOrganisationDialog().userDialog(
// //                                       employeeId: false,
// //                                       context: context,
// //                                       users: state.idCardManger,
// //                                       isDbUser: false,
// //                                       onTap: (BaseUser user) {
// //                                         BlocProvider.of<
// //                                             ArticleFoundDetailsCubit>(
// //                                             context)
// //                                             .updateDropdownValues(
// //                                           idCardManager: user,
// //                                         );
// //                                       },
// //                                       roleName:
// //                                       ConstantUserRoles.atomStaticUser,
// //                                       locationId: state.model.location!.id!,
// //                                       functionToCall: (BaseUser user) {
// //                                         BlocProvider.of<
// //                                             ArticleFoundDetailsCubit>(
// //                                             context)
// //                                             .updateDropdownValues(
// //                                           idCardManager: user,
// //                                         );
// //                                         // refresh the list
// //                                         BlocProvider.of<
// //                                             ArticleFoundDetailsCubit>(
// //                                             context)
// //                                             .refreshList();
// //                                       },
// //                                     );
// //                                   }
// //                                 },
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                               ///Id Card Employee Name
// //                               CommonWidgets.textDisplay(
// //                                 // state.labels?.locale.employeeId ??
// //                                 //     state.labels?.defaultLocale
// //                                 //         .employeeId ??
// //                                   Constants.employeeName,
// //                                   Styles.textStyleWhite16,
// //                                   isMandatory: true),
// //                               TextFieldAddButton(
// //                                 // title: '${state.model.idCardEmployee?.name} (${state.model.idCardEmployee?.email})',
// //                                 title: _displayNameEmail(
// //                                   state.model.idCardEmployee?.userInfo,
// //                                   state.model.idCardEmployee?.email,
// //                                 ),
// //                                 height: 75,
// //                                 isDisableColor: !editFields,
// //                                 onTap: () {
// //                                   if (editFields) {
// //                                     BaseOrganisationDialog().userDialog(
// //                                       employeeId: false,
// //                                       context: context,
// //                                       users: state.idCardEmployee,
// //                                       isDbUser: false,
// //                                       onTap: (BaseUser user) {
// //                                         BlocProvider.of<
// //                                             ArticleFoundDetailsCubit>(
// //                                             context)
// //                                             .updateDropdownValues(
// //                                           idCardEmployee: user,
// //                                         );
// //                                       },
// //                                       roleName:
// //                                       ConstantUserRoles.atomStaticUser,
// //                                       locationId: state.model.location!.id!,
// //                                       functionToCall: (BaseUser user) {
// //                                         BlocProvider.of<
// //                                             ArticleFoundDetailsCubit>(
// //                                             context)
// //                                             .updateDropdownValues(
// //                                           idCardEmployee: user,
// //                                         );
// //                                         // refresh the list
// //                                         BlocProvider.of<
// //                                             ArticleFoundDetailsCubit>(
// //                                             context)
// //                                             .refreshList();
// //                                       },
// //                                     );
// //                                   }
// //                                 },
// //                               ),
// //                               // TextFieldAddButton(
// //                               //   title: state.model.idCardEmployee?.employeeId,
// //                               //   height: 75,
// //                               //   isDisableColor: !showSaveSubmitButtons,
// //                               //   onTap: () {
// //                               //     if (showSaveSubmitButtons) {
// //                               //       BaseOrganisationDialog().userDialog(
// //                               //         employeeId: true,
// //                               //         context: context,
// //                               //         users: state.idCardEmployee,
// //                               //         isDbUser: false,
// //                               //         onTap: (BaseUser user) {
// //                               //           BlocProvider.of<
// //                               //                       ArticleFoundDetailsCubit>(
// //                               //                   context)
// //                               //               .updateDropdownValues(
// //                               //             idCardEmployee: user,
// //                               //           );
// //                               //         },
// //                               //         roleName:
// //                               //             ConstantUserRoles.atomStaticUser,
// //                               //         locationId: state.model.location!.id!,
// //                               //         functionToCall: (BaseUser user) {
// //                               //           BlocProvider.of<
// //                               //                       ArticleFoundDetailsCubit>(
// //                               //                   context)
// //                               //               .updateDropdownValues(
// //                               //             idCardEmployee: user,
// //                               //           );
// //                               //           // refresh the list
// //                               //           BlocProvider.of<
// //                               //                       ArticleFoundDetailsCubit>(
// //                               //                   context)
// //                               //               .refreshList();
// //                               //         },
// //                               //       );
// //                               //     }
// //                               //   },
// //                               // ),
// //                               CommonWidgets.verticalSpacerWidget(height * 0.03),
// //                             ],
// //
// //                             /// Found Date
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.timeOfVisit ??
// //                               //     state.labels?.defaultLocale
// //                               //         .timeOfVisit ??
// //                               Constants.founddate,
// //                               isMandatory: true,
// //                               Styles.textStyleWhite16,
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.001),
// //
// //                             BaseDate().datePickerWidgetLoading(
// //                               textController: foundDateController,
// //                               isDisabled: isReadOnly,
// //                               onlyDate: false,
// //                               showPastDate: true,
// //                               showFutureDate: false,
// //                               onChange: (String value) {
// //                                 foundDateController.text = value;
// //                                 state.model.foundDate =
// //                                     Utils().formatTime(value);
// //                                 BlocProvider.of<ArticleFoundDetailsCubit>(
// //                                     context)
// //                                     .onModelValueChange(state.model);
// //                               },
// //                               context: context,
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.01),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.01),
// //
// //                             /// Found Location
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.companyName ??
// //                               //     state.labels?.defaultLocale.companyName ??
// //                               Constants.foundLocation,
// //                               Styles.textStyleWhite16,
// //                               isMandatory: true,
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.001),
// //                             FlutterInputField(
// //                               textInputType: TextInputType.text,
// //                               textFormKey: Keys.challanKey,
// //                               controller: foundLocationController,
// //                               characterLimit:
// //                               Constants.characterLimitIdTextFormField,
// //                               hintText: '',
// //                               isEnable: !isReadOnly,
// //                               isDisableColor: isReadOnly,
// //                               onChange: (String value) {
// //                                 state.model.foundLocation = value;
// //                                 context
// //                                     .read<ArticleFoundDetailsCubit>()
// //                                     .onModelValueChange(state.model);
// //                               },
// //                               validateTextField: (String? user) {},
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                             /// Additional Information
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.additionalInformation ??
// //                               //     state.labels?.defaultLocale.additionalInformation ??
// //                                 Constants.additionalinformation,
// //                                 Styles.textStyleWhite16,
// //                                 isMandatory: false),
// //                             FlutterInputField(
// //                               lineHeight: 5,
// //                               characterLimit:
// //                               Constants.characterLimitDescTextFormField,
// //                               initialValue: state.model.additionalInformation,
// //                               textFormKey: Keys.premisesRoundTknCommentsKey,
// //                               hintText: Constants.informationhere,
// //                               showBorder: true,
// //                               textInputAction: TextInputAction.newline,
// //                               textInputType: TextInputType.multiline,
// //                               isEnable: !isReadOnly,
// //                               isDisableColor: isReadOnly,
// //                               onChange: (String value) {
// //                                 state.model.additionalInformation = value;
// //                                 context
// //                                     .read<ArticleFoundDetailsCubit>()
// //                                     .onModelValueChange(state.model);
// //                               },
// //                               validateTextField: (String? user) {},
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                             /// Quantity
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.companyName ??
// //                               //     state.labels?.defaultLocale.companyName ??
// //                               Constants.quantity,
// //                               Styles.textStyleWhite16,
// //                               isMandatory: true,
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.001),
// //                             FlutterInputField(
// //                               textInputType: TextInputType.number,
// //                               textFormKey: Keys.challanKey,
// //                               initialValue: '${state.model.quantity ?? ''}',
// //                               characterLimit:
// //                               Constants.characterLimitIdTextFormField,
// //                               hintText: '',
// //                               isEnable: !isReadOnly,
// //                               isDisableColor: isReadOnly,
// //                               onChange: (String value) {
// //                                 state.model.quantity = int.tryParse(value);
// //                                 // state.model.quantity = value;
// //                                 context
// //                                     .read<ArticleFoundDetailsCubit>()
// //                                     .onModelValueChange(state.model);
// //                               },
// //                               validateTextField: (String? user) {},
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                             /// Color
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.companyName ??
// //                               //     state.labels?.defaultLocale.companyName ??
// //                               Constants.colour,
// //                               Styles.textStyleWhite16,
// //                               isMandatory: true,
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.001),
// //                             FlutterInputField(
// //                               textInputType: TextInputType.text,
// //                               textFormKey: Keys.challanKey,
// //                               controller: colorController,
// //                               characterLimit:
// //                               Constants.characterLimitIdTextFormField,
// //                               hintText: '',
// //                               isEnable: !isReadOnly,
// //                               isDisableColor: isReadOnly,
// //                               onChange: (String value) {
// //                                 state.model.color = value;
// //                                 context
// //                                     .read<ArticleFoundDetailsCubit>()
// //                                     .onModelValueChange(state.model);
// //                               },
// //                               validateTextField: (String? user) {},
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                             /// Article Category
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.companyType ??
// //                               //     state.labels?.defaultLocale
// //                               //         .companyType ??
// //                                 Constants.articleCategory,
// //                                 Styles.textStyleWhite16,
// //                                 isMandatory: true),
// //                             TextFieldAddButton(
// //                               title: state.model.articleCategory?.name,
// //                               height: 75,
// //                               isDisableColor: isReadOnly,
// //                               onTap: () {
// //                                 if (!isReadOnly) {
// //                                   BaseOrganisationDialog().departmentDialog(
// //                                     context: context,
// //                                     organisations: state.articleCategory,
// //                                     onTap: (Organisation articleCategory) {
// //                                       BlocProvider.of<ArticleFoundDetailsCubit>(
// //                                           context)
// //                                           .updateDropdownValues(
// //                                           articleCategory: articleCategory);
// //                                     },
// //                                     leftImage: false,
// //                                     functionToCall: () {
// //                                       // refresh the list
// //                                       BlocProvider.of<ArticleFoundDetailsCubit>(
// //                                           context)
// //                                           .refreshList();
// //                                     },
// //                                   );
// //                                 }
// //                               },
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                             /// Approximate Value(INR)
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.companyName ??
// //                               //     state.labels?.defaultLocale.companyName ??
// //                               Constants.approximateValue,
// //                               Styles.textStyleWhite16,
// //                               isMandatory: true,
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.001),
// //                             FlutterInputField(
// //                               textInputType: TextInputType.number,
// //                               textFormKey: Keys.challanKey,
// //                               initialValue: state.model.approximateValue ?? '',
// //                               characterLimit:
// //                               Constants.characterLimitIdTextFormField,
// //                               hintText: '',
// //                               isEnable: !isReadOnly,
// //                               isDisableColor: isReadOnly,
// //                               onChange: (String value) {
// //                                 state.model.approximateValue = value;
// //                                 // state.model.quantity = value;
// //                                 context
// //                                     .read<ArticleFoundDetailsCubit>()
// //                                     .onModelValueChange(state.model);
// //                               },
// //                               validateTextField: (String? user) {},
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //
// //                             /// is Depositor GIG Employee
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.exceptionalApproval ??
// //                               //     state.labels?.defaultLocale
// //                               //         .exceptionalApproval ??
// //                                 Constants.isdepositordbemployee,
// //                                 isMandatory: true,
// //                                 Styles.textStyleWhite16),
// //                             RadioButtonsYesNo(
// //                                 status: state.model.status ?? 0,
// //                                 selectedValue:
// //                                 state.model.depositorDbEmp ? 1 : 0,
// //                                 onChangedYes: isReadOnly
// //                                     ? null
// //                                     : (val) {
// //                                   state.model.depositorDbEmp = true;
// //                                   BlocProvider.of<
// //                                       ArticleFoundDetailsCubit>(
// //                                       context)
// //                                       .onCheckBoxChange(state.model);
// //                                 },
// //                                 onChangedNo: isReadOnly
// //                                     ? null
// //                                     : (val) {
// //                                   state.model.depositorDbEmp = false;
// //                                   BlocProvider.of<
// //                                       ArticleFoundDetailsCubit>(
// //                                       context)
// //                                       .onCheckBoxChange(state.model);
// //                                 }),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.02),
// //
// //                             if (state.model.depositorDbEmp == true) ...[
// //                               ///  Depositor Employee Id
// //                               CommonWidgets.textDisplay(
// //                                 // state.labels?.locale.employeeId ??
// //                                 //     state.labels?.defaultLocale
// //                                 //         .employeeId ??
// //                                   Constants.depositoremployeeid,
// //                                   Styles.textStyleWhite16,
// //                                   isMandatory: true),
// //                               TextFieldAddButton(
// //                                 title: state.model.depositor?.employeeId,
// //                                 height: 75,
// //                                 isDisableColor: !editFields,
// //                                 onTap: () {
// //                                   if (editFields) {
// //                                     BaseOrganisationDialog().userDialog(
// //                                       employeeId: true,
// //                                       context: context,
// //                                       users: state.employee!,
// //                                       isDbUser: false,
// //                                       onTap: (BaseUser user) {
// //                                         BlocProvider.of<
// //                                             ArticleFoundDetailsCubit>(
// //                                             context)
// //                                             .updateDropdownValues(
// //                                           employee: user,
// //                                         );
// //                                       },
// //                                       roleName:
// //                                       ConstantUserRoles.atomStaticUser,
// //                                       locationId: state.model.location!.id!,
// //                                       functionToCall: (BaseUser user) {
// //                                         BlocProvider.of<
// //                                             ArticleFoundDetailsCubit>(
// //                                             context)
// //                                             .updateDropdownValues(
// //                                           employee: user,
// //                                         );
// //                                         // refresh the list
// //                                         BlocProvider.of<
// //                                             ArticleFoundDetailsCubit>(
// //                                             context)
// //                                             .refreshList();
// //                                       },
// //                                     );
// //                                   }
// //                                 },
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                               /// Depositor
// //                               CommonWidgets.textDisplay(
// //                                 // state.labels?.locale.cwrSponsor ??
// //                                 //     state.labels?.defaultLocale
// //                                 //         .cwrSponsor ??
// //                                   Constants.depositor,
// //                                   isMandatory: true,
// //                                   Styles.textStyleWhite16),
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.001),
// //                               FlutterInputField(
// //                                 controller: depositorController,
// //                                 textInputType: TextInputType.text,
// //                                 textFormKey: Keys.contactNoKey,
// //                                 hintText: '',
// //                                 isEnable: false,
// //                                 isDisableColor: true,
// //                                 onChange: (String value) {},
// //                                 validateTextField: (String? user) {},
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //                               ///  Depositor Department
// //                               CommonWidgets.textDisplay(
// //                                 // state.labels?.locale.department ??
// //                                 //     state.labels?.defaultLocale.department ??
// //                                 Constants.department,
// //                                 Styles.textStyleWhite16,
// //                                 isMandatory: true,
// //                               ),
// //                               TextFieldAddButton(
// //                                 title: state.model.depositorDepartment?.name,
// //                                 height: 75,
// //                                 isDisableColor: !editFields,
// //                                 onTap: () {
// //                                   if (editFields) {
// //                                     BaseOrganisationDialog().departmentDialog(
// //                                         context: context,
// //                                         organisations: state.departments,
// //                                         onTap: (Organisation department) {
// //                                           state.model.depositorDepartment
// //                                               ?.name = department.name;
// //                                           BlocProvider.of<
// //                                               ArticleFoundDetailsCubit>(
// //                                               context)
// //                                               .updateDropdownValues(
// //                                               department: department);
// //                                         },
// //                                         createEntity: false,
// //                                         functionToCall: () {
// //                                           // refresh the list
// //                                           BlocProvider.of<
// //                                               ArticleFoundDetailsCubit>(
// //                                               context)
// //                                               .refreshList();
// //                                         });
// //                                     FocusScope.of(context)
// //                                         .requestFocus(sentToFocusNode);
// //                                   }
// //                                 },
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(height * 0.03),
// //                             ],
// //
// //                             if (state.model.depositorDbEmp == false) ...[
// //                               /// Depositor
// //                               CommonWidgets.textDisplay(
// //                                 // state.labels?.locale.companyName ??
// //                                 //     state.labels?.defaultLocale.companyName ??
// //                                 Constants.depositor,
// //                                 Styles.textStyleWhite16,
// //                                 isMandatory: true,
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(
// //                                   height * 0.001),
// //                               FlutterInputField(
// //                                 textInputType: TextInputType.text,
// //                                 textFormKey: Keys.challanKey,
// //                                 controller: depositorTextController,
// //                                 characterLimit:
// //                                 Constants.characterLimitIdTextFormField,
// //                                 hintText: '',
// //                                 isEnable: !isReadOnly,
// //                                 isDisableColor: isReadOnly,
// //                                 onChange: (String value) {
// //                                   state.model.depositor?.name = value;
// //                                   state.model.depositorName = value;
// //                                   context
// //                                       .read<ArticleFoundDetailsCubit>()
// //                                       .onModelValueChange(state.model);
// //                                 },
// //                                 validateTextField: (String? user) {},
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(height * 0.01),
// //                             ],
// //
// //                             if (widget.model?.status != null &&
// //                                 widget.model?.status != 0) ...[
// //                               /// is Claimant Company Employee
// //                               CommonWidgets.textDisplay(
// //                                 // state.labels?.locale.exceptionalApproval ??
// //                                 //     state.labels?.defaultLocale
// //                                 //         .exceptionalApproval ??
// //                                   Constants.isclaimantdbemployee,
// //                                   isMandatory: true,
// //                                   Styles.textStyleWhite16),
// //                               RadioButtonsYesNo(
// //                                   status: state.model.status ?? 0,
// //                                   selectedValue:
// //                                   state.model.claimantDbEmp ? 1 : 0,
// //                                   onChangedYes: widget.model?.status != 1
// //                                       ? null
// //                                       : (val) {
// //                                     state.model.claimantDbEmp = true;
// //                                     BlocProvider.of<
// //                                         ArticleFoundDetailsCubit>(
// //                                         context)
// //                                         .onCheckBoxChange(state.model);
// //                                   },
// //                                   onChangedNo: widget.model?.status != 1
// //                                       ? null
// //                                       : (val) {
// //                                     state.model.claimantDbEmp = false;
// //                                     BlocProvider.of<
// //                                         ArticleFoundDetailsCubit>(
// //                                         context)
// //                                         .onCheckBoxChange(state.model);
// //                                   }),
// //                               CommonWidgets.verticalSpacerWidget(height * 0.01),
// //
// //                               if (widget.model?.claimantDbEmp == true) ...[
// //                                 ///  Claimant Employee Id
// //                                 CommonWidgets.textDisplay(
// //                                   // state.labels?.locale.employeeId ??
// //                                   //     state.labels?.defaultLocale
// //                                   //         .employeeId ??
// //                                     Constants.claimantemployeeid,
// //                                     Styles.textStyleWhite16,
// //                                     isMandatory: true),
// //                                 TextFieldAddButton(
// //                                   title: state.model.claimant?.employeeId,
// //                                   height: 75,
// //                                   isDisableColor: !showSaveSubmitButtons,
// //                                   onTap: () {
// //                                     if (showSaveSubmitButtons) {
// //                                       BaseOrganisationDialog().userDialog(
// //                                         employeeId: true,
// //                                         context: context,
// //                                         users: state.claimant!,
// //                                         isDbUser: false,
// //                                         onTap: (BaseUser user) {
// //                                           BlocProvider.of<
// //                                               ArticleFoundDetailsCubit>(
// //                                               context)
// //                                               .updateDropdownValues(
// //                                             claimant: user,
// //                                           );
// //                                         },
// //                                         roleName:
// //                                         ConstantUserRoles.atomStaticUser,
// //                                         locationId: state.model.location!.id!,
// //                                         functionToCall: (BaseUser user) {
// //                                           BlocProvider.of<
// //                                               ArticleFoundDetailsCubit>(
// //                                               context)
// //                                               .updateDropdownValues(
// //                                             claimant: user,
// //                                           );
// //                                           // refresh the list
// //                                           BlocProvider.of<
// //                                               ArticleFoundDetailsCubit>(
// //                                               context)
// //                                               .refreshList();
// //                                         },
// //                                       );
// //                                     }
// //                                   },
// //                                 ),
// //                                 CommonWidgets.verticalSpacerWidget(
// //                                     height * 0.03),
// //
// //                                 /// Claimant
// //                                 CommonWidgets.textDisplay(
// //                                   // state.labels?.locale.cwrSponsor ??
// //                                   //     state.labels?.defaultLocale
// //                                   //         .cwrSponsor ??
// //                                     Constants.claimant,
// //                                     isMandatory: true,
// //                                     Styles.textStyleWhite16),
// //                                 CommonWidgets.verticalSpacerWidget(
// //                                     height * 0.001),
// //                                 FlutterInputField(
// //                                   controller: claimantController,
// //                                   textInputType: TextInputType.text,
// //                                   textFormKey: Keys.contactNoKey,
// //                                   hintText: '',
// //                                   isEnable: false,
// //                                   isDisableColor: true,
// //                                   onChange: (String value) {},
// //                                   validateTextField: (String? user) {},
// //                                 ),
// //                                 CommonWidgets.verticalSpacerWidget(
// //                                     height * 0.03),
// //
// //                                 ///  Claimant Department
// //                                 CommonWidgets.textDisplay(
// //                                   // state.labels?.locale.department ??
// //                                   //     state.labels?.defaultLocale
// //                                   //         .department ??
// //                                   Constants.claimantdepartment,
// //                                   Styles.textStyleWhite16,
// //                                   isMandatory: true,
// //                                 ),
// //                                 TextFieldAddButton(
// //                                   title: state.model.claimantDepartment?.name,
// //                                   height: 75,
// //                                   isDisableColor: !showSaveSubmitButtons,
// //                                   onTap: () {
// //                                     if (showSaveSubmitButtons) {
// //                                       BaseOrganisationDialog().departmentDialog(
// //                                           context: context,
// //                                           organisations: state.departments,
// //                                           onTap: (Organisation department) {
// //                                             state.model.claimantDepartment
// //                                                 ?.name = department.name;
// //                                             BlocProvider.of<
// //                                                 ArticleFoundDetailsCubit>(
// //                                                 context)
// //                                                 .updateDropdownValues(
// //                                                 claimantDepartment:
// //                                                 department);
// //                                           },
// //                                           createEntity: false,
// //                                           functionToCall: () {
// //                                             // refresh the list
// //                                             BlocProvider.of<
// //                                                 ArticleFoundDetailsCubit>(
// //                                                 context)
// //                                                 .refreshList();
// //                                           });
// //                                       FocusScope.of(context)
// //                                           .requestFocus(sentToFocusNode);
// //                                     }
// //                                   },
// //                                 ),
// //                                 CommonWidgets.verticalSpacerWidget(
// //                                     height * 0.03),
// //
// //                                 /// Claimant Accepted to sign
// //                                 // CommonWidgets.textDisplay(
// //                                 //     // state.labels?.locale.exceptionalApproval ??
// //                                 //     //     state.labels?.defaultLocale
// //                                 //     //         .exceptionalApproval ??
// //                                 //     Constants.isclaimantacceptedtosign,
// //                                 //     isMandatory: true,
// //                                 //     Styles.textStyleWhite16),
// //                                 // RadioButtonsYesNo(
// //                                 //     status: state.model.status ?? 0,
// //                                 //     selectedValue:
// //                                 //         state.model.claimantNoSign ? 1 : 0,
// //                                 //     onChangedYes: isReadOnly
// //                                 //         ? null
// //                                 //         : (val) {
// //                                 //             state.model.claimantNoSign = true;
// //                                 //             BlocProvider.of<
// //                                 //                         ArticleFoundDetailsCubit>(
// //                                 //                     context)
// //                                 //                 .onCheckBoxChange(state.model);
// //                                 //           },
// //                                 //     onChangedNo: isReadOnly
// //                                 //         ? null
// //                                 //         : (val) {
// //                                 //             state.model.claimantNoSign = false;
// //                                 //             BlocProvider.of<
// //                                 //                         ArticleFoundDetailsCubit>(
// //                                 //                     context)
// //                                 //                 .onCheckBoxChange(state.model);
// //                                 //           }),
// //                                 // CommonWidgets.verticalSpacerWidget(
// //                                 //     height * 0.03),
// //
// //                                 // if (widget.model?.claimantNoSign == false) ...[
// //                                 //   /// Claimant Confirmed by Email
// //                                 //   CommonWidgets.textDisplay(
// //                                 //       // state.labels?.locale.exceptionalApproval ??
// //                                 //       //     state.labels?.defaultLocale
// //                                 //       //         .exceptionalApproval ??
// //                                 //       Constants.isclaimantacceptedbyemail,
// //                                 //       isMandatory: true,
// //                                 //       Styles.textStyleWhite16),
// //                                 //   RadioButtonsYesNo(
// //                                 //     status: state.model.status ?? 0,
// //                                 //     selectedValue:
// //                                 //         state.model.claimantConfirmByEmail
// //                                 //             ? 1
// //                                 //             : 0,
// //                                 //     onChangedYes: null,
// //                                 //     // onChangedYes: isReadOnly
// //                                 //     //     ? null
// //                                 //     //     : (val) {
// //                                 //     //   // state.model.claimantConfirmByEmail= true;
// //                                 //     //   BlocProvider.of<
// //                                 //     //       ArticleFoundDetailsCubit>(
// //                                 //     //       context)
// //                                 //     //       .onCheckBoxChange(state.model);
// //                                 //     // },
// //                                 //     onChangedNo: null,
// //                                 //     // isReadOnly
// //                                 //     //     ? null
// //                                 //     //     : (val) {
// //                                 //     //   // state.model.claimantConfirmByEmail = false;
// //                                 //     //   BlocProvider.of<
// //                                 //     //       ArticleFoundDetailsCubit>(
// //                                 //     //       context)
// //                                 //     //       .onCheckBoxChange(state.model);
// //                                 //     // }
// //                                 //   ),
// //                                 //   CommonWidgets.verticalSpacerWidget(
// //                                 //       height * 0.03),
// //                                 // ]
// //                               ],
// //
// //                               if (widget.model?.claimantDbEmp == false) ...[
// //                                 /// Claimant
// //                                 CommonWidgets.textDisplay(
// //                                   // state.labels?.locale.companyName ??
// //                                   //     state.labels?.defaultLocale.companyName ??
// //                                   Constants.claimant,
// //                                   Styles.textStyleWhite16,
// //                                   isMandatory: true,
// //                                 ),
// //                                 CommonWidgets.verticalSpacerWidget(
// //                                     height * 0.001),
// //                                 FlutterInputField(
// //                                   textInputType: TextInputType.text,
// //                                   textFormKey: Keys.challanKey,
// //                                   controller: claimantTextController,
// //                                   characterLimit:
// //                                   Constants.characterLimitIdTextFormField,
// //                                   hintText: '',
// //                                   isEnable: showSaveSubmitButtons,
// //                                   isDisableColor: !showSaveSubmitButtons,
// //                                   onChange: (String value) {
// //                                     state.model.claimant?.name = value;
// //                                     state.model.claimantName = value;
// //                                     context
// //                                         .read<ArticleFoundDetailsCubit>()
// //                                         .onModelValueChange(state.model);
// //                                   },
// //                                   validateTextField: (String? user) {},
// //                                 ),
// //                                 CommonWidgets.verticalSpacerWidget(
// //                                     height * 0.02),
// //                               ],
// //                             ],
// //
// //                             if(state.model.status !=0 && state.model.status !=null)...[
// //                               /// Claimant Signature
// //                               buildSignature(
// //                                   controller: claimantSignatureController,
// //                                   label:
// //                                   // state.labels?.locale.entrySecuritySign ??
// //                                   //     state.labels?.defaultLocale
// //                                   //         .entrySecuritySign ??
// //                                   Constants.claimantSignature,
// //                                   spaceHeight: height,
// //                                   state: state, isMandatory: true
// //                               ),
// //                             ],
// //
// //
// //                             CommonWidgets.verticalSpacerWidget(height * 0.02),
// //
// //                             if( state.model.status == 2)...[
// //                               /// Handover By
// //                               CommonWidgets.horizontalTextHandling(
// //                                 // state.labels?.locale.entrySecurity ??
// //                                 //     state.labels?.defaultLocale.entrySecurity ??
// //                                   Constants.handoverBy,
// //                                   isMandatory: true,
// //                                   '${state.model.handOverSecurityName}'),
// //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// //
// //                               /// Handover Date
// //                               CommonWidgets.textDisplay(
// //                                 // state.labels?.locale.inputDate ??
// //                                 //     state.labels?.defaultLocale.inputDate ??
// //                                 Constants.handedOverDate,
// //                                 Styles.textStyleWhite16,
// //                                 isMandatory: true,
// //                               ),
// //                               CommonWidgets.verticalSpacerWidget(height * 0.001),
// //                               dateCreateWidgetDisplay(
// //                                   state.model.handoverDate ?? ''),
// //                               CommonWidgets.verticalSpacerWidget(height * 0.03),
// //                             ],
// //                             ///Upload Image
// //                             CommonWidgets.textDisplay(
// //                               // state.labels?.locale.evidenceInfo ??
// //                               //     state.labels?.defaultLocale.evidenceInfo ??
// //                                 Constants.evidenceDocuments,
// //                                 Styles.textStyleWhite16),
// //                             widget.model == null
// //                                 ? CommonWidgets.verticalSpacerWidget(
// //                                 height * 0.001)
// //                                 : Container(),
// //                             if (state.model.status == 0 ||
// //                                 state.model.status == null) ...[
// //                               BaseImageUpload().uploadWidget(
// //                                 context: context,
// //                                 isDisabled: isReadOnly,
// //                                 loggedInUserDetails: state.loggedInUserDetails!,
// //                                 getFiles: uploadFiles,
// //                                 onImageSelected: (ImageContent data) {
// //                                   List<ImageContent>? files = [];
// //                                   files.add(data);
// //                                   for (ImageContent image in uploadFiles) {
// //                                     files.add(image);
// //                                   }
// //                                   BlocProvider.of<ArticleFoundDetailsCubit>(
// //                                       context)
// //                                       .addAttachment(
// //                                     data: files,
// //                                     images: files,
// //                                   );
// //                                 },
// //                               ),
// //                             ],
// //                             CommonWidgets.verticalSpacerWidget(height * 0.02),
// //
// //
// //                             /// Attachments
// //                             IgnorePointer(
// //                               ignoring: false,
// //                               child: Padding(
// //                                 padding: const EdgeInsets.symmetric(
// //                                     horizontal: 20.0),
// //                                 child: BaseImageUpload().getAttachment(
// //                                   height: height,
// //                                   attachments: state.uploadAttachments,
// //                                   files: uploadFiles,
// //                                   moduleCode: Constants.articleFoundModuleCode,
// //                                   isDisabled: isReadOnly,
// //                                   showDeleteIcon: state.model.status == null ||
// //                                       state.model.status ==
// //                                           ConstantsIntValue.mmStatusDraft,
// //                                 ),
// //                               ),
// //                             ),
// //                             CommonWidgets.verticalSpacerWidget(height * 0.02),
// //
// //
// //                             CommonWidgets.verticalSpacerWidget(height * 0.03),
// //
// //
// //                             /// SubmitButton
// //                             if (showSaveSubmitButtons) ...[
// //                               Row(
// //                                 mainAxisAlignment:
// //                                 MainAxisAlignment.spaceEvenly,
// //                                 children: [
// //                                   cancelButtonDisplay(),
// //                                   if (showSaveSubmitButtons) ...[
// //                                     submitButtonDisplay(state)
// //                                   ],
// //                                 ],
// //                               ),
// //                             ],
// //                           ],
// //                         ),
// //
// //                       ),
// //
// //                       /// Kept outside AbsorbPointer so the close button stays tappable
// //                       if (!showSaveSubmitButtons) ...[
// //                         Center(
// //                           child: cancelButtonDisplay(),
// //                         ),
// //                         CommonWidgets.verticalSpacerWidget(height * 0.04),
// //                       ],
// //                       CommonWidgets.verticalSpacerWidget(height * 0.04),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       // ),
// //     ]);
// //   }
// //
// //
// //
// //
// //   Widget buildSignature({
// //     required SignatureController controller,
// //     required String label,
// //     required double spaceHeight,
// //     required ArticleFoundDetailsState state,
// //     required bool isMandatory,
// //   }) {
// //     final bool isEditable = state.isReceiverSignEditable ?? false;
// //     final bool isSigned = state.model.claimantSign != null &&
// //         !state.model.claimantSign!.imageContent.isEmptyOrNull;
// //
// //     return AbsorbPointer(
// //       absorbing: !(state.model.lock.isEmptyOrNull && state.model.status == 1),
// //       child: Column(
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Row(
// //                 children: [
// //                   CommonWidgets.textDisplay(label, Styles.textStyleWhite14),
// //                   if (isMandatory)
// //                     const Text(' *', style: TextStyle(color: Colors.red)),
// //                 ],
// //               ),
// //               Row(
// //                 children: [
// //                   state.model.status == 1 && state.model.lock.isEmptyOrNull
// //                       ? IconButton(
// //                     onPressed: () {
// //                       controller.clear();
// //                       BlocProvider.of<ArticleFoundDetailsCubit>(context).clearSign();
// //                     },
// //                     iconSize: 20,
// //                     color: Colors.white,
// //                     icon: const Icon(Icons.refresh),
// //                   )
// //                       : SizedBox.fromSize(),
// //                 ],
// //               ),
// //             ],
// //           ),
// //           CommonWidgets.verticalSpacerWidget(spaceHeight * 0.001),
// //           ClipRect(
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(2.0),
// //                 border: Border.all(
// //                   color: AppColors.geryLightBackground,
// //                   width: 1,
// //                 ),
// //               ),
// //               height: 120,
// //               width: double.infinity,
// //               child: (!isEditable && isSigned)
// //                   ? Image.memory(
// //                 Uint8List.fromList(
// //                   base64Decode(state.model.claimantSign!.imageContent ?? ''),
// //                 ),
// //                 fit: BoxFit.none,
// //               )
// //                   : Signature(
// //                 controller: controller,
// //                 backgroundColor: Colors.transparent,
// //               ),
// //             ),
// //           ),
// //           CommonWidgets.verticalSpacerWidget(spaceHeight * 0.01),
// //         ],
// //       ),
// //     );
// //   }
// //   Widget cancelButtonDisplay() {
// //     return AppButton(
// //       width: Constants.cancelButtonWidth,
// //       backgroundColor: Colors.white,
// //       key: const Key(Keys.cancelButton),
// //       buttonText: Constants.close,
// //       buttonTextKey: Keys.cancelButton,
// //       onTap: () {
// //         Navigator.pop(context);
// //         CommonServices().unlock();
// //       },
// //     );
// //   }
// //
// //   Widget submitButtonDisplay(ArticleFoundDetailsState state) {
// //     return AppButton(
// //       width: 150,
// //       key: const Key(Keys.submitButton),
// //       buttonText: Constants.submit,
// //       buttonTextKey: Keys.submitButton,
// //       onTap: () async {
// //         FocusScope.of(context).unfocus();
// //         BlocProvider.of<ArticleFoundDetailsCubit>(context).submitForm(
// //             claimantSignatureController: claimantSignatureController
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget dateCreateWidgetDisplay(String date) {
// //     return FlutterInputField(
// //       textFormKey: Keys.dateofcreationTextController,
// //       showBorder: true,
// //       initialValue: date,
// //       hintText: '',
// //       isEnable: false,
// //       isDisableColor: false,
// //       onChange: (String value) {},
// //       validateTextField: (String? user) {},
// //     );
// //   }
// // }
// //
//
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:db_atom/index.dart';
// import 'package:db_atom/src/features/article_found/article_found_details/cubits/article_found_details_cubit.dart';
// import 'package:db_atom/src/features/article_found/models/article_found_model.dart';
//
// class ArticleFoundDetailsView extends StatefulWidget {
//   final ArticleFoundModel? model;
//   final String title;
//   final ExtraProperties? extraProperties;
//   final int? eventId; // For creating Article Found inside Event Protection
//   final String?
//   eventProtectionId; // For creating Article Found inside Event Protection
//   final Organisation? eventProtectionLocation;
//   final bool viaEvent;
//
//   const ArticleFoundDetailsView({
//     super.key,
//     this.model,
//     required this.title,
//     this.extraProperties,
//     this.eventId,
//     this.eventProtectionId,
//     this.eventProtectionLocation,
//     required this.viaEvent,
//   });
//
//   @override
//   State<ArticleFoundDetailsView> createState() =>
//       _ArticleFoundDetailsViewState();
// }
//
// class _ArticleFoundDetailsViewState extends State<ArticleFoundDetailsView> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController returnableTextController = TextEditingController();
//
//   User? userDetails;
//   List<ImageContent> getFiles = [];
//   TextEditingController takenOutOnDateController = TextEditingController();
//   TextEditingController statusController = TextEditingController();
//   TextEditingController expectedDateOfReturnController =
//   TextEditingController();
//   TextEditingController foundDateController = TextEditingController();
//   TextEditingController passValidUntilController = TextEditingController();
//   bool isReadOnly = false;
//   TextEditingController passTypeController = TextEditingController();
//   TextEditingController colorController = TextEditingController();
//   TextEditingController foundLocationController = TextEditingController();
//   TextEditingController quantityController = TextEditingController();
//   TextEditingController depositorController = TextEditingController();
//   TextEditingController depositorTextController = TextEditingController();
//   TextEditingController employeeIdController = TextEditingController();
//   TextEditingController returnedTimeController = TextEditingController();
//   TextEditingController claimantController = TextEditingController();
//   TextEditingController claimantTextController = TextEditingController();
//   TextEditingController safeStoragePlaceController = TextEditingController();
//   SignatureController claimantSignatureController = SignatureController();
//   TextEditingController assetTypeController=TextEditingController();
//   final FocusNode sentToFocusNode = FocusNode();
//   bool ignorePointer = false;
//   List<ImageContent> uploadFiles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<ArticleFoundDetailsCubit>(context).initializeValues();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     returnableTextController.dispose();
//     takenOutOnDateController.dispose();
//     statusController.dispose();
//     expectedDateOfReturnController.dispose();
//     foundDateController.dispose();
//     passValidUntilController.dispose();
//     passTypeController.dispose();
//     colorController.dispose();
//     foundLocationController.dispose();
//     quantityController.dispose();
//     depositorController.dispose();
//     depositorTextController.dispose();
//     employeeIdController.dispose();
//     returnedTimeController.dispose();
//     claimantController.dispose();
//     claimantTextController.dispose();
//     safeStoragePlaceController.dispose();
//     claimantSignatureController.dispose();
//     assetTypeController.dispose();
//   }
//
//   bool showSaveSubmitButtons = false;
//   bool lock = false;
//   bool editFields = false;
//
//   @override
//   Widget build(BuildContext context) {
//     log('---viaEvent-----${widget.viaEvent}-----');
//     final size = MediaQuery.of(context).size;
//     double height = size.height;
//     return BlocConsumer<ArticleFoundDetailsCubit, ArticleFoundDetailsState>(
//       listener: (context, state) {
//         log('-state.status--${state.status}--');
//         log('123 ${state.message}--');
//         Utils().formError(state, context);
//         Utils().errorAndLogout(state, context);
//         // if (widget.eventId != null && state.status == FormStatus.success && widget.viaEvent) {
//         //   // Navigator.pop(context);
//         //   Navigator.popAndPushNamed(
//         //     context,
//         //     eventInfoRoute,
//         //     arguments: {
//         //       ConstantsArgument.title: Constants.afterEventInformation,
//         //       ConstantsArgument.id: widget.eventProtectionId.toString(),
//         //       'eventDuration': 2,
//         //
//         //       /// 2 is for After the Event
//         //       ConstantsArgument.editForm: true,
//         //       ConstantsArgument.isEventProtection: true,
//         //     },
//         //   );
//         //   return;
//         // }
//
//         // if (widget.eventId != null && state.status == FormStatus.success && widget.viaEvent) {
//         //   var dialog = CustomAlertDialog(
//         //     title: Constants.articleFoundRegisterListTitle,
//         //     message: state.message,
//         //     positiveBtnText: Constants.ok,
//         //     onPositivePressed: () {
//         //       Navigator.pop(context); // close the dialog
//         //       if (!context.mounted) return;
//         //       Navigator.pop(context); // pop this page — back to the existing EventInfoView underneath
//         //     },
//         //   );
//         //   showDialog(
//         //       context: context,
//         //       barrierDismissible: false,
//         //       builder: (BuildContext context) => dialog);
//         //   return;
//         // }
//         // if (state.status == FormStatus.success && !widget.viaEvent) {
//         //   var dialog = CustomAlertDialog(
//         //     title: Constants.articleFoundRegisterListTitle,
//         //     message: state.message,
//         //     positiveBtnText: Constants.ok,
//         //     onPositivePressed: () {
//         //       // TODO: Need to improve this code
//         //       Navigator.pop(context);
//         //       Navigator.pop(context);
//         //       Navigator.popAndPushNamed(context, articleFoundNewListRoute,
//         //           arguments: {});
//         //     },
//         //   );
//         //   showDialog(
//         //       context: context,
//         //       barrierDismissible: false,
//         //       builder: (BuildContext context) => dialog);
//         // }
//
//
//         // if (state.status == FormStatus.success) {
//         //   var dialog = CustomAlertDialog(
//         //     title: Constants.articleFoundRegisterListTitle,
//         //     message: state.message,
//         //     positiveBtnText: Constants.ok,
//         //     onPositivePressed: () {
//         //       Navigator.pop(context); // close the dialog
//         //
//         //       if (!context.mounted) return;
//         //
//         //       if (widget.viaEvent) {
//         //         // Came from Event Protection flow — go back to the EventInfoView
//         //         // that's already underneath on the stack.
//         //         Navigator.pop(context);
//         //       } else {
//         //         // Came from the standalone Article Found list flow.
//         //         Navigator.pop(context);
//         //         Navigator.pop(context);
//         //         Navigator.popAndPushNamed(context, articleFoundNewListRoute,
//         //             arguments: {
//         //             });
//         //       }
//         //     },
//         //   );
//         //   showDialog(
//         //     context: context,
//         //     barrierDismissible: false,
//         //     builder: (BuildContext context) => dialog,
//         //   );
//         //   return;
//         // }
//
//         if (state.status == FormStatus.success) {
//           var dialog = CustomAlertDialog(
//             title: Constants.articleFoundRegisterListTitle,
//             message: state.message,
//             positiveBtnText: Constants.ok,
//             onPositivePressed: () {
//               Navigator.pop(context); // close the dialog
//
//               // if (!context.mounted) return;
//
//               if (widget.viaEvent) {
//                 Navigator.pop(context);
//               } else {
//                 Navigator.pop(context);
//                 Navigator.pop(context);
//                 // Navigator.popAndPushNamed(
//                 //   context,
//                 //   articleFoundNewListRoute,
//                 //   arguments: {
//                 //
//                 //   },
//                 // );
//                 Navigator.pushNamed(context, articleFoundNewListRoute);
//               }
//             },
//           );
//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (BuildContext context) => dialog,
//           );
//           return;
//         }
//       },
//       // },
//       builder: (context, state) {
//         depositorController.text =
//         '${state.model.depositor?.firstName ?? ''} ${state.model.depositor?.lastName ?? ''}';
//         depositorTextController.text = state.model.depositorName ?? '';
//         colorController.text = state.model.color ?? '';
//         foundLocationController.text = state.model.foundLocation ?? '';
//         claimantController.text =
//         '${state.model.claimant?.firstName ?? ''} ${state.model.claimant?.lastName ?? ''}';
//         claimantTextController.text = state.model.claimantName ?? '';
//         safeStoragePlaceController.text = state.model.safeStoragePlace ?? '';
//         // assetTypeController.text = '${state.model.typeOfAsset ?? 0}';
//
//         if (state.model.status == 0 && !state.model.lock.isEmptyOrNull) {
//           isReadOnly = true;
//         }
//         if (state.model.status == 1 && !state.model.lock.isEmptyOrNull) {
//           isReadOnly = true;
//         }
//
//         if (state.model.status != null &&
//             state.model.status != 0 &&
//             state.model.status != 1) {
//           isReadOnly = true;
//         }
//         if (state.model.status == 1) {
//           isReadOnly = true;
//         }
//
//         showSaveSubmitButtons = (widget.model == null ||
//             state.model.status == 0 ||
//             state.model.status == 1) &&
//             state.model.lock.isEmptyOrNull;
//
//         editFields= (widget.model == null ||  state.model.status == 0) &&  state.model.lock.isEmptyOrNull;
//
//         /// Builds a "Name (email)" display string, but only shows the parts that
//         /// actually have data — avoids literal "null" text when the value or its
//         /// fields are empty/null.
//
//         return Scaffold(
//           appBar: BaseAppBar().buildAppHeader(
//             context: context,
//             title: widget.title,
//             showPopUp: false,
//             showSaveButton:
//             showSaveSubmitButtons && state.status != FormStatus.loading,
//             pdfAPIName:
//             '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.articleFoundModuleCode}',
//             onTapSave: () {
//               FocusScope.of(context).unfocus();
//               BlocProvider.of<ArticleFoundDetailsCubit>(context).submitForm(
//                 claimantSignatureController:claimantSignatureController,
//                 isSaveOnly: true,
//               );
//             },
//             showSubmitButton:
//             showSaveSubmitButtons && state.status != FormStatus.loading,
//             onTapSubmit: () {
//               FocusScope.of(context).unfocus();
//               BlocProvider.of<ArticleFoundDetailsCubit>(context).submitForm(
//                   isSaveOnly: false,
//                   claimantSignatureController:claimantSignatureController
//               );
//             },
//             showLikeButton: false,
//             showDisLikeButton: false,
//           ),
//           backgroundColor: Colors.white,
//           body: getBodybuilder(state, height),
//         );
//       },
//     ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
//   }
//
//   void initializeDates(ArticleFoundDetailsState state) {
//     foundDateController.text = state.model.foundDate != null
//         ? Utils.timestampToDateConversion(
//         int.tryParse(state.model.foundDate ?? '') ??
//             DateTime.now()
//                 .millisecondsSinceEpoch, // Use current timestamp if null
//         Constants.fulldateFormat)
//         : '';
//   }
//
//   Widget getBodybuilder(ArticleFoundDetailsState state, height) {
//     initializeDates(state);
//     final name = state.model.typeOfArticle?.name?.toLowerCase() ?? '';
//
//
//     if (state.status == FormStatus.loading) {
//       return const BaseLoader();
//     }
//
//     if (state.status == FormStatus.addAttachment ||
//         state.status == FormStatus.initial) {
//       uploadFiles = state.uploadAttachments;
//       uploadFiles = state.model.images ?? [];
//     }
//     String _displayNameEmail(String? name, String? email) {
//       final hasName = name != null && name.trim().isNotEmpty;
//       final hasEmail = email != null && email.trim().isNotEmpty;
//
//       if (!hasName && !hasEmail) return '';
//       if (hasName && hasEmail) return '$name ($email)';
//       if (hasName) return name;
//       return email!;
//     }
//
//     return Stack(children: [
//       //  Background Image
//       // Positioned.fill(
//       //   child: Image.asset(
//       //     'assets/images/bg2.png',
//       //     fit: BoxFit.cover,
//       //   ),
//       // ),
//
//       // //  Blur Layer
//       // Positioned.fill(
//       //   child: BackdropFilter(
//       //     filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
//       //     child: Container(
//       //       color: Colors.black.withValues(alpha: 0.1), // optional tint
//       //     ),
//       //   ),
//       // ),
//
//       // color: AppColors.newColor3,
//       // color: AppColors.navigationSkyBlueColor,
//       SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               color: Colors.transparent,
//               // decoration: const ShapeDecoration(
//               //     color: AppColors.backgroundWhiteColor,
//               //     shape: RoundedRectangleBorder(
//               //       borderRadius:
//               //           BorderRadius.vertical(top: Radius.circular(20.0)),
//               //     )),
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
//                         absorbing:
//                         !showSaveSubmitButtons && !ignorePointer ,
//                         child: Column(
//                           children: [
//                             if (!state.model.lock.isEmptyOrNull) ...[
//                               RecordLockedWidget(text: '${state.model.lock}'),
//                             ],
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//                             Container(
//                               alignment: Alignment.topLeft,
//                               child: const Text(
//                                 Constants.generalinformation,
//                                 style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                               ),
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             /// Status
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.status ??
//                               //     state.labels?.defaultLocale.status ??
//                               Constants.status,
//                               const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//                             BaseDropDown().getDropDown(
//                               isDisabled: false,
//                               textController: statusController,
//                               items: articleFoundStatus,
//                               initialValue: '${state.model.status ?? 0}',
//                               onTap: () {},
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                             /// Created By
//                             CommonWidgets.horizontalTextHandling(
//                               // state.labels?.locale.entrySecurity ??
//                               //     state.labels?.defaultLocale.entrySecurity ??
//                                 Constants.createdby,
//                                 isMandatory: true,
//                                 '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
//                             CommonWidgets.verticalSpacerWidget(height * 0.02),
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             /// Location
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.location ??
//                               //     state.labels?.defaultLocale.location ??
//                               Constants.location,
//                               const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//                             BaseLocationDropdown().locationWidgetDisplay(
//                                 isEnabled: (!isReadOnly) && !lock && !widget.viaEvent,
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
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//
//                             /// Location Type
//                             CommonWidgets.textDisplay(
//                               Constants.locationType,
//                               const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                               isMandatory: true,
//                             ),
//                             TextFieldAddButton(
//                               title: state.model.locationType?.name,
//                               height: 75,
//                               isDisableColor: isReadOnly,
//                               onTap: () {
//                                 if (!isReadOnly) {
//                                   BaseOrganisationDialog().departmentDialog(
//                                     context: context,
//                                     organisations: state.getLocationType.getLocationType ?? [],
//                                     onTap: (Organisation locationType) {
//                                       BlocProvider.of<ArticleFoundDetailsCubit>(context)
//                                           .updateDropdownValues(locationType: locationType);
//                                     },
//                                     leftImage: false,
//                                     createEntity: false,
//                                     functionToCall: () {
//                                       BlocProvider.of<ArticleFoundDetailsCubit>(context).refreshList();
//                                     },
//                                   );
//                                 }
//                               },
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                             /// Date of creation
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.inputDate ??
//                               //     state.labels?.defaultLocale.inputDate ??
//                               Constants.dateofcreation,
//                               const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//                             dateCreateWidgetDisplay(
//                                 state.model.inputDate ?? ''),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                             /// Sl No.
//                             CommonWidgets.horizontalTextHandling(
//                               // state.labels?.locale.slltLocale.slNo ??
//                               Constants.slno,
//                               state.model.slNo ?? '',
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                             /// Safe Storage Place
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.coNo ??
//                               //     //     state.labels?.defaumpanyName ??
//                               //     state.labels?.defaultLocale.companyName ??
//                               Constants.safeStoragePlace,
//                               const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//                             FlutterInputField(
//                               textInputType: TextInputType.text,
//                               textFormKey: Keys.challanKey,
//                               controller: safeStoragePlaceController,
//                               characterLimit:
//                               Constants.characterLimitIdTextFormField,
//                               hintText: '',
//                               isEnable: showSaveSubmitButtons,
//                               isDisableColor: !showSaveSubmitButtons,
//                               onChange: (String value) {
//                                 state.model.safeStoragePlace = value;
//                                 context
//                                     .read<ArticleFoundDetailsCubit>()
//                                     .onModelValueChange(state.model);
//                               },
//                               validateTextField: (String? user) {},
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                             /// Article Type
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.companyType ??
//                               //     state.labels?.defaultLocale
//                               //         .companyType ??
//                                 Constants.articleType,
//                                 const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                 isMandatory: true),
//                             TextFieldAddButton(
//                               title: state.model.typeOfArticle?.name,
//                               height: 75,
//                               isDisableColor: isReadOnly,
//                               onTap: () {
//                                 if (!isReadOnly) {
//                                   BaseOrganisationDialog().departmentDialog(
//                                     context: context,
//                                     organisations: state.articleType,
//                                     onTap: (Organisation articleType) {
//                                       BlocProvider.of<ArticleFoundDetailsCubit>(
//                                           context)
//                                           .updateDropdownValues(
//                                           articleType: articleType);
//                                     },
//                                     leftImage: false,
//                                     functionToCall: () {
//                                       // refresh the list
//                                       BlocProvider.of<ArticleFoundDetailsCubit>(
//                                           context)
//                                           .refreshList();
//                                     },
//                                   );
//                                 }
//                               },
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                             /// Asset Type
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.companyType ??
//                               //     state.labels?.defaultLocale
//                               //         .companyType ??
//                                 Constants.assetType,
//                                 const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                 isMandatory: true),
//                             BaseDropDown().getDropDown(
//                               isDisabled:isReadOnly ? true : true,
//                               textController: assetTypeController,
//                               items: assetTypeValues,
//                               initialValue:
//                               '${state.model.typeOfAsset ?? 0}',
//                               onTap: () {
//                                 if(!isReadOnly){
//                                   BaseDropDown().assetTypeDialog(
//                                     context: context,
//                                     dropDownValues: assetTypeValues
//                                         .map((label) => label.key)
//                                         .toList(),
//                                     onTap: (String value) {
//                                       Label? selectedLabel;
//                                       selectedLabel =
//                                           assetTypeValues.firstWhere(
//                                                 (label) => label.key == value,
//                                             orElse: () =>
//                                             const Label(key: '', value: ''),
//                                           );
//
//                                       BlocProvider.of<
//                                           ArticleFoundDetailsCubit>(
//                                           context)
//                                           .updateDropdownValues(
//                                           assetType: int.tryParse(
//                                               selectedLabel.value));
//                                       widget.model?.typeOfAsset =
//                                           int.tryParse(selectedLabel.value);
//                                       // assetTypeController.text =
//                                       //     selectedLabel.key;
//                                       // setState(() {});
//                                     },
//                                   );}
//                               },
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                             if (name.contains('id')||name.contains('card')) ...[
//                               ///Manager Name
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.employeeId ??
//                                 //     state.labels?.defaultLocale
//                                 //         .employeeId ??
//                                   Constants.managerName,
//                                   const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                   isMandatory: true),
//                               TextFieldAddButton(
//                                 // title: '${state.model.idCardManager?.name} (${state.model.idCardManager?.email})',
//                                 title: _displayNameEmail(
//                                   state.model.idCardManager?.userInfo,
//                                   state.model.idCardManager?.email,
//                                 ),
//                                 height: 75,
//                                 isDisableColor: !editFields,
//                                 onTap: () {
//                                   if (editFields) {
//                                     BaseOrganisationDialog().userDialog(
//                                       employeeId: false,
//                                       context: context,
//                                       users: state.idCardManger,
//                                       isDbUser: false,
//                                       onTap: (BaseUser user) {
//                                         BlocProvider.of<
//                                             ArticleFoundDetailsCubit>(
//                                             context)
//                                             .updateDropdownValues(
//                                           idCardManager: user,
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
//                                           idCardManager: user,
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
//                               CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                               ///Id Card Employee Name
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.employeeId ??
//                                 //     state.labels?.defaultLocale
//                                 //         .employeeId ??
//                                   Constants.employeeName,
//                                   const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                   isMandatory: true),
//                               TextFieldAddButton(
//                                 // title: '${state.model.idCardEmployee?.name} (${state.model.idCardEmployee?.email})',
//                                 title: _displayNameEmail(
//                                   state.model.idCardEmployee?.userInfo,
//                                   state.model.idCardEmployee?.email,
//                                 ),
//                                 height: 75,
//                                 isDisableColor: !editFields,
//                                 onTap: () {
//                                   if (editFields) {
//                                     BaseOrganisationDialog().userDialog(
//                                       employeeId: false,
//                                       context: context,
//                                       users: state.idCardEmployee,
//                                       isDbUser: false,
//                                       onTap: (BaseUser user) {
//                                         BlocProvider.of<
//                                             ArticleFoundDetailsCubit>(
//                                             context)
//                                             .updateDropdownValues(
//                                           idCardEmployee: user,
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
//                                           idCardEmployee: user,
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
//                               // TextFieldAddButton(
//                               //   title: state.model.idCardEmployee?.employeeId,
//                               //   height: 75,
//                               //   isDisableColor: !showSaveSubmitButtons,
//                               //   onTap: () {
//                               //     if (showSaveSubmitButtons) {
//                               //       BaseOrganisationDialog().userDialog(
//                               //         employeeId: true,
//                               //         context: context,
//                               //         users: state.idCardEmployee,
//                               //         isDbUser: false,
//                               //         onTap: (BaseUser user) {
//                               //           BlocProvider.of<
//                               //                       ArticleFoundDetailsCubit>(
//                               //                   context)
//                               //               .updateDropdownValues(
//                               //             idCardEmployee: user,
//                               //           );
//                               //         },
//                               //         roleName:
//                               //             ConstantUserRoles.atomStaticUser,
//                               //         locationId: state.model.location!.id!,
//                               //         functionToCall: (BaseUser user) {
//                               //           BlocProvider.of<
//                               //                       ArticleFoundDetailsCubit>(
//                               //                   context)
//                               //               .updateDropdownValues(
//                               //             idCardEmployee: user,
//                               //           );
//                               //           // refresh the list
//                               //           BlocProvider.of<
//                               //                       ArticleFoundDetailsCubit>(
//                               //                   context)
//                               //               .refreshList();
//                               //         },
//                               //       );
//                               //     }
//                               //   },
//                               // ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.03),
//                             ],
//
//                             /// Found Date
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.timeOfVisit ??
//                               //     state.labels?.defaultLocale
//                               //         .timeOfVisit ??
//                               Constants.founddate,
//                               isMandatory: true,
//                               const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//
//                             BaseDate().datePickerWidgetLoading(
//                               textController: foundDateController,
//                               isDisabled: isReadOnly,
//                               onlyDate: false,
//                               showPastDate: true,
//                               showFutureDate: false,
//                               onChange: (String value) {
//                                 foundDateController.text = value;
//                                 state.model.foundDate =
//                                     Utils().formatTime(value);
//                                 BlocProvider.of<ArticleFoundDetailsCubit>(
//                                     context)
//                                     .onModelValueChange(state.model);
//                               },
//                               context: context,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//                             CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                             /// Found Location
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.companyName ??
//                               //     state.labels?.defaultLocale.companyName ??
//                               Constants.foundLocation,
//                               const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//                             FlutterInputField(
//                               textInputType: TextInputType.text,
//                               textFormKey: Keys.challanKey,
//                               controller: foundLocationController,
//                               characterLimit:
//                               Constants.characterLimitIdTextFormField,
//                               hintText: '',
//                               isEnable: !isReadOnly,
//                               isDisableColor: isReadOnly,
//                               onChange: (String value) {
//                                 state.model.foundLocation = value;
//                                 context
//                                     .read<ArticleFoundDetailsCubit>()
//                                     .onModelValueChange(state.model);
//                               },
//                               validateTextField: (String? user) {},
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                             /// Additional Information
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.additionalInformation ??
//                               //     state.labels?.defaultLocale.additionalInformation ??
//                                 Constants.additionalinformation,
//                                 const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                 isMandatory: false),
//                             FlutterInputField(
//                               lineHeight: 5,
//                               characterLimit:
//                               Constants.characterLimitDescTextFormField,
//                               initialValue: state.model.additionalInformation,
//                               textFormKey: Keys.premisesRoundTknCommentsKey,
//                               hintText: Constants.informationhere,
//                               showBorder: true,
//                               textInputAction: TextInputAction.newline,
//                               textInputType: TextInputType.multiline,
//                               isEnable: !isReadOnly,
//                               isDisableColor: isReadOnly,
//                               onChange: (String value) {
//                                 state.model.additionalInformation = value;
//                                 context
//                                     .read<ArticleFoundDetailsCubit>()
//                                     .onModelValueChange(state.model);
//                               },
//                               validateTextField: (String? user) {},
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                             /// Quantity
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.companyName ??
//                               //     state.labels?.defaultLocale.companyName ??
//                               Constants.quantity,
//                               const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//                             FlutterInputField(
//                               textInputType: TextInputType.number,
//                               textFormKey: Keys.challanKey,
//                               initialValue: '${state.model.quantity ?? ''}',
//                               characterLimit:
//                               Constants.characterLimitIdTextFormField,
//                               hintText: '',
//                               isEnable: !isReadOnly,
//                               isDisableColor: isReadOnly,
//                               onChange: (String value) {
//                                 state.model.quantity = int.tryParse(value);
//                                 // state.model.quantity = value;
//                                 context
//                                     .read<ArticleFoundDetailsCubit>()
//                                     .onModelValueChange(state.model);
//                               },
//                               validateTextField: (String? user) {},
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                             /// Color
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.companyName ??
//                               //     state.labels?.defaultLocale.companyName ??
//                               Constants.colour,
//                               const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//                             FlutterInputField(
//                               textInputType: TextInputType.text,
//                               textFormKey: Keys.challanKey,
//                               controller: colorController,
//                               characterLimit:
//                               Constants.characterLimitIdTextFormField,
//                               hintText: '',
//                               isEnable: !isReadOnly,
//                               isDisableColor: isReadOnly,
//                               onChange: (String value) {
//                                 state.model.color = value;
//                                 context
//                                     .read<ArticleFoundDetailsCubit>()
//                                     .onModelValueChange(state.model);
//                               },
//                               validateTextField: (String? user) {},
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                             /// Article Category
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.companyType ??
//                               //     state.labels?.defaultLocale
//                               //         .companyType ??
//                                 Constants.articleCategory,
//                                 const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                 isMandatory: true),
//                             TextFieldAddButton(
//                               title: state.model.articleCategory?.name,
//                               height: 75,
//                               isDisableColor: isReadOnly,
//                               onTap: () {
//                                 if (!isReadOnly) {
//                                   BaseOrganisationDialog().departmentDialog(
//                                     context: context,
//                                     organisations: state.articleCategory,
//                                     onTap: (Organisation articleCategory) {
//                                       BlocProvider.of<ArticleFoundDetailsCubit>(
//                                           context)
//                                           .updateDropdownValues(
//                                           articleCategory: articleCategory);
//                                     },
//                                     leftImage: false,
//                                     functionToCall: () {
//                                       // refresh the list
//                                       BlocProvider.of<ArticleFoundDetailsCubit>(
//                                           context)
//                                           .refreshList();
//                                     },
//                                   );
//                                 }
//                               },
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                             /// Approximate Value(INR)
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.companyName ??
//                               //     state.labels?.defaultLocale.companyName ??
//                               Constants.approximateValue,
//                               const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                               isMandatory: true,
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.001),
//                             FlutterInputField(
//                               textInputType: TextInputType.number,
//                               textFormKey: Keys.challanKey,
//                               initialValue: state.model.approximateValue ?? '',
//                               characterLimit:
//                               Constants.characterLimitIdTextFormField,
//                               hintText: '',
//                               isEnable: !isReadOnly,
//                               isDisableColor: isReadOnly,
//                               onChange: (String value) {
//                                 state.model.approximateValue = value;
//                                 // state.model.quantity = value;
//                                 context
//                                     .read<ArticleFoundDetailsCubit>()
//                                     .onModelValueChange(state.model);
//                               },
//                               validateTextField: (String? user) {},
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//
//                             /// is Depositor GIG Employee
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.exceptionalApproval ??
//                               //     state.labels?.defaultLocale
//                               //         .exceptionalApproval ??
//                                 Constants.isdepositordbemployee,
//                                 isMandatory: true,
//                                 const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
//                             RadioButtonsYesNo(
//                                 status: state.model.status ?? 0,
//                                 selectedValue:
//                                 state.model.depositorDbEmp ? 1 : 0,
//                                 onChangedYes: isReadOnly
//                                     ? null
//                                     : (val) {
//                                   state.model.depositorDbEmp = true;
//                                   BlocProvider.of<
//                                       ArticleFoundDetailsCubit>(
//                                       context)
//                                       .onCheckBoxChange(state.model);
//                                 },
//                                 onChangedNo: isReadOnly
//                                     ? null
//                                     : (val) {
//                                   state.model.depositorDbEmp = false;
//                                   BlocProvider.of<
//                                       ArticleFoundDetailsCubit>(
//                                       context)
//                                       .onCheckBoxChange(state.model);
//                                 }),
//                             CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                             if (state.model.depositorDbEmp == true) ...[
//                               ///  Depositor Employee Id
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.employeeId ??
//                                 //     state.labels?.defaultLocale
//                                 //         .employeeId ??
//                                   Constants.depositoremployeeid,
//                                   const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                   isMandatory: true),
//                               TextFieldAddButton(
//                                 title: state.model.depositor?.employeeId,
//                                 height: 75,
//                                 isDisableColor: !editFields,
//                                 onTap: () {
//                                   if (editFields) {
//                                     BaseOrganisationDialog().userDialog(
//                                       employeeId: true,
//                                       context: context,
//                                       users: state.employee!,
//                                       isDbUser: false,
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
//                               CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                               /// Depositor
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.cwrSponsor ??
//                                 //     state.labels?.defaultLocale
//                                 //         .cwrSponsor ??
//                                   Constants.depositor,
//                                   isMandatory: true,
//                                   const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.001),
//                               FlutterInputField(
//                                 controller: depositorController,
//                                 textInputType: TextInputType.text,
//                                 textFormKey: Keys.contactNoKey,
//                                 hintText: '',
//                                 isEnable: false,
//                                 isDisableColor: true,
//                                 onChange: (String value) {},
//                                 validateTextField: (String? user) {},
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//                               ///  Depositor Department
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.department ??
//                                 //     state.labels?.defaultLocale.department ??
//                                 Constants.department,
//                                 const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                 isMandatory: true,
//                               ),
//                               TextFieldAddButton(
//                                 title: state.model.depositorDepartment?.name,
//                                 height: 75,
//                                 isDisableColor: !editFields,
//                                 onTap: () {
//                                   if (editFields) {
//                                     BaseOrganisationDialog().departmentDialog(
//                                         context: context,
//                                         organisations: state.departments,
//                                         onTap: (Organisation department) {
//                                           state.model.depositorDepartment
//                                               ?.name = department.name;
//                                           BlocProvider.of<
//                                               ArticleFoundDetailsCubit>(
//                                               context)
//                                               .updateDropdownValues(
//                                               department: department);
//                                         },
//                                         createEntity: false,
//                                         functionToCall: () {
//                                           // refresh the list
//                                           BlocProvider.of<
//                                               ArticleFoundDetailsCubit>(
//                                               context)
//                                               .refreshList();
//                                         });
//                                     FocusScope.of(context)
//                                         .requestFocus(sentToFocusNode);
//                                   }
//                                 },
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.03),
//                             ],
//
//                             if (state.model.depositorDbEmp == false) ...[
//                               /// Depositor
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.companyName ??
//                                 //     state.labels?.defaultLocale.companyName ??
//                                 Constants.depositor,
//                                 const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                 isMandatory: true,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(
//                                   height * 0.001),
//                               FlutterInputField(
//                                 textInputType: TextInputType.text,
//                                 textFormKey: Keys.challanKey,
//                                 controller: depositorTextController,
//                                 characterLimit:
//                                 Constants.characterLimitIdTextFormField,
//                                 hintText: '',
//                                 isEnable: !isReadOnly,
//                                 isDisableColor: isReadOnly,
//                                 onChange: (String value) {
//                                   state.model.depositor?.name = value;
//                                   state.model.depositorName = value;
//                                   context
//                                       .read<ArticleFoundDetailsCubit>()
//                                       .onModelValueChange(state.model);
//                                 },
//                                 validateTextField: (String? user) {},
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.01),
//                             ],
//
//                             if (widget.model?.status != null &&
//                                 widget.model?.status != 0) ...[
//                               /// is Claimant Company Employee
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.exceptionalApproval ??
//                                 //     state.labels?.defaultLocale
//                                 //         .exceptionalApproval ??
//                                   Constants.isclaimantdbemployee,
//                                   isMandatory: true,
//                                   const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
//                               RadioButtonsYesNo(
//                                   status: state.model.status ?? 0,
//                                   selectedValue:
//                                   state.model.claimantDbEmp ? 1 : 0,
//                                   onChangedYes: widget.model?.status != 1
//                                       ? null
//                                       : (val) {
//                                     state.model.claimantDbEmp = true;
//                                     BlocProvider.of<
//                                         ArticleFoundDetailsCubit>(
//                                         context)
//                                         .onCheckBoxChange(state.model);
//                                   },
//                                   onChangedNo: widget.model?.status != 1
//                                       ? null
//                                       : (val) {
//                                     state.model.claimantDbEmp = false;
//                                     BlocProvider.of<
//                                         ArticleFoundDetailsCubit>(
//                                         context)
//                                         .onCheckBoxChange(state.model);
//                                   }),
//                               CommonWidgets.verticalSpacerWidget(height * 0.01),
//
//                               if (widget.model?.claimantDbEmp == true) ...[
//                                 ///  Claimant Employee Id
//                                 CommonWidgets.textDisplay(
//                                   // state.labels?.locale.employeeId ??
//                                   //     state.labels?.defaultLocale
//                                   //         .employeeId ??
//                                     Constants.claimantemployeeid,
//                                     const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                     isMandatory: true),
//                                 TextFieldAddButton(
//                                   title: state.model.claimant?.employeeId,
//                                   height: 75,
//                                   isDisableColor: !showSaveSubmitButtons,
//                                   onTap: () {
//                                     if (showSaveSubmitButtons) {
//                                       BaseOrganisationDialog().userDialog(
//                                         employeeId: true,
//                                         context: context,
//                                         users: state.claimant!,
//                                         isDbUser: false,
//                                         onTap: (BaseUser user) {
//                                           BlocProvider.of<
//                                               ArticleFoundDetailsCubit>(
//                                               context)
//                                               .updateDropdownValues(
//                                             claimant: user,
//                                           );
//                                         },
//                                         roleName:
//                                         ConstantUserRoles.atomStaticUser,
//                                         locationId: state.model.location!.id!,
//                                         functionToCall: (BaseUser user) {
//                                           BlocProvider.of<
//                                               ArticleFoundDetailsCubit>(
//                                               context)
//                                               .updateDropdownValues(
//                                             claimant: user,
//                                           );
//                                           // refresh the list
//                                           BlocProvider.of<
//                                               ArticleFoundDetailsCubit>(
//                                               context)
//                                               .refreshList();
//                                         },
//                                       );
//                                     }
//                                   },
//                                 ),
//                                 CommonWidgets.verticalSpacerWidget(
//                                     height * 0.03),
//
//                                 /// Claimant
//                                 CommonWidgets.textDisplay(
//                                   // state.labels?.locale.cwrSponsor ??
//                                   //     state.labels?.defaultLocale
//                                   //         .cwrSponsor ??
//                                     Constants.claimant,
//                                     isMandatory: true,
//                                     const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
//                                 CommonWidgets.verticalSpacerWidget(
//                                     height * 0.001),
//                                 FlutterInputField(
//                                   controller: claimantController,
//                                   textInputType: TextInputType.text,
//                                   textFormKey: Keys.contactNoKey,
//                                   hintText: '',
//                                   isEnable: false,
//                                   isDisableColor: true,
//                                   onChange: (String value) {},
//                                   validateTextField: (String? user) {},
//                                 ),
//                                 CommonWidgets.verticalSpacerWidget(
//                                     height * 0.03),
//
//                                 ///  Claimant Department
//                                 CommonWidgets.textDisplay(
//                                   // state.labels?.locale.department ??
//                                   //     state.labels?.defaultLocale
//                                   //         .department ??
//                                   Constants.claimantdepartment,
//                                   const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                   isMandatory: true,
//                                 ),
//                                 TextFieldAddButton(
//                                   title: state.model.claimantDepartment?.name,
//                                   height: 75,
//                                   isDisableColor: !showSaveSubmitButtons,
//                                   onTap: () {
//                                     if (showSaveSubmitButtons) {
//                                       BaseOrganisationDialog().departmentDialog(
//                                           context: context,
//                                           organisations: state.departments,
//                                           onTap: (Organisation department) {
//                                             state.model.claimantDepartment
//                                                 ?.name = department.name;
//                                             BlocProvider.of<
//                                                 ArticleFoundDetailsCubit>(
//                                                 context)
//                                                 .updateDropdownValues(
//                                                 claimantDepartment:
//                                                 department);
//                                           },
//                                           createEntity: false,
//                                           functionToCall: () {
//                                             // refresh the list
//                                             BlocProvider.of<
//                                                 ArticleFoundDetailsCubit>(
//                                                 context)
//                                                 .refreshList();
//                                           });
//                                       FocusScope.of(context)
//                                           .requestFocus(sentToFocusNode);
//                                     }
//                                   },
//                                 ),
//                                 CommonWidgets.verticalSpacerWidget(
//                                     height * 0.03),
//
//                                 /// Claimant Accepted to sign
//                                 // CommonWidgets.textDisplay(
//                                 //     // state.labels?.locale.exceptionalApproval ??
//                                 //     //     state.labels?.defaultLocale
//                                 //     //         .exceptionalApproval ??
//                                 //     Constants.isclaimantacceptedtosign,
//                                 //     isMandatory: true,
//                                 //     const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
//                                 // RadioButtonsYesNo(
//                                 //     status: state.model.status ?? 0,
//                                 //     selectedValue:
//                                 //         state.model.claimantNoSign ? 1 : 0,
//                                 //     onChangedYes: isReadOnly
//                                 //         ? null
//                                 //         : (val) {
//                                 //             state.model.claimantNoSign = true;
//                                 //             BlocProvider.of<
//                                 //                         ArticleFoundDetailsCubit>(
//                                 //                     context)
//                                 //                 .onCheckBoxChange(state.model);
//                                 //           },
//                                 //     onChangedNo: isReadOnly
//                                 //         ? null
//                                 //         : (val) {
//                                 //             state.model.claimantNoSign = false;
//                                 //             BlocProvider.of<
//                                 //                         ArticleFoundDetailsCubit>(
//                                 //                     context)
//                                 //                 .onCheckBoxChange(state.model);
//                                 //           }),
//                                 // CommonWidgets.verticalSpacerWidget(
//                                 //     height * 0.03),
//
//                                 // if (widget.model?.claimantNoSign == false) ...[
//                                 //   /// Claimant Confirmed by Email
//                                 //   CommonWidgets.textDisplay(
//                                 //       // state.labels?.locale.exceptionalApproval ??
//                                 //       //     state.labels?.defaultLocale
//                                 //       //         .exceptionalApproval ??
//                                 //       Constants.isclaimantacceptedbyemail,
//                                 //       isMandatory: true,
//                                 //       const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
//                                 //   RadioButtonsYesNo(
//                                 //     status: state.model.status ?? 0,
//                                 //     selectedValue:
//                                 //         state.model.claimantConfirmByEmail
//                                 //             ? 1
//                                 //             : 0,
//                                 //     onChangedYes: null,
//                                 //     // onChangedYes: isReadOnly
//                                 //     //     ? null
//                                 //     //     : (val) {
//                                 //     //   // state.model.claimantConfirmByEmail= true;
//                                 //     //   BlocProvider.of<
//                                 //     //       ArticleFoundDetailsCubit>(
//                                 //     //       context)
//                                 //     //       .onCheckBoxChange(state.model);
//                                 //     // },
//                                 //     onChangedNo: null,
//                                 //     // isReadOnly
//                                 //     //     ? null
//                                 //     //     : (val) {
//                                 //     //   // state.model.claimantConfirmByEmail = false;
//                                 //     //   BlocProvider.of<
//                                 //     //       ArticleFoundDetailsCubit>(
//                                 //     //       context)
//                                 //     //       .onCheckBoxChange(state.model);
//                                 //     // }
//                                 //   ),
//                                 //   CommonWidgets.verticalSpacerWidget(
//                                 //       height * 0.03),
//                                 // ]
//                               ],
//
//                               if (widget.model?.claimantDbEmp == false) ...[
//                                 /// Claimant
//                                 CommonWidgets.textDisplay(
//                                   // state.labels?.locale.companyName ??
//                                   //     state.labels?.defaultLocale.companyName ??
//                                   Constants.claimant,
//                                   const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                   isMandatory: true,
//                                 ),
//                                 CommonWidgets.verticalSpacerWidget(
//                                     height * 0.001),
//                                 FlutterInputField(
//                                   textInputType: TextInputType.text,
//                                   textFormKey: Keys.challanKey,
//                                   controller: claimantTextController,
//                                   characterLimit:
//                                   Constants.characterLimitIdTextFormField,
//                                   hintText: '',
//                                   isEnable: showSaveSubmitButtons,
//                                   isDisableColor: !showSaveSubmitButtons,
//                                   onChange: (String value) {
//                                     state.model.claimant?.name = value;
//                                     state.model.claimantName = value;
//                                     context
//                                         .read<ArticleFoundDetailsCubit>()
//                                         .onModelValueChange(state.model);
//                                   },
//                                   validateTextField: (String? user) {},
//                                 ),
//                                 CommonWidgets.verticalSpacerWidget(
//                                     height * 0.02),
//                               ],
//                             ],
//
//                             if(state.model.status !=0 && state.model.status !=null)...[
//                               /// Claimant Signature
//                               buildSignature(
//                                   controller: claimantSignatureController,
//                                   label:
//                                   // state.labels?.locale.entrySecuritySign ??
//                                   //     state.labels?.defaultLocale
//                                   //         .entrySecuritySign ??
//                                   Constants.claimantSignature,
//                                   spaceHeight: height,
//                                   state: state, isMandatory: true
//                               ),
//                             ],
//
//
//                             CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                             if( state.model.status == 2)...[
//                               /// Handover By
//                               CommonWidgets.horizontalTextHandling(
//                                 // state.labels?.locale.entrySecurity ??
//                                 //     state.labels?.defaultLocale.entrySecurity ??
//                                   Constants.handoverBy,
//                                   isMandatory: true,
//                                   '${state.model.handOverSecurityName}'),
//                               CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//                               /// Handover Date
//                               CommonWidgets.textDisplay(
//                                 // state.labels?.locale.inputDate ??
//                                 //     state.labels?.defaultLocale.inputDate ??
//                                 Constants.handedOverDate,
//                                 const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//                                 isMandatory: true,
//                               ),
//                               CommonWidgets.verticalSpacerWidget(height * 0.001),
//                               dateCreateWidgetDisplay(
//                                   state.model.handoverDate ?? ''),
//                               CommonWidgets.verticalSpacerWidget(height * 0.03),
//                             ],
//                             ///Upload Image
//                             CommonWidgets.textDisplay(
//                               // state.labels?.locale.evidenceInfo ??
//                               //     state.labels?.defaultLocale.evidenceInfo ??
//                                 Constants.evidenceDocuments,
//                                 const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
//                             widget.model == null
//                                 ? CommonWidgets.verticalSpacerWidget(
//                                 height * 0.001)
//                                 : Container(),
//                             if (state.model.status == 0 ||
//                                 state.model.status == null) ...[
//                               BaseImageUpload().uploadWidget(
//                                 context: context,
//                                 isDisabled: isReadOnly,
//                                 loggedInUserDetails: state.loggedInUserDetails!,
//                                 getFiles: uploadFiles,
//                                 onImageSelected: (ImageContent data) {
//                                   List<ImageContent>? files = [];
//                                   files.add(data);
//                                   for (ImageContent image in uploadFiles) {
//                                     files.add(image);
//                                   }
//                                   BlocProvider.of<ArticleFoundDetailsCubit>(
//                                       context)
//                                       .addAttachment(
//                                     data: files,
//                                     images: files,
//                                   );
//                                 },
//                               ),
//                             ],
//                             CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//
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
//                                   moduleCode: Constants.articleFoundModuleCode,
//                                   isDisabled: isReadOnly,
//                                   showDeleteIcon: state.model.status == null ||
//                                       state.model.status ==
//                                           ConstantsIntValue.mmStatusDraft,
//                                 ),
//                               ),
//                             ),
//                             CommonWidgets.verticalSpacerWidget(height * 0.02),
//
//
//                             CommonWidgets.verticalSpacerWidget(height * 0.03),
//
//
//                             /// SubmitButton
//                             if (showSaveSubmitButtons) ...[
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   cancelButtonDisplay(),
//                                   if (showSaveSubmitButtons) ...[
//                                     submitButtonDisplay(state)
//                                   ],
//                                 ],
//                               ),
//                             ],
//                           ],
//                         ),
//
//                       ),
//
//                       /// Kept outside AbsorbPointer so the close button stays tappable
//                       if (!showSaveSubmitButtons) ...[
//                         Center(
//                           child: cancelButtonDisplay(),
//                         ),
//                         CommonWidgets.verticalSpacerWidget(height * 0.04),
//                       ],
//                       CommonWidgets.verticalSpacerWidget(height * 0.04),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       // ),
//     ]);
//   }
//
//
//
//
//   Widget buildSignature({
//     required SignatureController controller,
//     required String label,
//     required double spaceHeight,
//     required ArticleFoundDetailsState state,
//     required bool isMandatory,
//   }) {
//     final bool isEditable = state.isReceiverSignEditable ?? false;
//     final bool isSigned = state.model.claimantSign != null &&
//         !state.model.claimantSign!.imageContent.isEmptyOrNull;
//
//     return AbsorbPointer(
//       absorbing: !(state.model.lock.isEmptyOrNull && state.model.status == 1),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   CommonWidgets.textDisplay(label, const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)),
//                   if (isMandatory)
//                     const Text(' *', style: TextStyle(color: Colors.red)),
//                 ],
//               ),
//               Row(
//                 children: [
//                   state.model.status == 1 && state.model.lock.isEmptyOrNull
//                       ? IconButton(
//                     onPressed: () {
//                       controller.clear();
//                       BlocProvider.of<ArticleFoundDetailsCubit>(context).clearSign();
//                     },
//                     iconSize: 20,
//                     color: Colors.black,
//                     icon: const Icon(Icons.refresh),
//                   )
//                       : SizedBox.fromSize(),
//                 ],
//               ),
//             ],
//           ),
//           CommonWidgets.verticalSpacerWidget(spaceHeight * 0.001),
//           ClipRect(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(2.0),
//                 border: Border.all(
//                   color: AppColors.geryLightBackground,
//                   width: 1,
//                 ),
//               ),
//               height: 120,
//               width: double.infinity,
//               child: (!isEditable && isSigned)
//                   ? Image.memory(
//                 Uint8List.fromList(
//                   base64Decode(state.model.claimantSign!.imageContent ?? ''),
//                 ),
//                 fit: BoxFit.none,
//               )
//                   : Signature(
//                 controller: controller,
//                 backgroundColor: Colors.transparent,
//               ),
//             ),
//           ),
//           CommonWidgets.verticalSpacerWidget(spaceHeight * 0.01),
//         ],
//       ),
//     );
//   }
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
//             claimantSignatureController: claimantSignatureController
//         );
//       },
//     );
//   }
//
//   Widget dateCreateWidgetDisplay(String date) {
//     return FlutterInputField(
//       textFormKey: Keys.dateofcreationTextController,
//       showBorder: true,
//       initialValue: date,
//       hintText: '',
//       isEnable: false,
//       isDisableColor: false,
//       onChange: (String value) {},
//       validateTextField: (String? user) {},
//     );
//   }
// }
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found/article_found_details/cubits/article_found_details_cubit.dart';
import 'package:db_atom/src/features/article_found/models/article_found_model.dart';

/// Visual theme for this screen (UI only).
class _Ui {
  static const Color indigo = Color(0xFF150A78);
  static const Color indigoDark = Color(0xFF0B0545);
  static const Color gold = Color(0xFFD4A98A);
  static const Color goldLight = Color(0xFFE9CDB6);
  static const Color pageBg = Color(0xFFF4F3FB);
  static const Color cardBorder = Color(0xFFE6E3F5);
  static const Color fieldFill = Color(0xFFEFEBFB);
  static const Color fieldFillDisabled = Color(0xFFF4F2FA);
  static const Color fieldBorder = Color(0xFFC9C2EA);
  static const Color fieldBorderDisabled = Color(0xFFDDD8F2);
  static const Color hint = Color(0xFF6E65B5);

  static const LinearGradient indigoGradient = LinearGradient(
    colors: [indigo, indigoDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldLight, gold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const TextStyle labelStyle = TextStyle(
    color: indigo,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle valueStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
}

// ---------------------------------------------------------------------------
// Reusable UI pieces
// ---------------------------------------------------------------------------

/// Tap-to-select field (replaces the old dark TextFieldAddButton look).
class _SelectorField extends StatelessWidget {
  final String? title;
  final String placeholder;
  final bool isDisabled;
  final VoidCallback onTap;

  const _SelectorField({
    required this.title,
    required this.isDisabled,
    required this.onTap,
    this.placeholder = 'Select',
  });

  @override
  Widget build(BuildContext context) {
    final hasTitle = title != null && title!.trim().isNotEmpty;

    return Material(
      color: isDisabled ? _Ui.fieldFillDisabled : _Ui.fieldFill,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDisabled ? _Ui.fieldBorderDisabled : _Ui.fieldBorder,
          width: 1.2,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 56),
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hasTitle ? title! : placeholder,
                  style: hasTitle
                      ? _Ui.valueStyle
                      : const TextStyle(color: _Ui.hint, fontSize: 15),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  gradient: isDisabled ? null : _Ui.indigoGradient,
                  color: isDisabled ? _Ui.fieldBorderDisabled : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Read-only value box (used for "Created By", "Sl No." etc.).
class _ReadOnlyField extends StatelessWidget {
  final String value;

  const _ReadOnlyField({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 52),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _Ui.fieldFillDisabled,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _Ui.fieldBorderDisabled, width: 1.2),
      ),
      child: Text(value.trim(), style: _Ui.valueStyle),
    );
  }
}

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class ArticleFoundDetailsView extends StatefulWidget {
  final ArticleFoundModel? model;
  final String title;
  final ExtraProperties? extraProperties;
  final int? eventId; // For creating Article Found inside Event Protection
  final String?
  eventProtectionId; // For creating Article Found inside Event Protection
  final Organisation? eventProtectionLocation;
  final bool viaEvent;

  const ArticleFoundDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
    this.eventId,
    this.eventProtectionId,
    this.eventProtectionLocation,
    required this.viaEvent,
  });

  @override
  State<ArticleFoundDetailsView> createState() =>
      _ArticleFoundDetailsViewState();
}

class _ArticleFoundDetailsViewState extends State<ArticleFoundDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController statusController = TextEditingController();
  final TextEditingController foundDateController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController foundLocationController =
  TextEditingController();
  final TextEditingController depositorController = TextEditingController();
  final TextEditingController depositorTextController =
  TextEditingController();
  final TextEditingController claimantController = TextEditingController();
  final TextEditingController claimantTextController =
  TextEditingController();
  final TextEditingController safeStoragePlaceController =
  TextEditingController();
  final TextEditingController assetTypeController = TextEditingController();
  final SignatureController claimantSignatureController =
  SignatureController();
  final FocusNode sentToFocusNode = FocusNode();

  bool isReadOnly = false;
  bool ignorePointer = false;
  bool showSaveSubmitButtons = false;
  bool lock = false;
  bool editFields = false;
  List<ImageContent> uploadFiles = [];

  ArticleFoundDetailsCubit get _cubit =>
      BlocProvider.of<ArticleFoundDetailsCubit>(context);

  @override
  void initState() {
    super.initState();
    _cubit.initializeValues();
  }

  @override
  void dispose() {
    statusController.dispose();
    foundDateController.dispose();
    colorController.dispose();
    foundLocationController.dispose();
    depositorController.dispose();
    depositorTextController.dispose();
    claimantController.dispose();
    claimantTextController.dispose();
    safeStoragePlaceController.dispose();
    assetTypeController.dispose();
    claimantSignatureController.dispose();
    sentToFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('---viaEvent-----${widget.viaEvent}-----');
    final double height = MediaQuery.of(context).size.height;

    return BlocConsumer<ArticleFoundDetailsCubit, ArticleFoundDetailsState>(
      listener: (context, state) {
        log('-state.status--${state.status}--');
        log('123 ${state.message}--');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.articleFoundRegisterListTitle,
            message: state.message,
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              Navigator.pop(context); // close the dialog

              if (widget.viaEvent) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushNamed(context, articleFoundNewListRoute);
              }
            },
          );
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => dialog,
          );
          return;
        }
      },
      builder: (context, state) {
        depositorController.text =
        '${state.model.depositor?.firstName ?? ''} ${state.model.depositor?.lastName ?? ''}';
        depositorTextController.text = state.model.depositorName ?? '';
        colorController.text = state.model.color ?? '';
        foundLocationController.text = state.model.foundLocation ?? '';
        claimantController.text =
        '${state.model.claimant?.firstName ?? ''} ${state.model.claimant?.lastName ?? ''}';
        claimantTextController.text = state.model.claimantName ?? '';
        safeStoragePlaceController.text = state.model.safeStoragePlace ?? '';

        if (state.model.status == 0 && !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 1 && !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status != null &&
            state.model.status != 0 &&
            state.model.status != 1) {
          isReadOnly = true;
        }
        if (state.model.status == 1) {
          isReadOnly = true;
        }

        showSaveSubmitButtons = (widget.model == null ||
            state.model.status == 0 ||
            state.model.status == 1) &&
            state.model.lock.isEmptyOrNull;

        editFields = (widget.model == null || state.model.status == 0) &&
            state.model.lock.isEmptyOrNull;

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton:
            showSaveSubmitButtons && state.status != FormStatus.loading,
            pdfAPIName:
            '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.articleFoundModuleCode}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              _cubit.submitForm(
                claimantSignatureController: claimantSignatureController,
                isSaveOnly: true,
              );
            },
            showSubmitButton:
            showSaveSubmitButtons && state.status != FormStatus.loading,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              _cubit.submitForm(
                isSaveOnly: false,
                claimantSignatureController: claimantSignatureController,
              );
            },
            showLikeButton: false,
            showDisLikeButton: false,
          ),
          backgroundColor: _Ui.pageBg,
          body: getBodybuilder(state, height),
        );
      },
    );
  }

  void initializeDates(ArticleFoundDetailsState state) {
    foundDateController.text = state.model.foundDate != null
        ? Utils.timestampToDateConversion(
        int.tryParse(state.model.foundDate ?? '') ??
            DateTime.now()
                .millisecondsSinceEpoch, // Use current timestamp if null
        Constants.fulldateFormat)
        : '';
  }

  /// Builds a "Name (email)" string, only showing the parts that have data.
  String _displayNameEmail(String? name, String? email) {
    final hasName = name != null && name.trim().isNotEmpty;
    final hasEmail = email != null && email.trim().isNotEmpty;

    if (!hasName && !hasEmail) return '';
    if (hasName && hasEmail) return '$name ($email)';
    if (hasName) return name;
    return email!;
  }

  // -------------------------------------------------------------------------
  // Body
  // -------------------------------------------------------------------------

  Widget getBodybuilder(ArticleFoundDetailsState state, double height) {
    initializeDates(state);
    final articleName = state.model.typeOfArticle?.name?.toLowerCase() ?? '';

    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      uploadFiles = state.uploadAttachments;
      uploadFiles = state.model.images ?? [];
    }

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        autovalidateMode: isReadOnly
            ? AutovalidateMode.disabled
            : AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AbsorbPointer(
                absorbing: !showSaveSubmitButtons && !ignorePointer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!state.model.lock.isEmptyOrNull)
                      RecordLockedWidget(text: '${state.model.lock}'),

                    _generalSection(state),
                    _articleSection(state, articleName),
                    _depositorSection(state),
                    if (widget.model?.status != null &&
                        widget.model?.status != 0)
                      _claimantSection(state),
                    if (state.model.status != 0 && state.model.status != null)
                      _signatureSection(state, height),
                    if (state.model.status == 2) _handoverSection(state),
                    _evidenceSection(state, height),

                    /// Submit buttons
                    if (showSaveSubmitButtons) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cancelButtonDisplay(),
                          submitButtonDisplay(state),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              /// Kept outside AbsorbPointer so the close button stays tappable
              if (!showSaveSubmitButtons) ...[
                Center(child: cancelButtonDisplay()),
              ],
              SizedBox(height: height * 0.06),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Sections
  // -------------------------------------------------------------------------

  Widget _generalSection(ArticleFoundDetailsState state) {
    return _section(
      icon: Icons.info_outline_rounded,
      title: Constants.generalinformation,
      children: [
        /// Status
        _field(
          Constants.status,
          BaseDropDown().getDropDown(
            isDisabled: false,
            textController: statusController,
            items: articleFoundStatus,
            initialValue: '${state.model.status ?? 0}',
            onTap: () {},
          ),
        ),

        /// Created By
        _field(
          Constants.createdby,
          _ReadOnlyField(
            value:
            '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}',
          ),
        ),

        /// Location
        _field(
          Constants.location,
          BaseLocationDropdown().locationWidgetDisplay(
            isEnabled: (!isReadOnly) && !lock && !widget.viaEvent,
            context: context,
            locations: state.locations ?? Locations(),
            selectedLocationName: state.model.location?.name ?? '',
            onTap: (Organisation? location) {
              _cubit.updateLocationDropdownValue(location: location);
            },
          ),
        ),

        /// Location Type
        _field(
          Constants.locationType,
          _SelectorField(
            title: state.model.locationType?.name,
            isDisabled: isReadOnly,
            onTap: () {
              if (!isReadOnly) {
                BaseOrganisationDialog().departmentDialog(
                  context: context,
                  organisations:
                  state.getLocationType.getLocationType ?? [],
                  onTap: (Organisation locationType) {
                    _cubit.updateDropdownValues(locationType: locationType);
                  },
                  leftImage: false,
                  createEntity: false,
                  functionToCall: () {
                    _cubit.refreshList();
                  },
                );
              }
            },
          ),
        ),

        /// Date of creation
        _field(
          Constants.dateofcreation,
          dateCreateWidgetDisplay(state.model.inputDate ?? ''),
        ),

        /// Sl No.
        _field(
          Constants.slno,
          _ReadOnlyField(value: state.model.slNo ?? ''),
        ),
      ],
    );
  }

  Widget _articleSection(ArticleFoundDetailsState state, String articleName) {
    return _section(
      icon: Icons.inventory_2_outlined,
      title: 'Article Details',
      children: [
        /// Safe Storage Place
        _field(
          Constants.safeStoragePlace,
          FlutterInputField(
            textInputType: TextInputType.text,
            textFormKey: Keys.challanKey,
            controller: safeStoragePlaceController,
            characterLimit: Constants.characterLimitIdTextFormField,
            hintText: '',
            isEnable: showSaveSubmitButtons,
            isDisableColor: !showSaveSubmitButtons,
            onChange: (String value) {
              state.model.safeStoragePlace = value;
              context
                  .read<ArticleFoundDetailsCubit>()
                  .onModelValueChange(state.model);
            },
            validateTextField: (String? user) {},
          ),
        ),

        /// Article Type
        _field(
          Constants.articleType,
          _SelectorField(
            title: state.model.typeOfArticle?.name,
            isDisabled: isReadOnly,
            onTap: () {
              if (!isReadOnly) {
                BaseOrganisationDialog().departmentDialog(
                  context: context,
                  organisations: state.articleType,
                  onTap: (Organisation articleType) {
                    _cubit.updateDropdownValues(articleType: articleType);
                  },
                  leftImage: false,
                  functionToCall: () {
                    _cubit.refreshList();
                  },
                );
              }
            },
          ),
        ),

        /// Asset Type
        _field(
          Constants.assetType,
          BaseDropDown().getDropDown(
            isDisabled: true,
            textController: assetTypeController,
            items: assetTypeValues,
            initialValue: '${state.model.typeOfAsset ?? 0}',
            onTap: () {
              if (!isReadOnly) {
                BaseDropDown().assetTypeDialog(
                  context: context,
                  dropDownValues:
                  assetTypeValues.map((label) => label.key).toList(),
                  onTap: (String value) {
                    final Label selectedLabel = assetTypeValues.firstWhere(
                          (label) => label.key == value,
                      orElse: () => const Label(key: '', value: ''),
                    );

                    _cubit.updateDropdownValues(
                      assetType: int.tryParse(selectedLabel.value),
                    );
                    widget.model?.typeOfAsset =
                        int.tryParse(selectedLabel.value);
                  },
                );
              }
            },
          ),
        ),

        /// ID-card specific fields
        if (articleName.contains('id') || articleName.contains('card')) ...[
          /// Manager Name
          _field(
            Constants.managerName,
            _SelectorField(
              title: _displayNameEmail(
                state.model.idCardManager?.userInfo,
                state.model.idCardManager?.email,
              ),
              isDisabled: !editFields,
              onTap: () {
                if (editFields) {
                  _openUserDialog(
                    state: state,
                    employeeId: false,
                    users: () => state.idCardManger,
                    onUserSelected: (BaseUser user) {
                      _cubit.updateDropdownValues(idCardManager: user);
                    },
                  );
                }
              },
            ),
          ),

          /// Employee Name
          _field(
            Constants.employeeName,
            _SelectorField(
              title: _displayNameEmail(
                state.model.idCardEmployee?.userInfo,
                state.model.idCardEmployee?.email,
              ),
              isDisabled: !editFields,
              onTap: () {
                if (editFields) {
                  _openUserDialog(
                    state: state,
                    employeeId: false,
                    users: () => state.idCardEmployee,
                    onUserSelected: (BaseUser user) {
                      _cubit.updateDropdownValues(idCardEmployee: user);
                    },
                  );
                }
              },
            ),
          ),
        ],

        /// Found Date
        _field(
          Constants.founddate,
          BaseDate().datePickerWidgetLoading(
            textController: foundDateController,
            isDisabled: isReadOnly,
            onlyDate: false,
            showPastDate: true,
            showFutureDate: false,
            onChange: (String value) {
              foundDateController.text = value;
              state.model.foundDate = Utils().formatTime(value);
              _cubit.onModelValueChange(state.model);
            },
            context: context,
          ),
        ),

        /// Found Location
        _field(
          Constants.foundLocation,
          FlutterInputField(
            textInputType: TextInputType.text,
            textFormKey: Keys.challanKey,
            controller: foundLocationController,
            characterLimit: Constants.characterLimitIdTextFormField,
            hintText: '',
            isEnable: !isReadOnly,
            isDisableColor: isReadOnly,
            onChange: (String value) {
              state.model.foundLocation = value;
              context
                  .read<ArticleFoundDetailsCubit>()
                  .onModelValueChange(state.model);
            },
            validateTextField: (String? user) {},
          ),
        ),

        /// Additional Information
        _field(
          Constants.additionalinformation,
          FlutterInputField(
            lineHeight: 5,
            characterLimit: Constants.characterLimitDescTextFormField,
            initialValue: state.model.additionalInformation,
            textFormKey: Keys.premisesRoundTknCommentsKey,
            hintText: Constants.informationhere,
            showBorder: true,
            textInputAction: TextInputAction.newline,
            textInputType: TextInputType.multiline,
            isEnable: !isReadOnly,
            isDisableColor: isReadOnly,
            onChange: (String value) {
              state.model.additionalInformation = value;
              context
                  .read<ArticleFoundDetailsCubit>()
                  .onModelValueChange(state.model);
            },
            validateTextField: (String? user) {},
          ),
          mandatory: false,
        ),

        /// Quantity
        _field(
          Constants.quantity,
          FlutterInputField(
            textInputType: TextInputType.number,
            textFormKey: Keys.challanKey,
            initialValue: '${state.model.quantity ?? ''}',
            characterLimit: Constants.characterLimitIdTextFormField,
            hintText: '',
            isEnable: !isReadOnly,
            isDisableColor: isReadOnly,
            onChange: (String value) {
              state.model.quantity = int.tryParse(value);
              context
                  .read<ArticleFoundDetailsCubit>()
                  .onModelValueChange(state.model);
            },
            validateTextField: (String? user) {},
          ),
        ),

        /// Colour
        _field(
          Constants.colour,
          FlutterInputField(
            textInputType: TextInputType.text,
            textFormKey: Keys.challanKey,
            controller: colorController,
            characterLimit: Constants.characterLimitIdTextFormField,
            hintText: '',
            isEnable: !isReadOnly,
            isDisableColor: isReadOnly,
            onChange: (String value) {
              state.model.color = value;
              context
                  .read<ArticleFoundDetailsCubit>()
                  .onModelValueChange(state.model);
            },
            validateTextField: (String? user) {},
          ),
        ),

        /// Article Category
        _field(
          Constants.articleCategory,
          _SelectorField(
            title: state.model.articleCategory?.name,
            isDisabled: isReadOnly,
            onTap: () {
              if (!isReadOnly) {
                BaseOrganisationDialog().departmentDialog(
                  context: context,
                  organisations: state.articleCategory,
                  onTap: (Organisation articleCategory) {
                    _cubit.updateDropdownValues(
                      articleCategory: articleCategory,
                    );
                  },
                  leftImage: false,
                  functionToCall: () {
                    _cubit.refreshList();
                  },
                );
              }
            },
          ),
        ),

        /// Approximate Value (INR)
        _field(
          Constants.approximateValue,
          FlutterInputField(
            textInputType: TextInputType.number,
            textFormKey: Keys.challanKey,
            initialValue: state.model.approximateValue ?? '',
            characterLimit: Constants.characterLimitIdTextFormField,
            hintText: '',
            isEnable: !isReadOnly,
            isDisableColor: isReadOnly,
            onChange: (String value) {
              state.model.approximateValue = value;
              context
                  .read<ArticleFoundDetailsCubit>()
                  .onModelValueChange(state.model);
            },
            validateTextField: (String? user) {},
          ),
        ),
      ],
    );
  }

  Widget _depositorSection(ArticleFoundDetailsState state) {
    return _section(
      icon: Icons.person_outline_rounded,
      title: 'Depositor Details',
      children: [
        /// Is depositor a company employee
        _field(
          Constants.isdepositordbemployee,
          RadioButtonsYesNo(
            status: state.model.status ?? 0,
            selectedValue: state.model.depositorDbEmp ? 1 : 0,
            onChangedYes: isReadOnly
                ? null
                : (val) {
              state.model.depositorDbEmp = true;
              _cubit.onCheckBoxChange(state.model);
            },
            onChangedNo: isReadOnly
                ? null
                : (val) {
              state.model.depositorDbEmp = false;
              _cubit.onCheckBoxChange(state.model);
            },
          ),
        ),

        if (state.model.depositorDbEmp == true) ...[
          /// Depositor Employee Id
          _field(
            Constants.depositoremployeeid,
            _SelectorField(
              title: state.model.depositor?.employeeId,
              isDisabled: !editFields,
              onTap: () {
                if (editFields) {
                  _openUserDialog(
                    state: state,
                    employeeId: true,
                    users: () => state.employee!,
                    onUserSelected: (BaseUser user) {
                      _cubit.updateDropdownValues(employee: user);
                    },
                  );
                }
              },
            ),
          ),

          /// Depositor
          _field(
            Constants.depositor,
            FlutterInputField(
              controller: depositorController,
              textInputType: TextInputType.text,
              textFormKey: Keys.contactNoKey,
              hintText: '',
              isEnable: false,
              isDisableColor: true,
              onChange: (String value) {},
              validateTextField: (String? user) {},
            ),
          ),

          /// Depositor Department
          _field(
            Constants.department,
            _SelectorField(
              title: state.model.depositorDepartment?.name,
              isDisabled: !editFields,
              onTap: () {
                if (editFields) {
                  BaseOrganisationDialog().departmentDialog(
                    context: context,
                    organisations: state.departments,
                    onTap: (Organisation department) {
                      state.model.depositorDepartment?.name = department.name;
                      _cubit.updateDropdownValues(department: department);
                    },
                    createEntity: false,
                    functionToCall: () {
                      _cubit.refreshList();
                    },
                  );
                  FocusScope.of(context).requestFocus(sentToFocusNode);
                }
              },
            ),
          ),
        ],

        if (state.model.depositorDbEmp == false)
        /// Depositor (free text)
          _field(
            Constants.depositor,
            FlutterInputField(
              textInputType: TextInputType.text,
              textFormKey: Keys.challanKey,
              controller: depositorTextController,
              characterLimit: Constants.characterLimitIdTextFormField,
              hintText: '',
              isEnable: !isReadOnly,
              isDisableColor: isReadOnly,
              onChange: (String value) {
                state.model.depositor?.name = value;
                state.model.depositorName = value;
                context
                    .read<ArticleFoundDetailsCubit>()
                    .onModelValueChange(state.model);
              },
              validateTextField: (String? user) {},
            ),
          ),
      ],
    );
  }

  Widget _claimantSection(ArticleFoundDetailsState state) {
    return _section(
      icon: Icons.badge_outlined,
      title: 'Claimant Details',
      children: [
        /// Is claimant a company employee
        _field(
          Constants.isclaimantdbemployee,
          RadioButtonsYesNo(
            status: state.model.status ?? 0,
            selectedValue: state.model.claimantDbEmp ? 1 : 0,
            onChangedYes: widget.model?.status != 1
                ? null
                : (val) {
              state.model.claimantDbEmp = true;
              _cubit.onCheckBoxChange(state.model);
            },
            onChangedNo: widget.model?.status != 1
                ? null
                : (val) {
              state.model.claimantDbEmp = false;
              _cubit.onCheckBoxChange(state.model);
            },
          ),
        ),

        if (widget.model?.claimantDbEmp == true) ...[
          /// Claimant Employee Id
          _field(
            Constants.claimantemployeeid,
            _SelectorField(
              title: state.model.claimant?.employeeId,
              isDisabled: !showSaveSubmitButtons,
              onTap: () {
                if (showSaveSubmitButtons) {
                  _openUserDialog(
                    state: state,
                    employeeId: true,
                    users: () => state.claimant!,
                    onUserSelected: (BaseUser user) {
                      _cubit.updateDropdownValues(claimant: user);
                    },
                  );
                }
              },
            ),
          ),

          /// Claimant
          _field(
            Constants.claimant,
            FlutterInputField(
              controller: claimantController,
              textInputType: TextInputType.text,
              textFormKey: Keys.contactNoKey,
              hintText: '',
              isEnable: false,
              isDisableColor: true,
              onChange: (String value) {},
              validateTextField: (String? user) {},
            ),
          ),

          /// Claimant Department
          _field(
            Constants.claimantdepartment,
            _SelectorField(
              title: state.model.claimantDepartment?.name,
              isDisabled: !showSaveSubmitButtons,
              onTap: () {
                if (showSaveSubmitButtons) {
                  BaseOrganisationDialog().departmentDialog(
                    context: context,
                    organisations: state.departments,
                    onTap: (Organisation department) {
                      state.model.claimantDepartment?.name = department.name;
                      _cubit.updateDropdownValues(
                        claimantDepartment: department,
                      );
                    },
                    createEntity: false,
                    functionToCall: () {
                      _cubit.refreshList();
                    },
                  );
                  FocusScope.of(context).requestFocus(sentToFocusNode);
                }
              },
            ),
          ),
        ],

        if (widget.model?.claimantDbEmp == false)
        /// Claimant (free text)
          _field(
            Constants.claimant,
            FlutterInputField(
              textInputType: TextInputType.text,
              textFormKey: Keys.challanKey,
              controller: claimantTextController,
              characterLimit: Constants.characterLimitIdTextFormField,
              hintText: '',
              isEnable: showSaveSubmitButtons,
              isDisableColor: !showSaveSubmitButtons,
              onChange: (String value) {
                state.model.claimant?.name = value;
                state.model.claimantName = value;
                context
                    .read<ArticleFoundDetailsCubit>()
                    .onModelValueChange(state.model);
              },
              validateTextField: (String? user) {},
            ),
          ),
      ],
    );
  }

  Widget _signatureSection(ArticleFoundDetailsState state, double height) {
    return _section(
      icon: Icons.draw_outlined,
      title: Constants.claimantSignature,
      children: [
        buildSignature(
          controller: claimantSignatureController,
          label: Constants.claimantSignature,
          spaceHeight: height,
          state: state,
          isMandatory: true,
        ),
      ],
    );
  }

  Widget _handoverSection(ArticleFoundDetailsState state) {
    return _section(
      icon: Icons.handshake_outlined,
      title: 'Handover Details',
      children: [
        /// Handover By
        _field(
          Constants.handoverBy,
          _ReadOnlyField(value: '${state.model.handOverSecurityName}'),
        ),

        /// Handover Date
        _field(
          Constants.handedOverDate,
          dateCreateWidgetDisplay(state.model.handoverDate ?? ''),
        ),
      ],
    );
  }

  Widget _evidenceSection(ArticleFoundDetailsState state, double height) {
    return _section(
      icon: Icons.attach_file_rounded,
      title: Constants.evidenceDocuments,
      children: [
        /// Upload Image
        if (state.model.status == 0 || state.model.status == null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BaseImageUpload().uploadWidget(
              context: context,
              isDisabled: isReadOnly,
              loggedInUserDetails: state.loggedInUserDetails!,
              getFiles: uploadFiles,
              onImageSelected: (ImageContent data) {
                List<ImageContent>? files = [];
                files.add(data);
                for (ImageContent image in uploadFiles) {
                  files.add(image);
                }
                _cubit.addAttachment(
                  data: files,
                  images: files,
                );
              },
            ),
          ),

        /// Attachments
        IgnorePointer(
          ignoring: false,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: BaseImageUpload().getAttachment(
              height: height,
              attachments: state.uploadAttachments,
              files: uploadFiles,
              moduleCode: Constants.articleFoundModuleCode,
              isDisabled: isReadOnly,
              showDeleteIcon: state.model.status == null ||
                  state.model.status == ConstantsIntValue.mmStatusDraft,
            ),
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Shared helpers
  // -------------------------------------------------------------------------

  /// Opens the user picker dialog and wires up selection + list refresh.
  void _openUserDialog({
    required ArticleFoundDetailsState state,
    required bool employeeId,
    required dynamic Function() users,
    required void Function(BaseUser user) onUserSelected,
  }) {
    BaseOrganisationDialog().userDialog(
      employeeId: employeeId,
      context: context,
      users: users(),
      isDbUser: false,
      onTap: (BaseUser user) {
        onUserSelected(user);
      },
      roleName: ConstantUserRoles.atomStaticUser,
      locationId: state.model.location!.id!,
      functionToCall: (BaseUser user) {
        onUserSelected(user);
        // refresh the list
        _cubit.refreshList();
      },
    );
  }

  /// White rounded card with an icon header and a gold underline.
  Widget _section({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _Ui.cardBorder),
        boxShadow: [
          BoxShadow(
            color: _Ui.indigo.withValues(alpha: 0.07),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: _Ui.indigoGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: _Ui.goldLight, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: _Ui.indigo,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 2.5,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_Ui.gold, _Ui.gold.withValues(alpha: 0.0)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  /// A label (with optional red asterisk) above a field.
  Widget _field(String label, Widget child, {bool mandatory = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(label, mandatory: mandatory),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _label(String text, {bool mandatory = true}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(child: Text(text, style: _Ui.labelStyle)),
        if (mandatory)
          const Text(
            ' *',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
          ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Signature / buttons
  // -------------------------------------------------------------------------

  Widget buildSignature({
    required SignatureController controller,
    required String label,
    required double spaceHeight,
    required ArticleFoundDetailsState state,
    required bool isMandatory,
  }) {
    final bool isEditable = state.isReceiverSignEditable ?? false;
    final bool isSigned = state.model.claimantSign != null &&
        !state.model.claimantSign!.imageContent.isEmptyOrNull;

    return AbsorbPointer(
      absorbing: !(state.model.lock.isEmptyOrNull && state.model.status == 1),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _label(label, mandatory: isMandatory),
                if (state.model.status == 1 && state.model.lock.isEmptyOrNull)
                  GestureDetector(
                    onTap: () {
                      controller.clear();
                      _cubit.clearSign();
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: _Ui.indigoGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _Ui.fieldBorder, width: 1.2),
                ),
                height: 130,
                width: double.infinity,
                child: (!isEditable && isSigned)
                    ? Image.memory(
                  Uint8List.fromList(
                    base64Decode(
                      state.model.claimantSign!.imageContent ?? '',
                    ),
                  ),
                  fit: BoxFit.none,
                )
                    : Signature(
                  controller: controller,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
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

  Widget submitButtonDisplay(ArticleFoundDetailsState state) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        _cubit.submitForm(
          claimantSignatureController: claimantSignatureController,
        );
      },
    );
  }

  Widget dateCreateWidgetDisplay(String date) {
    return FlutterInputField(
      textFormKey: Keys.dateofcreationTextController,
      showBorder: true,
      initialValue: date,
      hintText: '',
      isEnable: false,
      isDisableColor: false,
      onChange: (String value) {},
      validateTextField: (String? user) {},
    );
  }
}