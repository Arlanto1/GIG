import 'dart:core';
import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/opacity_absorb_widget.dart';
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
  List<Map<String, dynamic>> emailTemplateList = [];
  bool isTemplateLoading = false;

  String selectedTemplateHtml = "";
  String? updatedEmailText;

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
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return BlocConsumer<EventInfoCubit, EventInfoState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == FormStatus.templateLoaded,
        listener: (context, state) {
          Utils().formError(state, context);
          Utils().errorAndLogout(state, context);

          final template = state.emailTemplates?.last;

          if (template == null) return;

          final html = template["html"] as String?;
          final id = template["id"] as int?;

          if (html == null || html.isEmpty) return;

          openTemplatePreview(
            html: html,
            templateId: id,
          );
          // final firstTemplate = state.emailTemplates?.first;
          //
          // final html = firstTemplate?["html"] as String?;
          //
          // if (html?.isNotEmpty == true) {
          //   openTemplatePreview(html: html!);
          // }
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
          if (state.status == FormStatus.loading) {
            return const BaseLoader();
          }
          if (state.status == FormStatus.addAttachment ||
              state.status == FormStatus.initial) {
            guardFiles = state.guardAttachments ?? [];
          }
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
              log('state.model.eventConcludedAt--- ${state.model.eventConcludedAt}');
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
                    isSaveOnly: false,
                    updatedEmailText: updatedEmailText ?? '');
              },
            ),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                /// 🔹 FULL SCREEN BACKGROUND IMAGE
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/bg2.png',
                    fit: BoxFit.cover,
                  ),
                ),

                // 🔹 GLASS BLUR OVERLAY
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.15),
                    ),
                  ),
                ),

                // 🔹 CONTENT (FORCED TO FULL HEIGHT)
                LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.transparent,
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
                                          if (!state
                                              .model.lock.isEmptyOrNull) ...[
                                            RecordLockedWidget(
                                                text: '${state.model.lock}'),
                                          ],
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, right: 20),
                                            child: Column(
                                              children: [
                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                        height * 0.01),

                                                /// Event Started At
                                                if (state.eventDuration !=
                                                    1) ...[
                                                  CommonWidgets.textDisplay(
                                                    state.eventDuration == 0
                                                        ? Constants
                                                            .eventStartedAt
                                                        : Constants
                                                            .eventConcludedAt,
                                                    Styles.textStyleWhite14,
                                                  ),
                                                  BaseDate()
                                                      .datePickerWidgetLoading(
                                                    context: context,
                                                    textController:
                                                        dateController,
                                                    isDisabled:
                                                        !showSaveButtons,
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
                                                    startDate:
                                                        initialisedStartDate,
                                                    fromDate:
                                                        initialisedFromDate,
                                                    toDate: initialisedToDate,
                                                    onChange: (String value) {
                                                      dateController.text =
                                                          value;
                                                      log('dateControllerValue --- $value');
                                                      state.model.date = value;
                                                      BlocProvider.of<
                                                                  EventInfoCubit>(
                                                              context)
                                                          .onModelValueChange(
                                                              state.model);
                                                    },
                                                  ),
                                                  CommonWidgets
                                                      .verticalSpacerWidget(
                                                          height * 0.02),
                                                ],
                                                CommonWidgets.textDisplay(
                                                    Constants.additionalEmails,
                                                    Styles.textStyleWhite14),
                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                        height * 0.01),
                                                Opacity(
                                                  opacity:
                                                      showSaveButtons ? 1 : 0.5,
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
                                                        const SizedBox(
                                                            width: 14),
                                                        SvgPicture.asset(
                                                          AppIcon.pluscircle,
                                                          colorFilter:
                                                              const ColorFilter
                                                                  .mode(
                                                            AppColors.white,
                                                            BlendMode.srcIn,
                                                          ),
                                                          // color: AppColors.navigationSkyBlueColor,
                                                        ),
                                                        // ),
                                                        const SizedBox(
                                                            width: 10),
                                                        const Text(
                                                          Constants
                                                              .additionalEmails,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              decorationColor:
                                                                  AppColors
                                                                      .white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                getEmail(
                                                    state.additionalEmails ??
                                                        []),
                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                        height * 0.02),

                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                        height * 0.02),

                                                CommonWidgets.textDisplay(
                                                    'View Notification',
                                                    Styles.textStyleWhite14),

                                                /// 🔹 TEMPLATE LIST
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: .7),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      /// ===== HEADER =====
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 16,
                                                                vertical: 12),
                                                        color: Colors.white
                                                            .withValues(
                                                                alpha: 0.1),
                                                        child: Row(
                                                          children: [
                                                            const Expanded(
                                                              child: Text(
                                                                "Id",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            IconButton(
                                                              icon: const Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white),
                                                              tooltip:
                                                                  'Fetch Template',
                                                              onPressed: () {
                                                                context
                                                                    .read<
                                                                        EventInfoCubit>()
                                                                    .getEPEmailInfoById(
                                                                        widget
                                                                            .eventProtectionId);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      /// ===== LOADER =====
                                                      if (state
                                                              .isTemplateLoading ==
                                                          true)
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  12),
                                                          child:
                                                              CircularProgressIndicator(
                                                                  color: Colors
                                                                      .white),
                                                        ),

                                                      /// ===== EMPTY STATE =====
                                                      if (state.isTemplateLoading ==
                                                              false &&
                                                          (state.emailTemplates!
                                                              .isEmpty))
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  12),
                                                          child: Text(
                                                            "No templates loaded",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white70),
                                                          ),
                                                        ),

                                                      /// ===== TEMPLATE LIST =====
                                                      ...?state.emailTemplates
                                                          ?.map((item) {
                                                        return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 10),
                                                          decoration:
                                                              const BoxDecoration(
                                                            border: Border(
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                      .white24),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  item["id"]
                                                                      .toString(),
                                                                  style: Styles
                                                                      .textStyleWhite14,
                                                                ),
                                                              ),
                                                              // IconButton(
                                                              //   icon: const Icon(
                                                              //     Icons.remove_red_eye,
                                                              //     color: Colors.white,
                                                              //   ),
                                                              // onPressed: () {
                                                              //   openTemplatePreview(html: item["html"],    templateId: item["id"] as int?,);
                                                              // },
                                                              IconButton(
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .remove_red_eye,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  final id =
                                                                      item[
                                                                          "id"];

                                                                  if (id ==
                                                                      null)
                                                                    return;

                                                                  try {
                                                                    // Optional: show loader
                                                                    // showLoading();

                                                                    final response = await context
                                                                        .read<
                                                                            EventInfoCubit>()
                                                                        .getNotificationById(
                                                                          id.toString(),
                                                                        );

                                                                    final html =
                                                                        response
                                                                            .notification; // 👈 adjust field name if different

                                                                    if (html ==
                                                                            null ||
                                                                        html
                                                                            .trim()
                                                                            .isEmpty) {
                                                                      debugPrint(
                                                                          "HTML is empty");
                                                                      return;
                                                                    }

                                                                    openTemplatePreview(
                                                                      html:
                                                                          html,
                                                                      templateId:
                                                                          id as int?,
                                                                    );
                                                                  } catch (e, s) {
                                                                    debugPrint(
                                                                        "Failed to load template: $e");
                                                                    debugPrintStack(
                                                                        stackTrace:
                                                                            s);
                                                                  } finally {
                                                                    // Optional: hide loader
                                                                    // hideLoading();
                                                                  }
                                                                },
                                                                // ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ],
                                                  ),
                                                ),

                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                        height * 0.02),

                                                /// Will show for only Event Protection
                                                if (widget
                                                    .isEventProtection) ...[
                                                  if (state.eventDuration ==
                                                      ConstantsIntValue
                                                          .eventDurationAfter) ...[
                                                    Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          /// Add Button
                                                          OpacityAbsorbInkWellWidget(
                                                            absorbing:
                                                                !showSaveButtons,
                                                            onTap: () {
                                                              Navigator
                                                                  .pushNamed(
                                                                context,
                                                                articleFoundNewDetailsRoute,
                                                                arguments: {
                                                                  ConstantsArgument
                                                                          .eventId:
                                                                      state
                                                                          .model
                                                                          .id,
                                                                  ConstantsArgument
                                                                          .eventProtectionId:
                                                                      widget
                                                                          .eventProtectionId,
                                                                  ConstantsArgument
                                                                          .location:
                                                                      state
                                                                          .model
                                                                          .location,
                                                                },
                                                              );
                                                            },
                                                            child:
                                                                const AddViewButton(
                                                              label:
                                                                  'Add Article Found',
                                                            ),
                                                          ),

                                                          /// Show List Button
                                                          if (!state
                                                                  .foundArticles
                                                                  .isEmptyOrNull
                                                              // && state.model.status! >= 22
                                                              ) ...[
                                                            submitButtonDisplay(
                                                              label: Constants
                                                                  .showList,
                                                              onTap: () {
                                                                Navigator
                                                                    .pushNamed(
                                                                  context,
                                                                  articleFoundNewListRoute,
                                                                  arguments: {
                                                                    ConstantsArgument
                                                                            .eventId:
                                                                        state
                                                                            .model
                                                                            .id,
                                                                    ConstantsArgument
                                                                            .eventProtectionId:
                                                                        widget
                                                                            .eventProtectionId,
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                  CommonWidgets
                                                      .verticalSpacerWidget(
                                                          height * 0.02),
                                                ],
                                              ],
                                            ),
                                          ),
                                          CommonWidgets.verticalSpacerWidget(
                                              height * 0.02),
                                        ],
                                      ),
                                    ),

                                    // /// Attachments

                                    /// SubmitButton
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        cancelButtonDisplay(),
                                        if (showSaveButtons) ...[
                                          submitButtonDisplay(
                                            onTap: () async {
                                              FocusScope.of(context).unfocus();
                                              BlocProvider.of<EventInfoCubit>(
                                                      context)
                                                  .submitForm(
                                                      isSaveOnly: false,
                                                      updatedEmailText:
                                                          updatedEmailText ??
                                                              '');
                                            },
                                          ),
                                        ],
                                      ],
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.04),
                                  ],
                                ),
                              ),
                            ],
                            // ),
                          )));
                }),
              ],
            ),
          );
        });
  }

  void openTemplatePreview({
    required String html,
    int? templateId,
  }) {
    selectedTemplateHtml = html;

    // ✅ Capture the cubit from the correct context BEFORE opening the sheet
    final eventInfoCubit = context.read<EventInfoCubit>();
    final int? currentTemplateId = templateId;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: false,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        final height = MediaQuery.of(bottomSheetContext).size.height;

        return BlocProvider.value(
          value: eventInfoCubit, // ✅ reuse same cubit instance
          child: Builder(
            builder: (context) {
              final state = context.watch<EventInfoCubit>().state;

              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(
                    height: height * 0.9,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.newColor3.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.4),
                        width: 0.7,
                      ),
                    ),
                    child: Column(
                      children: [
                        /// ===== HEADER =====
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                currentTemplateId == null
                                    ? "Create Email Template"
                                    : "Edit Email Template #$currentTemplateId",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  /// ===== SUBMIT =====
                                  IconButton(
                                    tooltip: "Submit",
                                    icon: const Icon(Icons.send,
                                        color: Colors.white),
                                    onPressed: () async {
                                      final html =
                                          await quillController.getText();

                                      if (html.trim().isEmpty) return;

                                      context
                                          .read<EventInfoCubit>()
                                          .submitTemplateAndRefresh(
                                            html: html,
                                            id: currentTemplateId,
                                          );

                                      Navigator.pop(context);
                                    },
                                  ),

                                  /// ===== CLOSE =====
                                  IconButton(
                                    tooltip: "Close",
                                    icon: const Icon(Icons.close,
                                        color: Colors.white),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        /// ===== HTML EDITOR =====
                        Expanded(
                          child: HtmlEditor(
                            controller: quillController,
                            htmlToolbarOptions: const HtmlToolbarOptions(
                              toolbarPosition: ToolbarPosition.aboveEditor,
                              textStyle: Styles.textStyleBlack16,
                            ),
                            htmlEditorOptions: HtmlEditorOptions(
                              darkMode: false,
                              initialText: selectedTemplateHtml,
                            ),
                            callbacks: Callbacks(
                              onInit: () {
                                quillController.setText("""
     <style>
body { background-color: transparent !important; color: white !important; }
* { color: white !important; }
</style>
$selectedTemplateHtml
""");
                              },
                            ),
                          ),
                        ),

                        /// ===== ATTACHMENTS =====
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.015),
                              CommonWidgets.textDisplay(
                                Constants.uploadPhoto,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              BaseImageUpload().uploadWidget(
                                context: context,
                                isDisabled: !showSaveButtons,
                                loggedInUserDetails:
                                    state.loggedInUserDetails ?? User(),
                                getFiles: guardFiles,
                                onImageSelected: (ImageContent data) {
                                  final files = <ImageContent>[
                                    data,
                                    ...?guardFiles,
                                  ];

                                  context.read<EventInfoCubit>().addAttachment(
                                        guardImages: files,
                                      );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                              BaseImageUpload().getAttachment(
                                height: height,
                                attachments: state.guardAttachments,
                                files: guardFiles,
                                isDisabled: !showSaveButtons,
                                moduleCode: widget.isEventProtection
                                    ? Constants.eventProtectionModuleCode
                                    : Constants.annualPowerShutDownModuleCode,
                              ),
                            ],
                          ),
                        ),

                        CommonWidgets.verticalSpacerWidget(height * 0.015),
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

  void addEmail() {
    final exampleCubit = context.read<EventInfoCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider<EventInfoCubit>.value(
          value: exampleCubit,
          child: BlocBuilder<EventInfoCubit, EventInfoState>(
            builder: (context, state) {
              var height = MediaQuery.of(dialogContext).size.height;
              var width = MediaQuery.of(dialogContext).size.width;
              return AlertDialog(
                backgroundColor: AppColors.newColor.withValues(alpha: 0.5),
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
                          Styles.textStyleWhite14,
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
            style: Styles.textStyleWhite14,
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
