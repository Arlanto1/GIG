import 'dart:developer';

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
  TextEditingController returnableTextController = TextEditingController();
  User? userDetails;
  bool isReadOnly = false;
  bool showSaveSubmitButton = false;
  List<ImageContent> uploadFiles = [];
  List<ImageContent> getAttachments = [];

  TextEditingController dueDateTextController = TextEditingController();
  TextEditingController startDateTextController = TextEditingController();

  TextEditingController additionalInformationTextController =
      TextEditingController();

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
        if (state.model.status == null) {
          isReadOnly = false;
        }
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isReadOnly = true;
        // }
        showSaveSubmitButton =
            state.model.status != 9 && state.model.lock.isEmptyOrNull;
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.ticketingSystem,
            showPopUp: false,
            showSaveButton: showSaveSubmitButton ? true : false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            // pdfAPIName:
            // '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.vipVisitorsDetailsModule}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<TicketingSystemDetailsCubit>(context)
                  .submitForm();
            },
            onTapSubmit: () {
              // FocusScope.of(context).unfocus();
              // BlocProvider.of<TicketingSystemDetailsCubit>(context).submitForm(
              //   isSaveOnly: false,
              // );
            },
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
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

    dueDateTextController.text = state.model.dueDate != null
        ? Utils.timestampToDateConversion(
            int.tryParse(state.model.dueDate ?? '0'), Constants.fulldateFormat)
        : '';
  }

  getBodybuilder(TicketingSystemDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    log('uploadFiles ${uploadFiles}');
    log('image ${state.uploadAttachments}');

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      uploadFiles = state.uploadAttachments ?? [];
      log('upload ${state.uploadAttachments ?? []}');
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
                ),
              ),
              child: AbsorbPointer(
                absorbing: state.model.status == 9,
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
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.generalinformation,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Project Name
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.requesterDepartment ??
                                //     state.labels?.defaultLocale
                                //         .requesterDepartment ??
                                Constants.project,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.projectName ?? 'dbatom-uat',
                              height: 60,
                              // isDisableColor: disableForm,
                              onTap: () {
                                BaseOrganisationDialog().departmentDialog(
                                  context: context,
                                  organisations: state.projects,
                                  onTap: (Organisation department) {
                                    BlocProvider.of<
                                                TicketingSystemDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                            projects: department);
                                  },
                                  // orgName: 'EMPLOYEE_DEPARTMENTS',
                                  // createEntity: false,
                                  // title: 'Add Department',
                                  // functionToCall: () {
                                  //   // refresh the list
                                  //   BlocProvider.of<
                                  //       TicketingSystemDetailsCubit>(
                                  //       context)
                                  //       .refreshList();
                                  // }
                                );
                              },
                            ),

                            /// Priority
                            CommonWidgets.textDisplay(
                              Constants.priority,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            TextFieldAddButton(
                              title:
                                  state.model.priorityName ?? 'PO(Immediate)',
                              height: 70,
                              isDisableColor: state.model.status == 9,
                              onTap: () {
                                if (state.model.status != 9) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  BaseOrganisationDialog().departmentDialog(
                                    context: context,
                                    organisations: state.priorities,
                                    onTap: (Organisation department) {
                                      state.model.priorityName =
                                          department.name;
                                      BlocProvider.of<
                                                  TicketingSystemDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                              priority: department);
                                      // FocusScope.of(context)
                                      //     .requestFocus(receivedByFocusNode);
                                    },
                                    // orgName: 'EMPLOYEE_DEPARTMENTS',
                                    // createEntity: false,
                                    // title: 'Add Department',
                                    // functionToCall: () {
                                    //   // refresh the list
                                    //   BlocProvider.of<
                                    //               MaterialMovementDetailsCubit>(
                                    //           context)
                                    //       .refreshList();
                                    // }
                                  );
                                  // leodepartmentsDialog(stat
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Title
                            CommonWidgets.textDisplay(
                              Constants.title,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              textFormKey: Keys.returnChallanKey,
                              initialValue: state.model.title,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.title = value;

                                context
                                    .read<TicketingSystemDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Assignee
                            Column(
                              children: [
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.otherReceiverName ??
                                  //     state.labels?.defaultLocale
                                  //         .otherReceiverName ??
                                  Constants.assigneeName,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                TextFieldAddButton(
                                    title: state.model.assignee?.name,
                                    height: 70,
                                    isDisableColor: isReadOnly,
                                    onTap: () {
                                      // if (!isReadOnly) {
                                      BaseOrganisationDialog().userDialog(
                                        context: context,
                                        users: state.assignee,
                                        isDbUser: true,
                                        onTap: (BaseUser user) {
                                          BlocProvider.of<
                                                      TicketingSystemDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  assignee: user);
                                          // FocusScope.of(context).requestFocus(
                                          //     receivedForEmployeeIdFocusNode);
                                        },
                                        roleName:
                                            ConstantUserRoles.atomStaticUser,
                                        locationId: 0,
                                        // locationId:
                                        // state.model.location!.id!,
                                        // functionToCall: (BaseUser user) {
                                        //   BlocProvider.of<
                                        //       TicketingSystemDetailsCubit>(
                                        //       context)
                                        //       .updateDropdownValues(
                                        //       receiverEmailUser:
                                        //       user);
                                        //   FocusScope.of(context).requestFocus(
                                        //       receivedForEmployeeIdFocusNode);
                                        //   // refresh the list
                                        //   BlocProvider.of<
                                        //       MaterialMovementDetailsCubit>(
                                        //       context)
                                        //       .refreshList();
                                        // },
                                      );
                                      // }
                                    }),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Start Date
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.keyHandOverDue ??
                              //     state.labels?.defaultLocale
                              //         .keyHandOverDue ??
                              Constants.startDate,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: startDateTextController,
                              // isDisabled:
                              // state.model.keyHandingOverDuration == 2 &&
                              //     (state.model.status == null ||
                              //         state.model.status ==
                              //             ConstantsIntValue
                              //                 .issuanceDraftStatus)
                              //     ? false
                              //     : true,
                              onlyDate: false,
                              showPastDate: false,
                              onChange: (String value) {
                                startDateTextController.text = value;
                                state.model.startDate =
                                    Utils().formatTime(value);
                                BlocProvider.of<TicketingSystemDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                                //},
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Due Date
                            CommonWidgets.textDisplay(
                                Constants.duedate, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: dueDateTextController,
                              // isDisabled:
                              // state.model.keyHandingOverDuration == 2 &&
                              //     (state.model.status == null ||
                              //         state.model.status ==
                              //             ConstantsIntValue
                              //                 .issuanceDraftStatus)
                              //     ? false
                              //     : true,
                              onlyDate: false,
                              showPastDate: false,
                              onChange: (String value) {
                                dueDateTextController.text = value;
                                state.model.dueDate = Utils().formatTime(value);
                                BlocProvider.of<TicketingSystemDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                                //},
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Tracker
                            CommonWidgets.textDisplay(
                              Constants.tracker,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            TextFieldAddButton(
                              title: state.model.tracker?.name ?? 'Sept_Sprint',
                              height: 70,
                              isDisableColor: isReadOnly,
                              onTap: () {
                                // if (!isReadOnly) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());

                                BaseOrganisationDialog().departmentDialog(
                                  context: context,
                                  organisations: state.trackers,
                                  onTap: (Organisation department) {
                                    state.model.tracker?.name = department.name;

                                    BlocProvider.of<
                                                TicketingSystemDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                            trackers: department);
                                    // FocusScope.of(context)
                                    //     .requestFocus(receivedByFocusNode);
                                  },
                                  // orgName: 'EMPLOYEE_DEPARTMENTS',
                                  // createEntity: false,
                                  // title: 'Add Department',
                                  // functionToCall: () {
                                  //   // refresh the list
                                  //   BlocProvider.of<
                                  //               MaterialMovementDetailsCubit>(
                                  //           context)
                                  //       .refreshList();
                                  // }
                                );
                                // leodepartmentsDialog(stat
                                // }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Description
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.detailDes ??
                                //     state.labels?.defaultLocale.detailDes ??
                                Constants.description,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              characterLimit:
                                  Constants.characterLimitDescTextFormField,
                              initialValue: state.model.description,
                              showBorder: true,
                              textFormKey: Keys.incidentDescription,
                              hintText: Constants.informationhere,
                              // isEnable: state.model.status != 2,
                              // isDisableColor:
                              // state.model.status == 2 || disableForm,
                              onChange: (String value) {
                                state.model.description = value;
                                context
                                    .read<TicketingSystemDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            if (state.model.id != null) ...[
                              /// History
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.detailDes ??
                                  //     state.labels?.defaultLocale.detailDes ??
                                  Constants.history,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
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
                                  // state.model.history = value;
                                  // context
                                  //     .read<TicketingSystemDetailsCubit>()
                                  //     .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Notes
                              CommonWidgets.textDisplay(
                                  Constants.notes,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                characterLimit:
                                    Constants.characterLimitDescTextFormField,
                                // initialValue: state.model.history,
                                showBorder: true,
                                textFormKey: Keys.incidentDescription,
                                hintText: Constants.informationhere,
                                isEnable: state.model.status != 9,
                                isDisableColor: state.model.status == 9,
                                onChange: (String value) {
                                  state.model.history = value;
                                  context
                                      .read<TicketingSystemDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            /// upload
                            CommonWidgets.textDisplay(
                                Constants.uploadPhoto, Styles.textStyleBlack14),
                            // widget.guardingMasterData == null
                            //     ? CommonWidgets.verticalSpacerWidget(
                            //     height * 0.001)
                            //     : Container(),
                            // AbsorbPointer(
                            BaseImageUpload().uploadWidget(
                              context: context,
                              // isDisabled: disableForm,
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
                            // ),
                            /// Attachments
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: BaseImageUpload().getAttachment(
                                height: height,
                                attachments: state.uploadAttachments,
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
                          cancelButtonDisplay(),
                          if ((state.model.status != 9) ? true : false) ...[
                            submitButtonDisplay()
                          ],
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ],
                  ),
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
