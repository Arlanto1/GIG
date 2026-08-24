import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/csr_event/csr_event_details/cubits/csr_event_details_cubit.dart';
import 'package:db_atom/src/features/csr_event/models/csr_event_model.dart';

class CSRGeneralInfoView extends StatefulWidget {
  final CSREventGiModel? model;
  final ExtraProperties? extraProperties;
  final bool isCSREvent;
  final bool isSportEvent;

  const CSRGeneralInfoView({
    this.model,
    super.key,
    this.extraProperties,
    required this.isCSREvent,
    required this.isSportEvent,
  });

  @override
  State<CSRGeneralInfoView> createState() => _CSRGeneralInfoViewState();
}

class _CSRGeneralInfoViewState extends State<CSRGeneralInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController eventStartDateController = TextEditingController();
  TextEditingController eventEndDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  bool disableForm = false;
  TextEditingController sensitiveInfoController = TextEditingController();
  TextEditingController mediaExposureController = TextEditingController();

  final FocusNode lSM1ContactNoFocusNode = FocusNode();
  final FocusNode lSM2ContactNoFocusNode = FocusNode();
  final FocusNode pocContactNoFocusNode = FocusNode();
  final FocusNode pocEscalationContactNoFocusNode = FocusNode();
  List<ImageContent> uploadFiles = [];
  List<ImageContent> uploadPhotographyFiles = [];
  List<ImageContent> uploadVendorStaffFiles = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CSRGeneralInfoCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<CSRGeneralInfoCubit, CSRGeneralInfoState>(
      listener: (context, state) {
        debugPrint('ID12345');
log('widget.isCSREvent ${widget.isCSREvent}');
        log('state.model.photographyApproved${state.model.photographyApproved}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'General Information',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                csrEventListRoute,
                arguments: {
                  "isCSREvent": widget.isCSREvent
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
      },
      builder: (context, state) {
        if (state.model.status == 30 || !state.model.lock.isEmptyOrNull) {
          disableForm = true;
        }
        if (state.model.status == -1 || !state.model.lock.isEmptyOrNull) {
          disableForm = true;
        }
        if (state.model.status == null) {
          disableForm = false;
        }
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   disableForm = true;
        // }
        state.model.status ??= 0;
        if (state.model.status! > 0) {
          disableForm = true;
        }
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.isCSREvent == true ? Constants.cSREventList : Constants.sportEventList,
            showPopUp: false,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              // FocusScope.of(context).unfocus();
              // BlocProvider.of<CSRGeneralInfoCubit>(context)
              //     .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              // FocusScope.of(context).unfocus();
              // BlocProvider.of<CSRGeneralInfoCubit>(context)
              //     .submitForm(isSaveOnly: false);
            },
            pdfAPIName:
            '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.eventProtectionModuleCode}',
          ),
          backgroundColor: AppColors.newColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(CSRGeneralInfoState state) {
    log('--sdd--${state.model.eventStartDate}-------');
    log('--sdd-eventEndDate-${state.model.eventEndDate}-------');
    if (state.model.eventStartDate != null) {
      eventStartDateController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.eventStartDate ?? '0'),
          Constants.fulldateFormat);
    }
    if (state.model.eventEndDate != null) {
      eventEndDateController.text = Utils.timestampToDateConversion(
          int.tryParse(state.model.eventEndDate ?? '0'),
          Constants.fulldateFormat);
    }
  }

  getBodybuilder(CSRGeneralInfoState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    mediaExposureController.text = state.model.mediaExposure.toString();
    sensitiveInfoController.text = state.model.sensitiveInfoRisk.toString();


    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {

      uploadFiles = [...state.loadAttachments];

      if (state.model.map != null) {
        uploadFiles.add(state.model.map!);
      }
    }
    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      uploadPhotographyFiles = state.loadAttachments;
      uploadPhotographyFiles = state.model.photographyApprovedProof!;
      uploadVendorStaffFiles = state.model.vendorStaffDetails!;
    }


    // return Container(
    //   color: AppColors.white,
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         Container(
    //           height: height * 0.01,
    //           color: AppColors.newColor3,
    //         ),
    //         Container(
    //           decoration: ShapeDecoration(
    //               color: AppColors.newColor3,
    //               shape: const RoundedRectangleBorder(
    //                 borderRadius:
    //                     BorderRadius.vertical(top: Radius.circular(20.0)),
    //               )),
    return Stack(children: [
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

      // color: AppColors.newColor3,
      // color: AppColors.navigationSkyBlueColor,
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              child: Form(
                key: _formKey,
                autovalidateMode: disableForm
                    ? AutovalidateMode.disabled
                    : AutovalidateMode.onUserInteraction,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AbsorbPointer(
                        absorbing: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(children: [

                            // if (!state.model.lock.isEmptyOrNull) ...[
                            //   RecordLockedWidget(text: '${state.model.lock}'),
                            // ],
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                Constants.generalinformation,
                                style: Styles.textStyleRegularNormalWhite18,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Status
                            CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: statusController,
                                items: csrStatusValues,
                                initialValue: '${state.model.status ?? 0}',
                                onTap: () {
                                  if (disableForm) {
                                    BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: csrStatusValues
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            csrStatusValues.firstWhere(
                                                  (label) => label.key == value,
                                              orElse: () =>
                                              const Label(key: '', value: ''),
                                            );
                                        BlocProvider.of<GeneralInfoCubit>(
                                            context)
                                            .updateDropdownValues(
                                            status: int.tryParse(
                                                selectedLabel.value));
                                      },
                                    );
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Location
                            CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            // locationWidgetdislay(state),
                            BaseLocationDropdown().locationWidgetDisplay(
                                isEnabled: false,
                                context: context,
                                locations: state.locations ?? Locations(),
                                selectedLocationName:
                                state.model.location?.name ?? '',
                                onTap: (Organisation? location) {
                                  BlocProvider.of<GeneralInfoCubit>(context)
                                      .updateLocationDropdownValue(
                                      location: location);
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                                state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDate().creationDateDisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Created By
                            CommonWidgets.horizontalTextHandling(
                              // state.labels?.locale.entrySecurity ??
                              //     state.labels?.defaultLocale.entrySecurity ??
                                Constants.createdby,
                                isMandatory: true,
                                '${state.model.createdBy?.firstName ?? ''} ${state.model.createdBy?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Sl No.
                            CommonWidgets.horizontalTextHandling(
                                state.labels?.locale.slNo ??
                                    state.labels?.defaultLocale.slNo ??
                                    Constants.slno,
                                state.model.slNo ?? '',
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),


                            /// Entity
                            CommonWidgets.textDisplay(
                                state.labels?.locale.entity ??
                                    state.labels?.defaultLocale.entity ??
                                    Constants.entity,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseEntitiesSelection().entityDropDownSelection(
                              context: context,
                              selectedValues: state.model.entities ?? [],
                              all: state.listOfEntities ?? [],
                              enabled: false,
                              onTap: (List<Organisation> selectedEntities) {
                                log('--selectedEntities----${selectedEntities.length}');
                                BlocProvider.of<CSRGeneralInfoCubit>(context)
                                    .updateDropdownValues(
                                    entities: selectedEntities);
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              orgName: 'ATOM_ENTITIES',
                              functionToCall: () {
                                // refresh the list
                                BlocProvider.of<CSRGeneralInfoCubit>(context)
                                    .refreshList();
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Event Start Date
                            CommonWidgets.textDisplay(
                                state.labels?.locale.eventStartDate ??
                                    state
                                        .labels?.defaultLocale.eventStartDate ??
                                    Constants.eventStartDate,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: eventStartDateController,
                              isDisabled: true,
                              onlyDate: false,
                              showPastDate: false,
                              notFlagDate: true,
                              // startDate: '1727677800',
                              onChange: (String value) {
                                log('---value-$value------');
                                state.model.eventStartDate =
                                    Utils().formatTime(value);
                                log('---value11-${state.model.eventStartDate}------');
                                eventEndDateController.clear();
                                BlocProvider.of<CSRGeneralInfoCubit>(context)
                                    .onCheckBoxChange(state.model);
                                setState(() {});
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Event End Date
                            CommonWidgets.textDisplay(
                                state.labels?.locale.eventEndDate ??
                                    state.labels?.defaultLocale.eventEndDate ??
                                    Constants.eventEndDate,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            // Text('${Utils().formatUnixTimestamp(state.model.eventStartDate!)}'),
                            BaseDate().datePickerWidgetLoading(
                              textController: eventEndDateController,
                              isDisabled: true,
                              onlyDate: false,
                              // showPastDate: false,
                              startDate: state.model.eventStartDate,
                              notFlagDate: true,
                              onChange: (String value) {
                                state.model.eventEndDate =
                                    Utils().formatTime(value);
                                BlocProvider.of<CSRGeneralInfoCubit>(context)
                                    .onModelValueChange(state.model);
                                log('---value22-${state.model.eventEndDate}------');
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),


                            /// Event Type
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.anyEvent ??
                              //     state.labels?.defaultLocale.anyEvent ??
                                  Constants.eventType,
                              isMandatory: true,
                              Styles.textStyleWhite14,
                            ),
                            RadioButtonsYesNo(
                              isEvent: true,
                              status: state.model.status ?? 0,
                              selectedValue: state.model.eventType ? 1 : 0,
                              onChangedYes: null,
                              onChangedNo: null
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Event Name
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.lsm1ContactNo ??
                                //     state.labels?.defaultLocale.lsm1ContactNo ??
                                    Constants.eventName,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              initialValue: state.model.eventName,
                              textFormKey: Keys.lsm1ContactNOKey,
                              hintText: '',
                              focusNode: lSM1ContactNoFocusNode,
                              isEnable: false,
                              characterLimit: Constants.characterLimitContactNo,
                              isDisableColor: true,
                              onChange: (String value) {
                                // state.model.lsm1ContactNo = value;
                                // context
                                //     .read<CSRGeneralInfoCubit>()
                                //     .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Event location
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.lsm1ContactNo ??
                              //     state.labels?.defaultLocale.lsm1ContactNo ??
                                Constants.eventLoc,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              initialValue: state.model.eventLocation,
                              textFormKey: Keys.lsm1ContactNOKey,
                              hintText: '',
                              focusNode: lSM1ContactNoFocusNode,
                              isEnable: false,
                              characterLimit: Constants.characterLimitContactNo,
                              isDisableColor: true,
                              onChange: (String value) {
                                // state.model.lsm1ContactNo = value;
                                // context
                                //     .read<CSRGeneralInfoCubit>()
                                //     .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),


                            /// Num of Participants Registered /anticipated
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.lsm1ContactNo ??
                              //     state.labels?.defaultLocale.lsm1ContactNo ??
                                Constants.numParticipantsReg,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              initialValue: '${state.model.totalAttendies}',
                              textFormKey: Keys.lsm1ContactNOKey,
                              hintText: '',
                              focusNode: lSM1ContactNoFocusNode,
                              isEnable: false,
                              characterLimit: Constants.characterLimitContactNo,
                              isDisableColor: true,
                              onChange: (String value) {
                                // state.model.lsm1ContactNo = value;
                                // context
                                //     .read<CSRGeneralInfoCubit>()
                                //     .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),


                            /// External VIP Attendance
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.lsm1ContactNo ??
                              //     state.labels?.defaultLocale.lsm1ContactNo ??
                                Constants.extrernalVIPAttendance,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              initialValue: '${state.model.externalVipAttendance}',
                              textFormKey: Keys.lsm1ContactNOKey,
                              hintText: '',
                              focusNode: lSM1ContactNoFocusNode,
                              isEnable: false,
                              characterLimit: Constants.characterLimitContactNo,
                              isDisableColor: true,
                              onChange: (String value) {
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),


                            if(widget.isCSREvent == false)...[
                            ///Is Extra Security Deployment Required
                            Row(children: [
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.extraSecurityDeployed ??
                                //     state.labels?.defaultLocale
                                //         .extraSecurityDeployed ??
                                    Constants
                                        .isAmbulanceStationed,
                                Styles.textStyleWhite16,
                              ),
                              Opacity(
                                opacity: disableForm ? 0.5 : 1,
                                child: Checkbox(
                                    activeColor: const Color(0xFF071130),
                                    focusColor: const Color(0xFF071130),
                                    value: state.model.ambulanceStationed,
                                    onChanged: (bool? value) {
                                      state.model.ambulanceStationed =
                                      value!;
                                      BlocProvider.of<
                                          CSRGeneralInfoCubit>(
                                          context)
                                          .onCheckBoxChange(state.model);
                                    }),
                              )
                            ]),
],
                            /// Event Coordinator Primary
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.lsm1 ??
                                //     state.labels?.defaultLocale.lsm1 ??
                                    Constants.eventCoordinatorPrimary,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.bu1?.userInfo ??
                                  state.model.bu1?.name,
                              height: 70,
                              isDisableColor: true,
                              onTap: () {
                                BaseOrganisationDialog().userDialog(
                                  context: context,
                                  users: state.lsm,
                                  isDbUser: true,
                                  onTap: (BaseUser user) {
                                    // BlocProvider.of<CSRGeneralInfoCubit>(context)
                                    //     .updateDropdownValues(
                                    //   locationSecurityManager1: user,
                                    // );
                                    // FocusScope.of(context)
                                    //     .requestFocus(lSM1ContactNoFocusNode);
                                  },
                                  roleName: ConstantUserRoles
                                      .atomSeniorSecurityManagerUser,
                                  locationId: state.model.location!.id!,
                                  functionToCall: (BaseUser user) {
                                    BlocProvider.of<CSRGeneralInfoCubit>(context)
                                        .updateDropdownValues(
                                      locationSecurityManager1: user,
                                    );
                                    FocusScope.of(context)
                                        .requestFocus(lSM1ContactNoFocusNode);
                                    // refresh the list
                                    BlocProvider.of<GeneralInfoCubit>(context)
                                        .refreshList();
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            ///Contact No
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.lsm1ContactNo ??
                                //     state.labels?.defaultLocale.lsm1ContactNo ??
                                    Constants.eventCoordinatorPrimaryContact,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              initialValue: state.model.bu1ContactNo,
                              textFormKey: Keys.lsm1ContactNOKey,
                              hintText: '',
                              focusNode: lSM1ContactNoFocusNode,
                              isEnable: false,
                              characterLimit: Constants.characterLimitContactNo,
                              isDisableColor: true,
                              onChange: (String value) {
                              //   state.model.lsm1ContactNo = value;
                              //   context
                              //       .read<CSRGeneralInfoCubit>()
                              //       .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Event Coordinator secondary
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.lsm2 ??
                                //     state.labels?.defaultLocale.lsm2 ??
                                    Constants.eventCoordinatorSecondary,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.bu2?.userInfo ??
                                  state.model.bu2?.name,
                              height: 70,
                              isDisableColor: true,
                              onTap: () {
                                BaseOrganisationDialog().userDialog(
                                  context: context,
                                  users: state.lsm,
                                  isDbUser: true,
                                  onTap: (BaseUser user) {
                                    // BlocProvider.of<CSRGeneralInfoCubit>(context)
                                    //     .updateDropdownValues(
                                    //   locationSecurityManager2: user,
                                    // );
                                    // FocusScope.of(context)
                                    //     .requestFocus(lSM2ContactNoFocusNode);
                                  },
                                  roleName: ConstantUserRoles
                                      .atomSeniorSecurityManagerUser,
                                  locationId: state.model.location!.id!,
                                  functionToCall: (BaseUser user) {
                                    BlocProvider.of<CSRGeneralInfoCubit>(context)
                                        .updateDropdownValues(
                                      locationSecurityManager2: user,
                                    );
                                    FocusScope.of(context)
                                        .requestFocus(lSM2ContactNoFocusNode);
                                    // refresh the list
                                    BlocProvider.of<CSRGeneralInfoCubit>(context)
                                        .refreshList();
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Contact No
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.lsm2ContactNo ??
                                //     state.labels?.defaultLocale.lsm2ContactNo ??
                                    Constants.eventCoordinatorSecondaryContact,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              // labelText: Constants.lsm2ContactNo,
                              textInputType: TextInputType.number,
                              initialValue: state.model.bu2ContactNo,
                              textFormKey: Keys.lsm2ContactNOKey,
                              isEnable: false,
                              hintText: '',
                              focusNode: lSM2ContactNoFocusNode,
                              characterLimit: Constants.characterLimitContactNo,
                              isDisableColor: true,
                              onChange: (String value) {
                                // state.model.lsm2ContactNo = value;
                                // context
                                //     .read<CSRGeneralInfoCubit>()
                                //     .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),


                            /// Location Security  Manager 1
                            CommonWidgets.textDisplay(
                                state.labels?.locale.lsm1 ??
                                    state.labels?.defaultLocale.lsm1 ??
                                    Constants.locationSecurityManager1,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.lsm1?.userInfo ??
                                  state.model.lsm1?.name,
                              height: 70,
                              isDisableColor: true,
                              onTap: () {
                                BaseOrganisationDialog().userDialog(
                                  context: context,
                                  users: state.lsm,
                                  isDbUser: true,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<CSRGeneralInfoCubit>(context)
                                        .updateDropdownValues(
                                      locationSecurityManager1: user,
                                    );
                                    FocusScope.of(context)
                                        .requestFocus(lSM1ContactNoFocusNode);
                                  },
                                  roleName: ConstantUserRoles
                                      .atomSeniorSecurityManagerUser,
                                  locationId: state.model.location!.id!,
                                  functionToCall: (BaseUser user) {
                                    BlocProvider.of<CSRGeneralInfoCubit>(context)
                                        .updateDropdownValues(
                                      locationSecurityManager1: user,
                                    );
                                    FocusScope.of(context)
                                        .requestFocus(lSM1ContactNoFocusNode);
                                    // refresh the list
                                    BlocProvider.of<GeneralInfoCubit>(context)
                                        .refreshList();
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            ///LSM 1 Contact No
                            CommonWidgets.textDisplay(
                                state.labels?.locale.lsm1ContactNo ??
                                    state.labels?.defaultLocale.lsm1ContactNo ??
                                    Constants.lsm1ContactNo,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              initialValue: state.model.lsm1ContactNo,
                              textFormKey: Keys.lsm1ContactNOKey,
                              hintText: '',
                              focusNode: lSM1ContactNoFocusNode,
                              isEnable: false,
                              characterLimit: Constants.characterLimitContactNo,
                              isDisableColor: disableForm,
                              onChange: (String value) {
                                state.model.lsm1ContactNo = value;
                                context
                                    .read<CSRGeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Location Security  Manager 2
                            CommonWidgets.textDisplay(
                                state.labels?.locale.lsm2 ??
                                    state.labels?.defaultLocale.lsm2 ??
                                    Constants.locationSecurityManager2,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.lsm2?.userInfo ??
                                  state.model.lsm2?.name,
                              height: 70,
                              isDisableColor: true,
                              onTap: () {
                                BaseOrganisationDialog().userDialog(
                                  context: context,
                                  users: state.lsm,
                                  isDbUser: true,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<CSRGeneralInfoCubit>(context)
                                        .updateDropdownValues(
                                      locationSecurityManager2: user,
                                    );
                                    FocusScope.of(context)
                                        .requestFocus(lSM2ContactNoFocusNode);
                                  },
                                  roleName: ConstantUserRoles
                                      .atomSeniorSecurityManagerUser,
                                  locationId: state.model.location!.id!,
                                  functionToCall: (BaseUser user) {
                                    BlocProvider.of<CSRGeneralInfoCubit>(context)
                                        .updateDropdownValues(
                                      locationSecurityManager2: user,
                                    );
                                    FocusScope.of(context)
                                        .requestFocus(lSM2ContactNoFocusNode);
                                    // refresh the list
                                    BlocProvider.of<CSRGeneralInfoCubit>(context)
                                        .refreshList();
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            ///LSM 2 Contact No
                            CommonWidgets.textDisplay(
                                state.labels?.locale.lsm2ContactNo ??
                                    state.labels?.defaultLocale.lsm2ContactNo ??
                                    Constants.lsm2ContactNo,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              // labelText: Constants.lsm2ContactNo,
                              textInputType: TextInputType.number,
                              initialValue: state.model.lsm2ContactNo,
                              textFormKey: Keys.lsm2ContactNOKey,
                              isEnable: false,
                              hintText: '',
                              focusNode: lSM2ContactNoFocusNode,
                              characterLimit: Constants.characterLimitContactNo,
                              isDisableColor: true,
                              onChange: (String value) {
                                state.model.lsm2ContactNo = value;
                                context
                                    .read<CSRGeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// is there media exposure to the event?
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.staffCategory ??
                              //     state.labels?.defaultLocale.staffCategory ??
                                Constants.mediaExposure,
                                //isMandatory: true,
                                Styles.textStyleWhite14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),

                            BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: mediaExposureController,
                                initialValue:
                                state.model.mediaExposure.toString(),
                                items: mediaExposure,
                                onTap: () {
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Sensitive information Risk
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.staffCategory ??
                              //     state.labels?.defaultLocale.staffCategory ??
                                Constants.senstitiveInfoRisk,
                                //isMandatory: true,
                                Styles.textStyleWhite14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),

                            BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: sensitiveInfoController,
                                initialValue:
                                state.model.sensitiveInfoRisk.toString(),
                                items: riskInfo,
                                onTap: () {
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Name of NGO/Vendors Engaged for event
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.bu2ContactNo ??
                              //     state.labels?.defaultLocale.bu2ContactNo ??
                                Constants.nameNGOVendorsEngaged,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              initialValue: state.model.vendorCompanyName,
                              textFormKey: Keys.bu2ContactNOKey,
                              hintText: '',
                              focusNode: pocEscalationContactNoFocusNode,
                              characterLimit: Constants.characterLimitContactNo,
                              isEnable: false,
                              isDisableColor: true,
                              onChange: (String value) {
                                // state.model.bu2ContactNo = value;
                                // context
                                //     .read<CSRGeneralInfoCubit>()
                                //     .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),



                            /// Event Management Vendor POC Name
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.epOfficers ??
                              //     state.labels?.defaultLocale.epOfficers ??
                                Constants.eventMgmtVendorPocName,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ListView.builder(
                              itemCount: state.model.vendorPocName?.length ?? 0,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final officer = state.model.vendorPocName![index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
                                  child: BasicWidgetFunctions().getStringText(
                                    strings: [officer],
                                  ),
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Event Management Vendor POC Mobile NO
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.bu2ContactNo ??
                                //     state.labels?.defaultLocale.bu2ContactNo ??
                                    Constants.eventMgmtVendorPocContact,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              initialValue: state.model.vendorContactNo,
                              textFormKey: Keys.bu2ContactNOKey,
                              hintText: '',
                              focusNode: pocEscalationContactNoFocusNode,
                              characterLimit: Constants.characterLimitContactNo,
                              isEnable: false,
                              isDisableColor: true,
                              onChange: (String value) {
                                // state.model.bu2ContactNo = value;
                                // context
                                //     .read<CSRGeneralInfoCubit>()
                                //     .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),


                            /// Event Management Vendor Staff List
                            CommonWidgets.textDisplay(
                              Constants.eventMgmtVendorStaffList,
                              Styles.textStyleWhite16,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                           ListView.builder(
                                itemCount: state.model.vendorStaffList?.length ?? 0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final officer = state.model.vendorStaffList![index];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
                                    child: BasicWidgetFunctions().getStringText(
                                      strings: [officer],
                                    ),
                                  );
                                },
                              ),

                            CommonWidgets.textDisplay(
                              // state.labels?.locale.evidenceInfo ??
                              //     state.labels?.defaultLocale.evidenceInfo ??
                                Constants.vendorStaffDetailsUpload,
                                Styles.textStyleWhite16),
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.loadAttachments,
                              files: uploadVendorStaffFiles,
                              moduleCode: '',
                              isDisabled: true,
                              showDeleteIcon: false,
                            ),

                            Row(children: [
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.extraSecurityDeployed ??
                                //     state.labels?.defaultLocale
                                //         .extraSecurityDeployed ??
                                Constants
                                    .photoGraPhyReqired,
                                Styles.textStyleWhite16,
                              ),
                              Opacity(
                                opacity: disableForm ? 0.5 : 1,
                                child: Checkbox(
                                    activeColor: const Color(0xFF071130),
                                    focusColor: const Color(0xFF071130),
                                    value: state.model.photographyApproved,
                                    onChanged: (bool? value) {
                                      state.model.photographyApproved =
                                      value!;
                                      BlocProvider.of<
                                          CSRGeneralInfoCubit>(
                                          context)
                                          .onCheckBoxChange(state.model);
                                    }),
                              )
                            ]),

                            if(state.model.photographyApproved == true)...[
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.evidenceInfo ??
                                //     state.labels?.defaultLocale.evidenceInfo ??
                                  Constants.photoGraPhyReqiredEvidence,
                                  Styles.textStyleWhite16),
                              BaseImageUpload().getAttachment(
                                height: height,
                                attachments: state.loadAttachments,
                                files: uploadPhotographyFiles,
                                moduleCode: '',
                                isDisabled: true,
                                showDeleteIcon: false,
                              ),
                            ],

                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ///Upload Image
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.evidenceInfo ??
                                //     state.labels?.defaultLocale.evidenceInfo ??
                                    Constants.map,
                                Styles.textStyleWhite16),
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.loadAttachments,
                              files: uploadFiles,
                              moduleCode: '',
                              isDisabled: true,
                              showDeleteIcon: false,
                            ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),


                      if(state.model.status != 0 && state.model.status != 1 && state.model.status != 2 && state.model.status !=null)...[
                      /// Additional Information
                      CommonWidgets.textDisplay(
                        // state.labels?.locale.lsm1ContactNo ??
                        //     state.labels?.defaultLocale.lsm1ContactNo ??
                          Constants.additionalinformation,
                          Styles.textStyleWhite16,
                          isMandatory: true),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        textInputType: TextInputType.text,
                        initialValue: state.model.additionalInfo,
                        textFormKey: Keys.lsm1ContactNOKey,
                        hintText: '',
                        focusNode: lSM1ContactNoFocusNode,
                        isEnable: false,
                        characterLimit: Constants.characterLimitContactNo,
                        isDisableColor: true,
                        onChange: (String value) {
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),


                            CommonWidgets.textDisplay(
                              // state.labels?.locale.lsm1ContactNo ??
                              //     state.labels?.defaultLocale.lsm1ContactNo ??
                                Constants.assistanceInfo,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                            Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.white, width: .7),
                        ),
                        child: Column(
                          children: [

                            /// HEADER
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              color: Colors.white.withValues(alpha: 0.1),
                              child: const Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Role",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Name",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    "Contact No",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),

                            /// RECORDS
                            ...?state.model.commandSupport?.map((item) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    /// Role
                                    // Expanded(
                                    //   child: Text(
                                    //     '${item.role}',
                                    //     style: const TextStyle(color: Colors.white),
                                    //   ),
                                    // ),
                                    Expanded(
                                      child: Text(
                                        {
                                          3: 'ROC',
                                          0: 'Escalation 1 (SSM)',
                                          1: 'Escalation 2 (ASL)',
                                          2: 'Escalation 3 (SRH)',
                                        }[item.role] ?? 'Unknown',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),

                                    /// Name
                                    Expanded(
                                      child: Text(
                                        item.name!,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),

                                    /// Contact Num
                                    Expanded(
                                      child: Text(
                                        item.contactNo!,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      ],
                          ]),),

                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// SubmitButton
                      // if (state.model.status != 0) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cancelButtonDisplay(),
                        ],
                      ),
                      // ],
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ]),
              ),
            ),
          ],
        ),
      ),
    ],);
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


  Widget submitButtonDisplay(
      {required Function onTap, String? label = Constants.submit}) {
    return AppButton(
      width: 150,
      buttonText: label,
      buttonTextKey: Keys.submitButton,
      onTap: onTap,
    );
  }



  TextEditingController addEPOfficerController = TextEditingController();

  void addEPOfficers() {
    final cubit = context.read<GeneralInfoCubit>();
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<GeneralInfoCubit>.value(
          value: cubit,
          child: BlocBuilder<GeneralInfoCubit, GeneralInfoState>(
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
                                'Add Event Protection Officer',
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 1,
                              controller: addEPOfficerController,
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
                                state.model.epOfficers ??= [];
                                state.model.epOfficers
                                    ?.add(addEPOfficerController.text);

                                BlocProvider.of<GeneralInfoCubit>(this.context)
                                    .onCheckBoxChange(state.model);
                                Navigator.pop(context);
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
}


