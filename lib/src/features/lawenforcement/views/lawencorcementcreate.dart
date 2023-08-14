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
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/models/serial_number_model.dart';
import 'package:db_atom/src/features/createfound/views/add_employee_deparment.dart';
import 'package:db_atom/src/features/createfound/views/create_found_newuser.dart';
import 'package:db_atom/src/features/createfound/views/upload_attachment.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_cubit.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_state.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/lawenforcement/models/distribution_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/dropdown_object.dart';
import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';
import 'package:db_atom/src/features/lawenforcement/models/leodepartments.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';
import 'package:db_atom/src/features/lawenforcement/services/lawenforcementservice.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreateLawenforcement extends StatefulWidget {
  LawEnforcementDetails? listuser;
  CreateLawenforcement({super.key, this.listuser});

  @override
  State<CreateLawenforcement> createState() => _CreateLawenforcementState();
}

class _CreateLawenforcementState extends State<CreateLawenforcement> {
  final GlobalKey<FormState> lawenforcementFormKey = GlobalKey<FormState>();
  TextEditingController statusTextController = TextEditingController();
  TextEditingController actualdateTextController = TextEditingController();
  TextEditingController dbofficailwanttimeetTextController =
      TextEditingController();
  TextEditingController additionalinformationTextController =
      TextEditingController();
  TextEditingController nameTextController1 = TextEditingController();
  TextEditingController designationTextController1 = TextEditingController();
  TextEditingController officeaddressTextController1 = TextEditingController();
  TextEditingController emailidTextController1 = TextEditingController();
  TextEditingController contactnoTextController1 = TextEditingController();
  TextEditingController nameTextController2 = TextEditingController();
  TextEditingController designationTextController2 = TextEditingController();
  TextEditingController officeaddressTextController2 = TextEditingController();
  TextEditingController emailidTextController2 = TextEditingController();
  TextEditingController contactnoTextController2 = TextEditingController();
  TextEditingController nameTextController3 = TextEditingController();
  TextEditingController designationTextController3 = TextEditingController();
  TextEditingController officeaddressTextController3 = TextEditingController();
  TextEditingController emailidTextController3 = TextEditingController();
  TextEditingController contactnoTextController3 = TextEditingController();
  TextEditingController distributiongroupsTextController =
      TextEditingController();
  TextEditingController dateofcreationTextController = TextEditingController();

