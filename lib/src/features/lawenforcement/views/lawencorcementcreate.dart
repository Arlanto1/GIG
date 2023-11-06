import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_distribution_group_dropdown.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_entities_dropdown.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/create_fields.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/custom_multiple_selection_popup.dart';
import 'package:db_atom/src/common_widgets/custom_pop_list_texts.dart';
import 'package:db_atom/src/common_widgets/date_time_picker.dart';
import 'package:db_atom/src/common_widgets/image_download.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/views/add_employee_deparment.dart';
import 'package:db_atom/src/features/createfound/views/create_found_newuser.dart';
import 'package:db_atom/src/features/createfound/views/upload_attachment.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_cubit.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_state.dart';
import 'package:db_atom/src/features/lawenforcement/models/dropdown_object.dart';
import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../models/base_user.dart';
import '../../../models/organisation.dart';
import '../../createfound/models/user.dart';

class CreateLawEnforcement extends StatefulWidget {
  final LawEnforcementDetails? model;

  const CreateLawEnforcement({super.key, this.model});

  @override
  State<CreateLawEnforcement> createState() => _CreateLawEnforcementState();
}

class _CreateLawEnforcementState extends State<CreateLawEnforcement> {
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
  List<CreateImage> getFiles = [];
  List<FoundImage> getAttachments = [];
  late LawEnforcementState globalState;
  String? serialnumber;
  bool isDistrbuted = false;

