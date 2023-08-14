import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/create_fields.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/custom_multiple_selection_popup.dart';
import 'package:db_atom/src/common_widgets/custom_pop_list_texts.dart';
import 'package:db_atom/src/common_widgets/custom_simple_list_texts.dart';
import 'package:db_atom/src/common_widgets/date_time_picker.dart';
import 'package:db_atom/src/common_widgets/image_download.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/views/add_employee_deparment.dart';
import 'package:db_atom/src/features/createfound/views/create_found_newuser.dart';
import 'package:db_atom/src/features/createfound/views/upload_attachment.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_state.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/company_type_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_request_body.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_numbers_list.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_reason_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_item_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreatePassManagement extends StatefulWidget {
  DayPassListItemResponse? listuser;
  String? passId = '0';
  String? title;
  CreatePassManagement({super.key, this.listuser, this.passId, this.title});

  @override
  State<CreatePassManagement> createState() => _CreatePassManagementState();
}

class _CreatePassManagementState extends State<CreatePassManagement> {
  final GlobalKey<FormState> lawenforcementFormKey = GlobalKey<FormState>();
  TextEditingController statusTextController = TextEditingController();
  TextEditingController updatestatusTextController = TextEditingController();
  TextEditingController passvalidfromTextController = TextEditingController();
  TextEditingController passvaliduntilTextController = TextEditingController();
  TextEditingController companynameTextController = TextEditingController();
  TextEditingController employeeidTextController = TextEditingController();
  TextEditingController hostemployeeidTextController = TextEditingController();
  TextEditingController escortedbyTextController = TextEditingController();
  TextEditingController escortedemployeedidbyTextController =
      TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController dbsponsorTextController = TextEditingController();
  TextEditingController daypassnoTextController = TextEditingController();
  TextEditingController passtypeTextController = TextEditingController();
  TextEditingController contactnoTextController = TextEditingController();
  TextEditingController dateofcreationTextController = TextEditingController();
  TextEditingController visitorcomingfromTextController =
      TextEditingController();
  TextEditingController purposeofvisitTextController = TextEditingController();
  TextEditingController photofidentityextController = TextEditingController();
  TextEditingController sezpassinfoTextController = TextEditingController();
  TextEditingController mtpapplicationnoTextController =
      TextEditingController();

