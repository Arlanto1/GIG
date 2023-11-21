import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_drop_down.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/date_picker_dialog.dart';
import 'package:db_atom/src/common_widgets/base_widget/selected_tile_value_widget.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common_widgets/base_widget/base_department_dialog.dart';
import '../../../../../common_widgets/base_widget/radio_buttons_yes_no.dart';
import '../../../../../common_widgets/new_search_textfield.dart';
import '../../../../../common_widgets/textfiled_addbutton.dart';
import '../../../../../models/base_user.dart';
import '../cubits/sst_incident_general_info_cubit.dart';

class SstIncidentGeneralInfoView extends StatefulWidget {
  final bool isInternal;
  final bool viaOccurrence;

  const SstIncidentGeneralInfoView({
    super.key,
    required this.isInternal,
    required this.viaOccurrence,
  });

  @override
  State<SstIncidentGeneralInfoView> createState() =>
      _SstIncidentGeneralInfoViewState();
}

class _SstIncidentGeneralInfoViewState
    extends State<SstIncidentGeneralInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController incidentDateTimeController = TextEditingController();
  TextEditingController closureTargetDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController assetTypeController = TextEditingController();
  TextEditingController incidentTypeController = TextEditingController();
  TextEditingController systemController = TextEditingController();
  bool isDisabled = true;
  bool disableForm = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SstIncidentGeneralInfoCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<SstIncidentGeneralInfoCubit,
        SstIncidentGeneralInfoState>(
      listener: (context, state) {
        log('--state.status---${state.status}---');
        log('--state.message---${state.message}---');
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.generalInformation,
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPostivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              if (widget.viaOccurrence) {
                return Navigator.pushNamed(
                  context,
                  occurrenceDetailsRoute,
                  arguments: {
                    'id': state.model.occurrence?.id.toString(),
                    "title": Constants.editOccurrence,
                  },
                );
              }
              Navigator.popAndPushNamed(
                context,
                sstIncidentListRoute,
                arguments: {"isInternal": widget.isInternal},
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
          log('-if error-state.status---${state.status}---');
          log('-if error-state.message---${state.message}---');
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
        }
      },
      builder: (context, state) {
        state.model.status ??= 0;
        if (state.model.id != null && state.model.status! > 0) {
          log('--state.model.status----asd---${state.model.status}-');
          disableForm = true;
        }
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.isInternal
                ? Constants.internalStaff
                : Constants.externalVendor,
            showPopUp: false,
            showSaveButton: disableForm ? false : true,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<SstIncidentGeneralInfoCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    );
  }

  getBodybuilder(SstIncidentGeneralInfoState state, height) {
    if (state.status == FormStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

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
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhitecolor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  )),
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
                        absorbing: disableForm,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.generalinformation,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Created By
                            CommonWidgets.horizentaltextHandling(
                                Constants.createdby,
                                isMandatory: true,
                                '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Status
                            CommonWidgets.textDisplay(
                                Constants.status,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: state.model.status != 0,
                                textController: statusController,
                                items: incidentManagementStatus,
                                initialValue: '${state.model.status ?? 0}',
                                onTap: () {
                                  if (state.model.id == null &&
                                      state.model.id != null) {
                                    BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: incidentManagementStatus
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            incidentManagementStatus.firstWhere(
                                          (label) => label.key == value,
                                          orElse: () =>
                                              const Label(key: '', value: ''),
                                        );
                                        BlocProvider.of<
                                                    SstIncidentGeneralInfoCubit>(
                                                context)
                                            .updateDropdownValues(
                                          status:
                                              int.tryParse(selectedLabel.value),
                                        );
                                      },
                                    );
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                                Constants.dateofcreation,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDate().creationDateDisplay(
                                state.model.createdDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location
                            CommonWidgets.textDisplay(
                                Constants.location,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            locationWidgetdislay(
                                selectedLocation:
                                    state.model.location?.name ?? '',
                                enabled: state.model.id == null ||
                                    (state.model.location?.name ?? '').isEmpty,
                                locations: state.locations,
                                onTap: (Organisation? location) async {
                                  log('location?.name-----${location?.name}');

                                  state.model.location = location;

                                  BlocProvider.of<SstIncidentGeneralInfoCubit>(
                                          context)
                                      .updateDropdownValues(location: location);
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Sl No.
                            CommonWidgets.horizentaltextHandling(
                                Constants.slno,
                                isMandatory: true,
                                state.model.slNo ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// System
                            CommonWidgets.textDisplay(
                                Constants.system,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: state.model.status != 6,
                                textController: systemController,
                                items: systemDropDownValues,
                                initialValue: state.model.systemSLA.toString(),
                                onTap: () {
                                  if (isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues: systemDropDownValues
                                            .map((label) => label.key)
                                            .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              systemDropDownValues.firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      SstIncidentGeneralInfoCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  systemSLA: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Vendor
                            CommonWidgets.textDisplay(
                              Constants.vendor,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            TextfieldAddButton(
                              title: state.model.vendor?.name,
                              height: 70,
                              isDisableColor: disableForm,
                              onTap: () {
                                BaseDepartmentDialog().departmentDialog(
                                  context: context,
                                  //enabled: !disableForm,
                                  departments: state.vendors,
                                  onTap: (Organisation user) {
                                    BlocProvider.of<
                                                SstIncidentGeneralInfoCubit>(
                                            context)
                                        .updateDropdownValues(
                                      vendor: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Vendor Poc
                            CommonWidgets.textDisplay(
                                Constants.vendorPoc,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 1,
                              initialValue: state.model.vendorPoc,
                              textFormKey: Keys.claimantTextController,
                              hintText: Constants.informationhere,
                              isEnable: state.model.status != 6,
                              isDisableColor: state.model.status == 6,
                              onChange: (String value) {
                                state.model.vendorPoc = value;
                                context
                                    .read<SstIncidentGeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// System Manager
                            CommonWidgets.textDisplay(
                              Constants.systemManager,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            TextfieldAddButton(
                              title: state.model.systemManager?.name,
                              height: 70,
                              isDisableColor: disableForm,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  enabled: !disableForm,
                                  users: state.emailUsers!,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<
                                                SstIncidentGeneralInfoCubit>(
                                            context)
                                        .updateDropdownValues(
                                      systemManager: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// LSM
                            CommonWidgets.textDisplay(
                              Constants.lsm,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            TextfieldAddButton(
                              title: state.model.lsm?.name,
                              height: 70,
                              isDisableColor: disableForm,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  enabled: !disableForm,
                                  users: state.emailUsers!,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<
                                                SstIncidentGeneralInfoCubit>(
                                            context)
                                        .updateDropdownValues(
                                      lsm: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// ASL
                            CommonWidgets.textDisplay(
                              Constants.asl,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            TextfieldAddButton(
                              title: state.model.asl?.name,
                              height: 70,
                              isDisableColor: disableForm,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  enabled: !disableForm,
                                  users: state.emailUsers!,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<
                                                SstIncidentGeneralInfoCubit>(
                                            context)
                                        .updateDropdownValues(
                                      asl: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location Team
                            CommonWidgets.textDisplay(
                              Constants.locationTeam,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            TextfieldAddButton(
                              title: state.model.lt?.name,
                              height: 70,
                              isDisableColor: disableForm,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  enabled: !disableForm,
                                  users: state.emailUsers!,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<
                                                SstIncidentGeneralInfoCubit>(
                                            context)
                                        .updateDropdownValues(
                                      lt: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Short Description of Incident
                            CommonWidgets.textDisplay(
                                Constants.shortIncidentDescription,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              showBorder: true,
                              initialValue: state.model.shortDescription,
                              textFormKey: Keys.incidentDescription,
                              hintText: Constants.informationhere,
                              isEnable: state.model.status != 6,
                              isDisableColor: state.model.status == 6,
                              onChange: (String value) {
                                state.model.shortDescription = value;
                                context
                                    .read<SstIncidentGeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Detail Description
                            CommonWidgets.textDisplay(
                                Constants.detailIncidentDescription,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue: state.model.detailDescription,
                              showBorder: true,
                              textFormKey: Keys.incidentDescription,
                              hintText: Constants.informationhere,
                              isEnable: state.model.status != 6,
                              isDisableColor: state.model.status == 6,
                              onChange: (String value) {
                                state.model.detailDescription = value;
                                context
                                    .read<SstIncidentGeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// IPB Area
                            CommonWidgets.textDisplay(
                                Constants.ipbArea,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue: state.model.ipbArea ? 1 : 0,
                              onChangedYes: disableForm
                                  ? null
                                  : (val) {
                                      state.model.ipbArea = true;
                                      BlocProvider.of<
                                                  SstIncidentGeneralInfoCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    },
                              onChangedNo: state.model.status == 39
                                  ? null
                                  : (val) {
                                      state.model.ipbArea = false;
                                      BlocProvider.of<
                                                  SstIncidentGeneralInfoCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    },
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ]),
                        ),
                      ),

                      /// SubmitButton
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cancelButtonDisplay(),
                          if (!disableForm) ...[
                            submitButtonDisplay(onTap: () {
                              FocusScope.of(context).unfocus();
                              BlocProvider.of<SstIncidentGeneralInfoCubit>(
                                      context)
                                  .submitForm(isSaveOnly: false);
                            })
                          ],
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ]),
              ),
            ),
          ],
        ),
      ),
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

  Widget submitButtonDisplay(
      {required Function onTap, String? label = Constants.submit}) {
    return AppButton(
      width: 150,
      buttonText: label,
      buttonTextKey: Keys.submitButton,
      onTap: onTap,
    );
  }

  // Widget submitButtonDisplay() {
  //   return AppButton(
  //     width: 150,
  //     key: const Key(Keys.submitButton),
  //     buttonText: Constants.submit,
  //     buttonTextKey: Keys.submitButton,
  //     onTap: () async {
  //       FocusScope.of(context).unfocus();
  //       BlocProvider.of<GeneralInfoCubit>(context)
  //           .submitForm(isSaveOnly: false);
  //     },
  //   );
  // }

  Widget locationWidgetdislay({
    required bool enabled,
    Locations? locations,
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

  void selectLocation({Locations? locations, Function? onTap}) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // print(state.getLocationsResponse);
        return CustomExpansionListTexts(
          locationList: locations,
          onTap: onTap,
        );
      },
    );
  }

  TextEditingController addEPOfficerController = TextEditingController();
}