  // int get index => 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      appBar: AppHeader(
        isTitleCenter: false,
        title: widget.model != null
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
              if (!isDistrbuted) {
                createLawEnforcement(false, widget.model?.id ?? 0, globalState);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: isDistrbuted
                  ? SvgPicture.asset(
                AppIcon.createfoundsaveicon,
                color:
                AppColors.disabletextfieldBackground.withOpacity(0.5),
              )
                  : SvgPicture.asset(
                AppIcon.createfoundsaveicon,
              ),
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

          if (state.getVisitsCount < 1) {
            manageAddVisitOfficialDetailWidget(state);
          }
          if (state.getSerialnumberResponse != null) {
            serialnumber = state.getSerialnumberResponse?.serialNo ?? "";
          }
          globalState = state;
          if (state.stateType == LawEnforcementStateType.addattachment) {
            getFiles = state.loadAttachments ?? [];
          }
          initiallyLocationandSerialnumberdataset(state);
          // if (widget.listuser != null) {
          //   if (state.groups != null) {

          //   }
          // }
          return Container(
            color: AppColors.navigationSkybluecolor,
            child: SingleChildScrollView(
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
                      absorbing: widget.model?.status == 3 ||
                          widget.model?.status == 1,
                      child: Form(
                        key: lawEnforcementFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 20.0, right: 20),
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

                                ///created by

                                CommonWidgets.horizentaltextHandling(
                                    Constants.createdby,
                                    isMandatory: true,
                                    '${state.getUserDetailsResponse
                                        ?.firstName ?? ''} ${state
                                        .getUserDetailsResponse?.lastName ??
                                        ''}'),

                                // / Location
                                CommonWidgets.textDisplay(
                                    Constants.location, Styles.textStyleBlack14,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                locationWidgetDisplay(state),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// date of creation
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
                                    Constants.slno, serialnumber ?? '',
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Entity type
                                CommonWidgets.textDisplay(
                                    Constants.entity, Styles.textStyleBlack14,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                entityaddButtonwidgetLoading(state),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                ///Actual time of visit
                                CommonWidgets.textDisplay(
                                    Constants.actualtimeofvisit,
                                    Styles.textStyleBlack14,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                datepickerWidgetLoading(
                                    actualDateTextController),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Officials ID Card Verified?
                                CommonWidgets.textDisplay(
                                    Constants.officialsidcardverified,
                                    Styles.textStyleBlack14,
                                    isMandatory: true),
                                radioButtonHandling(
                                    state.isOfficialIdcardSelected ?? 1,
                                    Constants.officialsidcardverified),

                                /// Purpose of visit
                                CommonWidgets.textDisplay(
                                    Constants.purposeofvsit,
                                    Styles.textStyleBlack14,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                purposeofvisitaddButtonwidgetLoading(state),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Document if any to confirm purpose
                                CommonWidgets.textDisplay(
                                    Constants.documentifanytoconfirmpurpose,
                                    Styles.textStyleBlack14,
                                    isMandatory: true),
                                radioButtonHandling(
                                    state.isDocumentifanySelected ?? 1,
                                    Constants.documentifanytoconfirmpurpose),

                                /// In case of Police, was official in uniform?
                                CommonWidgets.textDisplay(
                                    Constants
                                        .incaseofpolicewasofficialinuniform,
                                    Styles.textStyleBlack14,
                                    isMandatory: true),
                                radioButtonHandling(
                                    state.isIncaseofpoliceSelected ?? 1,
                                    Constants
                                        .incaseofpolicewasofficialinuniform),

                                /// DB official want to meet
                                CommonWidgets.textDisplay(
                                    Constants.dbofficialwanttomeet,
                                    Styles.textStyleBlack14,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                textfieldWidgetLoad(
                                    dbOfficailWanttimeetTextController,
                                    0,
                                    state),

                                /// DB official department
                                CommonWidgets.textDisplay(
                                    Constants.dbofficialdepartment,
                                    Styles.textStyleBlack14,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                dbwanttodepartmentaddButtonwidgetLoading(state),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                ///DB Official email ID Accompanied LEO official'
                                CommonWidgets.textDisplay(
                                    Constants
                                        .dbofficialemailidaccompaniedleoofficial,
                                    Styles.textStyleBlack14,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                dbofficialemailidaddButtonwidgetLoading(state),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// additional information
                                CommonWidgets.textDisplay(
                                    Constants.additionalinformation,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                textfieldWidgetLoad(
                                  additionalInformationTextController,
                                  0,
                                  state,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ]),
                            ),

                            // CommonWidgets.indentedDivider(Colors.black),
                            const Divider(
                              color: AppColors.textgreyThemecolor,
                              thickness: 1,
                            ),

                            Padding(
                              padding:
                              const EdgeInsets.only(left: 20.0, right: 20),
                              child: Column(
                                children: [

                                  /// Visiting Official Details
                                  CommonWidgets.textDisplay(
                                    Constants.visitingofficialdetails,
                                    Styles.textStyleDarkGrey16,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                  //
                                  // // name
                                  // CommonWidgets.textDisplay(
                                  //     Constants.name, Styles.textStyleBlack14),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //     height * 0.001),
                                  // textfieldWidgetLoad(
                                  //     nameTextController2, 0, state),
                                  // // Designation
                                  // CommonWidgets.textDisplay(
                                  //     Constants.designation,
                                  //     Styles.textStyleBlack14),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //     height * 0.001),
                                  // textfieldWidgetLoad(
                                  //     designationTextController2, 0, state),
                                  // // Office Address
                                  // CommonWidgets.textDisplay(
                                  //     Constants.officeAddress,
                                  //     Styles.textStyleBlack14),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //     height * 0.001),
                                  // textfieldWidgetLoad(
                                  //     officeaddressTextController2, 0, state),
                                  //
                                  // // Email Id
                                  // CommonWidgets.textDisplay(Constants.emailid,
                                  //     Styles.textStyleBlack14),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //     height * 0.001),
                                  // textfieldWidgetLoad(
                                  //     emailidTextController2, 0, state),
                                  // // Contact Number
                                  // CommonWidgets.textDisplay(Constants.contactno,
                                  //     Styles.textStyleBlack14),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //     height * 0.001),
                                  // textfieldWidgetLoad(
                                  //     contactnoTextController2, 0, state),
                                  //

                                  (state.getVisitsCount) > 0
                                      ? listVisitingOfficialDetails(
                                    height,
                                    width,
                                    context,
                                    state,
                                    state.getVisitsCount,
                                  )
                                      : Container(),
                                  widget.model == null
                                      ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.01)
                                      : Container(),

                                  /// Add another visiting
                                  GestureDetector(
                                    onTap: () {
                                      if ((state.getVisitsCount) < 10) {
                                        manageAddVisitOfficialDetailWidget(
                                            state);
                                      } else {
                                        Validator().showToast(
                                          context,
                                          "You have reached maximum visiting official details adding",
                                        );
                                      }
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        // Expanded(
                                        //child:
                                        SvgPicture.asset(
                                          AppIcon.pluscircle,
                                          //color: AppColors.navigationSkybluecolor,
                                        ),
                                        // ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          Constants.addvisitingofficialdetails,
                                          style: TextStyle(
                                            color: AppColors
                                                .navigationSkybluecolor,
                                            decoration:
                                            TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Upload
                                  widget.model == null
                                      ? CommonWidgets.textDisplay(
                                      Constants.upload,
                                      Styles.textStyleBlack14)
                                      : Container(),
                                  widget.model == null
                                      ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                      : Container(),
                                  widget.model == null
                                      ? uploadWidget(state)
                                      : Container(),

                                  // Attachments
                                  getSpaceattchment(height),
                                  getAttachement(height),

                                  if (widget.model?.status == 1 ||
                                      widget.model?.status == 2 ||
                                      widget.model?.status == 3) ...[

                                    /// Distribution Groups
                                    widget.model?.status != 0
                                        ? CommonWidgets.textDisplay(
                                        Constants.distributiongroups,
                                        Styles.textStyleBlack14)
                                        : Container(),
                                    widget.model?.status != 0
                                        ? CommonWidgets.verticalSpacerWidget(
                                        height * 0.001)
                                        : Container(),
                                    widget.model?.status != 0
                                        ? textfieldWidgetLoad(
                                        distributiongroupsTextController,
                                        0,
                                        state)
                                        : Container(),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                  ],
                                  // SubmitButton
                                  if (widget.model?.status != 3) ...[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        cancelButtonDisplay(),
                                        submitButtonDisplay()
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void manageAddVisitOfficialDetailWidget(LawEnforcementState state) {
    int visitCount = (state.getVisitsCount) + 1;
    List<VisitingOfficialsModel>? getVisits = state.getVisits ?? [];

    getVisits.add(VisitingOfficialsModel());
    lawenforcementCubit.addingVisits(
      visitCount: visitCount,
      getVisits: getVisits,
    );
  }

  Widget listVisitingOfficialDetails(double height,
      double width,
      BuildContext context,
      LawEnforcementState state,
      int visitingOfficialDetailsArray) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < visitingOfficialDetailsArray; i++)

        // Name
          loadData(
              height, width, context, state, visitingOfficialDetailsArray, i),
      ],
    );
  }

  Widget loadData(double height, double width, BuildContext context,
      LawEnforcementState state, int visitingOfficialDetailsArray, int index) {
    // TextEditingController name = TextEditingController();
    // TextEditingController address = TextEditingController();
    // TextEditingController conatctno = TextEditingController();
    // TextEditingController emailid = TextEditingController();
    // TextEditingController designation = TextEditingController();

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            int value = (state.getVisitsCount) - 1;
            List<VisitingOfficialsModel>? getVisits1 = state.getVisits ?? [];
            getVisits1.removeAt(index);
            lawenforcementCubit.addingVisits(
                visitCount: value, getVisits: getVisits1);
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              AppIcon.closeicon,
              color: AppColors.navigationSkybluecolor,
            ),
          ), //Icon(Icons.cancel)
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
          state,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.01),

        // Designation
        CommonWidgets.textDisplay(
            Constants.designation, Styles.textStyleBlack14),
        CommonWidgets.verticalSpacerWidget(height * 0.001),
        textfieldWidgetLoad(
          index == 0
              ? designationTextController1
              : index == 1
              ? designationTextController2
              : designationTextController3,
          index,
          state,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.01),

        // Department
        CommonWidgets.textDisplay(
            Constants.department, Styles.textStyleBlack14),
        CommonWidgets.verticalSpacerWidget(height * 0.001),
        // articleaddButtonwidgetLoading(state),
        departmentaddButtonwidgetLoading(state, index),
        CommonWidgets.verticalSpacerWidget(height * 0.01),

        // Office Address
        CommonWidgets.textDisplay(
            Constants.officeAddress, Styles.textStyleBlack14),
        CommonWidgets.verticalSpacerWidget(height * 0.001),
        textfieldWidgetLoad(
          index == 0
              ? officeaddressTextController1
              : index == 1
              ? officeaddressTextController2
              : officeaddressTextController3,
          index,
          state,
        ),
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
          state,
        ),
        CommonWidgets.verticalSpacerWidget(height * 0.01),

        /// Contact No
        CommonWidgets.textDisplay(Constants.contactno, Styles.textStyleBlack14),
        CommonWidgets.verticalSpacerWidget(height * 0.001),
        textfieldWidgetLoad(
          index == 0
              ? contactnoTextController1
              : index == 1
              ? contactnoTextController2
              : contactnoTextController3,
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
      editCreatefoundItems();
      lawenforcementCubit.getDistributionGroupsDetails(context);
    } else {
      lawenforcementCubit.initalization();
    }

    getLawEnforcementList(context);
    _getCurrentDate();
  }

  initiallyLocationandSerialnumberdataset(LawEnforcementState state) async {
    print(state.locationSelectedlist);
    print(state.getLocationsResponse);
    print(widget.model);
    if (state.locationSelectedlist?.id == null &&
        state.getLocationsResponse != null &&
        widget.model == null &&
        (serialnumber ?? '').isEmpty) {
      Organisation list = Organisation(id: 24, name: "DLF Square");
      lawenforcementCubit.getlocationsResponseData(list);
      await lawenforcementCubit.getSerialnumberDetails('24', 'LEO', context);
    }
  }

  editCreatefoundItems() async {
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
          ? Utils.timestamptoDateConversion(
          int.parse(widget.model?.timeOfVisit ?? '0'),
          Constants.fulldateFormat)
          : '';
      dateofcreationTextController.text =
      widget.model?.inputDate != null && widget.model?.inputDate != '0'
          ? Utils.timestamptoDateConversion(
          int.parse(widget.model?.inputDate ?? '0'),
          Constants.fulldateFormat)
          : dateofcreationTextController.text;
      // List<VisitingOfficial>? visitingOfficials = widget.listuser?.visitingOfficials != null ? widget.listuser?.visitingOfficials ?? [] : [];
      statusTextController.text = widget.model?.status == 0
          ? "Draft"
          : widget.model?.status == 1
          ? "Submitted"
          : widget.model?.status == 3
          ? "Distributed"
          : "Handover";

      if (widget.model?.status == 3 ||
          statusTextController.text == 'Distributed') {
        lawenforcementCubit.getDistributed(true);
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

      serialnumber = widget.model?.slNo != null ? widget.model?.slNo ?? '' : '';

      await lawenforcementCubit.getSerialnumberDetails(
          (widget.model?.location?.id ?? 0).toString(), 'LEO', context);

      lawenforcementCubit.getlocationsResponseData(mumbai);
      int isDocumentifanySelected1 =
      ((widget.model?.documentVerified ?? false) == true) ? 1 : 0;
      int isOfficialIdcardSelected1 =
      ((widget.model?.officialCardVerified ?? false) == true) ? 1 : 0;
      int isIncaseofpoliceSelected1 =
      ((widget.model?.visitorInUniform ?? false) == true) ? 1 : 0;

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
        lawenforcementCubit.getEntityData(entities);
      }

      // if ((widget.model?.mailList?.length ?? 0) > 0) {
      //   //for (int i = 0; i < widget.listuser!.entities!.length; i++) {
      //   Organisation entity = widget.model?.mailList != null &&
      //       (widget.model?.mailList?.length ?? 0) > 0
      //       ? Organisation(
      //       id: widget.model?.mailList![0]["groupId"] ?? 0,
      //       name: widget.model?.mailList![0]["name"] ?? "")
      //       : Organisation();
      //   // AtomEntity entity = state.listOfEntities![i];
      //   //   DbOfficialEmailDepartment addentiity =
      //   // DbOfficialEmailDepartment(id: entity.id ?? 1);
      //   //distributionGroups.add(entity);
      //   lawenforcementCubit.geDistributonData(entity);
      //   distributiongroupsTextController.text =
      //       widget.model?.mailList![0]["name"] ?? "";
      // }

      // state.groups?.distributionGroups
      // }

      Organisation visit = widget.model?.visitPurpose != null
          ? Organisation(
          id: widget.model?.visitPurpose?.id ?? 0,
          name: widget.model?.visitPurpose?.name ?? "")
          : Organisation();
      lawenforcementCubit.getleopurposeResponseData(visit);

      BaseUser staticUser = widget.model?.dbOfficialEmailDepartment != null
          ? BaseUser(
          id: widget.model?.dbOfficialEmailDepartment?.id ?? 0,
          name: widget.model?.dbOfficialEmailDepartment?.name ?? "",
          email: widget.model?.dbOfficialAccompaniedEmail ?? '')
          : BaseUser();

      lawenforcementCubit.geDBOfficialyData(staticUser);

      List<LawVisitingOfficial>? visiting =
      widget.model?.visitingOfficials != null
          ? widget.model?.visitingOfficials ?? []
          : [];

      List<VisitingOfficialsModel>? visitingOfficials = [];
      if (visiting.isNotEmpty) {
        for (int i = 0; i < visiting.length; i++) {
          LawVisitingOfficial model = visiting[i];
          Organisation dept = Organisation(
              id: model.department?.id ?? 1,
              name: model.department?.name ?? '');
          VisitingOfficialsModel obj = VisitingOfficialsModel(
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

      lawenforcementCubit.addingVisits(
          visitCount: visitingOfficials.length, getVisits: visitingOfficials);

      // state.selectedemployeeDepartmentResponse
      Organisation emp = widget.model?.dbOfficialEmailDepartment != null
          ? Organisation(
          id: widget.model?.dbOfficialEmailDepartment?.id ?? 0,
          name: widget.model?.dbOfficialEmailDepartment?.name ?? '')
          : Organisation();
      lawenforcementCubit.getemployeeDepartmentsResponseData(emp);
      getAttachments =
      widget.model?.images != null ? widget.model?.images ?? [] : [];
    }
  }

  getLawEnforcementList(context) async {
    var userid = await SharedPrefs.getUserId();
    await lawenforcementCubit.getLocations('ATOM_LOCATIONS', context);
    await lawenforcementCubit.getEntities('ATOM_ENTITIES', context);
    await lawenforcementCubit.getLeopurposeofvisit(
        'ATOM_LEO_PURPOSE_VISIT', context);
    await lawenforcementCubit.getLeodepartments(
        'ATOM_LEO_DEPARTMENTS', context);
    await lawenforcementCubit.getEmployeeDepartments(
        'EMPLOYEE_DEPARTMENTS', context);
    await lawenforcementCubit.getDBofficialByRoleDepositor(
        'ATOM_STATIC_USER', context);
    await lawenforcementCubit.getUserDetails(userid, context);
  }

  Widget submitButtonDisplay() {
    return AppButton(
      //height: 50,
      disableColor: isDistrbuted,
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        if (isDistrbuted == false) {
          try {
            validateForm(context, globalState);
          } catch (e) {
            // present userwith error message
          }
        }
      },
    );
  }

  Widget radioButtonHandling(int selectedValue, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: widget.model != null
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
          activeColor: widget.model != null
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
                      lawstate: state,
                    );
                  });
            },
            onTap: (BaseUser list) {
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
        if (widget.model == null || textfiled.text.isEmpty) {
          datePickerDialog(textfiled);
        }
      },
      child: FlutterInputField(
        textFieldController: textfiled,
        textFormKey: textfiled == actualDateTextController
            ? Keys.founddateTextController
            : Keys.handedoverdateTextController,
        hintText: '',
        isEnable: false,
        isDisableColor:
        widget.model == null || textfiled.text.isEmpty ? false : true,
        onChange: (String username) {
          //this.username = username;
          print('dfwf');

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
    if (textfield == actualDateTextController) {
      actualDateTextController.text = formattedDate;
    }
    setState(() {
      // dateinput.text = formattedDate; //set output date to TextField value.
    });
  }

  void _getCurrentDate() {
    String formattedDate =
    DateFormat(Constants.fulldateFormat).format(DateTime.now());
    print(formattedDate);
    dateofcreationTextController.text = formattedDate;
    if (widget.model == null) {
      statusTextController.text = 'Draft';
    }
  }

  Widget uploadWidget(LawEnforcementState state) {
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
                  fixedSize: const Size(140, 50)),
              onPressed: () {
                // Navigator.pushNamed(context,
                //     createFoundAttachmentRoute);
                //UploadAttachment();
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

  Widget entityaddButtonwidgetLoading(LawEnforcementState state) {
    String title = '';
    if ((state.listOfEntities?.length ?? 0) > 0) {
      for (int i = 0; i < state.listOfEntities!.length; i++) {
        Organisation entity = state.listOfEntities![i];
        String value = entity.name ?? '';
        title = '$title  $value';
      }
    }
    return TextfieldAddButton(
      title: title,
      height: (state.listOfEntities?.length ?? 0) > 4
          ? (state.listOfEntities?.length ?? 0) > 9
          ? 140
          : 100
          : 60,
      isDisableColor: widget.model?.status != 3 ? false : true,
      onTap: () {
        entityTypeDialog(state);
        // }
      },
    );
  }

  entityTypeDialog(LawEnforcementState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomMultipleSelectionListTexts(
            duplicateentityList: state.getEntitiesResponse?.atomEntities ?? [],
            mainselectedentityList: state.listOfEntities ?? [],
            leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddNewFields(
                      title: Constants.addentitytype,
                      lawstate: state,
                    );
                  });
            },
            onTap: (List<Organisation> list) {
              lawenforcementCubit.getEntityData(list);
              setState(() {});
            },
          );
        });
  }

  leopurposeDialog(LawEnforcementState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateLeoPurposeVisits:
            state.getLeopurposeResponse?.atomLeoPurposeVisit ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddNewFields(
                        title: Constants.addpurposeofvisittype,
                        lawstate: state);
                  });
            },
            onTap: (Organisation list) {
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
                      lawState: state,
                    );
                  });
            },
            onTap: (Organisation list) {
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
            duplicateLeoDepartments:
            state.getLeodepartmentsResponse?.atomLeoDepartments ?? [],
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddNewFields(
                        title: Constants.addleoofficialtype, lawstate: state);
                  });
            },
            onTap: (Organisation list) {
              //print(list.name);

              if (state.getVisits!.isNotEmpty) {
                print(state.getVisits![index].department?.name);
                print(state.getVisits![index].department?.id);
                print(state.getVisits![index].name);
                print(state.getVisits![index].designation);
                VisitingOfficialsModel model = state.getVisits![index];
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
      isDisableColor: widget.model?.status != 3 ? false : true,
      onTap: () {
        // if (widget.listUser == null ||
        //     (state.leoPurposeVisitResponse != null &&
        //         ((state.leoPurposeVisitResponse?.name ?? '').isEmpty))) {
        leopurposeDialog(state);
        //  }
      },
    );
  }

  Widget departmentaddButtonwidgetLoading(LawEnforcementState state,
      int index) {
    Organisation? dept = Organisation();
    if ((state.getVisits?.length ?? 0) > 0) {
      dept = state.getVisits![index].department;
    }
    return TextfieldAddButton(
      title: dept?.name ?? '',
      height: 60,
      //isDisableColor:'',
      onTap: () {
        // if (widget.listUser?.status==3) {
        //   //   articleTypeDialog(state);
        //   //lawenforcementCubit.getleoDepartmentsResponseData(list);
        //   // }
        //   //leodepartmentsDialog(state);
        departmentsDialog(state, index);
        // }
      },
    );
  }

  Widget dbwanttodepartmentaddButtonwidgetLoading(LawEnforcementState state) {
    return TextfieldAddButton(
      title: state.selectedemployeeDepartmentResponse?.name ?? '',
      height: 60,
      isDisableColor: widget.model?.status != 3 ? false : true,
      onTap: () {
        // if (widget.listUser == null ||
        //     (state.selectedemployeeDepartmentResponse != null &&
        //         ((state.selectedemployeeDepartmentResponse?.name ?? '')
        //             .isEmpty))) {
        //   articleTypeDialog(state);
        leodepartmentsDialog(state);
        // }
      },
    );
  }

  Widget employeeDepartmentAddButtonWidgetLoading(LawEnforcementState state) {
    return TextfieldAddButton(
      title: state.createEmployeeDepartments?.name ?? '',
      height: 60,
      isDisableColor: widget.model?.status != 3 ? false : true,
      onTap: () {
        // if (widget.listUser == null ||
        //     (state.createEmployeeDepartments != null &&
        //         ((state.createEmployeeDepartments?.name ?? '').isEmpty))) {
        //   articleTypeDialog(state);
        leodepartmentsDialog(state);
        // }
      },
    );
  }

  Widget dbofficialemailidaddButtonwidgetLoading(LawEnforcementState state) {
    return TextfieldAddButton(
      title: state.getuserResponse != null &&
          (state.getuserResponse?.name ?? '').isNotEmpty
          ? ('${state.getuserResponse?.name ?? ''}(${state.getuserResponse
          ?.email ?? ''})')
          : '',
      height: 70,
      isDisableColor: widget.model?.status != 3 ? false : true,
      onTap: () {
        // if (widget.listUser == null ||
        //     (state.getuserResponse != null &&
        //         ((state.getuserResponse?.name ?? '').isEmpty))) {
        dbOfficialDialog(state);
        // }
      },
    );
  }

  Widget locationWidgetDisplay(LawEnforcementState state) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            // print(state.getLocationsResponse);
            return CustomExpansionListTexts(
              getLocationsresponse: state.getLocationsResponse,
              //GetLocations(),
              onTap: (Organisation? list) async {
                print(list?.name);
                await lawenforcementCubit.getSerialnumberDetails(
                    list?.id.toString() ?? '', 'LEO', context);
                // locationselectedText = list?.name ?? '';
                // locationSelectedlist = list;
                lawenforcementCubit.getlocationsResponseData(list);
              },
            );
          },
        );
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

  Future createLawEnforcement(bool isSubmit, int isFoundId,
      LawEnforcementState state) async {
    int actualdate = Utils.dateToTimestampConversion(
        actualDateTextController.text, Constants.fulldateFormat);
    int inputdate = (DateTime
        .now()
        .millisecondsSinceEpoch ~/ 1000);
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
        Organisation entity = state.listOfEntities![i];
        DbOfficialEmailDepartment addentiity =
        DbOfficialEmailDepartment(id: entity.id ?? 1);
        entities.add(addentiity);
      }
    }
    LawEntrySecurity? entrySecurtity =
    LawEntrySecurity(userId: state.getUserDetailsResponse?.userId ?? 1);
    LawLocation? location = LawLocation(
        id: state.locationSelectedlist?.id ?? 1,
        name: state.locationSelectedlist?.name ?? '');
    List<VisitingOfficial>? visitingOfficials = [];

    if (state.getVisits != null) {
      for (int i = 0; i < state.getVisits!.length; i++) {
        VisitingOfficialsModel model = state.getVisits![i];
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
    List<MailList>? loadGroups = widget.model?.mailList??[];
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
    if (widget.model != null) {
      lawEnforcement = LawEnforcement(
          id: isFoundId,
          entrySecurity: entrySecurtity,
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
          additionalInformation: additionalInformationTextController.text,
          visitingOfficials: visitingOfficials,
          dbOfficialEmailDepartment: dbOfficialEmailDepartment,
          dbOfficialAccompaniedEmail: state.getuserResponse != null
              ? ('${state.getuserResponse?.name ?? ''}(${state.getuserResponse
              ?.email ?? ''})')
              : '',
          dbOfficialEmail: dbOfficailWanttimeetTextController.text,
          visitPurpose: visitPurpose,
          mailList: loadGroups);
    } else {
      lawEnforcement = LawEnforcement(
          entrySecurity: entrySecurtity,
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
          additionalInformation: additionalInformationTextController.text,
          visitingOfficials: visitingOfficials,
          dbOfficialEmailDepartment: dbOfficialEmailDepartment,
          dbOfficialAccompaniedEmail: state.getuserResponse != null
              ? ('${state.getuserResponse?.name ?? ''}(${state.getuserResponse
              ?.email ?? ''})')
              : '',
          dbOfficialEmail: dbOfficailWanttimeetTextController.text,
          visitPurpose: visitPurpose,
          mailList: loadGroups);
    }
    showLoadingDialog(context);
    LawEnforcementRequestBody body =
    LawEnforcementRequestBody(lawEnforcement: lawEnforcement);
    BlocProvider.of<LawEnforcementCubit>(context).submitForm(
      body,
      isSubmit,
      context,
      widget.model != null ? 'edit LawEnforcement' : 'Create LawEnforcement',
    );
  }

  validateForm(BuildContext context, LawEnforcementState state) {
    if (statusTextController.text.isEmpty &&
        state.getUserDetailsResponse == null &&
        state.locationSelectedlist == null &&
        dateofcreationTextController.text.isEmpty &&
        serialnumber == null &&
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
    } else if (serialnumber != null && (serialnumber ?? '').isEmpty) {
      Validator().showToast(
        context,
        "Please enter serial number",
      );
    } else if (state.listOfEntities == null) {
      Validator().showToast(
        context,
        "Please enter entity",
      );
    } else if (actualDateTextController.text.isEmpty) {
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
    } else if (dbOfficailWanttimeetTextController.text.isEmpty) {
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
    } else if (additionalInformationTextController.text.isEmpty) {
      Validator().showToast(
        context,
        "Please enter additional information",
      );
    } else if (state.getVisits != null && state.getVisits!.isNotEmpty) {
      for (int i = 0; i < state.getVisits!.length;) {
        VisitingOfficialsModel model = state.getVisits![i];
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
            "Please enter visiting official details",
          );
          break;
        }
        // else if (!Validator.isValidEmail(model.email)) {
        //   Validator().showToast(
        //     context,
        //     "Please enter visiting official  details valid email",
        //   );
        //   break;
        // }
        else {
          if (widget.model?.status != 0 &&
              (widget.model != null &&
                  distributiongroupsTextController.text.isEmpty)) {
            Validator().showToast(
              context,
              "Please enter distribution groups",
            );
            break;
          } else {
            createLawEnforcement(true, widget.model?.id ?? 0, globalState);
            break;
          }
        }
      }
    } else {
      if (widget.model != null &&
          distributiongroupsTextController.text.isEmpty) {
        Validator().showToast(
          context,
          "Please enter distribution groups",
        );
      } else {
        createLawEnforcement(true, widget.model?.id ?? 0, globalState);
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
        setState(() {});
      },
      validateTextField: (String? user) {},
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
        Navigator.pop(context);
      },
    );
  }

  Widget attachmentListviews(List<CreateImage>? attachmentListviews,
      List<FoundImage>? attachmentListviews1,) {
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
            CreateImage? imageData;
            FoundImage? imageData1;
            if (widget.model != null) {
              imageData1 = attachmentListviews1?[index];
            } else {
              imageData = attachmentListviews?[index];
            }

            return Column(
              children: <Widget>[
                ListTile(
                  trailing: widget.model != null
                      ? SvgPicture.asset(AppIcon.download,
                      color: AppColors.boldgreyBackground)
                      : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
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

  distributiongroupsDailog(LawEnforcementState state) {
    // BaseDistributionGroupSelection().entityDropDownSelection(
    //     context: context,
    //     selectedValues: widget.model.mailList,
    //     all: state.groups?.distributionGroups ?? [],
    //     enabled: true,
    //     onTap: (List<MailList> selectedEntities) {
    //       log('--selectedEntities----${selectedEntities.length}');
    //
    //
    //       widget.model?.mailList = selectedEntities;
    //       Navigator.of(context)
    //           .pop(); // Close the dialog
    //     });

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomListTexts(
          duplicateloadGroups: state.groups?.distributionGroups ?? [],
          onTap: (Organisation organisation) {
            log('--organisation.name---${organisation.name}');

            distributiongroupsTextController.text = organisation.name ?? '';
            lawenforcementCubit.geDistributonData(organisation);
          },
        );
      },
    );
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
      textFieldController: textController,
      textFormKey: Keys.colorTextController,
      isEnable: true,
      hintText: '',
      onChange: (String username) {
        //this.username = username;
        if (textController == nameTextController1 ||
            textController == nameTextController2 ||
            textController == nameTextController3) {
          if (state.getVisits!.isNotEmpty) {
            VisitingOfficialsModel model = state.getVisits![index];
            model.name = username;
          }
        } else if (textController == designationTextController1 ||
            textController == designationTextController2 ||
            textController == designationTextController3) {
          if (state.getVisits!.isNotEmpty) {
            VisitingOfficialsModel model = state.getVisits![index];
            model.designation = username;
          }
        } else if (textController == emailidTextController1 ||
            textController == emailidTextController2 ||
            textController == emailidTextController3) {
          log('----state.getVisits-22-${state.getVisits}----');
          if (state.getVisits!.isNotEmpty) {
            log('----state.getVisits------');
            VisitingOfficialsModel model = state.getVisits![index];
            model.email = username;
          }
        } else if (textController == officeaddressTextController1 ||
            textController == officeaddressTextController2 ||
            textController == officeaddressTextController3) {
          if (state.getVisits!.isNotEmpty) {
            VisitingOfficialsModel model = state.getVisits![index];
            model.officialaddress = username;
          }
        } else if (textController == contactnoTextController1 ||
            textController == contactnoTextController2 ||
            textController == contactnoTextController3) {
          if (state.getVisits!.isNotEmpty) {
            VisitingOfficialsModel model = state.getVisits![index];
            model.conatctno = username;
          }
        }
      },
      validateTextField: (String? user) {},
    );
  }
}
