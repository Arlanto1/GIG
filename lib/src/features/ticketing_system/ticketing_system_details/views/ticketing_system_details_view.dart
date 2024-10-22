import 'dart:developer';

import 'package:db_atom/index.dart';

import '../../models/ticketing_system_model.dart';
import '../cubits/ticketing_system_details_cubit.dart';

class TicketingSystemDetailsView extends StatefulWidget {
  final TicketingSystemModel? model;

  const TicketingSystemDetailsView({
    super.key,
    this.model,
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
  List<ImageContent> getFiles = [];
  List<ImageContent> getAttachments = [];

  final FocusNode receivedByFocusNode = FocusNode();
  final FocusNode quantityFocusNode = FocusNode();

  TextEditingController dueDateTextController = TextEditingController();
  TextEditingController additionalInformationTextController =
      TextEditingController();

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TicketingSystemDetailsCubit>(context).initializeValues();
    initializeDates();
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
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Ticketing System',
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
        // if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        if (state.model.status == null) {
          isReadOnly = false;
        }
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isReadOnly = true;
        // }
        showSaveSubmitButton = state.model.status != -1 &&
            state.model.status != 1 &&
            !isReadOnly &&
            state.model.lock.isEmptyOrNull;
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: 'Ticketing System',
            showPopUp: false,
            showSaveButton: showSaveSubmitButton ? true : false,
            showSubmitButton: showSaveSubmitButton ? true : false,
            showDisLikeButton: false,
            showLikeButton: false,
            // pdfAPIName:
            // '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.vipVisitorsDetailsModule}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<TicketingSystemDetailsCubit>(context).submitForm(
                isSaveOnly: true,
                navigateToNextScreen: false,
              );
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<TicketingSystemDetailsCubit>(context).submitForm(
                isSaveOnly: false,
                navigateToNextScreen: false,
              );
            },
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {
    // TODO: Maybe we can remove this
  }

  getBodybuilder(TicketingSystemDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
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
                              title: state.model.project?.name,
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
                            // CommonWidgets.textDisplay(
                            // Constants.priority,
                            //   Styles.textStyleBlack14,
                            //   isMandatory: true,
                            // ),
                            // CommonWidgets.verticalSpacerWidget(height * 0.001),
                            // FlutterInputField(
                            //   isEnable: false,
                            //   isDisableColor: true,
                            //   textFormKey: Keys.statusTextController,
                            //   hintText: '',
                            //   initialValue:
                            //   getStatusString(state.model.status ?? 0),
                            //   onChange: (String value) {},
                            //   validateTextField: (String? user) {},
                            // ),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),
                            CommonWidgets.textDisplay(
                              Constants.priority,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            TextFieldAddButton(
                              title: state.model.priorityName,
                              height: 70,
                              isDisableColor: isReadOnly,
                              onTap: () {
                                if (!isReadOnly) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.priorities,
                                      onTap: (Organisation department) {
                                        state.model.priorityName =
                                            department.name;

                                        BlocProvider.of<
                                                    MaterialMovementDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                receiverDepartment: department);
                                        FocusScope.of(context)
                                            .requestFocus(receivedByFocusNode);
                                      },
                                      orgName: 'EMPLOYEE_DEPARTMENTS',
                                      createEntity: false,
                                      title: 'Add Department',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    MaterialMovementDetailsCubit>(
                                                context)
                                            .refreshList();
                                      });
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
                                log('--value---$value');

                                state.model.title = value;

                                context
                                    .read<TicketingSystemDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Assignee
                            CommonWidgets.textDisplay(
                              Constants.assigneeName,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            TextFieldAddButton(
                              title: state.model.priorityName,
                              height: 70,
                              isDisableColor: isReadOnly,
                              onTap: () {
                                if (!isReadOnly) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.priorities,
                                      onTap: (Organisation department) {
                                        state.model.priorityName =
                                            department.name;

                                        BlocProvider.of<
                                                    MaterialMovementDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                receiverDepartment: department);
                                        FocusScope.of(context)
                                            .requestFocus(receivedByFocusNode);
                                      },
                                      orgName: 'EMPLOYEE_DEPARTMENTS',
                                      createEntity: false,
                                      title: 'Add Department',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    MaterialMovementDetailsCubit>(
                                                context)
                                            .refreshList();
                                      });
                                  // leodepartmentsDialog(stat
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Start Date
                            CommonWidgets.textDisplay(
                              Constants.startDate,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
                                state.model.createdOn ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Due Date
                            CommonWidgets.textDisplay(
                                Constants.duedate, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDate().datePickerWidgetLoading(
                              showFutureDate: true,
                              showPastDate: false,
                              textController: dueDateTextController,
                              isDisabled: (widget.model?.status !=
                                          ConstantsIntValue
                                              .articleFoundStatusFound &&
                                      widget.model?.status != null)
                                  ? true
                                  : false,
                              //initialDate: DateTime.now().subtract(Duration(days: 1)),
                              onChange: (String value) {
                                widget.model?.createdOn =
                                    Utils().formatTime(value);
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
                              title: state.model.priorityName,
                              height: 70,
                              isDisableColor: isReadOnly,
                              onTap: () {
                                if (!isReadOnly) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.priorities,
                                      onTap: (Organisation department) {
                                        state.model.priorityName =
                                            department.name;

                                        BlocProvider.of<
                                                    MaterialMovementDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                receiverDepartment: department);
                                        FocusScope.of(context)
                                            .requestFocus(receivedByFocusNode);
                                      },
                                      orgName: 'EMPLOYEE_DEPARTMENTS',
                                      createEntity: false,
                                      title: 'Add Department',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    MaterialMovementDetailsCubit>(
                                                context)
                                            .refreshList();
                                      });
                                  // leodepartmentsDialog(stat
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Description
                            CommonWidgets.textDisplay(
                                Constants.description, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              showBorder: true,
                              lineHeight: 6,
                              characterLimit:
                                  Constants.characterLimitDescTextFormField,
                              controller: additionalInformationTextController,
                              textFormKey:
                                  Keys.additionalinformationTextController,
                              hintText: Constants.informationhere,
                              isEnable: (widget.model?.status == 0 ||
                                          widget.model == null) &&
                                      state.model.lock.isEmptyOrNull
                                  ? true
                                  : false,
                              isDisableColor: (widget.model?.status == 0 ||
                                          widget.model == null) &&
                                      state.model.lock.isEmptyOrNull
                                  ? false
                                  : true,
                              onChange: (String username) {
                                // additionalinformationTextController.text += '\n';
                                setState(() {});
                              },
                              validateTextField: (String? user) {},
                              onFieldSubmitted: (String value) {
                                additionalInformationTextController.value =
                                    TextEditingValue(
                                  text:
                                      '${additionalInformationTextController.text}\n',
                                  selection: TextSelection.collapsed(
                                    offset: additionalInformationTextController
                                            .text.length +
                                        1,
                                  ),
                                );
                                FocusScope.of(context)
                                    .requestFocus(quantityFocusNode);
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// upload
                            widget.model?.status == null ||
                                    widget.model?.status == 0
                                ? CommonWidgets.textDisplay(
                                    Constants.attachments,
                                    Styles.textStyleBlack14)
                                : Container(),
                            widget.model?.status == null ||
                                    widget.model?.status == 0
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            (widget.model?.status == null ||
                                        widget.model?.status == 0) &&
                                    state.model.lock.isEmptyOrNull
                                ? uploadWidget(state)
                                : Container(),

                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: [],
                              files: [],
                              showDeleteIcon: true,
                              moduleCode: '',
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            // ],

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
                          if ((state.model.status != -1 &&
                                      state.model.status != 1) &&
                                  showSaveSubmitButton
                              ? true
                              : false) ...[submitButtonDisplay()],
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

  String getStatusString(int status) {
    switch (status) {
      case -1:
        return 'Cancelled';
      case 0:
        return 'Created';
      case 1:
        return 'Submitted';
      default:
        return '';
    }
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

  // Widget cancelButtonDisplay(VVIPVisitorDetailsState state) {
  //   bool condition = widget.model?.id == null ||
  //       widget.model?.status == ConstantsIntValue.cancelledStatus ||
  //       widget.model?.status == 1 ||
  //       !state.model.lock.isEmptyOrNull;
  //   return AppButton(
  //     width: Constants.cancelButtonWidth,
  //     backgroundColor: Colors.white,
  //     key: const Key(Keys.cancelButton),
  //     buttonText: condition ? Constants.close : Constants.cancelRecord,
  //     buttonTextKey: Keys.cancelButton,
  //     onTap: () {
  //       if (condition) {
  //         Navigator.pop(context);
  //         return;
  //       }
  //       var dialog = CustomAlertDialog(
  //           title: Constants.cancelRecord,
  //           message: Constants.cancelRecordWarningMessage,
  //           onPositivePressed: () {
  //             Navigator.pop(context);
  //             Navigator.pop(context);
  //             updateRecordStatus(state);
  //           },
  //           positiveBtnText: Constants.yes,
  //           negativeBtnText: Constants.no);
  //       showDialog(context: context, builder: (BuildContext context) => dialog);
  //     },
  //   );
  // }

  // void updateRecordStatus(VVIPVisitorDetailsState state) {
  //   if (state.model.id != null) {
  //     BlocProvider.of<VVIPVisitorDetailsCubit>(context)
  //         .updateStatus(id: state.model.id.toString());
  //     Navigator.popAndPushNamed(
  //       context,
  //       vipVisitorsListRoute,
  //     );
  //   } else {
  //     Navigator.pop(context);
  //   }
  // }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();

        BlocProvider.of<TicketingSystemDetailsCubit>(context).submitForm();
      },
    );
  }

  Widget locationWidgetdislay(TicketingSystemDetailsState state) {
    return GestureDetector(
      onTap: () {
        if ((state.model.status == 0 || state.model.status == null) &&
            state.model.lock.isEmptyOrNull) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return CustomExpansionListTexts(
                onTap: (Organisation? list) async {
                  Organisation location = Organisation();
                  location.id = list?.id;
                  location.name = list?.name;

                  BlocProvider.of<TicketingSystemDetailsCubit>(context)
                      .updateDropdownValues(location: location);
                },
              );
            },
          );
        }
      },
    );
  }

  Widget datecreateWidgetdisplay(String date) {
    return FlutterInputField(
      textFormKey: Keys.dateofcreationTextController,
      initialValue: date,
      hintText: '',
      isEnable: false,
      isDisableColor: true,
      onChange: (String value) {},
      validateTextField: (String? user) {},
    );
  }

  Widget uploadWidget(TicketingSystemDetailsState state) {
    return widget.model?.status == null ||
            widget.model?.status == 0 ||
            widget.model?.status == 1
        ? Container(
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFCACACA),
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(140, 50),
                    backgroundColor: !isReadOnly && true
                        ? AppColors.navigationSkyBlueColor
                        : AppColors.geryLightBackground,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return UploadAttachment(
                            userdetails: state.loggedInUserDetails ?? User(),
                            getFiles: getFiles,
                            onImageSelected: (ImageContent data) {
                              log('-------function---onImageSelected---------');
                              List<ImageContent>? files = [];
                              files.add(data);
                              for (ImageContent image in getFiles.toList()) {
                                files.add(image);
                              }
                              BlocProvider.of<TicketingSystemDetailsCubit>(
                                      context)
                                  .addAttachment(files);
                            },
                          );
                        });
                  },

                  icon: SvgPicture.asset(
                    //AppIcon.dropdownicon,
                    AppIcon.uploadicon,
                    //fit: BoxFit.,
                    colorFilter: const ColorFilter.mode(
                      AppColors.backgroundWhiteColor,
                      BlendMode.srcIn,
                    ),
                    // color: AppColors.backgroundWhiteColor,
                    width: 13,
                    height: 13,
                    key: const Key(Keys.userIcon),
                  ),
                  label: const Text(
                    Constants.clicktoupload,
                    style: Styles.textStyleRegularNormalWhite12,
                  ), // <-- Text
                ),
              ),
            ]),
          )
        : Container();
  }
}
