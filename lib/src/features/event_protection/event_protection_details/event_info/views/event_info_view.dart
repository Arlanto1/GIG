import 'dart:core';
import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/opacity_absorb_widget.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

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

  final QuillEditorController quillController = QuillEditorController();

  User? userDetails;
  List<ImageContent>? guardFiles;
  TextEditingController dateController = TextEditingController();
  TextEditingController addEmailController = TextEditingController();

  bool showSaveButtons = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EventInfoCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    dateController.dispose();
    addEmailController.dispose();
    quillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return BlocConsumer<EventInfoCubit, EventInfoState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${state.message}')));
          Navigator.pop(context);
          Navigator.pop(context);
        }

        if (state.status == FormStatus.addArticleFound) {
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            createFoundScreenRoute,
            arguments: {
              ConstantsArgument.eventId: state.model.id,
              ConstantsArgument.eventProtectionId: widget.eventProtectionId,
            },
          );
        }
      },
      builder: (context, state) {
        if (state.model.date != null && state.model.date != '') {
          dateController.text = Utils.timestampToDateConversion(
              int.tryParse(state.model.date ?? '0'), Constants.fulldateFormat);
        }

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
          backgroundColor: AppColors.backgroundWhiteColor,
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
      color: AppColors.navigationSkyBlueColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkyBlueColor,
            ),
            Container(
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
                  shape: RoundedRectangleBorder(
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
                                  Styles.textStyleBlack14,
                                ),
                                BaseDate().datePickerWidgetLoading(
                                  context: context,
                                  textController: dateController,
                                  isDisabled: !showSaveButtons,
                                  onlyDate: false,
                                  startDate: DateTime
                                          .fromMillisecondsSinceEpoch(int.parse(
                                                  '${state.model.startDate}') *
                                              1000)
                                      .toString(),
                                  fromDate: DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(
                                                  '${state.model.startDate}') *
                                              1000)
                                      .toString(),
                                  toDate: DateTime.fromMillisecondsSinceEpoch(
                                          int.parse('${state.model.endDate}') *
                                              1000)
                                      .toString(),
                                  onChange: (String value) {
                                    dateController.text = value;
                                    state.model.date = value;
                                    BlocProvider.of<EventInfoCubit>(context)
                                        .onModelValueChange(state.model);
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],
                              CommonWidgets.textDisplay(
                                  Constants.additionalEmails,
                                  Styles.textStyleBlack14),
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
                                          AppColors.navigationSkyBlueColor,
                                          BlendMode.srcIn,
                                        ),
                                        // color: AppColors.navigationSkyBlueColor,
                                      ),
                                      // ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        Constants.additionalEmails,
                                        style: TextStyle(
                                          color:
                                              AppColors.navigationSkyBlueColor,
                                          decoration: TextDecoration.underline,
                                        ),
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
                                    color: Colors.grey, // Border color
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
                                    ToolBar(
                                      toolBarColor: toolbarColor,
                                      padding: const EdgeInsets.all(8),
                                      iconSize: 25,
                                      iconColor: toolbarIconColor,
                                      activeIconColor:
                                          Colors.greenAccent.shade400,
                                      controller: quillController,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      direction: Axis.horizontal,
                                      // customButtons: [
                                      //   Container(
                                      //     width: 25,
                                      //     height: 25,
                                      //     decoration: BoxDecoration(
                                      //         color: _hasFocus ? Colors.green : Colors.grey,
                                      //         borderRadius: BorderRadius.circular(15)),
                                      //   ),
                                      //   InkWell(
                                      //       onTap: () => unFocusEditor(),
                                      //       child: const Icon(
                                      //         Icons.favorite,
                                      //         color: Colors.black,
                                      //       )),
                                      //   InkWell(
                                      //       onTap: () async {
                                      //         var selectedText = await controller.getSelectedText();
                                      //         debugPrint('selectedText $selectedText');
                                      //         var selectedHtmlText = await controller.getSelectedHtmlText();
                                      //         debugPrint('selectedHtmlText $selectedHtmlText');
                                      //       },
                                      //       child: const Icon(
                                      //         Icons.add_circle,
                                      //         color: Colors.black,
                                      //       )),
                                      // ],
                                    ),
                                    SizedBox(
                                      height: 450,
                                      width: double.infinity,
                                      child: SingleChildScrollView(
                                        child: QuillHtmlEditor(
                                          // text: widget.text,
                                          hintText: 'Hint text goes here',
                                          controller: quillController,
                                          isEnabled: showSaveButtons,
                                          ensureVisible: true,
                                          minHeight: 500,
                                          autoFocus: true,
                                          textStyle: editorTextStyle,
                                          hintTextStyle: hintTextStyle,
                                          hintTextAlign: TextAlign.start,
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          hintTextPadding:
                                              const EdgeInsets.only(left: 20),
                                          backgroundColor: backgroundColor,
                                          inputAction: InputAction.newline,
                                          onEditingComplete: (s) async {
                                            debugPrint('Editing completed $s');
                                            state.model.email = s;
                                            BlocProvider.of<EventInfoCubit>(
                                                    context)
                                                .onModelValueChange(
                                                    state.model);
                                          },
                                          loadingBuilder: (context) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                              strokeWidth: 1,
                                              color: Colors.red,
                                            ));
                                          },
                                          onFocusChanged: (focus) {
                                            debugPrint(
                                                'has focus-----SSSS---- $focus');
                                          },
                                          onTextChanged: (text) {
                                            debugPrint(
                                                'widget text change $text');
                                            updatedEmailText = text;
                                          },
                                          onEditorCreated: () {
                                            debugPrint(
                                                'Editor has been loaded--------');
                                            // setHtmlText(widget.text);
                                            quillController.setText(
                                                state.model.email ?? '');
                                          },
                                          onEditorResized: (height) => debugPrint(
                                              'Editor resized----------- $height'),
                                          onSelectionChanged: (sel) => debugPrint(
                                              'index---- ${sel.index}, range ${sel.length}'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Will show for only Event Protection
                              if (widget.isEventProtection) ...[

                                if (state.eventDuration == ConstantsIntValue.eventDurationAfter) ...[
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
                                              createFoundScreenRoute,
                                              arguments: {
                                                ConstantsArgument.eventId:
                                                    state.model.id,
                                                ConstantsArgument
                                                        .eventProtectionId:
                                                    widget.eventProtectionId,
                                              },
                                            );
                                          },
                                          child: const AddViewButton(
                                            label: 'Add Article Found',
                                          ),
                                        ),

                                        /// Show List Button
                                        if (!state
                                            .foundArticles.isEmptyOrNull && state.model.status! >= 22) ...[
                                          submitButtonDisplay(
                                            label: Constants.showList,
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                articleFoundListRoute,
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
                                    height * 0.01),
                              ],

                              /// upload Photo
                              CommonWidgets.textDisplay(Constants.uploadPhoto,
                                  Styles.textStyleBlack14),
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
                                  log('-------function---onImageSelected---------');
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
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
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
      builder: (context) {
        return BlocProvider<EventInfoCubit>.value(
          value: exampleCubit,
          child: BlocBuilder<EventInfoCubit, EventInfoState>(
            builder: (context, state) {
              return AlertDialog(
                backgroundColor: AppColors.backgroundWhiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Builder(
                  builder: (context) {
                    var height = MediaQuery.of(context).size.height;
                    var width = MediaQuery.of(context).size.width;
                    return SizedBox(
                      height: height * 0.19,
                      width: width,
                      child: Center(
                        child: Column(
                          children: [
                            CommonWidgets.textDisplay(
                                Constants.additionalEmails,
                                Styles.textStyleBlack14),
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
                                'Please enter valid email',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            const Spacer(),
                            submitButtonDisplay(
                              onTap: () {
                                BlocProvider.of<EventInfoCubit>(this.context)
                                    .onAddEmail(addEmailController.text);
                                if (EmailValidator.validate(
                                    addEmailController.text)) {
                                  addEmailController.clear();
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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

  ///[setHtmlText] to set the html text to editor
  void setHtmlText(String text) async {
    await quillController.setText(text);
  }

  ///[insertNetworkImage] to set the html text to editor
  void insertNetworkImage(String url) async {
    await quillController.embedImage(url);
  }

  ///[insertVideoURL] to set the video url to editor
  ///this method recognises the inserted url and sanitize to make it embeddable url
  ///eg: converts youtube video to embed video, same for vimeo
  void insertVideoURL(String url) async {
    await quillController.embedVideo(url);
  }

  /// to set the html text to editor
  /// if index is not set, it will be inserted at the cursor postion
  void insertHtmlText(String text, {int? index}) async {
    await quillController.insertText(text, index: index);
  }

  /// to clear the editor
  void clearEditor() => quillController.clear();

  /// to enable/disable the editor
  void enableEditor(bool enable) => quillController.enableEditor(enable);

  /// method to un focus editor
  void unFocusEditor() => quillController.unFocus();
}
