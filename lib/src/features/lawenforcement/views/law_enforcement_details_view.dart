import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_cubit.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_state.dart';
import 'package:db_atom/src/features/lawenforcement/models/dropdown_object.dart';
import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';
import 'package:db_atom/src/features/lawenforcement/services/law_enforcement_services.dart';
import 'package:intl/intl.dart';

class LawEnforcementDetailsView extends StatefulWidget {
  final LawEnforcementDetailsModel? model;
  final ExtraProperties? extraProperties;

  const LawEnforcementDetailsView({
    super.key,
    this.model,
    this.extraProperties,
  });

  @override
  State<LawEnforcementDetailsView> createState() =>
      _LawEnforcementDetailsViewState();
}

class _LawEnforcementDetailsViewState extends State<LawEnforcementDetailsView> {
  final GlobalKey<FormState> lawEnforcementFormKey = GlobalKey<FormState>();
  TextEditingController statusTextController = TextEditingController();
  TextEditingController actualDateTextController = TextEditingController();
  TextEditingController dbOfficailWanttimeetTextController =
      TextEditingController();
  TextEditingController additionalInformationTextController =
      TextEditingController();
  TextEditingController nameTextController1 = TextEditingController();
  TextEditingController nameVisitingOfficialTextController =
      TextEditingController();
  TextEditingController designationTextController1 = TextEditingController();
  TextEditingController designationVisitingOfficialTextController =
      TextEditingController();
  TextEditingController officeaddressTextController1 = TextEditingController();
  TextEditingController officeaddressVisitingOfficialTextController =
      TextEditingController();
  TextEditingController emailidTextController1 = TextEditingController();
  TextEditingController emailidVisitingOfficialTextController =
      TextEditingController();
  TextEditingController contactnoTextController1 = TextEditingController();
  TextEditingController contactnoVisitingOfficialTextController =
      TextEditingController();
  TextEditingController nameTextController2 = TextEditingController();
  TextEditingController designationTextController2 = TextEditingController();
  TextEditingController officeaddressTextController2 = TextEditingController();
  TextEditingController emailidTextController2 = TextEditingController();
  TextEditingController contactnoTextController2 = TextEditingController();
  TextEditingController nameTextController3 = TextEditingController();
  TextEditingController nameTextController4 = TextEditingController();
  TextEditingController designationTextController3 = TextEditingController();
  TextEditingController designationTextController4 = TextEditingController();
  TextEditingController officeaddressTextController3 = TextEditingController();
  TextEditingController emailidTextController3 = TextEditingController();
  TextEditingController contactnoTextController3 = TextEditingController();
  TextEditingController emailidTextController4 = TextEditingController();
  TextEditingController contactnoTextController4 = TextEditingController();
  TextEditingController distributiongroupsTextController =
      TextEditingController();
  TextEditingController dateofcreationTextController = TextEditingController();
  TextEditingController officeaddressTextController4 = TextEditingController();
  TextEditingController nameTextController5 = TextEditingController();
  TextEditingController designationTextController5 = TextEditingController();
  TextEditingController officeaddressTextController5 = TextEditingController();
  TextEditingController emailidTextController5 = TextEditingController();
  TextEditingController contactnoTextController5 = TextEditingController();

  final FocusNode dbOfficialWantToMeetFocusNode = FocusNode();
  final FocusNode additionalInformationFocusNode = FocusNode();

  List<ImageContent> getFiles = [];
  List<ImageContent> getAttachments = [];
  late LawEnforcementState globalState;

  // String? serialnumber;
  bool isDistrbuted = false;

  int isOfficialIdcardSelected = 0;
  int isDocumentifanySelected = 0;
  int isIncaseofpoliceSelected = 0;