  List<CreateImage>? getFiles;
  List<FoundImage>? getAttachments;
  late LawEnforcementState globalState;
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
              : Constants.createlawenforcement,
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
                createLawEnforcement(
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
                lawenforcementValidations(context, globalState);
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
        body: BlocBuilder<LawEnforcementCubit, LawEnforcementState>(
          builder: (context, state) {
            // listOfEntities = state.getEntitiesResponse;
            //leoDepartmentsResponse = state.getLeodepartmentsResponse;
            // leoPurposeVisitResponse = state.getLeopurposeResponse;

            if (state.getSerialnumberResponse != null) {
              serialnumber = state.getSerialnumberResponse?.serialNo ?? "";
            }
            globalState = state;
            if (state.stateType == LawEnforcementStateType.addattachment) {
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

                                    // article type
                                    CommonWidgets.textDisplay(Constants.entity,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    entityaddButtonwidgetLoading(state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Actual time of visit
                                    CommonWidgets.textDisplay(
                                        Constants.actualtimeofvisit,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    datepickerWidgetLoading(
                                        actualdateTextController),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Officials ID Card Verified?
                                    CommonWidgets.textDisplay(
                                        Constants.officialsidcardverified,
                                        Styles.textStyleBlack14),
                                    radioButtonHandling(
                                        state.isOfficialIdcardSelected ?? 1,
                                        Constants.officialsidcardverified),

                                    // Purpose of visit
                                    CommonWidgets.textDisplay(
                                        Constants.purposeofvsit,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    purposeofvisitaddButtonwidgetLoading(state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // Document if any to confirm purpose
                                    CommonWidgets.textDisplay(
                                        Constants.documentifanytoconfirmpurpose,
                                        Styles.textStyleBlack14),
                                    radioButtonHandling(
                                        state.isDocumentifanySelected ?? 1,
                                        Constants
                                            .documentifanytoconfirmpurpose),

                                    // In case of Police, was official in uniform?
                                    CommonWidgets.textDisplay(
                                        Constants
                                            .incaseofpolicewasofficialinuniform,
                                        Styles.textStyleBlack14),
                                    radioButtonHandling(
                                        state.isIncaseofpoliceSelected ?? 1,
                                        Constants
                                            .incaseofpolicewasofficialinuniform),

                                    // DB official want to meet
                                    CommonWidgets.textDisplay(
                                        Constants.dbofficialwanttomeet,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    textfieldWidgetLoad(
                                        dbofficailwanttimeetTextController,
                                        0,
                                        state),

                                    // DB official department
                                    CommonWidgets.textDisplay(
                                        Constants.dbofficialdepartment,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    dbwanttodepartmentaddButtonwidgetLoading(
                                        state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    //DB Official email ID Accompanied LEO official'
                                    CommonWidgets.textDisplay(
                                        Constants
                                            .dbofficialemailidaccompaniedleoofficial,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    // articleaddButtonwidgetLoading(state),
                                    dbofficialemailidaddButtonwidgetLoading(
                                        state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // additional information
                                    CommonWidgets.textDisplay(
                                        Constants.additionalinformation,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    textfieldWidgetLoad(
                                        additionalinformationTextController,
                                        0,
                                        state),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                  ]),
                                ),

                                // CommonWidgets.indentedDivider(Colors.black),
                                Divider(
                                  color: AppColors.textgreyThemecolor,
                                  thickness: 1,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20),
                                  child: Column(children: [
                                    // Visiting Official Details
                                    CommonWidgets.textDisplay(
                                        Constants.visitingofficialdetails,
                                        Styles.textStyleDarkGrey16),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                    // Add another visiting
                                    GestureDetector(
                                      onTap: () {
                                        if ((state.getVisitsCount ?? 0) < 3) {
                                          int value =
                                              (state.getVisitsCount ?? 0) + 1;
                                          List<VistingOfficialsModel>?
                                              getVisits1 =
                                              state.getVisits ?? [];
                                          getVisits1
                                              .add(VistingOfficialsModel());
                                          lawenforcementCubit.addingVisitis(
                                              value, getVisits1);
                                        } else {
                                          Validator().showToast(
                                            context,
                                            "You have reached maximum visting official details adding",
                                          );
                                        }
                                      },
                                      child: Container(
                                          child: Row(
                                        children: <Widget>[
                                          // Expanded(
                                          //child:
                                          SvgPicture.asset(
                                            AppIcon.pluscircle,
                                            //color: AppColors.navigationSkybluecolor,
                                          ),
                                          // ),
                                          SizedBox(width: 10),

                                          Text(
                                            Constants
                                                .addanothervisitingofficialdetails,
                                            style: TextStyle(
                                              color: AppColors
                                                  .navigationSkybluecolor,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),

                                    //

                                    (state.getVisitsCount ?? 0) > 0
                                        ? listVisitingOfficialDetails(
                                            height,
                                            width,
                                            context,
                                            state,
                                            state.getVisitsCount ?? 0)
                                        : Container(),
                                    widget.listuser == null
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),

                                    // Upload
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

                                    // Distribution Groups
                                    widget.listuser != null
                                        ? CommonWidgets.textDisplay(
                                            Constants.distributiongroups,
                                            Styles.textStyleBlack14)
                                        : Container(),
                                    widget.listuser != null
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.001)
                                        : Container(),
                                    widget.listuser != null
                                        ? textfieldWidgetLoad(
                                            distributiongroupsTextController,
                                            0,
                                            state)
                                        : Container(),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    // SubmitButton
                                    Center(child: submitButtonDisplay()),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.005),
                                  ]),
                                )
                              ])))
                ])));
          },
        )); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  Widget listVisitingOfficialDetails(
      double height,
      double width,
      BuildContext context,
      LawEnforcementState state,
      int visitingOfficialDetailsArray) {
    return Column(children: <Widget>[
      for (int i = 0; i < visitingOfficialDetailsArray; i++)

        // Name
        loadData(
            height, width, context, state, visitingOfficialDetailsArray, i),
    ]);
  }

  Widget loadData(double height, double width, BuildContext context,
      LawEnforcementState state, int visitingOfficialDetailsArray, int index) {
    // TextEditingController name = TextEditingController();
    // TextEditingController address = TextEditingController();
    // TextEditingController conatctno = TextEditingController();
    // TextEditingController emailid = TextEditingController();
    // TextEditingController designation = TextEditingController();

    //}
    return Column(children: [
      GestureDetector(
          onTap: () {
            int value = (state.getVisitsCount ?? 0) - 1;
            List<VistingOfficialsModel>? getVisits1 = state.getVisits ?? [];
            getVisits1.removeAt(index);
            lawenforcementCubit.addingVisitis(value, getVisits1);
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              AppIcon.closeicon,
              color: AppColors.navigationSkybluecolor,
            ),
          ) //Icon(Icons.cancel)
          ),
      CommonWidgets.verticalSpacerWidget(height * 0.002),
      CommonWidgets.textDisplay(Constants.name, Styles.textStyleBlack14),
      CommonWidgets.verticalSpacerWidget(height * 0.001),
      textfieldWidgetLoad(
          index == 0
              ? nameTextController1
              : index == 1
                  ? nameTextController2
                  : nameTextController3,
          index,
          state),
      CommonWidgets.verticalSpacerWidget(height * 0.01),

      // Designation
      CommonWidgets.textDisplay(Constants.designation, Styles.textStyleBlack14),
      CommonWidgets.verticalSpacerWidget(height * 0.001),
      textfieldWidgetLoad(
          index == 0
              ? designationTextController1
              : index == 1
                  ? designationTextController2
                  : designationTextController3,
          index,
          state),
      CommonWidgets.verticalSpacerWidget(height * 0.01),

      // Department
      CommonWidgets.textDisplay(Constants.department, Styles.textStyleBlack14),
      CommonWidgets.verticalSpacerWidget(height * 0.001),
      // articleaddButtonwidgetLoading(state),
      departmentaddButtonwidgetLoading(state, index),
      CommonWidgets.verticalSpacerWidget(height * 0.01),

      // Office Address
      CommonWidgets.textDisplay(
          Constants.officeaddress, Styles.textStyleBlack14),
      CommonWidgets.verticalSpacerWidget(height * 0.001),
      textfieldWidgetLoad(
          index == 0
              ? officeaddressTextController1
              : index == 1
                  ? officeaddressTextController2
                  : officeaddressTextController3,
          index,
          state),
      CommonWidgets.verticalSpacerWidget(height * 0.01),

      // Email Id
      CommonWidgets.textDisplay(Constants.emailid, Styles.textStyleBlack14),
      CommonWidgets.verticalSpacerWidget(height * 0.001),
      textfieldWidgetLoad(
          index == 0
              ? emailidTextController1
              : index == 1
                  ? emailidTextController2
                  : emailidTextController3,
          index,
          state),
      CommonWidgets.verticalSpacerWidget(height * 0.01),

      // Conatct No
      CommonWidgets.textDisplay(Constants.contactno, Styles.textStyleBlack14),
      CommonWidgets.verticalSpacerWidget(height * 0.001),
      textfieldWidgetLoad(
          index == 0
              ? contactnoTextController1
              : index == 1
                  ? contactnoTextController2
                  : contactnoTextController3,
          index,
          state),
      CommonWidgets.verticalSpacerWidget(height * 0.02),
    ]);
  }

  @override
  void initState() {
    super.initState();
    if (widget.listuser != null) {
      editCreatefoundItems();
      lawenforcementCubit.getDistributionGroupsDetails();
    } else {
      lawenforcementCubit.initalization();
    }

    getLawenforcementList();
    _getCurrentDate();
  }

  editCreatefoundItems() async {
    if (widget.listuser != null) {
      await SharedPrefs.setFoundId(widget.listuser?.id ?? 0);

      additionalinformationTextController.text =
          widget.listuser?.additionalInformation != null
              ? widget.listuser?.additionalInformation.toString() ?? ""
              : '';
      dbofficailwanttimeetTextController.text =
          widget.listuser?.dbOfficialEmail != null
              ? widget.listuser?.dbOfficialEmail.toString() ?? ""
              : '';
      actualdateTextController.text = widget.listuser?.timeOfVisit != null &&
              widget.listuser?.timeOfVisit != '0'
          ? Utils.timestamptoDateConversion(
              int.parse(widget.listuser?.timeOfVisit ?? '0'),
              Constants.fulldateFormat)
          : '';
      dateofcreationTextController.text = widget.listuser?.inputDate != null &&
              widget.listuser?.inputDate != '0'
          ? Utils.timestamptoDateConversion(
              int.parse(widget.listuser?.inputDate ?? '0'),
              Constants.fulldateFormat)
          : dateofcreationTextController.text;
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
      int isDocumentifanySelected1 =
          ((widget.listuser?.documentVerified ?? false) == true) ? 1 : 0;
      int isOfficialIdcardSelected1 =
          ((widget.listuser?.officialCardVerified ?? false) == true) ? 1 : 0;
      int isIncaseofpoliceSelected1 =
          ((widget.listuser?.visitorInUniform ?? false) == true) ? 1 : 0;

      lawenforcementCubit.getRadioButtonSelected(
          Constants.documentifanytoconfirmpurpose,
          isDocumentifanySelected1,
          isDocumentifanySelected1 == 1 ? "Yes" : "No");
      lawenforcementCubit.getRadioButtonSelected(
          Constants.officialsidcardverified,
          isOfficialIdcardSelected1,
          isOfficialIdcardSelected1 == 1 ? "Yes" : "No");
      lawenforcementCubit.getRadioButtonSelected(
          Constants.incaseofpolicewasofficialinuniform,
          isIncaseofpoliceSelected1,
          isIncaseofpoliceSelected1 == 1 ? "Yes" : "No");

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

      if ((widget.listuser?.mailList?.length ?? 0) > 0) {
        //for (int i = 0; i < widget.listuser!.entities!.length; i++) {
        DistributionGroup entity = widget.listuser?.mailList != null &&
                (widget.listuser?.mailList?.length ?? 0) > 0
            ? DistributionGroup(
                id: widget.listuser?.mailList![0]["groupId"] ?? 0,
                name: widget.listuser?.mailList![0]["name"] ?? "")
            : DistributionGroup();
        // AtomEntity entity = state.listOfEntities![i];
        //   DbOfficialEmailDepartment addentiity =
        // DbOfficialEmailDepartment(id: entity.id ?? 1);
        //distributionGroups.add(entity);
        lawenforcementCubit.geDistributonData(entity);
        distributiongroupsTextController.text =
            widget.listuser?.mailList![0]["name"] ?? "";
      }

      // state.groups?.distributionGroups
      // }

      AtomLeoPurposeVisit visit = widget.listuser?.visitPurpose != null
          ? AtomLeoPurposeVisit(
              id: widget.listuser?.visitPurpose?.id ?? 0,
              name: widget.listuser?.visitPurpose?.name ?? "")
          : AtomLeoPurposeVisit();
      lawenforcementCubit.getleopurposeResponseData(visit);

      AtomStaticUser staticUser =
          widget.listuser?.dbOfficialEmailDepartment != null
              ? AtomStaticUser(
                  id: widget.listuser?.dbOfficialEmailDepartment?.id ?? 0,
                  name: widget.listuser?.dbOfficialEmailDepartment?.name ?? "",
                  email: widget.listuser?.dbOfficialAccompaniedEmail ?? '')
              : AtomStaticUser();

      lawenforcementCubit.geDBOfficialyData(staticUser);

      List<LawVisitingOfficial>? visiting =
          widget.listuser?.visitingOfficials != null
              ? widget.listuser?.visitingOfficials ?? []
              : [];

      List<VistingOfficialsModel>? visitingOfficials = [];
      if (visiting.length > 0) {
        for (int i = 0; i < visiting.length; i++) {
          LawVisitingOfficial model = visiting[i];
          AtomLeoDepartment dept = AtomLeoDepartment(
              id: model.department?.id ?? 1,
              name: model.department?.name ?? '');
          VistingOfficialsModel obj = VistingOfficialsModel(
              officialaddress: model.address ?? '',
              name: model.name ?? '',
              conatctno: model.contactNo ?? '',
              designation: model.designation ?? '',
              email: model.email ?? '',
              department: dept,
              id: model.id);
          visitingOfficials.add(obj);
          lawenforcementCubit.getleoDepartmentsResponseData(dept);

          //AtomLeoDepartment dept = AtomLeoDepartment();

          // if (widget.listuser != null && (state.getVisits?.length ?? 0) > 0) {
          //   VistingOfficialsModel model = state.getVisits![index];
          //for (int i = 0; i < visiting.length; i++) {
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
          }
          // dept = model != null
          //     ? AtomLeoDepartment(
          //         id: model.department?.id ?? 1, name: model.department?.name ?? '')
          //     : AtomLeoDepartment();
          // lawenforcementCubit.getleoDepartmentsResponseData(dept);
//}
        }
      }

      lawenforcementCubit.addingVisitis(
          visitingOfficials.length, visitingOfficials);

      // state.selectedemployeeDepartmentResponse
      EmployeeDepartment emp =
          widget.listuser?.dbOfficialEmailDepartment != null
              ? EmployeeDepartment(
                  id: widget.listuser?.dbOfficialEmailDepartment?.id ?? 0,
                  name: widget.listuser?.dbOfficialEmailDepartment?.name ?? '')
              : EmployeeDepartment();
      lawenforcementCubit.getemployeeDepartmentsResponseData(emp);
      getAttachments =
          widget.listuser?.images != null ? widget.listuser?.images ?? [] : [];
    }
  }

