import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import 'package:intl/intl.dart';

class CreatePassManagement extends StatefulWidget {
  final PassManagementModel? model;
  final int passId;
  final String? title;
  final ExtraProperties? extraProperties;

  const CreatePassManagement({
    super.key,
    this.model,
    required this.passId,
    this.title,
    this.extraProperties,
  });

  @override
  State<CreatePassManagement> createState() => _CreatePassManagementState();
}

class _CreatePassManagementState extends State<CreatePassManagement> {
  final GlobalKey<FormState> lawEnforcementFormKey = GlobalKey<FormState>();
  TextEditingController statusTextController = TextEditingController();
  TextEditingController updateStatusTextController = TextEditingController();
  TextEditingController passValidFromTextController = TextEditingController();
  TextEditingController passValidUntilTextController = TextEditingController();
  TextEditingController companyNameTextController = TextEditingController();
  TextEditingController employeeIdTextController = TextEditingController();
  TextEditingController hostEmployeeIdTextController = TextEditingController();
  TextEditingController escortedByTextController = TextEditingController();
  TextEditingController escortedEmployeeIdByTextController =
      TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController vendorVisitorNameTextController = TextEditingController();

  TextEditingController hostTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController dbsponsorTextController = TextEditingController();
  TextEditingController daypassnoTextController = TextEditingController();
  TextEditingController passCategoryTextController = TextEditingController();
  TextEditingController passTypeTextController = TextEditingController();
  TextEditingController contactnoTextController = TextEditingController();
  TextEditingController dateofcreationTextController = TextEditingController();
  TextEditingController visitorcomingfromTextController =
      TextEditingController();
  TextEditingController purposeofvisitTextController = TextEditingController();
  TextEditingController photofidentityextController = TextEditingController();
  TextEditingController sezpassinfoTextController = TextEditingController();
  TextEditingController mtpApplicationNoTextController =
      TextEditingController();
  TextEditingController passReturnedTextController = TextEditingController();

  final FocusNode companyNameFocusNode = FocusNode();

  List<ImageContent> getFiles = [];
  List<ImageContent> getAttachments = [];
  List<ImageContent> photogetFiles = [];
  List<ImageContent> photogetAttachments = [];
  late CreatePassMgmtState globalState;
  String? serialnumber;
  String createdBy = '';
  String handOverBy = '';
  bool isEditable = true;
  bool isFTECompanyNameEditable = true;
  bool isDisabled = false;
  int pageNumber = 0;
  bool isShowSaveAndSubmitButton = false;

