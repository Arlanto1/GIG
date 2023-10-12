import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/radio_buttons_yes_no.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/cubits/general_info_cubit.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../main_DEV.dart';
import '../../../../../common_widgets/app_button.dart';
import '../../../../../common_widgets/base_widget/base_app_bar.dart';

import '../../../../../common_widgets/base_widget/base_drop_down.dart';
import '../../../../../common_widgets/base_widget/date_picker_dialog.dart';
import '../../../../../common_widgets/base_widget/selected_tile_value_widget.dart';
import '../../../../../common_widgets/basic_reusable_widgets.dart';
import '../../../../../common_widgets/custom_list_expansion_pop_up.dart';
import '../../../../../common_widgets/image_download.dart';
import '../../../../../common_widgets/new_search_textfield.dart';
import '../../../../../constants/app_icon.dart';
import '../../../../../constants/constants.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../routing/router.dart';
import '../../../../../utils/app_themes/colors/app_color.dart';
import '../../../../../utils/app_themes/styles/app_styles.dart';
import '../../../../../utils/customalert.dart';
import '../../../../../utils/helpers/keys/keys.dart';
import '../../../../../utils/util.dart';
import '../../../../../utils/validators/validator.dart';
import '../../../../article_found_register_module/foundlist/models/foundlist_article_details.dart';
import '../../../../createfound/models/create_found_request.dart';
import '../../../../createfound/models/get_locations_model.dart';
import '../../../../createfound/models/user.dart';
import '../models/general_info_model.dart';

class OccurrenceDetails extends StatefulWidget {
  final Occurrence? occurrence;
  final String title;

  const OccurrenceDetails({
    super.key,
    this.occurrence,
    required this.title,
  });

  @override
  State<OccurrenceDetails> createState() => _GuardingMasterDataDetailsState();
}