  List<CreateImage>? getFiles;
  List<FoundImage>? getAttachments;
  List<CreateImage>? photogetFiles;
  List<FoundImage>? photogetAttachments;
  late CreatePassMgmtState globalState;
  String? serialnumber;
  String createdBy = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
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
            icon: SvgPicture.asset(AppIcon.backIcon,
                color: AppColors.backgroundWhitecolor),
          ),
          action: [
            GestureDetector(
              onTap: () {
                passSubmit(false, widget.listuser?.id ?? 0, globalState);
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
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
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
          //backgroundColor: AppColors.navigationSkybluecolor,
        ),
        backgroundColor: AppColors.backgroundWhitecolor,
        body: BlocBuilder<CreatePassMgmtCubit, CreatePassMgmtState>(
          builder: (context, state) {
            // listOfEntities = state.getEntitiesResponse;
            //leoDepartmentsResponse = state.getLeodepartmentsResponse;
            // leoPurposeVisitResponse = state.getLeopurposeResponse;

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
            // if (widget.listuser != null) {
            //   if (state.groups != null) {

            //   }
            // }
            return Container(
                color: AppColors.navigationSkybluecolor,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                    height: height * 0.01,
                    color: AppColors.navigationSkybluecolor,
                  ),
                  Container(
                      //padding: const EdgeInsets.all(20.0),
                      decoration: const ShapeDecoration(
                          color: AppColors.backgroundWhitecolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0)),
                          )),
                      child: Form(
                          key: lawenforcementFormKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
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

                                    // Status
                                    CommonWidgets.textDisplay(Constants.status,
                                        Styles.textStyleBlack14),
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

                             
                                    // Update Status
                                  (widget.listuser != null && (statusTextController.text.toLowerCase() == "created" || statusTextController.text.toLowerCase() == "handed over") )?  CommonWidgets.textDisplay(Constants.updatestatus,
                                        Styles.textStyleBlack14) : Container(),
                                    (widget.listuser != null && (statusTextController.text.toLowerCase() == "created" || statusTextController.text.toLowerCase() == "handed over") )? CommonWidgets.verticalSpacerWidget(
                                        height * 0.001) : Container(),
                                   (widget.listuser != null && (statusTextController.text.toLowerCase() == "created" || statusTextController.text.toLowerCase() == "handed over") ) ? GestureDetector(
                                      onTap: () {
                                        if (statusTextController.text.toLowerCase() == "created" )
                                            {
                                           updatestausTypeDialog();
                                        }
                                        else
                                        {
                                           updatestausTypeDialog();
                                        }
                                      },
                                     child: FlutterInputField(
                                        isEnable: false,
                                        isDisableColor: true,
                                        textFieldController: updatestatusTextController,
                                        textFormKey: Keys.statusTextController,
                                        hintText: '',
                                        onChange: (String username) {
                                          //this.username = username;
                                        },
                                        validateTextField: (String? user) {},
                                        suffixWidget: GestureDetector(
                                          onTap: () {
                                            if (statusTextController.text.toLowerCase() == "created" )
                                            {
                                           updatestausTypeDialog();
                                        }
                                        else
                                        {
                                           updatestausTypeDialog();
                                        }
                                          },
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
                                   ) : Container(),
                                   (statusTextController.text.toLowerCase() == "created" || statusTextController.text.toLowerCase() == "handed over") ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.01) : Container(),     

                                    //created by

                                    CommonWidgets.horizentaltextHandling(
                                        Constants.createdby,
                                        createdBy.isNotEmpty
                                            ? createdBy
                                            : state.getUserDetailsResponse
                                                    ?.lastName ??
                                                ''),

                                    // ),
                                    // Location
                                    CommonWidgets.textDisplay(
                                        Constants.location,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    locationWidgetdislay(state),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // date of creation
                                    CommonWidgets.textDisplay(
                                        Constants.dateofcreation,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    datecreateWidgetdisplay(),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // slno

                                    CommonWidgets.horizentaltextHandling(
                                        Constants.slno, serialnumber ?? ''),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // entity type
                                    CommonWidgets.textDisplay(Constants.entity,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    entityaddButtonwidgetLoading(state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Pass Type
                                    CommonWidgets.textDisplay(
                                        Constants.passtype,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    GestureDetector(
                                      onTap: () {
                                        if (widget.passId == "1" ||
                                            widget.passId == "2") {
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
                                          textFormKey:
                                              Keys.statusTextController,
                                          hintText: '',
                                          onChange: (String username) {
                                            //this.username = username;
                                            setState(() {});
                                          },
                                          onTap: () {
                                            if (widget.passId == "1" ||
                                                widget.passId == "2") {
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
                                                if (widget.passId == "1" ||
                                                    widget.passId == "2") {
                                                  passTypeDialog();
                                                }
                                              })),
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Company Type
                                    widget.passId == "0" || widget.passId == "3"
                                        ? CommonWidgets.textDisplay(
                                            Constants.companytype,
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.passId == "0" || widget.passId == "3"
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    // articleaddButtonwidgetLoading(state),
                                    widget.passId == "0" || widget.passId == "3"
                                        ? companytypeaddButtonwidgetLoading(
                                            state)
                                        : Container(),
                                    widget.passId == "0" || widget.passId == "3"
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    // Company Name // Name
                                    CommonWidgets.textDisplay(
                                        widget.passId == "0" ||
                                                widget.passId == "3"
                                            ? Constants.companyname
                                            : widget.passId == "2"
                                                ? "Vendor Name"
                                                :   widget.passId == "0" ? Constants.name : "Visitor Name",
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    widget.passId == "0" || widget.passId == "3"
                                        ? textfieldWidgetLoad(
                                            companynameTextController, 0, state)
                                        : textfieldWidgetLoad(
                                            nameTextController, 0, state),

                                    // Name

                                    CommonWidgets.textDisplay(
                                        widget.passId == "0"
                                            ? Constants.name
                                            : widget.passId == "3"
                                                ? "Email"
                                                : "Contact No",
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    widget.passId == "0"
                                        ? ((state.atomCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'fte'
                                            ? nameaddButtonwidgetLoading(state)
                                            : textfieldWidgetLoad(
                                                nameTextController, 0, state))
                                        : widget.passId == "3"
                                            ? textfieldWidgetLoad(
                                                emailTextController, 0, state)
                                            : textfieldWidgetLoad(
                                                contactnoTextController,
                                                0,
                                                state),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Employee Id
                                    widget.passId == "0" &&
                                                (state.atomCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() !=
                                                    'exceptions' ||
                                            widget.passId == "3"
                                        ? CommonWidgets.textDisplay(
                                            Constants.employeeid,
                                            Styles.textStyleBlack14)
                                        : Container(),

                                    widget.passId == "0" &&
                                                (state.atomCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() !=
                                                    'exceptions' ||
                                            widget.passId == "3"
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),

                                    widget.passId == "0" &&
                                                (state.atomCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() !=
                                                    'exceptions' ||
                                            widget.passId == "3"
                                        ? textfieldWidgetLoad(
                                            employeeidTextController, 0, state)
                                        : Container(),

                                    widget.passId == "0" &&
                                                (state.atomCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() !=
                                                    'exceptions' ||
                                            widget.passId == "3"
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    widget.passId == "0" &&
                                            (state.atomCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'cwr t1'
                                        ? CommonWidgets.textDisplay(
                                            Constants.email,
                                            Styles.textStyleBlack14)
                                        : Container(),

                                    widget.passId == "0" &&
                                            (state.atomCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'cwr t1'
                                        ? textfieldWidgetLoad(
                                            emailTextController, 0, state)
                                        : Container(),

                                    widget.passId == "0" &&
                                            (state.atomCompanyType?.name ?? '')
                                                    .toLowerCase() ==
                                                'cwr t1'
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    // DB sponsor
                                    widget.passId == "0" &&
                                            ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.atomCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? CommonWidgets.textDisplay(
                                            'DB Sponsor',
                                            Styles.textStyleBlack14)
                                        : Container(),

                                    widget.passId == "0" &&
                                            ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.atomCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),

                                    // articleaddButtonwidgetLoading(state),
                                    widget.passId == "0" &&
                                            ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.atomCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? dbsponsoraddButtonwidgetLoading(state)
                                        : Container(),

                                    widget.passId == "0" &&
                                            ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.atomCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    // db sponsor employee id
                                    widget.passId == "0" &&
                                            ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.atomCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? CommonWidgets.textDisplay(
                                            'DB Sponsor Employee Id',
                                            Styles.textStyleBlack14)
                                        : Container(),

                                    widget.passId == "0" &&
                                            ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.atomCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? textfieldWidgetLoad(
                                            dbsponsorTextController, 0, state)
                                        : Container(),

                                    widget.passId == "0" &&
                                            ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'cwr t1' ||
                                                (state.atomCompanyType?.name ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'cwr t2')
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    widget.passId == '1' || widget.passId == '3'
                                        ? CommonWidgets.textDisplay(
                                            widget.passId == '1'
                                                ? 'Visitor Coming From'
                                                : 'SEZ Pass Info',
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.passId == '1' || widget.passId == '3'
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),

                                    widget.passId == '1' || widget.passId == '3'
                                        ? textfieldWidgetLoad(
                                            widget.passId == '3'
                                                ? sezpassinfoTextController
                                                : visitorcomingfromTextController,
                                            0,
                                            state)
                                        : Container(),

                                    widget.passId == '1' || widget.passId == '3'
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),
                                    widget.passId == '1' || widget.passId == '3'
                                        ? CommonWidgets.textDisplay(
                                            widget.passId == '3'
                                                ? 'MTP Application No'
                                                : 'Purpose of Visit',
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.passId == '1' || widget.passId == '3'
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),

                                    widget.passId == '1' || widget.passId == '3'
                                        ? textfieldWidgetLoad(
                                            widget.passId == '3'
                                                ? mtpapplicationnoTextController
                                                : purposeofvisitTextController,
                                            0,
                                            state)
                                        : Container(),

                                    widget.passId == "1" || widget.passId == '3'
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),
                                    //Photo Identity Validation Type
                                    widget.passId == "1"
                                        ? CommonWidgets.textDisplay(
                                            'Photo Identity Validation Type  ',
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.passId == "1"
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    widget.passId == "1"
                                        ? GestureDetector(
                                            onTap: () {
                                              photoIdentityTypeDialog();
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
                                                  photoIdentityTypeDialog();
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
                                                      print(
                                                          'suffixIcon pressed');

                                                      photoIdentityTypeDialog();
                                                    })),
                                          )
                                        : Container(),
                                    widget.passId == "1"
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    // Host
                                    ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions' &&
                                                widget.passId == "0") ||
                                            widget.passId == "1" ||
                                            widget.passId == "2" ||
                                            widget.passId == '3'
                                        ? CommonWidgets.textDisplay(
                                            Constants.host,
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions' &&
                                                widget.passId == "0") ||
                                            widget.passId == "1" ||
                                            widget.passId == "2" ||
                                            widget.passId == '3'
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    // articleaddButtonwidgetLoading(state),
                                    ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions' &&
                                                widget.passId == "0") ||
                                            widget.passId == "1" ||
                                            widget.passId == "2" ||
                                            widget.passId == '3'
                                        ? hostaddButtonwidgetLoading(state)
                                        : Container(),
                                    ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions' &&
                                                widget.passId == "0") ||
                                            widget.passId == "1" ||
                                            widget.passId == "2" ||
                                            widget.passId == '3'
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    // Host Employee Id
                                    ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions' &&
                                                widget.passId == "0") ||
                                            widget.passId == "1" ||
                                            widget.passId == "2" ||
                                            widget.passId == '3'
                                        ? CommonWidgets.textDisplay(
                                            Constants.hostemployeeid,
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions' &&
                                                widget.passId == "0") ||
                                            widget.passId == "1" ||
                                            widget.passId == "2" ||
                                            widget.passId == '3'
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    ((state.atomCompanyType?.name ?? '')
                                                        .toLowerCase() ==
                                                    'exceptions' &&
                                                widget.passId == "0") ||
                                            widget.passId == "1" ||
                                            widget.passId == "2" ||
                                            widget.passId == '3'
                                        ? textfieldWidgetLoad(
                                            hostemployeeidTextController,
                                            0,
                                            state)
                                        : Container(),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // department
                                    widget.passId == '3'
                                        ? Container()
                                        : CommonWidgets.textDisplay(
                                            widget.passId == '1' ||
                                                    widget.passId == '2'
                                                ? "Visiting Department"
                                                : Constants.department,
                                            Styles.textStyleBlack14),
                                    widget.passId == '3'
                                        ? Container()
                                        : CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    widget.passId == '3'
                                        ? Container()
                                        : departmentaddButtonwidgetLoading(
                                            state),
                                    widget.passId == '3'
                                        ? Container()
                                        : CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                    // Reason for day pass
                                    widget.passId == '3' ||  widget.passId == '1'
                                        ? Container()
                                        : CommonWidgets.textDisplay(
                                           widget.passId == "2"
                                                    ? "Reason for Vendor Pass"
                                                    : Constants
                                                        .reasonfordaypass,
                                            Styles.textStyleBlack14),
                                     widget.passId == '3' ||  widget.passId == '1'
                                        ? Container()
                                        : CommonWidgets.verticalSpacerWidget(
                                            height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    widget.passId == '3' ||  widget.passId == '1'
                                        ? Container()
                                        : reasonforadaypassaddButtonwidgetLoading(
                                            state),
                                    widget.passId == '3' ||  widget.passId == '1'
                                        ? Container()
                                        : CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                    // passCategoryDialog

                                    // Day  pass no
                                    CommonWidgets.textDisplay(
                                        widget.passId == "1"
                                            ? "Visitor Pass No"
                                            : widget.passId == "2"
                                                ? "Vendor Pass No"
                                                : widget.passId == '3'
                                                    ? 'Pass Category'
                                                    : Constants.daypassno,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    GestureDetector(
                                      onTap: () {
                                        if (widget.listuser == null ||
                                            daypassnoTextController
                                                .text.isEmpty) {
                                          //daypassNoDialog();
                                          //passnumberaddButtonwidgetLoading(state);
                                          if (widget.passId == '3') {
                                            passCategoryDialog();
                                          } else {
                                            passnumberTypeDialog(state);
                                          }
                                        }
                                      },
                                      child: FlutterInputField(
                                          isEnable: false,
                                          isDisableColor:
                                              widget.listuser == null ||
                                                      daypassnoTextController
                                                          .text.isEmpty
                                                  ? false
                                                  : true,
                                          textFieldController:
                                              daypassnoTextController,
                                          textFormKey:
                                              Keys.statusTextController,
                                          hintText: '',
                                          onChange: (String username) {
                                            //this.username = username;
                                            setState(() {});
                                          },
                                          onTap: () {
                                            if (widget.listuser == null ||
                                                daypassnoTextController
                                                    .text.isEmpty) {
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
                                                print('suffixIcon pressed');

                                                //passnumberaddButtonwidgetLoading(state);
                                                if (widget.passId == '3') {
                                                  passCategoryDialog();
                                                } else {
                                                  passnumberTypeDialog(state);
                                                }
                                              })),
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Pass Valid From
                                    CommonWidgets.textDisplay(
                                        Constants.passvlidfrom,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    datepickerWidgetLoading(
                                        passvalidfromTextController),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Pass Valid Until
                                    CommonWidgets.textDisplay(
                                        Constants.passvliduntil,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    datepickerWidgetLoading(
                                        passvaliduntilTextController),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Escorted by Host
                                    widget.passId == '1'
                                        ? CommonWidgets.textDisplay(
                                            'Escorted by Host',
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.passId == '1'
                                        ? radioButtonHandling(
                                            state.escortedbyhost ?? 1,
                                            'Escorted by Host')
                                        : Container(),

                                    // Escorted By
                                    widget.passId == '0' ||
                                            widget.passId == '2' ||
                                            (widget.passId == '1' &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? CommonWidgets.textDisplay(
                                            Constants.escortedby,
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.passId == '0' ||
                                            widget.passId == '2' ||
                                            (widget.passId == '1' &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    widget.passId == '0' ||
                                            widget.passId == '2' ||
                                            (widget.passId == '1' &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? textfieldWidgetLoad(
                                            escortedbyTextController, 0, state)
                                        : Container(),
                                    widget.passId == '0' ||
                                            widget.passId == '2' ||
                                            (widget.passId == '1' &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    // Escorted By
                                    widget.passId == '0' ||
                                            widget.passId == '2' ||
                                            (widget.passId == '1' &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? CommonWidgets.textDisplay(
                                            Constants.escortedbyemployeeid,
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.passId == '0' ||
                                            widget.passId == '2' ||
                                            (widget.passId == '1' &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    widget.passId == '0' ||
                                            widget.passId == '2' ||
                                            (widget.passId == '1' &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? textfieldWidgetLoad(
                                            escortedemployeedidbyTextController,
                                            0,
                                            state)
                                        : Container(),
                                    widget.passId == '0' ||
                                            widget.passId == '2' ||
                                            (widget.passId == '1' &&
                                                (state.escortedbyhost ?? 0) ==
                                                    0)
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    widget.passId == '1' && widget.listuser == null
                                        ? CommonWidgets.textDisplay(
                                            'Photo of Visitor',
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.passId == '1' && widget.listuser == null
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    widget.passId == '1' && widget.listuser == null
                                        ? uploadWidget(state,true)
                                        : Container(),

                                   // Attachments
                                    widget.passId == '1' ? photogetSpaceattchment(height) : Container(),
                                    widget.passId == '1' ? photogetAttachement(height) : Container(),     

                                    widget.listuser == null
                                        ? CommonWidgets.textDisplay(
                                            Constants.upload,
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.listuser == null
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    widget.listuser == null
                                        ? uploadWidget(state,false)
                                        : Container(),

                                    // Attachments
                                    getSpaceattchment(height),
                                    getAttachement(height),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // SubmitButton
                                    Center(child: submitButtonDisplay()),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.005),
                                  ]),
                                ),
                                // Upload
                              ])))
                ])));
          },
        )); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  Widget radioButtonHandling(int selectedValue, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: widget.listuser != null
              ? AppColors.disabletextfieldBackground
              : AppColors.navigationSkybluecolor,
          focusColor: AppColors.navigationSkybluecolor,
          value: 1,
          groupValue: selectedValue,
          onChanged: (val) {
            print(name);
            //
            selectedValue = 1;

            createpassmgmtCubit.getRadioButtonSelected(
                name, selectedValue, "Yes");
          },
        ),
        const Text(Constants.yes),
        Radio(
          activeColor: widget.listuser != null
              ? AppColors.disabletextfieldBackground
              : AppColors.navigationSkybluecolor,
          value: 0,
          groupValue: selectedValue,
          onChanged: (val) {
            print(name);
            //radioButtonItem = 'No';
            selectedValue = 0;

            createpassmgmtCubit.getRadioButtonSelected(
                name, selectedValue, "No");
          },
        ),
        const Text(Constants.no),
      ],
    );
    //return Container();
  }

  @override
  void initState() {
    super.initState();
    if (widget.listuser != null) {
      //globalState = CreatePassMgmtState(stateType: CreatePassMgmtStateType.initial);
      editCreatefoundItems();
    } else {
      createpassmgmtCubit.initalization();
    }
    if (widget.passId == '0') {
      passtypeTextController.text = 'DAY_PASS';
    } else if (widget.passId == '3') {
      passtypeTextController.text = 'SEZ_PASS';
    }
    getPassmanagmentList();
    _getCurrentDate();
  }

  editCreatefoundItems() async {
    if (widget.listuser != null) {
      await SharedPrefs.setFoundId(widget.listuser?.id ?? 0);

      employeeidTextController.text = widget.listuser?.employeeId != null
          ? widget.listuser?.employeeId.toString() ?? ""
          : '';
      companynameTextController.text = widget.listuser?.companyName != null
          ? widget.listuser?.companyName.toString() ?? ""
          : '';
      escortedemployeedidbyTextController.text =
          widget.listuser?.escortedEmployeeId != null
              ? widget.listuser?.escortedEmployeeId.toString() ?? ""
              : '';
      escortedbyTextController.text = widget.listuser?.escortedByName != null
          ? widget.listuser?.escortedByName.toString() ?? ""
          : '';
      hostemployeeidTextController.text =
          widget.listuser?.hostEmployeeId != null
              ? widget.listuser?.hostEmployeeId.toString() ?? ""
              : '';

      T1Analyst host1 = widget.listuser?.host != null
          ? T1Analyst(
              id: widget.listuser?.host?.userId ?? 0,
              name: ((widget.listuser?.host?.firstName ?? '') +
                  ' ' +
                  (widget.listuser?.host?.lastName ?? '')))
          : T1Analyst();
          
      createpassmgmtCubit.gethostanalystsResponseData(host1);
      createpassmgmtCubit.getdbsponsoranalystsResponseData(host1);

      nameTextController.text = widget.passId == '1' && widget.listuser?.visitorName != null ?  widget.listuser?.visitorName ?? ''
          : widget.listuser?.employeeName.toString() ?? '';
            var userid = await SharedPrefs.getUserId();
      T1Analyst name1 = nameTextController.text.isNotEmpty
          ? T1Analyst(
              id:int.parse(userid) ,
              name: nameTextController.text)
          : T1Analyst();
      createpassmgmtCubit.getnameanalystsResponseData(name1);
      dateofcreationTextController.text = widget.listuser?.inputDate != null &&
              widget.listuser?.inputDate != '0'
          ? Utils.timestamptoDateConversion(
              int.parse(widget.listuser?.inputDate ?? '0'),
              Constants.fulldateFormat)
          : dateofcreationTextController.text;
      passvalidfromTextController.text = widget.listuser?.startTime != null &&
              widget.listuser?.startTime != '0'
          ? Utils.timestamptoDateConversion(
              int.parse(widget.listuser?.startTime ?? '0'),
              Constants.fulldateFormat)
          : passvalidfromTextController.text;
      passvaliduntilTextController.text =
          widget.listuser?.endTime != null && widget.listuser?.endTime != '0'
              ? Utils.timestamptoDateConversion(
                  int.parse(widget.listuser?.endTime ?? '0'),
                  Constants.fulldateFormat)
              : passvaliduntilTextController.text;

      // List<VisitingOfficial>? visitingOfficials = widget.listuser?.visitingOfficials != null ? widget.listuser?.visitingOfficials ?? [] : [];
      statusTextController.text = widget.listuser?.status == 0
          ? "created"
          : widget.listuser?.status == 1
              ? "handed over"
              : widget.listuser?.status == 2
                  ? "returned"
                  : widget.listuser?.status == 3
                      ? "non returned"
                      : widget.listuser?.status == 4
                          ? 'lost'
                          : widget.listuser?.status == 5
                              ? 'damaged'
                              : widget.listuser?.status == 6
                                  ? 'defaced'
                                  : widget.listuser?.status == 7
                                      ? 'cancelled'
                                      : widget.listuser?.status == 8
                                          ? 'returned damaged'
                                          : 'returned defaced';
       if (widget.listuser?.passType == 1) 
       {
        passtypeTextController.text = 'VISITOR_PASS';
       } 
       else if (widget.listuser?.passType == 5) 
       {
        passtypeTextController.text = 'DWS_VISITOR_PASS';
       } 
        else if (widget.listuser?.passType == 2) 
       {
        passtypeTextController.text = 'VENDOR_PASS';
       } 
       else if (widget.listuser?.passType == 6) 
       {
        passtypeTextController.text = 'DWS_VENDOR_PASS';
       } 

       if (widget.listuser?.idValidationType == 0) 
       {
        photofidentityextController.text = 'Adhar Card';
       } 
       else if (widget.listuser?.idValidationType == 1) 
       {
        photofidentityextController.text = 'Pan Card';
       } 
        else if (widget.listuser?.idValidationType == 2) 
       {
        photofidentityextController.text = 'Passport';
       } 
       else if (widget.listuser?.idValidationType == 3) 
       {
        photofidentityextController.text = 'Driving Licence';
       } 
       else if (widget.listuser?.idValidationType == 4) 
       {
        photofidentityextController.text = 'Voter Card';
       }                                     

      //state.serialnumberResponse?.serialNo

      //  state.getUserDetailsResponse  =  widget.listuser?.entrySecurity != null ? GetUserDetails(
      //     userId: widget.listuser?.entrySecurity?.userId ?? 1,
      //     lastName: widget.listuser?.entrySecurity?.lastName ?? "") : GetUserDetails() ;

      //state.locationSelectedlist =
      Mumbai mumbai = widget.listuser?.location != null
          ? Mumbai(
              id: widget.listuser?.location?.id ?? 0,
              name: widget.listuser?.location?.name ?? "")
          : Mumbai();
     
      serialnumber =
          widget.listuser?.slNo != null ? widget.listuser?.slNo ?? '' : '';
      ActivePassInfoList active = ActivePassInfoList(
          id: widget.listuser?.passInfo?.id ?? 0,
          name: widget.listuser?.passInfo?.passNo ?? '');
      daypassnoTextController.text = widget.listuser?.passInfo?.passNo ?? '';
      createpassmgmtCubit.getpassListResponseData(active);
      await createpassmgmtCubit.getSerialnumberDetails(
          (widget.listuser?.location?.id ?? 0).toString(), 'AF');
      createpassmgmtCubit.getPassnumber(
          '0', (widget.listuser?.location?.id ?? 0).toString());
      createpassmgmtCubit.getlocationsResponseData(mumbai);

      if ((widget.listuser?.entities?.length ?? 0) > 0) {
        List<AtomEntity> entities = [];
        for (int i = 0; i < widget.listuser!.entities!.length; i++) {
          AtomEntity entity = widget.listuser?.entities != null &&
                  (widget.listuser?.entities?.length ?? 0) > 0
              ? AtomEntity(
                  id: widget.listuser?.entities![i].id ?? 0,
                  name: widget.listuser?.entities![i].name ?? "")
              : AtomEntity();
          // AtomEntity entity = state.listOfEntities![i];
          //   DbOfficialEmailDepartment addentiity =
          // DbOfficialEmailDepartment(id: entity.id ?? 1);
          entities.add(entity);
        }
        createpassmgmtCubit.getEntityData(entities);
      }
      AtomCompanyType emp = widget.listuser != null
          ? AtomCompanyType(
              id: widget.listuser?.companyType?.id ?? 0,
              name: widget.listuser?.companyType?.name ?? '')
          : AtomCompanyType();
      createpassmgmtCubit.getatomCompanyTypeResponseData(emp);
//vendorPassReason
      DayPassReasonElement day = widget.listuser != null
          ? widget.passId == '2' ? DayPassReasonElement(
              id: widget.listuser?.vendorPassReason?.id ?? 0,
              name: widget.listuser?.vendorPassReason?.name ?? ''): DayPassReasonElement(
              id: widget.listuser?.dayPassReason?.id ?? 0,
              name: widget.listuser?.dayPassReason?.name ?? '')
          : DayPassReasonElement();
      createpassmgmtCubit.getdaypassreasonResponseData(day);

      EmployeeDepartment dep = widget.listuser != null
          ? EmployeeDepartment(
              id: widget.listuser?.department?.id ?? 0,
              name: widget.listuser?.department?.name ?? '')
          : EmployeeDepartment();
      createpassmgmtCubit.getemployeeDepartmentsResponseData(dep);
      getAttachments =
          widget.listuser?.images != null ? widget.listuser?.images ?? [] : [];
      photogetAttachments =
          widget.listuser?.visitorImage != null ? widget.listuser?.visitorImage ?? [] : [];   
          
      emailTextController.text = widget.listuser?.email ?? '';
      purposeofvisitTextController.text = widget.listuser?.visitingPurpose ?? '';  
      mtpapplicationnoTextController.text = widget.listuser?.mifareNo ?? '';
      visitorcomingfromTextController.text = widget.listuser?.visitorComingFrom ?? '';
      contactnoTextController.text = widget.listuser?.contactNo ?? '';
      sezpassinfoTextController.text = widget.listuser?.passNo ?? '';
      dbsponsorTextController.text = widget.listuser?.hostEmployeeId ?? '';
       
    }
  }

  getPassmanagmentList() async {
    await createpassmgmtCubit.getLocations('ATOM_LOCATIONS');
    await createpassmgmtCubit.getEntities('ATOM_ENTITIES');
    await createpassmgmtCubit.getEmployeeDepartments('EMPLOYEE_DEPARTMENTS');
    if (widget.listuser == null ||
        (widget.listuser?.entrySecurity?.userName ?? '').isEmpty) {
      var userid = await SharedPrefs.getUserId();
      await createpassmgmtCubit.getUserDetails(userid);
    } else {
      createdBy = widget.listuser?.entrySecurity?.userName ?? '';
    }
    await createpassmgmtCubit.getCompanytypes('ATOM_COMPANY_TYPES');
    await createpassmgmtCubit.getDayPassreasons('DAY_PASS_REASON');
    await createpassmgmtCubit.getAnalysts('T1_Analyst');
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

  daypassNoDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomSimpleListTexts(
            texts: ["Personal", "company"],
            onTap: (String value) {
              print(value);
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
            texts: widget.passId == "1"
                ? ["VISITOR_PASS", "DWS_VISITOR_PASS"]
                : widget.passId == "2"
                    ? ["VENDOR_PASS", "DWS_VENDOR_PASS"]
                    : [],
            onTap: (String value) {
              print(value);
              passtypeTextController.text = value;
              setState(() {});
            },
          );
        });
  }

  updatestausTypeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomSimpleListTexts(
            texts: statusTextController.text.toLowerCase() == "created"
                ? ["cancelled"]
                :  ["returned","lost","damaged", "defaced", "returned damaged" ,"returned defaced"],
            onTap: (String value) {
              print(value);
              updatestatusTextController.text = value;
              setState(() {});
            },
          );
        });
  }

  passCategoryDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomSimpleListTexts(
            texts: widget.passId == "3"
                ? ["Permenant", "Temporary"]
                : widget.passId == "2"
                    ? ["VENDOR_PASS", "DWS_VENDOR_PASS"]
                    : [],
            onTap: (String value) {
              print(value);
              daypassnoTextController.text = value;
              setState(() {});
            },
          );
        });
  }

  photoIdentityTypeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomSimpleListTexts(
            texts: [
              "Adhar Card",
              "Pan Card",
              "Passport",
              "Driving Licence",
              "Voter Card"
            ],
            onTap: (String value) {
              print(value);
              photofidentityextController.text = value;
              setState(() {});
            },
          );
        });
  }

  Widget departmentaddButtonwidgetLoading(CreatePassMgmtState state) {
    return TextfieldAddButton(
      title: state.selectedemployeeDepartmentResponse?.name ?? '',
      height: 60,
      isDisableColor: widget.listuser == null ||
              (state.selectedemployeeDepartmentResponse != null &&
                  ((state.selectedemployeeDepartmentResponse?.name ?? '')
                      .isEmpty))
          ? false
          : true,
      onTap: () {
        if (widget.listuser == null ||
            (state.selectedemployeeDepartmentResponse != null &&
                ((state.selectedemployeeDepartmentResponse?.name ?? '')
                    .isEmpty))) {
          //   articleTypeDialog(state);
          departmentsDialog(state);
        }
      },
    );
  }

  Widget reasonforadaypassaddButtonwidgetLoading(CreatePassMgmtState state) {
    return TextfieldAddButton(
      title: state.dayPasselementReason?.name ?? '',
      height: 60,
      isDisableColor: widget.listuser == null ||
              (state.dayPasselementReason != null &&
                  ((state.dayPasselementReason?.name ?? '').isEmpty))
          ? false
          : true,
      onTap: () {
        if (widget.listuser == null ||
            (state.dayPasselementReason != null &&
                ((state.dayPasselementReason?.name ?? '').isEmpty))) {
          //   articleTypeDialog(state);
          reasondaypassDialog(state);
        }
      },
    );
  }

  reasondaypassDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicatedayPassReason: state.dayPassReason?.dayPassReason ?? [],
            leftimagename:  widget.passId == '0' || widget.passId == '2' ?  AppIcon.addicon : null, 
            onLeftButtonTap: () {
              if(widget.passId == '0' || widget.passId == '2')
              {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddNewFields(
                      title: widget.passId == '0' ? Constants.addreasonfordaypass : Constants.addreasonforvendorpass,
                      createpassmgmtstate: state,
                    );
                  });
              }
            },
            onTap: (DayPassReasonElement list) {
              //print(list.name);
              createpassmgmtCubit.getdaypassreasonResponseData(list);
            },
          );
        });
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
        textFormKey: textfiled != passvalidfromTextController ||
                textfiled != passvaliduntilTextController
            ? Keys.founddateTextController
            : Keys.actualdateTextController,
        hintText: '',
        isEnable: false,
        isDisableColor: true,
        //widget.listuser == null || textfiled.text.isEmpty ? false : true,
        onChange: (String username) {
          //this.username = username;
          print('dfwf');

          // setState(() {});
        },
        validateTextField: (String? user) {},
        suffixWidget: GestureDetector(
          onTap: () async {
            if (widget.listuser == null || textfiled.text.isEmpty) {
              datePickerDialog(textfiled);
            }
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

    print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat(Constants.fulldateFormat)
        .format(pickedDate ?? DateTime.now());
    print(
        formattedDate); //formatted date output using intl package =>  2021-03-16
    //you can implement different kind of Date Format here according to your requirement
    if (textfield == passvalidfromTextController) {
      passvalidfromTextController.text = formattedDate;
    }
    if (textfield == passvaliduntilTextController) {
      passvaliduntilTextController.text = formattedDate;
    }
    // setState(() {
    //   // dateinput.text = formattedDate; //set output date to TextField value.
    // });
  }

  void _getCurrentDate() {
    final _currentDate = DateTime.now();
    String formattedDate =
        DateFormat(Constants.fulldateFormat).format(_currentDate);
    print(formattedDate);
    String nextformattedDate = DateFormat(Constants.fulldateFormat)
        .format(_currentDate.add(Duration(days: 1)));
    dateofcreationTextController.text = formattedDate;
    passvalidfromTextController.text = formattedDate;
    passvaliduntilTextController.text = nextformattedDate;
    if (widget.listuser == null) {
      statusTextController.text = 'created';
    }
  }

  Widget uploadWidget(CreatePassMgmtState state,bool isPhotoType) {
    return // upload
        widget.listuser == null
            ? Container(
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFCACACA),
                      width: 1.0,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(140, 50)),
                      onPressed: () {
                        // Navigator.pushNamed(context,
                        //     createFoundAttachmentRoute);
                        //UploadAttachment();
                        showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return UploadAttachment(
                                userdetails: state.getUserDetailsResponse ??
                                    GetUserDetails(),
                                getFiles: isPhotoType ? photogetFiles ?? [] :getFiles ?? [],
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
                      // const Icon(
                      //   // <-- Icon
                      //   Icons.upload,
                      //   color: AppColors.backgroundWhitecolor,
                      //   size: 24.0,
                      // ),
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
    return getAttachments != null ||
            getFiles != null ||
            getFiles?.length != 0 ||
            getAttachments?.length != 0
        ? CommonWidgets.verticalSpacerWidget(height * 0.01)
        : Container();
  }

  Widget getAttachement(double height) {
    return (getAttachments == null ||
            getAttachments?.length == 0 ||
            widget.listuser == null)
        ? getFiles?.length == 0 || getFiles == null
            ? Container()
            : attachmentListviews(getFiles, getAttachments)
        : attachmentListviews(getFiles, getAttachments);
  }

  Widget photogetSpaceattchment(double height) {
    return photogetAttachments != null ||
            photogetFiles != null ||
            photogetFiles?.length != 0 ||
            photogetAttachments?.length != 0
        ? CommonWidgets.verticalSpacerWidget(height * 0.01)
        : Container();
  }

  Widget photogetAttachement(double height) {
    return (photogetAttachments == null ||
            photogetAttachments?.length == 0 ||
            widget.listuser == null)
        ? photogetFiles?.length == 0 || photogetFiles == null
            ? Container()
            : attachmentListviews(photogetFiles, photogetAttachments)
        : attachmentListviews(photogetFiles, photogetAttachments);
  }

  Widget entityaddButtonwidgetLoading(CreatePassMgmtState state) {
    String title = '';
    if ((state.listOfEntities?.length ?? 0) > 0) {
      for (int i = 0; i < state.listOfEntities!.length; i++) {
        AtomEntity entity = state.listOfEntities![i];
        String value = entity.name ?? '';
        title = title + '  ' + value;
      }
    }
    return TextfieldAddButton(
      title: title,
      height: 60,
      isDisableColor: widget.listuser == null ||
              ((state.listOfEntities?.length ?? 0) == 0 && (title.isEmpty))
          ? false
          : true,
      onTap: () {
        if (widget.listuser == null ||
            (state.listOfEntities != null && (title.isEmpty))) {
          entityTypeDialog(state);
        }
      },
    );
  }

  entityTypeDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomMultipleSelectionListTexts(
            duplicateentityList: state.getEntitiesResponse?.atomEntities ?? [],
            leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return  AddNewFields(
                      title: Constants.addentitytype,
                      createpassmgmtstate: state,
                    );
                  });
           
            },
            onTap: (List<AtomEntity> list) {
              createpassmgmtCubit.getEntityData(list);
            },
          );
        });
  }

  departmentsDialog(CreatePassMgmtState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateemployeeDepartments:
                state.employeeDepartment?.employeeDepartments ?? [],
            leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddEmployeeDepartment(
                      title: Constants.addemployeedepartment,
                      createpassmgmtstate: state,
                    );
                  });
            },
            onTap: (EmployeeDepartment list) {
              //print(list.name);
              createpassmgmtCubit.getemployeeDepartmentsResponseData(list);
            },
          );
        });
  }

  Widget companytypeaddButtonwidgetLoading(CreatePassMgmtState state) {
    return TextfieldAddButton(
      title: state.atomCompanyType?.name ?? '',
      height: 60,
      isDisableColor: widget.listuser == null ||
              (state.atomCompanyType != null &&
                  ((state.atomCompanyType?.name ?? '').isEmpty))
          ? false
          : true,
      onTap: () {
        if (widget.listuser == null ||
            (state.atomCompanyType != null &&
                ((state.atomCompanyType?.name ?? '').isEmpty))) {
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
              leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return  AddNewFields(
                      title: Constants.addcompanytype,
                      createpassmgmtstate: state
                    );
                  });
           
            },
            onTap: (AtomCompanyType list) {
              //print(list.name);
              if ((list.name ?? '').toLowerCase() == 'fte') {
                companynameTextController.text = 'Deutsche Bank';
              }
              createpassmgmtCubit.getatomCompanyTypeResponseData(list);
            },
          );
        });
  }

  Widget nameaddButtonwidgetLoading(CreatePassMgmtState state) {
    return TextfieldAddButton(
      title: state.t1nameanalyst?.name ?? '',
      height: 60,
      isDisableColor: widget.listuser == null ||
              (state.t1nameanalyst != null &&
                  ((state.t1nameanalyst?.name ?? '').isEmpty))
          ? false
          : true,
      onTap: () {
        if (widget.listuser == null ||
            (state.t1nameanalyst != null &&
                ((state.t1nameanalyst?.name ?? '').isEmpty))) {
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
            duplicatet1Analyst: state.analyst?.t1Analyst ?? [],
            leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return  CreateFoundNewUser(title: Constants.createnewuser,createpassmgmtstate: state,);
                  });
            },
            onTap: (T1Analyst list) {
              //print(list.name);
              createpassmgmtCubit.getnameanalystsResponseData(list);
            },
          );
        });
  }

  Widget hostaddButtonwidgetLoading(CreatePassMgmtState state) {
    return TextfieldAddButton(
      title: state.t1hostanalyst?.name ?? '',
      height: 60,
      isDisableColor: widget.listuser == null ||
              (state.t1hostanalyst != null &&
                  ((state.t1hostanalyst?.name ?? '').isEmpty))
          ? false
          : true,
      onTap: () {
        if (widget.listuser == null ||
            (state.t1hostanalyst != null &&
                ((state.t1hostanalyst?.name ?? '').isEmpty))) {
          //   articleTypeDialog(state);
          // leodepartmentsDialog(state, 0);
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
            duplicatet1Analyst: state.analyst?.t1Analyst ?? [],
            leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return  CreateFoundNewUser(title: Constants.createnewuser,createpassmgmtstate: state,);
                  });
            
            },
            onTap: (T1Analyst list) {
              //print(list.name);
              createpassmgmtCubit.gethostanalystsResponseData(list);
            },
          );
        });
  }

  Widget dbsponsoraddButtonwidgetLoading(CreatePassMgmtState state) {
    return TextfieldAddButton(
      title: state.t1dbsponsoranalyst?.name ?? '',
      height: 60,
      isDisableColor: widget.listuser == null ||
              state.t1dbsponsoranalyst == null ||
              (state.t1dbsponsoranalyst != null &&
                  ((state.t1dbsponsoranalyst?.name ?? '').isEmpty))
          ? false
          : true,
      onTap: () {
        if (widget.listuser == null ||
            state.t1dbsponsoranalyst == null ||
            (state.t1dbsponsoranalyst != null &&
                ((state.t1dbsponsoranalyst?.name ?? '').isEmpty))) {
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
            duplicatet1Analyst: state.analyst?.t1Analyst ?? [],
            leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return  CreateFoundNewUser(title: Constants.createnewuser,createpassmgmtstate: state,);
                  });
            },
            onTap: (T1Analyst list) {
              //print(list.name);
              createpassmgmtCubit.getdbsponsoranalystsResponseData(list);
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
            onTap: (ActivePassInfoList list) {
              //print(list.name);
              daypassnoTextController.text = list.name ?? '';
              createpassmgmtCubit.getpassListResponseData(list);
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
        if (widget.listuser == null ||
            (state.locationSelectedlist?.name ?? '').isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              // print(state.getLocationsResponse);
              return CustomExpansionListTexts(
                getLocationsresponse: state.getLocationsResponse,
                //GetLocations(),
                onTap: (Mumbai? list) async {
                  print(list?.name);
                  await createpassmgmtCubit.getSerialnumberDetails(
                      list?.id.toString() ?? '', 'AF');

                  createpassmgmtCubit.getPassnumber(
                      widget.passId ?? '0', list?.id.toString() ?? '');
                  // locationselectedText = list?.name ?? '';
                  // locationSelectedlist = list;
                  createpassmgmtCubit.getlocationsResponseData(list);
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
                color: Color(0xFFCACACA),
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
                              AppColors.normaltextBackground),
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

  Future passSubmit(
      bool isSubmit, int isFoundId, CreatePassMgmtState state) async {
    int passvalidfromdate = Utils.datetoTimestampConversion(
        passvalidfromTextController.text, Constants.fulldateFormat);
    int passvaliduntildate = Utils.datetoTimestampConversion(
        passvaliduntilTextController.text, Constants.fulldateFormat);
    int inputdate = Utils.datetoTimestampConversion(
        dateofcreationTextController.text, Constants.fulldateFormat);
    int statusvalue = 0;
   

    if (statusTextController.text.toLowerCase() == "created") {
      statusvalue = 0;
    } else if (statusTextController.text.toLowerCase() == "handed over") {
      statusvalue = 1;
    } else if (statusTextController.text.toLowerCase() == "returned") {
      statusvalue = 2;
    } else if (statusTextController.text.toLowerCase() == "non returned") {
      statusvalue = 3;
    } else if (statusTextController.text.toLowerCase() == "lost") {
      statusvalue = 4;
    } else if (statusTextController.text.toLowerCase() == "damaged") {
      statusvalue = 5;
    } else if (statusTextController.text.toLowerCase() == "defaced") {
      statusvalue = 6;
    } else if (statusTextController.text.toLowerCase() == "cancelled") {
      statusvalue = 7;
    } else if (statusTextController.text.toLowerCase() == "returned damaged") {
      statusvalue = 8;
    } else {
      statusvalue = 9;
    }

  int updatestatusvalue = 0;
     if (updatestatusTextController.text.toLowerCase() == "returned") {
      updatestatusvalue = 2;
    } else if (updatestatusTextController.text.toLowerCase() == "lost") {
      updatestatusvalue = 4;
    } else if (updatestatusTextController.text.toLowerCase() == "damaged") {
      updatestatusvalue = 5;
    } else if (updatestatusTextController.text.toLowerCase() == "defaced") {
      updatestatusvalue = 6;
    } else if (updatestatusTextController.text.toLowerCase() == "cancelled") {
      updatestatusvalue = 7;
    } else if (updatestatusTextController.text.toLowerCase() == "returned damaged") {
      updatestatusvalue = 8;
    } else {
      updatestatusvalue = 9;
    }

    List<PassMgmtTypEntity>? entities = [];
    if ((state.listOfEntities?.length ?? 0) > 0) {
      for (int i = 0; i < state.listOfEntities!.length; i++) {
        AtomEntity entity = state.listOfEntities![i];
        PassMgmtTypEntity addentiity = PassMgmtTypEntity(id: entity.id ?? 1);
        entities.add(addentiity);
      }
    }
    PassMgmtLocation? location = PassMgmtLocation(
        id: (state.locationSelectedlist?.id   == 0) ? 1 : state.locationSelectedlist?.id ?? 1,
        name: state.locationSelectedlist?.name ?? '');

    PassMgmtLocation? daypass = PassMgmtLocation(
        id: (state.dayPasselementReason?.id   == 0) ? 1 : state.dayPasselementReason?.id ?? 1,
        name: state.dayPasselementReason?.name ?? ''); 

    PassCompanyType? companyType = PassCompanyType(
        id: (state.atomCompanyType?.id   == 0) ? 1 :state.atomCompanyType?.id ?? 1,
        name: state.atomCompanyType?.name ?? '');
    PassMgmtLocationregion? locregion = PassMgmtLocationregion(
        id:  (state.locationSelectedlist?.id   == 0) ? 1 : state.locationSelectedlist?.id ?? 1,
        name: state.locationSelectedlist?.name ?? '');

    PassDept? dept2 = PassDept(
        id:  (state.selectedemployeeDepartmentResponse?.id   == 0) ? 1 : state.selectedemployeeDepartmentResponse?.id ?? 1,
        name: state.selectedemployeeDepartmentResponse?.name ?? '');
    PassmgmtInfo info = PassmgmtInfo(
        id:  (state.activePassInfoList?.id   == 0) ? 1 : state.activePassInfoList?.id ?? 1,
        passNo: state.activePassInfoList?.name ?? '');

    //  if (widget.passId == '3') {
    //  }
    //  else
    //  {
       
    //  }     

    PassHost? host2 = PassHost(
        id:  (state.t1hostanalyst?.id   == 0) ? 1 : state.t1hostanalyst?.id ?? 1,
        name: state.t1hostanalyst?.name ?? '');

    PassHost? dbsponsor = PassHost(
        id:  (state.t1dbsponsoranalyst?.id   == 0) ? 1 : state.t1dbsponsoranalyst?.id ?? 1,
        name: state.t1dbsponsoranalyst?.name ?? '');    

     int passtypeIdentify = 0;
      if(passtypeTextController.text == "VISITOR_PASS")  
      {
        passtypeIdentify = 1;
      } 
      else if(passtypeTextController.text == "DWS_VISITOR_PASS")  
      {
        passtypeIdentify = 5;
      }
      else if(passtypeTextController.text == "VENDOR_PASS")  
      {
        passtypeIdentify = 2;
      }
      else if(passtypeTextController.text == "DWS_VENDOR_PASS")  
      {
        passtypeIdentify = 6;
      }
      else if(passtypeTextController.text == "SEZ_PASS")  
      {
        passtypeIdentify = 3;
      }
      else if(passtypeTextController.text == "DAY_PASS")  
      {
        passtypeIdentify = 0;
      }
    int idValidationType = 0;  
    if(photofidentityextController.text == "Adhar Card")  
      {
        idValidationType = 0;
      } 
      else if(photofidentityextController.text == "Pan Card")  
      {
        idValidationType = 1;
      }
      else if(photofidentityextController.text == "Passport")  
      {
        idValidationType = 2;
      }
      else if(photofidentityextController.text == "Driving Licence")  
      {
        idValidationType = 3;
      }
      else if(photofidentityextController.text == "Voter Card")  
      {
        idValidationType = 4;
      }
    int category = 0;  
    if(daypassnoTextController.text == "Permenant")  
      {
        category = 0;
      } 
      else if(daypassnoTextController.text == "Temporary")  
      {
        category = 1;
      }   

    List<CreateImage>? images = getFiles ?? [];
    List<CreateImage>? photoimages = photogetFiles ?? [];
    PassEntrySecurity? entrysecurtity =
        PassEntrySecurity(userId: state.getUserDetailsResponse?.userId ?? 1);
    PassManagement? passmgmtbody;
    if (widget.listuser != null) {
      passmgmtbody = PassManagement(
        id: isFoundId ?? 0,
        updatedStatus: (statusTextController.text.toLowerCase() == "created" || statusTextController.text.toLowerCase() == "handed over") ? updatestatusvalue : null,
        inputDate: inputdate.toString(),
        slNo: serialnumber ?? '',
        location: location,
        status: statusvalue,
        locationRegion: locregion,
        companyName: companynameTextController.text ?? '',
        employeeName: state.t1nameanalyst?.name == null
            ? (nameTextController.text ?? '')
            : state.t1nameanalyst?.name ?? '',
        employeeId: employeeidTextController.text ?? '',
        passType: passtypeIdentify,//int.parse(widget.passId ?? '0'),
        passNo: widget.passId == '3' ? daypassnoTextController.text : state.dayPasselementReason?.name ?? '',
        escortedBy: escortedbyTextController.text ?? '',
        escortedEmployeeId: escortedemployeedidbyTextController.text ?? '',
        hostEmployeeId: hostemployeeidTextController.text.length > 0 ? hostemployeeidTextController.text ?? '' : dbsponsorTextController.text,
        passIssuedOn: passvalidfromdate.toString(),
        endTime: passvaliduntildate.toString(),
        startTime:passvalidfromdate.toString(),
        hostName: dbsponsorTextController.text.isEmpty ? state.t1hostanalyst?.name ?? '' : state.t1dbsponsoranalyst?.name ?? '',
        companyType: companyType,
        images: images,
        entities: entities,
        department: dept2,
        passInfo: info,
        host: dbsponsorTextController.text.isEmpty ?  host2 : dbsponsor,
        email: emailTextController.text ?? '',
        contactNo: contactnoTextController.text ?? '',
        visitingDepartment: dept2,
        visitorName:nameTextController.text ?? "",
        visitorImage:photoimages,
        visitorComingFrom: visitorcomingfromTextController.text ?? '',
        visitingPurpose:visitorcomingfromTextController.text ?? '',
        escortedByHost : state.escortedbyhost == 1 ? true : false,
        idValidationType: idValidationType,
        mifareNo: mtpapplicationnoTextController.text ?? '',
        category: category,
        dayPassReason: daypass,
        entrySecurity: entrysecurtity,
      );
    } else {
      passmgmtbody = PassManagement(
        // id: isFoundId ?? 0,
        inputDate: inputdate.toString(),
        slNo: serialnumber ?? '',
        location: location,
        status: statusvalue,
        locationRegion: locregion,
        companyName: companynameTextController.text ?? '',
        employeeName: state.t1nameanalyst?.name == null
            ? (nameTextController.text ?? '')
            : state.t1nameanalyst?.name ?? '',
        employeeId: employeeidTextController.text ?? '',
        passType: passtypeIdentify,//0,
        passNo:  widget.passId == '3' ? daypassnoTextController.text : state.dayPasselementReason?.name ?? '',
        escortedBy: escortedbyTextController.text ?? '',
        escortedEmployeeId: escortedemployeedidbyTextController.text ?? '',
        hostEmployeeId: hostemployeeidTextController.text.length > 0 ? hostemployeeidTextController.text ?? '' : dbsponsorTextController.text,
        passIssuedOn: passvalidfromdate.toString(),
        endTime: passvaliduntildate.toString(),
        startTime:passvalidfromdate.toString(),
        hostName: dbsponsorTextController.text.isEmpty ? state.t1hostanalyst?.name ?? '' : state.t1dbsponsoranalyst?.name ?? '',
        companyType: companyType,
        images: images,
        entities: entities,
        department: dept2,
        passInfo: info,
        host: dbsponsorTextController.text.isEmpty ? host2 : dbsponsor,
        contactNo: contactnoTextController.text ?? '',
        visitingDepartment: dept2,
        visitorName:nameTextController.text ?? "",
        visitorImage:photoimages,
        visitorComingFrom: visitorcomingfromTextController.text ?? '',
        visitingPurpose:visitorcomingfromTextController.text ?? '',
        escortedByHost : state.escortedbyhost == 1 ? true : false,
        idValidationType: idValidationType,
        mifareNo: mtpapplicationnoTextController.text ?? '',
        category: category,
        dayPassReason: daypass,
        email: emailTextController.text ?? '',
        entrySecurity: entrysecurtity
      );
    }
    showLoadingDialog(context);
    var username = await SharedPrefs.getUsername();
    CreatePassMgmtBody body = CreatePassMgmtBody(passManagement: passmgmtbody);
    createpassmgmtCubit.creatpasseNewFoundArticle(
        body,
        isSubmit,
        context,
        username,
        widget.listuser != null
            ? widget.title ?? ''
            : widget.title ?? '');
  }

  passValidations(BuildContext context, CreatePassMgmtState state) {
    if (statusTextController.text.isEmpty &&
        state.getUserDetailsResponse == null &&
        state.locationSelectedlist == null &&
        dateofcreationTextController.text.isEmpty &&
        serialnumber == null &&
        state.listOfEntities == null &&
        passvalidfromTextController.text.isEmpty &&
        passvaliduntilTextController.text.isEmpty &&
        escortedemployeedidbyTextController.text.isEmpty &&
        escortedbyTextController.text.isEmpty &&
        passtypeTextController.text.isEmpty &&
        state.selectedemployeeDepartmentResponse == null &&
        state.atomCompanyType == null &&
        state.dayPasselementReason == null) {
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
    } else if (serialnumber != null && (serialnumber ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter serial number",
      );
    } else if (state.listOfEntities == null) {
      Validator().showToast(
        context,
        "Please enter entitiy",
      );
    } else if (widget.passId == '0' && state.atomCompanyType == null) {
      Validator().showToast(
        context,
        "Please enter company type",
      );
    } else if (widget.passId == '0' && companynameTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter company name",
      );
    } else if ((widget.passId == '0' && (state.atomCompanyType?.name ?? '').toLowerCase() == 'fte' &&
        (state.t1nameanalyst?.name ?? '').isEmpty)) {
      Validator().showToast(
        context,
        "Please enter name",
      );
    } else if (widget.passId == '0'  && nameTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter name",
      );
    } else if (widget.passId == '0'  &&  (state.atomCompanyType?.name ?? '').toLowerCase() !=
            'exceptions' &&
        employeeidTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter employeed id",
      );
    } else if ( (widget.passId == '0' && (state.atomCompanyType?.name ?? '').toLowerCase() == 'cwr t1' &&
        emailTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter email",
      );
    } else if ((state.atomCompanyType?.name ?? '').toLowerCase() ==
            'exceptions' &&
        (state.t1hostanalyst?.name ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter host",
      );
    } else if ((state.atomCompanyType?.name ?? '').toLowerCase() ==
            'exceptions' &&
        hostemployeeidTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter host employeed id",
      );
    } else if ( (widget.passId == '0' && (state.selectedemployeeDepartmentResponse == null ||
        (state.selectedemployeeDepartmentResponse?.name ?? '').isEmpty))) {
      Validator().showToast(
        context,
        "Please enter department",
      );
    } else if ( widget.passId == '0' && (state.dayPasselementReason == null ||
        (state.dayPasselementReason?.name ?? '').isEmpty)) {
      Validator().showToast(
        context,
        "Please enter reason for day pass",
      );
    } else if (  widget.passId == '0' && (state.activePassInfoList == null ||
        (state.activePassInfoList?.name ?? '').isEmpty)) {
      Validator().showToast(
        context,
        "Please enter day pass no",
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
    } else if ( widget.passId == '0' && (escortedbyTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter host escorted by",
      );
    } else if (widget.passId == '0' && (escortedemployeedidbyTextController.text.isEmpty)) {
      Validator().showToast(
        context,
        "Please enter host escort employeed id",
      );
    } else {
      passSubmit(true, widget.listuser?.id ?? 0, globalState);
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
        // setState(() {});
      },
      validateTextField: (String? user) {},
    );
  }

  Widget attachmentListviews(
    List<CreateImage>? attachmentListviews,
    List<FoundImage>? attachmentListviews1,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFCACACA),
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              attachmentListviews1?.length ?? attachmentListviews?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            CreateImage? imagedata;
            FoundImage? imagedata1;
            if (widget.listuser != null) {
              imagedata1 = attachmentListviews1?[index];
            } else {
              imagedata = attachmentListviews?[index];
            }

            return Column(
              children: <Widget>[
                ListTile(
                  trailing: widget.listuser != null
                      ? SvgPicture.asset(AppIcon.download,
                          color: AppColors.boldgreyBackground)
                      : SizedBox(
                          height: 0,
                          width: 0,
                        ),
                  onTap: () {
                    DownloadImage().saveImage(
                        context, imagedata1?.id ?? 0, imagedata1?.title ?? '');
                  },
                  title: widget.listuser != null
                      ? Text(imagedata1?.title ?? '')
                      : Text(imagedata?.title ?? ''),
                ),

                Divider(
                  color: Color(0xFFCACACA),
                  thickness: 1,
                ), //                           <-- Divider
              ],
            );
          }),
    );
  }

  Widget textfieldWidgetLoad(TextEditingController textController, int index,
      CreatePassMgmtState state) {
    return FlutterInputField(
      //lineHeight: textController == employeeidTextController ? 1 : 1,
      onTap: () {},
      textFieldController: textController,
      textFormKey: Keys.colorTextController,
      // isEnable:
      //     widget.listuser == null
      //     ? true
      //     : (widget.listuser != null &&
      //             (textController.text ?? '')
      //                 .isEmpty) ?
      //     true
      //     : false,
      //     isDisableColor: (widget.listuser != null &&
      //                 (textController.text ?? '')
      //                     .isEmpty) ||
      //             widget.listuser == null
      //         ? false
      //         :
      //     true,
      hintText: '',
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
  final DayPassListItemResponse? listuser;

  CreatePassMngArguments(
      this.passType, this.title, this.isRegistry, this.listuser);
}
