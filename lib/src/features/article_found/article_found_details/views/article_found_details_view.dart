import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found/article_found_details/cubits/article_found_details_cubit.dart';
import 'package:db_atom/src/features/article_found/models/article_found_model.dart';

class ArticleFoundDetailsView extends StatefulWidget {
  final ArticleFoundModel? model;
  final String title;
  final ExtraProperties? extraProperties;
  final int? eventId; // For creating Article Found inside Event Protection
  final String?
      eventProtectionId; // For creating Article Found inside Event Protection
  final Organisation? eventProtectionLocation;

  const ArticleFoundDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
    this.eventId,
    this.eventProtectionId,
    this.eventProtectionLocation,
  });

  @override
  State<ArticleFoundDetailsView> createState() =>
      _ArticleFoundDetailsViewState();
}

class _ArticleFoundDetailsViewState extends State<ArticleFoundDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController returnableTextController = TextEditingController();

  User? userDetails;
  List<ImageContent> getFiles = [];
  TextEditingController takenOutOnDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController expectedDateOfReturnController =
      TextEditingController();
  TextEditingController foundDateController = TextEditingController();
  TextEditingController passValidUntilController = TextEditingController();
  bool isReadOnly = false;
  TextEditingController passTypeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController foundLocationController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController depositorController = TextEditingController();
  TextEditingController depositorTextController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController returnedTimeController = TextEditingController();
  TextEditingController claimantController = TextEditingController();
  TextEditingController claimantTextController = TextEditingController();
  final FocusNode sentToFocusNode = FocusNode();

  List<ImageContent> uploadFiles = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ArticleFoundDetailsCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool showSaveSubmitButtons = false;
  bool lock = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<ArticleFoundDetailsCubit, ArticleFoundDetailsState>(
      listener: (context, state) {
        log('-state.status--${state.status}--');
        log('123 ${state.message}--');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (widget.eventId != null && state.status == FormStatus.success) {
          // Navigator.pop(context);
          Navigator.popAndPushNamed(
            context,
            eventInfoRoute,
            arguments: {
              ConstantsArgument.title: Constants.afterEventInformation,
              ConstantsArgument.id: widget.eventProtectionId.toString(),
              'eventDuration': 2,

              /// 2 is for After the Event
              ConstantsArgument.editForm: true,
              ConstantsArgument.isEventProtection: true,
            },
          );
          return;
        }
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.articleFoundRegisterListTitle,
            message: state.message,
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, articleFoundNewListRoute,
                  arguments: {});
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
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
              BlocProvider.of<ArticleFoundDetailsCubit>(context).submitForm(
                isSaveOnly: true,
              );
            },
            showSubmitButton:
                showSaveSubmitButtons && state.status != FormStatus.loading,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<ArticleFoundDetailsCubit>(context).submitForm(
                isSaveOnly: false,
              );
            },
            showLikeButton: false,
            showDisLikeButton: false,
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
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

  getBodybuilder(ArticleFoundDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      uploadFiles = state.uploadAttachments;
      uploadFiles = state.model.images ?? [];
    }

    return Stack(children: [
      // 🌄 Background Image
      Positioned.fill(
        // child: Image.asset(
        //   'assets/images/bc.png', // 🔹 Replace with your image path
        //   fit: BoxFit.cover,              // makes it fill the screen
        // ),
        child: Container(
          // color: const Color(0xFF6474C6),
          color: AppColors.newColor3
        ),
      ),
      // Positioned.fill(
      //   child: Container(
      //     color: Colors.white.withValues(alpha: 0.1), // adjust opacity as needed
      //   ),
      // ),
      Container(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // decoration: const ShapeDecoration(
                //     color: AppColors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius:
                //       BorderRadius.vertical(top: Radius.circular(0.0)),
                //     )),
                child: Form(
                  key: _formKey,
                  autovalidateMode: isReadOnly
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AbsorbPointer(
                          absorbing:
                              !showSaveSubmitButtons && IgnorePointer == false,
                          child: Column(
                            children: [
                              // if (!state.model.lock.isEmptyOrNull) ...[
                              //   RecordLockedWidget(text: '${state.model.lock}'),
                              // ],
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  Constants.generalinformation,
                                  style: Styles.textStyleWhite16,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Status
                              CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                isDisabled: false,
                                textController: statusController,
                                items: articleFoundStatus,
                                initialValue: '${state.model.status ?? 0}',
                                onTap: () {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// Created By
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.createdby,
                                  isMandatory: true,
                                  '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Location
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
                                  isEnabled: (!isReadOnly) && !lock,
                                  context: context,
                                  locations: state.locations ?? Locations(),
                                  selectedLocationName:
                                      state.model.location?.name ?? '',
                                  onTap: (Organisation? location) {
                                    BlocProvider.of<ArticleFoundDetailsCubit>(
                                            context)
                                        .updateLocationDropdownValue(
                                            location: location);
                                  }),

                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// Date of creation
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
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// Sl No.
                              CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.slNo ??
                                    state.labels?.defaultLocale.slNo ??
                                    Constants.slno,
                                state.model.slNo ?? '',
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// Article Type
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.companyType ??
                                  //     state.labels?.defaultLocale
                                  //         .companyType ??
                                  Constants.articleType,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.typeOfArticle?.name,
                                height: 75,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.articleType,
                                      onTap: (Organisation articleType) {
                                        BlocProvider.of<
                                                    ArticleFoundDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                articleType: articleType);
                                      },
                                      leftImage: false,
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    ArticleFoundDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// Found Date
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.timeOfVisit ??
                                //     state.labels?.defaultLocale
                                //         .timeOfVisit ??
                                Constants.founddate,
                                isMandatory: true,
                                Styles.textStyleWhite16,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDate().datePickerWidgetLoading(
                                textController: foundDateController,
                                isDisabled: isReadOnly,
                                onlyDate: false,
                                showPastDate: true,
                                showFutureDate: false,
                                onChange: (String value) {
                                  foundDateController.text = value;
                                  state.model.foundDate =
                                      Utils().formatTime(value);
                                  BlocProvider.of<ArticleFoundDetailsCubit>(
                                          context)
                                      .onModelValueChange(state.model);
                                },
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Found Location
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.companyName ??
                                //     state.labels?.defaultLocale.companyName ??
                                Constants.foundlocation,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.text,
                                textFormKey: Keys.challanKey,
                                controller: foundLocationController,
                                characterLimit:
                                    Constants.characterLimitIdTextFormField,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// Additional Information
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.additionalInformation ??
                                  //     state.labels?.defaultLocale.additionalInformation ??
                                  Constants.additionalinformation,
                                  Styles.textStyleWhite16,
                                  isMandatory: false),
                              FlutterInputField(
                                lineHeight: 5,
                                characterLimit:
                                    Constants.characterLimitDescTextFormField,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// Quantity
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.companyName ??
                                //     state.labels?.defaultLocale.companyName ??
                                Constants.quantity,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.number,
                                textFormKey: Keys.challanKey,
                                initialValue: '${state.model.quantity ?? ''}',
                                characterLimit:
                                    Constants.characterLimitIdTextFormField,
                                hintText: '',
                                isEnable: !isReadOnly,
                                isDisableColor: isReadOnly,
                                onChange: (String value) {
                                  state.model.quantity = int.tryParse(value);
                                  // state.model.quantity = value;
                                  context
                                      .read<ArticleFoundDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// Color
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.companyName ??
                                //     state.labels?.defaultLocale.companyName ??
                                Constants.colour,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.text,
                                textFormKey: Keys.challanKey,
                                controller: colorController,
                                characterLimit:
                                    Constants.characterLimitIdTextFormField,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              /// is Depositor Db Employee
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.exceptionalApproval ??
                                  //     state.labels?.defaultLocale
                                  //         .exceptionalApproval ??
                                  Constants.isdepositordbemployee,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.depositorDbEmp ? 1 : 0,
                                  onChangedYes: isReadOnly
                                      ? null
                                      : (val) {
                                          state.model.depositorDbEmp = true;
                                          BlocProvider.of<
                                                      ArticleFoundDetailsCubit>(
                                                  context)
                                              .onCheckBoxChange(state.model);
                                        },
                                  onChangedNo: isReadOnly
                                      ? null
                                      : (val) {
                                          state.model.depositorDbEmp = false;
                                          BlocProvider.of<
                                                      ArticleFoundDetailsCubit>(
                                                  context)
                                              .onCheckBoxChange(state.model);
                                        }),
                              CommonWidgets.verticalSpacerWidget(height * 0.03),

                              if (state.model.depositorDbEmp == true) ...[
                                ///  Depositor Employee Id
                                CommonWidgets.textDisplay(
                                    // state.labels?.locale.employeeId ??
                                    //     state.labels?.defaultLocale
                                    //         .employeeId ??
                                    Constants.depositoremployeeid,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.depositor?.employeeId,
                                  height: 75,
                                  isDisableColor: !showSaveSubmitButtons,
                                  onTap: () {
                                    if (showSaveSubmitButtons) {
                                      BaseOrganisationDialog().userDialog(
                                        employeeId: true,
                                        context: context,
                                        users: state.employee!,
                                        isDbUser: true,
                                        onTap: (BaseUser user) {
                                          BlocProvider.of<
                                                      ArticleFoundDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                            employee: user,
                                          );
                                        },
                                        roleName:
                                            ConstantUserRoles.atomStaticUser,
                                        locationId: state.model.location!.id!,
                                        functionToCall: (BaseUser user) {
                                          BlocProvider.of<
                                                      ArticleFoundDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                            employee: user,
                                          );
                                          // refresh the list
                                          BlocProvider.of<
                                                      ArticleFoundDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        },
                                      );
                                    }
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.03),

                                /// Depositor
                                CommonWidgets.textDisplay(
                                    // state.labels?.locale.cwrSponsor ??
                                    //     state.labels?.defaultLocale
                                    //         .cwrSponsor ??
                                    Constants.depositor,
                                    isMandatory: true,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
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
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.03),

                                ///  Depositor Department
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.department ??
                                      state.labels?.defaultLocale.department ??
                                      Constants.department,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                TextFieldAddButton(
                                  title: state.model.depositorDepartment?.name,
                                  height: 75,
                                  isDisableColor: !showSaveSubmitButtons,
                                  onTap: () {
                                    if (showSaveSubmitButtons) {
                                      BaseOrganisationDialog().departmentDialog(
                                          context: context,
                                          organisations: state.departments,
                                          onTap: (Organisation department) {
                                            state.model.depositorDepartment
                                                ?.name = department.name;
                                            BlocProvider.of<
                                                        ArticleFoundDetailsCubit>(
                                                    context)
                                                .updateDropdownValues(
                                                    department: department);
                                          },
                                          createEntity: false,
                                          functionToCall: () {
                                            // refresh the list
                                            BlocProvider.of<
                                                        ArticleFoundDetailsCubit>(
                                                    context)
                                                .refreshList();
                                          });
                                      FocusScope.of(context)
                                          .requestFocus(sentToFocusNode);
                                    }
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.03),
                              ],

                              if (state.model.depositorDbEmp == false) ...[
                                /// Depositor
                                CommonWidgets.textDisplay(
                                  // state.labels?.locale.companyName ??
                                  //     state.labels?.defaultLocale.companyName ??
                                  Constants.depositor,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.text,
                                  textFormKey: Keys.challanKey,
                                  controller: depositorTextController,
                                  characterLimit:
                                      Constants.characterLimitIdTextFormField,
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
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              if (widget.model?.status != null &&
                                  widget.model?.status != 0) ...[
                                /// is Claimant Company Employee
                                CommonWidgets.textDisplay(
                                    // state.labels?.locale.exceptionalApproval ??
                                    //     state.labels?.defaultLocale
                                    //         .exceptionalApproval ??
                                    Constants.isclaimantdbemployee,
                                    isMandatory: true,
                                    Styles.textStyleWhite16),
                                RadioButtonsYesNo(
                                    status: state.model.status ?? 0,
                                    selectedValue:
                                        state.model.claimantDbEmp ? 1 : 0,
                                    onChangedYes: widget.model?.status != 1
                                        ? null
                                        : (val) {
                                            state.model.claimantDbEmp = true;
                                            BlocProvider.of<
                                                        ArticleFoundDetailsCubit>(
                                                    context)
                                                .onCheckBoxChange(state.model);
                                          },
                                    onChangedNo: widget.model?.status != 1
                                        ? null
                                        : (val) {
                                            state.model.claimantDbEmp = false;
                                            BlocProvider.of<
                                                        ArticleFoundDetailsCubit>(
                                                    context)
                                                .onCheckBoxChange(state.model);
                                          }),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                if (widget.model?.claimantDbEmp == true) ...[
                                  ///  Claimant Employee Id
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.employeeId ??
                                      //     state.labels?.defaultLocale
                                      //         .employeeId ??
                                      Constants.claimantemployeeid,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  TextFieldAddButton(
                                    title: state.model.claimant?.employeeId,
                                    height: 75,
                                    isDisableColor: !showSaveSubmitButtons,
                                    onTap: () {
                                      if (showSaveSubmitButtons) {
                                        BaseOrganisationDialog().userDialog(
                                          employeeId: true,
                                          context: context,
                                          users: state.claimant!,
                                          isDbUser: true,
                                          onTap: (BaseUser user) {
                                            BlocProvider.of<
                                                        ArticleFoundDetailsCubit>(
                                                    context)
                                                .updateDropdownValues(
                                              claimant: user,
                                            );
                                          },
                                          roleName:
                                              ConstantUserRoles.atomStaticUser,
                                          locationId: state.model.location!.id!,
                                          functionToCall: (BaseUser user) {
                                            BlocProvider.of<
                                                        ArticleFoundDetailsCubit>(
                                                    context)
                                                .updateDropdownValues(
                                              claimant: user,
                                            );
                                            // refresh the list
                                            BlocProvider.of<
                                                        ArticleFoundDetailsCubit>(
                                                    context)
                                                .refreshList();
                                          },
                                        );
                                      }
                                    },
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.03),

                                  /// Claimant
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.cwrSponsor ??
                                      //     state.labels?.defaultLocale
                                      //         .cwrSponsor ??
                                      Constants.claimant,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
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
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.03),

                                  ///  Claimant Department
                                  CommonWidgets.textDisplay(
                                    // state.labels?.locale.department ??
                                    //     state.labels?.defaultLocale
                                    //         .department ??
                                    Constants.claimantdepartment,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),
                                  TextFieldAddButton(
                                    title: state.model.claimantDepartment?.name,
                                    height: 75,
                                    isDisableColor: !showSaveSubmitButtons,
                                    onTap: () {
                                      if (showSaveSubmitButtons) {
                                        BaseOrganisationDialog()
                                            .departmentDialog(
                                                context: context,
                                                organisations:
                                                    state.departments,
                                                onTap:
                                                    (Organisation department) {
                                                  state.model.claimantDepartment
                                                      ?.name = department.name;
                                                  BlocProvider.of<
                                                              ArticleFoundDetailsCubit>(
                                                          context)
                                                      .updateDropdownValues(
                                                          claimantDepartment:
                                                              department);
                                                },
                                                createEntity: false,
                                                functionToCall: () {
                                                  // refresh the list
                                                  BlocProvider.of<
                                                              ArticleFoundDetailsCubit>(
                                                          context)
                                                      .refreshList();
                                                });
                                        FocusScope.of(context)
                                            .requestFocus(sentToFocusNode);
                                      }
                                    },
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.03),

                                  /// Claimant Accepted to sign
                                  CommonWidgets.textDisplay(
                                      // state.labels?.locale.exceptionalApproval ??
                                      //     state.labels?.defaultLocale
                                      //         .exceptionalApproval ??
                                      Constants.isclaimantacceptedtosign,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  RadioButtonsYesNo(
                                      status: state.model.status ?? 0,
                                      selectedValue:
                                          state.model.claimantNoSign ? 1 : 0,
                                      onChangedYes: isReadOnly
                                          ? null
                                          : (val) {
                                              state.model.claimantNoSign = true;
                                              BlocProvider.of<
                                                          ArticleFoundDetailsCubit>(
                                                      context)
                                                  .onCheckBoxChange(
                                                      state.model);
                                            },
                                      onChangedNo: isReadOnly
                                          ? null
                                          : (val) {
                                              state.model.claimantNoSign =
                                                  false;
                                              BlocProvider.of<
                                                          ArticleFoundDetailsCubit>(
                                                      context)
                                                  .onCheckBoxChange(
                                                      state.model);
                                            }),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.03),

                                  if (widget.model?.claimantNoSign ==
                                      false) ...[
                                    /// Claimant Confirmed by Email
                                    CommonWidgets.textDisplay(
                                        // state.labels?.locale.exceptionalApproval ??
                                        //     state.labels?.defaultLocale
                                        //         .exceptionalApproval ??
                                        Constants.isclaimantacceptedbyemail,
                                        isMandatory: true,
                                        Styles.textStyleWhite16),
                                    RadioButtonsYesNo(
                                      status: state.model.status ?? 0,
                                      selectedValue:
                                          state.model.claimantConfirmByEmail
                                              ? 1
                                              : 0,
                                      onChangedYes:
                                          null, // onChangedYes: isReadOnly
                                      //     ? null
                                      //     : (val) {
                                      //   // state.model.claimantConfirmByEmail= true;
                                      //   BlocProvider.of<
                                      //       ArticleFoundDetailsCubit>(
                                      //       context)
                                      //       .onCheckBoxChange(state.model);
                                      // },
                                      onChangedNo: null,
                                      // isReadOnly
                                      //     ? null
                                      //     : (val) {
                                      //   // state.model.claimantConfirmByEmail = false;
                                      //   BlocProvider.of<
                                      //       ArticleFoundDetailsCubit>(
                                      //       context)
                                      //       .onCheckBoxChange(state.model);
                                      // }
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.03),
                                  ]
                                ],

                                if (widget.model?.claimantDbEmp == false) ...[
                                  /// Claimant
                                  CommonWidgets.textDisplay(
                                    // state.labels?.locale.companyName ??
                                    //     state.labels?.defaultLocale.companyName ??
                                    Constants.claimant,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    textInputType: TextInputType.text,
                                    textFormKey: Keys.challanKey,
                                    controller: claimantTextController,
                                    characterLimit:
                                        Constants.characterLimitIdTextFormField,
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
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                ],
                              ],

                              ///Attachments
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.evidenceInfo ??
                                      state
                                          .labels?.defaultLocale.evidenceInfo ??
                                      Constants.evidenceDocuments,
                                  Styles.textStyleWhite16),
                              widget.model == null
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),
                              if (state.model.status == 0 ||
                                  state.model.status == null) ...[
                                BaseImageUpload().uploadWidget(
                                  context: context,
                                  isDisabled: isReadOnly,
                                  loggedInUserDetails:
                                      state.loggedInUserDetails!,
                                  getFiles: uploadFiles,
                                  onImageSelected: (ImageContent data) {
                                    List<ImageContent>? files = [];
                                    files.add(data);
                                    for (ImageContent image in uploadFiles) {
                                      files.add(image);
                                    }
                                    BlocProvider.of<ArticleFoundDetailsCubit>(
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
                                    attachments: state.uploadAttachments,
                                    files: uploadFiles,
                                    moduleCode:
                                        Constants.articleFoundModuleCode,
                                    isDisabled: false,
                                    showDeleteIcon:
                                        state.model.status == null ||
                                            state.model.status == 0,
                                  ),
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// SubmitButton
                              if (showSaveSubmitButtons) ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    cancelButtonDisplay(),
                                    if (showSaveSubmitButtons) ...[
                                      submitButtonDisplay(state)
                                    ],
                                  ],
                                ),
                              ],
                              if (!showSaveSubmitButtons) ...[
                                cancelButtonDisplay(),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.04),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // if (!showSaveSubmitButtons) ...[
              //   Container(
              //     padding: const EdgeInsets.all(5.0),
              //     decoration: const ShapeDecoration(
              //       color: AppColors.backgroundWhiteColor,
              //       shape: RoundedRectangleBorder(
              //         borderRadius:
              //         BorderRadius.vertical(top: Radius.circular(00.0)),
              //       ),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         cancelButtonDisplay(),
              //       ],
              //     ),
              //   ),
              // ],
            ],
          ),
        ),
      ),
    ]);
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
        BlocProvider.of<ArticleFoundDetailsCubit>(context).submitForm();
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