class _GuardingMasterDataDetailsState extends State<OccurrenceDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  List<CreateImage>? getFiles;
  List<FoundImage>? getAttachments;
  TextEditingController powerFailureStartDateController =
      TextEditingController();
  TextEditingController powerFailureEndDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  bool isDisabled = true;

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OccurrenceGeneralInfoCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<OccurrenceGeneralInfoCubit, GeneralInfoState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        // log('-deploymentOrderSubmitted---${state.guardingMasterData.deploymentOrderSubmitted}----');

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Occurrence',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPostivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                guardingMasterDataRoute,
                arguments: {},
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
        if (state.status == FormStatus.error) {
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
        }
      },
      builder: (context, state) {
        initializeDates();
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            //title: widget.title,
            showPopUp: false,
            showSaveButton: state.occurrence.status != 1 ? true : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<OccurrenceGeneralInfoCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            title: '',
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {
    // dateOfBirthController.text = Utils.timestamptoDateConversion(
    //     int.tryParse(widget.occurrence?.dateOfBirth ?? '0'),
    //     Constants.dateFormat);
    //
    // dateOfJoiningController.text = Utils.timestamptoDateConversion(
    //     int.parse(widget.occurrence?.dateOfJoining ?? '0'),
    //     Constants.dateFormat);
  }

  getBodybuilder(GeneralInfoState state, height) {
    //returnableTextController.text =
    // state.materialMovement.returnable! ? 'Returnable' : 'Non Returnable';

    if (state.status == FormStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      // log('---getAttachments----builder----${getAttachments?.length}-----');
      // getFiles = state.loadAttachments ?? [];
      // log('---guardAttachments----builder----${state.guardAttachments?.length}-----');
    }

    return Container(
        color: AppColors.navigationSkybluecolor,
        child: SingleChildScrollView(
            child: Column(children: [
          Container(
            height: height * 0.01,
            color: AppColors.navigationSkybluecolor,
          ),
          Container(
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhitecolor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  )),
              child: Form(
                  key: _formKey,
                  autovalidateMode: state.occurrence.status == 1
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Status
                              CommonWidgets.textDisplay(
                                  Constants.status, Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                isDisabled: isDisabled,
                                textController: statusController,
                                items: occurrenceStatusDropDownValues,
                                initialValue: '${state.occurrence.status ?? 0}',
                                onTap: () {
                                  if (widget.occurrence != null) {
                                    BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: occurrenceStatusDropDownValues
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            occurrenceStatusDropDownValues.firstWhere(
                                          (label) => label.key == value,
                                          orElse: () =>
                                              const Label(key: '', value: ''),
                                        );
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .updateDropdownValues(
                                                status: int.tryParse(
                                                    selectedLabel.value));
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Shift Handover By
                              CommonWidgets.verticalTextHandling(
                                  Constants.shiftHandoverBy,
                                  '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Location
                              CommonWidgets.textDisplay(
                                  Constants.location, Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              locationWidgetdislay(state),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Date of creation
                              CommonWidgets.textDisplay(
                                  Constants.dateofcreation,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDate().creationDateDisplay(
                                  state.occurrence.inputDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Sl No.
                              CommonWidgets.horizentaltextHandling(
                                  Constants.slno, state.occurrence.slNo ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Shift Briefing Attended
                              CommonWidgets.textDisplay(
                                  Constants.shiftBriefingAttended,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.shiftBrfngAttnded
                                          ? 1
                                          : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.shiftBrfngAttnded =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  shiftBrfngAttnded: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.shiftBrfngAttnded =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  shiftBrfngAttnded: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              ///premises Round Taken
                              CommonWidgets.textDisplay(
                                  Constants.premisesRoundTaken,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.premisesRoundTkn ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.premisesRoundTkn =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  premisesRoundTkn: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.premisesRoundTkn =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  premisesRoundTkn: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.occurrence.premisesRoundTkn ==
                                  true) ...[
                                /// Premises Round Taken Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.occurrence.premisesRoundTknComments,
                                  textFormKey: Keys.premisesRoundTknCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.occurrence.status != 6,
                                  isDisableColor: state.occurrence.status == 6,
                                  onChange: (String value) {
                                    state.occurrence.premisesRoundTknComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.occurrence);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              ///Medical Emergency
                              CommonWidgets.textDisplay(
                                  Constants.medicalEmergency,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.medicalEmrgncy ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.medicalEmrgncy =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(medicalEmrgncy: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.medicalEmrgncy =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  medicalEmrgncy: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),
                              if (state.occurrence.medicalEmrgncy == true) ...[
                                /// Medical Emergency Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.occurrence.medicalEmrgncyComments,
                                  textFormKey: Keys.emergencyCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.occurrence.status != 6,
                                  isDisableColor: state.occurrence.status == 6,
                                  onChange: (String value) {
                                    state.occurrence.medicalEmrgncyComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.occurrence);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              ///Material Movement
                              CommonWidgets.textDisplay(
                                  Constants.materialMovement,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.materialMovement ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.materialMovement =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  materialMovement: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.materialMovement =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  materialMovement: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              ///LEO Visit
                              CommonWidgets.textDisplay(
                                  Constants.lEOVisit, Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.leoVisit ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.leoVisit = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(leoVisit: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.leoVisit = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(leoVisit: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              ///Social Engineering Incidents
                              CommonWidgets.textDisplay(
                                  Constants.socialEngineeringIncidents,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.socialEnggIncdnt ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.socialEnggIncdnt =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  socialEnggIncdnt: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.socialEnggIncdnt =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  socialEnggIncdnt: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.occurrence.socialEnggIncdnt ==
                                  true) ...[
                                /// Medical Emergency Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.occurrence.socialEnggIncdntComments,
                                  textFormKey: Keys.socialEnggIncdntCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.occurrence.status != 6,
                                  isDisableColor: state.occurrence.status == 6,
                                  onChange: (String value) {
                                    state.occurrence.socialEnggIncdntComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.occurrence);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              ///Found Article Transaction
                              CommonWidgets.textDisplay(
                                  Constants.foundArticleTransaction,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.foundArticleTrnsctn
                                          ? 1
                                          : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.foundArticleTrnsctn =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  foundArticleTrnsctn: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.foundArticleTrnsctn =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  foundArticleTrnsctn: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              ///Process Breach Incident
                              CommonWidgets.textDisplay(
                                  Constants.processBreachIncident,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.processBreachIncdnt
                                          ? 1
                                          : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.processBreachIncdnt =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  processBreachIncdnt: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.processBreachIncdnt =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  processBreachIncdnt: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.occurrence.processBreachIncdnt ==
                                  true) ...[
                                CommonWidgets.textDisplay(
                                    Constants.incidentItemList,
                                    Styles.textStyleBlack14),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.pushNamed(context,
                                        incidentManagementDetailsRoute),
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      // Expanded(
                                      //child:
                                      const SizedBox(width: 14),
                                      SvgPicture.asset(
                                        AppIcon.pluscircle,
                                        //color: AppColors.navigationSkybluecolor,
                                      ),
                                      // ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Add Incident Item List',
                                        style: TextStyle(
                                          color:
                                              AppColors.navigationSkybluecolor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],

                              ///Any Infrastructural Issue
                              CommonWidgets.textDisplay(
                                  Constants.anyInfrastructuralIssue,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.infraIssue ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.infraIssue = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(infraIssue: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.infraIssue = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(infraIssue: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.occurrence.infraIssue == true) ...[
                                /// Any Infrastructural Issue Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.occurrence.infraIssueComments,
                                  textFormKey: Keys.infraIssueCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.occurrence.status != 6,
                                  isDisableColor: state.occurrence.status == 6,
                                  onChange: (String value) {
                                    state.occurrence.infraIssueComments = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.occurrence);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              ///Any Suspicious Activity
                              CommonWidgets.textDisplay(
                                  Constants.anySuspiciousActivity,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.suspiciousActivity
                                          ? 1
                                          : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.suspiciousActivity =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  suspiciousActivity: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.suspiciousActivity =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  suspiciousActivity: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.occurrence.suspiciousActivity ==
                                  true) ...[
                                CommonWidgets.textDisplay(
                                    Constants.incidentItemList,
                                    Styles.textStyleBlack14),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.pushNamed(context,
                                        incidentManagementDetailsRoute),
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      // Expanded(
                                      //child:
                                      const SizedBox(width: 14),
                                      SvgPicture.asset(
                                        AppIcon.pluscircle,
                                        //color: AppColors.navigationSkybluecolor,
                                      ),
                                      // ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Add Incident Item List',
                                        style: TextStyle(
                                          color:
                                              AppColors.navigationSkybluecolor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],

                              ///Fire Alarm Emergency Occurred
                              CommonWidgets.textDisplay(
                                  Constants.fireAlarmEmergencyOccurred,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.fireAlarmEmrgncy ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.fireAlarmEmrgncy =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  fireAlarmEmrgncy: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.fireAlarmEmrgncy =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  fireAlarmEmrgncy: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.occurrence.fireAlarmEmrgncy ==
                                  true) ...[
                                /// fire Alarm Emrgncy comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.occurrence.fireAlarmEmrgncyComments,
                                  textFormKey: Keys.fireAlarmEmrgncyCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.occurrence.status != 6,
                                  isDisableColor: state.occurrence.status == 6,
                                  onChange: (String value) {
                                    state.occurrence.fireAlarmEmrgncyComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.occurrence);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              ///Landlord Issue
                              CommonWidgets.textDisplay(Constants.landlordIssue,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.landlordIssue ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.landlordIssue = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(landlordIssue: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.landlordIssue =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(landlordIssue: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.occurrence.landlordIssue == true) ...[
                                /// fire Alarm Emrgncy comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.occurrence.landlordIssueComments,
                                  textFormKey: Keys.landlordIssueCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.occurrence.status != 6,
                                  isDisableColor: state.occurrence.status == 6,
                                  onChange: (String value) {
                                    state.occurrence.landlordIssueComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.occurrence);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              ///Security System Failure Incidents
                              CommonWidgets.textDisplay(
                                  Constants.securitySystemFailureIncidents,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.secSysFailureIncdnt
                                          ? 1
                                          : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.secSysFailureIncdnt =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  secSysFailureIncdnt: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.secSysFailureIncdnt =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  secSysFailureIncdnt: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),
                              if (state.occurrence.secSysFailureIncdnt ==
                                  true) ...[
                                CommonWidgets.textDisplay(
                                    Constants.securitySystemSLAList,
                                    Styles.textStyleBlack14),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.pushNamed(context,
                                        incidentManagementDetailsRoute),
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      // Expanded(
                                      //child:
                                      const SizedBox(width: 14),
                                      SvgPicture.asset(
                                        AppIcon.pluscircle,
                                        //color: AppColors.navigationSkybluecolor,
                                      ),
                                      // ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Add Security System SLA List',
                                        style: TextStyle(
                                          color:
                                              AppColors.navigationSkybluecolor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],

                              ///Any System Alarm Received
                              CommonWidgets.textDisplay(
                                  Constants.anySystemAlarmReceived,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.sysAlarmRcvd ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.sysAlarmRcvd = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(sysAlarmRcvd: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.sysAlarmRcvd = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(sysAlarmRcvd: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.occurrence.sysAlarmRcvd == true) ...[
                                /// Any system alarm received Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.occurrence.sysAlarmRcvdComments,
                                  textFormKey: Keys.sysAlarmRcvdCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.occurrence.status != 6,
                                  isDisableColor: state.occurrence.status == 6,
                                  onChange: (String value) {
                                    state.occurrence.sysAlarmRcvdComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.occurrence);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              ///Transport Incident
                              CommonWidgets.textDisplay(
                                  Constants.transportIncident,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.transportIncdnt ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.transportIncdnt =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  transportIncdnt: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.transportIncdnt =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  transportIncdnt: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.occurrence.transportIncdnt == true) ...[
                                /// Transport incident  Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.occurrence.transportIncdntComments,
                                  textFormKey: Keys.transportIncdntCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.occurrence.status != 6,
                                  isDisableColor: state.occurrence.status == 6,
                                  onChange: (String value) {
                                    state.occurrence.transportIncdntComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.occurrence);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              ///Any Event
                              CommonWidgets.textDisplay(
                                  Constants.anyEvent, Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.anyEvent ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.anyEvent = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(anyEvent: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.anyEvent = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(anyEvent: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.occurrence.anyEvent == true) ...[
                                /// Notifi SCRI
                                CommonWidgets.textDisplay(Constants.notifySCRI,
                                    Styles.textStyleBlack14),
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue: state.occurrence.notifyScri,
                                  textFormKey: Keys.notifyScriKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.occurrence.status != 6,
                                  isDisableColor: state.occurrence.status == 6,
                                  onChange: (String value) {
                                    state.occurrence.notifyScri = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.occurrence);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              ///Power Failure
                              CommonWidgets.textDisplay(Constants.powerFailure,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.powerFailure ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.powerFailure = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(powerFailure: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.powerFailure = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(powerFailure: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.occurrence.powerFailure == true) ...[
                                /// Power Failure Start Date
                                CommonWidgets.textDisplay(
                                  Constants.powerFailureDate,
                                  Styles.textStyleBlack14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                BaseDate().datePickerWidgetLoading(
                                  textController:
                                      powerFailureStartDateController,
                                  onlyDate: true,
                                  onChange: (String value) {
                                    state.occurrence.powerFailureStartDate =
                                        Utils().formatTime(value);
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                            context)
                                        .onModelValueChange(state.occurrence);
                                  },
                                  context: context,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Power Failure End Date
                                CommonWidgets.textDisplay(
                                  Constants.powerFailureEndDate,
                                  Styles.textStyleBlack14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                BaseDate().datePickerWidgetLoading(
                                  textController: powerFailureEndDateController,
                                  onlyDate: true,
                                  onChange: (String value) {
                                    state.occurrence.powerFailureEndDate =
                                        Utils().formatTime(value);
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                            context)
                                        .onModelValueChange(state.occurrence);
                                  },
                                  context: context,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                ///DG Working
                                CommonWidgets.textDisplay(Constants.dgWrking,
                                    Styles.textStyleBlack14),
                                RadioButtonsYesNo(
                                    status: state.occurrence.status ?? 0,
                                    selectedValue:
                                        state.occurrence.dgWrking ? 1 : 0,
                                    onChangedYes: widget.occurrence?.status == 6
                                        ? null
                                        : (val) {
                                            state.occurrence.dgWrking = true;
                                            BlocProvider.of<
                                                        OccurrenceGeneralInfoCubit>(
                                                    context)
                                                .showFields(dgWrking: true);
                                            //.onModelValueChange(state.guardingMasterData
                                            //);
                                          },
                                    onChangedNo: widget.occurrence?.status == 4
                                        ? null
                                        : (val) {
                                            state.occurrence.dgWrking = false;
                                            BlocProvider.of<
                                                        OccurrenceGeneralInfoCubit>(
                                                    context)
                                                .showFields(dgWrking: false);
                                            // .onModelValueChange(state.guardingMasterData
                                            //  );
                                          }),
                              ],

                              ///ATM Vendor Visit
                              CommonWidgets.textDisplay(
                                  Constants.aTMVendorVisit,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.atmVendorVisit ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.atmVendorVisit =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(atmVendorVisit: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.atmVendorVisit =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  atmVendorVisit: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              ///CWM Visit
                              CommonWidgets.textDisplay(
                                  Constants.cWMVisit, Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.cwmVisit ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.cwmVisit = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(cwmVisit: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.cwmVisit = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(cwmVisit: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              /// Follow up actions for next shift
                              CommonWidgets.textDisplay(
                                  Constants.followUp, Styles.textStyleBlack14),
                              FlutterInputField(
                                lineHeight: 6,
                                initialValue: state.occurrence.comments,
                                textFormKey: Keys.commentsKey,
                                hintText: Constants.informationhere,
                                isEnable: state.occurrence.status != 6,
                                isDisableColor: state.occurrence.status == 6,
                                onChange: (String value) {
                                  state.occurrence.comments = value;
                                  context
                                      .read<OccurrenceGeneralInfoCubit>()
                                      .onModelValueChange(state.occurrence);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Followed Up
                              CommonWidgets.textDisplay(Constants.followedUp,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.occurrence.status ?? 0,
                                  selectedValue:
                                      state.occurrence.followedUp ? 1 : 0,
                                  onChangedYes: widget.occurrence?.status == 6
                                      ? null
                                      : (val) {
                                          state.occurrence.followedUp = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(followedUp: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: widget.occurrence?.status == 4
                                      ? null
                                      : (val) {
                                          state.occurrence.followedUp = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(followedUp: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              /// SubmitButton
                              if (state.occurrence.status != 4) ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    cancelButtonDisplay(),
                                    submitButtonDisplay()
                                  ],
                                ),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.04),
                            ]))
                      ])))
        ])));
  }

  String getStatusString(int status) {
    switch (status) {
      case 1:
        return 'Active';
      case 2:
        return 'InActive';
      case 3:
        return 'Leave';
      case 4:
        return 'Week Off ';
      default:
        return 'Unknown Status';
    }
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

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<OccurrenceGeneralInfoCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }

  // Widget uploadWidget({
  //   required BuildContext context,
  //   required EntrySecurity loggedInUserDetails,
  //   required Function onImageSelected,
  //   // required List<CreateImage>? getFiles,
  // }) {
  //   return Container(
  //     height: 60,
  //     decoration: BoxDecoration(
  //         border: Border.all(
  //           color: const Color(0xFFCACACA),
  //           width: 1.0,
  //         ),
  //         borderRadius: const BorderRadius.all(Radius.circular(8))),
  //     child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
  //       Padding(
  //         padding: const EdgeInsets.only(right: 5.0),
  //         child: ElevatedButton.icon(
  //           style:
  //           ElevatedButton.styleFrom(fixedSize: const Size(140, 50)),
  //           onPressed: () {
  //             showDialog(
  //                 context: context,
  //                 builder: (BuildContext dialogContext) {
  //                   return UploadAttachment(
  //                     userdetails: loggedInUserDetails,
  //                     getFiles: getFiles ?? [],
  //                     onImageSelected: onImageSelected,
  //                   );
  //                 });
  //           },
  //
  //           icon: SvgPicture.asset(
  //             //AppIcon.dropdownicon,
  //             AppIcon.uploadicon,
  //             //fit: BoxFit.,
  //             color: AppColors.backgroundWhitecolor,
  //             width: 13,
  //             height: 13,
  //             key: const Key(Keys.userIcon),
  //           ),
  //           label: const Text(
  //             Constants.clicktoupload,
  //             style: Styles.textStyleRegularNormalWhite12,
  //           ),
  //         ),
  //       ),
  //     ]),
  //   );
  // }

  Widget locationWidgetdislay(GeneralInfoState state) {
    return GestureDetector(
      onTap: () {
        // if (widget.occurrence == null ||
        //     (state.occurrence.location?.name ?? '').isEmpty)
      //     {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              // print(state.getLocationsResponse);
              return CustomExpansionListTexts(
                getLocationsresponse: state.locations,
                onTap: (Mumbai? list) async {
                  log('list?.name-----${list?.name}');

                  Organisation location = Organisation();
                  location.id = list?.id;
                  location.name = list?.name;
                  state.occurrence.location = location;

                  BlocProvider.of<OccurrenceGeneralInfoCubit>(context)
                      .updateDropdownValues(location: location);
                },
              );
            },
          );
       // }
      },
      child:
          SelectedTileValueWidget(name: state.occurrence.location?.name ?? ''),
    );
  }

  Widget attachmentListviews(
    List<CreateImage>? attachmentListviews,
    List<FoundImage>? attachmentListviews1,
  ) {
    log('----attachmentListviews---cc--${attachmentListviews?.length}-----------');
    log('----attachmentListviews1----found-${attachmentListviews1?.length}-----------');

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
          itemCount:
              attachmentListviews1?.length ?? attachmentListviews?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            CreateImage? imagedata;
            FoundImage? imagedata1;
            if (widget.occurrence != null) {
              imagedata1 = attachmentListviews1?[index];
            } else {
              imagedata = attachmentListviews?[index];
            }

            return Column(
              children: <Widget>[
                ListTile(
                  trailing: widget.occurrence != null
                      ? SvgPicture.asset(AppIcon.download,
                          color: AppColors.boldgreyBackground)
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                  onTap: () {
                    DownloadImage().saveImage(
                        context, imagedata1?.id ?? 0, imagedata1?.title ?? '');
                  },
                  title: widget.occurrence != null
                      ? Text(imagedata1?.title ?? '')
                      : Text(imagedata1?.title ?? ''),
                ),

                const Divider(
                  color: Color(0xFFCACACA),
                  thickness: 1,
                ), //
              ],
            );
          }),
    );
  }
}
