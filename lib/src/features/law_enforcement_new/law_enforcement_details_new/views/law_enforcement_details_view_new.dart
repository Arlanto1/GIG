import 'dart:developer';
import 'dart:ui';

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

class _LawEnforcementNewDetailsViewState
    extends State<LawEnforcementNewDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController statusController = TextEditingController();
  TextEditingController timeOfVisitController = TextEditingController();
  TextEditingController dbOfficialWantToMeetController =
      TextEditingController();

  List<ImageContent> uploadFiles = [];

  bool isReadOnly = false;
  bool isEdit = false;

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LawEnforcementDetailsCubit>(context).initializeValues();
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
    return BlocConsumer<LawEnforcementDetailsCubit, LawEnforcementDetailsState>(
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
              Navigator.popAndPushNamed(context, lawEnforcementNewListRoute);
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
      },
      builder: (context, state) {
        dbOfficialWantToMeetController.text = state.model.dbOfficialEmail ?? '';

        if (state.model.status == null) {
          isEdit = true;
        }

        if (state.model.status == 0 &&
            state.model.lock.isEmptyOrNull &&
            state.model.isEligibleToEdit == true) {
          isEdit = true;
        }

        if (state.model.status == 1 &&
            state.model.lock.isEmptyOrNull &&
            state.model.isEligibleToEdit == true) {
          isEdit = true;
        }

        if (state.model.status == 2 &&
            state.model.lock.isEmptyOrNull &&
            state.model.isEligibleToEdit == true) {
          isEdit = true;
        }
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
            showSaveButton:
                isEdit && state.status != FormStatus.loading ? true : false,
            showSubmitButton:
                isEdit && state.status != FormStatus.loading ? true : false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<LawEnforcementDetailsCubit>(context).submitForm(
                isSaveOnly: true,
                navigateToNextScreen: false,
              );
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<LawEnforcementDetailsCubit>(context).submitForm(
                isSaveOnly: false,
                navigateToNextScreen: false,
              );
            },
          ),
          backgroundColor: Colors.transparent,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(LawEnforcementDetailsState state) {
    timeOfVisitController.text = state.model.timeOfVisit != null
        ? Utils.timestampToDateConversion(
            int.tryParse(state.model.timeOfVisit ?? '') ??
                DateTime.now()
                    .millisecondsSinceEpoch, // Use current timestamp if null
            Constants.fulldateFormat)
        : '';
  }

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

    return Stack(
      children: [
        // 🔹 Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg2.png',
            fit: BoxFit.cover,
          ),
        ),

        // 🔹 Blur Layer
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child: Container(
              color: Colors.black.withValues(alpha: 0.08), // optional tint
            ),
          ),
        ),

        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  Constants.generalinformation,
                                  style: Styles.textStyleRegularNormalWhite18,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Status
                              CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
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

                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Date of Creation
                              CommonWidgets.textDisplay(
                                state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              dateCreateWidgetDisplay(
                                  state.model.inputDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Created By
                              CommonWidgets.horizontalTextHandling(
                                state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}',
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Location
                              CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseLocationDropdown().locationWidgetDisplay(
                                  context: context,
                                  isEnabled: isEdit,
                                  locations: state.locations ?? Locations(),
                                  selectedLocationName:
                                      state.model.location?.name ?? '',
                                  onTap: (Organisation? location) {
                                    BlocProvider.of<LawEnforcementDetailsCubit>(
                                            context)
                                        .updateLocationDropdownValue(
                                            location: location);
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Sl no
                              CommonWidgets.horizontalTextHandling(
                                state.labels?.locale.slNo ??
                                    state.labels?.defaultLocale.slNo ??
                                    Constants.slno,
                                state.model.slNo ?? '',
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Entity
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.entity ??
                                      state.labels?.defaultLocale.entity ??
                                      Constants.entity,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseEntitiesSelection().entityDropDownSelection(
                                context: context,
                                selectedValues: state.model.entities ?? [],
                                all: state.listOfEntities ?? [],
                                enabled: isEdit,
                                onTap: (List<Organisation> selectedEntities) {
                                  BlocProvider.of<LawEnforcementDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          entities: selectedEntities);
                                  Navigator.of(context).pop();
                                },
                                orgName: 'ATOM_ENTITIES',
                                functionToCall: () {
                                  BlocProvider.of<LawEnforcementDetailsCubit>(
                                          context)
                                      .refreshList();
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Actual Time of Visit
                              CommonWidgets.textDisplay(
                                state.labels?.locale.timeOfVisit ??
                                    state.labels?.defaultLocale.timeOfVisit ??
                                    Constants.actualtimeofvisit,
                                isMandatory: true,
                                Styles.textStyleWhite16,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDate().datePickerWidgetLoading(
                                textController: timeOfVisitController,
                                isDisabled: !isEdit,
                                onlyDate: false,
                                showPastDate: true,
                                showFutureDate: false,
                                onChange: (String value) {
                                  timeOfVisitController.text = value;
                                  state.model.timeOfVisit =
                                      Utils().formatTime(value);
                                  BlocProvider.of<LawEnforcementDetailsCubit>(
                                          context)
                                      .onModelValueChange(state.model);
                                },
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Official ID Card Verified?
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.officialCardVerified ??
                                      state.labels?.defaultLocale
                                          .officialCardVerified ??
                                      Constants.officialsidcardverified,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.officialCardVerified ? 1 : 0,
                                  onChangedYes: state.model.status != null &&
                                          state.model.status != 0
                                      ? null
                                      : (val) {
                                          state.model.officialCardVerified =
                                              true;
                                          BlocProvider.of<
                                                      LawEnforcementDetailsCubit>(
                                                  context)
                                              .onCheckBoxChange(state.model);
                                        },
                                  onChangedNo: state.model.status != null &&
                                          state.model.status != 0
                                      ? null
                                      : (val) {
                                          state.model.officialCardVerified =
                                              false;
                                          BlocProvider.of<
                                                      LawEnforcementDetailsCubit>(
                                                  context)
                                              .onCheckBoxChange(state.model);
                                        }),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Purpose of visit
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.visitPurpose ??
                                      state
                                          .labels?.defaultLocale.visitPurpose ??
                                      Constants.purposeOfVisit,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              TextFieldAddButton(
                                title: state.model.visitPurpose?.name,
                                height: 70,
                                isDisableColor: !isEdit,
                                onTap: () {
                                  if (isEdit) {
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
                                        functionToCall: () {
                                          // refresh the list
                                          BlocProvider.of<
                                                      LawEnforcementDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        });
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Document if any to confirm purpose
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.documentVerified ??
                                      state.labels?.defaultLocale
                                          .documentVerified ??
                                      Constants.documentifanytoconfirmpurpose,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.documentVerified ? 1 : 0,
                                  onChangedYes: state.model.status != null &&
                                          state.model.status != 0
                                      ? null
                                      : (val) {
                                          state.model.documentVerified = true;
                                          BlocProvider.of<
                                                      LawEnforcementDetailsCubit>(
                                                  context)
                                              .onCheckBoxChange(state.model);
                                        },
                                  onChangedNo: state.model.status != null &&
                                          state.model.status != 0
                                      ? null
                                      : (val) {
                                          state.model.documentVerified = false;
                                          BlocProvider.of<
                                                      LawEnforcementDetailsCubit>(
                                                  context)
                                              .onCheckBoxChange(state.model);
                                        }),

                              /// In case of Police, was official in uniform?
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.visitorInUniform ??
                                      state.labels?.defaultLocale
                                          .visitorInUniform ??
                                      Constants
                                          .incaseofpolicewasofficialinuniform,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.visitorInUniform ? 1 : 0,
                                  onChangedYes: state.model.status != null &&
                                          state.model.status != 0
                                      ? null
                                      : (val) {
                                          state.model.visitorInUniform = true;
                                          BlocProvider.of<
                                                      LawEnforcementDetailsCubit>(
                                                  context)
                                              .onCheckBoxChange(state.model);
                                        },
                                  onChangedNo: state.model.status != null &&
                                          state.model.status != 0
                                      ? null
                                      : (val) {
                                          state.model.visitorInUniform = false;
                                          BlocProvider.of<
                                                      LawEnforcementDetailsCubit>(
                                                  context)
                                              .onCheckBoxChange(state.model);
                                        }),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// DB official want to meet
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.dbOfficialEmail ??
                                      state.labels?.defaultLocale
                                          .dbOfficialEmail ??
                                      Constants.dbofficialwanttomeet,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                controller: dbOfficialWantToMeetController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.contactNoKey,
                                hintText: '',
                                isEnable: isEdit,
                                isDisableColor: !isEdit,
                                onChange: (String value) {
                                  state.model.dbOfficialEmail = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///DB official Department
                              CommonWidgets.textDisplay(
                                state.labels?.locale.dbOfficialEmailDepartment ??
                                    state.labels?.defaultLocale
                                        .dbOfficialEmailDepartment ??
                                    Constants.dbofficialdepartment,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              TextFieldAddButton(
                                title:
                                    state.model.dbOfficialEmailDepartment?.name,
                                height: 70,
                                isDisableColor: !isEdit,
                                onTap: () {
                                  if (isEdit) {
                                    BaseOrganisationDialog().departmentDialog(
                                        context: context,
                                        organisations: state.department,
                                        onTap: (Organisation department) {
                                          state.model.dbOfficialEmailDepartment
                                              ?.name = department.name;

                                          BlocProvider.of<
                                                      LawEnforcementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  department: department);
                                        },
                                        functionToCall: () {
                                          // refresh the list
                                          BlocProvider.of<
                                                      LawEnforcementDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        });
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Db Official email ID Accompanied LEO Official
                              CommonWidgets.textDisplay(
                                  state.labels?.locale
                                          .dbOfficialAccompaniedEmail ??
                                      state.labels?.defaultLocale
                                          .dbOfficialAccompaniedEmail ??
                                      Constants
                                          .dbofficialemailidaccompaniedleoofficial,
                                  Styles.textStyleWhite16,
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
                                                  dbOfficialEmail: user);
                                        },
                                        roleName:
                                            ConstantUserRoles.atomStaticUser,
                                        locationId: state.model.location!.id!,
                                        functionToCall: (BaseUser user) {
                                          BlocProvider.of<
                                                      LawEnforcementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  dbOfficialEmail: user);
                                          BlocProvider.of<
                                                      LawEnforcementDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        },
                                      );
                                    }
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Additional Information
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.additionalInformation ??
                                      state.labels?.defaultLocale
                                          .additionalInformation ??
                                      Constants.additionalinformation,
                                  Styles.textStyleWhite16,
                                  isMandatory: false),
                              FlutterInputField(
                                lineHeight: 6,
                                characterLimit:
                                    Constants.characterLimitDescTextFormField,
                                initialValue: state.model.additionalInformation,
                                textFormKey: Keys.premisesRoundTknCommentsKey,
                                hintText: Constants.informationhere,
                                showBorder: true,
                                textInputAction: TextInputAction.newline,
                                textInputType: TextInputType.multiline,
                                isEnable: isEdit,
                                isDisableColor: !isEdit,
                                onChange: (String value) {
                                  state.model.additionalInformation = value;
                                  context
                                      .read<LawEnforcementDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Attachments
                              CommonWidgets.textDisplay(Constants.attachments,
                                  Styles.textStyleWhite16),
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
                                    for (ImageContent image in uploadFiles) {
                                      files.add(image);
                                    }
                                    BlocProvider.of<LawEnforcementDetailsCubit>(
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
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: BaseImageUpload().getAttachment(
                                    height: height,
                                    attachments: state.loadAttachments,
                                    files: uploadFiles,
                                    moduleCode: Constants.leoModuleCode,
                                    isDisabled: false,
                                    showDeleteIcon: isEdit,
                                  ),
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (widget.model?.status ==
                                      ConstantsIntValue.leoStatusSubmitted ||
                                  widget.model?.status ==
                                      ConstantsIntValue
                                          .leoStatusVerificationUnderProgress ||
                                  widget.model?.status ==
                                      ConstantsIntValue
                                          .leoStatusDistributed) ...[
                                ///Distribution Groups
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.distributionList ??
                                        state.labels?.defaultLocale
                                            .distributionList ??
                                        Constants.distributiongroups,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                BaseEntitiesSelection().entityDropDownSelection(
                                  context: context,
                                  selectedValues: state.model.mailList ?? [],
                                  all: state.distributionGroups ?? [],
                                  enabled: isEdit,
                                  onTap: (List<Organisation> selectedGroups) {
                                    BlocProvider.of<LawEnforcementDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                            distributionGroups: selectedGroups);
                                    Navigator.of(context).pop();
                                  },
                                  functionToCall: () {
                                    BlocProvider.of<LawEnforcementDetailsCubit>(
                                            context)
                                        .refreshList();
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],
                              if (state.model.id != null) ...[
                                /// Modified Date
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.date ??
                                  //     state.labels?.defaultLocale.date ??
                                  Constants.modifiedOn,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                datecreateWidgetdisplay(
                                    state.model.modifiedDate ?? ''),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Modified By
                                CommonWidgets.horizontalTextHandling(
                                    // state.labels?.locale.entrySecurity ??
                                    //     state.labels?.defaultLocale.entrySecurity ??
                                    Constants.modifiedBy,
                                    isMandatory: true,
                                    state.model.modifiedBy ?? ''),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
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
                            // child: Text(
                            //   Constants.visitingOfficialDetails,
                            //   style: Styles.styleHeaderGreyText16,
                            // ),
                            child: CommonWidgets.textDisplay(
                                // state.labels?.locale.additionalInformation ??
                                //     state.labels?.defaultLocale.additionalInformation ??
                                Constants.visitingOfficialDetails,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          GestureDetector(
                            onTap: () async {
                              NavigatorState nav = Navigator.of(context);
                              if (state.model.status == 0 ||
                                  state.model.status == null) {
                                bool isSaveSuccess = await BlocProvider.of<
                                        LawEnforcementDetailsCubit>(context)
                                    .submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );

                                if (!isSaveSuccess) {
                                  return;
                                }
                                log('--state.model.id---${state.model.id}--');
                              }
                              nav.pushNamed(
                                visitingOfficialListRoute,
                                arguments: {
                                  ConstantsArgument.title:
                                      Constants.visitingOfficials,
                                  ConstantsArgument.keyLostType: 0,
                                  ConstantsArgument.id: state.model.id,
                                  ConstantsArgument.departments:
                                      state.visitingDepartment,
                                  ConstantsArgument.showSaveButton:
                                      (widget.model?.status != 3) && !isReadOnly
                                          ? true
                                          : false,
                                  ConstantsArgument.isEligibleToEdit:
                                      widget.model?.id == null
                                          ? true
                                          : state.model.isEligibleToEdit
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SvgPicture.asset(
                                  AppIcon.plusCircle,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white70,
                                    BlendMode.srcIn,
                                  ),
                                  // color: AppColors.navigationSkyBlueColor,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Add/View Visiting Officials',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white),
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
                        if ((isEdit)) ...[
                          cancelButtonDisplay(),
                          submitButtonDisplay()
                        ],
                      ],
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.04),
                  ],
                ),
              ),
              if (state.model.status == ConstantsIntValue.cancelledStatus ||
                  !isEdit) ...[
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: ShapeDecoration(
                    color: AppColors.newColor3,
                    shape: const RoundedRectangleBorder(
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
      ],
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
