import 'dart:core';
import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/date_picker_dialog.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/event_info/views/article_dialog.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../../../common_widgets/base_widget/base_image_upload.dart';
import '../../../../../common_widgets/new_search_textfield.dart';
import '../../../../../constants/app_icon.dart';
import '../../../../../models/entry_security.dart';
import '../../../../../utils/util.dart';
import '../cubits/event_info_cubit.dart';
import 'editor.dart';

class EventInfoView extends StatefulWidget {
  const EventInfoView({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<EventInfoView> createState() => _EventInfoViewState();
}

class _EventInfoViewState extends State<EventInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final quill.QuillController _controller = quill.QuillController.basic();
  final QuillEditorController controller = QuillEditorController();

  GetUserDetails? userDetails;
  List<CreateImage>? guardFiles;
  TextEditingController dateController = TextEditingController();
  TextEditingController addEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EventInfoCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<EventInfoCubit, EventInfoState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');

        if (state.status == FormStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Saved Successfully')));
          Navigator.pop(context);
        }
        if (state.status == FormStatus.error) {
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
        }
      },
      builder: (context, state) {
        dateController.text = Utils.timestamptoDateConversion(
            int.tryParse(state.model.date ?? '0'), Constants.dateFormat);
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: state.model.status != 4 ? true : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<EventInfoCubit>(context)
                  .submitForm(isSaveOnly: true);
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
      return const Center(child: CircularProgressIndicator());
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
                            CommonWidgets.textDisplay(
                              Constants.eventStartedAt,
                              Styles.textStyleBlack14,
                            ),
                            BaseDate().datePickerWidgetLoading(
                              textController: dateController,
                              isDisabled: false,
                              onlyDate: true,
                              onChange: (String value) {
                                dateController.text = value;
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            CommonWidgets.textDisplay(
                                Constants.additionalEmails,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            GestureDetector(
                              onTap: addEmail,
                              child: Row(
                                children: <Widget>[
                                  // Expanded(
                                  //child:
                                  const SizedBox(width: 14),
                                  SvgPicture.asset(
                                    AppIcon.pluscircle,
                                    //color: AppColors.navigationSkybluecolor,
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
                              child: Column(
                                children: [
                                  EditorHtml(text: state.model.email ?? ''),
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
                                              articles: state.foundArticles ?? []);
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
                              state.loggedInUserDetails ?? EntrySecurity(),
                              getFiles: guardFiles,
                              onImageSelected: (CreateImage data) {
                                log('-------function---onImageSelected---------');
                                List<CreateImage>? files = [];
                                files.add(data);
                                for (CreateImage image in guardFiles ?? []) {
                                  files.add(image);
                                }
                                BlocProvider.of<EventInfoCubit>(
                                    context)
                                    .addAttachment(guardImages: files);
                              },
                            ),
                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.guardAttachments,
                              files: guardFiles,
                              showDownloadIcon: state.model.image!= null
                                  ? true
                                  : false,
                            ),
                          ],
                        ),
                      ),


                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      /// SubmitButton
                      if (state.model.status != 4) ...[
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
          ],
        ),
      ),
    );
  }

  void addEmail() {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: AppColors.backgroundWhitecolor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Builder(builder: (context) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;
              return SizedBox(
                height: height * 0.15,
                width: width,
                child: Center(
                  child: Column(
                    children: [
                      CommonWidgets.textDisplay(
                          Constants.additionalEmails, Styles.textStyleBlack14),
                      CommonWidgets.verticalSpacerWidget(height * 0.001),
                      FlutterInputField(
                        lineHeight: 1,
                        textFieldController: addEmailController,
                        textFormKey: Keys.equipmentNoKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {},
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      const Spacer(),
                      submitButtonDisplay(
                        onTap: () {
                          BlocProvider.of<EventInfoCubit>(this.context)
                              .onAddEmail(addEmailController.text);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
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
          const Icon(Icons.delete),
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
}