  @override
  void initState() {
    super.initState();
    getPassManagementList();
    if (widget.model != null) {
      log('Existing Record');
      //globalState = CreatePassMgmtState(stateType: CreatePassMgmtStateType.initial);
      populateData();
      createPassMgmtCubit.initializeValues(
          model: widget.model!, passId: widget.passId);
    } else {
      log('New Record');
      // widget.model = DayPassListElement();
      createPassMgmtCubit.initialization();
      createPassMgmtCubit.initializeValues(
          model: PassManagementModel(), passId: widget.passId);
    }
    _getCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    log('--passId----${widget.passId}----');
    log('--status----${widget.model?.status}----');
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      appBar: AppHeader(
        isTitleCenter: false,
        // title: widget.listuser != null
        //     ? 'Edit Day Pass Management'
        //     : 'Create Day Pass Management',
        title: widget.title,
        backBtn: IconButton(
          onPressed: () {
            Navigator.pop(context);
            CommonServices().unlock();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
        ),

        action: [
          if (((widget.model?.status == null ||
                          widget.model?.status == 0) &&
                      (widget.model != null &&
                          widget.model!.lock.isEmptyOrNull)) ||
                  widget.model == null
              // ||
              // (widget.extraProperties != null &&
              //     !widget.extraProperties!.hasWritePermission!)
              ) ...[
            GestureDetector(
              onTap: () {
                submitForm(false, widget.model?.id ?? 0, globalState);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: SvgPicture.asset(
                  AppIcon.createfoundsaveicon,
                ),
              ),
            ),
            ],
          if (((widget.model?.status == null ||
              widget.model?.status == 0 ||
              widget.model?.status == 1 ||
              widget.model?.status == 3) &&
              (widget.model != null &&
                  widget.model!.lock.isEmptyOrNull)) ||
              widget.model == null
          // ||
          // (widget.extraProperties != null &&
          //     !widget.extraProperties!.hasWritePermission!)
          ) ...[
            GestureDetector(
              onTap: () {
                passValidations(context, globalState);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.send,
                  color: AppColors.backgroundWhiteColor,
                ),
                // SvgPicture.asset(
                //   AppIcon.createfoundsaveicon,
                //),
              ),
            ),
          ],
          if (widget.model?.id != null) ...[
            GestureDetector(
              onTap: () {
                DownloadImage().exportPdf(context, 'export.pdf',
                    '/${CommonApis.exportDetailPagePDF}${widget.model?.id}&moduleCode=${Constants.passManagementModuleCode}');
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(Icons.picture_as_pdf, color: Colors.white),
              ),
            ),
          ],
        ],
        //backgroundColor: AppColors.navigationSkybluecolor,
      ),
      backgroundColor: AppColors.backgroundWhiteColor,
      body: BlocConsumer<CreatePassMgmtCubit, CreatePassMgmtState>(
        listener: (context, state) {
          log('-state.stateType---${state.stateType}----');
          // Utils().formError(state, context);
          // Utils().errorAndLogout(state, context);
// log('widget.extraProperties!.hasWritePermission! ${widget.extraProperties!.hasWritePermission!}');
          if (state.stateType == CreatePassMgmtStateType.successFormSubmit) {
            var dialog = CustomAlertDialog(
              title: widget.title,
              message: state.message ?? '',
              positiveBtnText: Constants.ok,
              onPositivePressed: () {
                // TODO: Need to improve this code
                Navigator.pop(context);
                Navigator.pop(context);
                // Navigator.pop(context);
                // TODO: dynamic title
                Navigator.popAndPushNamed(
                  context,
                  daypassmanagementListRoute,
                  arguments: {
                    "passMngDetails": PassMngArguments(
                        widget.passId, widget.title ?? 'Pass Management', false)
                  },
                );
              },
            );
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => dialog);

            // Utils.dynamicAlert(
            //     context, state.message ?? '', 'Material Movement', '');
          }
          if (state.stateType == CreatePassMgmtStateType.failure) {
            Validator().showToast(
              context,
              state.message ?? 'Invalid Information',
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<CreatePassMgmtCubit, CreatePassMgmtState>(
            builder: (context, state) {
              log('-builder-state.stateType---${state.stateType}---');
              if (state.stateType == CreatePassMgmtStateType.loading) {
                return const BaseLoader();
              }

              if (widget.model == null &&
                  widget.passId != ConstantsIntValue.passIdSez &&
                  passTypeTextController.text.isEmptyOrNull) {
                passTypeTextController.text = state.passTypes!.first.name!;
                state.model.passType = state.passTypes!.first.id;
              } else if (widget.model != null) {
                Iterable<Organisation>? passes = state.passTypes?.where(
                        (element) => element.id == widget.model?.passType) ??
                    [];

                if (passTypeTextController.text.isEmptyOrNull &&
                    !passes.isEmptyOrNull) {
                  passTypeTextController.text = passes.first.name!;
                }
                state.model.passType = widget.model?.passType;
              }

              if (widget.model?.status == null ||
                  widget.model?.status == 0 ||
                  widget.model?.status == 1) {
                isDisabled = false;
              }

              if (widget.model?.status != 7 &&
                  widget.model?.status != 2 &&
                  widget.model?.status != 4 &&
                  widget.model?.status != 5 &&
                  widget.model?.status != 6 &&
                  widget.model?.status != 8 &&
                  widget.model?.status != 9) {
                isDisabled = false;
              }

              if (widget.model != null && !widget.model!.lock.isEmptyOrNull) {
                isDisabled = true;
              }
              // if (widget.extraProperties != null &&
              //     !widget.extraProperties!.hasWritePermission!) {
              //   isDisabled = true;
              // }
              if (((widget.model?.status == null ||
                              widget.model?.status == 0 ||
                              widget.model?.status == 1 ||
                              widget.model?.status == 3) &&
                          (widget.model != null &&
                              widget.model!.lock.isEmptyOrNull)) ||
                      widget.model == null
                  // ||
                  // (widget.extraProperties != null &&
                  //     !widget.extraProperties!.hasWritePermission!)
                  ) {
                isShowSaveAndSubmitButton = true;
              }
              log('slno ${state.getSerialnumberResponse?.serialNo}');
              log('slno1${serialnumber}');
              if (state.getSerialnumberResponse != null &&
                  !state.getSerialnumberResponse!.serialNo.isEmptyOrNull && widget.model?.slNo ==null) {
                serialnumber = state.getSerialnumberResponse?.serialNo;
              }
              globalState = state;
              if (state.stateType == CreatePassMgmtStateType.addattachment) {
                getFiles = state.loadAttachments ?? [];
              }
              if (state.stateType == CreatePassMgmtStateType.photoattachment) {
                photogetFiles = state.photoAttachments ?? [];
              }
              // initiallyLocationAndSerialNumberDataset(state);
              // if (widget.listuser != null) {
              //   if (state.groups != null) {

              //   }
              // }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: height * 0.01,
                      color: AppColors.navigationSkyBlueColor,
                    ),
                    Container(
                      //padding: const EdgeInsets.all(20.0),
                      decoration: const ShapeDecoration(
                          color: AppColors.backgroundWhiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0)),
                          )),
                      child: AbsorbPointer(
                        absorbing: isDisabled,
                        child: Form(
                          key: lawEnforcementFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (widget.model != null &&
                                  !widget.model!.lock.isEmptyOrNull) ...[
                                RecordLockedWidget(
                                    text: '${widget.model?.lock}'),
                              ],
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        Constants.generalinformation,
                                        style: Styles.styleHeaderGreyText16,
                                      ),
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Status
                                    CommonWidgets.textDisplay(
                                        state.labels?.locale.status ??
                                            state
                                                .labels?.defaultLocale.status ??
                                            Constants.status,
                                        Styles.textStyleBlack14,
                                        isMandatory: true),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    FlutterInputField(
                                      isEnable: false,
                                      isDisableColor: true,
                                      controller: statusTextController,
                                      textFormKey: Keys.statusTextController,
                                      hintText: '',
                                      onChange: (String username) {
                                        //this.username = username;
                                      },
                                      validateTextField: (String? user) {},
                                      suffixWidget: GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: SvgPicture.asset(
                                            //AppIcon.dropdownicon,
                                            AppIcon.dropdownicon,
                                            //fit: BoxFit.,
                                            colorFilter: const ColorFilter.mode(
                                              AppColors.textGreyThemeColor,
                                              BlendMode.srcIn,
                                            ),
                                            // color: AppColors.textGreyThemeColor,
                                            width: 10,
                                            height: 10,
                                            key: const Key(Keys.userIcon),
                                          ),
                                        ),
                                      ),
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Update Status
                                    if (widget.model != null &&
                                        (statusTextController.text
                                                    .toLowerCase() ==
                                                "created" ||
                                            statusTextController.text
                                                    .toLowerCase() ==
                                                "handed over" ||
                                            statusTextController.text
                                                    .toLowerCase() ==
                                                "non returned")) ...[
                                      CommonWidgets.textDisplay(
                                          isMandatory: true,
                                          state.labels?.locale.updateStatus ??
                                              state.labels?.defaultLocale
                                                  .updateStatus ??
                                              Constants.updatestatus,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      TextFieldAddButton(
                                        title: updateStatusTextController.text,
                                        height: 60,
                                        isDisableColor: widget.model != null &&
                                            !widget.model!.lock.isEmptyOrNull,
                                        onTap: () {
                                          if (widget
                                              .model!.lock.isEmptyOrNull) {
                                            BaseOrganisationDialog()
                                                .departmentDialog(
                                              context: context,
                                              organisations:
                                                  state.updateStatuses ?? [],
                                              onTap: (Organisation org) {
                                                updateStatusTextController
                                                    .text = org.name!;
                                                setState(() {});
                                                BlocProvider.of<
                                                            CreatePassMgmtCubit>(
                                                        context)
                                                    .updateDropdownValues(
                                                        updateStatus: org);
                                              },
                                            );
                                          }
                                        },
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                    ],

                                    /// Created By
                                    CommonWidgets.horizentaltextHandling(
                                        state.labels?.locale.entrySecurity ??
                                            state.labels?.defaultLocale
                                                .entrySecurity ??
                                            Constants.createdby,
                                        isMandatory: true,
                                        createdBy.isNotEmpty
                                            ? createdBy
                                            : '${state.getUserDetailsResponse?.firstName ?? ''}  ${state.getUserDetailsResponse?.lastName ?? ''}'
                                                ''),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Location
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.location ??
                                          state
                                              .labels?.defaultLocale.location ??
                                          Constants.location,
                                      Styles.textStyleBlack14,
                                      isMandatory: true,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    locationWidgetDisplay(state),
                                    // BaseLocationDropdown().locationWidgetDisplay(
                                    //     context: context,
                                    //     locations: state.getLocationsResponse ??
                                    //         Locations(),
                                    //     selectedLocationName:
                                    //         widget.model?.location?.name ?? '',
                                    //     onTap: (Organisation? org) async {
                                    //       await createPassMgmtCubit
                                    //           .getSerialnumberDetails(
                                    //         org?.id.toString() ?? '',
                                    //         widget.passId ?? '',
                                    //         context,
                                    //       );
                                    //
                                    //       createPassMgmtCubit.getPassNumber(
                                    //           widget.passId ?? '0',
                                    //           org?.id.toString() ?? '',
                                    //           context);
                                    //       createPassMgmtCubit
                                    //           .getlocationsResponseData(org);
                                    //       daypassnoTextController.text = '';
                                    //     }),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Date of creation
                                    CommonWidgets.textDisplay(
                                        state.labels?.locale.inputDate ??
                                            state.labels?.defaultLocale
                                                .inputDate ??
                                            Constants.dateofcreation,
                                        isMandatory: true,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    datecreateWidgetdisplay(),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// slno
                                    CommonWidgets.horizentaltextHandling(
                                      state.labels?.locale.slNo ??
                                          state.labels?.defaultLocale.slNo ??
                                          Constants.slno,
                                      serialnumber ?? '',
                                      isMandatory: true,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// entity type
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.entity ??
                                          state.labels?.defaultLocale.entity ??
                                          Constants.entity,
                                      Styles.textStyleBlack14,
                                      isMandatory: true,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    entityaddButtonwidgetLoading(state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Pass Type
                                    CommonWidgets.textDisplay(
                                      state.labels?.locale.passType ??
                                          state
                                              .labels?.defaultLocale.passType ??
                                          Constants.passtype,
                                      Styles.textStyleBlack14,
                                      isMandatory: true,
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    GestureDetector(
                                      onTap: () {
                                        if ((widget.model == null ||
                                                widget.model?.status == 0)
                                            // &&
                                            // !(widget.extraProperties != null &&
                                            //     !widget.extraProperties!
                                            //         .hasWritePermission!)
                                            ) {
                                          passTypeDialog(state);
                                        }
                                      },
                                      child: FlutterInputField(
                                        isEnable: false,
                                        isDisableColor: true,
                                        controller: passTypeTextController,
                                        textFormKey: Keys.statusTextController,
                                        hintText: '',
                                        onChange: (String username) {
                                          //this.username = username;
                                          setState(() {});
                                        },
                                        onTap: () {
                                          if ((widget.model?.status == 0 ||
                                                  widget.model?.status ==
                                                      null ||
                                                  widget.model?.status != 1)
                                              // ||
                                              // !(widget.extraProperties !=
                                              //     null &&
                                              //     !widget.extraProperties!
                                              //         .hasWritePermission!)
                                              ) {
                                            passTypeDialog(state);
                                          }
                                        },
                                        validateTextField: (String? user) {},
                                        suffixWidget: IconButton(
                                          icon: SvgPicture.asset(
                                              width: 10,
                                              height: 10,
                                              AppIcon.dropdownicon,
                                              key: const Key('closed_eye')),
                                          onPressed: () {
                                            if ((widget.model?.status == 0 ||
                                                    widget.model?.status ==
                                                        null ||
                                                    widget.model?.status != 1)
                                                // &&
                                                // !(widget.extraProperties !=
                                                //     null &&
                                                //     !widget.extraProperties!
                                                //         .hasWritePermission!)
                                                ) {
                                              passTypeDialog(state);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                    if (widget.passId ==
                                        ConstantsIntValue.passIdSez) ...[
                                      /// Pass Category
                                      CommonWidgets.textDisplay(
                                        state.labels?.locale.category ??
                                            state.labels?.defaultLocale
                                                .category ??
                                            Constants.passCategory,
                                        isMandatory: true,
                                        Styles.textStyleBlack14,
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      GestureDetector(
                                        onTap: () {
                                          if ((widget.model == null ||
                                                  widget.model?.status == 0)
                                              // &&
                                              // !(widget.extraProperties !=
                                              //     null &&
                                              //     !widget.extraProperties!
                                              //         .hasWritePermission!)
                                              ) {
                                            if (!isDisabled) {
                                              //daypassNoDialog();
                                              //passnumberaddButtonwidgetLoading(state);
                                              // if (widget.passId == ConstantsIntValue.passIdSez) {
                                              passCategoryDialog(state: state);
                                              // } else {
                                              //passnumberTypeDialog(state);
                                              // }
                                            }
                                          }
                                        },
                                        child: FlutterInputField(
                                            isEnable: false,
                                            isDisableColor: widget.model ==
                                                        null ||
                                                    passCategoryTextController
                                                        .text.isEmpty ||
                                                    widget.model?.status == 0
                                                ? false
                                                : true,
                                            controller:
                                                passCategoryTextController,
                                            textFormKey:
                                                Keys.statusTextController,
                                            hintText: '',
                                            onChange: (String username) {
                                              //this.username = username;
                                              setState(() {});
                                            },
                                            onTap: () {
                                              if ((widget.model == null ||
                                                      daypassnoTextController
                                                          .text.isEmpty ||
                                                      widget.model?.status == 0)
                                                  // &&
                                                  // !(widget.extraProperties !=
                                                  //     null &&
                                                  //     !widget.extraProperties!
                                                  //         .hasWritePermission!)
                                                  ) {
                                                //passnumberaddButtonwidgetLoading(state);
                                                // if (widget.passId == ConstantsIntValue.passIdSez) {
                                                passCategoryDialog(
                                                    state: state);
                                                // } else {
                                                // passnumberTypeDialog(state);
                                                // }
                                              }
                                            },
                                            validateTextField:
                                                (String? user) {},
                                            suffixWidget: IconButton(
                                                icon: SvgPicture.asset(
                                                    width: 10,
                                                    height: 10,
                                                    AppIcon.dropdownicon,
                                                    key: const Key(
                                                        'closed_eye')),
                                                onPressed: () {
                                                  log('suffixIcon pressed');
                                                  if ((widget.model == null ||
                                                          widget.model
                                                                  ?.status ==
                                                              0)
                                                      // &&
                                                      // !(widget
                                                      //     .extraProperties !=
                                                      //     null &&
                                                      //     !widget
                                                      //         .extraProperties!
                                                      //         .hasWritePermission!)
                                                      ) {
                                                    //passnumberaddButtonwidgetLoading(state);
                                                    // if (widget.passId == ConstantsIntValue.passIdSez) {
                                                    passCategoryDialog(
                                                        state: state);
                                                    // } else {
                                                    //passnumberTypeDialog(state);
                                                    //}
                                                  }
                                                })),
                                      ),
                                    ],

                                    /// Company Type
                                    if (widget.passId ==
                                            ConstantsIntValue.passIdDayPass ||
                                        widget.passId ==
                                            ConstantsIntValue.passIdSez) ...[
                                      CommonWidgets.textDisplay(
                                          state.labels?.locale.companyType ??
                                              state.labels?.defaultLocale
                                                  .companyType ??
                                              Constants.companyType,
                                          isMandatory: true,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      companytypeaddButtonwidgetLoading(state),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),

                                      // /// Company Name
                                      //   CommonWidgets.textDisplay(
                                      //      state.labels?.locale
                                      //           .companyName ??
                                      //           state.labels?.defaultLocale
                                      //               .companyName ??
                                      //           Constants.companyName,
                                      //       isMandatory: true,
                                      //       Styles.textStyleBlack14),
                                      //
                                      //   FlutterInputField(
                                      //     controller: companyNameTextController,
                                      //     textInputType: TextInputType.text,
                                      //     textFormKey: Keys.nameKey,
                                      //     hintText: '',
                                      //     focusNode: companyNameFocusNode,
                                      //     isEnable: isFTECompanyNameEditable &&
                                      //         (widget.model?.status == null ||
                                      //             widget.model?.status ==
                                      //                 ConstantsIntValue
                                      //                     .passStatusCreated) &&
                                      //         !(widget.extraProperties != null &&
                                      //             !widget.extraProperties!
                                      //                 .hasWritePermission!),
                                      //     isDisableColor: false,
                                      //     onChange: (String value) {
                                      //       companyNameTextController.text =
                                      //           value;
                                      //     },
                                      //     validateTextField: (String? user) {},
                                      //   )
                                    ],
                                    //  else ...[
                                    //     textFieldWidgetLoad(
                                    //         controller: nameTextController,
                                    //         index: 0,
                                    //         state: state),
                                    //   ],

                                    /// Vendor/Visitor  Name
                                    if (widget.passId ==
                                            ConstantsIntValue.passIdVendor ||
                                        widget.passId ==
                                            ConstantsIntValue
                                                .passIdVisitor) ...[
                                      CommonWidgets.textDisplay(
                                          widget.passId ==
                                                  ConstantsIntValue
                                                      .passIdVisitor
                                              ? state.labels?.locale
                                                      .visitorName ??
                                                  state.labels?.defaultLocale
                                                      .visitorName ??
                                                  Constants.visitorName
                                              : state.labels?.locale
                                                      .vendorName ??
                                                  state.labels?.defaultLocale
                                                      .vendorName ??
                                                  Constants.vendorName,
                                          isMandatory: true,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      textFieldWidgetLoad(
                                          controller: vendorVisitorNameTextController,
                                          index: 0,
                                          state: state),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                    ],

                                    /// Vendor Company Name
                                    if (widget.passId ==
                                            ConstantsIntValue.passIdVendor) ...[
                                      CommonWidgets.textDisplay(
                                          state.labels?.locale.companyName ??
                                              state.labels?.defaultLocale
                                                  .companyName ??
                                              Constants.companyName,
                                          isMandatory: true,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      textFieldWidgetLoad(
                                          controller: companyNameTextController,
                                          index: 0,
                                          state: state),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                    ],

                                    ///Day/Sez Company Name
                                    if (widget.passId ==
                                            ConstantsIntValue.passIdDayPass ||
                                        widget.passId ==
                                            ConstantsIntValue.passIdSez) ...[
                                      //   CommonWidgets.textDisplay(
                                      //       state.labels?.locale.companyName ??
                                      //           state.labels?.defaultLocale
                                      //               .companyName ??
                                      //           Constants.companyName,
                                      //       isMandatory: true,
                                      //       Styles.textStyleBlack14),
                                      //   CommonWidgets.verticalSpacerWidget(
                                      //       height * 0.001),
                                      //   FlutterInputField(
                                      //     controller: companyNameTextController,
                                      //     textInputType: TextInputType.text,
                                      //     textFormKey: Keys.nameKey,
                                      //     hintText: '',
                                      //     focusNode: companyNameFocusNode,
                                      //     isEnable:true
                                      //         // &&
                                      //         // !(widget.extraProperties != null &&
                                      //         //     !widget.extraProperties!
                                      //         //         .hasWritePermission!)
                                      //     ,
                                      //     isDisableColor: false,
                                      //     onChange: (String value) {
                                      //       companyNameTextController.text =
                                      //           value;
                                      //     },
                                      //     validateTextField: (String? user) {},
                                      //   ),
                                      //   CommonWidgets.verticalSpacerWidget(
                                      //       height * 0.01),
                                      CommonWidgets.textDisplay(
                                          state.labels?.locale.companyName ??
                                              state.labels?.defaultLocale
                                                  .companyName ??
                                              Constants.companyName,
                                          isMandatory: true,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      FlutterInputField(
                                        controller: companyNameTextController,
                                        textInputType: TextInputType.text,
                                        textFormKey: Keys.nameKey,
                                        hintText: '',
                                        // focusNode: companyNameFocusNode,
                                        isEnable:widget.model?.status == 0 || widget.model == null ? isFTECompanyNameEditable: false,
                                        isDisableColor: false,
                                        onChange: (String value) {
                                          companyNameTextController.text =
                                              value;
                                        },
                                        validateTextField: (String? user) {},
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                    ],

                                    /// Employee Id
                                    if ((widget.passId ==
                                            ConstantsIntValue.passIdDayPass && (state.selectedCompanyType?.name ??
                                            '')
                                                .toLowerCase() !=
                                            'exceptions' && (state.selectedCompanyType?.name ??
                                        '')
                                        .toLowerCase() !=
                                        'cwr t2' )||
                                        widget.passId ==
                                            ConstantsIntValue.passIdSez) ...[
                                      CommonWidgets.textDisplay(
                                          state.labels?.locale.employeeId ??
                                              state.labels?.defaultLocale
                                                  .employeeId ??
                                              Constants.employeeid,
                                          isMandatory: true,
                                          Styles.textStyleBlack14),
                                      nameAddButtonWidgetLoading(state),
                                    ],
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    ///Sez Name
                                    if (widget.passId ==
                                        ConstantsIntValue.passIdSez) ...[
                                      CommonWidgets.textDisplay(
                                          state.labels?.locale.employeeName ??
                                              state.labels?.defaultLocale
                                                  .employeeName ??
                                              Constants.name,
                                          isMandatory: false,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      FlutterInputField(
                                        controller: nameTextController,
                                        textInputType: TextInputType.text,
                                        textFormKey: Keys.nameKey,
                                        hintText: '',
                                        // focusNode: companyNameFocusNode,
                                        isEnable:
                                           false,
                                        isDisableColor:
                                             true,
                                        onChange: (String value) {
                                          // nameTextController.text =
                                          //     value;
                                        },
                                        validateTextField: (String? user) {},
                                      )
                                    ],

                                    ///Day Pass CWR T2 Employee Id
                                    if (widget.passId ==
                                        ConstantsIntValue.passIdDayPass && (state.selectedCompanyType?.name ??
                                        '')
                                        .toLowerCase() ==
                                        'cwr t2') ...[
                                      CommonWidgets.textDisplay(
                                          state.labels?.locale.employeeId ??
                                              state.labels?.defaultLocale
                                                  .employeeId ??
                                              Constants.employeeid,
                                          isMandatory: true,
                                          Styles.textStyleBlack14),
                                      FlutterInputField(
                                        controller: employeeIdTextController,
                                        textInputType: TextInputType.number,
                                        textFormKey: Keys.nameKey,
                                        hintText: '',
                                        // focusNode: companyNameFocusNode,
                                        isEnable: widget.model?.status == 0 || widget.model == null,
                                        isDisableColor: !isEditable,
                                        onChange: (String value) {
                                          employeeIdTextController.text =
                                              value;
                                        },
                                        validateTextField: (String? user) {},
                                      )
                                    ],
                                    ///Day Pass Name
                                    if (widget.passId ==
                                        ConstantsIntValue.passIdDayPass) ...[
                                      CommonWidgets.textDisplay(
                                          state.labels?.locale.employeeName ??
                                              state.labels?.defaultLocale
                                                  .employeeName ??
                                              Constants.name,
                                          isMandatory: true,
                                          Styles.textStyleBlack14),
                                      FlutterInputField(
                                        controller: nameTextController,
                                        textInputType: TextInputType.text,
                                        textFormKey: Keys.nameKey,
                                        hintText: '',
                                        // focusNode: companyNameFocusNode,
                                        isEnable: ((widget.model?.status == 0 || widget.model == null)
                                           &&
                                            ((state.selectedCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'exceptions' || (state.selectedCompanyType?.name ??
                                            '')
                                            .toLowerCase() ==
                                            'cwr t2'))
                                                ? true
                                                : false,
                                        isDisableColor:
                                        (isEditable)
                                            && ((state.selectedCompanyType?.name ??
                                            '')
                                            .toLowerCase() ==
                                            'exceptions' || (state.selectedCompanyType?.name ??
                                            '')
                                            .toLowerCase() ==
                                            'cwr t2')
                                            ? false
                                            : true,
                                        onChange: (String value) {
                                          nameTextController.text =
                                              value;
                                        },
                                        validateTextField: (String? user) {},
                                      )
                                    ],

                                    ///Vendor/Visitor Contact No
                                    if (widget.passId ==
                                            ConstantsIntValue.passIdVisitor ||
                                        widget.passId ==
                                            ConstantsIntValue.passIdVendor) ...[
                                      CommonWidgets.textDisplay(
                                          state.labels?.locale.contactNo ??
                                              state.labels?.defaultLocale
                                                  .contactNo ??
                                              Constants.contactNo,
                                          isMandatory: true,
                                          Styles.textStyleBlack14),
                                      textFieldWidgetLoad(
                                        controller: contactnoTextController,
                                        index: 0,
                                        state: state,
                                      ),
                                    ],

                                    /// Sez Email
                                    if (widget.passId ==
                                            ConstantsIntValue.passIdSez &&
                                        passCategoryTextController.text ==
                                            "Temporary") ...[
                                      CommonWidgets.textDisplay(
                                          state.labels?.locale.email ??
                                              state.labels?.defaultLocale
                                                  .email ??
                                              Constants.email,
                                          isMandatory: true,
                                          Styles.textStyleBlack14),
                                      textFieldWidgetLoad(
                                        controller: emailTextController,
                                        index: 0,
                                        state: state,
                                      ),
                                    ],

                                    /// DB sponsor Employee Id
                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdDayPass &&
                                            ((state.selectedCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.selectedCompanyType
                                                                ?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? CommonWidgets.textDisplay(
                                            state.labels?.locale.cwrSponsor ??
                                                state.labels?.defaultLocale
                                                    .cwrSponsor ??
                                                Constants.dbSponsorEmployeeId,
                                            isMandatory: true,
                                            Styles.textStyleBlack14)
                                        : Container(),

                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdDayPass &&
                                            ((state.selectedCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.selectedCompanyType
                                                                ?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),

                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdDayPass &&
                                            ((state.selectedCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.selectedCompanyType
                                                                ?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? dbSponsorAddButtonWidgetLoading(state)
                                        : Container(),

                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdDayPass &&
                                            ((state.selectedCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.selectedCompanyType
                                                                ?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    /// db sponsor
                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdDayPass &&
                                            ((state.selectedCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.selectedCompanyType
                                                                ?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? CommonWidgets.textDisplay(
                                            state.labels?.locale.cwrSponsor ??
                                                state.labels?.defaultLocale
                                                    .cwrSponsor ??
                                                Constants.dbSponsor,
                                            isMandatory: true,
                                            Styles.textStyleBlack14)
                                        : Container(),

                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdDayPass &&
                                            ((state.selectedCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.selectedCompanyType
                                                                ?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? FlutterInputField(
                                            controller: dbsponsorTextController,
                                            textInputType: TextInputType.text,
                                            textFormKey: Keys.nameKey,
                                            hintText: '',
                                            focusNode: companyNameFocusNode,
                                            isEnable: false,
                                            isDisableColor: true,
                                            onChange: (String value) {
                                              // nameTextController.text =
                                              //     value;
                                            },
                                            validateTextField:
                                                (String? user) {},
                                          )
                                        : Container(),

                                    /// SEZ Pass
                                    if (widget.passId ==
                                            ConstantsIntValue.passIdVisitor ||
                                        widget.passId ==
                                            ConstantsIntValue.passIdSez) ...[
                                      CommonWidgets.textDisplay(
                                        widget
                                                    .passId ==
                                                ConstantsIntValue.passIdVisitor
                                            ? state.labels?.locale
                                                    .visitorComingFrom ??
                                                state.labels?.defaultLocale
                                                    .visitorComingFrom ??
                                                Constants.visitorComingFrom
                                            : state.labels?.locale
                                                    .sezPassInfo ??
                                                state.labels?.defaultLocale
                                                    .sezPassInfo ??
                                                Constants.sezPass,
                                        Styles.textStyleBlack14,
                                        isMandatory: true,
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      textFieldWidgetLoad(
                                        controller: widget.passId ==
                                                ConstantsIntValue.passIdVisitor
                                            ? visitorcomingfromTextController
                                            : sezpassinfoTextController,
                                        index: 0,
                                        state: state,
                                      ),

                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),

                                      ///Mtp Application no
                                      CommonWidgets.textDisplay(
                                        widget.passId ==
                                                ConstantsIntValue.passIdSez
                                            ? state.labels?.locale.mtpPassNo ??
                                                state.labels?.defaultLocale
                                                    .mtpPassNo ??
                                                Constants.mTPApplicationNo
                                            : state.labels?.locale
                                                    .visitingPurpose ??
                                                state.labels?.defaultLocale
                                                    .visitingPurpose ??
                                                Constants.purposeOfVisit,
                                        Styles.textStyleBlack14,
                                        isMandatory: true,
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      textFieldWidgetLoad(
                                          controller: widget.passId ==
                                                  ConstantsIntValue.passIdSez
                                              ? mtpApplicationNoTextController
                                              : purposeofvisitTextController,
                                          index: 0,
                                          state: state),
                                      // CommonWidgets.verticalSpacerWidget(
                                      //     height * 0.0001),
                                    ],
                                    //Photo Identity Validation Type
                                    widget.passId ==
                                            ConstantsIntValue.passIdVisitor
                                        ? CommonWidgets.textDisplay(
                                            state.labels?.locale
                                                    .idValidationType ??
                                                state.labels?.defaultLocale
                                                    .idValidationType ??
                                                Constants.photoIdentityType,
                                            isMandatory: true,
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.passId ==
                                            ConstantsIntValue.passIdVisitor
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    widget.passId ==
                                            ConstantsIntValue.passIdVisitor
                                        ? GestureDetector(
                                            onTap: () {
                                              if ((widget.model?.status == 0 ||
                                                      widget.model?.status ==
                                                          null)
                                                  // &&
                                                  // !(widget.extraProperties !=
                                                  //     null &&
                                                  //     !widget.extraProperties!
                                                  //         .hasWritePermission!)
                                                  ) {
                                                photoIdentityTypeDialog();
                                              }
                                            },
                                            child: FlutterInputField(
                                                isEnable: false,
                                                isDisableColor:
                                                    // widget.listuser == null ||
                                                    //         passTypeTextController
                                                    //             .text.isEmpty
                                                    //     ? false
                                                    //     :
                                                    true,
                                                controller:
                                                    photofidentityextController,
                                                textFormKey:
                                                    Keys.statusTextController,
                                                hintText: '',
                                                onChange: (String username) {
                                                  //this.username = username;
                                                  setState(() {});
                                                },
                                                onTap: () {
                                                  if ((widget.model?.status ==
                                                              0 ||
                                                          widget.model
                                                                  ?.status ==
                                                              null)
                                                      // &&
                                                      // !(widget.extraProperties !=
                                                      //     null &&
                                                      //     !widget
                                                      //         .extraProperties!
                                                      //         .hasWritePermission!)
                                                      ) {
                                                    photoIdentityTypeDialog();
                                                  }
                                                },
                                                validateTextField:
                                                    (String? user) {},
                                                suffixWidget: IconButton(
                                                    icon: SvgPicture.asset(
                                                        width: 10,
                                                        height: 10,
                                                        AppIcon.dropdownicon,
                                                        key: const Key(
                                                            'closed_eye')),
                                                    onPressed: () {
                                                      log('suffixIcon pressed');
                                                      if ((widget.model
                                                                      ?.status ==
                                                                  0 ||
                                                              widget.model
                                                                      ?.status ==
                                                                  null)
                                                          // &&
                                                          // !(widget.extraProperties !=
                                                          //     null &&
                                                          //     !widget
                                                          //         .extraProperties!
                                                          //         .hasWritePermission!)
                                                          ) {
                                                        photoIdentityTypeDialog();
                                                      }
                                                    })),
                                          )
                                        : Container(),
                                    widget.passId ==
                                            ConstantsIntValue.passIdVisitor
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    /// Host Employee Id
                                    (((state.selectedCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions') &&
                                                widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdDayPass) ||
                                            widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVisitor ||
                                            widget.passId ==
                                                ConstantsIntValue.passIdVendor
                                        ? CommonWidgets.textDisplay(
                                            state.labels?.locale
                                                    .hostEmployeeId ??
                                                state.labels?.defaultLocale
                                                    .hostEmployeeId ??
                                                Constants.hostemployeeid,
                                            isMandatory: true,
                                            Styles.textStyleBlack14)
                                        : Container(),

                                    (((state.selectedCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions') &&
                                                widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdDayPass) ||
                                            widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVisitor ||
                                            widget.passId ==
                                                ConstantsIntValue.passIdVendor
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    // articleaddButtonwidgetLoading(state),
                                    (((state.selectedCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions') &&
                                                widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdDayPass) ||
                                            widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVisitor ||
                                            widget.passId ==
                                                ConstantsIntValue.passIdVendor
                                        ? dbSponsorAddButtonWidgetLoading(state)
                                        : Container(),
                                    (((state.selectedCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions') &&
                                                widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdDayPass) ||
                                            widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVisitor ||
                                            widget.passId ==
                                                ConstantsIntValue.passIdVendor
                                        // widget.passId == ConstantsIntValue.passIdSez ||
                                        // (state.selectedCompanyType?.name ==
                                        //         null &&
                                        //     widget.passId == ConstantsIntValue.passIdDayPass)
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    /// Host
                                    (((state.selectedCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions') &&
                                                widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdDayPass) ||
                                            widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVisitor ||
                                            widget.passId ==
                                                ConstantsIntValue.passIdVendor
                                        ? CommonWidgets.textDisplay(
                                            state.labels?.locale.host ??
                                                state.labels?.defaultLocale
                                                    .host ??
                                                Constants.host,
                                            isMandatory: true,
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    (((state.selectedCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions') &&
                                                widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdDayPass) ||
                                            widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVisitor ||
                                            widget.passId ==
                                                ConstantsIntValue.passIdVendor
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),

                                    (((state.selectedCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions') &&
                                                widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdDayPass) ||
                                            widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVisitor ||
                                            widget.passId ==
                                                ConstantsIntValue.passIdVendor
                                        ? FlutterInputField(
                                            controller:
                                                hostEmployeeIdTextController,
                                            textInputType: TextInputType.text,
                                            textFormKey: Keys.nameKey,
                                            hintText: '',
                                            focusNode: companyNameFocusNode,
                                            isEnable: false,
                                            isDisableColor: true,
                                            onChange: (String value) {
                                              // nameTextController.text =
                                              //     value;
                                            },
                                            validateTextField:
                                                (String? user) {},
                                          )
                                        : Container(),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// department
                                    widget.passId == ConstantsIntValue.passIdSez
                                        ? Container()
                                        : CommonWidgets.textDisplay(
                                            widget.passId ==
                                                        ConstantsIntValue
                                                            .passIdVisitor ||
                                                    widget
                                                            .passId ==
                                                        ConstantsIntValue
                                                            .passIdVendor
                                                ? state.labels?.locale
                                                        .visitingDepartment ??
                                                    state.labels?.defaultLocale
                                                        .visitingDepartment ??
                                                    Constants.visitingDepartment
                                                : Constants.department,
                                            isMandatory:
                                                (state.selectedCompanyType
                                                                    ?.name ??
                                                                '')
                                                            .toLowerCase() ==
                                                        'exceptions'
                                                    ? false
                                                    : true,
                                            Styles.textStyleBlack14),
                                    widget.passId == ConstantsIntValue.passIdSez
                                        ? Container()
                                        : CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    widget.passId == ConstantsIntValue.passIdSez
                                        ? Container()
                                        : departmentaddButtonwidgetLoading(
                                            state),
                                    widget.passId == ConstantsIntValue.passIdSez
                                        ? Container()
                                        : CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                    /// Reason for day pass
                                    if (widget.passId ==
                                            ConstantsIntValue.passIdDayPass ||
                                        widget.passId ==
                                            ConstantsIntValue.passIdVendor) ...[
                                      CommonWidgets.textDisplay(
                                        widget.passId ==
                                                ConstantsIntValue.passIdVendor
                                            ? state.labels?.locale
                                                    .vendorPassReason ??
                                                state.labels?.defaultLocale
                                                    .vendorPassReason ??
                                                Constants.reasonForVendorPass
                                            : state.labels?.locale
                                                    .dayPassReason ??
                                                state.labels?.defaultLocale
                                                    .dayPassReason ??
                                                Constants.reasonfordaypass,
                                        isMandatory: true,
                                        Styles.textStyleBlack14,
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      reasonforadaypassaddButtonwidgetLoading(
                                        state,
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                    ],

                                    /// Exceptional approval for External auditors/regulators
                                    if (state.dayPasselementReason != null &&
                                        (state.dayPasselementReason!.name
                                                .equalsIgnoreCase(
                                                    'external auditors') ||
                                            state.dayPasselementReason!.name
                                                .equalsIgnoreCase(
                                                    'external regulators'))) ...[
                                      Column(
                                        children: [
                                          CommonWidgets.textDisplay(
                                            state.labels?.locale
                                                    .exceptionalApproval ??
                                                state.labels?.defaultLocale
                                                    .exceptionalApproval ??
                                                Constants.exceptionalApproval,
                                            Styles.textStyleBlack14,
                                            isMandatory: true,
                                          ),
                                          radioButtonHandling(
                                              state.exceptionalApproval),
                                        ],
                                      ),
                                    ],

                                    if (widget.passId !=
                                        ConstantsIntValue.passIdSez) ...[
                                      /// Day  pass no
                                      CommonWidgets.textDisplay(
                                        widget
                                                    .passId ==
                                                ConstantsIntValue.passIdVisitor
                                            ? state.labels?.locale
                                                    .visitorPassInfo ??
                                                state.labels?.defaultLocale
                                                    .visitorPassInfo ??
                                                Constants.visitorPassNo
                                            : widget
                                                        .passId ==
                                                    ConstantsIntValue
                                                        .passIdVendor
                                                ? state.labels
                                                        ?.locale.vendorPassInfo ??
                                                    state.labels?.defaultLocale
                                                        .vendorPassInfo ??
                                                    Constants.vendorPassNo
                                                : state.labels?.locale
                                                        .dayPassInfo ??
                                                    state.labels?.defaultLocale
                                                        .dayPassInfo ??
                                                    Constants.daypassno,
                                        isMandatory: true,
                                        Styles.textStyleBlack14,
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      GestureDetector(
                                        onTap: () {
                                          if ((widget.model == null ||
                                                  widget.model?.status == 0)
                                              // &&
                                              // !(widget.extraProperties !=
                                              //     null &&
                                              //     !widget.extraProperties!
                                              //         .hasWritePermission!)
                                              ) {
                                            if (!isDisabled) {
                                              //daypassNoDialog();
                                              //passnumberaddButtonwidgetLoading(state);
                                              // if (widget.passId == ConstantsIntValue.passIdSez) {
                                              //   passCategoryDialog(state: state);
                                              // } else {
                                              passNumberTypeDialog(state);
                                              // }
                                            }
                                          }
                                        },
                                        child: FlutterInputField(
                                            isEnable: false,
                                            isDisableColor: (widget.model ==
                                                            null ||
                                                        passCategoryTextController
                                                            .text.isEmpty ||
                                                        widget.model?.status ==
                                                            0)
                                                ? false
                                                : true,
                                            controller: daypassnoTextController,
                                            textFormKey:
                                                Keys.statusTextController,
                                            hintText: '',
                                            onChange: (String username) {
                                              //this.username = username;
                                              setState(() {});
                                            },
                                            onTap: () {
                                              if ((widget.model == null ||
                                                      daypassnoTextController
                                                          .text.isEmpty ||
                                                      widget.model?.status ==
                                                          0) ) {
                                                //passnumberaddButtonwidgetLoading(state);
                                                // if (widget.passId == ConstantsIntValue.passIdSez) {
                                                //   passCategoryDialog(state: state);
                                                // } else {
                                                passNumberTypeDialog(state);
                                                // }
                                              }
                                            },
                                            validateTextField:
                                                (String? user) {},
                                            suffixWidget: IconButton(
                                                icon: SvgPicture.asset(
                                                    width: 10,
                                                    height: 10,
                                                    AppIcon.dropdownicon,
                                                    key: const Key(
                                                        'closed_eye')),
                                                onPressed: () {
                                                  log('suffixIcon pressed');
                                                  if ((widget.model == null ||
                                                          widget.model
                                                                  ?.status ==
                                                              0) &&
                                                      !(widget.extraProperties !=
                                                              null &&
                                                          !widget
                                                              .extraProperties!
                                                              .hasWritePermission!)) {
                                                    //passnumberaddButtonwidgetLoading(state);
                                                    // if (widget.passId == ConstantsIntValue.passIdSez) {
                                                    //   passCategoryDialog(
                                                    //       state: state);
                                                    // } else {
                                                    passNumberTypeDialog(state);
                                                    //}
                                                  }
                                                })),
                                      ),
                                    ],
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Pass Valid From
                                    if (widget.passId !=
                                        ConstantsIntValue.passIdSez) ...[
                                      CommonWidgets.textDisplay(
                                          state.labels?.locale.startTime ??
                                              state.labels?.defaultLocale
                                                  .startTime ??
                                              Constants.passvlidfrom,
                                          isMandatory: true,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      datepickerWidgetLoading(
                                          passValidFromTextController),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                    ],
                                    if (widget.passId ==
                                        ConstantsIntValue.passIdSez) ...[
                                      CommonWidgets.textDisplay(
                                          state.labels?.locale.passIssuedOn ??
                                              state.labels?.defaultLocale
                                                  .passIssuedOn ??
                                              Constants.passIssuedOn,
                                          isMandatory: true,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      // datepickerWidgetLoading(
                                      //     passvalidfromTextController),
                                      BaseDate().datePickerWidgetLoading(
                                        isDisabled: (widget.model?.status ==
                                                        0 ||
                                                    widget.model?.status ==
                                                        null)
                                            ? false
                                            : true,
                                        showFutureDate: false,
                                        textController:
                                            passValidFromTextController,
                                        onlyDate: false,
                                        onChange: (String value) {
                                          passValidFromTextController.text =
                                              Utils.timestampToDateConversion(
                                                  int.parse(
                                                      widget.model?.startTime ??
                                                          '0'),
                                                  Constants.fulldateFormat);
                                        },
                                        context: context,
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                    ],

                                    /// Pass Valid Until
                                    CommonWidgets.textDisplay(
                                        state.labels?.locale.endTime ??
                                            state.labels?.defaultLocale
                                                .endTime ??
                                            Constants.passvliduntil,
                                        isMandatory: true,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    // datepickerWidgetLoading(
                                    //     passvaliduntilTextController),

                                    BaseDate().datePickerWidgetLoading(
                                      isDisabled:
                                          (state.selectedCompanyType?.name ??
                                                          '')
                                                      .toLowerCase() !=
                                                  'exceptions' ||
                                              (widget.model?.status != 0 &&
                                                      widget.model?.status !=
                                                          null) &&
                                                  !(widget.extraProperties !=
                                                          null &&
                                                      !widget.extraProperties!
                                                          .hasWritePermission!),
                                      showPastDate: false,
                                      textController:
                                          passValidUntilTextController,
                                      onlyDate: widget.passId !=
                                              ConstantsIntValue.passIdSez
                                          ? false
                                          : true,
                                      onChange: (String value) {
                                        /// Make Pass Valid Date Editable if the Company Type is 'Exceptions'
                                        if (
                                            !widget.model!.companyType!.name!
                                                .contains('Exceptions')) {
                                          passValidUntilTextController.text =
                                              Utils.timestampToDateConversion(
                                                  int.parse(
                                                      widget.model?.endTime ??
                                                          '0'),
                                                  Constants.dateFormat);
                                        }
                                      },
                                      context: context,
                                    ),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Escorted by Host
                                    widget.passId ==
                                            ConstantsIntValue.passIdVisitor
                                        ? CommonWidgets.textDisplay(
                                            state.labels?.locale
                                                    .escortedByHost ??
                                                state.labels?.defaultLocale
                                                    .escortedByHost ??
                                                Constants.escortedByHost,
                                            isMandatory: true,
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.passId ==
                                            ConstantsIntValue.passIdVisitor
                                        ? radioButtonHandling(
                                            state.escortedbyhost ?? 0,
                                          )
                                        : Container(),
                                    // Text('state.escortedbyhost--- ${widget.model?.escortedByHost}'),
                                    // Text('state.email--- ${state.escorted}'),
                                    /// Escorted By
                                    (widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdVendor ||
                                                (widget.passId ==
                                                        ConstantsIntValue
                                                            .passIdVisitor &&
                                                    (state.escortedbyhost ??
                                                            0) ==
                                                        0)) &&
                                            widget
                                                    .model?.companyType?.name
                                                    ?.toLowerCase() !=
                                                'cwr t1'
                                        ? CommonWidgets.textDisplay(
                                            state.showIdentifiedFields
                                                ? state.labels?.locale
                                                        .identifiedBy ??
                                                    state.labels?.defaultLocale
                                                        .identifiedBy ??
                                                    Constants.identifiedBy
                                                : state.labels?.locale
                                                        .escortedBy ??
                                                    state.labels?.defaultLocale
                                                        .escortedBy ??
                                                    Constants.escortedby,
                                            isMandatory: true,
                                            Styles.textStyleBlack14)
                                        // :CommonWidgets.textDisplay(
                                        // Constants.identifiedBy,
                                        // isMandatory: true,
                                        // Styles.textStyleBlack14),
                                        : Container(),
                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVendor ||
                                            (widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdVisitor &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVendor ||
                                            (widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdVisitor &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? textFieldWidgetLoad(
                                            controller:
                                                escortedByTextController,
                                            index: 0,
                                            state: state,
                                          )
                                        : Container(),
                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVendor ||
                                            widget.passId ==
                                                ConstantsIntValue.passIdSez ||
                                            (widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdVisitor &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    /// Escorted By Employee Id
                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVendor ||
                                            (widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdVisitor &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? CommonWidgets.textDisplay(
                                            state.showIdentifiedFields
                                                ? state.labels?.locale
                                                        .identifiedEmployeeId ??
                                                    state.labels?.defaultLocale
                                                        .identifiedEmployeeId ??
                                                    Constants
                                                        .identifiedByEmployeeId
                                                : state.labels?.locale
                                                        .escortedEmployeeId ??
                                                    state.labels?.defaultLocale
                                                        .escortedEmployeeId ??
                                                    Constants
                                                        .escortedbyemployeeid,
                                            isMandatory: true,
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVendor ||
                                            (widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdVisitor &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVendor ||
                                            (widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdVisitor &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? textFieldWidgetLoad(
                                            controller:
                                                escortedEmployeeIdByTextController,
                                            index: 0,
                                            state: state,
                                          )
                                        : Container(),
                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVendor ||
                                            (widget.passId ==
                                                    ConstantsIntValue
                                                        .passIdVisitor &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    ///upload Photo of Visitor
                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVisitor &&
                                            ((widget.model == null ||
                                                    widget.model?.status ==
                                                        0) ||
                                                !(widget.extraProperties !=
                                                        null &&
                                                    !widget.extraProperties!
                                                        .hasWritePermission!))
                                        ? CommonWidgets.textDisplay(
                                            state.labels?.locale.visitorImage ??
                                                state.labels?.defaultLocale
                                                    .visitorImage ??
                                                Constants.photoOfVisitor,
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVisitor &&
                                            ((widget.model == null ||
                                                    widget.model?.status ==
                                                        0) &&
                                                !(widget.extraProperties !=
                                                        null &&
                                                    !widget.extraProperties!
                                                        .hasWritePermission!))
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    widget.passId ==
                                                ConstantsIntValue
                                                    .passIdVisitor &&
                                            ((widget.model == null ||
                                                    widget.model?.status ==
                                                        0) &&
                                                !(widget.extraProperties !=
                                                        null &&
                                                    !widget.extraProperties!
                                                        .hasWritePermission!))
                                        ? uploadWidget(state, true)
                                        : Container(),

                                    /// Attachments
                                    if (widget.passId ==
                                        ConstantsIntValue.passIdVisitor) ...[
                                      photogetSpaceattchment(height),
                                      BaseImageUpload().getAttachment(
                                        height: height,
                                        attachments: photogetAttachments,
                                        files: photogetFiles,
                                        showDeleteIcon:
                                            widget.model?.status != 0 &&
                                                    widget.model != null
                                                ? false
                                                : true,
                                        moduleCode:
                                            Constants.passManagementModuleCode,
                                        isDisabled: isDisabled,
                                      )
                                    ],
                                    // if (widget.passId ==
                                    //     ConstantsIntValue.passIdDayPass) ...[
                                    //   BaseImageUpload().getAttachment(
                                    //     height: height,
                                    //     attachments:
                                    //         state.loadAttachments.isEmptyOrNull
                                    //             ? getFiles
                                    //             : state.loadAttachments,
                                    //     files: getFiles.isEmptyOrNull
                                    //         ? getAttachments
                                    //         : getFiles,
                                    //     showDownloadIcon:
                                    //         widget.model == null ||
                                    //             widget.model?.status == 0,
                                    //     moduleCode:
                                    //         Constants.passManagementModuleCode,
                                    //   ),
                                    // ],

                                    ///upload
                                    if (widget.passId !=
                                        ConstantsIntValue.passIdVisitor) ...[
                                      ((widget.model == null ||
                                                  widget.model?.status == 0) ||
                                              !(widget.extraProperties !=
                                                      null &&
                                                  !widget.extraProperties!
                                                      .hasWritePermission!))
                                          ? CommonWidgets.textDisplay(
                                              state.labels?.locale
                                                      .evidenceInfo ??
                                                  state.labels?.defaultLocale
                                                      .evidenceInfo ??
                                                  Constants.evidenceDocuments,
                                              Styles.textStyleBlack14)
                                          : Container(),
                                      ((widget.model == null ||
                                                  widget.model?.status == 0) ||
                                              !(widget.extraProperties !=
                                                      null &&
                                                  !widget.extraProperties!
                                                      .hasWritePermission!))
                                          ? CommonWidgets.verticalSpacerWidget(
                                              height * 0.001)
                                          : Container(),
                                      ((widget.model == null ||
                                                  widget.model?.status == 0) ||
                                              !(widget.extraProperties !=
                                                      null &&
                                                  !widget.extraProperties!
                                                      .hasWritePermission!))
                                          ? uploadWidget(state, false)
                                          : Container(),

                                      /// Attachments
                                      BaseImageUpload().getAttachment(
                                        height: height,
                                        attachments: state.loadAttachments,
                                        files: getFiles,
                                        showDeleteIcon:
                                            widget.model?.status != 0 &&
                                                    widget.model != null
                                                ? false
                                                : true,
                                        moduleCode:
                                            Constants.passManagementModuleCode,
                                        isDisabled: isDisabled,
                                      ),
                                    ],
                                    // getSpaceattchment(height),
                                    // getAttachement(height),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.02),

                                    if (widget.model?.status ==
                                            ConstantsIntValue
                                                .passStatusReturned ||
                                        widget.model?.status ==
                                            ConstantsIntValue
                                                .passStatusReturnedDamaged ||
                                        widget.model?.status ==
                                            ConstantsIntValue
                                                .passStatusReturnedDefaced) ...[
                                      /// Pass Collected By
                                      CommonWidgets.horizentaltextHandling(
                                        state.labels?.locale.handoverSecurity ??
                                            state.labels?.defaultLocale
                                                .handoverSecurity ??
                                            Constants.passCollectedBy,
                                        isMandatory: true,
                                        '${widget.model?.handoverSecurity?.firstName ?? ''} ${widget.model?.handoverSecurity?.lastName ?? ''}',
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                      CommonWidgets.textDisplay(
                                          state.labels?.locale.returnedTime ??
                                              state.labels?.defaultLocale
                                                  .returnedTime ??
                                              Constants.passReturnedOn,
                                          isMandatory: true,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      datepickerWidgetLoading(
                                          passReturnedTextController),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                    ],

                                    /// SubmitButton
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        if (isShowSaveAndSubmitButton) ...[
                                          cancelButtonDisplay(),
                                          submitButtonDisplay()
                                        ],
                                      ],
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.03),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (!isShowSaveAndSubmitButton) ...[
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: const ShapeDecoration(
                          color: AppColors.backgroundWhiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(00.0)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            cancelButtonDisplay(),
                          ],
                        ),
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.03),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  Widget radioButtonHandling(int selectedValue) {
    bool isEditable =
        (widget.model?.status == null || widget.model?.status == 0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: isEditable
              ? AppColors.navigationSkyBlueColor
              : AppColors.disableTextFieldBackground,
          focusColor: AppColors.navigationSkyBlueColor,
          value: 1,
          groupValue: selectedValue,
          onChanged: isEditable
              ? (val) {
                  selectedValue = 1;
                  createPassMgmtCubit.getRadioButtonSelected(selectedValue);
                }
              : null,
        ),
        const Text(Constants.yes),
        Radio(
          activeColor: isEditable
              ? AppColors.navigationSkyBlueColor
              : AppColors.disableTextFieldBackground,
          value: 0,
          groupValue: selectedValue,
          onChanged: isEditable
              ? (val) {
                  selectedValue = 0;
                  createPassMgmtCubit.getRadioButtonSelected(selectedValue);
                }
              : null,
        ),
        const Text(Constants.no),
      ],
    );
  }

  populateData() async {
    log('Radio ${widget.model?.exceptionalApproval}');
    if (widget.model != null) {
      int value = 0;
      if (widget.model!.escortedByHost ?? false) {
        value = 1;
      }
      if(widget.model!.exceptionalApproval?? true){
        value = 1;
      }
      createPassMgmtCubit.getRadioButtonSelected(value);

      if (widget.model?.companyType?.name?.toLowerCase() == 'fte') {
        isFTECompanyNameEditable = false;
      }
      await SharedPrefs.setFoundId(widget.model?.id ?? 0);


      employeeIdTextController.text = widget.model?.employeeId != null
          ? widget.model?.employeeId.toString() ?? ""
          : widget.model?.employeeId.toString() ?? "";
      sezpassinfoTextController.text = widget.model?.passInfo != null
          ? widget.model?.passInfo.toString() ?? ""
          : '';
      companyNameTextController.text = widget.model?.companyName != null
          ? widget.model?.companyName.toString() ?? ""
          : '';
      mtpApplicationNoTextController.text = widget.model?.mifareNo != null
          ? widget.model?.mifareNo.toString() ?? ""
          : '';
      escortedEmployeeIdByTextController.text =
          widget.model?.escortedEmployeeId != null
              ? widget.model?.escortedEmployeeId.toString() ?? ""
              : '';
      escortedByTextController.text = widget.model?.escortedByName != null
          ? widget.model?.escortedByName.toString() ?? ""
          : '';
      // hostEmployeeIdTextController.text = widget.model?.host?.employeeId !=null
      //     ? widget.model?.host?.name ??''
      //     : 'dfgfd';

      hostEmployeeIdTextController.text = widget.model?.host?.name !=null?
          ('${widget.model?.host?.firstName} ${widget.model?.host?.lastName}' ?? ''):'';
      var userId = await SharedPrefs.getUserId();
      // BaseUser host1 = widget.dayPassItem?.host != null

      hostTextController.text = widget.model?.employeeId != null
          ? widget.model?.host?.employeeId.toString() ?? ""
          : '';
      User? host1 = widget.model?.host ??
          User(
            userId: widget.model?.host?.userId,
            name: widget.model?.host?.userInfo,
            employeeId: widget.model?.host?.employeeId,
          );
      // createPassMgmtCubit.gethostanalystsResponseData(host1);
      // createPassMgmtCubit.getdbsponsoranalystsResponseData(host1);
      createPassMgmtCubit.gethostUsersResponseData(host1);

      dbsponsorTextController.text = widget.model?.host?.userInfo != null
          ? widget.model?.host?.userInfo ?? ''
          : '';
      // BaseUser dbSponsor1 = dbsponsorTextController.text.isNotEmpty
      //     ? BaseUser(id: int.parse(userId), name: dbsponsorTextController.text)
      //     : BaseUser();
      User? dbSponsor1 = widget.model?.host ??
          User(
            userId: widget.model?.host?.userId,
            name: dbsponsorTextController.text,
            employeeId: widget.model?.host?.employeeId,
          );

      createPassMgmtCubit.getdbsponsorUsersResponseData(dbSponsor1);
      nameTextController.text =
          widget.passId == ConstantsIntValue.passIdDayPass &&
                  widget.model?.employeeName != null
              ? widget.model?.employeeName ?? ''
              : widget.model?.employeeName.toString() ?? '';
      vendorVisitorNameTextController.text = (widget.passId == ConstantsIntValue.passIdVisitor && widget.model?.employeeName != null ? widget.model?.employeeName??'' :  widget.model?.employeeName.toString()??'');
      var userid = await SharedPrefs.getUserId();

      BaseUser? name1 = (widget.model?.employee !=null ?
          BaseUser(
            id: widget.model?.employee?.userId,
            name: nameTextController.text,
            employeeId: widget.model?.employee?.employeeId
          ): BaseUser(
          id: widget.model?.employee?.userId,
          name: nameTextController.text,
          employeeId: widget.model?.employeeId
      ));
      createPassMgmtCubit.getNameUsersResponseData(name1);
      log('---employeeId---${widget.model?.employee?.employeeId}--');

      log('-widget.model?.inputDate---${widget.model?.inputDate}--');

      dateofcreationTextController.text =
          widget.model?.inputDate != null && widget.model?.inputDate != '0'
              ? Utils.timestampToDateConversion(
                  int.tryParse(widget.model?.inputDate ?? '0'),
                  Constants.fulldateFormat)
              : dateofcreationTextController.text;

      log('--dateofcreationTextController.text----${dateofcreationTextController.text}--');

      passValidFromTextController.text =
          widget.model?.startTime != null && widget.model?.startTime != '0'
              ? Utils.timestampToDateConversion(
                  int.parse(widget.model?.startTime ?? '0'),
                  Constants.fulldateFormat)
              : passValidFromTextController.text;
      passValidUntilTextController.text =
          widget.model?.endTime != null && widget.model?.endTime != '0'
              ? Utils.timestampToDateConversion(
                  int.parse(widget.model?.endTime ?? '0'),
                  widget.passId != ConstantsIntValue.passIdSez
                      ? Constants.fulldateFormat
                      : Constants.dateFormat)
              : passValidUntilTextController.text;

      passReturnedTextController.text = widget.model?.status == 2 ||
              widget.model?.status == 8 ||
              widget.model?.status == 9 &&
                  (widget.model?.returnedTime != null &&
                      widget.model?.returnedTime != '0')
          ? Utils.timestampToDateConversion(
              int.parse(widget.model?.returnedTime ?? '0'),
              Constants.fulldateFormat)
          : passReturnedTextController.text;

      log('-${widget.model?.status}-passReturnedTextController--${passReturnedTextController.text}-@@@----${widget.model?.returnedTime}--');
      // List<VisitingOfficial>? visitingOfficials = widget.listuser?.visitingOfficials != null ? widget.listuser?.visitingOfficials ?? [] : [];

      statusTextController.text =
          Utils().buildPassManagementStatus(widget.model?.status);

      log('---statusTextController.text--${statusTextController.text}-');
      if (widget.model?.passType == 1) {
        passTypeTextController.text = 'VISITOR_PASS';
      } else if (widget.model?.passType == 5) {
        passTypeTextController.text = 'DWS_VISITOR_PASS';
      } else if (widget.model?.passType == 2) {
        passTypeTextController.text = 'VENDOR_PASS';
      } else if (widget.model?.passType == 6) {
        passTypeTextController.text = 'DWS_VENDOR_PASS';
      } else if (widget.model?.passInfo?.passType == 3) {
        passTypeTextController.text = 'SEZ_PASS';
      }

      log('--passTypeTextController.text--------popu-${passTypeTextController.text}----');

      if (widget.model?.idValidationType == 0) {
        photofidentityextController.text = 'Aadhaar Card';
      } else if (widget.model?.idValidationType == 1) {
        photofidentityextController.text = 'Pan Card';
      } else if (widget.model?.idValidationType == 2) {
        photofidentityextController.text = 'Passport';
      } else if (widget.model?.idValidationType == 3) {
        photofidentityextController.text = 'Driving Licence';
      } else if (widget.model?.idValidationType == 4) {
        photofidentityextController.text = 'Voter Card';
      }

      //state.serialnumberResponse?.serialNo

      //  state.getUserDetailsResponse  =  widget.listuser?.entrySecurity != null ? GetUserDetails(
      //     userId: widget.listuser?.entrySecurity?.userId ?? 1,
      //     lastName: widget.listuser?.entrySecurity?.lastName ?? "") : GetUserDetails() ;

      //state.locationSelectedlist =
      // Organisation location = widget.model?.location != null
      //     ? Organisation(
      //         id: widget.model?.location?.id ?? 0,
      //         name: widget.model?.location?.name ?? "")
      //     : Organisation();

      log('--widget.model?.slNo--serialnumber---@@---222-${widget.model?.slNo}----');
      log('slno2--${serialnumber}----');

      if (widget.model?.slNo !=null) {
         serialnumber = widget.model?.slNo;
         log('slno2--${serialnumber}----');

      }
      if (serialnumber.isEmptyOrNull) {
        widget.model?.slNo ??
            await createPassMgmtCubit.getSerialnumberDetails(
              (widget.model!.location!),
              widget.passId,
            );
      }
      createPassMgmtCubit.getlocationsResponseData(widget.model?.location);
      Organisation active = Organisation(
          id: widget.model?.passInfo?.id ?? 0,
          name: widget.model?.passInfo?.passNo ?? '');
      if (widget.passId == ConstantsIntValue.passIdSez) {
        passCategoryTextController.text =
            widget.model?.category == 1 ? 'Permanent' : widget.model?.category == 2 ? 'Temporary' :'';
        log('-passCategoryTextController.text----${passCategoryTextController.text}-');
      }
      // daypassnoTextController.text =
      //     widget.dayPassItem?.category.toString() ?? '';

      log('-widget.model!.passInfo?.passNo----${widget.model!.passInfo?.passNo}-');

      daypassnoTextController.text = widget.model!.passInfo?.passNo ?? '';
      createPassMgmtCubit.getPassListResponseData(active);
      // await createpassmgmtCubit.getSerialnumberDetails(
      //     (widget.dayPassItem?.location?.id ?? 0).toString(),
      //     'SEZPass',
      //     context);
      createPassMgmtCubit.getPassNumber(0, widget.model?.location?.id ?? 0);
      createPassMgmtCubit.getlocationsResponseData(widget.model?.location);
      // createPassMgmtCubit.getRadioButtonSelected(widget.model?.exceptionalApproval == true ? 1 :0);
      if ((widget.model?.entities?.length ?? 0) > 0) {
        List<Organisation> entities = [];
        for (int i = 0; i < widget.model!.entities!.length; i++) {
          Organisation entity = widget.model?.entities != null &&
                  (widget.model?.entities?.length ?? 0) > 0
              ? Organisation(
                  id: widget.model?.entities![i].id ?? 0,
                  name: widget.model?.entities![i].name ?? "")
              : Organisation();
          // AtomEntity entity = state.listOfEntities![i];
          //   DbOfficialEmailDepartment addentiity =
          // DbOfficialEmailDepartment(id: entity.id ?? 1);
          entities.add(entity);
        }
        createPassMgmtCubit.getEntityData(entities);
      }

      Organisation companyType = widget.model?.companyType ?? Organisation();

      createPassMgmtCubit.selectedCompanyType(companyType);

      /// vendorPassReason
      Organisation? day = widget.model != null
          ? widget.model?.vendorPassReason?.id != null
              ? widget.model?.vendorPassReason
              : widget.model?.dayPassReason
          : Organisation();

      createPassMgmtCubit.getVendorPassReasonResponseData(day);
      createPassMgmtCubit.getdaypassreasonResponseData(day);

      Organisation dep = widget.model?.department ?? Organisation();
      createPassMgmtCubit.selectedEmployeeDepartment(dep);

      getAttachments = widget.model?.evidenceDocuments != null
          ? widget.model?.evidenceDocuments ?? []
          : [];

      getFiles = widget.model?.evidenceDocuments != null
          ? widget.model?.evidenceDocuments ?? []
          : [];

      log('-populate-getAttachments---${getFiles.length}---getFiles---${getFiles.length}--');
      // photogetAttachments =
      //     widget.model?.visitorImage != null ? widget.model?.visitorImage ?? [] : [];
      photogetAttachments = widget.model?.visitorImage != null
          ? [widget.model!.visitorImage!]
          : [];
      photogetFiles = widget.model?.visitorImage != null
          ? [widget.model!.visitorImage!]
          : [];
      emailTextController.text = widget.model?.email ?? '';
      purposeofvisitTextController.text = widget.model?.visitingPurpose ?? '';
      mtpApplicationNoTextController.text = widget.model?.mifareNo ?? '';
      visitorcomingfromTextController.text =
          widget.model?.visitorComingFrom ?? '';
      contactnoTextController.text = widget.model?.contactNo ?? '';
      employeeIdTextController.text = companyType.name == 'CWR T2'?widget.model?.employeeId ?? '' :widget.model?.employee?.employeeId ?? '' ;
      sezpassinfoTextController.text = widget.model?.passNo ?? '';
      //sezpassinfoTextController.text = widget.model?.passNo ?? '';
      //sezpassinfoTextController.text = widget.model?.passNo ?? '';
      dbsponsorTextController.text = widget.model?.host?.userInfo ?? '';
    }
  }

  getPassManagementList() async {
    if (widget.passId == ConstantsIntValue.passIdSez) {
      await createPassMgmtCubit.getLocations('ATOM_LOCATIONS', 1, context,
          isSezLocations: true);
    } else {
      await createPassMgmtCubit.getLocations('ATOM_LOCATIONS', null, context);
    }
    await createPassMgmtCubit.getEntities('ATOM_ENTITIES');
    await createPassMgmtCubit.getEmployeeDepartments(
      'EMPLOYEE_DEPARTMENTS',
    );
    if (widget.model == null ||
        (widget.model?.entrySecurity?.userName ?? '').isEmpty) {
      var userid = await SharedPrefs.getUserId();
      await createPassMgmtCubit.getUserDetails(
        userid,
      );
    } else {
      createdBy =
          '${widget.model?.entrySecurity?.firstName ?? ''} ${widget.model?.entrySecurity?.lastName ?? ''}';
    }
    await createPassMgmtCubit.companyTypes(
      name: widget.passId == ConstantsIntValue.passIdSez
          ? 'ATOM_SEZ_COMPANY_TYPES'
          : 'ATOM_COMPANY_TYPES',
    );
    await createPassMgmtCubit.getDayPassreasons(
      'DAY_PASS_REASON',
    );
    await createPassMgmtCubit.getVendorPassreasons(
      'VENDOR_PASS_REASON',
    );
    //await createpassmgmtCubit.getAnalysts('T1_Analyst');
    await createPassMgmtCubit.getUserByRoleDepositor();

    await CommonServices().getUiLabels(
        language: await SharedPrefs.getLanguageCode(),
        moduleCode: Constants.passManagementRolesModuleCode);
  }

  Widget submitButtonDisplay() {
    return // Login button
        AppButton(
      //height: 50,
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        try {
          // passSubmit(true, widget.listuser?.id ?? 0, globalState);
          passValidations(context, globalState);
        } catch (e) {
          // present userwith error message
        }
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
        updateRecordStatus();
        CommonServices().unlock();
      },
    );
  }

  void updateRecordStatus() {
    if (widget.model?.id != null) {
      // BlocProvider.of<CreatePassMgmtCubit>(context)
      //     .updateStatus(id: widget.model!.id!);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, daypassmanagementListRoute,
          arguments: {
            "passMngDetails": PassMngArguments(
                widget.passId,
                widget.title?.replaceAll('Edit', '') ?? 'Pass Management',
                false)
          });
    } else {
      Navigator.pop(context);
    }
  }

  daypassNoDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomSimpleListTexts(
            texts: const ["Personal", "company"],
            onTap: (String value) {
              log(value);
              daypassnoTextController.text = value;
              setState(() {});
            },
          );
        });
  }

  passTypeDialog(CreatePassMgmtState state) {
    log('--state.pastype-${state.passTypes?.length}------');

    BaseOrganisationDialog().departmentDialog(
      context: context,
      organisations: state.passTypes ?? [],
      onTap: (Organisation org) {
        log('---org.name-${org.name}-');

        log('---widget.model-${widget.model}-');
        log('---widget.model?.passType-${widget.model?.passType}-');
        state.model.passType = org.id;

        passTypeTextController.text = org.name ?? '';
      },
    );

    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return CustomSimpleListTexts(
    //         texts: state.passTypes,
    //         // texts: widget.passId == ConstantsIntValue.passIdVisitor &&
    //         //     (widget.model?.status == 0 || widget.model?.status == null)
    //         //     ? ["VISITOR_PASS", "DWS_VISITOR_PASS"]
    //         //     : widget.passId == ConstantsIntValue.passIdVendor
    //         //     ? ["VENDOR_PASS", "DWS_VENDOR_PASS"]
    //         //     : widget.passId == ConstantsIntValue.passIdDayPass &&
    //         //     (widget.model?.status == 0 ||
    //         //         widget.model?.status == null)
    //         //     ? ["DAY_PASS"]
    //         //     : widget.passId == ConstantsIntValue.passIdDayPass
    //         //     ? ["DAY_PASS", "DWS_DAY_PASS"]
    //         //     : widget.passId == ConstantsIntValue.passIdSez &&
    //         //     (widget.model?.status == 0 ||
    //         //         widget.model?.status == null)
    //         //     ? ["SEZ_PASS"]
    //         //     : ["SEZ_PASS", "DWS_SEZ_PASS"],
    //         onTap: (String value) {
    //           log(value);
    //           passTypeTextController.text = value;
    //         },
    //       );
    //     });
  }

  passCategoryDialog({required CreatePassMgmtState state}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomSimpleListTexts(
          texts: widget.passId == ConstantsIntValue.passIdSez
              ? ["Permanent", "Temporary"]
              // : widget.passId == ConstantsIntValue.passIdVendor
              //     ? ["VENDOR_PASS", "DWS_VENDOR_PASS"]
              : [],
          onTap: (String value) async {
            log(value);
            passCategoryTextController.text = value;

            String passValidUntilDate =
                await BlocProvider.of<CreatePassMgmtCubit>(context)
                    .getPassValidUntil(
              passCategory: value == 'Permanent'
                  ? ConstantsIntValue.passCategoryPermanent
                  : ConstantsIntValue.passCategoryTemporary,
            );

            widget.model?.companyType = state.selectedCompanyType;
            // BlocProvider.of<CreatePassMgmtCubit>(context)
            //     .companyTypes(
            //     name: 'ATOM_SEZ_COMPANY_TYPES',
            //     filter: value == 'Permanent' ? '1' : '0');
            // List<Organisation> companyTypes =
            //     await BlocProvider.of<CreatePassMgmtCubit>(context)
            //         .companyTypes(
            //             name: 'ATOM_SEZ_COMPANY_TYPES',
            //             filter: value == 'Permanent' ? '1' : '0');

            passValidUntilDate = Utils.timestampToDateConversion(
                int.tryParse(passValidUntilDate), Constants.dateFormat);

            if (value.equalsIgnoreCase('Permanent')) {
              passValidUntilTextController.text = passValidUntilDate;
              companyNameTextController.text = Constants.deutscheBank;
              isFTECompanyNameEditable = false;
            } else {
              passValidUntilTextController.text = passValidUntilDate;
              companyNameTextController.text =
                  widget.model?.companyName.toString() ?? "";
              (widget.model?.status == 0 || widget.model?.status == null) && value.equalsIgnoreCase('Temporary')
                  ? isFTECompanyNameEditable = true
                  : isFTECompanyNameEditable = false;
            }
            // }
            setState(() {});
          },
        );
      },
    );
  }

  photoIdentityTypeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomSimpleListTexts(
            texts: const [
              "Aadhaar Card",
              "Pan Card",
              "Passport",
              "Driving Licence",
              "Voter Card"
            ],
            onTap: (String value) {
              log(value);
              photofidentityextController.text = value;
              setState(() {});
            },
          );
        });
  }

  Widget departmentaddButtonwidgetLoading(CreatePassMgmtState state) {
    return TextFieldAddButton(
      title: state.selectedDepartment?.name ?? '',
      height: 60,
      isDisableColor:
          (widget.model == null || widget.model?.status == 0) ? false : true,
      onTap: () {
        if ((widget.model == null || widget.model?.status == 0)) {
          //  articleTypeDialog(state);
          departmentsDialog(state);
        }
      },
    );
  }

  Widget reasonforadaypassaddButtonwidgetLoading(CreatePassMgmtState state) {
    return Column(
      children: [
        TextFieldAddButton(
          title: widget.passId == ConstantsIntValue.passIdDayPass
              ? state.dayPasselementReason?.name ?? ''
              : state.vendorPasselementReason?.name ?? '',
          height: 60,
          isDisableColor:
              widget.model?.status == 0 || widget.model == null ? false : true,
          onTap: () {
            if ((widget.model == null || widget.model?.status == 0)) {
              log('--widget.passId---${widget.passId}---');
              if (widget.passId == ConstantsIntValue.passIdVendor) {
                vendorPassReasonDialog(state);
              } else if (widget.passId == ConstantsIntValue.passIdDayPass) {
                reasondaypassDialog(state);
              }
            }
          },
        ),
      ],
    );
  }

  Widget datepickerWidgetLoading(TextEditingController controller) {
    return GestureDetector(
      onTap: () {
        // if (widget.listuser == null || textfiled.text.isEmpty) {
        //   datePickerDialog(textfiled);
        // }
      },
      child: FlutterInputField(
        controller: controller,
        textFormKey: '',
        // textFormKey: textfiled != passvalidfromTextController ||
        //         textfiled != passvaliduntilTextController
        //     ? Keys.founddateTextController
        //     : Keys.actualdateTextController,
        hintText: '',
        isEnable: false,
        isDisableColor: true,
        //widget.listuser == null || textfiled.text.isEmpty ? false : true,
        onChange: (String username) {
          //this.username = username;
          log('');

          // setState(() {});
        },
        validateTextField: (String? user) {},
        suffixWidget: GestureDetector(
          onTap: () async {
            // if (widget.dayPassItem == null || textfiled.text.isEmpty)
            {
              datePickerDialog(controller);
            }
            // DateTime? pickedDate = await showDateTimePicker(
            //     context: context,
            //     initialDate: DateTime.now(),
            //     firstDate: DateTime(2000),
            //     lastDate: DateTime(2101));
            // String formattedDate = DateFormat(Constants.fulldateFormat)
            //     .format(pickedDate ?? DateTime.now());
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              AppIcon.calendaricon,
              colorFilter: const ColorFilter.mode(
                AppColors.textGreyThemeColor,
                BlendMode.srcIn,
              ),
              // color: AppColors.textGreyThemeColor,
              width: 20,
              key: const Key(Keys.userIcon),
            ),
          ),
        ),
      ),
    );
  }

  datePickerDialog(TextEditingController textfield) async {
    // datePickerselection(context, founddateTextController);
    DateTime? pickedDate = await showDateTimePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    //log(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat(Constants.fulldateFormat)
        .format(pickedDate ?? DateTime.now());
    log(formattedDate); //formatted date output using intl package =>  2021-03-16
    //you can implement different kind of Date Format here according to your requirement
    if (textfield == passValidFromTextController) {
      passValidFromTextController.text = formattedDate;
    }
    // setState(() {
    //   // dateinput.text = formattedDate; //set output date to TextField value.
    // });
  }

  // String _getCurrentDates() {
  //   return DateFormat(Constants.fulldateFormat).format(DateTime.now());
  // }

  final currentDate = DateTime.now();

  void _getCurrentDate() {
    String currentFormattedDate =
        DateFormat(Constants.fulldateFormat).format(currentDate);
    dateofcreationTextController.text = currentFormattedDate;
    log('--------currentFormattedDate--$currentFormattedDate-');
    log('-------passReturnedTextControllere--${passReturnedTextController.text}-');

    passReturnedTextController.text =
        widget.model?.status == 1 ? currentFormattedDate : '';
    log('-------passReturned1111--${passReturnedTextController.text}-');

    if (widget.passId != ConstantsIntValue.passIdSez) {
      passValidFromTextController.text = currentFormattedDate;
      String nextFormattedDate = DateFormat(Constants.fulldateFormat)
          .format(currentDate.add(const Duration(hours: 12)));
      log('---nextFormattedDate----$nextFormattedDate------');
      passValidUntilTextController.text = nextFormattedDate;
    }
    if (widget.model == null) {
      statusTextController.text = 'Created';
    }
  }

  Widget uploadWidget(CreatePassMgmtState state, bool isPhotoType) {
    return // upload
        widget.model == null || widget.model?.status == 0
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
                        backgroundColor: AppColors.navigationSkyBlueColor,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return UploadAttachment(
                                userdetails: state.getUserDetailsResponse,
                                getFiles:
                                    isPhotoType ? photogetFiles : getFiles,
                                createpassmgmtstate: state,
                                isPhotoType: isPhotoType,
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

  // Widget getSpaceattchment(double height) {
  //   return getFiles.isNotEmpty || getAttachments.isNotEmpty
  //       ? CommonWidgets.verticalSpacerWidget(height * 0.01)
  //       : Container();
  // }

  // Widget getAttachement(double height) {
  //   return (getAttachments.isEmpty || widget.model == null)
  //       ? getFiles.isEmpty
  //           ? Container()
  //           : attachmentListviews(getFiles, getAttachments)
  //       : attachmentListviews(getFiles, getAttachments);
  // }

  Widget photogetSpaceattchment(double height) {
    return photogetFiles.isNotEmpty || photogetAttachments.isNotEmpty
        ? CommonWidgets.verticalSpacerWidget(height * 0.01)
        : Container();
  }

  Widget entityaddButtonwidgetLoading(CreatePassMgmtState state) {
    return BaseEntitiesSelection().entityDropDownSelection(
      context: context,
      selectedValues: state.selectedEntities ?? [],
      all: state.getEntitiesResponse?.atomEntities ?? [],
      onTap: (List<Organisation> list) {
        createPassMgmtCubit.getEntityData(list);
        Navigator.pop(context);
      },
      enabled: widget.model == null || widget.model?.status == 0,
      addTitle: Constants.addentitytype,
      orgName: 'ATOM_ENTITIES',
      createEntity: widget.model == null || widget.model?.status == 0,
    );
  }

  departmentsDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateEmployeeDepartments:
                state.employeeDepartment?.employeeDepartments ?? [],
            // leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddEmployeeDepartment(
                      title: Constants.addEmployeeDepartment,
                      createPassMgmtState: state,
                    );
                  });
            },
            onTap: (Organisation list) {
              //log(list.name);
              createPassMgmtCubit.selectedEmployeeDepartment(list);
            },
          );
        });
  }

  Widget companytypeaddButtonwidgetLoading(CreatePassMgmtState state) {
    return TextFieldAddButton(
      title: passCategoryTextController.text == 'Permanent'
          ? "FTE"
          : state.selectedCompanyType?.name ?? '',
      height: 60,
      isDisableColor: !((widget.model == null || widget.model?.status == 0)),
      onTap: () {
        if ((widget.model == null || widget.model?.status == 0)) {
          companyTypeDialog(state);
        }
        FocusScope.of(context).requestFocus(companyNameFocusNode);
      },
    );
  }

  companyTypeDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateatomCompanyTypes: state.companyTypes ?? [],
            leftImageName: null,
            // onLeftButtonTap: () {
            // Navigator.pop(context);
            // showDialog(
            //     context: context,
            //     builder: (BuildContext dialogContext) {
            //       return AddNewFields(
            //           title: Constants.addcompanytype,
            //           createPassmgmtState: state);
            //     });
            // },
            onTap: (Organisation organisation) {
              //log(list.name);
              // isEditable = true;
              companyNameTextController.text = "";
              if(widget.model?.status == 0 || widget.model == null) {
                if ((organisation.name ?? '').toLowerCase() == 'fte') {
                  companyNameTextController.text = "Deutsche Bank";
                  isFTECompanyNameEditable = false;
                } else {
                  isFTECompanyNameEditable = true;
                }
              }
              log('--organisation.name ---${organisation.name}---');
              if ((organisation.name ?? '').toLowerCase() != 'exceptions' && widget.passId != ConstantsIntValue.passIdSez) {
                log('--if----organisation.name ---${organisation.name}---');
                String nextFormattedDate = DateFormat(Constants.fulldateFormat)
                    .format(currentDate.add(const Duration(hours: 12)));
                log('---nextFormattedDate----$nextFormattedDate------');
                passValidUntilTextController.text = nextFormattedDate;
              }
              state.nameResponse?.employeeId = null;
              state.dbsponsorResponse?.employeeId = null;
              widget.model?.host?.userInfo = null;
              nameTextController.text = '';
              dbsponsorTextController.text = '';
              createPassMgmtCubit.selectedCompanyType(organisation);
            },
          );
        });
  }

  reasondaypassDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicatedayPassReason:
                state.dayPassReason?.dayPassReasonElement ?? [],
            // leftImageName: widget.passId == ConstantsIntValue.passIdDayPass ||
            //         widget.passId == ConstantsIntValue.passIdVendor
            //     ? AppIcon.addicon
            //     : null,
            onLeftButtonTap: () {
              if (widget.passId == ConstantsIntValue.passIdDayPass ||
                  widget.passId == ConstantsIntValue.passIdVendor) {
                Navigator.pop(context);
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AddNewFields(
                        title: widget.passId == ConstantsIntValue.passIdDayPass
                            ? Constants.addreasonfordaypass
                            : Constants.addreasonforvendorpass,
                        createPassmgmtState: state,
                      );
                    });
              }
            },
            onTap: (Organisation organisation) {
              // setState(() {
              //   log('reason for day pass list---${organisation.name}');
              //   if (((organisation.name ?? '').toLowerCase() ==
              //       'external auditors' ||
              //       (organisation.name ?? '').toLowerCase() ==
              //           'external regulators')) {
              //     Column(
              //       children: [
              //         CommonWidgets.textDisplay(
              //           Constants.exceptionalApproval,
              //           isMandatory: true,
              //           Styles.textStyleBlack14,
              //         ),
              //         radioButtonHandling(
              //           state.exceptionalApproval ?? 1,
              //           Constants.exceptionalApproval,
              //         ),
              //       ],
              //     );
              //   }
              // });
              createPassMgmtCubit.getVendorPassReasonResponseData(organisation);
              createPassMgmtCubit.getdaypassreasonResponseData(organisation);
            },
          );
        });
  }

  vendorPassReasonDialog(CreatePassMgmtState state) {
    log('--state.vendorPassReason?.vendorPassReason--${state.vendorPassReason?.vendorPassReason.toString()}--');
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicatedayPassReason:
                state.vendorPassReason?.vendorPassReason ?? [],
            // leftImageName: widget.passId == ConstantsIntValue.passIdVendor
            //     ? AppIcon.addicon
            //     : null,
            onLeftButtonTap: () {
              if (widget.passId == ConstantsIntValue.passIdVendor) {
                Navigator.pop(context);
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AddNewFields(
                        title: widget.passId == ConstantsIntValue.passIdVendor
                            ? Constants.addreasonforvendorpass
                            : Constants.addreasonforvendorpass,
                        createPassmgmtState: state,
                      );
                    });
              }
            },
            onTap: (Organisation org) {
              //log(list.name);
              createPassMgmtCubit.getVendorPassReasonResponseData(org);
            },
          );
        });
  }

  Widget nameAddButtonWidgetLoading(CreatePassMgmtState state) {
    return TextFieldAddButton(
      title: state.nameResponse?.employeeId,
      height: 60,
      isDisableColor: widget.model?.status == 0 ||
              widget.model == null
          ? false
          : true,
      onTap: () {
        if ((state.selectedCompanyType?.name ?? '').toLowerCase() == 'fte' &&
            state.model.status ==
                ConstantsIntValue.articleFoundStatusHandedOverOrClaimed) {
          return;
        }

        if (widget.model?.status == 0 || widget.model == null) {
          BaseOrganisationDialog().userDialog(
            employeeId: true,
            context: context,
            users: state.getDepositorResponse,
            roleName: ConstantUserRoles.atomStaticUser,
            locationId: state.location!.id!,
            isDbUser: true,
            functionToCall: (BaseUser user) {
              createPassMgmtCubit.getNameUsersResponseData(user);
              BlocProvider.of<CreatePassMgmtCubit>(context).refreshList();
            },
            onTap: (BaseUser user) {
              // BlocProvider.of<CreatePassMgmtCubit>(context)
              //     .updateDropdownValues(
              //   locationSecurityManager1: state.getDepositorResponse?.atomStaticUser,
              // );
              createPassMgmtCubit.getNameUsersResponseData(user);
              nameTextController.text = '${user.name} (${user.email})' ?? '';
            },
          );
        }
      },
      // onTap: () {
      //   if (widget.model == null ||
      //       (state.nameResponse != null &&
      //           ((state.nameResponse?.name ?? '').isEmpty))) {
      //     //   articleTypeDialog(state);
      //     // leodepartmentsDialog(state, 0);
      //     nameTypeDialog(state);
      //   }
      // },
    );
  }

  nameTypeDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            //duplicatet1Analyst: state.analyst?.t1Analyst ?? [],
            duplicateDepostorList: state.getDepositorResponse ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return CreateFoundNewUser(
                      title: Constants.createnewuser,
                      createpassmgmtstate: state,
                      locationId: state.location!.id!,
                    );
                  });
            },
            onTap: (BaseUser list) {
              //log(list.name);
              //createpassmgmtCubit.getnameanalystsResponseData(list);
              createPassMgmtCubit.getNameUsersResponseData(list);
            },
          );
        });
  }

  Widget hostAddButtonWidgetLoading(CreatePassMgmtState state) {
    return TextFieldAddButton(
      title: state.hostResponse?.employeeId,
      height: 60,
      isDisableColor: widget.model?.status == 0 || widget.model?.status == null
          ? false
          : true,
      onTap: () {
        if ((widget.model == null || widget.model?.status == 0)) {
          BaseOrganisationDialog().userDialog(
            employeeId: true,
            context: context,
            users: state.getDepositorResponse!,
            roleName: ConstantUserRoles.atomStaticUser,
            locationId: state.location!.id!,
            isDbUser: true,
            functionToCall: (BaseUser user) {
              createPassMgmtCubit.gethostUsersResponseData(User(
                  userId: user.id,
                  name: user.name,
                  employeeId: user.employeeId));
              BlocProvider.of<CreatePassMgmtCubit>(context).refreshList();
            },
            onTap: (BaseUser user) {
              // BlocProvider.of<CreatePassMgmtCubit>(context)
              //     .updateDropdownValues(
              //   locationSecurityManager1: state.getDepositorResponse?.atomStaticUser,
              // );
              createPassMgmtCubit.gethostUsersResponseData(User(
                  userId: user.id,
                  name: user.name,
                  employeeId: user.employeeId,email: user.email));
              hostEmployeeIdTextController.text =
                  '${user.name} (${user.email}})' ?? '';
            },
          );
        }
      },
    );
  }

  hostTypeDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateDepostorList: state.getDepositorResponse ??
                [], //state.analyst?.t1Analyst ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return CreateFoundNewUser(
                      title: Constants.createnewuser,
                      createpassmgmtstate: state,
                      locationId: state.location!.id!,
                    );
                  });
            },
            onTap: (BaseUser baseUser) {
              //log(list.name);

              createPassMgmtCubit.gethostUsersResponseData(User(
                  userId: baseUser.id,
                  name: baseUser.name,
                  employeeId: baseUser.employeeId,
              email: baseUser.email));
            },
          );
        });
  }

  Widget dbSponsorAddButtonWidgetLoading(CreatePassMgmtState state) {
    return TextFieldAddButton(
      title: state.dbsponsorResponse?.employeeId,
      height: 60,
      isDisableColor:
          widget.model?.status == 0 || widget.model == null ? false : true,
      onTap: () {
        if ((widget.model == null || widget.model?.status == 0)) {
          BaseOrganisationDialog().userDialog(
            employeeId: true,
            context: context,
            users: state.getDepositorResponse,
            roleName: ConstantUserRoles.atomStaticUser,
            locationId: state.location!.id!,
            isDbUser: true,
            functionToCall: (BaseUser user) {
              createPassMgmtCubit.getdbsponsorUsersResponseData(User(
                  userId: user.id,
                  name: user.name,
                  employeeId: user.employeeId));
              BlocProvider.of<CreatePassMgmtCubit>(context).refreshList();
            },
            onTap: (BaseUser user) {
              if(user.employeeId != state.nameResponse?.employeeId) {
                createPassMgmtCubit.getdbsponsorUsersResponseData(User(
                    userId: user.id,
                    name: user.name,
                    employeeId: user.employeeId,
                    email: user.email));
                dbsponsorTextController.text =
                    '${user.name} (${user.email})' ?? '';
                hostEmployeeIdTextController.text =
                    '${user.name} (${user.email})' ?? '';
              }
              else if(user.employeeId == state.nameResponse?.employeeId){
                Validator().showToast(
                    context,
                    "Same user selected in multiple lists",
                  );
                }
              return;
            },
          );
        }
      },
      // onTap: () {
      //   if (widget.model == null || widget.model?.status == 0) {
      //     dbsponsorTypeDialog(state);
      //   }
      // },
    );
  }

  // dbSponsorTypeDialog(CreatePassMgmtState state) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext dialogContext) {
  //         return CustomListTexts(
  //           //duplicatet1Analyst:
  //           duplicateDepostorList: state.getDepositorResponse ?? [],
  //           leftImageName: AppIcon.addicon,
  //           onLeftButtonTap: () {
  //             Navigator.pop(context);
  //             showDialog(
  //                 barrierDismissible: false,
  //                 context: context,
  //                 builder: (BuildContext dialogContext) {
  //                   return CreateFoundNewUser(
  //                     title: Constants.createnewuser,
  //                     createpassmgmtstate: state,
  //                     locationId: state.location!.id!,
  //                   );
  //                 });
  //           },
  //           onTap: (BaseUser baseUser) {
  //             //log(list.name);
  //             //dbsponsorTextController.text = list.name??'';
  //             createPassMgmtCubit.getdbsponsorUsersResponseData(
  //                 User(userId: baseUser.id, name: baseUser.name));
  //           },
  //         );
  //       });
  // }

  // Widget passnumberaddButtonwidgetLoading(CreatePassMgmtState state) {
  //   return TextfieldAddButton(
  //     title: state.activePassInfoList?.name ?? '',
  //     height: 60,
  //     isDisableColor: widget.listuser == null ||
  //             (state.activePassInfoList != null &&
  //                 ((state.activePassInfoList?.name ?? '')
  //                     .isEmpty))
  //         ? false
  //         : true,
  //     onTap: () {
  //       if (widget.listuser == null ||
  //           (state.activePassInfoList != null &&
  //               ((state.activePassInfoList?.name ?? '')
  //                   .isEmpty))) {
  //         //   articleTypeDialog(state);
  //         // leodepartmentsDialog(state, 0);
  //         passnumberTypeDialog(state);
  //       }
  //     },
  //   );
  // }
  passNumberTypeDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateactivePassInfoList:
                state.passnumbelistresponse?.activePassInfoList ?? [],
            // leftimagename: AppIcon.addicon,
            //onLeftButtonTap: () {
            // Navigator.pop(context);
            // showDialog(
            //     context: context,
            //     builder: (BuildContext dialogContext) {
            //       return const AddEmployeeDepartment(
            //         title: Constants.addarticletype,
            //       );
            //     });
            // },
            onTap: (Organisation organisation) {
              // widget.model?.passInfo = PassInfo(id: organisation.id, passNo: organisation.name);
              daypassnoTextController.text = organisation.name ?? '';
              createPassMgmtCubit.getPassListResponseData(organisation);
            },
          );
        });
  }

  // Widget hostaddButtonwidgetLoading(CreatePassMgmtState state) {
  //   return TextfieldAddButton(
  //     title: state.getuserResponse != null &&
  //             (state.getuserResponse?.name ?? '').isNotEmpty
  //         ? ((state.getuserResponse?.name ?? '') +
  //             '(' +
  //             (state.getuserResponse?.email ?? '') +
  //             ')')
  //         : '',
  //     height: 70,
  //     isDisableColor: widget.listuser == null ||
  //             (state.getuserResponse != null &&
  //                 ((state.getuserResponse?.name ?? '').isEmpty))
  //         ? false
  //         : true,
  //     onTap: () {
  //       if (widget.listuser == null ||
  //           (state.getuserResponse != null &&
  //               ((state.getuserResponse?.name ?? '').isEmpty))) {
  //         //dbOfficialDialog(state);
  //       }
  //     },
  //   );
  // }

  Widget locationWidgetDisplay(CreatePassMgmtState state) {
    return GestureDetector(
      onTap: () {
        if ((widget.model?.status == 0 || widget.model?.status == null)) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              // log(state.getLocationsResponse);
              return CustomExpansionListTexts(
                locationList: state.getLocationsResponse,
                //GetLocations(),
                onTap: (Organisation location) async {
                  await createPassMgmtCubit.getSerialnumberDetails(
                    location,
                    widget.passId,
                  );
                  await BlocProvider.of<CreatePassMgmtCubit>(context)
                      .getPassTypes(
                          locationId: location.id!, passId: widget.passId);

                  await createPassMgmtCubit.getPassNumber(
                      widget.passId, location.id!);
                  createPassMgmtCubit.getlocationsResponseData(location);
                  daypassnoTextController.text = '';
                  hostEmployeeIdTextController.text = '';
                  dbsponsorTextController.text = '';
                  nameTextController.text = '';
                },
              );
            },
          );
        }
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFCACACA),
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: (state.location?.name ?? '').isEmpty
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              AppColors.normalTextBackground),
                        ),
                        onPressed: () {},
                        child: Text(
                          state.location?.name ?? '',
                          style: Styles.textStyleBlack14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future submitForm(
      bool isSubmit, int isFoundId, CreatePassMgmtState state) async {
    if (widget.passId == ConstantsIntValue.passIdDayPass) {
      if (daypassnoTextController.text.isEmptyOrNull) {
        Validator().showToast(
          context,
          "Please enter Day Pass Number",
        );
        return;
      }
    }
    // if (widget.passId == ConstantsIntValue.passIdSez) {
    //   if (sezpassinfoTextController.text.isEmptyOrNull) {
    //     Validator().showToast(
    //       context,
    //       "Please enter Sez Pass Info",
    //     );
    //     return;
    //   }
    // }

    if (widget.passId == ConstantsIntValue.passIdVisitor ||
        widget.passId == ConstantsIntValue.passIdVendor) {
      if (daypassnoTextController.text.isEmptyOrNull) {
        Validator().showToast(
          context,
          "Please enter Visitor Pass No",
        );
        return;
      }
    }

    log('-widget.model?.passInfo--${widget.model?.passInfo}-');

    PassInfo? selectedPassInfo;
    if (state.selectedPassInfo != null) {
      selectedPassInfo = PassInfo(
        id: state.selectedPassInfo?.id,
        passNo: state.selectedPassInfo?.name,
      );
    }
    PassInfo passInfo =
        selectedPassInfo ?? widget.model?.passInfo ?? PassInfo();

    passInfo.passType = state.model.passType ?? widget.passId;

    // For Day Pass and Sez Pass, Pass No is text field.
    if (widget.passId == ConstantsIntValue.passIdSez) {
      passInfo.passNo = sezpassinfoTextController.text;
    } else {
      passInfo.passNo = daypassnoTextController.text;
    }
    passInfo.mifareNo = mtpApplicationNoTextController.text;

    int passValidFromDate = widget.model?.startTime != null
        ? int.tryParse(widget.model!.startTime!)!
        : (DateTime.now().millisecondsSinceEpoch ~/ 1000);

    int? passReturnedOn;

    log('state.model.updatedStatus--${state.model.updatedStatus}--');
    if (state.model.updatedStatus !=
        ConstantsIntValue.passStatusLostDeActivated) {
      passReturnedOn = (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    }
    // int passValidUntilDate =
    //     (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 12 * 3600; //Add
    //
    // DateTime desiredDate = DateTime(2022, 5, 31);
    // int passValidUntilDatePermanent = (desiredDate.millisecondsSinceEpoch ~/ 1000);

    // int passValidUntilDatePermanent =
    //     ((DateTime.now().millisecondsSinceEpoch ~/ 1000) +
    //         24 * 3600 * 1227); //Adding 1227 days

    int inputDate = widget.model?.inputDate != null
        ? int.tryParse(widget.model!.inputDate!)!
        : (DateTime.now().millisecondsSinceEpoch ~/ 1000);

    // String dateString = passValidUntilTextController.text;

    //  DateTime dateTime = DateTime.parse(
    //      "${dateString.split("-")[0]}-${dateString.split("-")[1]}-${dateString.split("-")[2]}");
    // int passValidUntilDate = dateTime.millisecondsSinceEpoch ~/ 1000;

    // int statusValue = 0;
    //
    // if (statusTextController.text.toLowerCase() == "Created") {
    //   statusValue = 0;
    // } else if (statusTextController.text.toLowerCase() == "Handed over") {
    //   statusValue = 1;
    // } else if (statusTextController.text.toLowerCase() == "Returned") {
    //   statusValue = 2;
    // } else if (statusTextController.text.toLowerCase() == "Non Returned") {
    //   statusValue = 3;
    // } else if (statusTextController.text.toLowerCase() == "Lost/De-Activated") {
    //   statusValue = 4;
    // } else if (statusTextController.text.toLowerCase() ==
    //     "Damaged/De-Activated") {
    //   statusValue = 5;
    // } else if (statusTextController.text.toLowerCase() == "Defaced") {
    //   statusValue = 6;
    // } else if (statusTextController.text.toLowerCase() == "Cancelled") {
    //   statusValue = 7;
    // } else if (statusTextController.text.toLowerCase() == "Returned/Damaged") {
    //   statusValue = 8;
    // } else if (statusTextController.text.toLowerCase() == "Returned/Defaced") {
    //   statusValue = 9;
    // } else {
    //   statusValue = 0;
    // }

    // int updateStatusValue = 0;
    // if (updateStatusTextController.text
    //     .equalsIgnoreCase(ConstantsIntValue.passStatusReturned)) {
    //   updateStatusValue = 2;
    // } else if (updateStatusTextController.text
    //     .equalsIgnoreCase(ConstantsIntValue.passStatusLostDeActivated)) {
    //   updateStatusValue = 4;
    // } else if (updateStatusTextController.text
    //     .equalsIgnoreCase(ConstantsIntValue.passStatusDamagedDeActivated)) {
    //   updateStatusValue = 5;
    // } else if (updateStatusTextController.text
    //     .equalsIgnoreCase(ConstantsIntValue.passStatusDefaced)) {
    //   updateStatusValue = 6;
    // } else if (updateStatusTextController.text
    //     .equalsIgnoreCase(ConstantsIntValue.passStatusCancelled)) {
    //   updateStatusValue = 7;
    // } else if (updateStatusTextController.text
    //     .equalsIgnoreCase(ConstantsIntValue.passStatusReturnedDamaged)) {
    //   updateStatusValue = 8;
    // } else if (updateStatusTextController.text
    //     .equalsIgnoreCase(ConstantsIntValue.passStatusReturnedDefaced)) {
    //   updateStatusValue = 9;
    // } else {
    //   updateStatusValue = 1;
    // }
    // return;

    log('-state.selectedEntities?.length--${state.selectedEntities?.length}---');
    List<Organisation>? entities = state.selectedEntities;
    // if ((state.selectedEntities?.length ?? 0) > 0) {
    //   for (int i = 0; i < state.selectedEntities!.length; i++) {
    //     Organisation entity = state.selectedEntities![i];
    //     // Organisation addentiity = Organisation(id: entity.id ?? 1);
    //     entities.add(entity);
    //   }
    // }
    Organisation? location = state.location;

    // Organisation? companyType = widget.model?.companyType;
    Organisation? locationRegion = state.locationRegion;

    // Organisation? dept2 = widget.model?.department;
    // PassInfo info;
    //
    // log('widget.passId------------${widget.passId}');
    // passInfo.passNo = passInfo.passNo;
    // if (widget.passId == ConstantsIntValue.passIdSez) {
    //   info = passInfo;
    // } else {
    //
    //   log('---else---------passNo}');
    //
    //   info = PassInfo(
    //       passType: passInfo.passType,
    //       id: (state.vendorPassInfo?.id == 0)
    //           ? 1
    //           : state.vendorPassInfo?.id ??
    //               ((widget.passId == ConstantsIntValue.passIdSez) ? 9151 : 3),
    //       //9151 //int.parse(sezpassinfoTextController.text ?? '1')
    //       passNo: sezpassinfoTextController.text,
    //       mifareNo: mtpApplicationNoTextController.text);
    // }

    // createpassmgmtCubit.gethostanalystsResponseData(host1);
    // createpassmgmtCubit.getdbsponsoranalystsResponseData(host1);
    // createpassmgmtCubit.gethostUsersResponseData(host1);

    User? host2 = state.hostResponse;
    //userName: state.hostResponse?.userName ?? '');

    User? dbSponsor = User(
      userId: state.dbsponsorResponse?.userId,
      firstName: state.dbsponsorResponse?.name,
      email: state.dbsponsorResponse?.email,
      employeeId: state.dbsponsorResponse?.employeeId,
    );


    // Organisation? companyType = widget.model?.companyType;
    // log('--state.locationSelectedlist?.id--${state.location?.id}----');
    Organisation? companyType =
        state.selectedCompanyType ?? widget.model?.companyType;

    Organisation? department =
        state.selectedDepartment ?? widget.model?.department;
    Organisation? vendorPass =
        state.vendorPasselementReason ?? widget.model?.vendorPassReason;
    Organisation? dayPass =
        state.dayPasselementReason ?? widget.model?.dayPassReason;

    int idValidationType = 0;
    if (photofidentityextController.text == "Aadhaar Card") {
      idValidationType = 0;
    } else if (photofidentityextController.text == "Pan Card") {
      idValidationType = 1;
    } else if (photofidentityextController.text == "Passport") {
      idValidationType = 2;
    } else if (photofidentityextController.text == "Driving Licence") {
      idValidationType = 3;
    } else if (photofidentityextController.text == "Voter Card") {
      idValidationType = 4;
    }
    int category = 1;
    if (passCategoryTextController.text == "Permanent") {
      category = 1;
    } else if (passCategoryTextController.text == "Temporary") {
      category = 2;
    }

    List<ImageContent>? evidenceDocuments =
        !getFiles.isEmptyOrNull ? getFiles : getAttachments;

    List<ImageContent>? photoImages =
        !photogetFiles.isEmptyOrNull ? photogetFiles : photogetAttachments;
    // return;
    //List<ImageContent>? photoImages = photogetFiles;
    User? entrySecurity = widget.model?.entrySecurity ??
        User(userId: state.getUserDetailsResponse?.userId ?? 1);

    User? handoverSecurity =
        widget.model?.status == ConstantsIntValue.passStatusHandedOver
            ? widget.model?.handoverSecurity ??
            User(userId: state.getUserDetailsResponse?.userId ?? 1)
            : null;
    if (statusTextController.text.isEmptyOrNull) {
      Validator().showToast(
        context,
        "Please enter Status",
      );
      return;
    }
    if (statusTextController.text.isEmptyOrNull) {
      Validator().showToast(
        context,
        "Please enter Status",
      );
      return;
    }

    if (serialnumber == null) {
      Validator().showToast(
        context,
        "Please enter Sl No",
      );
      return;
    }

    log('-passValidUntilTextController.text--${passValidUntilTextController.text}--');
    // String endTime = Utils.dateToTimestampConversion(
    //     passValidUntilTextController.text, Constants.dateFormat).toString();
    String endTime = "";
    if (!passValidUntilTextController.text.isEmptyOrNull) {
      endTime = Utils().formatTime(passValidUntilTextController.text);
    }
    //Organisation? dayPass = widget.model?.dayPassReason;
    PassManagement? passMgmtBody;
    log('--pass info id--${passInfo.id}---');
    if (widget.model != null) {
      log('--passinfo type--${passInfo.passType}--------');
      log('111${widget.model?.employee?.email}');
      passMgmtBody = PassManagement(
        id: isFoundId,
        updatedStatus: state.model.updatedStatus,
        inputDate: inputDate.toString(),
        slNo: serialnumber ?? '',
        location: location,
        status: widget.model?.status ?? 0,
        locationRegion: widget.model?.locationRegion,
        companyName: companyNameTextController.text,
          employeeName: widget.passId == ConstantsIntValue.passIdDayPass || widget.passId == ConstantsIntValue.passIdSez
              ? (state.nameResponse?.name != null && state.nameResponse?.email != null
              ? '${state.nameResponse?.name}'
              : nameTextController.text)
              : vendorVisitorNameTextController.text,
        employeeId: widget.passId == ConstantsIntValue.passIdDayPass || widget.passId == ConstantsIntValue.passIdSez
            ? ((widget.passId == ConstantsIntValue.passIdDayPass && companyType?.name != 'CWR T2') || widget.passId == ConstantsIntValue.passIdSez
            ? state.nameResponse?.employeeId
            : employeeIdTextController.text)
            : null,
        employee: (widget.passId == ConstantsIntValue.passIdDayPass && companyType?.name != 'CWR T2') || widget.passId == ConstantsIntValue.passIdSez
            ? User(
                userId: state.nameResponse?.id,
                firstName: state.nameResponse?.name,
                email: widget.model?.employee?.email,
                employeeId: state.nameResponse?.employeeId,
              )
            : null,
        passType: passInfo.passType,
        passInfo: passInfo,
        passNo: passInfo.passNo,
        escortedBy: escortedByTextController.text,
        escortedEmployeeId: escortedEmployeeIdByTextController.text,
        hostEmployeeId:  dbSponsor.employeeId,
        mifareNo: mtpApplicationNoTextController.text,
        passIssuedOn: widget.passId == ConstantsIntValue.passIdSez ? passValidFromDate.toString():'',
        endTime: endTime,
        // endTime: widget.passId == ConstantsIntValue.passIdSez && widget.model?.category == 0
        //     ? passValidUntilDatePermanent.toString()
        //     : passValidUntilDate.toString(),
        startTime: passValidFromDate.toString(),
        returnedTime:
            widget.model?.status == ConstantsIntValue.passStatusHandedOver
                ? passReturnedOn.toString()
                : null,
        hostName: dbsponsorTextController.text.isEmpty
            ? '${state.hostResponse?.userInfo} ${state.hostResponse?.email}' ??
                ''
            : '${state.dbsponsorResponse?.userInfo} (${state.dbsponsorResponse?.email})' ??
                '',
        companyType: companyType,
        evidenceDocuments: evidenceDocuments,
        entities: entities,
        department: department,
        host:dbSponsor,
        email: widget.passId == ConstantsIntValue.passIdSez ? emailTextController.text : null,
        contactNo: contactnoTextController.text,
        visitingDepartment: department,
        visitorName: widget.passId == ConstantsIntValue.passIdVisitor ? vendorVisitorNameTextController.text:null,
        visitorImage: photoImages,
        visitorComingFrom: visitorcomingfromTextController.text,
        visitingPurpose: purposeofvisitTextController.text,
        escortedByHost: widget.passId == ConstantsIntValue.passIdVendor || widget.passId == ConstantsIntValue.passIdVisitor ? state.escortedbyhost == 1 ? true : false : null,
        exceptionalApproval: state.exceptionalApproval == 1 ? true : false,
        idValidationType: idValidationType,
        //mifareNo: mtpapplicationnoTextController.text ?? '',
        category: !passCategoryTextController.text.isEmptyOrNull ? category : null,
        dayPassReason: dayPass,
        vendorPassReason: vendorPass,
        entrySecurity: entrySecurity,
        handoverSecurity: handoverSecurity,
        handOverSecurityName:
            '${handoverSecurity?.firstName ?? ''} ${handoverSecurity?.lastName ?? ''}',
        entrySecurityName:
            '${entrySecurity.firstName ?? ''} ${entrySecurity.lastName ?? ''}',
      );
    } else {
      log('--passinfo type--333----${passInfo.passType}--------');
      log('222 ${state.nameResponse?.email}');
      passMgmtBody = PassManagement(
          // id: isFoundId ?? 0,
          inputDate: inputDate.toString(),
          slNo: serialnumber ?? '',
          location: location,
          status: widget.model?.status ?? 0,
          locationRegion: locationRegion,
          companyName: companyNameTextController.text,
          employeeName: widget.passId == ConstantsIntValue.passIdDayPass || widget.passId == ConstantsIntValue.passIdSez
              ? (state.nameResponse?.name != null && state.nameResponse?.email != null
              ? '${state.nameResponse?.name}'
              : nameTextController.text)
              : vendorVisitorNameTextController.text,
          employeeId: widget.passId == ConstantsIntValue.passIdDayPass || widget.passId == ConstantsIntValue.passIdSez
              ? ( (widget.passId == ConstantsIntValue.passIdDayPass && companyType?.name != 'CWR T2') || widget.passId == ConstantsIntValue.passIdSez
              ? state.nameResponse?.employeeId
              : employeeIdTextController.text)
              : null,
          employee: (widget.passId == ConstantsIntValue.passIdDayPass && companyType?.name != 'CWR T2') || widget.passId == ConstantsIntValue.passIdSez
              ? User(
            userId: state.nameResponse?.id,
            firstName: state.nameResponse?.name,
            email: state.nameResponse?.email,
            employeeId: state.nameResponse?.employeeId,
          )
              : null,
          passType: passInfo.passType,
          //0,
          passNo: passInfo.passNo,
          escortedBy: escortedByTextController.text,
          escortedEmployeeId: escortedEmployeeIdByTextController.text,
          mifareNo: mtpApplicationNoTextController.text,
          hostEmployeeId: dbsponsorTextController.text.isEmpty  ? host2?.employeeId : dbSponsor?.employeeId,
          passIssuedOn: widget.passId == ConstantsIntValue.passIdSez ? passValidFromDate.toString():'',
          endTime: endTime,
          startTime: passValidFromDate.toString(),
          returnedTime:
              widget.model?.status == 1 ? passReturnedOn.toString() : null,
          hostName: dbsponsorTextController.text.isEmpty
              ? '${state.hostResponse?.userInfo} (${state.hostResponse?.email})' ??
                  ''
              : '${state.dbsponsorResponse?.userInfo} (${state.dbsponsorResponse?.email})' ??
                  '',
          companyType: companyType,
          evidenceDocuments: evidenceDocuments,
          entities: entities,
          department: department,
          // passInfo: info,
          passInfo: passInfo,
          host: dbsponsorTextController.text.isEmpty ? host2 : dbSponsor,
          contactNo: contactnoTextController.text,
          visitingDepartment: department,
          visitorName: widget.passId == ConstantsIntValue.passIdVisitor ?vendorVisitorNameTextController.text:null,
          visitorImage: photoImages,
          visitorComingFrom: visitorcomingfromTextController.text,
          visitingPurpose: purposeofvisitTextController.text,
          escortedByHost: widget.passId == ConstantsIntValue.passIdVendor || widget.passId == ConstantsIntValue.passIdVisitor ? state.escortedbyhost == 1 ? true : false : null,
          exceptionalApproval: state.exceptionalApproval == 1 ? true : false,
          idValidationType: idValidationType,
          // mifareNo: mtpapplicationnoTextController.text ?? '',
          category: !passCategoryTextController.text.isEmptyOrNull ? category : null,
          dayPassReason: dayPass,
          vendorPassReason: vendorPass,
          email: widget.passId == ConstantsIntValue.passIdSez ? emailTextController.text : null,
          entrySecurity: entrySecurity,
          handoverSecurity: handoverSecurity);
    }
    // showLoadingDialog(context);
    var username = await SharedPrefs.getUsername();
    CreatePassMgmtBody body = CreatePassMgmtBody(passManagement: passMgmtBody);

    createPassMgmtCubit.createPass(
      bodyRequest: body,
      isSubmit: isSubmit,
      username: username,
      title: widget.model != null ? widget.title ?? '' : widget.title ?? '',
    );

    // String userid = await SharedPrefs.getUserId();
    //
    // await dayPassListCubit.getList(
    //     pageNumber.toString(), '20', userid, '${widget.passId}', context);
  }

  passValidations(BuildContext context, CreatePassMgmtState state) {
    if (statusTextController.text.isEmpty &&
        state.getUserDetailsResponse == null &&
        state.location == null &&
        dateofcreationTextController.text.isEmpty &&
        serialnumber == null &&
        state.selectedEntities == null &&
        passValidFromTextController.text.isEmpty &&
        passValidUntilTextController.text.isEmpty &&
        escortedEmployeeIdByTextController.text.isEmpty &&
        mtpApplicationNoTextController.text.isEmpty &&
        escortedByTextController.text.isEmpty &&
        passTypeTextController.text.isEmpty &&
        state.selectedDepartment == null &&
        state.selectedCompanyType == null &&
        state.dayPasselementReason == null) {
      Validator().showToast(
        context,
        "Please fill all required fields",
      );
    } else if (state.getUserDetailsResponse != null &&
        (state.getUserDetailsResponse?.firstName ?? '').isEmpty &&
        (state.getUserDetailsResponse?.lastName ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter creator name",
      );
    } else if (state.location != null && (state.location?.name ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter location",
      );
    } else if (dateofcreationTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter creator date",
      );
    } else if (serialnumber != null && (serialnumber ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter serial number",
      );
    } else if (state.selectedEntities == null) {
      Validator().showToast(
        context,
        "Please enter entity",
      );
    } else if ((widget.passId == ConstantsIntValue.passIdDayPass ||
            widget.passId == ConstantsIntValue.passIdSez) &&
        state.selectedCompanyType?.name == null) {
      Validator().showToast(
        context,
        "Please enter company type",
      );
    } else if ((widget.passId == ConstantsIntValue.passIdDayPass ||
            widget.passId == ConstantsIntValue.passIdSez) &&
        companyNameTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter company name",
      );
    }
    // else if ((widget.passId == ConstantsIntValue.passIdDayPass &&
    //     (state.selectedCompanyType?.name ?? '').toLowerCase() == 'fte' &&
    //     (state.nameResponse?.name ?? '').isEmpty)) {
    //   Validator().showToast(
    //     context,
    //     "Please enter name",
    //   );
    // } else if ((widget.passId == ConstantsIntValue.passIdDayPass &&
    //         (state.selectedCompanyType?.name ?? '').toLowerCase() != 'fte') &&
    //     nameTextController.text.isEmpty) {
    //   Validator().showToast(
    //     context,
    //     "Please enter name",
    //   );
    // }
    else if ((widget.passId == ConstantsIntValue.passIdVisitor ||
            widget.passId == ConstantsIntValue.passIdVendor) &&
        vendorVisitorNameTextController.text.isEmpty) {
      Validator().showToast(
        context,
        widget.passId == ConstantsIntValue.passIdVendor
            ? "Please enter vendor name"
            : "Please enter visitor name",
      );
    } else if ((widget.passId == ConstantsIntValue.passIdVisitor ||
            widget.passId == ConstantsIntValue.passIdVendor) &&
        contactnoTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter contact no",
      );
    } else if ((widget.passId == ConstantsIntValue.passIdVisitor ||
                widget.passId == ConstantsIntValue.passIdVendor) &&
            contactnoTextController.text.length < 10 ||
        contactnoTextController.text.length > 17) {
      Validator().showToast(
        context,
        "Please enter valid contact no",
      );
      return;
    } else if (widget.passId == ConstantsIntValue.passIdVisitor &&
        visitorcomingfromTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter visit coming from",
      );
    } else if (widget.passId == ConstantsIntValue.passIdVisitor &&
        photofidentityextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter photo identify type",
      );
    } else if (widget.passId == ConstantsIntValue.passIdVisitor &&
        purposeofvisitTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter purpose of visit",
      );
    }
    // else if (widget.passId == ConstantsIntValue.passIdDayPass &&
    //     (state.selectedCompanyType?.name ?? '').toLowerCase() != 'exceptions' &&
    //     state.nameResponse?.employeeId ==null) {
    //   Validator().showToast(
    //     context,
    //     "Please enter employee id",
    //   );
    // }
    // else if (widget.passId == ConstantsIntValue.passIdSez &&
    //     state.nameResponse?.employeeId ==null &&
    //     (state.selectedCompanyType?.name ?? '').toLowerCase() == 'fte') {
    //   Validator().showToast(
    //     context,
    //     "Please enter employee id",
    //   );
    // }
    // else if ((widget.passId == ConstantsIntValue.passIdDayPass &&
    //     (state.selectedCompanyType?.name ?? '').toLowerCase() == 'cwr t1' &&
    //     emailTextController.text.isEmpty)) {
    //   Validator().showToast(
    //     context,
    //     "Please enter email",
    //   );
    // }
    // if ((widget.passId == ConstantsIntValue.passIdSez &&
    //     emailTextController.text.isEmpty &&
    //     (state.selectedCompanyType?.name ?? '').toLowerCase() == 'fte')) {
    //   Validator().showToast(
    //     context,
    //     "Please enter email",
    //   );
    // }
    else if ((widget.passId == ConstantsIntValue.passIdSez &&
        !emailTextController.text.isEmptyOrNull &&
        !Validator.isValidEmail(emailTextController.text))) {
      log('-widget.model?.email--${widget.model?.email}-222--${emailTextController.text}---');

      Validator().showToast(
        context,
        "Please enter valid email",
      );
    } else if ((widget.passId == ConstantsIntValue.passIdSez &&
        sezpassinfoTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter SEZ Pass",
      );
    } else if ((widget.passId == ConstantsIntValue.passIdSez &&
        mtpApplicationNoTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter MTP Application No",
      );
    } else if ((widget.passId == ConstantsIntValue.passIdDayPass ||
            widget.passId == ConstantsIntValue.passIdVisitor ||
            widget.passId == ConstantsIntValue.passIdVendor) &&
        ((state.selectedCompanyType?.name ?? '').toLowerCase() ==
                'exceptions' &&
            hostEmployeeIdTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter host",
      );
    } else if ((widget.passId == ConstantsIntValue.passIdDayPass ||
            widget.passId == ConstantsIntValue.passIdVisitor ||
            widget.passId == ConstantsIntValue.passIdVendor) &&
        ((state.selectedCompanyType?.name ?? '').toLowerCase() ==
                'exceptions' &&
            hostEmployeeIdTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter host employee id",
      );
    } else if ((widget.passId == ConstantsIntValue.passIdVisitor ||
            widget.passId == ConstantsIntValue.passIdVendor ||
            widget.passId == ConstantsIntValue.passIdSez) &&
        (state.hostResponse?.name ?? '').isEmpty &&
        state.companyTypes == 'Exception') {
      Validator().showToast(
        context,
        "Please enter host",
      );
    }
    // else if ((widget.passId == ConstantsIntValue.passIdVisitor ||
    //         widget.passId == ConstantsIntValue.passIdVendor ||
    //         widget.passId == ConstantsIntValue.passIdSez) &&
    //     hostemployeeidTextController.text.isEmpty) {
    //   Validator().showToast(
    //     context,
    //     "Please enter host employeed id",
    //   );
    // }
    else if ((widget.passId == ConstantsIntValue.passIdDayPass &&
        (state.selectedDepartment == null ||
            (state.selectedDepartment?.name ?? '').isEmpty))) {
      Validator().showToast(
        context,
        "Please enter department",
      );
    } else if (((widget.passId == ConstantsIntValue.passIdVisitor ||
            widget.passId == ConstantsIntValue.passIdVendor) &&
        (state.selectedDepartment == null ||
            (state.selectedDepartment?.name ?? '').isEmpty))) {
      Validator().showToast(
        context,
        "Please enter visit department",
      );
    } else if ((widget.passId == ConstantsIntValue.passIdVisitor ||
            widget.passId == ConstantsIntValue.passIdVendor) &&
        passTypeTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter pass type",
      );
    } else if (widget.passId == ConstantsIntValue.passIdDayPass &&
        (state.dayPasselementReason == null ||
            (state.dayPasselementReason?.name ?? '').isEmpty)) {
      Validator().showToast(
        context,
        "Please enter reason for day pass",
      );
    } else if (widget.passId == ConstantsIntValue.passIdVendor &&
        (state.vendorPasselementReason == null ||
            (state.vendorPasselementReason?.name ?? '').isEmpty)) {
      Validator().showToast(
        context,
        "Please enter reason for vendor pass",
      );
    } else if (widget.passId == ConstantsIntValue.passIdDayPass &&
        daypassnoTextController.text.isEmptyOrNull) {
      Validator().showToast(
        context,
        "Please enter Day Pass Number",
      );
    } else if (widget.passId == ConstantsIntValue.passIdVisitor &&
        daypassnoTextController.text.isEmptyOrNull) {
      Validator().showToast(
        context,
        "Please enter Visitor pass no",
      );
    } else if (widget.passId == ConstantsIntValue.passIdVendor &&
        daypassnoTextController.text.isEmptyOrNull) {
      Validator().showToast(
        context,
        "Please enter Vendor pass no",
      );
    }
    // else if ((widget.passId == ConstantsIntValue.passIdVisitor ||
    //         widget.passId == ConstantsIntValue.passIdVendor) &&
    //     (state.selectedPassInfo == null ||
    //         (state.selectedPassInfo?.name ?? '').isEmpty)) {
    //   Validator().showToast(
    //     context,
    //     widget.passId == ConstantsIntValue.passIdVendor
    //         ? "Please enter vendor pass no"
    //         : "Please enter visitor pass no",
    //   );
    // }
    else if (widget.passId == ConstantsIntValue.passIdSez &&
        passCategoryTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter pass category",
      );
    } else if (passValidFromTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter pass valid from",
      );
    } else if (passValidUntilTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter pass valid until",
      );
    } else if ((widget.passId == ConstantsIntValue.passIdVisitor ||
            widget.passId == ConstantsIntValue.passIdVendor) &&
        ((state.escortedbyhost ?? 0) == 0) &&
        (escortedByTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter Escorted By",
      );
    } else if ((widget.passId == ConstantsIntValue.passIdVisitor ||
            widget.passId == ConstantsIntValue.passIdVendor) &&
        ((state.escortedbyhost ?? 0) == 0) &&
        (escortedEmployeeIdByTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter Escorted By Employee Id",
      );
    } else {
      submitForm(true, widget.model?.id ?? 0, globalState);
    }
  }

  Widget datecreateWidgetdisplay() {
    return FlutterInputField(
      controller: dateofcreationTextController,
      textFormKey: Keys.dateofcreationTextController,
      hintText: '',
      isEnable: false,
      isDisableColor: true,
      onChange: (String username) {
        //this.username = username;
        //setState(() {});
      },
      validateTextField: (String? user) {},
    );
  }

  // Widget attachmentListviews(
  //   List<ImageContent>? attachmentListviews,
  //   List<ImageContent>? attachmentListviews1,
  // ) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         color: const Color(0xFFCACACA),
  //         style: BorderStyle.solid,
  //         width: 1.0,
  //       ),
  //       color: Colors.transparent,
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //
  //     child: ListView.builder(
  //         shrinkWrap: true,
  //         physics: const NeverScrollableScrollPhysics(),
  //         itemCount: (attachmentListviews1?.length ?? 0) >
  //                 (attachmentListviews?.length ?? 0)
  //             ? attachmentListviews?.length
  //             : attachmentListviews?.length ?? 0,
  //         itemBuilder: (BuildContext context, int index) {
  //           ImageContent? imagedata;
  //           ImageContent? imagedata1;
  //           if (widget.model != null) {
  //             imagedata1 = attachmentListviews1?[index];
  //           } else {
  //             imagedata = attachmentListviews?[index];
  //           }
  //           log('--attachmentListviews1?.length--${attachmentListviews1?.length}');
  //           log('--attachmentListviews?.length--${attachmentListviews?.length}');
  //           return Column(
  //             children: <Widget>[
  //               ListTile(
  //                 trailing: widget.model != null
  //                     ? SvgPicture.asset(AppIcon.download,
  //                         color: AppColors.boldgreyBackground)
  //                     : const SizedBox(
  //                         height: 0,
  //                         width: 0,
  //                       ),
  //                 onTap: () {
  //                   DownloadImage().saveImage(
  //                       context, imagedata1?.id ?? 0, imagedata1?.title ?? '');
  //                 },
  //                 title: widget.model != null
  //                     ? Text(imagedata1?.title ?? '')
  //                     : Text(imagedata?.title ?? ''),
  //               ),
  //
  //               const Divider(
  //                 color: Color(0xFFCACACA),
  //                 thickness: 1,
  //               ), //                           <-- Divider
  //             ],
  //           );
  //         }),
  //   );
  // }

  Widget textFieldWidgetLoad({
    required TextEditingController controller,
    required int index,
    required CreatePassMgmtState state,
    bool isDbUser = false,
  }) {
    bool isEditable =
        (widget.model?.status == null || widget.model?.status == 0);

    return isDbUser
        ? Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 105,
                child: FlutterInputField(
                  //lineHeight: textController == employeeidTextController ? 1 : 1,
                  onTap: () {},
                  controller: controller,
                  textFormKey: Keys.colorTextController,
                  textCapitalization:
                      controller == emailTextController ? false : true,
                  textInputType: controller == contactnoTextController ||
                          controller == employeeIdTextController ||
                          controller == escortedEmployeeIdByTextController ||
                          controller == hostEmployeeIdTextController ||
                          controller == dbsponsorTextController
                      ? TextInputType.number
                      : TextInputType.text,
                  characterLimit: controller == contactnoTextController
                      ? Constants.characterLimitContactNo
                      : Constants.characterLimitIdTextFormField,
                  isEnable: (controller == companyNameTextController &&
                              widget.model?.status == 0
                          ? isFTECompanyNameEditable
                          : isEditable) ||
                      isEditable,
                  isDisableColor: isEditable,
                  hintText: '',
                  onChange: (String value) {
                    //this.username = username;
                    controller.text = value;
                  },
                  validateTextField: (String? user) {},
                  // )
                  //)
                ),
              ),
              const Text('@db.com')
            ],
          )
        : FlutterInputField(
            //lineHeight: textController == employeeidTextController ? 1 : 1,
            onTap: () {},
            controller: controller,
            textFormKey: Keys.colorTextController,
            textCapitalization:
                controller == emailTextController ? false : true,
            textInputType: controller == contactnoTextController ||
                    controller == employeeIdTextController ||
                    controller == escortedEmployeeIdByTextController ||
                    controller == hostEmployeeIdTextController ||
                    controller == dbsponsorTextController
                ? TextInputType.number
                : TextInputType.text,
            characterLimit: controller == contactnoTextController
                ? Constants.characterLimitContactNo
                : Constants.characterLimitIdTextFormField,
            isEnable: (controller == companyNameTextController &&
                        widget.model?.status == 0
                    ? isFTECompanyNameEditable
                    : isEditable) ||
                isEditable,
            isDisableColor: isEditable,
            hintText: '',
            onChange: (String value) {
              //this.username = username;
              controller.text = value;
            },
            validateTextField: (String? user) {},
            // )
            //)
          );
  }

  Widget textfieldWidgetLoad1(TextEditingController textController, int index,
      CreatePassMgmtState state) {
    return FlutterInputField(
      //lineHeight: textController == employeeidTextController ? 1 : 1,
      onTap: () {},
      controller: textController,
      textFormKey: Keys.colorTextController,
      textInputType: textController == contactnoTextController ||
              textController == sezpassinfoTextController ||
              textController == hostEmployeeIdTextController
          ? TextInputType.number
          : TextInputType.text,
      isEnable: widget.model?.status == null ||
              widget.model?.status == 0 &&
                  (textController != hostEmployeeIdTextController)
          ? true
          : false,
      isDisableColor: widget.model?.status == null || widget.model?.status == 0
          ? false
          : true,
      hintText: 'no empty',
      onChange: (String username) {
        //this.username = username;
      },
      validateTextField: (String? user) {},
      // )
      //)
    );
  }
}

class CreatePassMngArguments {
  final int passType;
  final String title;
  final bool isRegistry;
  final PassManagementModel? model;

  CreatePassMngArguments(
      this.passType, this.title, this.isRegistry, this.model);
}