  // int get index => 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<LawEnforcementCubit, LawEnforcementState>(
      listener: (context, state) {},
      builder: (context, state) {
        log('state.model.lock.isEmptyOrNull${state.model!.lock.isEmptyOrNull}');
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isDistrbuted = true;
        // }
        if (!state.model!.lock.isEmptyOrNull) {
          isDistrbuted = true;
        }

        if (widget.model?.status == 3) {
          isDistrbuted = true;
        }
        return Scaffold(
          appBar: AppHeader(
            isTitleCenter: false,
            title: widget.model != null
                ? Constants.editlawenforcement
                : Constants.createlawenforcement,
            backBtn: IconButton(
              onPressed: () {
                Navigator.pop(context);
                CommonServices().unlock();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: Colors.white),
            ),
            action: [
              Visibility(
                visible: widget.model?.status != -1,
                child: GestureDetector(
                  onTap: () {
                    if (!isDistrbuted) {
                      submitForm(isSubmit: false, state: globalState);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!isDistrbuted)
                          SvgPicture.asset(
                            AppIcon.createfoundsaveicon,
                          )
                      ],
                    ),
                  ),
                ),
              ),
              //GestureDetector(
              Visibility(
                visible: widget.model?.status != -1,
                child: GestureDetector(
                  onTap: () async {
                    // Navigator.pop(context);

                    //loginFormKey.currentState!.validate();
                    FocusScope.of(context).unfocus();
                    try {
                      // passSubmit(true, widget.listuser?.id ?? 0, globalState);
                      validateForm(context, globalState);
                    } catch (e) {
                      // present userwith error message
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (!isDistrbuted)
                          const Icon(
                            Icons.send,
                            color: AppColors.white,
                          )
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.model?.id != null) ...[
                GestureDetector(
                  onTap: () {
                    DownloadImage().exportPdf(context, 'export.pdf',
                        '/${CommonApis.exportDetailPagePDF}${widget.model?.id}&moduleCode=${Constants.leoModuleCode}');
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
          body: BlocConsumer<LawEnforcementCubit, LawEnforcementState>(
            listener: (context, state) {
              log('state.model!.lock.isEmptyOrNull ${widget.model?.lock.isEmptyOrNull}');
              Utils().formError(state, context);
              Utils().errorAndLogout(state, context);
              if (state.status == FormStatus.successFormSubmit) {
                var dialog = CustomAlertDialog(
                  title: 'Law Enforcement',
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
                      lawEnforcementListRoute,
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
              if (state.status == FormStatus.failure) {
                Validator().showToast(
                  context,
                  state.message ?? 'Invalid Information',
                );
              }
            },
            builder: (context, state) {
              return BlocBuilder<LawEnforcementCubit, LawEnforcementState>(
                builder: (context, state) {
                  // listOfEntities = state.getEntitiesResponse;
                  //leoDepartmentsResponse = state.getLeodepartmentsResponse;
                  // leoPurposeVisitResponse = state.getLeopurposeResponse;

                  if (state.status == FormStatus.loading) {
                    return const BaseLoader();
                  }

                  if (state.getVisitsCount < 1) {
                    manageAddVisitOfficialDetailWidget(state);
                  }
                  globalState = state;
                  if (state.status == FormStatus.addAttachment) {
                    getFiles = state.loadAttachments ?? [];
                  }
                  // initiallyLocationandSerialnumberdataset(state);
                  // if (widget.listuser != null) {
                  //   if (state.groups != null) {

                  //   }
                  // }
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
                            //padding: const EdgeInsets.all(20.0),
                            decoration: const ShapeDecoration(
                                color: AppColors.backgroundWhiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.0)),
                                )),
                            child: AbsorbPointer(
                              absorbing: isDistrbuted,
                              child: Form(
                                key: lawEnforcementFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (!state.model!.lock.isEmptyOrNull) ...[
                                      RecordLockedWidget(
                                          text: '${state.model?.lock}'),
                                    ],
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20),
                                      child: Column(children: [
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
                                            Constants.status,
                                            Styles.textStyleBlack14,
                                            isMandatory: true),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                        FlutterInputField(
                                          isEnable: false,
                                          isDisableColor: true,
                                          controller: statusTextController,
                                          textFormKey:
                                              Keys.statusTextController,
                                          hintText: '',
                                          onChange: (String username) {
                                            //this.username = username;
                                          },
                                          validateTextField: (String? user) {},
                                          suffixWidget: GestureDetector(
                                            onTap: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: SvgPicture.asset(
                                                //AppIcon.dropdownicon,
                                                AppIcon.dropdownicon,
                                                //fit: BoxFit.,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  AppColors.textGreyThemeColor,
                                                  BlendMode.srcIn,
                                                ),
                                                // color: AppColors
                                                //     .textGreyThemeColor,
                                                width: 10,
                                                height: 10,
                                                key: const Key(Keys.userIcon),
                                              ),
                                            ),
                                          ),
                                        ),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                        /// created by
                                        CommonWidgets.horizentaltextHandling(
                                            Constants.createdby,
                                            isMandatory: true,
                                            // '${state.getUserDetailsResponse?.firstName ?? ''} ${state.getUserDetailsResponse?.lastName ?? ''}'),
                                            '${widget.model != null ? widget.model?.entrySecurity?.firstName : state.getUserDetailsResponse?.firstName ?? ''} ${widget.model != null ? widget.model?.entrySecurity?.lastName : state.getUserDetailsResponse?.lastName ?? ''}'),

                                        /// Location
                                        CommonWidgets.textDisplay(
                                            Constants.location,
                                            Styles.textStyleBlack14,
                                            isMandatory: true),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                        locationWidgetDisplay(state),

                                        // BaseLocationDropdown().locationWidgetDisplay(
                                        //     isEnabled: (widget.model?.status == null ||
                                        //         widget.model?.status == 0 ||
                                        //         widget.model?.status == 1),
                                        //     context: context,
                                        //     locations: state.getLocationsResponse ?? Locations(),
                                        //     selectedLocationName:
                                        //     state.model?.location?.name ?? '',
                                        //     onTap: (Organisation? location) {
                                        //       BlocProvider.of<
                                        //           MaterialMovementDetailsCubit>(
                                        //           context)
                                        //           .updateDropdownValues(location: location);
                                        //     }),

                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                        /// Date of creation
                                        CommonWidgets.textDisplay(
                                            Constants.dateofcreation,
                                            Styles.textStyleBlack14,
                                            isMandatory: true),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                        datecreateWidgetdisplay(),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                        /// slno
                                        CommonWidgets.horizentaltextHandling(
                                            Constants.slno, state.slno ?? '',
                                            isMandatory: true),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                        /// Entity type
                                        CommonWidgets.textDisplay(
                                            Constants.entity,
                                            Styles.textStyleBlack14,
                                            isMandatory: true),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                        entityaddButtonwidgetLoading(state),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                        /// Actual time of visit
                                        CommonWidgets.textDisplay(
                                            Constants.actualtimeofvisit,
                                            Styles.textStyleBlack14,
                                            isMandatory: true),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                        // datepickerWidgetLoading(
                                        //     actualDateTextController),
                                        BaseDate().datePickerWidgetLoading(
                                          showFutureDate: false,
                                          textController:
                                              actualDateTextController,
                                          isDisabled:
                                              (widget.model?.status == -1)
                                                  ? true
                                                  : false,
                                          //initialDate: DateTime.now().subtract(Duration(days: 1)),
                                          onChange: (String value) {
                                            widget.model?.timeOfVisit =
                                                Utils().formatTime(value);
                                          },
                                          context: context,
                                        ),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                        /// Officials ID Card Verified?
                                        CommonWidgets.textDisplay(
                                            Constants.officialsidcardverified,
                                            Styles.textStyleBlack14,
                                            isMandatory: true),
                                        radioButtonHandling(
                                            isOfficialIdcardSelected,
                                            Constants.officialsidcardverified),

                                        /// Purpose of visit
                                        CommonWidgets.textDisplay(
                                            Constants.purposeofvsit,
                                            Styles.textStyleBlack14,
                                            isMandatory: true),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),

                                        purposeofvisitaddButtonwidgetLoading(
                                            state),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                        /// Document if any to confirm purpose
                                        CommonWidgets.textDisplay(
                                            Constants
                                                .documentifanytoconfirmpurpose,
                                            Styles.textStyleBlack14,
                                            isMandatory: true),
                                        radioButtonHandling(
                                            isDocumentifanySelected,
                                            Constants
                                                .documentifanytoconfirmpurpose),

                                        /// In case of Police, was official in uniform?
                                        CommonWidgets.textDisplay(
                                            Constants
                                                .incaseofpolicewasofficialinuniform,
                                            Styles.textStyleBlack14,
                                            isMandatory: true),
                                        radioButtonHandling(
                                            isIncaseofpoliceSelected,
                                            // state.isIncaseofpoliceSelected ?? 0,
                                            Constants
                                                .incaseofpolicewasofficialinuniform),

                                        /// DB official want to meet
                                        CommonWidgets.textDisplay(
                                            Constants.dbofficialwanttomeet,
                                            Styles.textStyleBlack14,
                                            isMandatory: true),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                        // textfieldWidgetLoad(
                                        //     dbOfficailWanttimeetTextController,
                                        //     0,
                                        //     state),
                                        FlutterInputField(
                                          showBorder: false,
                                          lineHeight: 1,
                                          controller:
                                              dbOfficailWanttimeetTextController,
                                          textFormKey: Keys
                                              .additionalinformationTextController,
                                          hintText: Constants.informationhere,
                                          focusNode:
                                              dbOfficialWantToMeetFocusNode,
                                          isEnable: !isDistrbuted,
                                          isDisableColor: isDistrbuted,
                                          onChange: (String username) {
                                            //this.username = username;
                                            setState(() {});
                                          },
                                          validateTextField: (String? user) {},
                                        ),

                                        /// DB official department
                                        CommonWidgets.textDisplay(
                                            Constants.dbofficialdepartment,
                                            Styles.textStyleBlack14,
                                            isMandatory: true),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                        dbwanttodepartmentaddButtonwidgetLoading(
                                            state),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                        /// DB Official email ID Accompanied LEO official'
                                        CommonWidgets.textDisplay(
                                            Constants
                                                .dbofficialemailidaccompaniedleoofficial,
                                            Styles.textStyleBlack14,
                                            isMandatory: true),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                        dBOfficialEmailIDAccompaniedLeoOfficialWidget(
                                          state,
                                        ),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                        /// additional information
                                        CommonWidgets.textDisplay(
                                            Constants.additionalinformation,
                                            Styles.textStyleBlack14),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                        FlutterInputField(
                                          showBorder: true,
                                          lineHeight: 6,
                                          controller:
                                              additionalInformationTextController,
                                          textFormKey: Keys
                                              .additionalinformationTextController,
                                          hintText: Constants.informationhere,
                                          focusNode:
                                              additionalInformationFocusNode,
                                          isEnable: (widget.model?.status ==
                                                      0 ||
                                                  widget.model?.status == 1 ||
                                                  widget.model?.status == 2 ||
                                                  widget.model == null)
                                              ? true
                                              : false,
                                          isDisableColor:
                                              (widget.model?.status == 0 ||
                                                          widget.model
                                                                  ?.status ==
                                                              1 ||
                                                          widget.model
                                                                  ?.status ==
                                                              2 ||
                                                          widget.model ==
                                                              null) ||
                                                      (widget.model != null &&
                                                          widget.model!.lock
                                                              .isEmptyOrNull)
                                                  ? false
                                                  : true,
                                          onChange: (String username) {
                                            //this.username = username;
                                            setState(() {});
                                          },
                                          characterLimit: Constants
                                              .characterLimitDescTextFormField,
                                          validateTextField: (String? user) {},
                                          onFieldSubmitted: (String value) {
                                            additionalInformationTextController
                                                .value = TextEditingValue(
                                              text:
                                                  '${additionalInformationTextController.text}\n',
                                              selection:
                                                  TextSelection.collapsed(
                                                offset:
                                                    additionalInformationTextController
                                                            .text.length +
                                                        1,
                                              ),
                                            );
                                          },
                                        ),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),
                                      ]),
                                    ),

                                    // CommonWidgets.indentedDivider(Colors.black),
                                    const Divider(
                                      color: AppColors.textGreyThemeColor,
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: const ShapeDecoration(
                              color: AppColors.backgroundWhiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(00.0)),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: Column(
                                    children: [
                                      /// Visiting Official Details
                                      CommonWidgets.textDisplay(
                                        Constants.visitingOfficialDetails,
                                        Styles.textStyleDarkGrey16,
                                        isMandatory: true,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          // if (widget
                                          //     .model!.lock.isEmptyOrNull) {
                                          NavigatorState nav =
                                              Navigator.of(context);

                                          bool isSaveSuccess = await submitForm(
                                            isSubmit: false,
                                            state: state,
                                            navigateToNextScreen: true,
                                          );
                                          if (!isSaveSuccess) {
                                            return;
                                          }
                                          log('--widget.model.status---${widget.model?.status}--');
                                          // List<LawVisitingOfficial>
                                          //     visitingOfficials =
                                          await LawEnforcementServices()
                                              .getLeoVisitingOfficials(
                                                  id: state.model!.id!);

                                          log('--atomLeoDepartments--${state.departmentResponse?.atomLeoDepartments?.length}-');
                                          nav.pushNamed(
                                            visitingOfficialListRoute,
                                            arguments: {
                                              ConstantsArgument.title:
                                                  Constants.visitingOfficials,
                                              ConstantsArgument.type: 0,
                                              ConstantsArgument.id:
                                                  state.model?.id,
                                              // ConstantsArgument.models:
                                              //     visitingOfficials,
                                              ConstantsArgument
                                                  .departments: state
                                                      .departmentResponse
                                                      ?.atomLeoDepartments ??
                                                  [],
                                              ConstantsArgument.showSaveButton:
                                                  (widget.model?.status != 3)
                                                      ? true
                                                      : false,
                                            },
                                          );
                                          // }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              AppIcon.pluscircle,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                AppColors
                                                    .navigationSkyBlueColor,
                                                BlendMode.srcIn,
                                              ),
                                              // color: AppColors
                                              //     .navigationSkyBlueColor,
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              'Add/View Visiting Official(s)',
                                              style: TextStyle(
                                                color: AppColors
                                                    .navigationSkyBlueColor,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                      // (state.getVisitsCount) > 0
                                      //     ? listVisitingOfficialDetails(
                                      //         height,
                                      //         width,
                                      //         context,
                                      //         state,
                                      //         state.getVisitsCount,
                                      //       )
                                      //     : Container(),
                                      // widget.model == null
                                      //     ? CommonWidgets.verticalSpacerWidget(
                                      //         height * 0.01)
                                      //     : Container(),
                                      //
                                      // /// Add another visiting
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     if (widget.model?.status != -1) {
                                      //       if ((state.getVisitsCount) < 10) {
                                      //         manageAddVisitOfficialDetailWidget(
                                      //             state);
                                      //       } else {
                                      //         Validator().showToast(
                                      //           context,
                                      //           "You have reached maximum visiting official details adding",
                                      //         );
                                      //       }
                                      //     }
                                      //   },
                                      //   child: Row(
                                      //     children: <Widget>[
                                      //       // Expanded(
                                      //       //child:
                                      //       SvgPicture.asset(
                                      //         AppIcon.pluscircle,
                                      //         //color: AppColors.navigationSkybluecolor,
                                      //       ),
                                      //       // ),
                                      //       const SizedBox(width: 10),
                                      //       const Text(
                                      //         Constants
                                      //             .addvisitingofficialdetails,
                                      //         style: TextStyle(
                                      //           color: AppColors
                                      //               .navigationSkybluecolor,
                                      //           decoration:
                                      //               TextDecoration.underline,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),

                                      // Upload

                                      if ((widget.model == null ||
                                              widget.model?.status == 0 ||
                                              widget.model?.status == 1 ||
                                              widget.model?.status == 2) ||
                                          (widget.model != null &&
                                              widget.model!.lock
                                                  .isEmptyOrNull)) ...[
                                        CommonWidgets.textDisplay(
                                            Constants.upload,
                                            Styles.textStyleBlack14),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                        uploadWidget(state),
                                      ],
                                      // (widget.model == null ||
                                      //             widget.model?.status == 0 ||
                                      //             widget.model?.status == 1 ||
                                      //             widget.model?.status == 2) ||
                                      //         (widget.model != null &&
                                      //             widget.model!.lock
                                      //                 .isEmptyOrNull)
                                      //     ? CommonWidgets.textDisplay(
                                      //         Constants.upload,
                                      //         Styles.textStyleBlack14)
                                      //     : Container(),
                                      // (widget.model?.status == null ||
                                      //             widget.model?.status == 0 ||
                                      //             widget.model?.status == 1 ||
                                      //             widget.model?.status == 2) ||
                                      //         (widget.model != null &&
                                      //             widget.model!.lock
                                      //                 .isEmptyOrNull)
                                      //     ? CommonWidgets.verticalSpacerWidget(
                                      //         height * 0.001)
                                      //     : Container(),
                                      // (widget.model?.status == null ||
                                      //             widget.model?.status == 0 ||
                                      //             widget.model?.status == 1 ||
                                      //             widget.model?.status == 2) ||
                                      //         (widget.model != null &&
                                      //             widget.model!.lock
                                      //                 .isEmptyOrNull)
                                      //     ? uploadWidget(state)
                                      //     : Container(),

                                      BaseImageUpload().getAttachment(
                                          height: height,
                                          attachments: state
                                                  .loadAttachments.isEmptyOrNull
                                              ? getFiles
                                              : state.loadAttachments,
                                          files: getFiles.isEmptyOrNull
                                              ? getAttachments
                                              : getFiles,
                                          // showDownloadIcon: (widget.model ==
                                          //             null ||
                                          //         widget.model?.status == 0) &&
                                          //     (widget.model != null &&
                                          //         widget.model!.lock
                                          //             .isEmptyOrNull),
                                          moduleCode: Constants.leoModuleCode,
                                          showDeleteIcon:
                                              widget.model == null ||
                                                  widget.model?.status ==
                                                      ConstantsIntValue
                                                          .leoStatusDraft),
                                      // Attachments
                                      // getSpaceattchment(height),
                                      // getAttachement(height),

                                      if (widget.model?.status == 1 ||
                                          widget.model?.status == 2 ||
                                          widget.model?.status == 3) ...[
                                        /// Distribution Groups
                                        CommonWidgets.textDisplay(
                                          Constants.distributiongroups,
                                          Styles.textStyleBlack14,
                                          isMandatory: true,
                                        ),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                        BaseEntitiesSelection()
                                            .entityDropDownSelection(
                                          context: context,
                                          selectedValues:
                                              widget.model?.mailList ?? [],
                                          all: state
                                                  .groups?.distributionGroups ??
                                              [],
                                          enabled: (widget.model?.status == 1 ||
                                                  widget.model?.status == 2) &&
                                              (widget.model != null &&
                                                  widget.model!.lock
                                                      .isEmptyOrNull),
                                          onTap: (List<Organisation>
                                              selectedEntities) {
                                            log('--selectedEntities----${selectedEntities.length}');

                                            widget.model?.mailList =
                                                selectedEntities;
                                            setState(() {});
                                            // BlocProvider.of<LawEnforcementCubit>(context).onModelValueChange();
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                        ),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),
                                      ],
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),

                                      /// SubmitButton
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          cancelButtonDisplay(),
                                          if (!isDistrbuted) ...[
                                            submitButtonDisplay()
                                          ]
                                        ],
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.05),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void manageAddVisitOfficialDetailWidget(LawEnforcementState state) {
    int visitCount = (state.getVisitsCount) + 1;
    List<VisitingOfficialsModel>? getVisits = state.visitingOfficials ?? [];

    getVisits.add(VisitingOfficialsModel());
    lawEnforcementCubit.addingVisits(
      visitCount: visitCount,
      getVisits: getVisits,
    );
  }

  Widget listVisitingOfficialDetails(
    double height,
    double width,
    BuildContext context,
    LawEnforcementState state,
    int visitingOfficialDetailsArray,
  ) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < visitingOfficialDetailsArray; i++)

          // Name
          loadData(
            height,
            width,
            context,
            state,
            visitingOfficialDetailsArray,
            i,
          ),
      ],
    );
  }

  Widget loadData(
    double height,
    double width,
    BuildContext context,
    LawEnforcementState state,
    int visitingOfficialDetailsArray,
    int index,
  ) {
    return Column(
      children: [
        if (index != 0) ...[
          Row(
            children: [
              Expanded(
                child: CommonWidgets.textDisplay(
                  Constants.visitingOfficialDetails,
                  Styles.textStyleDarkGrey16,
                  isMandatory: true,
                ),
              ),
              CommonWidgets.verticalSpacerWidget(height * 0.06),
              GestureDetector(
                onTap: () {
                  if (widget.model?.status == 1 ||
                      widget.model?.status == 0 ||
                      widget.model?.status == null) {
                    int value = (state.getVisitsCount) - 1;
                    List<VisitingOfficialsModel>? getVisits1 =
                        state.visitingOfficials ?? [];
                    getVisits1.removeAt(index);
                    lawEnforcementCubit.addingVisits(
                        visitCount: value, getVisits: getVisits1);
                  }
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    AppIcon.closeicon,
                    colorFilter: const ColorFilter.mode(
                      AppColors.navigationSkyBlueColor,
                      BlendMode.srcIn,
                    ),
                    // color: AppColors.navigationSkyBlueColor,
                  ),
                ), //Icon(Icons.cancel)
              ),
            ],
          )
        ],
        CommonWidgets.verticalSpacerWidget(height * 0.002),

        CommonWidgets.textDisplay(
          Constants.name,
          Styles.textStyleBlack14,
          isMandatory: true,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.001),
        textfieldWidgetLoad(
          index == 0
              ? nameTextController1
              : index == 1
                  ? nameTextController2
                  : index == 2
                      ? nameTextController3
                      : index == 3
                          ? nameTextController4
                          : nameTextController5,
          index,
          state,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.01),

        // Designation
        CommonWidgets.textDisplay(
          Constants.designation,
          Styles.textStyleBlack14,
          isMandatory: true,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.001),
        textfieldWidgetLoad(
          index == 0
              ? designationTextController1
              : index == 1
                  ? designationTextController2
                  : index == 2
                      ? designationTextController3
                      : index == 3
                          ? designationTextController4
                          : designationTextController5,
          index,
          state,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.01),

        // Department
        CommonWidgets.textDisplay(
          Constants.department,
          Styles.textStyleBlack14,
          isMandatory: true,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.001),
        // articleaddButtonwidgetLoading(state),
        departmentaddButtonwidgetLoading(state, index),
        CommonWidgets.verticalSpacerWidget(height * 0.01),

        // Office Address
        CommonWidgets.textDisplay(
          Constants.officeAddress,
          Styles.textStyleBlack14,
          isMandatory: true,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.001),
        textfieldWidgetLoad(
          index == 0
              ? officeaddressTextController1
              : index == 1
                  ? officeaddressTextController2
                  : index == 2
                      ? officeaddressTextController3
                      : index == 3
                          ? officeaddressTextController4
                          : officeaddressTextController5,
          index,
          state,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.01),

        // Email Id
        CommonWidgets.textDisplay(
          Constants.emailId,
          Styles.textStyleBlack14,
          //isMandatory: state.getVisitsCount != 1 ? false : true,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.001),
        textfieldWidgetLoad(
          index == 0
              ? emailidTextController1
              : index == 1
                  ? emailidTextController2
                  : index == 2
                      ? emailidTextController3
                      : index == 3
                          ? emailidTextController4
                          : emailidTextController5,
          index,
          state,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.01),

        /// Contact No
        CommonWidgets.textDisplay(
          Constants.contactNo,
          Styles.textStyleBlack14,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.001),
        textfieldWidgetLoad(
          index == 0
              ? contactnoTextController1
              : index == 1
                  ? contactnoTextController2
                  : index == 2
                      ? contactnoTextController3
                      : index == 3
                          ? contactnoTextController4
                          : contactnoTextController5,
          index,
          state,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.02),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      populateData();
      lawEnforcementCubit.initializeValuesForExistingRecord(
          model: widget.model!);
      lawEnforcementCubit.getDistributionGroupsDetails();
    } else {
      lawEnforcementCubit.initializeValuesForNewRecord();
    }

    getLawEnforcementList(context);
    _getCurrentDate();
  }

  // initiallyLocationandSerialnumberdataset(LawEnforcementState state) async {
  //   if (state.locationSelectedlist?.id == null &&
  //       state.getLocationsResponse != null &&
  //       widget.model == null &&
  //       (serialnumber ?? '').isEmpty) {
  //     Organisation organisation = Organisation(id: 323, name: "SunGard");
  //     lawEnforcementCubit.getlocationsResponseData(organisation);
  //     await lawEnforcementCubit.getSerialnumberDetails('323', 'LEO', context);
  //   }
  // }

  populateData() async {
    if (widget.model != null) {
      await SharedPrefs.setFoundId(widget.model?.id ?? 0);

      additionalInformationTextController.text =
          widget.model?.additionalInformation != null
              ? widget.model?.additionalInformation.toString() ?? ""
              : '';
      dbOfficailWanttimeetTextController.text =
          widget.model?.dbOfficialEmail != null
              ? widget.model?.dbOfficialEmail.toString() ?? ""
              : '';
      actualDateTextController.text =
          widget.model?.timeOfVisit != null && widget.model?.timeOfVisit != '0'
              ? Utils.timestampToDateConversion(
                  int.parse(widget.model?.timeOfVisit ?? ''),
                  Constants.fulldateFormat)
              : actualDateTextController.text;
      dateofcreationTextController.text =
          widget.model?.inputDate != null && widget.model?.inputDate != '0'
              ? Utils.timestampToDateConversion(
                  int.parse(widget.model?.inputDate ?? '0'),
                  Constants.fulldateFormat)
              : dateofcreationTextController.text;
      // List<VisitingOfficial>? visitingOfficials = widget.listuser?.visitingOfficials != null ? widget.listuser?.visitingOfficials ?? [] : [];
      statusTextController.text = widget.model?.status == 0
          ? "Draft"
          : widget.model?.status == 1
              ? "Submitted"
              : widget.model?.status == 2
                  ? "Verification Under Process"
                  : widget.model?.status == 3
                      ? "Distributed"
                      : widget.model?.status == -1
                          ? 'Cancelled'
                          : '';

      if (widget.model?.status == 3 ||
          statusTextController.text == 'Distributed') {
        lawEnforcementCubit.getDistributed(true);
        isDistrbuted = true;
        setState(() {});
      }
      //state.serialnumberResponse?.serialNo

      //  state.getUserDetailsResponse  =  widget.listuser?.entrySecurity != null ? GetUserDetails(
      //     userId: widget.listuser?.entrySecurity?.userId ?? 1,
      //     lastName: widget.listuser?.entrySecurity?.lastName ?? "") : GetUserDetails() ;

      //state.locationSelectedlist =
      Organisation mumbai = widget.model?.location != null
          ? Organisation(
              id: widget.model?.location?.id ?? 0,
              name: widget.model?.location?.name ?? "")
          : Organisation();

      log('--widget.model?.slNo----${widget.model?.slNo}---');
      // serialnumber = widget.model?.slNo != null ? widget.model?.slNo ?? '' : '';

      widget.model?.slNo ??
          await lawEnforcementCubit.getSerialnumberDetails(
            (widget.model?.location?.id ?? 0),
            'LEO',
          );

      log('--widget.model?.slNo--22--${widget.model?.slNo}---');

      lawEnforcementCubit.getlocationsResponseData(mumbai);
      int isDocumentifanySelected1 =
          ((widget.model?.documentVerified ?? false) == true) ? 1 : 0;
      int isOfficialIdcardSelected1 =
          ((widget.model?.officialCardVerified ?? false) == true) ? 1 : 0;
      int isIncaseofpoliceSelected1 =
          ((widget.model?.visitorInUniform ?? false) == true) ? 1 : 0;

      lawEnforcementCubit.getRadioButtonSelected(
          Constants.documentifanytoconfirmpurpose,
          isDocumentifanySelected1,
          isDocumentifanySelected1 == 1 ? "Yes" : "No");
      lawEnforcementCubit.getRadioButtonSelected(
          Constants.officialsidcardverified,
          isOfficialIdcardSelected1,
          isOfficialIdcardSelected1 == 1 ? "Yes" : "No");
      lawEnforcementCubit.getRadioButtonSelected(
          Constants.incaseofpolicewasofficialinuniform,
          isIncaseofpoliceSelected1,
          isIncaseofpoliceSelected1 == 1 ? "Yes" : "No");

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
        lawEnforcementCubit.getEntityData(entities);
      }
      Organisation visit = widget.model?.visitPurpose != null
          ? Organisation(
              id: widget.model?.visitPurpose?.id ?? 0,
              name: widget.model?.visitPurpose?.name ?? "")
          : Organisation();
      lawEnforcementCubit.getleopurposeResponseData(visit);

      log('-----dbOfficialAccompaniedEmail---${widget.model?.dbOfficialAccompaniedEmail}');
      BaseUser staticUser =
          !widget.model!.dbOfficialAccompaniedEmail.isEmptyOrNull
              ? BaseUser(
                  // id: widget.model?.dbOfficialAccompaniedEmail,
                  email: widget.model?.dbOfficialAccompaniedEmail ?? "",
                )
              : BaseUser();

      log('---staticUser--${staticUser.email}---');
      lawEnforcementCubit
          .getDBOfficialEmailIdAccompaniedLeoOfficial(staticUser);

      List<LawVisitingOfficial>? visiting =
          widget.model?.visitingOfficials ?? [];

      List<VisitingOfficialsModel>? visitingOfficials = [];
      if (visiting.isNotEmpty) {
        for (int i = 0; i < visiting.length; i++) {
          LawVisitingOfficial model = visiting[i];
          Organisation dept = Organisation(
              id: model.department?.id, name: model.department?.name ?? '');
          VisitingOfficialsModel obj = VisitingOfficialsModel(
              address: model.address ?? '',
              name: model.name ?? '',
              contactNo: model.contactNo ?? '',
              designation: model.designation ?? '',
              email: model.email ?? '',
              department: dept,
              id: model.id);
          visitingOfficials.add(obj);
        }
      }
      // lawEnforcementCubit.getleoDepartmentsResponseData(dept);

      //AtomLeoDepartment dept = AtomLeoDepartment();

      // if (widget.listuser != null && (state.getVisits?.length ?? 0) > 0) {
      for (VisitingOfficialsModel model in visitingOfficials) {
        for (int i = 0; i < visiting.length; i++) {
          if (i == 0) {
            nameTextController1.text = model.name ?? '';
            officeaddressTextController1.text = model.address ?? '';
            contactnoTextController1.text = model.contactNo ?? '';
            emailidTextController1.text = model.email ?? '';
            designationTextController1.text = model.designation ?? '';
          } else if (i == 1) {
            nameTextController2.text = model.name ?? '';
            officeaddressTextController2.text = model.address ?? '';
            contactnoTextController2.text = model.contactNo ?? '';
            emailidTextController2.text = model.email ?? '';
            designationTextController2.text = model.designation ?? '';
          } else if (i == 2) {
            nameTextController3.text = model.name ?? '';
            officeaddressTextController3.text = model.address ?? '';
            contactnoTextController3.text = model.contactNo ?? '';
            emailidTextController3.text = model.email ?? '';
            designationTextController3.text = model.designation ?? '';
          } else if (i == 3) {
            nameTextController4.text = model.name ?? '';
            officeaddressTextController4.text = model.address ?? '';
            contactnoTextController4.text = model.contactNo ?? '';
            emailidTextController4.text = model.email ?? '';
            designationTextController4.text = model.designation ?? '';
          } else if (i == 4) {
            nameTextController5.text = model.name ?? '';
            officeaddressTextController5.text = model.address ?? '';
            contactnoTextController5.text = model.contactNo ?? '';
            emailidTextController5.text = model.email ?? '';
            designationTextController5.text = model.designation ?? '';
          }
          // dept = model != null
          //     ? AtomLeoDepartment(
          //         id: model.department?.id ?? 1, name: model.department?.name ?? '')
          //     : AtomLeoDepartment();
          // lawenforcementCubit.getleoDepartmentsResponseData(dept);
//}
//         }
        }
      }

      lawEnforcementCubit.addingVisits(
          visitCount: visitingOfficials.length, getVisits: visitingOfficials);

      // state.selectedemployeeDepartmentResponse
      Organisation emp = widget.model?.dbOfficialEmailDepartment != null
          ? Organisation(
              id: widget.model?.dbOfficialEmailDepartment?.id ?? 0,
              name: widget.model?.dbOfficialEmailDepartment?.name ?? '')
          : Organisation();
      lawEnforcementCubit.getemployeeDepartmentsResponseData(emp);
      getAttachments =
          widget.model?.images != null ? widget.model?.images ?? [] : [];
    }
  }

  getLawEnforcementList(context) async {
    var userid = await SharedPrefs.getUserId();
    await lawEnforcementCubit.getLocations('ATOM_LOCATIONS', context);
    await lawEnforcementCubit.getEntities('ATOM_ENTITIES');
    await lawEnforcementCubit.getLeoPurposeOfVisits(
      'ATOM_LEO_PURPOSE_VISIT',
    );
    await lawEnforcementCubit.getLeoDepartments(
      'ATOM_LEO_DEPARTMENTS',
    );
    await lawEnforcementCubit.getEmployeeDepartments(
      'EMPLOYEE_DEPARTMENTS',
    );
    await lawEnforcementCubit.getDBofficialByRoleDepositor(
      ConstantUserRoles.atomStaticUser,0
    );
    await lawEnforcementCubit.getUserDetails(
      userid,
    );
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
          validateForm(context, globalState);
        } catch (e) {
          // present userwith error message
        }
      },
    );
  }

  Widget radioButtonHandling(int selectedValue, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: (widget.model == null ||
                  (widget.model != null &&
                      widget.model!.status == 0 &&
                      (widget.model!.lock == null ||
                          widget.model!.lock!.isEmpty)))
              ? AppColors.navigationSkyBlueColor
              : AppColors.disableTextFieldBackground,
          focusColor: AppColors.navigationSkyBlueColor,
          value: 1,
          groupValue: selectedValue,
          onChanged: (val) {
            selectedValue = 1;
            if (name == Constants.officialsidcardverified &&
                (widget.model?.status == 0 || widget.model?.status == null)) {
              isOfficialIdcardSelected = selectedValue;
            } else if (name == Constants.documentifanytoconfirmpurpose &&
                (widget.model?.status == 0 || widget.model?.status == null)) {
              isDocumentifanySelected = selectedValue;
            } else if (name == Constants.incaseofpolicewasofficialinuniform &&
                (widget.model?.status == 0 || widget.model?.status == null)) {
              isIncaseofpoliceSelected = selectedValue;
            }
            setState(() {});
            lawEnforcementCubit.getRadioButtonSelected(
                name, selectedValue, "Yes");
          },
        ),
        const Text(Constants.yes),
        Radio(
          activeColor: (widget.model == null ||
                  (widget.model != null &&
                      widget.model!.status == 0 &&
                      (widget.model!.lock == null ||
                          widget.model!.lock!.isEmpty)))
              ? AppColors.navigationSkyBlueColor
              : AppColors.disableTextFieldBackground,
          value: 0,
          groupValue: selectedValue,
          onChanged: (val) {
            selectedValue = 0;
            if (name == Constants.officialsidcardverified &&
                (widget.model?.status == 0 || widget.model?.status == null)) {
              isOfficialIdcardSelected = selectedValue;
            } else if (name == Constants.documentifanytoconfirmpurpose &&
                (widget.model?.status == 0 || widget.model?.status == null)) {
              isDocumentifanySelected = selectedValue;
            } else if (name == Constants.incaseofpolicewasofficialinuniform &&
                (widget.model?.status == 0 || widget.model?.status == null)) {
              isIncaseofpoliceSelected = selectedValue;
            }

            //setState(() {});
            lawEnforcementCubit.getRadioButtonSelected(
                name, selectedValue, "No");
            // }
          },
        ),
        const Text(Constants.no),
      ],
    );
    //return Container();
  }

  dbOfficialDialog(LawEnforcementState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
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
                      lawstate: state,
                    );
                  });
            },
            onTap: (BaseUser list) {
              // if (name.toLowerCase() == 'depositor') {
              //  // selecteddepositorList = list;
              // } else {
              //   selectedClaimList = list;
              // }
              // setState(() {});
              log('---staticUserlist--${list.email}---');

              lawEnforcementCubit
                  .getDBOfficialEmailIdAccompaniedLeoOfficial(list);
              FocusScope.of(context)
                  .requestFocus(additionalInformationFocusNode);
            },
          );
        });
  }

  Widget datepickerWidgetLoading(TextEditingController textfiled) {
    return GestureDetector(
      onTap: () {
        if (widget.model?.status == 0 || (widget.model?.status == null)) {
          datePickerDialog(textfiled);
        }
      },
      child: FlutterInputField(
        controller: textfiled,
        textFormKey: textfiled == actualDateTextController
            ? Keys.founddateTextController
            : Keys.handedoverdateTextController,
        hintText: '',
        isEnable: false,
        isDisableColor:
            widget.model == null || textfiled.text.isEmpty ? false : true,
        onChange: (String username) {
          //this.username = username;
          log('dfwf');

          setState(() {});
        },
        validateTextField: (String? user) {},
        suffixWidget: GestureDetector(
          onTap: () async {
            if (widget.model == null || textfiled.text.isEmpty) {
              datePickerDialog(textfiled);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              AppIcon.calendaricon,
              colorFilter: const ColorFilter.mode(
                AppColors.navigationSkyBlueColor,
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
        lastDate: DateTime.now());

    log('pickedDate---$pickedDate'); //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat(Constants.fulldateFormat)
        .format(pickedDate ?? DateTime.now());
    log(formattedDate); //formatted date output using intl package =>  2021-03-16
    //you can implement different kind of Date Format here according to your requirement
    // if (textfield == actualDateTextController) {
    //   actualDateTextController.text = formattedDate;
    // }
    setState(() {
      // dateinput.text = formattedDate; //set output date to TextField value.
    });
  }

  void _getCurrentDate() {
    String formattedDate =
        DateFormat(Constants.fulldateFormat).format(DateTime.now());
    log(formattedDate);
    dateofcreationTextController.text = formattedDate;
    if (widget.model == null) {
      statusTextController.text = 'Draft';
    }
  }

  Widget uploadWidget(LawEnforcementState state) {
    return // upload
        widget.model == null ||
                widget.model?.status == 0 ||
                widget.model?.status == 1 ||
                widget.model?.status == 2
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
                                userdetails:
                                    state.getUserDetailsResponse ?? User(),
                                getFiles: getFiles,
                                lawstate: state,
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

  Widget getSpaceattchment(double height) {
    return getFiles.isNotEmpty || getAttachments.isNotEmpty
        ? CommonWidgets.verticalSpacerWidget(height * 0.01)
        : Container();
  }

  Widget entityaddButtonwidgetLoading(LawEnforcementState state) {
    return BaseEntitiesSelection().entityDropDownSelection(
      context: context,
      selectedValues: state.listOfEntities ?? [],
      all: state.getEntitiesResponse?.atomEntities ?? [],
      onTap: (List<Organisation> list) {
        lawEnforcementCubit.getEntityData(list);
        setState(() {});
        Navigator.pop(context);
      },
      enabled: !isDistrbuted,
      addTitle: Constants.addentitytype,
      orgName: 'ATOM_ENTITIES',
      createEntity: widget.model?.status == 0 ||
          widget.model?.status == 1 ||
          widget.model?.status == 2,
    );
  }

  leopurposeDialog(LawEnforcementState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateLeoPurposeVisits:
                state.purposeList?.atomLeoPurposeVisit ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddNewFields(
                        title: Constants.addpurposeofvisittype,
                        lawEnforcementState: state);
                  });
            },
            onTap: (Organisation list) {
              //log(list.name);
              lawEnforcementCubit.getleopurposeResponseData(list);
              FocusScope.of(context)
                  .requestFocus(dbOfficialWantToMeetFocusNode);
            },
          );
        });
  }

  leodepartmentsDialog(LawEnforcementState state) {
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
                      title: Constants.addemployeedepartment,
                      lawState: state,
                    );
                  });
            },
            onTap: (Organisation list) {
              //log(list.name);
              lawEnforcementCubit.getemployeeDepartmentsResponseData(list);
            },
          );
        });
  }

  departmentsDialog(LawEnforcementState state, int index) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateLeoDepartments:
                state.departmentResponse?.atomLeoDepartments ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddNewFields(
                        title: Constants.addleoofficialtype,
                        lawEnforcementState: state);
                  });
            },
            onTap: (Organisation list) {
              //log(list.name);

              if (state.visitingOfficials!.isNotEmpty) {
                VisitingOfficialsModel model = state.visitingOfficials![index];
                model.department = list;
              }

              lawEnforcementCubit.getleoDepartmentsResponseData(list);
            },
          );
        });
  }

  Widget purposeofvisitaddButtonwidgetLoading(LawEnforcementState state) {
    return TextFieldAddButton(
      title: state.leoPurposeVisitResponse?.name ?? '',
      height: 60,
      isDisableColor: !isDistrbuted ? false : true,
      onTap: () {
        if (widget.model?.status == 0 ||
            widget.model?.status == 1 ||
            widget.model?.status == 2 ||
            widget.model == null) {
          leopurposeDialog(state);
        }
        //  }
      },
    );
  }

  Widget departmentaddButtonwidgetLoading(
      LawEnforcementState state, int index) {
    Organisation? dept = Organisation();
    if ((state.visitingOfficials?.length ?? 0) > 0) {
      dept = state.visitingOfficials![index].department;
    }
    return TextFieldAddButton(
      title: dept?.name ?? '',
      height: 60,
      isDisableColor: widget.model?.status == 0 ||
              widget.model?.status == 1 ||
              widget.model == null ||
              widget.model?.status == null
          ? false
          : true,
      onTap: () {
        if (widget.model?.status == 0 ||
            widget.model?.status == 1 ||
            widget.model == null) {
          departmentsDialog(state, index);
        }
      },
    );
  }

  Widget dbwanttodepartmentaddButtonwidgetLoading(LawEnforcementState state) {
    return TextFieldAddButton(
      title: state.selectedemployeeDepartmentResponse?.name ?? '',
      height: 60,
      isDisableColor: isDistrbuted,
      onTap: () {
        if (!isDistrbuted) {
          leodepartmentsDialog(state);
        }
      },
    );
  }

  Widget employeeDepartmentAddButtonWidgetLoading(LawEnforcementState state) {
    return TextFieldAddButton(
      title: state.createEmployeeDepartments?.name ?? '',
      height: 60,
      isDisableColor:
          widget.model?.status != 0 && widget.model != null ? true : false,
      onTap: () {
        if (widget.model?.status == 0 || widget.model == null) {
          leodepartmentsDialog(state);
        }
      },
    );
  }

  Widget dBOfficialEmailIDAccompaniedLeoOfficialWidget(
      LawEnforcementState state) {
    return TextFieldAddButton(
      title: state.dBOfficialEmailIdAccompaniedLeoOfficial != null
          ? ('${state.dBOfficialEmailIdAccompaniedLeoOfficial?.name ?? ''}${state.dBOfficialEmailIdAccompaniedLeoOfficial?.email ?? ''}')
          : '',
      height: 70,
      isDisableColor: isDistrbuted,
      onTap: () {
        if (!isDistrbuted) {
          dbOfficialDialog(state);
        }
      },
    );
  }

  Widget locationWidgetDisplay(LawEnforcementState state) {
    return GestureDetector(
      onTap: () {
        if (widget.model?.status == null ||
            widget.model?.status == 0 ||
            widget.model?.status == 1) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              // log(state.getLocationsResponse);
              return CustomExpansionListTexts(
                locationList: state.getLocationsResponse,
                //GetLocations(),
                onTap: (Organisation? org) async {
                  await lawEnforcementCubit.getSerialnumberDetails(
                    org?.id ?? 0,
                    Constants.leoModuleCode,
                  );
                  // locationselectedText = list?.name ?? '';
                  // locationSelectedlist = list;
                  lawEnforcementCubit.getlocationsResponseData(org);
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
          child: (state.locationSelectedlist?.name ?? '').isEmpty
              ? Container()
              : Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                          state.locationSelectedlist?.name ?? '',
                          style: Styles.textStyleBlack14,
                        ),
                      ),
                    ),
                  )
                ])),
    );
  }

  Future<bool> submitForm({
    required bool isSubmit,
    required LawEnforcementState state,
    bool? navigateToNextScreen,
  }) async {
    log('---submitForm----');
    int actualDate = Utils.dateToTimestampConversion(
        actualDateTextController.text, Constants.fulldateFormat);
    String? inputDate;
    if (widget.model?.id == null) {
      inputDate = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
    } else {
      inputDate = widget.model?.inputDate;
    }
    int statusValue = 0;
    if (statusTextController.text.toLowerCase() == "draft") {
      statusValue = 0;
    } else if (statusTextController.text.toLowerCase() == "submitted") {
      statusValue = 1;
    } else if (statusTextController.text.toLowerCase() == "distributed") {
      statusValue = 3;
    } else if (statusTextController.text.toLowerCase() ==
        "verification under process") {
      statusValue = 2;
    } else if (statusTextController.text.toLowerCase() == "cancelled") {
      statusValue = -1;
    }
    bool isDocumentifanySelected =
        state.isDocumentifanySelected == 1 ? true : false;
    bool isIncaseofpoliceSelected =
        state.isIncaseofpoliceSelected == 1 ? true : false;
    bool isOfficialIdcardSelected =
        state.isOfficialIdcardSelected == 1 ? true : false;

    DbOfficialEmailDepartment? dbOfficialEmailDepartment =
        DbOfficialEmailDepartment(
            id: state.selectedemployeeDepartmentResponse?.id);
    DbOfficialEmailDepartment? visitPurpose =
        DbOfficialEmailDepartment(id: state.leoPurposeVisitResponse?.id);
    List<DbOfficialEmailDepartment>? entities = [];
    if ((state.listOfEntities?.length ?? 0) > 0) {
      for (int i = 0; i < state.listOfEntities!.length; i++) {
        Organisation entity = state.listOfEntities![i];
        DbOfficialEmailDepartment addentiity =
            DbOfficialEmailDepartment(id: entity.id ?? 1);
        entities.add(addentiity);
      }
    }
    LawEntrySecurity? entrySecurity;
    if (widget.model?.entrySecurity == null) {
      entrySecurity =
          LawEntrySecurity(userId: state.getUserDetailsResponse?.userId);
    } else {
      entrySecurity =
          LawEntrySecurity(userId: widget.model?.entrySecurity?.userId);
    }

    LawLocation? location = LawLocation(
        id: state.locationSelectedlist?.id ?? widget.model?.location?.id,
        name: state.locationSelectedlist?.name ?? widget.model?.location?.name);
    List<VisitingOfficial>? visitingOfficials;
    visitingOfficials ??= [];
    if (state.visitingOfficials != null) {
      for (int i = 0; i < state.visitingOfficials!.length; i++) {
        VisitingOfficialsModel model = state.visitingOfficials![i];
        DbOfficialEmailDepartment? dept =
            DbOfficialEmailDepartment(id: model.department?.id);
        VisitingOfficial? obj = VisitingOfficial(
            address: model.address ?? '',
            name: model.name ?? '',
            contactNo: model.contactNo ?? '',
            designation: model.designation ?? '',
            email: model.email ?? '',
            department: dept);
        if (!obj.name.isEmptyOrNull ||
            !obj.designation.isEmptyOrNull ||
            obj.department != null ||
            !obj.address.isEmptyOrNull) {
          visitingOfficials.add(obj);
        }
      }
    }

    for (Organisation organisation in widget.model?.mailList ?? []) {
      log('---organisation.name--createLawEnforcement---${organisation.name}');
    }
    List<Organisation>? loadGroups = widget.model?.mailList ?? [];
    List<ImageContent>? images =
        getFiles.isEmpty ? widget.model?.images : getFiles;
    LawEnforcement? lawEnforcement;
    if (widget.model != null) {
      lawEnforcement = LawEnforcement(
          id: widget.model?.id ?? 0,
          entrySecurity: entrySecurity,
          inputDate: inputDate.toString(),
          slNo: state.slno ?? widget.model?.slNo,
          location: location,
          status: statusValue,
          images: images,
          timeOfVisit: actualDate != 0 ? actualDate.toString() : '',
          officialCardVerified: isOfficialIdcardSelected,
          documentVerified: isDocumentifanySelected,
          visitorInUniform: isIncaseofpoliceSelected,
          entities: entities,
          additionalInformation: additionalInformationTextController.text,
          visitingOfficials: visitingOfficials,
          dbOfficialEmailDepartment: dbOfficialEmailDepartment,
          dbOfficialAccompaniedEmail:
              state.dBOfficialEmailIdAccompaniedLeoOfficial != null
                  ? (state.dBOfficialEmailIdAccompaniedLeoOfficial?.email ?? '')
                  : '',
          dbOfficialEmail: dbOfficailWanttimeetTextController.text,
          visitPurpose: visitPurpose,
          mailList: loadGroups);
    } else {
      lawEnforcement = LawEnforcement(
          entrySecurity: entrySecurity,
          inputDate: inputDate.toString(),
          slNo: state.slno ?? widget.model?.slNo,
          location: location,
          status: statusValue,
          images: images,
          timeOfVisit: actualDate != 0 ? actualDate.toString() : '',
          officialCardVerified: isOfficialIdcardSelected,
          documentVerified: isDocumentifanySelected,
          visitorInUniform: isIncaseofpoliceSelected,
          entities: entities,
          additionalInformation: additionalInformationTextController.text,
          visitingOfficials: visitingOfficials,
          dbOfficialEmailDepartment: dbOfficialEmailDepartment,
          dbOfficialAccompaniedEmail:
              state.dBOfficialEmailIdAccompaniedLeoOfficial != null
                  ? (state.dBOfficialEmailIdAccompaniedLeoOfficial?.email ?? '')
                  : '',
          dbOfficialEmail: dbOfficailWanttimeetTextController.text,
          visitPurpose: visitPurpose,
          mailList: loadGroups);
    }
    // if(addingVisitingOfficials){
    //
    // }
    // showLoadingDialog(context);
    LawEnforcementRequestBody body =
        LawEnforcementRequestBody(lawEnforcement: lawEnforcement);
    return await BlocProvider.of<LawEnforcementCubit>(context).submitForm(
      bodyRequest: body,
      isSubmit: isSubmit,
      title: widget.model != null
          ? 'edit LawEnforcement'
          : 'Create LawEnforcement',
      navigateToNextScreen: navigateToNextScreen ?? false,
    );
  }

  validateForm(BuildContext context, LawEnforcementState state) {
    if (statusTextController.text.isEmpty &&
        state.getUserDetailsResponse == null &&
        state.locationSelectedlist == null &&
        dateofcreationTextController.text.isEmpty &&
        // serialnumber == null &&
        state.listOfEntities == null &&
        actualDateTextController.text.isEmpty &&
        state.leoPurposeVisitResponse == null &&
        dbOfficailWanttimeetTextController.text.isEmpty &&
        additionalInformationTextController.text.isEmpty &&
        state.selectedemployeeDepartmentResponse == null) {
      Validator().showToast(
        context,
        "Please fill all required fields",
      );
    } else if (state.getUserDetailsResponse != null &&
        (state.getUserDetailsResponse?.lastName ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter creator name",
      );
    } else if (state.locationSelectedlist != null &&
        (state.locationSelectedlist?.name ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter location",
      );
    } else if (dateofcreationTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter creator date",
      );
    }
    /*else if (serialnumber != null && (serialnumber ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter serial number",
      );
    } */
    else if (state.listOfEntities.isEmptyOrNull) {
      Validator().showToast(
        context,
        "Please enter entity",
      );
    } else if (actualDateTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter actual time of visit",
      );
    } else if (state.leoPurposeVisitResponse != null &&
        (state.leoPurposeVisitResponse?.name ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter purpose of visit",
      );
    } else if (dbOfficailWanttimeetTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter DB official want to meet",
      );
    } else if (state.selectedemployeeDepartmentResponse != null &&
        (state.selectedemployeeDepartmentResponse?.name ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter DB official department",
      );
    } else if (state.dBOfficialEmailIdAccompaniedLeoOfficial != null &&
        (state.dBOfficialEmailIdAccompaniedLeoOfficial?.email ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter DB official email id accompanied LEO official",
      );
    }
    // else if (state.visitingOfficials != null &&
    //     state.visitingOfficials!.isNotEmpty) {
    //   for (int i = 0; i < state.visitingOfficials!.length;) {
    //     VisitingOfficialsModel model = state.visitingOfficials![i];
    //     if (model.name == null ||
    //         (model.name ?? '').isEmpty ||
    //         model.address == null ||
    //         (model.address ?? '').isEmpty ||
    //         model.department == null ||
    //         (model.department?.name ?? '').isEmpty ||
    //         model.designation == null ||
    //         (model.designation ?? '').isEmpty) {
    //       // Validator().showToast(
    //       //   context,
    //       //   "Please enter visiting official details",
    //       // );
    //       // break;
    //     }
    //     // else if (model.email != null && !Validator.isValidEmail(model.email?.trim())) {
    //     //   log('-model.email---${model.email}---');
    //     //   Validator().showToast(
    //     //     context,
    //     //     "Please enter visiting official  details valid email",
    //     //   );
    //     //   break;
    //     // }
    //     else {
    //       if (widget.model?.status != 0 &&
    //           (widget.model != null &&
    //               distributiongroupsTextController.text.isEmpty)) {
    //         Validator().showToast(
    //           context,
    //           "Please enter distribution groups",
    //         );
    //         break;
    //       } else {
    //         submitForm(isSubmit: true, state: globalState);
    //         break;
    //       }
    //     }
    //   }
    // }
    else {
      // if (widget.model?.status != 0 &&
      //     (widget.model != null &&
      //         distributiongroupsTextController.text.isEmpty)) {
      //   Validator().showToast(
      //     context,
      //     "Please enter distribution groups",
      //   );
      // }
      // else {
      submitForm(isSubmit: true, state: globalState);
      //}
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
        setState(() {});
      },
      validateTextField: (String? user) {},
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

  distributiongroupsDailog(LawEnforcementState state) {
    BaseEntitiesSelection().entityDropDownSelection(
        context: context,
        selectedValues: widget.model?.mailList ?? [],
        all: state.groups?.distributionGroups ?? [],
        enabled: widget.model?.status == 1 || widget.model?.status == 2,
        onTap: (List<Organisation> selectedEntities) {
          log('--selectedEntities----${selectedEntities.length}');

          widget.model?.mailList = selectedEntities;
          Navigator.of(context).pop(); // Close the dialog
        });

    // showDialog(
    //   context: context,
    //   builder: (BuildContext dialogContext) {
    //     return CustomListTexts(
    //       duplicateloadGroups: state.groups?.distributionGroups ?? [],
    //       onTap: (Organisation organisation) {
    //         log('--organisation.name---${organisation.name}');
    //
    //         distributiongroupsTextController.text = organisation.name ?? '';
    //         lawenforcementCubit.geDistributonData(organisation);
    //       },
    //     );
    //   },
    // );
  }

  Widget textfieldWidgetLoad(TextEditingController textController, int index,
      LawEnforcementState state) {
    return FlutterInputField(
      lineHeight: textController == additionalInformationTextController ? 6 : 1,
      onTap: () {
        if (textController == distributiongroupsTextController) {
          distributiongroupsDailog(state);
        }
      },
      textCapitalization:
          textController == emailidTextController1 ? false : true,
      controller: textController,
      textFormKey: Keys.colorTextController,
      isEnable: widget.model?.status == 0 ||
          widget.model?.status == 1 ||
          widget.model == null,
      hintText: '',
      onChange: (String username) {
        //this.username = username;
        if (textController == nameTextController1 ||
            textController == nameTextController2 ||
            textController == nameTextController3 ||
            textController == nameTextController4 ||
            textController == nameTextController5) {
          if (state.visitingOfficials!.isNotEmpty) {
            VisitingOfficialsModel model = state.visitingOfficials![index];
            model.name = username;
          }
        } else if (textController == designationTextController1 ||
            textController == designationTextController2 ||
            textController == designationTextController3 ||
            textController == designationTextController4 ||
            textController == designationTextController5) {
          if (state.visitingOfficials!.isNotEmpty) {
            VisitingOfficialsModel model = state.visitingOfficials![index];
            model.designation = username;
          }
        } else if (textController == emailidTextController1 ||
            textController == emailidTextController2 ||
            textController == emailidTextController3 ||
            textController == emailidTextController4 ||
            textController == emailidTextController5) {
          log('----state.getVisits-22-${state.visitingOfficials}----');
          if (state.visitingOfficials!.isNotEmpty) {
            log('----state.getVisits------');
            VisitingOfficialsModel model = state.visitingOfficials![index];
            model.email = username;
          }
        } else if (textController == officeaddressTextController1 ||
            textController == officeaddressTextController2 ||
            textController == officeaddressTextController3 ||
            textController == officeaddressTextController4 ||
            textController == officeaddressTextController5) {
          if (state.visitingOfficials!.isNotEmpty) {
            VisitingOfficialsModel model = state.visitingOfficials![index];
            model.address = username;
          }
        } else if (textController == contactnoTextController1 ||
            textController == contactnoTextController2 ||
            textController == contactnoTextController3 ||
            textController == contactnoTextController4 ||
            textController == contactnoTextController5) {
          if (state.visitingOfficials!.isNotEmpty) {
            VisitingOfficialsModel model = state.visitingOfficials![index];
            model.contactNo = username;
          }
        }
      },
      validateTextField: (String? user) {},
    );
  }
}
