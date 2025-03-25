import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/law_enforcement_new/models/law_enforcement_model_new.dart';

import '../cubits/law_enforcement_details_cubit_new.dart';

class LawEnforcementNewDetailsView extends StatefulWidget {
  final LawEnforcementModelNew? model;
  final String title;
  final ExtraProperties? extraProperties;

  const LawEnforcementNewDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<LawEnforcementNewDetailsView> createState() =>
      _LawEnforcementNewDetailsViewState();
}

class _LawEnforcementNewDetailsViewState extends State<LawEnforcementNewDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController statusController = TextEditingController();
  TextEditingController timeOfVisitController = TextEditingController();
  TextEditingController dbOfficialWantToMeetController = TextEditingController();


  List<ImageContent> uploadFiles = [];

  bool isReadOnly = false;
  bool isEdit = false;

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LawEnforcementDetailsCubit>(context)
        .initializeValues();
    // initializeDates(state);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<LawEnforcementDetailsCubit,
        LawEnforcementDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Law Enforcement',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                  context, lawEnforcementNewListRoute);
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);

        }
      },
      builder: (context, state) {
        dbOfficialWantToMeetController.text = state.model.dbOfficialEmail??'';

        if (state.model.status == null) {
          isEdit = true;
        }
        if (state.model.status == 0 && state.model.lock.isEmptyOrNull) {
          isEdit = true;
        }

        if (state.model.status == 1 && state.model.lock.isEmptyOrNull) {
          isEdit = true;
        }

        if (state.model.status == 2 && state.model.lock.isEmptyOrNull) {
          isEdit = true;
        }
        // if (state.model.status == -1 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        if (state.model.status == null) {
          isReadOnly = false;
        }
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isReadOnly = true;
        // }

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            pdfAPIName:
            '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.leoModuleCode}',
            showSaveButton: isEdit && state.status != FormStatus.loading
                ? true
                : false,
            showSubmitButton: isEdit && state.status != FormStatus.loading
                ? true
                : false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<LawEnforcementDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: true,
                navigateToNextScreen: false,
              );
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<LawEnforcementDetailsCubit>(context)
                  .submitForm(
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

  void initializeDates(LawEnforcementDetailsState state) {
    timeOfVisitController.text =
    state.model.timeOfVisit != null ? Utils.timestampToDateConversion(
        int.tryParse(state.model.timeOfVisit ?? '') ??
            DateTime
                .now()
                .millisecondsSinceEpoch, // Use current timestamp if null
        Constants.fulldateFormat) : '';  }

  getBodybuilder(LawEnforcementDetailsState state, height) {

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      uploadFiles = state.loadAttachments;
      uploadFiles = state.model.images ?? [];
    }

    initializeDates(state);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AbsorbPointer(
                    absorbing: isReadOnly,
                    child: Form(
                      key: _formKey,
                      autovalidateMode: isReadOnly
                          ? AutovalidateMode.disabled
                          : AutovalidateMode.onUserInteraction,
                      child: Padding(
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

                            ///Status
                            CommonWidgets.textDisplay(
                              state.labels?.locale.status ??
                                  state.labels?.defaultLocale.status ??
                                  Constants.status,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              isEnable: false,
                              isDisableColor: true,
                              textFormKey: Keys.statusTextController,
                              hintText: '',
                              initialValue: Utils().buildLeoStatusRow(
                                  state.model.status ?? 0,
                                  returnTextOnly: true),
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),

                            ///Date of Creation
                            CommonWidgets.textDisplay(
                              state.labels?.locale.inputDate ??
                                  state.labels?.defaultLocale.inputDate ??
                                  Constants.dateofcreation,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            dateCreateWidgetDisplay(
                                state.model.inputDate ?? ''),

                            ///Created By
                            CommonWidgets.verticalTextHandling(
                              state.labels?.locale.entrySecurity ??
                                  state.labels?.defaultLocale.entrySecurity ??
                                  Constants.createdby,
                              '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}',
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Location
                            CommonWidgets.textDisplay(
                              state.labels?.locale.location ??
                                  state.labels?.defaultLocale.location ??
                                  Constants.location,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseLocationDropdown().locationWidgetDisplay(
                                context: context,
                                isEnabled: isEdit,
                                locations: state.locations ?? Locations(),
                                selectedLocationName:
                                state.model.location?.name ?? '',
                                onTap: (Organisation? location) {
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context)
                                      .updateLocationDropdownValue(
                                      location: location);
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Sl no
                            CommonWidgets.horizentaltextHandling(
                              state.labels?.locale.slNo ??
                                  state.labels?.defaultLocale.slNo ??
                                  Constants.slno,
                              state.model.slNo ?? '',
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Entity
                            CommonWidgets.textDisplay(
                                state.labels?.locale.entity ??
                                    state.labels?.defaultLocale.entity ??
                                    Constants.entity,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseEntitiesSelection().entityDropDownSelection(
                              context: context,
                              selectedValues: state.model.entities ?? [],
                              all: state.listOfEntities ?? [],
                              enabled: isEdit,
                              onTap: (List<Organisation> selectedEntities) {
                                log('--selectedEntities----${selectedEntities.length}');
                                BlocProvider.of<
                                    LawEnforcementDetailsCubit>(
                                    context)
                                    .updateDropdownValues(
                                    entities: selectedEntities);
                                Navigator.of(context).pop();
                              },
                              orgName: 'ATOM_ENTITIES',
                              functionToCall: () {
                                BlocProvider.of<
                                    LawEnforcementDetailsCubit>(
                                    context)
                                    .refreshList();
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Actual Time of Visit
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.keyHandOverDue ??
                              //     state.labels?.defaultLocale
                              // .keyHandOverDue ??
                              Constants.actualtimeofvisit,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: timeOfVisitController,
                              isDisabled: !isEdit,
                              onlyDate: false,
                              showPastDate: true,
                              showFutureDate: false,
                              // fromDate: initialisedStartDate,
                              // toDate: initialisedToDate,
                              onChange: (String value) {
                                // isDateSelectedByUser = true;
                                timeOfVisitController.text = value;
                                state.model.timeOfVisit =
                                    Utils().formatTime(value);
                                // state.model.startTime =
                                //     Utils().formatTime(value);
                                BlocProvider.of<
                                    LawEnforcementDetailsCubit>(
                                    context)
                                    .onModelValueChange(state.model);
                                //},
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Official ID Card Verified?
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.premisesRoundTkn ??
                              //     state.labels?.defaultLocale
                              //         .premisesRoundTkn ??
                                Constants.officialsidcardverified,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                state.model.officialCardVerified ? 1 : 0,
                                onChangedYes: state.model.status != null && state.model.status != 0
                                    ? null
                                    : (val) {
                                  state.model.officialCardVerified= true;
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context)
                                      .onCheckBoxChange(state.model);
                                },
                                onChangedNo:state.model.status != null && state.model.status != 0
                                    ? null
                                    : (val) {
                                  state.model.officialCardVerified = false;
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context)
                                      .onCheckBoxChange(state.model);
                                }),

                            /// Purpose of visit
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.typeOfService ??
                                //     state.labels?.defaultLocale.typeOfService ??
                                    Constants.purposeOfVisit,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            TextFieldAddButton(
                              title: state.model.visitPurpose?.name,
                              height: 70,
                              isDisableColor: !isEdit,
                              onTap: () {
                                if (isEdit) {
                                // if (widget.materialMovement != null) {
                                BaseOrganisationDialog().departmentDialog(
                                    context: context,
                                    organisations: state.visitPurpose,
                                    onTap: (Organisation visitPurpose) {
                                      state.model.visitPurpose?.name =
                                          visitPurpose.name;

                                      BlocProvider.of<
                                          LawEnforcementDetailsCubit>(
                                          context)
                                          .updateDropdownValues(
                                          visitPurpose: visitPurpose);
                                    },
                                    // orgName: 'EMPLOYEE_DEPARTMENTS',
                                    // createEntity: false,
                                    // title: 'Add Department',
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<
                                          LawEnforcementDetailsCubit>(
                                          context)
                                          .refreshList();
                                    });
                                }
                                // leodepartmentsDialog(state);
                                // }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Document if any to confirm purpose
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.premisesRoundTkn ??
                              //     state.labels?.defaultLocale
                              //         .premisesRoundTkn ??
                                Constants.documentifanytoconfirmpurpose,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                state.model.documentVerified? 1 : 0,
                                onChangedYes: state.model.status != null && state.model.status != 0
                                    ? null
                                    : (val) {
                                  state.model.documentVerified = true;
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context).onCheckBoxChange(state.model);
                                  //.onModelValueChange(state.guardingMasterData
                                  //);
                                },
                                onChangedNo: state.model.status != null && state.model.status != 0
                                    ? null
                                    : (val) {
                                  state.model.documentVerified = false;
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context).onCheckBoxChange(state.model);
                                }),

                            /// In case of Police, was official in uniform?
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.premisesRoundTkn ??
                                //     state.labels?.defaultLocale
                                //         .premisesRoundTkn ??
                                    Constants.incaseofpolicewasofficialinuniform,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                state.model.visitorInUniform? 1 : 0,
                                onChangedYes: state.model.status != null && state.model.status != 0
                                    ? null
                                    : (val) {
                                  state.model.visitorInUniform = true;
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context).onCheckBoxChange(state.model);
                                  //.onModelValueChange(state.guardingMasterData
                                  //);
                                },
                                onChangedNo: state.model.status != null && state.model.status != 0
                                    ? null
                                    : (val) {
                                  state.model.visitorInUniform = false;
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context).onCheckBoxChange(state.model);
                                }),


                            /// DB official want to meet
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.name ??
                              //     state.labels?.defaultLocale
                              //         .name ??
                                Constants.dbofficialwanttomeet,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: dbOfficialWantToMeetController,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              // focusNode: employeeIdFocusNode,
                              isEnable: isEdit,
                              isDisableColor: !isEdit,
                              onChange: (String value) {
                                state.model.dbOfficialEmail = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),


                            ///DB official Department
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.vendor ??
                              //     state.labels?.defaultLocale.vendor ??
                                  Constants.dbofficialdepartment,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            TextFieldAddButton(
                              title: state.model.dbOfficialEmailDepartment?.name,
                              height: 70,
                              isDisableColor: !isEdit,
                              onTap: () {
                                if (isEdit) {
                                  // if (widget.materialMovement != null) {
                                  BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.department,
                                      onTap: (Organisation department) {
                                        state.model.dbOfficialEmailDepartment?.name =
                                            department.name;

                                        BlocProvider.of<
                                            LawEnforcementDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                            department: department);
                                      },
                                      // orgName: 'EMPLOYEE_DEPARTMENTS',
                                      // createEntity: false,
                                      // title: 'Add Department',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                            LawEnforcementDetailsCubit>(
                                            context)
                                            .refreshList();
                                      });
                                 }
                                // leodepartmentsDialog(state);
                                // }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Db Official email ID Accompanied LEO Official
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.approver ??
                                //     state.labels?.defaultLocale.approver ??
                                    Constants.dbofficialemailidaccompaniedleoofficial,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextFieldAddButton(
                                title: state.model.dbOfficialAccompaniedEmail,
                                height: 70,
                                isDisableColor: !isEdit,
                                onTap: () {
                                  if (isEdit) {
                                    BaseOrganisationDialog().userDialog(
                                      employeeId: false,
                                      context: context,
                                      users: state.users!,
                                      isDbUser: true,
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                            LawEnforcementDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                            dbOfficialEmail:
                                            user);
                                        // FocusScope.of(context).requestFocus(
                                        //     receivedForEmployeeIdFocusNode);
                                      },
                                      roleName: ConstantUserRoles
                                          .atomStaticUser,
                                      locationId:
                                      state.model.location!.id!,
                                      functionToCall: (BaseUser user) {
                                        BlocProvider.of<
                                            LawEnforcementDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                            dbOfficialEmail:
                                            user);
                                        // FocusScope.oedf(context).requestFocus(
                                        //     receivForEmployeeIdFocusNode);
                                        // refresh the list
                                        BlocProvider.of<
                                            LawEnforcementDetailsCubit>(
                                            context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Additional Information
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.approver ??
                              //     state.labels?.defaultLocale.approver ??
                                Constants.additionalinformation,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                              FlutterInputField(
                                lineHeight: 6,
                                characterLimit:
                                Constants.characterLimitDescTextFormField,
                                initialValue:
                                state.model.additionalInformation,
                                textFormKey: Keys.premisesRoundTknCommentsKey,
                                hintText: Constants.informationhere,
                                showBorder: true,
                                textInputAction: TextInputAction.newline,
                                textInputType:
                                TextInputType.multiline,
                                isEnable: isEdit,
                                isDisableColor: !isEdit,
                                onChange: (String value) {
                                  state.model.additionalInformation =
                                      value;
                                  context
                                      .read<LawEnforcementDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),

                            ///Attachments
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.attachment ??
                              //     state.labels?.defaultLocale.attachment ??
                                Constants.attachments,
                                Styles.textStyleBlack14),
                            widget.model == null
                                ? CommonWidgets.verticalSpacerWidget(
                                height * 0.001)
                                : Container(),
                            if (state.model.status == 0 ||
                                state.model.status == null) ...[
                              BaseImageUpload().uploadWidget(
                                context: context,
                                isDisabled: !isEdit,
                                loggedInUserDetails:
                                state.loggedInUserDetails!,
                                getFiles: uploadFiles,
                                onImageSelected: (ImageContent data) {
                                  List<ImageContent>? files = [];
                                  files.add(data);
                                  for (ImageContent image
                                  in uploadFiles ?? []) {
                                    files.add(image);
                                  }
                                  BlocProvider.of<
                                      LawEnforcementDetailsCubit>(
                                      context)
                                      .addAttachment(
                                    data: files,
                                    images: files,
                                  );
                                },
                              ),
                            ],
                            /// Attachments
                            IgnorePointer(
                              ignoring: false,
                              child:  Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: BaseImageUpload().getAttachment(
                                  height: height,
                                  attachments: state.loadAttachments,
                                  files: uploadFiles,
                                  moduleCode: Constants.leoModuleCode,
                                  isDisabled: false,
                                  showDeleteIcon: isEdit ,
                                ),
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            if(widget.model?.status == 2 || widget.model?.status == 3)...[
                            ///Distribution Groups
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.entity ??
                                //     state.labels?.defaultLocale.entity ??
                                    Constants.distributiongroups,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseEntitiesSelection().entityDropDownSelection(
                              context: context,
                              selectedValues: state.model.mailList ?? [],
                              all: state.distributionGroups ?? [],
                              enabled: isEdit,
                              onTap: (List<Organisation> selectedGroups) {
                                BlocProvider.of<
                                    LawEnforcementDetailsCubit>(
                                    context)
                                    .updateDropdownValues(
                                    distributionGroups: selectedGroups);
                                Navigator.of(context).pop();
                              },
                              // orgName: 'ATOM_ENTITIES',
                              functionToCall: () {
                                BlocProvider.of<
                                    LawEnforcementDetailsCubit>(
                                    context)
                                    .refreshList();
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
    ],
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Visiting Officials Details section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Visiting Officials Details
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            Constants.visitingOfficialDetails,
                            style: Styles.styleHeaderGreyText16,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        GestureDetector(
                          onTap: () async {
                            NavigatorState nav = Navigator.of(context);
                            if(widget.model == null || state.model.status == 0 || state.model.status ==1) {
                              bool isSaveSuccess = await BlocProvider.of<
                                  LawEnforcementDetailsCubit>(context)
                                  .submitForm(
                                isSaveOnly: true,
                                navigateToNextScreen: true,
                              );

                              if (!isSaveSuccess) {
                                return;
                              }
                            }
                            log('--state.model.id---${state.model.id}--');
                            // List<Organisation> violationDescriptions =
                            // await CommonServices().getOrganisations(
                            //     name: Constants.visitingOfficialDetails);
                            // nav.pushNamed(
                            //   lawVisitingOfficialViewRoute,
                            //   arguments: {
                            //     ConstantsArgument.id: state.model.id,
                            //     ConstantsArgument.title:
                            //     Constants.visitingOfficials,
                            //     ConstantsArgument.extraProperties:
                            //     ExtraProperties(hasWritePermission: true),
                            //     // ConstantsArgument.isLocked:
                            //     // !state.model.lock.isEmptyOrNull,
                            //     ConstantsArgument.parentStatus:
                            //     state.model.status,
                            //   },
                            // );
                            nav.pushNamed(
                              visitingOfficialListRoute,
                              arguments: {
                                ConstantsArgument.id:
                                state.model.id,
                                ConstantsArgument.title:
                                Constants.visitingOfficials,
                                ConstantsArgument
                                    .departments: state
                                    .visitingDepartment,
                                ConstantsArgument.keyLostType: 0,
                                // ConstantsArgument.models:
                                //     visitingOfficials,
                                ConstantsArgument.showSaveButton:
                                (widget.model?.status != 3) &&
                                    !isReadOnly
                                    ? true
                                    : false,
                              },
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SvgPicture.asset(
                                AppIcon.pluscircle,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.navigationSkyBlueColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                Constants.addOrViewVisitingOfficialDetails,
                                style: TextStyle(
                                  color: AppColors.navigationSkyBlueColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.02),
                      ],
                    ),
                  ),

                  /// SubmitButton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if ((
                          isEdit)) ...[
                        cancelButtonDisplay(),
                        submitButtonDisplay()
                      ],
                    ],
                  ),
                  CommonWidgets.verticalSpacerWidget(height * 0.04),
                ],
              ),
            ),
            if (
                state.model.status == ConstantsIntValue.cancelledStatus ||
                !isEdit) ...[
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(0.0)),
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
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();

        BlocProvider.of<LawEnforcementDetailsCubit>(context).submitForm();
      },
    );
  }

  Widget submitButton({
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

  Widget dateCreateWidgetDisplay(String date) {
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
}
