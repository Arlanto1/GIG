import 'dart:developer';

import 'package:db_atom/src/common_widgets/custom_simple_list_texts.dart';
import 'package:db_atom/src/common_widgets/date_time_picker.dart';
import 'package:db_atom/src/features/createfound/views/create_found_newuser.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_state.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_request_body.dart';
import 'package:intl/intl.dart';

import 'package:db_atom/index.dart';
import '../../passmgmtlist/models/day_passlist_model.dart';

class CreatePassManagement extends StatefulWidget {
  DayPassListElement? model;
  final String? passId;
  final String? title;

  CreatePassManagement({super.key, this.model, this.passId, this.title});

  @override
  State<CreatePassManagement> createState() => _CreatePassManagementState();
}

class _CreatePassManagementState extends State<CreatePassManagement> {
  final GlobalKey<FormState> lawenforcementFormKey = GlobalKey<FormState>();
  TextEditingController statusTextController = TextEditingController();
  TextEditingController updateStatusTextController = TextEditingController();
  TextEditingController passvalidfromTextController = TextEditingController();
  TextEditingController passvaliduntilTextController = TextEditingController();
  TextEditingController companynameTextController = TextEditingController();
  TextEditingController employeeidTextController = TextEditingController();
  TextEditingController hostemployeeidTextController = TextEditingController();
  TextEditingController escortedbyTextController = TextEditingController();
  TextEditingController escortedemployeedidbyTextController =
      TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController hostTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController dbsponsorTextController = TextEditingController();
  TextEditingController daypassnoTextController = TextEditingController();
  TextEditingController passCategoryTextController = TextEditingController();
  TextEditingController passtypeTextController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    log('--passId----${widget.passId}----');
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
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white),
        ),

        action: [
          if (widget.model?.status == null ||
              widget.model?.status == 0 ||
              widget.model?.status == 1 ||
              widget.model?.status == 3) ...[
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
            GestureDetector(
              onTap: () {
                passValidations(context, globalState);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.send,
                  color: AppColors.backgroundWhitecolor,
                ),
                // SvgPicture.asset(
                //   AppIcon.createfoundsaveicon,
                //),
              ),
            ),
          ],
        ],
        //backgroundColor: AppColors.navigationSkybluecolor,
      ),
      backgroundColor: AppColors.backgroundWhitecolor,
      body: BlocBuilder<CreatePassMgmtCubit, CreatePassMgmtState>(
        builder: (context, state) {
          log('--widget.model?.status----${widget.model?.status}---');
          log('--isDisabled-111--$isDisabled---');

          log('--widget.model?.status----${widget.model?.status != null}---');
          log('--widget.model?.status != 0----${widget.model?.status != 0}---');

          if (widget.model?.status != null &&
              widget.model?.status != 0 &&
              widget.model?.status != 1) {
            log('--isDisabled-ifffffff--$isDisabled---');

            isDisabled = true;
            log('--isDisabled-ifffffff-2222-$isDisabled---');
          }
          log('--isDisabled-2222--$isDisabled---');

          if (state.getSerialnumberResponse != null) {
            serialnumber = state.getSerialnumberResponse?.serialNo ?? "";
          }
          globalState = state;
          if (state.stateType == CreatePassMgmtStateType.addattachment) {
            getFiles = state.loadAttachments ?? [];
          }
          if (state.stateType == CreatePassMgmtStateType.photoattachment) {
            photogetFiles = state.photoAttachments ?? [];
          }
          initiallyLocationAndSerialNumberDataset(state);
          // if (widget.listuser != null) {
          //   if (state.groups != null) {

          //   }
          // }
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.01,
                  color: AppColors.navigationSkybluecolor,
                ),
                Container(
                  //padding: const EdgeInsets.all(20.0),
                  decoration: const ShapeDecoration(
                      color: AppColors.backgroundWhitecolor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0)),
                      )),
                  child: AbsorbPointer(
                    absorbing: isDisabled,
                    child: Form(
                      key: lawenforcementFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
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
                                    Constants.status, Styles.textStyleBlack14,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  isEnable: false,
                                  isDisableColor: true,
                                  textFieldController: statusTextController,
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
                                        color: AppColors.textgreyThemecolor,
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
                                (widget.model != null &&
                                        (statusTextController.text
                                                    .toLowerCase() ==
                                                "created" ||
                                            statusTextController.text
                                                    .toLowerCase() ==
                                                "handed over"))
                                    ? CommonWidgets.textDisplay(
                                        isMandatory: true,
                                        Constants.updatestatus,
                                        Styles.textStyleBlack14)
                                    : Container(),
                                (widget.model != null &&
                                        (statusTextController.text
                                                    .toLowerCase() ==
                                                "created" ||
                                            statusTextController.text
                                                    .toLowerCase() ==
                                                "handed over"))
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.001)
                                    : Container(),

                                if ((widget.model != null &&
                                    (statusTextController.text.toLowerCase() ==
                                            "created" ||
                                        statusTextController.text
                                                .toLowerCase() ==
                                            "handed over"))) ...[
                                  InkWell(
                                    onTap: () {
                                      log('-ontap-----statusTextController.text----${statusTextController.text}---');
                                      if (statusTextController.text
                                              .toLowerCase() ==
                                          "created") {
                                        updatestausTypeDialog();
                                      } else {
                                        updatestausTypeDialog();
                                      }
                                    },
                                    child: FlutterInputField(
                                      isEnable: false,
                                      isDisableColor: true,
                                      textFieldController:
                                          updateStatusTextController,
                                      textFormKey:
                                          Keys.updateStatusTextControllerKey,
                                      hintText: '',
                                      onChange: (String value) {},
                                      validateTextField: (String? user) {},
                                      suffixIcon: Icons.arrow_drop_down,
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     log('-ontap-----statusTextController.text----${statusTextController.text}---');
                                  //     if (statusTextController.text
                                  //             .toLowerCase() ==
                                  //         "created") {
                                  //       updatestausTypeDialog();
                                  //     } else {
                                  //       updatestausTypeDialog();
                                  //     }
                                  //   },
                                  //   child: FlutterInputField(
                                  //     isEnable: false,
                                  //     isDisableColor: true,
                                  //     textFieldController:
                                  //         updateStatusTextController,
                                  //     textFormKey:
                                  //         Keys.updateStatusTextControllerKey,
                                  //     hintText: '',
                                  //     onChange: (String value) {},
                                  //     validateTextField: (String? user) {},
                                  //     suffixWidget: GestureDetector(
                                  //       onTap: () {
                                  //         log('--FlutterInputField----onTap--');
                                  //         if (statusTextController.text
                                  //                 .toLowerCase() ==
                                  //             "created") {
                                  //           updatestausTypeDialog();
                                  //         } else {
                                  //           updatestausTypeDialog();
                                  //         }
                                  //       },
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(20.0),
                                  //         child: SvgPicture.asset(
                                  //           //AppIcon.dropdownicon,
                                  //           AppIcon.dropdownicon,
                                  //           //fit: BoxFit.,
                                  //           color: AppColors.textgreyThemecolor,
                                  //           width: 10,
                                  //           height: 10,
                                  //           key: const Key(Keys.userIcon),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  (statusTextController.text.toLowerCase() ==
                                              "created" ||
                                          statusTextController.text
                                                  .toLowerCase() ==
                                              "handed over")
                                      ? CommonWidgets.verticalSpacerWidget(
                                          height * 0.01)
                                      : Container(),
                                ],

                                /// Created By
                                CommonWidgets.horizentaltextHandling(
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
                                  Constants.location,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                locationWidgetdislay(state),
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

                                /// date of creation
                                CommonWidgets.textDisplay(
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
                                  Constants.slno,
                                  serialnumber ?? '',
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// entity type
                                CommonWidgets.textDisplay(
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
                                  Constants.passtype,
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                GestureDetector(
                                  onTap: () {
                                    if (widget.model?.status == 0 ||
                                        widget.model?.status == null ||
                                        widget.model?.status != 1) {
                                      passTypeDialog();
                                    }
                                  },
                                  child: FlutterInputField(
                                      isEnable: false,
                                      isDisableColor:
                                          // widget.listuser == null ||
                                          //         passtypeTextController
                                          //             .text.isEmpty
                                          //     ? false
                                          //     :
                                          true,
                                      textFieldController:
                                          passtypeTextController,
                                      textFormKey: Keys.statusTextController,
                                      hintText: '',
                                      onChange: (String username) {
                                        //this.username = username;
                                        setState(() {});
                                      },
                                      onTap: () {
                                        if (widget.model?.status == 0 ||
                                            widget.model?.status == null ||
                                            widget.model?.status != 1) {
                                          passTypeDialog();
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
                                            if (widget.model?.status == 0 ||
                                                widget.model?.status == null ||
                                                widget.model?.status != 1) {
                                              passTypeDialog();
                                            }
                                          })),
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Company Type
                                widget.passId == "0" || widget.passId == "3"
                                    ? CommonWidgets.textDisplay(
                                        Constants.companytype,
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    : Container(),
                                widget.passId == "0" || widget.passId == "3"
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.001)
                                    : Container(),

                                widget.passId == "0" || widget.passId == "3"
                                    ? companytypeaddButtonwidgetLoading(state)
                                    : Container(),
                                widget.passId == "0" || widget.passId == "3"
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.01)
                                    : Container(),

                                /// Vendor Name // Visitor Name // Company Name
                                CommonWidgets.textDisplay(
                                  widget.passId == "0" || widget.passId == "3"
                                      ? Constants.companyname
                                      : widget.passId == "2"
                                          ? "Vendor Name"
                                          : widget.passId == "0"
                                              ? Constants.name
                                              : "Visitor Name",
                                  Styles.textStyleBlack14,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                widget.passId == "0" || widget.passId == "3"
                                    ? textFieldWidgetLoad(
                                        companynameTextController, 0, state)
                                    : textFieldWidgetLoad(
                                        nameTextController, 0, state),

                                ///Vendor Company Name
                                widget.passId == "2"
                                    ? CommonWidgets.textDisplay(
                                        Constants.companyname,
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    : Container(),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                widget.passId == "2"
                                    ? textFieldWidgetLoad(
                                        companynameTextController, 0, state)
                                    : Container(),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Name
                                widget.passId == "3"
                                    ? CommonWidgets.textDisplay(
                                        Constants.name,
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    : Container(),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                widget.passId == "3"
                                    ? textFieldWidgetLoad(
                                        nameTextController, 0, state)
                                    : Container(),

                                ///Contact No / Email
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                                CommonWidgets.textDisplay(
                                    widget.passId == "0"
                                        ? Constants.name
                                        : widget.passId == "3"
                                            ? "Email"
                                            : "Contact No",
                                    Styles.textStyleBlack14,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                // articleaddButtonwidgetLoading(state),
                                widget.passId == "0"
                                    ? ((state.selectedCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'fte' ||
                                            (state.selectedCompanyType?.name ==
                                                null)
                                        ? nameaddButtonwidgetLoading(state)
                                        : textFieldWidgetLoad(
                                            nameTextController, 0, state))
                                    : widget.passId == "3"
                                        ? textFieldWidgetLoad(
                                            emailTextController, 0, state)
                                        : textFieldWidgetLoad(
                                            contactnoTextController, 0, state),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Employee Id
                                widget.passId == "0" &&
                                            (state.selectedCompanyType?.name ??
                                                        '')
                                                    .toLowerCase() !=
                                                'exceptions' ||
                                        widget.passId == "3"
                                    ? CommonWidgets.textDisplay(
                                        Constants.employeeid,
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    : Container(),

                                widget.passId == "0" &&
                                            (state.selectedCompanyType?.name ??
                                                        '')
                                                    .toLowerCase() !=
                                                'exceptions' ||
                                        widget.passId == "3"
                                    ? textFieldWidgetLoad(
                                        employeeidTextController, 0, state)
                                    : Container(),

                                widget.passId == "0" &&
                                        (state.selectedCompanyType?.name ?? '')
                                                .toLowerCase() ==
                                            'cwr t1'
                                    ? CommonWidgets.textDisplay(Constants.email,
                                        Styles.textStyleBlack14,
                                        isMandatory: true)
                                    : Container(),

                                widget.passId == "0" &&
                                        (state.selectedCompanyType?.name ?? '')
                                                .toLowerCase() ==
                                            'cwr t1'
                                    ? textFieldWidgetLoad(
                                        emailTextController, 0, state)
                                    : Container(),

                                widget.passId == "0" &&
                                        (state.selectedCompanyType?.name ?? '')
                                                .toLowerCase() ==
                                            'cwr t1'
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.01)
                                    : Container(),

                                /// DB sponsor
                                widget.passId == "0" &&
                                        ((state.selectedCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'cwr t1' ||
                                            (state.selectedCompanyType?.name ??
                                                        '')
                                                    .toLowerCase() ==
                                                'cwr t2')
                                    ? CommonWidgets.textDisplay(
                                        'DB Sponsor',
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    : Container(),

                                widget.passId == "0" &&
                                        ((state.selectedCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'cwr t1' ||
                                            (state.selectedCompanyType?.name ??
                                                        '')
                                                    .toLowerCase() ==
                                                'cwr t2')
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.001)
                                    : Container(),

                                widget.passId == "0" &&
                                        ((state.selectedCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'cwr t1' ||
                                            (state.selectedCompanyType?.name ??
                                                        '')
                                                    .toLowerCase() ==
                                                'cwr t2')
                                    ? dbsponsoraddButtonwidgetLoading(state)
                                    : Container(),

                                widget.passId == "0" &&
                                        ((state.selectedCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'cwr t1' ||
                                            (state.selectedCompanyType?.name ??
                                                        '')
                                                    .toLowerCase() ==
                                                'cwr t2')
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.01)
                                    : Container(),

                                /// db sponsor employee id
                                widget.passId == "0" &&
                                        ((state.selectedCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'cwr t1' ||
                                            (state.selectedCompanyType?.name ??
                                                        '')
                                                    .toLowerCase() ==
                                                'cwr t2')
                                    ? CommonWidgets.textDisplay(
                                        'DB Sponsor Employee Id',
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    : Container(),

                                widget.passId == "0" &&
                                        ((state.selectedCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'cwr t1' ||
                                            (state.selectedCompanyType?.name ??
                                                        '')
                                                    .toLowerCase() ==
                                                'cwr t2')
                                    ? textFieldWidgetLoad(
                                        dbsponsorTextController, 0, state)
                                    : Container(),

                                widget.passId == "0" &&
                                        ((state.selectedCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'cwr t1' ||
                                            (state.selectedCompanyType?.name ??
                                                        '')
                                                    .toLowerCase() ==
                                                'cwr t2')
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.01)
                                    : Container(),

                                /// SEZ Pass Info
                                if (widget.passId == '1' ||
                                    widget.passId == '3') ...[
                                  CommonWidgets.textDisplay(
                                    widget.passId == '1'
                                        ? 'Visitor Coming From'
                                        : 'SEZ Pass Info',
                                    Styles.textStyleBlack14,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  textFieldWidgetLoad(
                                      widget.passId == '1'
                                          ? visitorcomingfromTextController
                                          : sezpassinfoTextController,
                                      0,
                                      state),

                                  // /// Incident Location
                                  // CommonWidgets.textDisplay(
                                  //     Constants.incidentLocation,
                                  //     Styles.textStyleBlack14),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //     height * 0.001),
                                  // FlutterInputField(
                                  //   keyboardType: TextInputType.text,
                                  //   initialValue: state.model.incidentLocation,
                                  //   textFormKey: Keys.lsm1ContactNOKey,
                                  //   hintText: '',
                                  //   isEnable: true,
                                  //   isDisableColor: false,
                                  //   onChange: (String value) {
                                  //     state.createpassFoundresponse. = value;
                                  //     context
                                  //         .read<IncidentGeneralInfoCubit>()
                                  //         .onModelValueChange(state.model);
                                  //   },
                                  //   validateTextField: (String? user) {},
                                  // ),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //     height * 0.01),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                  CommonWidgets.textDisplay(
                                    widget.passId == '3'
                                        ? 'MTP Application No'
                                        : 'Purpose of Visit',
                                    Styles.textStyleBlack14,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  textFieldWidgetLoad(
                                      widget.passId == '3'
                                          ? mtpApplicationNoTextController
                                          : purposeofvisitTextController,
                                      0,
                                      state),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                ],
                                //Photo Identity Validation Type
                                widget.passId == "1"
                                    ? CommonWidgets.textDisplay(
                                        'Photo Identity Validation Type  ',
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    : Container(),
                                widget.passId == "1"
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.001)
                                    : Container(),
                                widget.passId == "1"
                                    ? GestureDetector(
                                        onTap: () {
                                          if (widget.model?.status == 0 ||
                                              widget.model?.status == null) {
                                            photoIdentityTypeDialog();
                                          }
                                        },
                                        child: FlutterInputField(
                                            isEnable: false,
                                            isDisableColor:
                                                // widget.listuser == null ||
                                                //         passtypeTextController
                                                //             .text.isEmpty
                                                //     ? false
                                                //     :
                                                true,
                                            textFieldController:
                                                photofidentityextController,
                                            textFormKey:
                                                Keys.statusTextController,
                                            hintText: '',
                                            onChange: (String username) {
                                              //this.username = username;
                                              setState(() {});
                                            },
                                            onTap: () {
                                              if (widget.model?.status == 0 ||
                                                  widget.model?.status ==
                                                      null) {
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
                                                  if (widget.model?.status ==
                                                          0 ||
                                                      widget.model?.status ==
                                                          null) {
                                                    photoIdentityTypeDialog();
                                                  }
                                                })),
                                      )
                                    : Container(),
                                widget.passId == "1"
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.01)
                                    : Container(),

                                /// Host
                                (((state.selectedCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'exceptions'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'developer'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'tester' ) && widget.passId == "0") ||
                                        widget.passId == "1" ||
                                        widget.passId == "2"
                                        // widget.passId == '3' ||
                                        // (state.selectedCompanyType?.name ==
                                        //         null &&
                                        //     widget.passId == "0")
                                    ? CommonWidgets.textDisplay(
                                        Constants.host,
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    : Container(),

                                (((state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'exceptions'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'developer'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'tester' ) && widget.passId == "0")  ||
                                        widget.passId == "1" ||
                                        widget.passId == "2"
                                        //   widget.passId == '3' ||
                                        // (state.selectedCompanyType?.name ==
                                        //         null &&
                                        //     widget.passId == "0")
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.001)
                                    : Container(),
                                // articleaddButtonwidgetLoading(state),
                                (((state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'exceptions'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'developer'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'tester' ) && widget.passId == "0")  ||
                                        widget.passId == "1" ||
                                        widget.passId == "2"
                                        // widget.passId == '3' ||
                                        // (state.selectedCompanyType?.name ==
                                        //         null &&
                                        //     widget.passId == "0")
                                    ? hostaddButtonwidgetLoading(state)
                                    : Container(),
                                (((state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'exceptions'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'developer'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'tester' ) && widget.passId == "0")  ||
                                        widget.passId == "1" ||
                                        widget.passId == "2"
                                        // widget.passId == '3' ||
                                        // (state.selectedCompanyType?.name ==
                                        //         null &&
                                        //     widget.passId == "0")
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.01)
                                    : Container(),

                                /// Host Employee Id
                                (((state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'exceptions'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'developer'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'tester' ) && widget.passId == "0")  ||
                                        widget.passId == "1" ||
                                        widget.passId == "2"
                                        // widget.passId == '3' ||
                                        // (state.selectedCompanyType?.name ==
                                        //         null &&
                                        //     widget.passId == "0")
                                    ? CommonWidgets.textDisplay(
                                        Constants.hostemployeeid,
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    : Container(),
                                (((state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'exceptions'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'developer'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'tester' ) && widget.passId == "0")  ||
                                        widget.passId == "1" ||
                                        widget.passId == "2"
                                        // widget.passId == '3' ||
                                        // (state.selectedCompanyType?.name ==
                                        //         null &&
                                        //     widget.passId == "0")
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.001)
                                    : Container(),

                                (((state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'exceptions'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'developer'||(state.selectedCompanyType?.name ?? '')
                                    .toLowerCase() ==
                                    'tester' ) && widget.passId == "0")  ||
                                        widget.passId == "1" ||
                                        widget.passId == "2"
                                        //  widget.passId == '3' ||
                                        // (state.selectedCompanyType?.name ==
                                        //         null &&
                                        //     widget.passId == "0")
                                    ? textfieldWidgetLoad1(
                                        hostemployeeidTextController,
                                        0,
                                        state,
                                      )
                                    : Container(),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// department
                                widget.passId == '3'
                                    ? Container()
                                    : CommonWidgets.textDisplay(
                                        widget.passId == '1' ||
                                                widget.passId == '2'
                                            ? "Visiting Department"
                                            : Constants.department,
                                        isMandatory: true,
                                        Styles.textStyleBlack14),
                                widget.passId == '3'
                                    ? Container()
                                    : CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                // articleaddButtonwidgetLoading(state),
                                widget.passId == '3'
                                    ? Container()
                                    : departmentaddButtonwidgetLoading(state),
                                widget.passId == '3'
                                    ? Container()
                                    : CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                /// Reason for day pass
                                if (widget.passId == '0' ||
                                    widget.passId == '2') ...[
                                  CommonWidgets.textDisplay(
                                    widget.passId == "2"
                                        ? "Reason for Vendor Pass"
                                        : Constants.reasonfordaypass,
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

                                ///Exceptional approval for External auditors/regulators
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
                                        Constants.exceptionalApproval,
                                        Styles.textStyleBlack14,
                                        isMandatory: true,
                                      ),
                                      radioButtonHandling(
                                        state.exceptionalApproval ?? 0,
                                        Constants.exceptionalApproval,
                                      ),
                                    ],
                                  ),
                                ],

                                /// Day  pass no
                                CommonWidgets.textDisplay(
                                  widget.passId == "1"
                                      ? "Visitor Pass No"
                                      : widget.passId == "2"
                                          ? "Vendor Pass No"
                                          : widget.passId == '3'
                                              ? 'Pass Category'
                                              : Constants.daypassno,
                                  isMandatory: true,
                                  Styles.textStyleBlack14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                GestureDetector(
                                  onTap: () {
                                    if (widget.model == null ||
                                        widget.model?.status == 0) {
                                      if (!isDisabled) {
                                        //daypassNoDialog();
                                        //passnumberaddButtonwidgetLoading(state);
                                        if (widget.passId == '3') {
                                          passCategoryDialog();
                                        } else {
                                          passnumberTypeDialog(state);
                                        }
                                      }
                                    }
                                  },
                                  child: FlutterInputField(
                                      isEnable: false,
                                      isDisableColor: widget.model == null ||
                                              passCategoryTextController
                                                  .text.isEmpty ||
                                              widget.model?.status == 0
                                          ? false
                                          : true,
                                      textFieldController: widget.passId == '3'
                                          ? passCategoryTextController
                                          : daypassnoTextController,
                                      textFormKey: Keys.statusTextController,
                                      hintText: '',
                                      onChange: (String username) {
                                        //this.username = username;
                                        setState(() {});
                                      },
                                      onTap: () {
                                        if (widget.model == null ||
                                            daypassnoTextController
                                                .text.isEmpty ||
                                            widget.model?.status == 0) {
                                          //passnumberaddButtonwidgetLoading(state);
                                          if (widget.passId == '3') {
                                            passCategoryDialog();
                                          } else {
                                            passnumberTypeDialog(state);
                                          }
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
                                            log('suffixIcon pressed');
                                            if (widget.model == null ||
                                                daypassnoTextController
                                                    .text.isEmpty ||
                                                widget.model?.status == 0) {
                                              //passnumberaddButtonwidgetLoading(state);
                                              if (widget.passId == '3') {
                                                passCategoryDialog();
                                              } else {
                                                passnumberTypeDialog(state);
                                              }
                                            }
                                          })),
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Pass Valid From
                                if (widget.passId != '3') ...[
                                  CommonWidgets.textDisplay(
                                      Constants.passvlidfrom,
                                      isMandatory: true,
                                      Styles.textStyleBlack14),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  datepickerWidgetLoading(
                                      passvalidfromTextController),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                ],
                                if (widget.passId == '3') ...[
                                  CommonWidgets.textDisplay(
                                      Constants.passIssuedOn,
                                      isMandatory: true,
                                      Styles.textStyleBlack14),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  datepickerWidgetLoading(
                                      passvalidfromTextController),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                ],

                                /// Pass Valid Until
                                CommonWidgets.textDisplay(
                                    Constants.passvliduntil,
                                    isMandatory: true,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                // datepickerWidgetLoading(
                                //     passvaliduntilTextController),

                                BaseDate().datePickerWidgetLoading(
                                  isDisabled:
                                      widget.model?.status == 0 ? false : true,
                                  showPastDate: false,
                                  textController: passvaliduntilTextController,
                                  onlyDate: (widget.passId == '3' &&
                                          widget.model?.category == 1)
                                      ? true
                                      : false,
                                  onChange: (String value) {
                                    log('--fr-value-${passvaliduntilTextController.text}------');
                                    passvaliduntilTextController.text =
                                        Utils.timestamptoDateConversion(
                                            int.parse(
                                                widget.model?.endTime ?? '0'),
                                            Constants.dateFormat);
                                  },
                                  context: context,
                                ),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Escorted by Host
                                widget.passId == '1'
                                    ? CommonWidgets.textDisplay(
                                        'Escorted by Host',
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    : Container(),
                                widget.passId == '1'
                                    ? radioButtonHandling(
                                        state.escortedbyhost ?? 0,
                                        'Escorted by Host')
                                    : Container(),

                                /// Escorted By
                                (widget.passId == '2' ||
                                            (widget.passId == '1' &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)) &&
                                        widget.model?.companyType?.name
                                                ?.toLowerCase() !=
                                            'cwr t1'
                                    ? CommonWidgets.textDisplay(
                                        state.showIdentifiedFields
                                            ? Constants.identifiedBy
                                            : Constants.escortedby,
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    // :CommonWidgets.textDisplay(
                                    // Constants.identifiedBy,
                                    // isMandatory: true,
                                    // Styles.textStyleBlack14),
                                    : Container(),
                                widget.passId == '2' ||
                                        (widget.passId == '1' &&
                                            (state.escortedbyhost ?? 0) == 0)
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.001)
                                    : Container(),
                                widget.passId == '2' ||
                                        (widget.passId == '1' &&
                                            (state.escortedbyhost ?? 0) == 0)
                                    ? textFieldWidgetLoad(
                                        escortedbyTextController, 0, state)
                                    : Container(),
                                widget.passId == '2' ||
                                        widget.passId == '3' ||
                                        (widget.passId == '1' &&
                                            (state.escortedbyhost ?? 0) == 0)
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.01)
                                    : Container(),

                                /// Escorted By Employee Id
                                widget.passId == '2' ||
                                        (widget.passId == '1' &&
                                            (state.escortedbyhost ?? 0) == 0)
                                    ? CommonWidgets.textDisplay(
                                        state.showIdentifiedFields
                                            ? Constants.identifiedByEmployeeId
                                            : Constants.escortedbyemployeeid,
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    : Container(),
                                widget.passId == '2' ||
                                        (widget.passId == '1' &&
                                            (state.escortedbyhost ?? 0) == 0)
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.001)
                                    : Container(),
                                widget.passId == '2' ||
                                        (widget.passId == '1' &&
                                            (state.escortedbyhost ?? 0) == 0)
                                    ? textFieldWidgetLoad(
                                        escortedemployeedidbyTextController,
                                        0,
                                        state)
                                    : Container(),
                                widget.passId == '2' ||
                                        (widget.passId == '1' &&
                                            (state.escortedbyhost ?? 0) == 0)
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.01)
                                    : Container(),

                                ///upload Photo of Visitor
                                widget.passId == '1' && widget.model == null
                                    ? CommonWidgets.textDisplay(
                                        'Photo of Visitor',
                                        isMandatory: true,
                                        Styles.textStyleBlack14)
                                    : Container(),
                                widget.passId == '1' && widget.model == null
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.001)
                                    : Container(),
                                widget.passId == '1' && widget.model == null
                                    ? uploadWidget(state, true)
                                    : Container(),

                                /// Attachments
                                widget.passId == '1'
                                    ? photogetSpaceattchment(height)
                                    : Container(),
                                widget.passId == '1'
                                    ? photogetAttachement(height)
                                    : Container(),

                                ///upload
                                widget.model == null
                                    ? CommonWidgets.textDisplay(
                                        Constants.evidenceDocuments,
                                        Styles.textStyleBlack14)
                                    : Container(),
                                widget.model == null
                                    ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.001)
                                    : Container(),
                                widget.model == null
                                    ? uploadWidget(state, false)
                                    : Container(),

                                /// Attachments
                                getSpaceattchment(height),
                                getAttachement(height),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                                if(widget.model?.status == 2 )...[
                                /// Pass Collected By
                                CommonWidgets.horizentaltextHandling(
                                    Constants.passCollectedBy,
                                    isMandatory: true,
                                        '${widget.model?.handoverSecurity?.firstName ?? ''} ${widget.model?.handoverSecurity?.lastName ?? ''}',
                                       ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                                  CommonWidgets.textDisplay(
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
                                if (widget.model?.status == null ||
                                    widget.model?.status == 0 ||
                                    widget.model?.status == 1 ||
                                    widget.model?.status == 3) ...[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      cancelButtonDisplay(),
                                      submitButtonDisplay()
                                    ],
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.03),
                                ],
                                // if(widget.model?.status != 0 ||
                                //     widget.model?.status != 1 ||
                                //     widget.model?.status != 2 ||
                                //     widget.model?.status != 3 )
                                // Row(
                                //   mainAxisAlignment:
                                //   MainAxisAlignment.center,
                                //   children: [
                                //     cancelButtonDisplay(),
                                //   ],
                                // ),
                                // CommonWidgets.verticalSpacerWidget(
                                //    height * 0.03),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if ((widget.model?.status == 2 ||
                        widget.model?.status == 4 ||
                        widget.model?.status == 5 ||
                        widget.model?.status == 6 ||
                        widget.model?.status == 7 ||
                        widget.model?.status == 8 ||
                        widget.model?.status == 9)
                    ? true
                    : false) ...[
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: const ShapeDecoration(
                      color: AppColors.backgroundWhitecolor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(00.0)),
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
              ],
            ),
          );
        },
      ),
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  Widget radioButtonHandling(int selectedValue, String name) {
    bool isEditable =
        (widget.model?.status == null || widget.model?.status == 0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: isEditable
              ? AppColors.navigationSkybluecolor
              : AppColors.disabletextfieldBackground,
          focusColor: AppColors.navigationSkybluecolor,
          value: 1,
          groupValue: selectedValue,
          onChanged: isEditable
              ? (val) {
                  selectedValue = 1;
                  createPassMgmtCubit.getRadioButtonSelected(
                      name, selectedValue, "Yes");
                }
              : null,
        ),
        const Text(Constants.yes),
        Radio(
          activeColor: isEditable
              ? AppColors.navigationSkybluecolor
              : AppColors.disabletextfieldBackground,
          value: 0,
          groupValue: selectedValue,
          onChanged: isEditable
              ? (val) {
                  log(name);
                  selectedValue = 0;
                  createPassMgmtCubit.getRadioButtonSelected(
                      name, selectedValue, "No");
                }
              : null,
        ),
        const Text(Constants.no),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      //globalState = CreatePassMgmtState(stateType: CreatePassMgmtStateType.initial);
      populateData();
    } else {
      createPassMgmtCubit.initialization();
    }
    if (widget.passId == '0') {
      passtypeTextController.text = 'DAY_PASS';
    } else if (widget.passId == '1') {
      passtypeTextController.text = 'VISITOR_PASS';
    }
    else if (widget.passId == '2') {
      passtypeTextController.text = 'VENDOR_PASS';
    }
    else if (widget.passId == '3') {
      passtypeTextController.text = 'SEZ_PASS';
    }
    getPassmanagmentList();
    _getCurrentDate();
  }

  initiallyLocationAndSerialNumberDataset(CreatePassMgmtState state) async {
    if (state.location?.id == null &&
        state.getLocationsResponse != null &&
        widget.model == null &&
        (serialnumber ?? '').isEmpty) {
      Organisation location = Organisation(id: 323, name: "SunGard");
      createPassMgmtCubit.getlocationsResponseData(location);
      await createPassMgmtCubit.getSerialnumberDetails(
        '323',
        widget.passId ?? '',
        context,
      );
      await createPassMgmtCubit.getPassNumber(
        widget.passId ?? '',
        '323',
        context,
      );
    }
  }

  populateData() async {
    if (widget.model != null) {
      createPassMgmtCubit.initializeValues(widget.model!);
      if (widget.model?.companyType?.name?.toLowerCase() == 'fte') {
        isFTECompanyNameEditable = false;
      }
      await SharedPrefs.setFoundId(widget.model?.id ?? 0);

      employeeidTextController.text = widget.model?.employeeId != null
          ? widget.model?.employeeId.toString() ?? ""
          : '';
      sezpassinfoTextController.text = widget.model?.passInfo != null
          ? widget.model?.passInfo.toString() ?? ""
          : '';
      companynameTextController.text = widget.model?.companyName != null
          ? widget.model?.companyName.toString() ?? ""
          : '';
      mtpApplicationNoTextController.text = widget.model?.mifareNo != null
          ? widget.model?.mifareNo.toString() ?? ""
          : '';
      escortedemployeedidbyTextController.text =
          widget.model?.escortedEmployeeId != null
              ? widget.model?.escortedEmployeeId.toString() ?? ""
              : '';
      escortedbyTextController.text = widget.model?.escortedByName != null
          ? widget.model?.escortedByName.toString() ?? ""
          : '';
      hostemployeeidTextController.text = widget.model?.hostEmployeeId != null
          ? widget.model?.hostEmployeeId.toString() ?? ""
          : '';
      var userId = await SharedPrefs.getUserId();
      // BaseUser host1 = widget.dayPassItem?.host != null

      hostTextController.text = widget.model?.hostName != null
          ? widget.model?.hostName.toString() ?? ""
          : '';
      log('-widget.model?.host----${widget.model?.host?.userName}----');
      User? host1 = widget.model?.host ??
          User(userId: int.parse(userId), name: hostTextController.text);

      createPassMgmtCubit.gethostanalystsResponseData(host1);
      createPassMgmtCubit.getdbsponsoranalystsResponseData(host1);
      createPassMgmtCubit.gethostUsersResponseData(host1);

      dbsponsorTextController.text = widget.model?.hostName != null
          ? widget.model?.hostName.toString() ?? ""
          : '';
      // BaseUser dbSponsor1 = dbsponsorTextController.text.isNotEmpty
      //     ? BaseUser(id: int.parse(userId), name: dbsponsorTextController.text)
      //     : BaseUser();

      User? dbSponsor1 = widget.model?.host ??
          User(userId: int.parse(userId), name: dbsponsorTextController.text);

      createPassMgmtCubit.getdbsponsorUsersResponseData(dbSponsor1);
      nameTextController.text =
          widget.passId == '1' && widget.model?.employeeName != null
              ? widget.model?.employeeName ?? ''
              : widget.model?.employeeName.toString() ?? '';
      var userid = await SharedPrefs.getUserId();
      BaseUser name1 = nameTextController.text.isNotEmpty
          ? BaseUser(id: int.parse(userid), name: nameTextController.text)
          : BaseUser();
      //createpassmgmtCubit.getnameanalystsResponseData(name1);
      createPassMgmtCubit.getNameUsersResponseData(name1);
      dateofcreationTextController.text =
          widget.model?.inputDate != null && widget.model?.inputDate != '0'
              ? Utils.timestamptoDateConversion(
                  int.parse(widget.model?.inputDate ?? '0'),
                  Constants.fulldateFormat)
              : dateofcreationTextController.text;
      passvalidfromTextController.text =
          widget.model?.startTime != null && widget.model?.startTime != '0'
              ? Utils.timestamptoDateConversion(
                  int.parse(widget.model?.startTime ?? '0'),
                  Constants.fulldateFormat)
              : passvalidfromTextController.text;
      passvaliduntilTextController.text = widget.model?.endTime != null &&
              widget.model?.endTime != '0'
          ? Utils.timestamptoDateConversion(
              int.parse(widget.model?.endTime ?? '0'), Constants.fulldateFormat)
          : passvaliduntilTextController.text;

      passReturnedTextController.text = widget.model?.returnedTime != null &&
          widget.model?.returnedTime != '0'
          ? Utils.timestamptoDateConversion(
          int.parse(widget.model?.returnedTime ?? '0'), Constants.fulldateFormat)
          : passReturnedTextController.text;

      // List<VisitingOfficial>? visitingOfficials = widget.listuser?.visitingOfficials != null ? widget.listuser?.visitingOfficials ?? [] : [];

      statusTextController.text =
          Utils().buildPassManagementStatus(widget.model?.status);

      log('---statusTextController.text--${statusTextController.text}-');
      if (widget.model?.passType == 1) {
        passtypeTextController.text = 'VISITOR_PASS';
      } else if (widget.model?.passType == 5) {
        passtypeTextController.text = 'DWS_VISITOR_PASS';
      } else if (widget.model?.passType == 2) {
        passtypeTextController.text = 'VENDOR_PASS';
      } else if (widget.model?.passType == 6) {
        passtypeTextController.text = 'DWS_VENDOR_PASS';
      } else if (widget.model?.passInfo?.passType == 3) {
        passtypeTextController.text = 'SEZ_PASS';
      }

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
      Organisation location = widget.model?.location != null
          ? Organisation(
              id: widget.model?.location?.id ?? 0,
              name: widget.model?.location?.name ?? "")
          : Organisation();

      serialnumber = widget.model?.slNo != null ? widget.model?.slNo ?? '' : '';

      await createPassMgmtCubit.getSerialnumberDetails(
          (widget.model?.location?.id ?? 0).toString(),
          widget.passId ?? '',
          context);

      createPassMgmtCubit.getlocationsResponseData(location);
      Organisation active = Organisation(
          id: widget.model?.passInfo?.id ?? 0,
          name: widget.model?.passInfo?.passNo ?? '');
      passCategoryTextController.text =
          widget.model?.category == 1 ? 'Temporary' : 'Permanent';
      log('-passCategoryTextController.text----${passCategoryTextController.text}-');

      // daypassnoTextController.text =
      //     widget.dayPassItem?.category.toString() ?? '';

      daypassnoTextController.text = widget.model!.passInfo?.passNo ?? '';
      createPassMgmtCubit.getpassListResponseData(active);
      // await createpassmgmtCubit.getSerialnumberDetails(
      //     (widget.dayPassItem?.location?.id ?? 0).toString(),
      //     'SEZPass',
      //     context);
      createPassMgmtCubit.getPassNumber(
          '0', (widget.model?.location?.id ?? 0).toString(), context);
      createPassMgmtCubit.getlocationsResponseData(location);

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
      createPassMgmtCubit.getdaypassreasonResponseData(day);

      Organisation dep = widget.model?.department ?? Organisation();
      createPassMgmtCubit.selectedEmployeeDepartment(dep);
      getAttachments = widget.model?.evidenceDocuments != null
          ? widget.model?.evidenceDocuments ?? []
          : [];
      // photogetAttachments =
      //     widget.model?.visitorImage != null ? widget.model?.visitorImage ?? [] : [];

      emailTextController.text = widget.model?.email ?? '';
      purposeofvisitTextController.text = widget.model?.visitingPurpose ?? '';
      mtpApplicationNoTextController.text = widget.model?.mifareNo ?? '';
      visitorcomingfromTextController.text =
          widget.model?.visitorComingFrom ?? '';
      contactnoTextController.text = widget.model?.contactNo ?? '';
      employeeidTextController.text = widget.model?.employeeId ?? '';
      sezpassinfoTextController.text = widget.model?.passNo ?? '';
      //sezpassinfoTextController.text = widget.model?.passNo ?? '';
      dbsponsorTextController.text = widget.model?.hostEmployeeId ?? '';
    }
  }

  getPassmanagmentList() async {
    await createPassMgmtCubit.getLocations('ATOM_LOCATIONS', context);
    await createPassMgmtCubit.getEntities('ATOM_ENTITIES', context);
    await createPassMgmtCubit.getEmployeeDepartments(
        'EMPLOYEE_DEPARTMENTS', context);
    if (widget.model == null ||
        (widget.model?.entrySecurity?.userName ?? '').isEmpty) {
      var userid = await SharedPrefs.getUserId();
      await createPassMgmtCubit.getUserDetails(userid, context);
    } else {
      createdBy = widget.model?.entrySecurity?.userName ?? '';
    }
    await createPassMgmtCubit.companyTypes('ATOM_COMPANY_TYPES', context);
    await createPassMgmtCubit.getDayPassreasons('DAY_PASS_REASON', context);
    await createPassMgmtCubit.getVendorPassreasons(
        'VENDOR_PASS_REASON', context);
    //await createpassmgmtCubit.getAnalysts('T1_Analyst');
    await createPassMgmtCubit.getUserByRoleDepositor(
        'ATOM_STATIC_USER', context);
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
      // Customize the button properties as needed
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        updateRecordStatus();
      },
    );
  }

  void updateRecordStatus() {
    if (widget.model?.id != null ) {
      BlocProvider.of<CreatePassMgmtCubit>(context)
          .updateStatus(id: widget.model!.id.toString());
      Navigator.popAndPushNamed(
        context,
        daypassmanagementListRoute,
      );
    }  else {
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

  passTypeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomSimpleListTexts(
              texts: widget.passId == "1" && (widget.model?.status == 0 || widget.model?.status == null)
                  ? ["VISITOR_PASS"]
                  : widget.passId == "1"
                  ? ["VISITOR_PASS", "DWS_VISITOR_PASS"]
                  : widget.passId == "2" && (widget.model?.status == 0 || widget.model?.status == null)
                  ? ["VENDOR_PASS"]
                  : widget.passId == "2"
                  ? ["VENDOR_PASS", "DWS_VENDOR_PASS"]
                  : widget.passId == "0" && (widget.model?.status == 0 || widget.model?.status == null)
                  ? ["DAY_PASS"]
                  : widget.passId == "0"
                  ? ["DAY_PASS", "DWS_DAY_PASS"]
                  : widget.passId == "3" && (widget.model?.status == 0 || widget.model?.status == null)
                  ? ["SEZ_PASS"]
                  : ["SEZ_PASS", "DWS_SEZ_PASS"],
              onTap: (String value) {
              log(value);
              passtypeTextController.text = value;
            },
          );
        });
  }

  updatestausTypeDialog() {
    log('----updatestausTypeDialog-');

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomSimpleListTexts(
            texts: statusTextController.text.toLowerCase() == "created"
                ? ["cancelled"]
                : [
                    "returned",
                    "lost",
                    "damaged",
                    "defaced",
                    "returned damaged",
                    "returned defaced"
                  ],
            onTap: (String value) {
              log(value);
              updateStatusTextController.text = value;
              setState(() {});
            },
          );
        });
  }

  passCategoryDialog() {
    // BaseDropDown().getDropDown(
    //     isDisabled: false,
    //     textController: daypassnoTextController,
    //     items: categoryValues,
    //     initialValue: daypassnoTextController.text,
    //     onTap: () {
    //       BaseDropDown().assetTypeDialog(
    //           context: context,
    //           dropDownValues: categoryValues
    //               .map((label) => label.key)
    //               .toList(),
    //           onTap: (String value) {
    //             Label? selectedLabel;
    //             selectedLabel = categoryValues.firstWhere(
    //               (label) => label.key == value,
    //               orElse: () => const Label(key: '', value: ''),
    //             );
    //
    //             daypassnoTextController.text = selectedLabel.value;
    //           });
    //     });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomSimpleListTexts(
          texts: widget.passId == "3"
              ? ["Permanent", "Temporary"]
              // : widget.passId == "2"
              //     ? ["VENDOR_PASS", "DWS_VENDOR_PASS"]
              : [],
          onTap: (String value) {
            log(value);
            passCategoryTextController.text = value;

            final currentDate = DateTime.now();
            if (value.equalsIgnoreCase('Permanent')) {
              String nextFormattedDate = DateFormat(Constants.dateFormat)
                  .format(currentDate.add(const Duration(days: 1189)));
              passvaliduntilTextController.text = nextFormattedDate;
              companynameTextController.text = "Deutsche Bank";
              isFTECompanyNameEditable = false;
            } else {
              final currentDate = DateTime.now();
              String nextformattedDate = DateFormat(Constants.fulldateFormat)
                  .format(currentDate.add(const Duration(hours: 12)));
              passvaliduntilTextController.text = nextformattedDate;
              companynameTextController.text =
                  widget.model?.companyName.toString() ?? "";
              isFTECompanyNameEditable = true;
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
          widget.model?.status != 0 && widget.model != null ? true : false,
      onTap: () {
        if (widget.model == null || widget.model?.status == 0) {
          //  articleTypeDialog(state);
          departmentsDialog(state);
        }
      },
    );
  }

//   Widget reasonforadaypassaddButtonwidgetLoading(CreatePassMgmtState state) {
//     log('-state.dayPasselementReason?.name---${state.dayPasselementReason?.name}-');
//     log('-state.vendorPasselementReason?.name---${state.vendorPasselementReason?.name}--');
// log('exceptional --- $Column');
//     return TextfieldAddButton(
//       title: widget.passId == '0'
//           ? state.dayPasselementReason?.name ?? ''
//           : state.vendorPasselementReason?.name ?? '',
//       height: 60,
//       isDisableColor: widget.model?.status != 0 && widget.model != null ? true : false,
//       onTap: () {
//         if (widget.model == null || widget.model?.status == 0) {
//           if (widget.passId == '2') {
//             vendorPassReasonDialog(state);
//           } else if (widget.passId == '0') {
//             reasondaypassDialog(state);
//
//             // Check if the selected dayPassReason is 'external auditors' or 'external regulators'
//             if (widget.model?.dayPassReason?.name?.toLowerCase() == 'external auditors' || widget.model?.dayPassReason?.name?.toLowerCase() == 'external regulators') {
//               return Column(
//                 children: [
//                   CommonWidgets.textDisplay(
//                     Constants.exceptionalApproval,
//                     isMandatory: true,
//                     Styles.textStyleBlack14,
//                   ),
//                   radioButtonHandling(
//                     state.exceptionalApproval ?? 1,
//                     Constants.exceptionalApproval,
//                   ),
//                 ],
//               );
//             }
//           }
//         }
//       },
//     );
//   }

  Widget reasonforadaypassaddButtonwidgetLoading(CreatePassMgmtState state) {
    log('-state.dayPasselementReason?.name---${state.dayPasselementReason?.name}-');
    log('-state.vendorPasselementReason?.name---${state.vendorPasselementReason?.name}--');
    return Column(
      children: [
        TextFieldAddButton(
          title: widget.passId == '0'
              ? state.dayPasselementReason?.name ?? ''
              : state.vendorPasselementReason?.name ?? '',
          height: 60,
          isDisableColor:
              widget.model?.status != 0 && widget.model != null ? true : false,
          onTap: () {
            if (widget.model == null || widget.model?.status == 0) {
              if (widget.passId == '2') {
                vendorPassReasonDialog(state);
              } else if (widget.passId == '0') {
                reasondaypassDialog(state);
              }
            }
          },
        ),
      ],
    );
  }

  Widget datepickerWidgetLoading(TextEditingController textfiled) {
    return GestureDetector(
      onTap: () {
        // if (widget.listuser == null || textfiled.text.isEmpty) {
        //   datePickerDialog(textfiled);
        // }
      },
      child: FlutterInputField(
        textFieldController: textfiled,
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
              datePickerDialog(textfiled);
            }
            DateTime? pickedDate = await showDateTimePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));
            String formattedDate = DateFormat(Constants.fulldateFormat)
                .format(pickedDate ?? DateTime.now());
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              AppIcon.calendaricon,
              color: AppColors.textgreyThemecolor,
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
    if (textfield == passvalidfromTextController) {
      passvalidfromTextController.text = formattedDate;
    }
    // setState(() {
    //   // dateinput.text = formattedDate; //set output date to TextField value.
    // });
  }

  // String _getCurrentDates() {
  //   return DateFormat(Constants.fulldateFormat).format(DateTime.now());
  // }

  void _getCurrentDate() {
    final currentDate = DateTime.now();
    String formattedDate =
        DateFormat(Constants.fulldateFormat).format(currentDate);
    log(formattedDate);
    String nextformattedDate = DateFormat(Constants.fulldateFormat)
        .format(currentDate.add(const Duration(hours: 12)));
    dateofcreationTextController.text = formattedDate;
    passReturnedTextController.text=formattedDate;
    passvalidfromTextController.text = formattedDate;
    passvaliduntilTextController.text = nextformattedDate;
    if (widget.model == null) {
      statusTextController.text = 'created';
    }
  }

  Widget uploadWidget(CreatePassMgmtState state, bool isPhotoType) {
    return // upload
        widget.model == null
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
                        backgroundColor: AppColors.navigationSkybluecolor,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return UploadAttachment(
                                userdetails: state.getUserDetailsResponse,
                                getFiles: isPhotoType
                                    ? photogetFiles ?? []
                                    : getFiles ?? [],
                                createpassmgmtstate: state,
                                isPhotoType: isPhotoType,
                              );
                            });
                      },

                      icon: SvgPicture.asset(
                        //AppIcon.dropdownicon,
                        AppIcon.uploadicon,
                        //fit: BoxFit.,
                        color: AppColors.backgroundWhitecolor,
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

  Widget getAttachement(double height) {
    return (getAttachments.isEmpty || widget.model == null)
        ? getFiles.isEmpty
            ? Container()
            : attachmentListviews(getFiles, getAttachments)
        : attachmentListviews(getFiles, getAttachments);
  }

  Widget photogetSpaceattchment(double height) {
    return photogetFiles.isNotEmpty || photogetAttachments.isNotEmpty
        ? CommonWidgets.verticalSpacerWidget(height * 0.01)
        : Container();
  }

  // Widget photogetAttachement(double height) {
  //   return (photogetAttachments.isEmpty || widget.model == null)
  //       ? photogetFiles.isEmpty
  //           ? Container()
  //           : attachmentListviews(photogetFiles, photogetAttachments)
  //       : attachmentListviews(photogetFiles, photogetAttachments);
  // }
  Widget photogetAttachement(double height) {
    return (photogetAttachments.isNotEmpty || photogetFiles.isNotEmpty)
        ? attachmentListviews(photogetFiles, photogetAttachments)
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
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddEmployeeDepartment(
                      title: Constants.addemployeedepartment,
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
      isDisableColor:
          widget.model?.status != 0 && widget.model != null ? true : false,
      onTap: () {
        if (widget.model == null || widget.model?.status == 0) {
          companyTypeDialog(state);
        }
      },
    );
  }

  companyTypeDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateatomCompanyTypes:
                state.companyTypes?.atomCompanyTypes ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddNewFields(
                        title: Constants.addcompanytype,
                        createpassmgmtstate: state);
                  });
            },
            onTap: (Organisation organisation) {
              //log(list.name);
              // isEditable = true;
              companynameTextController.text = "";
              if ((organisation.name ?? '').toLowerCase() == 'fte') {
                companynameTextController.text = "Deutsche Bank";
                isFTECompanyNameEditable = false;
              }
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
            leftImageName: widget.passId == '0' || widget.passId == '2'
                ? AppIcon.addicon
                : null,
            onLeftButtonTap: () {
              if (widget.passId == '0' || widget.passId == '2') {
                Navigator.pop(context);
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AddNewFields(
                        title: widget.passId == '0'
                            ? Constants.addreasonfordaypass
                            : Constants.addreasonforvendorpass,
                        createpassmgmtstate: state,
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
              createPassMgmtCubit.getdaypassreasonResponseData(organisation);
            },
          );
        });
  }

  vendorPassReasonDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicatedayPassReason:
                state.vendorPassReason?.vendorPassReason ?? [],
            leftImageName: widget.passId == '2' ? AppIcon.addicon : null,
            onLeftButtonTap: () {
              if (widget.passId == '2') {
                Navigator.pop(context);
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AddNewFields(
                        title: widget.passId == '2'
                            ? Constants.addreasonforvendorpass
                            : Constants.addreasonforvendorpass,
                        createpassmgmtstate: state,
                      );
                    });
              }
            },
            onTap: (Organisation list) {
              //log(list.name);
              createPassMgmtCubit.getVendorPassReasonResponseData(list);
            },
          );
        });
  }

  Widget nameaddButtonwidgetLoading(CreatePassMgmtState state) {
    return TextFieldAddButton(
      title: state.nameResponse?.name ?? '', //state.t1nameanalyst?.name ?? '',
      height: 60,
      isDisableColor:
          widget.model?.status != 0 || widget.model != null ? false : true,
      onTap: () {
        if (widget.model == null ||
            (state.nameResponse != null &&
                ((state.nameResponse?.name ?? '').isEmpty))) {
          //   articleTypeDialog(state);
          // leodepartmentsDialog(state, 0);
          nameTypeDialog(state);
        }
      },
    );
  }

  nameTypeDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            //duplicatet1Analyst: state.analyst?.t1Analyst ?? [],
            duplicateDepostorList:
                state.getDepositorResponse?.atomStaticUser ?? [],
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

  Widget hostaddButtonwidgetLoading(CreatePassMgmtState state) {
    return TextFieldAddButton(
      title: state.hostResponse?.name, //state.t1hostanalyst?.name ?? '',
      height: 60,
      isDisableColor: widget.model?.status == 0 || widget.model?.status == null
          ? false
          : true,
      onTap: () {
        if (widget.model?.status == 0 || widget.model?.status == null) {
          hostTypeDialog(state);
        }
      },
    );
  }

  hostTypeDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateDepostorList: state.getDepositorResponse?.atomStaticUser ??
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
                    );
                  });
            },
            onTap: (BaseUser baseUser) {
              //log(list.name);

              createPassMgmtCubit.gethostUsersResponseData(
                  User(userId: baseUser.id, name: baseUser.name));
            },
          );
        });
  }

  Widget dbsponsoraddButtonwidgetLoading(CreatePassMgmtState state) {
    return TextFieldAddButton(
      title: state.dbsponsorResponse?.name ?? '',
      height: 60,
      isDisableColor:
          widget.model?.status != 0 && widget.model != null ? true : false,
      onTap: () {
        if (widget.model == null || widget.model?.status == 0) {
          dbsponsorTypeDialog(state);
        }
      },
    );
  }

  dbsponsorTypeDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            //duplicatet1Analyst:
            duplicateDepostorList: state.getDepositorResponse?.atomStaticUser ??
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
                    );
                  });
            },
            onTap: (BaseUser baseUser) {
              //log(list.name);
              //dbsponsorTextController.text = list.name??'';
              createPassMgmtCubit.getdbsponsorUsersResponseData(
                  User(userId: baseUser.id, name: baseUser.name));
            },
          );
        });
  }

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
  passnumberTypeDialog(CreatePassMgmtState state) {
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
              //log(list.name);
              daypassnoTextController.text = organisation.name ?? '';
              createPassMgmtCubit.getpassListResponseData(organisation);
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

  Widget locationWidgetdislay(CreatePassMgmtState state) {
    return GestureDetector(
      onTap: () {
        if (widget.model?.status == 0 || widget.model?.status == null) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              // log(state.getLocationsResponse);
              return CustomExpansionListTexts(
                locationList: state.getLocationsResponse,
                //GetLocations(),
                onTap: (Organisation? org) async {
                  await createPassMgmtCubit.getSerialnumberDetails(
                    org?.id.toString() ?? '',
                    widget.passId ?? '',
                    context,
                  );

                  createPassMgmtCubit.getPassNumber(
                      widget.passId ?? '0', org?.id.toString() ?? '', context);
                  createPassMgmtCubit.getlocationsResponseData(org);
                  daypassnoTextController.text = '';
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
                              AppColors.normaltextBackground),
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

  // Widget locationWidgetdislay(CreatePassMgmtState state) {
  //   return GestureDetector(
  //     onTap: () {
  //       // if (widget.occurrence == null ||
  //       //     (state.occurrence.location?.name ?? '').isEmpty)
  //       //     {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext dialogContext) {
  //           // log(state.getLocationsResponse);
  //           return CustomExpansionListTexts(
  //             getLocationsresponse: state.locations,
  //             onTap: (Organisation? list) async {
  //               log('list?.name-----${list?.name}');
  //
  //               Organisation location = Organisation();
  //               location.id = list?.id;
  //               location.name = list?.name;
  //               state?.location = location;
  //
  //               BlocProvider.of<CreatePassMgmtCubit>(context)
  //                   .updateDropdownValues(location: location);
  //             },
  //           );
  //         },
  //       );
  //       // }
  //     },
  //     child: SelectedTileValueWidget(name: state.location?.name ?? ''),
  //   );
  // }
  Future submitForm(
      bool isSubmit, int isFoundId, CreatePassMgmtState state) async {
    if (widget.passId == '0') {
      if (daypassnoTextController.text.isEmptyOrNull) {
        Validator().showToast(
          context,
          "Please enter Day Pass Number",
        );
        return;
      }
    }
    if (widget.passId == '3') {
      if (sezpassinfoTextController.text.isEmptyOrNull) {
        Validator().showToast(
          context,
          "Please enter Sez Pass Info",
        );
        return;
      }
    }

    if (widget.passId == '1' || widget.passId == '2') {
      if (daypassnoTextController.text.isEmptyOrNull) {
        Validator().showToast(
          context,
          "Please enter Visitor Pass No",
        );
        return;
      }
    }

    if (widget.passId == '2') {
      if (state.vendorPassInfo == null) {
        Validator().showToast(
          context,
          "Vendor Pass No",
        );
        return;
      }
    }

    PassInfo passInfo = widget.model?.passInfo ?? PassInfo();
    // switch (passtypeTextController.text) {
    //   case 'DAY_PASS':
    //     passInfo.passType = 0;
    //     break;
    //   case 'VISITOR_PASS':
    //     passInfo.passType = 1;
    //     break;
    //   case 'VENDOR_PASS':
    //     passInfo.passType = 2;
    //     break;
    //   case 'SEZ_PASS':
    //     passInfo.passType = 3;
    //     break;
    //   default:
    //     passInfo.passType = 0;
    //     break;
    // }
    passInfo.passType = widget.passId.toIntOrNull();

    if (widget.passId == '3') {
      passInfo.passNo = sezpassinfoTextController.text;
    } else {
      passInfo.passNo = daypassnoTextController.text;
    }
    passInfo.mifareNo = mtpApplicationNoTextController.text;
    log('-passtypeTextController-----${passtypeTextController.text}----');
    log('-sezpassinfoTextController-----${sezpassinfoTextController.text}----');
    log('-mtpApplicationNoTextController-----${mtpApplicationNoTextController.text}----');
    log('-passCategoryTextController111-----${passCategoryTextController.text}----');

    int passvalidfromdate = (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    int passReturnedOn = (DateTime.now().millisecondsSinceEpoch ~/ 1000);

    int passValidUntilDate =
        (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 12 * 3600; //Add

    int passValidUntilDatePermanent =
        ((DateTime.now().millisecondsSinceEpoch ~/ 1000) +
            24 * 3600 * 1227); //Adding 1227 days

    int inputdate = (DateTime.now().millisecondsSinceEpoch ~/ 1000);

    String dateString = passvaliduntilTextController.text;
    log('--dateString---$dateString----');

    //  DateTime dateTime = DateTime.parse(
    //      "${dateString.split("-")[0]}-${dateString.split("-")[1]}-${dateString.split("-")[2]}");
    // int passValidUntilDate = dateTime.millisecondsSinceEpoch ~/ 1000;

    int statusValue = 0;

    if (statusTextController.text.toLowerCase() == "created") {
      statusValue = 0;
    } else if (statusTextController.text.toLowerCase() == "handed over") {
      statusValue = 1;
    } else if (statusTextController.text.toLowerCase() == "returned") {
      statusValue = 2;
    } else if (statusTextController.text.toLowerCase() == "non returned") {
      statusValue = 3;
    } else if (statusTextController.text.toLowerCase() == "lost") {
      statusValue = 4;
    } else if (statusTextController.text.toLowerCase() == "damaged") {
      statusValue = 5;
    } else if (statusTextController.text.toLowerCase() == "defaced") {
      statusValue = 6;
    } else if (statusTextController.text.toLowerCase() == "cancelled") {
      statusValue = 7;
    } else if (statusTextController.text.toLowerCase() == "returned damaged") {
      statusValue = 8;
    } else if (statusTextController.text.toLowerCase() == "returned defaced") {
      statusValue = 9;
    } else {
      statusValue = 1;
    }

    int updatestatusvalue = 0;
    if (updateStatusTextController.text.toLowerCase() == "returned") {
      updatestatusvalue = 2;
    } else if (updateStatusTextController.text.toLowerCase() == "lost") {
      updatestatusvalue = 4;
    } else if (updateStatusTextController.text.toLowerCase() == "damaged") {
      updatestatusvalue = 5;
    } else if (updateStatusTextController.text.toLowerCase() == "defaced") {
      updatestatusvalue = 6;
    } else if (updateStatusTextController.text.toLowerCase() == "cancelled") {
      updatestatusvalue = 7;
    } else if (updateStatusTextController.text.toLowerCase() ==
        "returned damaged") {
      updatestatusvalue = 8;
    } else if (updateStatusTextController.text.toLowerCase() ==
        "returned defaced") {
      updatestatusvalue = 9;
    } else {
      updatestatusvalue = 1;
    }

    log('-state.selectedEntities?.length--${state.selectedEntities?.length}---');
    List<Organisation>? entities = state.selectedEntities;
    // if ((state.selectedEntities?.length ?? 0) > 0) {
    //   for (int i = 0; i < state.selectedEntities!.length; i++) {
    //     Organisation entity = state.selectedEntities![i];
    //     // Organisation addentiity = Organisation(id: entity.id ?? 1);
    //     entities.add(entity);
    //   }
    // }
    Organisation? location = Organisation(
        id: (state.location?.id == 0) ? 1 : state.location?.id ?? 1,
        name: state.location?.name ?? '');

    // Organisation? companyType = widget.model?.companyType;
    log('--state.locationSelectedlist?.id--${state.location?.id}----');
    Organisation? locationRegion = Organisation(
        id: (state.location?.id == 0) ? 1 : state.location?.id ?? 1,
        name: state.location?.name ?? '');

    // Organisation? dept2 = widget.model?.department;
    PassInfo info;

    log('widget.passId------------${widget.passId}');
    passInfo.passNo = passInfo.passNo;
    if (widget.passId == "3") {
      info = passInfo;
    } else {
      info = PassInfo(
          passType: passInfo.passType,
          id: (state.vendorPassInfo?.id == 0)
              ? 1
              : state.vendorPassInfo?.id ?? ((widget.passId == "3") ? 9151 : 3),
          //9151 //int.parse(sezpassinfoTextController.text ?? '1')
          passNo: sezpassinfoTextController.text,
          mifareNo: mtpApplicationNoTextController.text);
    }

    // createpassmgmtCubit.gethostanalystsResponseData(host1);
    // createpassmgmtCubit.getdbsponsoranalystsResponseData(host1);
    // createpassmgmtCubit.gethostUsersResponseData(host1);

    User? host2 = state.hostResponse;
    //userName: state.hostResponse?.userName ?? '');

    User? dbSponsor = state.dbsponsorResponse;

    // Organisation? companyType = widget.model?.companyType;
    // log('--state.locationSelectedlist?.id--${state.location?.id}----');
    Organisation? companyType =
        state.selectedCompanyType ?? widget.model?.companyType;

    log('-state.selectedCompanyType.id--${state.selectedCompanyType?.id}---');
    log('-companyType--${companyType?.id}---');
    Organisation? department =
        state.selectedDepartment ?? widget.model?.department;
    Organisation? dayPass =
        state.dayPasselementReason ?? widget.model?.dayPassReason;

    // int passTypeIdentify;
    // if (passtypeTextController.text == "VISITOR_PASS") {
    //   passTypeIdentify = 1;
    // } else if (passtypeTextController.text == "DWS_VISITOR_PASS") {
    //   passTypeIdentify = 5;
    // } else if (passtypeTextController.text == "VENDOR_PASS") {
    //   passTypeIdentify = 2;
    // } else if (passtypeTextController.text == "DWS_VENDOR_PASS") {
    //   passTypeIdentify = 6;
    // } else if (passtypeTextController.text == "SEZ_PASS") {
    //   passInfo.passType = 3;
    // } else if (passtypeTextController.text == "DAY_PASS") {
    //   passTypeIdentify = 0;
    // } else if (passtypeTextController.text == "DWS_DAY_PASS") {
    //   passTypeIdentify = 4;
    // }

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
    int category = 0;
    if (passCategoryTextController.text == "Permanent") {
      category = 0;
    } else if (passCategoryTextController.text == "Temporary") {
      category = 1;
    }

    List<ImageContent>? evidenceDocuments = getFiles;
    List<ImageContent>? photoImages = photogetFiles;
    User? entrySecurity = widget.model?.entrySecurity ??
        User(userId: state.getUserDetailsResponse?.userId ?? 1);
    User? handoverSecurity = widget.model?.handoverSecurity ??
        User(userId: state.getUserDetailsResponse?.userId ?? 1);
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
    //Organisation? dayPass = widget.model?.dayPassReason;
    PassManagement? passmgmtbody;
    log('--pass info id--${passInfo.id}---');
    if (widget.model != null) {
      log('--passinfo type--${passInfo.passType}--------');
      passmgmtbody = PassManagement(
        id: isFoundId,
        updatedStatus: (statusTextController.text.toLowerCase() == "created" ||
                statusTextController.text.toLowerCase() == "handed over")
            ? updatestatusvalue
            : null,
        inputDate: inputdate.toString(),
        slNo: serialnumber ?? '',
        location: location,
        status: statusValue,
        locationRegion: widget.model?.locationRegion,
        companyName: companynameTextController.text,
        employeeName: state.nameResponse?.name == null
            ? (nameTextController.text)
            : state.nameResponse?.name ?? '',
        employeeId: employeeidTextController.text,
        passType: passInfo.passType,
        //int.parse(widget.passId ?? '0'),
        passNo: widget.passId == '3'
            ? daypassnoTextController.text
            : state.dayPasselementReason?.name ?? '',
        escortedBy: escortedbyTextController.text,
        escortedEmployeeId: escortedemployeedidbyTextController.text,
        hostEmployeeId: hostemployeeidTextController.text.isNotEmpty
            ? hostemployeeidTextController.text
            : dbsponsorTextController.text,
        mifareNo: mtpApplicationNoTextController.text,
        passIssuedOn: passvalidfromdate.toString(),
        endTime: widget.passId == '3' && widget.model?.category == 0
            ? passValidUntilDatePermanent.toString()
            : passValidUntilDate.toString(),
        startTime: passvalidfromdate.toString(),
        returnedTime: passReturnedOn.toString(),
        hostName: dbsponsorTextController.text.isEmpty
            ? state.hostResponse?.name ?? ''
            : state.dbsponsorResponse?.name ?? '',
        companyType: companyType,
        evidenceDocuments: evidenceDocuments,
        entities: entities,
        department: department,
        passInfo: passInfo,
        host: dbsponsorTextController.text.isEmpty ? host2 : dbSponsor,
        email: emailTextController.text,
        contactNo: contactnoTextController.text,
        visitingDepartment: department,
        visitorName: nameTextController.text,
        visitorImage: photoImages,
        visitorComingFrom: visitorcomingfromTextController.text,
        visitingPurpose: purposeofvisitTextController.text,
        escortedByHost: state.escortedbyhost == 0 ? true : false,
        exceptionalApproval: state.exceptionalApproval == 0 ? true : false,
        idValidationType: idValidationType,
        //mifareNo: mtpapplicationnoTextController.text ?? '',
        category: category,
        dayPassReason: dayPass,
        entrySecurity: entrySecurity,
        handoverSecurity: handoverSecurity,
        handOverSecurityName: '${handoverSecurity.firstName ?? ''} ${handoverSecurity.lastName ?? ''}',
        entrySecurityName:
            '${entrySecurity.firstName ?? ''} ${entrySecurity.lastName ?? ''}',
      );
    } else {
      log('--passinfo type--333----${passInfo.passType}--------');
      passmgmtbody = PassManagement(
          // id: isFoundId ?? 0,
          inputDate: inputdate.toString(),
          slNo: serialnumber ?? '',
          location: location,
          status: statusValue,
          locationRegion: locationRegion,
          companyName: companynameTextController.text,
          employeeName: state.nameResponse?.name == null
              ? (nameTextController.text)
              : state.nameResponse?.name ?? '',
          employeeId: employeeidTextController.text,
          passType: passInfo.passType,
          //0,
          passNo: widget.passId == '3'
              ? daypassnoTextController.text
              : state.dayPasselementReason?.name ?? '',
          escortedBy: escortedbyTextController.text,
          escortedEmployeeId: escortedemployeedidbyTextController.text,
          mifareNo: mtpApplicationNoTextController.text,
          hostEmployeeId: hostemployeeidTextController.text.isNotEmpty
              ? hostemployeeidTextController.text
              : dbsponsorTextController.text,
          passIssuedOn: passvalidfromdate.toString(),
          endTime: widget.passId == '3' && widget.model?.category == 0
              ? passValidUntilDatePermanent.toString()
              : passValidUntilDate.toString(),
          startTime: passvalidfromdate.toString(),
          returnedTime: passReturnedOn.toString(),
          hostName: dbsponsorTextController.text.isEmpty
              ? state.hostResponse?.name ?? ''
              : state.dbsponsorResponse?.name ?? '',
          companyType: companyType,
          evidenceDocuments: evidenceDocuments,
          entities: entities,
          department: department,
          passInfo: info,
          host: dbsponsorTextController.text.isEmpty ? host2 : dbSponsor,
          contactNo: contactnoTextController.text,
          visitingDepartment: department,
          visitorName: nameTextController.text,
          visitorImage: photoImages,
          visitorComingFrom: visitorcomingfromTextController.text,
          visitingPurpose: purposeofvisitTextController.text,
          escortedByHost: state.escortedbyhost == 0 ? true : false,
          exceptionalApproval: state.exceptionalApproval == 0 ? true : false,
          idValidationType: idValidationType,
          // mifareNo: mtpapplicationnoTextController.text ?? '',
          category: category,
          dayPassReason: dayPass,
          email: emailTextController.text,
          entrySecurity: entrySecurity,
      handoverSecurity: handoverSecurity);
    }
    showLoadingDialog(context);
    var username = await SharedPrefs.getUsername();
    CreatePassMgmtBody body = CreatePassMgmtBody(passManagement: passmgmtbody);
    createPassMgmtCubit.createPass(body, isSubmit, context, username,
        widget.model != null ? widget.title ?? '' : widget.title ?? '');
    String userid = await SharedPrefs.getUserId();
    await dayPassListCubit.getList(
        pageNumber.toString(), '20', userid, '${widget.passId}', context);
  }

  passValidations(BuildContext context, CreatePassMgmtState state) {
    if (statusTextController.text.isEmpty &&
        state.getUserDetailsResponse == null &&
        state.location == null &&
        dateofcreationTextController.text.isEmpty &&
        serialnumber == null &&
        state.selectedEntities == null &&
        passvalidfromTextController.text.isEmpty &&
        passvaliduntilTextController.text.isEmpty &&
        escortedemployeedidbyTextController.text.isEmpty &&
        mtpApplicationNoTextController.text.isEmpty &&
        escortedbyTextController.text.isEmpty &&
        passtypeTextController.text.isEmpty &&
        state.selectedDepartment == null &&
        state.selectedCompanyType == null &&
        state.dayPasselementReason == null) {
      Validator().showToast(
        context,
        "Please fill all required fields",
      );
      //}
      // else if (state.getUserDetailsResponse != null &&
      //     (state.getUserDetailsResponse?.firstName ?? '').isEmpty &&
      //     (state.getUserDetailsResponse?.lastName ?? '').isEmpty) {
      //   Validator().showToast(
      //     context,
      //     "Please enter creator name",
      //   );
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
        "Please enter entitiy",
      );
    } else if ((widget.passId == '0' || widget.passId == '3') &&
        state.selectedCompanyType?.name == null) {
      Validator().showToast(
        context,
        "Please enter company type",
      );
    } else if ((widget.passId == '0' || widget.passId == '3') &&
        companynameTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter company name",
      );
    } else if ((widget.passId == '0' &&
        (state.selectedCompanyType?.name ?? '').toLowerCase() == 'fte' &&
        (state.nameResponse?.name ?? '').isEmpty)) {
      Validator().showToast(
        context,
        "Please enter name",
      );
    } else if ((widget.passId == '0' &&
            (state.selectedCompanyType?.name ?? '').toLowerCase() != 'fte') &&
        nameTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter name",
      );
    } else if ((widget.passId == '1' || widget.passId == '2') &&
        nameTextController.text.isEmpty) {
      Validator().showToast(
        context,
        widget.passId == '2'
            ? "Please enter vendor name"
            : "Please enter visitor name",
      );
    } else if ((widget.passId == '1' || widget.passId == '2') &&
        contactnoTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter contact no",
      );
    } else if ((widget.passId == '1' || widget.passId == '2') &&
        contactnoTextController.text.length != 10) {
      Validator().showToast(
        context,
        "Please enter valid contact no",
      );
    } else if (widget.passId == '1' &&
        visitorcomingfromTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter visit coming from",
      );
    } else if (widget.passId == '1' &&
        photofidentityextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter photo identify type",
      );
    } else if (widget.passId == '1' &&
        purposeofvisitTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter purpose of visit",
      );
    } else if (widget.passId == '0' &&
        (state.selectedCompanyType?.name ?? '').toLowerCase() != 'exceptions' &&
        employeeidTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter Employee id",
      );
    } else if (widget.passId == '3' && employeeidTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter Employee id",
      );
    } else if ((widget.passId == '0' &&
        (state.selectedCompanyType?.name ?? '').toLowerCase() == 'cwr t1' &&
        emailTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter email",
      );
    } else if ((widget.passId == '3' && emailTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter email",
      );
    } else if ((widget.passId == '3' &&
        sezpassinfoTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter SEZ pass info",
      );
    } else if ((widget.passId == '3' &&
        mtpApplicationNoTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter MTP application no",
      );
    } else if ((widget.passId == '0' ||
            widget.passId == '1' ||
            widget.passId == '2') &&
        ((state.selectedCompanyType?.name ?? '').toLowerCase() ==
                'exceptions' &&
            hostemployeeidTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter host",
      );
    } else if ((widget.passId == '0' ||
            widget.passId == '1' ||
            widget.passId == '2') &&
        ((state.selectedCompanyType?.name ?? '').toLowerCase() ==
                'exceptions' &&
            hostemployeeidTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter host employeed id",
      );
    }
    // else if ((widget.passId == '1' ||
    //         widget.passId == '2' ||
    //         widget.passId == '3') &&
    //     (state.hostResponse?.name ?? '').isEmpty  && state.companyTypes == 'Exception') {
    //   Validator().showToast(
    //     context,
    //     "Please enter host",
    //   );
    // } else if ((widget.passId == '1' ||
    //         widget.passId == '2' ||
    //         widget.passId == '3') &&
    //     hostemployeeidTextController.text.isEmpty) {
    //   Validator().showToast(
    //     context,
    //     "Please enter host employeed id",
    //   );
    // }
    else if ((widget.passId == '0' &&
        (state.selectedDepartment == null ||
            (state.selectedDepartment?.name ?? '').isEmpty))) {
      Validator().showToast(
        context,
        "Please enter department",
      );
    } else if (((widget.passId == '1' || widget.passId == '2') &&
        (state.selectedDepartment == null ||
            (state.selectedDepartment?.name ?? '').isEmpty))) {
      Validator().showToast(
        context,
        "Please enter visit department",
      );
    } else if ((widget.passId == '1' || widget.passId == '2') &&
        passtypeTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter pass type",
      );
    } else if (widget.passId == '0' &&
        (state.dayPasselementReason == null ||
            (state.dayPasselementReason?.name ?? '').isEmpty)) {
      Validator().showToast(
        context,
        "Please enter reason for day pass",
      );
    } else if (widget.passId == '2' &&
        (state.vendorPasselementReason == null ||
            (state.vendorPasselementReason?.name ?? '').isEmpty)) {
      Validator().showToast(
        context,
        "Please enter reason for vendor pass",
      );
    } else if (widget.passId == '0' &&
        (state.vendorPassInfo == null ||
            (state.vendorPassInfo?.name ?? '').isEmpty)) {
      Validator().showToast(
        context,
        "Please enter day pass no",
      );
    } else if (widget.passId == '1' &&
        (state.vendorPassInfo == null ||
            (state.vendorPassInfo?.name ?? '').isEmpty)) {
      Validator().showToast(
        context,
        "Please enter Visitor pass no",
      );
    } else if (widget.passId == '2' &&
        (state.vendorPassInfo == null ||
            (state.vendorPassInfo?.name ?? '').isEmpty)) {
      Validator().showToast(
        context,
        "Please enter Vendor pass no",
      );
    } else if ((widget.passId == '1' || widget.passId == '2') &&
        (state.vendorPassInfo == null ||
            (state.vendorPassInfo?.name ?? '').isEmpty)) {
      Validator().showToast(
        context,
        widget.passId == '2'
            ? "Please enter vendor pass no"
            : "Please enter visit pass no",
      );
    } else if (widget.passId == '3' &&
        passCategoryTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter pass category",
      );
    } else if (passvalidfromTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter pass valid from",
      );
    } else if (passvaliduntilTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter pass valid until",
      );
    }
    // else if ((widget.passId == '1' || widget.passId == '2') &&
    //     ((state.escortedbyhost ?? 0) == 0) &&
    //     (escortedbyTextController.text.isEmpty)) {
    //   Validator().showToast(
    //     context,
    //     "Please enter escorted by",
    //   );
    // }
    else if ((widget.passId == '1' || widget.passId == '2') &&
        ((state.escortedbyhost ?? 0) == 0) &&
        (escortedemployeedidbyTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter escort employeed id",
      );
    } else {
      submitForm(true, widget.model?.id ?? 0, globalState);
    }
  }

  Widget datecreateWidgetdisplay() {
    return FlutterInputField(
      textFieldController: dateofcreationTextController,
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

  Widget attachmentListviews(
    List<ImageContent>? attachmentListviews,
    List<ImageContent>? attachmentListviews1,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFCACACA),
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (attachmentListviews1?.length ?? 0) >
                  (attachmentListviews?.length ?? 0)
              ? attachmentListviews1?.length
              : attachmentListviews?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            ImageContent? imageData;
            ImageContent? imageData1;
            if (widget.model != null) {
              imageData1 = attachmentListviews1?[index];
            } else {
              imageData = attachmentListviews?[index];
            }
            log('--attachmentListviews1?.length--${attachmentListviews1?.length}');
            log('--attachmentListviews?.length--${attachmentListviews?.length}');

            return Column(
              children: <Widget>[
                ListTile(
                  trailing: widget.model == null || widget.model?.status == 0
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // Delete logic here
                                if (imageData1 != null) {
                                  // Implement delete functionality for attachmentListviews1
                                  setState(() {
                                    attachmentListviews1!.removeAt(index);
                                  });
                                }
                                if (imageData != null) {
                                  // Implement delete functionality for attachmentListviews1
                                  setState(() {
                                    attachmentListviews!.removeAt(index);
                                  });
                                }
                              },
                            ),
                            SvgPicture.asset(AppIcon.download,
                                color: AppColors.boldgreyBackground),
                          ],
                        )
                      : SvgPicture.asset(AppIcon.download,
                          color: AppColors.boldgreyBackground),
                  onTap: () {
                    DownloadImage().saveImage(
                        context, imageData1?.id ?? 0, imageData1?.title ?? '');
                  },
                  title: widget.model != null
                      ? Text(imageData1?.title ?? '')
                      : Text(imageData?.title ?? ''),
                ),

                const Divider(
                  color: Color(0xFFCACACA),
                  thickness: 1,
                ), //                           <-- Divider
              ],
            );
          }),
    );
  }

  Widget textFieldWidgetLoad(
    TextEditingController textController,
    int index,
    CreatePassMgmtState state,
  ) {
    bool isEditable =
        (widget.model?.status == null || widget.model?.status == 0);
    return FlutterInputField(
      //lineHeight: textController == employeeidTextController ? 1 : 1,
      onTap: () {},
      textFieldController: textController,
      textFormKey: Keys.colorTextController,
      textInputType: textController == contactnoTextController ||
              textController == sezpassinfoTextController
          ? TextInputType.number
          : TextInputType.text,
      isEnable: (textController == companynameTextController
              ? isFTECompanyNameEditable
              : isEditable) ||
          isEditable,
      isDisableColor: isEditable,
      hintText: '',
      onChange: (String value) {
        //this.username = username;
        textController.text = value;
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
      textFieldController: textController,
      textFormKey: Keys.colorTextController,
      textInputType: textController == contactnoTextController ||
              textController == sezpassinfoTextController
          ? TextInputType.number
          : TextInputType.text,
      isEnable: widget.model?.status == null || widget.model?.status == 0
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
  final String passType;
  final String title;
  final bool isRegistry;
  final DayPassListElement? model;

  CreatePassMngArguments(
      this.passType, this.title, this.isRegistry, this.model);
}
