import 'dart:core';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/opacity_absorb_widget.dart';
// import 'package:quill_html_editor/quill_html_editor.dart';
// import 'package:html_editor_enhanced/html_editor.dart';
import 'package:html_editor_enhanced/html_editor.dart'; // includes HtmlEditor and HtmlEditorToolbar

class EventInfoView extends StatefulWidget {
  const EventInfoView({
    super.key,
    required this.title,
    required this.editForm,
    required this.isEventProtection,
    required this.eventProtectionId,
  });

  final String title;
  final bool editForm;
  final bool isEventProtection;
  final String eventProtectionId;

  @override
  State<EventInfoView> createState() => _EventInfoViewState();
}

class _EventInfoViewState extends State<EventInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final QuillEditorController quillController = QuillEditorController();
  final HtmlEditorController quillController = HtmlEditorController();


  User? userDetails;
  List<ImageContent>? guardFiles;
  TextEditingController dateController = TextEditingController();
  TextEditingController addEmailController = TextEditingController();

  bool showSaveButtons = false;

  String? initialisedFromDate;
  String? initialisedToDate;
  String? initialisedStartDate;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EventInfoCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    dateController.dispose();
    addEmailController.dispose();
    // quillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final height = size.height;

    return BlocConsumer<EventInfoCubit, EventInfoState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        // if (state.status == FormStatus.success) {
        //   ScaffoldMessenger.of(context)
        //       .showSnackBar(SnackBar(content: Text('${state.message}')));
        //   Navigator.pop(context);
        //   Navigator.pop(context);
        // }

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Event Protection',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.popAndPushNamed(
              //   context,
              //   keyManagementIssuanceListRoute,
              // );
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
        if (state.status == FormStatus.addArticleFound) {
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            articleFoundNewDetailsRoute,
            arguments: {
              ConstantsArgument.eventId: state.model.id,
              ConstantsArgument.eventProtectionId: widget.eventProtectionId,
            },
          );
        }
      },
      builder: (context, state) {
        if (state.eventDuration == ConstantsIntValue.eventDurationBefore) {
          if (!state.model.eventStartedAt.isEmptyOrNull &&
              dateController.text.isEmpty) {
            log('state.model.eventStartedAt--- ${state.model.eventStartedAt}');
            dateController.text = Utils.timestampToDateConversion(
                int.tryParse(state.model.eventStartedAt ?? '0'),
                Constants.fulldateFormat);
          }
          initialisedFromDate = DateTime.fromMillisecondsSinceEpoch(
              (int.tryParse('${state.model.startDate}') ?? 0) * 1000)
              .toString();
          initialisedStartDate = DateTime.fromMillisecondsSinceEpoch(
              (int.tryParse('${state.model.startDate}') ?? 0) * 1000)
              .toString();
          initialisedToDate = DateTime.fromMillisecondsSinceEpoch(
              (int.tryParse('${state.model.endDate}') ?? 0) * 1000)
              .toString();
          log('initialisedToDate--- $initialisedToDate');
          log('initialisedStartDate--- $initialisedStartDate');
          log('initialisedFromDate--- $initialisedFromDate');
        }

        if (state.eventDuration == ConstantsIntValue.eventDurationAfter) {
          if (!state.model.eventConcludedAt.isEmptyOrNull &&
              dateController.text.isEmpty) {
            log('state.model.eventConcludedAt--- ${state.model
                .eventConcludedAt}');
            dateController.text = Utils.timestampToDateConversion(
                int.tryParse(state.model.eventConcludedAt ?? 'null'),
                Constants.fulldateFormat);
          }
          initialisedFromDate = DateTime.fromMillisecondsSinceEpoch(
              (int.tryParse('${state.model.eventStartedAt}') ?? 0) * 1000)
              .toString();
          initialisedStartDate = DateTime.fromMillisecondsSinceEpoch(
              (int.tryParse('${state.model.eventStartedAt}') ?? 0) * 1000)
              .toString();
          DateTime currentDate = DateTime.now();
          DateTime newDateTime = currentDate.add(const Duration(days: 1));
          initialisedToDate = newDateTime.toString();
          log('initialisedToDate--- $initialisedToDate');
          log('initialisedStartDate--- $initialisedStartDate');
          log('initialisedFromDate--- $initialisedFromDate');
        }

        log('--widget.editForm---${widget.editForm}--');
        if (state.model.status != 4 && widget.editForm) {
          showSaveButtons = true;
        }

        if (!state.model.lock.isEmptyOrNull) {
          showSaveButtons = false;
        }
        // if(widget.editForm){
        //   showSaveButtons == true;
        // }

        log('-showSaveButtons-$showSaveButtons---');
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: showSaveButtons,
            showSubmitButton: showSaveButtons,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<EventInfoCubit>(context).submitForm(
                  isSaveOnly: true, updatedEmailText: updatedEmailText ?? '');
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<EventInfoCubit>(context).submitForm(
                  isSaveOnly: false, updatedEmailText: updatedEmailText ?? '');
            },
          ),
          backgroundColor: AppColors.newColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  String? updatedEmailText;

  getBodybuilder(EventInfoState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      guardFiles = state.guardAttachments ?? [];
    }

    return Container(
      color: AppColors.newColor3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.newColor3,
            ),
            Container(
              decoration: ShapeDecoration(
                  color: AppColors.newColor3,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.0)),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Form(
                    key: _formKey,
                    autovalidateMode: state.model.status == 30
                        ? AutovalidateMode.disabled
                        : AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        if (!state.model.lock.isEmptyOrNull) ...[
                          RecordLockedWidget(text: '${state.model.lock}'),
                        ],
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(
                            children: [
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Event Started At
                              if (state.eventDuration != 1) ...[
                                CommonWidgets.textDisplay(
                                  state.eventDuration == 0
                                      ? Constants.eventStartedAt
                                      : Constants.eventConcludedAt,
                                  Styles.textStyleWhite14,
                                ),
                                BaseDate().datePickerWidgetLoading(
                                  context: context,
                                  textController: dateController,
                                  isDisabled: !showSaveButtons,
                                  onlyDate: false,
                                  // startDate: DateTime
                                  //         .fromMillisecondsSinceEpoch(int.parse(
                                  //                 '${state.model.startDate}') *
                                  //             1000)
                                  //     .toString(),
                                  // fromDate: DateTime.fromMillisecondsSinceEpoch(
                                  //         int.parse(
                                  //                 '${state.model.startDate}') *
                                  //             1000)
                                  //     .toString(),
                                  // toDate: DateTime.fromMillisecondsSinceEpoch(
                                  //         int.parse('${state.model.endDate}') *
                                  //             1000)
                                  //     .toString(),
                                  startDate: initialisedStartDate,
                                  fromDate: initialisedFromDate,
                                  toDate: initialisedToDate,
                                  onChange: (String value) {
                                    dateController.text = value;
                                    log('dateControllerValue --- $value');
                                    state.model.date = value;
                                    BlocProvider.of<EventInfoCubit>(context)
                                        .onModelValueChange(state.model);
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],
                              CommonWidgets.textDisplay(
                                  Constants.additionalEmails,
                                  Styles.textStyleWhite14),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              Opacity(
                                opacity: showSaveButtons ? 1 : 0.5,
                                child: GestureDetector(
                                  onTap: () {
                                    if (!showSaveButtons) {
                                      return;
                                    }
                                    addEmail();
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      // Expanded(
                                      //child:
                                      const SizedBox(width: 14),
                                      SvgPicture.asset(
                                        AppIcon.pluscircle,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.white,
                                          BlendMode.srcIn,
                                        ),
                                        // color: AppColors.navigationSkyBlueColor,
                                      ),
                                      // ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        Constants.additionalEmails,
                                        style: TextStyle(
                                            color: AppColors.white,
                                            decoration:
                                            TextDecoration.underline,
                                            decorationColor: AppColors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              getEmail(state.additionalEmails ?? []),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                              Container(
                                height: 700,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                    color: Colors.white, // Border color
                                    width: .7, // Bor
                                    // der width
                                  ),
                                ),
                                child:

                                // Column(
                                //   children: [
                                //     EditorHtml(
                                //       mainContext: context,
                                //       text: state.model.email ?? '',
                                //       eventInfoState: state,
                                //     ),
                                //   ],
                                // ),

                                Column(
                                  children: [
                                    // ToolBar(
                                    //   toolBarColor: toolbarColor,
                                    //   padding: const EdgeInsets.all(8),
                                    //   iconSize: 25,
                                    //   iconColor: toolbarIconColor,
                                    //   activeIconColor:
                                    //       Colors.greenAccent.shade400,
                                    //   controller: quillController,
                                    //   crossAxisAlignment:
                                    //       WrapCrossAlignment.start,
                                    //   direction: Axis.horizontal,
                                    //   // customButtons: [
                                    //   //   Container(
                                    //   //     width: 25,
                                    //   //     height: 25,
                                    //   //     decoration: BoxDecoration(
                                    //   //         color: _hasFocus ? Colors.green : Colors.grey,
                                    //   //         borderRadius: BorderRadius.circular(15)),
                                    //   //   ),
                                    //   //   InkWell(
                                    //   //       onTap: () => unFocusEditor(),
                                    //   //       child: const Icon(
                                    //   //         Icons.favorite,
                                    //   //         color: Colors.black,
                                    //   //       )),
                                    //   //   InkWell(
                                    //   //       onTap: () async {
                                    //   //         var selectedText = await controller.getSelectedText();
                                    //   //         debugPrint('selectedText $selectedText');
                                    //   //         var selectedHtmlText = await controller.getSelectedHtmlText();
                                    //   //         debugPrint('selectedHtmlText $selectedHtmlText');
                                    //   //       },
                                    //   //       child: const Icon(
                                    //   //         Icons.add_circle,
                                    //   //         color: Colors.black,
                                    //   //       )),
                                    //   // ],
                                    // ),
                                    // HtmlToolbar(
                                    //   controller: quillController,
                                    //   toolbarType: ToolbarType.nativeScrollable,
                                    // ),
                                    // HtmlEditor(
                                    //   controller: quillController, // your HtmlEditorController
                                    //   htmlEditorOptions: HtmlEditorOptions(
                                    //     hint: "Type here...",
                                    //     initialText: state.model.email ?? '',
                                    //     shouldEnsureVisible: true,
                                    //   ),
                                    //   otherOptions: OtherOptions(
                                    //     height: 400,
                                    //   ),
                                    //   callbacks: Callbacks(
                                    //     onTextChanged: (text) {
                                    //       updatedEmailText = text;
                                    //     },
                                    //     onEditorCreated: () {
                                    //       setHtmlText(state.model.email ?? '');
                                    //     },
                                    //   ),
                                    // ),
                                    HtmlEditor(
                                      controller: quillController,
                                      htmlEditorOptions: HtmlEditorOptions(
                                        hint: "Type here...",
                                        initialText: state.model.email ?? '',
                                        shouldEnsureVisible: true,
                                      ),
                                      htmlToolbarOptions: const HtmlToolbarOptions(
                                        defaultToolbarButtons: [
                                          FontButtons(),
                                          ColorButtons(),
                                          ParagraphButtons(),
                                          InsertButtons(),
                                        ],
                                      ),
                                      otherOptions: OtherOptions(height: 400),
                                      callbacks: Callbacks(
                                        onInit: () {
                                          quillController.setText(state.model.email ?? '');
                                        },
                                        onChangeContent: (String? text) {
                                          updatedEmailText = text ?? '';
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      height: 450,
                                      width: double.infinity,
                                      child: SingleChildScrollView(
                                        // child: QuillHtmlEditor(
                                        //   // text: widget.text,
                                        //   hintText: 'Hint text goes here',
                                        //   controller: quillController,
                                        //   isEnabled: showSaveButtons,
                                        //   ensureVisible: true,
                                        //   minHeight: 500,
                                        //   autoFocus: true,
                                        //   textStyle: editorTextStyle,
                                        //   hintTextStyle: hintTextStyle,
                                        //   hintTextAlign: TextAlign.start,
                                        //   padding: const EdgeInsets.only(
                                        //       left: 10, top: 10),
                                        //   hintTextPadding:
                                        //       const EdgeInsets.only(left: 20),
                                        //   backgroundColor: backgroundColor,
                                        //   inputAction: InputAction.newline,
                                        //   onEditingComplete: (s) async {
                                        //     debugPrint('Editing completed $s');
                                        //     state.model.email = s;
                                        //     BlocProvider.of<EventInfoCubit>(
                                        //             context)
                                        //         .onModelValueChange(
                                        //             state.model);
                                        //   },
                                        //   loadingBuilder: (context) {
                                        //     return const Center(
                                        //         child:
                                        //             CircularProgressIndicator(
                                        //       strokeWidth: 1,
                                        //       color: Colors.red,
                                        //     ));
                                        //   },
                                        //   onFocusChanged: (focus) {
                                        //     debugPrint(
                                        //         'has focus-----SSSS---- $focus');
                                        //   },
                                        //   onTextChanged: (text) {
                                        //     debugPrint(
                                        //         'widget text change $text');
                                        //     updatedEmailText = text;
                                        //   },
                                        //   onEditorCreated: () {
                                        //     debugPrint(
                                        //         'Editor has been loaded--------');
                                        //     // setHtmlText(widget.text);
                                        //     quillController.setText(
                                        //         state.model.email ?? '');
                                        //   },
                                        //   onEditorResized: (height) => debugPrint(
                                        //       'Editor resized----------- $height'),
                                        //   onSelectionChanged: (sel) => debugPrint(
                                        //       'index---- ${sel.index}, range ${sel.length}'),
                                        // ),
                                        child: HtmlEditor(
                                          controller: quillController,
                                          htmlEditorOptions: HtmlEditorOptions(
                                            hint: 'Hint text goes here',
                                            initialText: state.model.email ??
                                                '',
                                            autoAdjustHeight: true,
                                            disabled: !showSaveButtons,
                                          ),
                                          htmlToolbarOptions: HtmlToolbarOptions(
                                            toolbarPosition: ToolbarPosition
                                                .aboveEditor,
                                          ),
                                          callbacks: Callbacks(
                                            onChangeContent: (text) {
                                              updatedEmailText = text;
                                            },
                                            onBlur: () async {
                                              final text = await quillController
                                                  .getText();
                                              state.model.email = text;
                                              BlocProvider.of<EventInfoCubit>(
                                                  context)
                                                  .onModelValueChange(
                                                  state.model);
                                            },
                                            onInit: () {
                                              quillController.setText(
                                                  state.model.email ?? '');
                                            },
                                          ),
                                        )
                                        ,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Will show for only Event Protection
                              if (widget.isEventProtection) ...[
                                if (state.eventDuration ==
                                    ConstantsIntValue.eventDurationAfter) ...[
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [

                                        /// Add Button
                                        OpacityAbsorbInkWellWidget(
                                          absorbing: !showSaveButtons,
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              articleFoundNewDetailsRoute,
                                              arguments: {
                                                ConstantsArgument.eventId:
                                                state.model.id,
                                                ConstantsArgument
                                                    .eventProtectionId:
                                                widget.eventProtectionId,
                                                ConstantsArgument.location:
                                                state.model.location,
                                              },
                                            );
                                          },
                                          child: const AddViewButton(
                                            label: 'Add Article Found',
                                          ),
                                        ),

                                        /// Show List Button
                                        if (!state.foundArticles.isEmptyOrNull
                                        // && state.model.status! >= 22
                                        ) ...[
                                          submitButtonDisplay(
                                            label: Constants.showList,
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                articleFoundNewListRoute,
                                                arguments: {
                                                  ConstantsArgument.eventId:
                                                  state.model.id,
                                                  ConstantsArgument
                                                      .eventProtectionId:
                                                  widget.eventProtectionId,
                                                },
                                              );
                                              // showDialog(
                                              //   context: context,
                                              //   builder: (context) {
                                              //     return ArticleDialog(
                                              //       articles:
                                              //           state.foundArticles ??
                                              //               [],
                                              //       showLeftButton:
                                              //       false,
                                              //       leftButtonTap: () {
                                              //         FocusScope.of(context)
                                              //             .unfocus();
                                              //         BlocProvider.of<
                                              //                     EventInfoCubit>(
                                              //                 this.context)
                                              //             .submitForm(
                                              //                 isSaveOnly: true,
                                              //                 addArticleFound:
                                              //                     true,
                                              //                 updatedEmailText:
                                              //                     updatedEmailText ??
                                              //                         '');
                                              //       },
                                              //     );
                                              //   },
                                              // );
                                            },
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              /// upload Photo
                              CommonWidgets.textDisplay(Constants.uploadPhoto,
                                  Styles.textStyleWhite14),
                              state.model.image == null
                                  ? CommonWidgets.verticalSpacerWidget(
                                  height * 0.001)
                                  : Container(),
                              BaseImageUpload().uploadWidget(
                                context: context,
                                isDisabled: !showSaveButtons,
                                loggedInUserDetails:
                                state.loggedInUserDetails ?? User(),
                                getFiles: guardFiles,
                                onImageSelected: (ImageContent data) {
                                  log(
                                      '-------function---onImageSelected---------');
                                  List<ImageContent>? files = [];
                                  files.add(data);
                                  for (ImageContent image in guardFiles ?? []) {
                                    files.add(image);
                                  }
                                  BlocProvider.of<EventInfoCubit>(context)
                                      .addAttachment(guardImages: files);
                                },
                              ),
                            ],
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.02),
                      ],
                    ),
                  ),

                  /// Attachments
                  BaseImageUpload().getAttachment(
                    height: height,
                    attachments: state.guardAttachments,
                    files: guardFiles,
                    isDisabled: !showSaveButtons,
                    // showDownloadIcon:
                    //     state.model.image != null ? true : false,
                    moduleCode: widget.isEventProtection
                        ? Constants.eventProtectionModuleCode
                        : Constants.annualPowerShutDownModuleCode,
                  ),
                  CommonWidgets.verticalSpacerWidget(height * 0.02),

                  /// SubmitButton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cancelButtonDisplay(),
                      if (showSaveButtons) ...[
                        submitButtonDisplay(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            BlocProvider.of<EventInfoCubit>(context).submitForm(
                                isSaveOnly: false,
                                updatedEmailText: updatedEmailText ?? '');
                          },
                        ),
                      ],
                    ],
                  ),
                  CommonWidgets.verticalSpacerWidget(height * 0.04),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addEmail() {
    final exampleCubit = context.read<EventInfoCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider<EventInfoCubit>.value(
          value: exampleCubit,
          child: BlocBuilder<EventInfoCubit, EventInfoState>(
            builder: (context, state) {
              var height = MediaQuery
                  .of(dialogContext)
                  .size
                  .height;
              var width = MediaQuery
                  .of(dialogContext)
                  .size
                  .width;
              return AlertDialog(
                backgroundColor: AppColors.backgroundWhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: SizedBox(
                  height: height * 0.19,
                  width: width,
                  child: Center(
                    child: Column(
                      children: [
                        CommonWidgets.textDisplay(
                          Constants.additionalEmails,
                          Styles.textStyleBlack14,
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.001),
                        FlutterInputField(
                          lineHeight: 1,
                          controller: addEmailController,
                          textFormKey: Keys.equipmentNoKey,
                          hintText: '',
                          isEnable: showSaveButtons,
                          isDisableColor: false,
                          onChange: (String value) {},
                          validateTextField: (String value) {},
                        ),
                        if (state.status == FormStatus.invalidEmail) ...[
                          const Text(
                            'Please enter a valid email',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        const Spacer(),
                        submitButtonDisplay(
                          onTap: () {
                            // Access the context here for BlocProvider
                            BlocProvider.of<EventInfoCubit>(this.context)
                                .onAddEmail(addEmailController.text);
                            if (EmailValidator.validate(
                                addEmailController.text)) {
                              addEmailController.clear();
                              Navigator.pop(dialogContext);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
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

  Widget submitButtonDisplay({
    required Function onTap,
    String? label = Constants.submit,
  }) {
    return AppButton(
      width: 150,
      buttonText: label,
      buttonTextKey: Keys.submitButton,
      onTap: onTap,
    );
  }

  void onPressedRemoveEmail(String email) {
    BlocProvider.of<EventInfoCubit>(context).removeEmail(email);
  }

  Widget getEmail(List<String> emails) {
    List<Widget> widgets = [];

    for (String email in emails) {
      widgets.add(Row(
        children: [
          Text(
            email,
            textAlign: TextAlign.start,
          ),
          Opacity(
            opacity: showSaveButtons ? 1 : 0.5,
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                if (!showSaveButtons) {
                  return;
                }
                onPressedRemoveEmail(email);
              },
            ),
          ),
        ],
      ));
      widgets.add(const SizedBox(height: 2));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  ///[getHtmlText] to get the html text from editor
  Future<String> getHtmlText() async {
    String? htmlText = await quillController.getText();
    debugPrint(htmlText);
    return htmlText;
  }

  void setHtmlText(String text) {
    quillController.setText(text); // just call it, don't await
  }

  // void insertNetworkImage(String url) {
  //   quillController.insertNetworkImage(url: url); // just call it
  // }

  // void insertHtmlText(String text) {
  //   quillController.insertHtml(html: text); // just call it
  // }

  void clearEditor() {
    quillController.clear(); // call directly
  }

  void enableEditor(bool enable) {
    quillController.enable(); // call directly
  }

}