  getLawenforcementList() async {
    var userid = await SharedPrefs.getUserId();
    await lawenforcementCubit.getLocations('ATOM_LOCATIONS');
    await lawenforcementCubit.getEntities('ATOM_ENTITIES');
    await lawenforcementCubit.getLeopurposeofvisit('ATOM_LEO_PURPOSE_VISIT');
    await lawenforcementCubit.getLeodepartments('ATOM_LEO_DEPARTMENTS');
    await lawenforcementCubit.getEmployeeDepartments('EMPLOYEE_DEPARTMENTS');
    await lawenforcementCubit.getDBofficialByRoleDepositor('ATOM_STATIC_USER');
    await lawenforcementCubit.getUserDetails(userid);
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
          createLawEnforcement(true, widget.listuser?.id ?? 0, globalState);
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
            // if (name == Constants.officialsidcardverified) {
            //   isOfficialIdcardSelected = selectedValue;
            // } else if (name == Constants.documentifanytoconfirmpurpose) {
            //   isDocumentifanySelected = selectedValue;
            // } else if (name == Constants.incaseofpolicewasofficialinuniform) {
            //   isIncaseofpoliceSelected = selectedValue;
            // }
            // setState(() {});
            lawenforcementCubit.getRadioButtonSelected(
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
            // if (name == Constants.officialsidcardverified) {
            //   isOfficialIdcardSelected = selectedValue;
            // } else if (name == Constants.documentifanytoconfirmpurpose) {
            //   isDocumentifanySelected = selectedValue;
            // } else if (name == Constants.incaseofpolicewasofficialinuniform) {
            //   isIncaseofpoliceSelected = selectedValue;
            // }
            //setState(() {});
            lawenforcementCubit.getRadioButtonSelected(
                name, selectedValue, "No");
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
            duplicatedepostorList:
                state.getDepositorResponse?.atomStaticUser ?? [],
           leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return  CreateFoundNewUser(title: Constants.createnewuser,lawstate: state,);
                  });
            },
            onTap: (AtomStaticUser list) {
              print(list.name);
              // if (name.toLowerCase() == 'depositor') {
              //  // selecteddepositorList = list;
              // } else {
              //   selectedClaimList = list;
              // }
              // setState(() {});
              lawenforcementCubit.geDBOfficialyData(list);
            },
          );
        });
  }

  Widget datepickerWidgetLoading(TextEditingController textfiled) {
    return GestureDetector(
      onTap: () {
        if (widget.listuser == null || textfiled.text.isEmpty) {
          datePickerDialog(textfiled);
        }
      },
      child: FlutterInputField(
        textFieldController: textfiled,
        textFormKey: textfiled == actualdateTextController
            ? Keys.founddateTextController
            : Keys.actualdateTextController,
        hintText: '',
        isEnable: false,
        isDisableColor:
            widget.listuser == null || textfiled.text.isEmpty ? false : true,
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
    if (textfield == actualdateTextController) {
      actualdateTextController.text = formattedDate;
    }
    // setState(() {
    //   // dateinput.text = formattedDate; //set output date to TextField value.
    // });
  }

  void _getCurrentDate() {
    String formattedDate =
        DateFormat(Constants.fulldateFormat).format(DateTime.now());
    print(formattedDate);
    dateofcreationTextController.text = formattedDate;
    if (widget.listuser == null) {
      statusTextController.text = 'Draft';
    }
  }

  Widget uploadWidget(LawEnforcementState state) {
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
                                lawstate: state,
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

  Widget entityaddButtonwidgetLoading(LawEnforcementState state) {
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

  entityTypeDialog(LawEnforcementState state) {
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
                      lawstate: state,
                    );
                  });
           
            },
            onTap: (List<AtomEntity> list) {
              lawenforcementCubit.getEntityData(list);
            },
          );
        });
  }

  leopurposeDialog(LawEnforcementState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateleopurposevisits:
                state.getLeopurposeResponse?.atomLeoPurposeVisit ?? [],
            leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return  AddNewFields(
                      title: Constants.addpurposeofvisittype,
                      lawstate: state
                    );
                  });
           
            },
            onTap: (AtomLeoPurposeVisit list) {
              //print(list.name);
              lawenforcementCubit.getleopurposeResponseData(list);
            },
          );
        });
  }

  leodepartmentsDialog(LawEnforcementState state) {
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
                    return  AddEmployeeDepartment(
                      title: Constants.addemployeedepartment,
                      lawstate: state,
                    );
                  });
            },
            onTap: (EmployeeDepartment list) {
              //print(list.name);
              lawenforcementCubit.getemployeeDepartmentsResponseData(list);
            },
          );
        });
  }

  departmentsDialog(LawEnforcementState state, int index) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateleodepartments:
                state.getLeodepartmentsResponse?.atomLeoDepartments ?? [],
            leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return  AddNewFields(
                      title: Constants.addleoofficialtype,
                      lawstate: state
                    );
                  });
           
            },
            onTap: (AtomLeoDepartment list) {
              //print(list.name);

              if (state.getVisits!.isNotEmpty) {
                print(state.getVisits![index].department?.name);
                print(state.getVisits![index].department?.id);
                print(state.getVisits![index].name);
                print(state.getVisits![index].designation);
                VistingOfficialsModel model = state.getVisits![index];
                model.department = list;
              }

              lawenforcementCubit.getleoDepartmentsResponseData(list);
            },
          );
        });
  }

  Widget purposeofvisitaddButtonwidgetLoading(LawEnforcementState state) {
    return TextfieldAddButton(
      title: state.leoPurposeVisitResponse?.name ?? '',
      height: 60,
      isDisableColor: widget.listuser == null ||
              (state.leoPurposeVisitResponse != null &&
                  ((state.leoPurposeVisitResponse?.name ?? '').isEmpty))
          ? false
          : true,
      onTap: () {
        if (widget.listuser == null ||
            (state.leoPurposeVisitResponse != null &&
                ((state.leoPurposeVisitResponse?.name ?? '').isEmpty))) {
          leopurposeDialog(state);
        }
      },
    );
  }

  Widget departmentaddButtonwidgetLoading(
      LawEnforcementState state, int index) {
    AtomLeoDepartment? dept = AtomLeoDepartment();
    if ((state.getVisits?.length ?? 0) > 0) {
      dept = state.getVisits![index].department;
    }
    return TextfieldAddButton(
      title: dept?.name ?? '',
      height: 60,
      isDisableColor: widget.listuser == null || ((dept?.name ?? '').isEmpty)
          ? false
          : true,
      onTap: () {
        if (widget.listuser == null || ((dept?.name ?? '').isEmpty)) {
          //   articleTypeDialog(state);
          //lawenforcementCubit.getleoDepartmentsResponseData(list);
          // }
          //leodepartmentsDialog(state);
          departmentsDialog(state, index);
        }
      },
    );
  }

  Widget dbwanttodepartmentaddButtonwidgetLoading(LawEnforcementState state) {
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
          leodepartmentsDialog(state);
        }
      },
    );
  }

  Widget dbofficialemailidaddButtonwidgetLoading(LawEnforcementState state) {
    return TextfieldAddButton(
      title: state.getuserResponse != null &&
              (state.getuserResponse?.name ?? '').isNotEmpty
          ? ((state.getuserResponse?.name ?? '') +
              '(' +
              (state.getuserResponse?.email ?? '') +
              ')')
          : '',
      height: 70,
      isDisableColor: widget.listuser == null ||
              (state.getuserResponse != null &&
                  ((state.getuserResponse?.name ?? '').isEmpty))
          ? false
          : true,
      onTap: () {
        if (widget.listuser == null ||
            (state.getuserResponse != null &&
                ((state.getuserResponse?.name ?? '').isEmpty))) {
          dbOfficialDialog(state);
        }
      },
    );
  }

  Widget locationWidgetdislay(LawEnforcementState state) {
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
                  await lawenforcementCubit.getSerialnumberDetails(
                      list?.id.toString() ?? '', 'AF');
                  // locationselectedText = list?.name ?? '';
                  // locationSelectedlist = list;
                  lawenforcementCubit.getlocationsResponseData(list);
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

  Future createLawEnforcement(
      bool isSubmit, int isFoundId, LawEnforcementState state) async {
    int actualdate = Utils.datetoTimestampConversion(
        actualdateTextController.text, Constants.fulldateFormat);
    int inputdate = Utils.datetoTimestampConversion(
        dateofcreationTextController.text, Constants.fulldateFormat);
    int statusvalue = 0;
    if (statusTextController.text.toLowerCase() == "draft") {
      statusvalue = 0;
    } else if (statusTextController.text.toLowerCase() == "submitted") {
      statusvalue = 1;
    } else if (statusTextController.text.toLowerCase() == "distributed") {
      statusvalue = 3;
    } else {
      statusvalue = 2;
    }
    bool isDocumentifanySelected =
        state.isDocumentifanySelected == 1 ? true : false;
    bool isIncaseofpoliceSelected =
        state.isIncaseofpoliceSelected == 1 ? true : false;
    bool isOfficialIdcardSelected =
        state.isOfficialIdcardSelected == 1 ? true : false;

    DbOfficialEmailDepartment? dbOfficialEmailDepartment =
        DbOfficialEmailDepartment(
            id: state.selectedemployeeDepartmentResponse?.id ?? 1);
    DbOfficialEmailDepartment? visitPurpose =
        DbOfficialEmailDepartment(id: state.leoPurposeVisitResponse?.id ?? 1);
    List<DbOfficialEmailDepartment>? entities = [];
    if ((state.listOfEntities?.length ?? 0) > 0) {
      for (int i = 0; i < state.listOfEntities!.length; i++) {
        AtomEntity entity = state.listOfEntities![i];
        DbOfficialEmailDepartment addentiity =
            DbOfficialEmailDepartment(id: entity.id ?? 1);
        entities.add(addentiity);
      }
    }
    LawEntrySecurity? entrysecurtity =
        LawEntrySecurity(userId: state.getUserDetailsResponse?.userId ?? 1);
    LawLocation? location = LawLocation(
        id: state.locationSelectedlist?.id ?? 1,
        name: state.locationSelectedlist?.name ?? '');
    List<VisitingOfficial>? visitingOfficials = [];
    if (state.getVisits != null) {
      for (int i = 0; i < state.getVisits!.length; i++) {
        VistingOfficialsModel model = state.getVisits![i];
        DbOfficialEmailDepartment dept =
            DbOfficialEmailDepartment(id: model.department?.id ?? 1);
        VisitingOfficial obj = VisitingOfficial(
            address: model.officialaddress ?? '',
            name: model.name ?? '',
            contactNo: model.conatctno ?? '',
            designation: model.designation ?? '',
            email: model.email ?? '',
            department: dept);
        visitingOfficials.add(obj);
      }
    }
    List<MailList>? loadGroups = [];
    if (state.listIndividualdept != null) {
      //for (int i = 0; i < widget.listuser!.entities!.length; i++) {
      MailList entity = state.listIndividualdept != null
          ? MailList(
              groupId: state.listIndividualdept?.id ?? 0,
              name: state.listIndividualdept?.name ?? "")
          : MailList();
      // AtomEntity entity = state.listOfEntities![i];
      //   DbOfficialEmailDepartment addentiity =
      // DbOfficialEmailDepartment(id: entity.id ?? 1);
      //distributionGroups.add(entity);
      //lawenforcementCubit.geDistributonData(entity);
      loadGroups.add(entity);
    }
    List<CreateImage>? images = getFiles ?? [];
    LawEnforcement? lawEnforcement;
    if (widget.listuser != null) {
      lawEnforcement = LawEnforcement(
          id: isFoundId ?? 0,
          entrySecurity: entrysecurtity,
          inputDate: inputdate.toString(),
          slNo: serialnumber ?? '',
          location: location,
          status: statusvalue,
          images: images,
          timeOfVisit: actualdate.toString(),
          officialCardVerified: isOfficialIdcardSelected,
          documentVerified: isDocumentifanySelected,
          visitorInUniform: isIncaseofpoliceSelected,
          entities: entities,
          additionalInformation: additionalinformationTextController.text ?? '',
          visitingOfficials: visitingOfficials,
          dbOfficialEmailDepartment: dbOfficialEmailDepartment,
          dbOfficialAccompaniedEmail: state.getuserResponse != null
              ? ((state.getuserResponse?.name ?? '') +
                  '(' +
                  (state.getuserResponse?.email ?? '') +
                  ')')
              : '',
          dbOfficialEmail: dbofficailwanttimeetTextController.text ?? '',
          mailList: loadGroups);
    } else {
      lawEnforcement = LawEnforcement(
          entrySecurity: entrysecurtity,
          inputDate: inputdate.toString(),
          slNo: serialnumber ?? '',
          location: location,
          status: statusvalue,
          images: images,
          timeOfVisit: actualdate.toString(),
          officialCardVerified: isOfficialIdcardSelected,
          documentVerified: isDocumentifanySelected,
          visitorInUniform: isIncaseofpoliceSelected,
          entities: entities,
          additionalInformation: additionalinformationTextController.text ?? '',
          visitingOfficials: visitingOfficials,
          dbOfficialEmailDepartment: dbOfficialEmailDepartment,
          dbOfficialAccompaniedEmail: state.getuserResponse != null
              ? ((state.getuserResponse?.name ?? '') +
                  '(' +
                  (state.getuserResponse?.email ?? '') +
                  ')')
              : '',
          dbOfficialEmail: dbofficailwanttimeetTextController.text ?? '',
          mailList: loadGroups);
    }
    showLoadingDialog(context);
    var username = await SharedPrefs.getUsername();
    LawEnforcementRequestBody body =
        LawEnforcementRequestBody(lawEnforcement: lawEnforcement);
    lawenforcementCubit.lawcreateNewFoundArticle(
        body,
        isSubmit,
        context,
        username,
        widget.listuser != null
            ? 'edit LawEnforcement'
            : 'Create LawEnforcement');
  }

  lawenforcementValidations(BuildContext context, LawEnforcementState state) {
    if (statusTextController.text.isEmpty &&
        state.getUserDetailsResponse == null &&
        state.locationSelectedlist == null &&
        dateofcreationTextController.text.isEmpty &&
        serialnumber == null &&
        state.listOfEntities == null &&
        actualdateTextController.text.isEmpty &&
        state.leoPurposeVisitResponse == null &&
        dbofficailwanttimeetTextController.text.isEmpty &&
        additionalinformationTextController.text.isEmpty &&
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
    } else if (actualdateTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter actual date",
      );
    } else if (state.leoPurposeVisitResponse != null &&
        (state.leoPurposeVisitResponse?.name ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter purpose of visit",
      );
    } else if (dbofficailwanttimeetTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter db official want to meet",
      );
    } else if (state.selectedemployeeDepartmentResponse != null &&
        (state.selectedemployeeDepartmentResponse?.name ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter db official department",
      );
    } else if (state.getuserResponse != null &&
        (state.getuserResponse?.name ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter db official email id accompanied leo official",
      );
    } else if (additionalinformationTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter additional information",
      );
    } else if (state.getVisits != null && state.getVisits!.isNotEmpty) {
      for (int i = 0; i < state.getVisits!.length; i++) {
        VistingOfficialsModel model = state.getVisits![i];
        if (model.name == null ||
            (model.name ?? '').isEmpty ||
            model.officialaddress == null ||
            (model.officialaddress ?? '').isEmpty ||
            model.conatctno == null ||
            (model.conatctno ?? '').isEmpty ||
            model.email == null ||
            (model.email ?? '').isEmpty ||
            model.department == null ||
            (model.department?.name ?? '').isEmpty ||
            model.designation == null ||
            (model.designation ?? '').isEmpty) {
          Validator().showToast(
            context,
            "Please enter visting offical details",
          );
          break;
        } else if (!Validator.isValidEmail(model.email)) {
          Validator().showToast(
            context,
            "Please enter visting offical  details valid email",
          );
          break;
        } else {
          if (widget.listuser != null &&
              distributiongroupsTextController.text.isEmpty) {
            Validator().showToast(
              context,
              "Please enter distribution groups",
            );
            break;
          } else {
            createLawEnforcement(true, widget.listuser?.id ?? 0, globalState);
            break;
          }
        }
      }
    } else {
      if (widget.listuser != null &&
          distributiongroupsTextController.text.isEmpty) {
        Validator().showToast(
          context,
          "Please enter distribution groups",
        );
      } else {
        createLawEnforcement(true, widget.listuser?.id ?? 0, globalState);
      }
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

  distributiongroupsDailog(LawEnforcementState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateloadGroups: state.groups?.distributionGroups ?? [],
            // leftimagename: AppIcon.addicon,
            // onLeftButtonTap: () {
            // Navigator.pop(context);
            // showDialog(
            //     context: context,
            //     builder: (BuildContext dialogContext) {
            //       return const CreateFoundNewUser();
            //     });
            // },
            onTap: (DistributionGroup list) {
              print(list.name);

              distributiongroupsTextController.text = list.name ?? '';
              lawenforcementCubit.geDistributonData(list);
            },
          );
        });
  }


  Widget textfieldWidgetLoad(TextEditingController textController, int index,
      LawEnforcementState state) {
    return FlutterInputField(
      lineHeight: textController == additionalinformationTextController ? 6 : 1,
      onTap: () {
        if (textController == distributiongroupsTextController) {
          distributiongroupsDailog(state);
        }
      },
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
        if (textController == nameTextController1 ||
            textController == nameTextController2 ||
            textController == nameTextController3) {
          if (state.getVisits!.isNotEmpty) {
            VistingOfficialsModel model = state.getVisits![index];
            model.name = username;
          }
        } else if (textController == designationTextController1 ||
            textController == designationTextController2 ||
            textController == designationTextController3) {
          if (state.getVisits!.isNotEmpty) {
            VistingOfficialsModel model = state.getVisits![index];
            model.designation = username;
          }
        } else if (textController == emailidTextController1 ||
            textController == emailidTextController2 ||
            textController == emailidTextController3) {
          if (state.getVisits!.isNotEmpty) {
            VistingOfficialsModel model = state.getVisits![index];
            model.email = username;
          }
        } else if (textController == officeaddressTextController1 ||
            textController == officeaddressTextController2 ||
            textController == officeaddressTextController3) {
          if (state.getVisits!.isNotEmpty) {
            VistingOfficialsModel model = state.getVisits![index];
            model.officialaddress = username;
          }
        } else if (textController == contactnoTextController1 ||
            textController == contactnoTextController2 ||
            textController == contactnoTextController3) {
          if (state.getVisits!.isNotEmpty) {
            VistingOfficialsModel model = state.getVisits![index];
            model.conatctno = username;
          }
        }
      },
      validateTextField: (String? user) {},
      // )
      //)
    );
  }
}
