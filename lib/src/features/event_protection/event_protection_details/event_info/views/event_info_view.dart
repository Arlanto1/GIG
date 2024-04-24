import 'dart:core';
import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_circular_loader.dart';
import 'package:db_atom/src/common_widgets/base_widget/date_picker_dialog.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/event_info/views/article_dialog.dart';
import 'package:db_atom/src/models/image_content.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../../../common_widgets/base_widget/base_image_upload.dart';
import '../../../../../common_widgets/new_search_textfield.dart';
import '../../../../../constants/app_icon.dart';
import '../../../../../routing/router.dart';
import '../../../../../utils/util.dart';
import '../cubits/event_info_cubit.dart';

class EventInfoView extends StatefulWidget {
  const EventInfoView({
    super.key,
    required this.title,
    required this.editForm,
  });

  final String title;
  final bool editForm;

  @override
  State<EventInfoView> createState() => _EventInfoViewState();
}

class _EventInfoViewState extends State<EventInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final quill.QuillController _controller = quill.QuillController.basic();
  final QuillEditorController controller = QuillEditorController();

  User? userDetails;
  List<ImageContent>? guardFiles;
  TextEditingController dateController = TextEditingController();
  TextEditingController addEmailController = TextEditingController();
  TextEditingController deleteEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EventInfoCubit>(context).initializeValues();
  }

  bool hasFocus = false;
  bool showSaveButtons = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return BlocConsumer<EventInfoCubit, EventInfoState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Saved Successfully')));
          Navigator.pop(context);
          Navigator.pop(context);
        }

        if (state.status == FormStatus.addArticleFound) {
          Navigator.pop(context);
          Navigator.pushNamed(
            context,
            createFoundScreenRoute,
            arguments: {'eventId': state.model.id},
          );
        }

      },
      builder: (context, state) {
        dateController.text = Utils.timestampToDateConversion(
            int.tryParse(state.model.date ?? '0'), Constants.dateFormat);

        if (state.model.status != 4 && widget.editForm) {
          showSaveButtons == true;
        }

        // if(widget.editForm){
        //   showSaveButtons == true;
        // }

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
              BlocProvider.of<EventInfoCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<EventInfoCubit>(context)
                  .submitForm(isSaveOnly: false);
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  getBodybuilder(EventInfoState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      // log('---getAttachments----builder----${getAttachments?.length}-----');
      // getFiles = state.loadAttachments ?? [];
      // log('---guardAttachments----builder----${state.guardAttachments?.length}-----');

      guardFiles = state.guardAttachments ?? [];
    }
    return Container(
      color: AppColors.navigationSkybluecolor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkybluecolor,
            ),
            Container(
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhitecolor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  )),
              child: AbsorbPointer(
                absorbing: !widget.editForm,
                child: Form(
                  key: _formKey,
                  autovalidateMode: state.model.status == 30
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
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

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
                                isDisabled: false,
                                onlyDate: true,
                                onChange: (String value) {
                                  dateController.text = value;
                                  state.model.date = value;
                                  BlocProvider.of<EventInfoCubit>(context)
                                      .onModelValueChange(state.model);
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                            CommonWidgets.textDisplay(
                                Constants.additionalEmails,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            GestureDetector(
                              onTap: () {
                                addEmail();
                              },
                              child: Row(
                                children: <Widget>[
                                  // Expanded(
                                  //child:
                                  const SizedBox(width: 14),
                                  SvgPicture.asset(
                                    AppIcon.pluscircle,
                                    color: AppColors.navigationSkybluecolor,
                                  ),
                                  // ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    Constants.additionalEmails,
                                    style: TextStyle(
                                      color: AppColors.navigationSkybluecolor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            getEmail(state.additionalEmails ?? []),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
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
                                    controller: controller,
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
                                    child: QuillHtmlEditor(
                                      // text: widget.text,
                                      hintText: 'Hint text goes here',
                                      controller: controller,
                                      isEnabled: true,
                                      ensureVisible: false,
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
                                        var cubit =
                                            BlocProvider.of<EventInfoCubit>(
                                                context);
                                        state.model.email = await getHtmlText();
                                        cubit.onModelValueChange(state.model);
                                      },
                                      loadingBuilder: (context) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                          color: Colors.red,
                                        ));
                                      },
                                      onFocusChanged: (focus) {
                                        debugPrint(
                                            'has focus-----SSSS---- $focus');

                                        // setState(() {
                                        //   hasFocus = focus;
                                        // });
                                      },
                                      onTextChanged: (text) => debugPrint(
                                          'widget text change $text'),
                                      onEditorCreated: () {
                                        debugPrint(
                                            'Editor has been loaded--------');
                                        // setHtmlText(widget.text);
                                        controller
                                            .setText(state.model.email ?? '');
                                      },
                                      onEditorResized: (height) => debugPrint(
                                          'Editor resized----------- $height'),
                                      onSelectionChanged: (sel) => debugPrint(
                                          'index---- ${sel.index}, range ${sel.length}'),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            if (state.eventDuration == 2) ...[
                              Center(
                                child: submitButtonDisplay(
                                    label: 'Articles Found',
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ArticleDialog(
                                            articles: state.foundArticles ?? [],
                                            showLeftButton:
                                                (state.model.status ?? 0) > 22
                                                    ? false
                                                    : true,
                                            leftButtonTap: () {
                                              // TODO: Call Save API
                                              BlocProvider.of<EventInfoCubit>(
                                                      this.context)
                                                  .submitForm(
                                                      isSaveOnly: true,
                                                      addArticleFound: true);
                                            },
                                          );
                                        },
                                      );
                                    }),
                              ),
                            ],
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload Photo
                            CommonWidgets.textDisplay(
                                Constants.uploadPhoto, Styles.textStyleBlack14),
                            state.model.image == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            BaseImageUpload().uploadWidget(
                              context: context,
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
                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.guardAttachments,
                              files: guardFiles,
                              showDownloadIcon:
                                  state.model.image != null ? true : false,
                              moduleCode: Constants.eventProtectionModuleCode,
                            ),
                          ],
                        ),
                      ),

                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// SubmitButton
                      if (showSaveButtons) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cancelButtonDisplay(),
                            submitButtonDisplay(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                BlocProvider.of<EventInfoCubit>(context)
                                    .submitForm(isSaveOnly: true);
                              },
                            ),
                          ],
                        ),
                      ],
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ],
                  ),
                ),
              ),
            ),
            if (!showSaveButtons) ...[
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhitecolor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(00.0)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButtonDisplay(),
                  ],
                ),
              ),
            ],
            CommonWidgets.verticalSpacerWidget(height * 0.04),
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
                backgroundColor: AppColors.backgroundWhitecolor,
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
                              isEnable: true,
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
      // Customize the button properties as needed
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget submitButtonDisplay(
      {required Function onTap, String? label = Constants.submit}) {
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
    log('-getEmail---${emails.toString()}--');
    List<Widget> widgets = [];

    for (String email in emails) {
      widgets.add(Row(
        children: [
          Text(
            email,
            textAlign: TextAlign.start,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              onPressedRemoveEmail(email);
            },
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
    String? htmlText = await controller.getText();
    debugPrint(htmlText);
    return htmlText;
  }

  ///[setHtmlText] to set the html text to editor
  void setHtmlText(String text) async {
    await controller.setText(text);
  }

  ///[insertNetworkImage] to set the html text to editor
  void insertNetworkImage(String url) async {
    await controller.embedImage(url);
  }

  ///[insertVideoURL] to set the video url to editor
  ///this method recognises the inserted url and sanitize to make it embeddable url
  ///eg: converts youtube video to embed video, same for vimeo
  void insertVideoURL(String url) async {
    await controller.embedVideo(url);
  }

  /// to set the html text to editor
  /// if index is not set, it will be inserted at the cursor postion
  void insertHtmlText(String text, {int? index}) async {
    await controller.insertText(text, index: index);
  }

  /// to clear the editor
  void clearEditor() => controller.clear();

  /// to enable/disable the editor
  void enableEditor(bool enable) => controller.enableEditor(enable);

  /// method to un focus editor
  void unFocusEditor() => controller.unFocus();
}
