import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
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
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/views/add_employee_deparment.dart';
import 'package:db_atom/src/features/createfound/views/upload_attachment.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/lawenforcement/models/dropdown_object.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_state.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/company_type_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/create_pass_mgmt_request_body.dart';
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
  CreatePassManagement({super.key, this.listuser});

  @override
  State<CreatePassManagement> createState() => _CreatePassManagementState();
}

class _CreatePassManagementState extends State<CreatePassManagement> {
  final GlobalKey<FormState> lawenforcementFormKey = GlobalKey<FormState>();
  TextEditingController statusTextController = TextEditingController();
  TextEditingController passvalidfromTextController = TextEditingController();
  TextEditingController passvaliduntilTextController = TextEditingController();
  TextEditingController companynameTextController = TextEditingController();
  TextEditingController employeeidTextController = TextEditingController();
  TextEditingController hostemployeeidTextController = TextEditingController();
  TextEditingController escortedbyTextController = TextEditingController();
  TextEditingController escortedemployeedidbyTextController =
      TextEditingController();
  TextEditingController daypassnoTextController = TextEditingController();
  TextEditingController passtypeTextController = TextEditingController();

  TextEditingController dateofcreationTextController = TextEditingController();

  List<CreateImage>? getFiles;
  List<FoundImage>? getAttachments;
  late CreatePassMgmtState globalState;
  String? serialnumber;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
        appBar: AppHeader(
          isTitleCenter: false,
          title: widget.listuser != null
              ? Constants.editlawenforcement
              : 'Create Pass Management',
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
                passSubmit(
                    false, widget.listuser?.id ?? 0, globalState);
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

                                    //created by

                                    CommonWidgets.horizentaltextHandling(
                                        Constants.createdby,
                                        state.getUserDetailsResponse
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
                                        // if (widget.listuser == null ||
                                        //     passtypeTextController
                                        //         .text.isEmpty) {
                                        //   //passTypeDialog();
                                        // }
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
                                            // if (widget.listuser == null ||
                                            //     passtypeTextController
                                            //         .text.isEmpty) {
                                            //   //passTypeDialog();
                                            // }
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

                                                // passTypeDialog();
                                              })),
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Company Type
                                    CommonWidgets.textDisplay(
                                        Constants.companytype,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    companytypeaddButtonwidgetLoading(state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Company Name
                                    CommonWidgets.textDisplay(
                                        Constants.companyname,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    textfieldWidgetLoad(
                                        companynameTextController, 0, state),

                                    // Name
                                    CommonWidgets.textDisplay(Constants.name,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    nameaddButtonwidgetLoading(state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Employee Id
                                    CommonWidgets.textDisplay(
                                        Constants.employeeid,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    textfieldWidgetLoad(
                                        employeeidTextController, 0, state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Host
                                    CommonWidgets.textDisplay(Constants.host,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    hostaddButtonwidgetLoading(state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Host Employee Id
                                    CommonWidgets.textDisplay(
                                        Constants.hostemployeeid,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    textfieldWidgetLoad(
                                        hostemployeeidTextController, 0, state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // DB official department
                                    CommonWidgets.textDisplay(
                                        Constants.department,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    departmentaddButtonwidgetLoading(state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Reason for day pass
                                    CommonWidgets.textDisplay(
                                        Constants.reasonfordaypass,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    reasonforadaypassaddButtonwidgetLoading(
                                        state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Day  pass no
                                    CommonWidgets.textDisplay(
                                        Constants.daypassno,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    GestureDetector(
                                      onTap: () {
                                        if (widget.listuser == null ||
                                            daypassnoTextController
                                                .text.isEmpty) {
                                          daypassNoDialog();
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
                                              daypassNoDialog();
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

                                                daypassNoDialog();
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

                                    // Escorted By
                                    CommonWidgets.textDisplay(
                                        Constants.escortedby,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    textfieldWidgetLoad(
                                        escortedbyTextController, 0, state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Escorted By
                                    CommonWidgets.textDisplay(
                                        Constants.escortedbyemployeeid,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    textfieldWidgetLoad(
                                        escortedemployeedidbyTextController,
                                        0,
                                        state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

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
                                        ? uploadWidget(state)
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

  @override
  void initState() {
    super.initState();
    if (widget.listuser != null) {
      editCreatefoundItems();
    } else {
      createpassmgmtCubit.initalization();
    }
    passtypeTextController.text = 'DAY_PASS';
    getLawenforcementList();
    _getCurrentDate();
  }

  editCreatefoundItems() async {
    if (widget.listuser != null) {
      await SharedPrefs.setFoundId(widget.listuser?.id ?? 0);

      // employeeidTextController.text =
      //     widget.listuser?.additionalInformation != null
      //         ? widget.listuser?.additionalInformation.toString() ?? ""
      //         : '';
      // companynameTextController.text = widget.listuser?.dbOfficialEmail != null
      //     ? widget.listuser?.dbOfficialEmail.toString() ?? ""
      //     : '';
      // passvalidfromTextController.text = widget.listuser?.timeOfVisit != null &&
      //         widget.listuser?.timeOfVisit != '0'
      //     ? Utils.timestamptoDateConversion(
      //         int.parse(widget.listuser?.timeOfVisit ?? '0'),
      //         Constants.fulldateFormat)
      //     : '';
      // passvaliduntilTextController.text =
      //     widget.listuser?.timeOfVisit != null &&
      //             widget.listuser?.timeOfVisit != '0'
      //         ? Utils.timestamptoDateConversion(
      //             int.parse(widget.listuser?.timeOfVisit ?? '0'),
      //             Constants.fulldateFormat)
      //         : '';
      // dateofcreationTextController.text = widget.listuser?.inputDate != null &&
      //         widget.listuser?.inputDate != '0'
      //     ? Utils.timestamptoDateConversion(
      //         int.parse(widget.listuser?.inputDate ?? '0'),
      //         Constants.fulldateFormat)
      //     : dateofcreationTextController.text;
      // List<VisitingOfficial>? visitingOfficials = widget.listuser?.visitingOfficials != null ? widget.listuser?.visitingOfficials ?? [] : [];
      statusTextController.text = widget.listuser?.status == 0
          ? "Draft"
          : widget.listuser?.status == 1
              ? "Submitted"
              : widget.listuser?.status == 3
                  ? "Distributed"
                  : "Handover";

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

      await lawenforcementCubit.getSerialnumberDetails(
          (widget.listuser?.location?.id ?? 0).toString(), 'AF');

      lawenforcementCubit.getlocationsResponseData(mumbai);

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
        lawenforcementCubit.getEntityData(entities);
      }
      // state.selectedemployeeDepartmentResponse
      // EmployeeDepartment emp =
      //     widget.listuser?.dbOfficialEmailDepartment != null
      //         ? EmployeeDepartment(
      //             id: widget.listuser?.dbOfficialEmailDepartment?.id ?? 0,
      //             name: widget.listuser?.dbOfficialEmailDepartment?.name ?? '')
      //         : EmployeeDepartment();
      // lawenforcementCubit.getemployeeDepartmentsResponseData(emp);
      getAttachments =
          widget.listuser?.images != null ? widget.listuser?.images ?? [] : [];
    }
  }

  getLawenforcementList() async {
    var userid = await SharedPrefs.getUserId();
    await createpassmgmtCubit.getLocations('ATOM_LOCATIONS');
    await createpassmgmtCubit.getEntities('ATOM_ENTITIES');
    await createpassmgmtCubit.getEmployeeDepartments('EMPLOYEE_DEPARTMENTS');
    await createpassmgmtCubit.getUserDetails(userid);
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
          passSubmit(true, widget.listuser?.id ?? 0, globalState);
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

  // passTypeDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return CustomSimpleListTexts(
  //           texts: ["Personal", "company"],
  //           onTap: (String value) {
  //             print(value);
  //             passtypeTextController.text = value;
  //             setState(() {});
  //           },
  //         );
  //       });
  // }

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
        isDisableColor:true,
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
   String nextformattedDate =  DateFormat(Constants.fulldateFormat).format(_currentDate.add(Duration(days: 1)));
    dateofcreationTextController.text = formattedDate;
    passvalidfromTextController.text =  formattedDate;
    passvaliduntilTextController.text = nextformattedDate;
    if (widget.listuser == null) {
      statusTextController.text = 'Draft';
    }
  }

  Widget uploadWidget(CreatePassMgmtState state) {
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
                                getFiles: getFiles ?? [],
                                createpassmgmtstate: state,
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
            // leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              // Navigator.pop(context);
              // showDialog(
              //     context: context,
              //     builder: (BuildContext dialogContext) {
              //       return const AddEmployeeDepartment(
              //         title: Constants.addarticletype,
              //       );
              //     });
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
            // leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              // Navigator.pop(context);
              // showDialog(
              //     context: context,
              //     builder: (BuildContext dialogContext) {
              //       return const AddEmployeeDepartment(
              //         title: Constants.addarticletype,
              //       );
              //     });
            },
            onTap: (AtomCompanyType list) {
              //print(list.name);
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
                  ((state.t1nameanalyst?.name ?? '')
                      .isEmpty))
          ? false
          : true,
      onTap: () {
        if (widget.listuser == null ||
            (state.t1nameanalyst != null &&
                ((state.t1nameanalyst?.name ?? '')
                    .isEmpty))) {
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
            duplicatet1Analyst:
                state.analyst?.t1Analyst ?? [],
            // leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              // Navigator.pop(context);
              // showDialog(
              //     context: context,
              //     builder: (BuildContext dialogContext) {
              //       return const AddEmployeeDepartment(
              //         title: Constants.addarticletype,
              //       );
              //     });
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
                  ((state.t1hostanalyst?.name ?? '')
                      .isEmpty))
          ? false
          : true,
      onTap: () {
        if (widget.listuser == null ||
            (state.t1hostanalyst != null &&
                ((state.t1hostanalyst?.name ?? '')
                    .isEmpty))) {
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
            duplicatet1Analyst:
                state.analyst?.t1Analyst ?? [],
            // leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              // Navigator.pop(context);
              // showDialog(
              //     context: context,
              //     builder: (BuildContext dialogContext) {
              //       return const AddEmployeeDepartment(
              //         title: Constants.addarticletype,
              //       );
              //     });
            },
            onTap: (T1Analyst list) {
              //print(list.name);
              createpassmgmtCubit.gethostanalystsResponseData(list);
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

    List<PassMgmtTypEntity>? entities = [];
    if ((state.listOfEntities?.length ?? 0) > 0) {
      for (int i = 0; i < state.listOfEntities!.length; i++) {
        AtomEntity entity = state.listOfEntities![i];
        PassMgmtTypEntity addentiity =
            PassMgmtTypEntity(id: entity.id ?? 1);
        entities.add(addentiity);
      }
    }
    PassMgmtLocation? location = PassMgmtLocation(
        id: state.locationSelectedlist?.id ?? 1,
        name: state.locationSelectedlist?.name ?? '');
    PassCompanyType? companyType = PassCompanyType(
        id: state.atomCompanyType?.id ?? 1,
        name: state.atomCompanyType?.name ?? '');    
   PassMgmtLocationregion? locregion = PassMgmtLocationregion(
        id: state.locationSelectedlist?.id ?? 1,
        name: state.locationSelectedlist?.name ?? '');

        

    List<CreateImage>? images = getFiles ?? [];
    PassManagement? passmgmtbody;
    //if (widget.listuser != null) {
      passmgmtbody = PassManagement(
        id: isFoundId ?? 0,
        inputDate: inputdate.toString(),
        slNo: serialnumber ?? '',
        location: location,
        status: statusvalue,
        locationRegion: locregion,
        companyName:companynameTextController.text ?? '',
        employeeName:state.t1nameanalyst?.name ?? '',
        employeeId: employeeidTextController.text ?? '',
        passType: 0,
        passNo: state.dayPasselementReason?.name ?? '',
        escortedBy: escortedbyTextController.text ?? '',
        escortedEmployeeId: escortedemployeedidbyTextController.text ?? '',
        hostEmployeeId: hostemployeeidTextController.text ?? '',
        passIssuedOn: passvalidfromdate.toString(),
        endTime: passvalidfromdate.toString(),
        hostName: state.t1hostanalyst?.name ?? '',
        companyType:companyType ,
        images: images,
        entities: entities,
       
      );
  //  } else {
      // passmgmtbody = PassManagement(
      //     inputDate: inputdate.toString(),
      //     slNo: serialnumber ?? '',
      //     location: location,
      //     status: statusvalue,
      //     images: images,
      //     timeOfVisit: actualdate.toString(),
      //     entities: entities,
      //     additionalInformation: employeeidTextController.text ?? '',
      //     dbOfficialAccompaniedEmail: state.getuserResponse != null
      //         ? ((state.getuserResponse?.name ?? '') +
      //             '(' +
      //             (state.getuserResponse?.email ?? '') +
      //             ')')
      //         : '',
      //     // dbOfficialEmail: dbofficailwanttimeetTextController.text ?? '',
      //    );
  // }
    showLoadingDialog(context);
   var username = await SharedPrefs.getUsername();
    CreatePassMgmtBody body =
        CreatePassMgmtBody(passManagement: passmgmtbody);
    createpassmgmtCubit.creatpasseNewFoundArticle(
        body,
        isSubmit,
        context,
        username,
        widget.listuser != null
            ? 'edit Pass Managemnt'
            : 'Create Pass Managemnt');
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
        employeeidTextController.text.isEmpty &&
        passtypeTextController.text.isEmpty &&
        state.selectedemployeeDepartmentResponse == null && state.atomCompanyType == null && state.t1hostanalyst == null && state.t1nameanalyst == null && state.dayPasselementReason == null)  {
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
    } 
    else if (state.atomCompanyType == null) {
      Validator().showToast(
        context,
        "Please enter company type",
      );
    } 
    else if (companynameTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter company name",
      );
    } 
     else if (state.t1nameanalyst == null) {
      Validator().showToast(
        context,
        "Please enter name",
      );
    } 
    else if (employeeidTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter employeed id",
      );
    } 
     else if (state.t1hostanalyst == null) {
      Validator().showToast(
        context,
        "Please enter host",
      );
    } 
    else if (hostemployeeidTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter host employeed id",
      );
    } 
    else if (state.employeeDepartment == null) {
      Validator().showToast(
        context,
        "Please enter department",
      );
    } 
     else if (state.dayPasselementReason == null) {
      Validator().showToast(
        context,
        "Please enter reason for day pass",
      );
    } 
     else if (state.dayPasselementReason == null) {
      Validator().showToast(
        context,
        "Please enter day pass no",
      );
    } 
    else if (passvalidfromTextController.text.isEmpty) {
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
    else if (escortedbyTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter host escorted by",
      );
    } 
    else if (escortedemployeedidbyTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter host escort employeed id",
      );
    } 
     else {
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
      lineHeight: textController == employeeidTextController ? 1 : 1,
      onTap: () {},
      textFieldController: textController,
      textFormKey: Keys.colorTextController,
      isEnable:
          //widget.listuser == null
          // ? true
          // : (widget.listuser != null &&
          //         (widget.listuser?.color ?? '')
          //             .isEmpty) ?
          // true
          // : false,
          // isDisableColor: (widget.listuser != null &&
          //             (widget.listuser?.color ?? '')
          //                 .isEmpty) ||
          //         widget.listuser == null
          //     ? false
          //     :
          true,
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
