import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/base_department_dialog.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/radio_buttons_yes_no.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/features/occurrence/occurrences_details/general_info/cubits/occurrence_general_info_cubit.dart';
import 'package:db_atom/src/models/base_user.dart';
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

class OccurrenceDetails extends StatefulWidget {
  final String title;

  const OccurrenceDetails({
    super.key,
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
  bool disableForm = true;

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
    return BlocConsumer<OccurrenceGeneralInfoCubit, OccurrenceGeneralInfoState>(
      listener: (context, state) {
        log('State Status: ${state.status}');
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
                occurrenceRoute,
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
            showSaveButton: state.model.status != 1 ? true : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<OccurrenceGeneralInfoCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            title: Constants.createOccurrence,
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {
    // dateOfBirthController.text = Utils.timestamptoDateConversion(
    //     int.tryParse(state.model.dateOfBirth ?? '0'),
    //     Constants.dateFormat);
    //
    // dateOfJoiningController.text = Utils.timestamptoDateConversion(
    //     int.parse(state.model.dateOfJoining ?? '0'),
    //     Constants.dateFormat);
  }

  getBodybuilder(OccurrenceGeneralInfoState state, height) {
    //returnableTextController.text =
    // state.materialMovement.returnable! ? 'Returnable' : 'Non Returnable';
    if (state.model.status != null && state.model.status! > 0) {
      disableForm = true;
    }
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
                  autovalidateMode: state.model.status == 1
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
                                isDisabled: disableForm,
                                textController: statusController,
                                items: occurrenceStatusDropDownValues,
                                initialValue: '${state.model.status ??= 0}',
                                onTap: () {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues:
                                        occurrenceStatusDropDownValues
                                            .map((label) => label.key)
                                            .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          occurrenceStatusDropDownValues
                                              .firstWhere(
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
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Shift Handover By
                              CommonWidgets.verticalTextHandling(
                                  Constants.shiftHandoverBy,
                                  '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Shift Taken Over by
                              CommonWidgets.textDisplay(
                                Constants.shiftTakenOverBy,
                                Styles.textStyleBlack14,
                              ),
                              TextfieldAddButton(
                                  title: state.model.handOverSecurity?.name,
                                  height: 70,
                                  isDisableColor:
                                      state.model.status != 6 ? false : true,
                                  onTap: () {
                                    if (state.model.status != 6) {
                                      BaseDepartmentDialog().userDialog(
                                        context: context,
                                        users: state.emailUsers!,
                                        onTap: (BaseUser user) {
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  shiftTakenOverBy: user);
                                        },
                                      );
                                    }
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Location
                              CommonWidgets.textDisplay(
                                  Constants.location, Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              locationWidgetdislay(
                                  selectedLocation:
                                      state.model.location?.name ?? '',
                                  enabled: state.model.id == null ||
                                      (state.model.location?.name ?? '')
                                          .isEmpty,
                                  locations: state.locations,
                                  onTap: (Organisation? location) async {
                                    log('location?.name-----${location?.name}');

                                    state.model.location = location;

                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                            context)
                                        .updateDropdownValues(
                                            location: location);
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Date of creation
                              CommonWidgets.textDisplay(
                                  Constants.dateofcreation,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDate().creationDateDisplay(
                                  state.model.inputDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Sl No.
                              CommonWidgets.horizentaltextHandling(
                                  Constants.slno, state.model.slNo ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Shift Briefing Attended
                              CommonWidgets.textDisplay(
                                  Constants.shiftBriefingAttended,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.shiftBrfngAttnded ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.shiftBrfngAttnded = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  shiftBrfngAttnded: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.shiftBrfngAttnded = false;
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
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.premisesRoundTkn ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.premisesRoundTkn = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  premisesRoundTkn: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.premisesRoundTkn = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  premisesRoundTkn: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.model.premisesRoundTkn == true) ...[
                                /// Premises Round Taken Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.model.premisesRoundTknComments,
                                  textFormKey: Keys.premisesRoundTknCommentsKey,
                                  hintText: Constants.informationhere,
                                  showBorder: true,
                                  isEnable: state.model.status != 6,
                                  isDisableColor: state.model.status == 6,
                                  onChange: (String value) {
                                    state.model.premisesRoundTknComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
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
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.medicalEmrgncy ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.medicalEmrgncy = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(medicalEmrgncy: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.medicalEmrgncy = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  medicalEmrgncy: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),
                              if (state.model.medicalEmrgncy == true) ...[
                                /// Medical Emergency Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.model.medicalEmrgncyComments,
                                  showBorder: true,
                                  textFormKey: Keys.emergencyCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.model.status != 6,
                                  isDisableColor: state.model.status == 6,
                                  onChange: (String value) {
                                    state.model.medicalEmrgncyComments = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
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
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.materialMovement ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.materialMovement = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  materialMovement: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.materialMovement = false;
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
                                  status: state.model.status ?? 0,
                                  selectedValue: state.model.leoVisit ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.leoVisit = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(leoVisit: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.leoVisit = false;
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
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.socialEnggIncdnt ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.socialEnggIncdnt = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  socialEnggIncdnt: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.socialEnggIncdnt = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  socialEnggIncdnt: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.model.socialEnggIncdnt == true) ...[
                                /// Medical Emergency Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.model.socialEnggIncdntComments,
                                  showBorder: true,
                                  textFormKey: Keys.socialEnggIncdntCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.model.status != 6,
                                  isDisableColor: state.model.status == 6,
                                  onChange: (String value) {
                                    state.model.socialEnggIncdntComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
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
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.foundArticleTrnsctn ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.foundArticleTrnsctn =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  foundArticleTrnsctn: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.foundArticleTrnsctn =
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
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.processBreachIncdnt ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.processBreachIncdnt =
                                              true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  processBreachIncdnt: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.processBreachIncdnt =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  processBreachIncdnt: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.model.processBreachIncdnt == true) ...[
                                CommonWidgets.textDisplay(
                                    Constants.incidentItemList,
                                    Styles.textStyleBlack14),
                                GestureDetector(
                                  onTap: () => navigateToCreateIncident(
                                    state: state,
                                    occId: 1,
                                    isSSTIncident: false,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(width: 14),
                                      SvgPicture.asset(
                                        AppIcon.pluscircle,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Add Incident Item List',
                                        style: TextStyle(
                                          color:
                                              AppColors.navigationSkybluecolor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      if (state.model.incidentItems !=
                                          null) ...[
                                        CommonWidgets.horizontalSpacerWidget(
                                            height * 0.01),
                                        showButtonDisplay(
                                          occId: state.model.id.toString(),
                                          occType: 1,
                                          state: state,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],

                              ///Any Infrastructural Issue
                              CommonWidgets.textDisplay(
                                  Constants.anyInfrastructuralIssue,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue: state.model.infraIssue ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.infraIssue = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(infraIssue: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.infraIssue = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(infraIssue: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.model.infraIssue == true) ...[
                                /// Any Infrastructural Issue Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue: state.model.infraIssueComments,
                                  textFormKey: Keys.infraIssueCommentsKey,
                                  showBorder: true,
                                  hintText: Constants.informationhere,
                                  isEnable: state.model.status != 6,
                                  isDisableColor: state.model.status == 6,
                                  onChange: (String value) {
                                    state.model.infraIssueComments = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
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
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.suspiciousActivity ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.suspiciousActivity = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  suspiciousActivity: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.suspiciousActivity =
                                              false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  suspiciousActivity: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.model.suspiciousActivity == true) ...[
                                CommonWidgets.textDisplay(
                                    Constants.incidentItemList,
                                    Styles.textStyleBlack14),
                                GestureDetector(
                                  onTap: () => navigateToCreateIncident(
                                    state: state,
                                    occId: 2,
                                    isSSTIncident: false,
                                  ),
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
                                      if (state.model.incidentItems !=
                                          null) ...[
                                        CommonWidgets.horizontalSpacerWidget(
                                            height * 0.01),
                                        showButtonDisplay(
                                          occId: state.model.id.toString(),
                                          occType: 2,
                                          state: state,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],

                              ///Fire Alarm Emergency Occurred
                              CommonWidgets.textDisplay(
                                  Constants.fireAlarmEmergencyOccurred,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.fireAlarmEmrgncy ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.fireAlarmEmrgncy = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  fireAlarmEmrgncy: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.fireAlarmEmrgncy = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  fireAlarmEmrgncy: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.model.fireAlarmEmrgncy == true) ...[
                                /// fire Alarm Emrgncy comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.model.fireAlarmEmrgncyComments,
                                  showBorder: true,
                                  textFormKey: Keys.fireAlarmEmrgncyCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.model.status != 6,
                                  isDisableColor: state.model.status == 6,
                                  onChange: (String value) {
                                    state.model.fireAlarmEmrgncyComments =
                                        value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
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
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.landlordIssue ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.landlordIssue = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(landlordIssue: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.landlordIssue = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(landlordIssue: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.model.landlordIssue == true) ...[
                                /// fire Alarm Emrgncy comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.model.landlordIssueComments,
                                  showBorder: true,
                                  textFormKey: Keys.landlordIssueCommentsKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.model.status != 6,
                                  isDisableColor: state.model.status == 6,
                                  onChange: (String value) {
                                    state.model.landlordIssueComments = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
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
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.secSysFailureIncdnt ? 1 : 0,
                                onChangedYes: state.model.status == 6
                                    ? null
                                    : (val) {
                                        state.model.secSysFailureIncdnt = true;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                                secSysFailureIncdnt: true);
                                        //.onModelValueChange(state.guardingMasterData
                                        //);
                                      },
                                onChangedNo: state.model.status == 4
                                    ? null
                                    : (val) {
                                        state.model.secSysFailureIncdnt = false;
                                        BlocProvider.of<
                                                    OccurrenceGeneralInfoCubit>(
                                                context)
                                            .showFields(
                                                secSysFailureIncdnt: false);
                                        // .onModelValueChange(state.guardingMasterData
                                        //  );
                                      },
                              ),
                              if (state.model.secSysFailureIncdnt == true) ...[
                                CommonWidgets.textDisplay(
                                    Constants.securitySystemSLAList,
                                    Styles.textStyleBlack14),
                                GestureDetector(
                                  onTap: () {
                                    openPopUp(state);
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      const SizedBox(width: 14),
                                      SvgPicture.asset(
                                        AppIcon.pluscircle,
                                        //color: AppColors.navigationSkybluecolor,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Add Security System SLA List',
                                        style: TextStyle(
                                          color:
                                              AppColors.navigationSkybluecolor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      if (state.model.secSysFailureIncident !=
                                          null) ...[
                                        CommonWidgets.horizontalSpacerWidget(
                                            height * 0.01),
                                        showButtonDisplay(
                                          occId: state.model.id.toString(),
                                          occType: 2,
                                          state: state,
                                          isSSTIncident: true,
                                          showPopUp: true,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],

                              ///Any System Alarm Received
                              CommonWidgets.textDisplay(
                                  Constants.anySystemAlarmReceived,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.sysAlarmRcvd ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.sysAlarmRcvd = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(sysAlarmRcvd: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.sysAlarmRcvd = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(sysAlarmRcvd: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.model.sysAlarmRcvd == true) ...[
                                /// Any system alarm received Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.model.sysAlarmRcvdComments,
                                  textFormKey: Keys.sysAlarmRcvdCommentsKey,
                                  showBorder: true,
                                  hintText: Constants.informationhere,
                                  isEnable: state.model.status != 6,
                                  isDisableColor: state.model.status == 6,
                                  onChange: (String value) {
                                    state.model.sysAlarmRcvdComments = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
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
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.transportIncdnt ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.transportIncdnt = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  transportIncdnt: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.transportIncdnt = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(
                                                  transportIncdnt: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.model.transportIncdnt == true) ...[
                                /// Transport incident  Comments
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.model.transportIncdntComments,
                                  textFormKey: Keys.transportIncdntCommentsKey,
                                  hintText: Constants.informationhere,
                                  showBorder: true,
                                  isEnable: state.model.status != 6,
                                  isDisableColor: state.model.status == 6,
                                  onChange: (String value) {
                                    state.model.transportIncdntComments = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
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
                                  status: state.model.status ?? 0,
                                  selectedValue: state.model.anyEvent ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.anyEvent = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(anyEvent: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.anyEvent = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(anyEvent: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.model.anyEvent == true) ...[
                                /// Notifi SCRI
                                CommonWidgets.textDisplay(Constants.notifySCRI,
                                    Styles.textStyleBlack14),
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue: state.model.notifyScri,
                                  textFormKey: Keys.notifyScriKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.model.status != 6,
                                  showBorder: true,
                                  isDisableColor: state.model.status == 6,
                                  onChange: (String value) {
                                    state.model.notifyScri = value;
                                    context
                                        .read<OccurrenceGeneralInfoCubit>()
                                        .onModelValueChange(state.model);
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
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.powerFailure ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.powerFailure = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(powerFailure: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.powerFailure = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(powerFailure: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              if (state.model.powerFailure == true) ...[
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
                                  onChange: (String value) {
                                    state.model.powerFailureStartDate =
                                        Utils().formatTime(value);
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                            context)
                                        .onModelValueChange(state.model);
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
                                  onChange: (String value) {
                                    state.model.powerFailureEndDate =
                                        Utils().formatTime(value);
                                    BlocProvider.of<OccurrenceGeneralInfoCubit>(
                                            context)
                                        .onModelValueChange(state.model);
                                  },
                                  context: context,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                ///DG Working
                                CommonWidgets.textDisplay(Constants.dgWrking,
                                    Styles.textStyleBlack14),
                                RadioButtonsYesNo(
                                    status: state.model.status ?? 0,
                                    selectedValue: state.model.dgWrking ? 1 : 0,
                                    onChangedYes: state.model.status == 6
                                        ? null
                                        : (val) {
                                            state.model.dgWrking = true;
                                            BlocProvider.of<
                                                        OccurrenceGeneralInfoCubit>(
                                                    context)
                                                .showFields(dgWrking: true);
                                            //.onModelValueChange(state.guardingMasterData
                                            //);
                                          },
                                    onChangedNo: state.model.status == 4
                                        ? null
                                        : (val) {
                                            state.model.dgWrking = false;
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
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.atmVendorVisit ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.atmVendorVisit = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(atmVendorVisit: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.atmVendorVisit = false;
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
                                  status: state.model.status ?? 0,
                                  selectedValue: state.model.cwmVisit ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.cwmVisit = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(cwmVisit: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.cwmVisit = false;
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
                                initialValue: state.model.comments,
                                textFormKey: Keys.commentsKey,
                                hintText: Constants.informationhere,
                                showBorder: true,
                                isEnable: state.model.status != 6,
                                isDisableColor: state.model.status == 6,
                                onChange: (String value) {
                                  state.model.comments = value;
                                  context
                                      .read<OccurrenceGeneralInfoCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Followed Up
                              CommonWidgets.textDisplay(Constants.followedUp,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue: state.model.followedUp ? 1 : 0,
                                  onChangedYes: state.model.status == 6
                                      ? null
                                      : (val) {
                                          state.model.followedUp = true;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(followedUp: true);
                                          //.onModelValueChange(state.guardingMasterData
                                          //);
                                        },
                                  onChangedNo: state.model.status == 4
                                      ? null
                                      : (val) {
                                          state.model.followedUp = false;
                                          BlocProvider.of<
                                                      OccurrenceGeneralInfoCubit>(
                                                  context)
                                              .showFields(followedUp: false);
                                          // .onModelValueChange(state.guardingMasterData
                                          //  );
                                        }),

                              /// SubmitButton
                              if (state.model.status != 4) ...[
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

  openPopUp(OccurrenceGeneralInfoState state) {
    BaseDropDown().assetTypeDialog(
      context: context,
      dropDownValues: sstIncidentType.map((label) => label.key).toList(),
      pop: false,
      onTap: (String value) {
        Label? selectedLabel;
        selectedLabel = sstIncidentType.firstWhere(
          (label) => label.key == value,
          orElse: () => const Label(key: '', value: ''),
        );

        // Call navigateToCreateIncident here
        navigateToCreateIncident(
          state: state,
          occId: 1,
          isSSTIncident: true,
          isInternal: selectedLabel.value == '0' ? true : false,
        );
      },
    );
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

  Future<void> navigateToCreateIncident({
    required OccurrenceGeneralInfoState state,
    required int occId,
    required bool isSSTIncident,
    bool? isInternal,
  }) async {
    log('---navigateToCreateIncident--@@@-');
    // if (state.model.id == null) {
    //   BlocProvider.of<OccurrenceGeneralInfoCubit>(context)
    //       .submitForm(isSaveOnly: true);
    // }

    var map = {
      'occId': state.model.id.toString(),
      'occType': occId,
    };
    if (isInternal ?? false) {
      map.putIfAbsent('isInternal', () => isInternal ?? false);
    }
    log('---navigateToCreateIncident--@@@----2----');

    Navigator.pushNamed(
      context,
      isSSTIncident ? sstIncidentDetailsRoute : incidentManagementDetailsRoute,
      arguments: map,
    );
  }

  Widget showButtonDisplay({
    required String occId,
    required int occType,
    bool? isSSTIncident,
    bool? showPopUp,
    required OccurrenceGeneralInfoState state,
  }) {
    return AppButton(
      // Customize the button properties as needed
      height: 40,
      width: 100,
      backgroundColor: Colors.white,
      key: const Key(Keys.showButton),
      buttonText: Constants.showList,
      buttonTextKey: Keys.showButton,
      onTap: () => {
        showPopUp ?? false
            ? openPopUp(state)
            : Navigator.pushNamed(
                context,
                incidentManagementsRoute,
                arguments: {
                  'occId': occId,
                  'occType': occType,
                },
              ),
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

  Widget locationWidgetdislay({
    required bool enabled,
    GetLocations? locations,
    required String selectedLocation,
    Function? onTap,
  }) {
    return GestureDetector(
      onTap: () {
        if (enabled) {
          selectLocation(
            locations: locations,
            onTap: onTap,
          );
        }
      },
      child: SelectedTileValueWidget(name: selectedLocation),
    );
  }

  void selectLocation({GetLocations? locations, Function? onTap}) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // print(state.getLocationsResponse);
        return CustomExpansionListTexts(
          getLocationsresponse: locations,
          onTap: onTap,
        );
      },
    );
  }
}
