import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_drop_down.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_entities_dropdown.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/date_picker_dialog.dart';
import 'package:db_atom/src/common_widgets/base_widget/selected_tile_value_widget.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/models/location.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../main_DEV.dart';
import '../../../../../common_widgets/base_widget/base_department_dialog.dart';
import '../../../../../common_widgets/base_widget/radio_buttons_yes_no.dart';
import '../../../../../common_widgets/new_search_textfield.dart';
import '../../../../../common_widgets/textfiled_addbutton.dart';
import '../../../../../models/base_user.dart';
import '../../../../../models/department.dart';
import '../../../../../utils/util.dart';
import '../cubits/general_info_cubit.dart';

class GeneralInfoView extends StatefulWidget {
  const GeneralInfoView({
    super.key,
  });

  @override
  State<GeneralInfoView> createState() => _GeneralInfoViewState();
}

class _GeneralInfoViewState extends State<GeneralInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GetUserDetails? userDetails;
  List<CreateImage>? getFiles;
  List<CreateImage>? guardFiles;
  List<CreateImage>? deploymentFiles;
  List<CreateImage>? bioDataFiles;
  List<CreateImage>? permanentAddressFiles;
  List<CreateImage>? localAddressFiles;
  TextEditingController eventStartDateController = TextEditingController();
  TextEditingController eventEndDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  bool isDisabled = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GeneralInfoCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<GeneralInfoCubit, GeneralInfoState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'General Information',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPostivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                eventProtectionListRoute,
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
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.generalInformation,
            showPopUp: false,
            showSaveButton: state.model.status == 0 ? true : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<GeneralInfoCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(GeneralInfoState state) {
    log('--sdd--${state.model.eventStartDate}-------');
    log('--sdd-eventEndDate-${state.model.eventEndDate}-------');
    if (state.model.eventStartDate != null) {
      eventStartDateController.text = Utils.timestamptoDateConversion(
          int.tryParse(state.model.eventStartDate ?? '0'),
          Constants.dateFormat);
    }
    if (state.model.eventEndDate != null) {
      eventEndDateController.text = Utils.timestamptoDateConversion(
          int.tryParse(state.model.eventEndDate ?? '0'), Constants.dateFormat);
    }
  }

  bool disableForm = false;
  getBodybuilder(GeneralInfoState state, height) {
    log('--creation Date-${state.model.inputDate}----------');
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    log('--state.model-----${state.model.status}----------');

    if(state.model.status == null) {
      log('--state.model--2---${state.model.status}----------');
      state.model.status = 0;
    }
    log('--state.model---3--${state.model.status}----------');
    if(state.model.status!>0) {
      disableForm = true;
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
                      Padding(
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

                          /// Status
                          CommonWidgets.textDisplay(
                              Constants.status, Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDropDown().getDropDown(
                              isDisabled: state.model.status != 0,
                              textController: statusController,
                              items: eventProtectionGiStatus,
                              initialValue: '${state.model.status ?? 0}',
                              onTap: () {
                                if (state.model.id != null) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: eventProtectionGiStatus
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          eventProtectionGiStatus.firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      BlocProvider.of<GeneralInfoCubit>(context)
                                          .updateDropdownValues(
                                              status: int.tryParse(
                                                  selectedLabel.value));
                                    },
                                  );
                                }
                              }),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Sl No.
                          CommonWidgets.horizentaltextHandling(
                              Constants.slno, state.model.slNo ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Date of creation
                          CommonWidgets.textDisplay(Constants.dateofcreation,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDate()
                              .creationDateDisplay(state.model.inputDate ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Location
                          CommonWidgets.textDisplay(
                              Constants.location, Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          locationWidgetdislay(state),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Entity
                          CommonWidgets.textDisplay(
                            Constants.entity,
                            Styles.textStyleBlack14,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),

                          BaseEntitiesSelection().entityDropDownSelection(
                              context: context,
                              selectedValues: state.model.entities ?? [],
                              all: state.listOfEntities ?? [],
                              onTap: (List<Entity> selectedEntities) {
                                log('--selectedEntities----${selectedEntities.length}');
                                BlocProvider.of<GeneralInfoCubit>(context)
                                    .updateDropdownValues(
                                        entities: selectedEntities);
                                Navigator.of(context).pop(); // Close the dialog
                              }),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Event Start Date
                          CommonWidgets.textDisplay(
                            Constants.eventStartDate,
                            Styles.textStyleBlack14,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),

                          BaseDate().datePickerWidgetLoading(
                            textController: eventStartDateController,
                            onlyDate: true,
                            onChange: (String value) {
                              log('---value-$value------');
                              state.model.eventStartDate =
                                  Utils().formatTime(value);
                              log('---value11-${state.model.eventStartDate}------');
                              BlocProvider.of<GeneralInfoCubit>(context)
                                  .onModelValueChange(state.model);
                            },
                            context: context,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Event End Date
                          CommonWidgets.textDisplay(
                            Constants.eventEndDate,
                            Styles.textStyleBlack14,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),

                          BaseDate().datePickerWidgetLoading(
                            textController: eventEndDateController,
                            onlyDate: true,
                            onChange: (String value) {
                              state.model.eventEndDate =
                                  Utils().formatTime(value);
                              BlocProvider.of<GeneralInfoCubit>(context)
                                  .onModelValueChange(state.model);
                              log('---value22-${state.model.eventEndDate}------');
                            },
                            context: context,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///  Is Annual Power Shutdown?
                          CommonWidgets.textDisplay(
                              Constants.isAnnualPowerShutdown,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue:
                                  state.model.annualPowerShutdown ? 1 : 0,
                              onChangedYes: state.model.status == 6
                                  ? null
                                  : (val) {
                                      state.model.annualPowerShutdown = true;
                                      BlocProvider.of<GeneralInfoCubit>(context)
                                          .showFields(
                                              annualPowerShutdown: true);
                                      //.onModelValueChange(state.guardingMasterData
                                      //);
                                    },
                              onChangedNo: state.model.status == 4
                                  ? null
                                  : (val) {
                                      state.model.annualPowerShutdown = false;
                                      BlocProvider.of<GeneralInfoCubit>(context)
                                          .showFields(
                                              annualPowerShutdown: false);
                                      // .onModelValueChange(state.guardingMasterData
                                      //  );
                                    }),
                          if (state.model.annualPowerShutdown) ...[
                            /// Sub Regional Head (SRH) 1
                            CommonWidgets.textDisplay(
                              Constants.subRegionalHead1,
                              Styles.textStyleBlack14,
                            ),
                            TextfieldAddButton(
                              title: state.model.srh1?.firstName,
                              height: 60,
                              isDisableColor: false,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  users: state.emailUsers!,
                                  onTap: (GetUserDetails user) {
                                    BlocProvider.of<GeneralInfoCubit>(context)
                                        .updateDropdownValues(
                                      subRegionalHead1: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Sub Regional Head (SRH) 2
                            CommonWidgets.textDisplay(
                              Constants.subRegionalHead2,
                              Styles.textStyleBlack14,
                            ),
                            TextfieldAddButton(
                              title: state.model.srh2?.firstName,
                              height: 60,
                              isDisableColor: false,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  users: state.emailUsers!,
                                  onTap: (GetUserDetails user) {
                                    BlocProvider.of<GeneralInfoCubit>(context)
                                        .updateDropdownValues(
                                      subRegionalHead2: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],
                          if (!state.model.annualPowerShutdown) ...[
                            /// Event Protection Manager 1
                            CommonWidgets.textDisplay(
                              Constants.eventProtectionManager1,
                              Styles.textStyleBlack14,
                            ),
                            TextfieldAddButton(
                              title: state.model.epManager1?.name,
                              height: 60,
                              isDisableColor: false,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  users: state.emailUsers!,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<GeneralInfoCubit>(context)
                                        .updateDropdownValues(
                                      epManager1: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Event Protection Manager 2
                            CommonWidgets.textDisplay(
                              Constants.eventProtectionManager2,
                              Styles.textStyleBlack14,
                            ),
                            TextfieldAddButton(
                              title: state.model.epManager2?.name,
                              height: 60,
                              isDisableColor: false,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  users: state.emailUsers!,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<GeneralInfoCubit>(context)
                                        .updateDropdownValues(
                                      epManager2: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],

                          /// Location Security  Manager 1
                          CommonWidgets.textDisplay(
                            Constants.locationSecurityManager1,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.lsm1?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (BaseUser user) {
                                  BlocProvider.of<GeneralInfoCubit>(context)
                                      .updateDropdownValues(
                                    locationSecurityManager1: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///LSM 1 Contact No
                          CommonWidgets.textDisplay(
                              Constants.lsm1ContactNo, Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.lsm1ContactNo,
                            textFormKey: Keys.lsm1ContactNOKey,
                            hintText: '',
                            isEnable: true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.lsm1ContactNo = value;
                              context
                                  .read<GeneralInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Location Security  Manager 2
                          CommonWidgets.textDisplay(
                            Constants.locationSecurityManager2,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.lsm2?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (BaseUser user) {
                                  BlocProvider.of<GeneralInfoCubit>(context)
                                      .updateDropdownValues(
                                    locationSecurityManager2: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///LSM 2 Contact No
                          CommonWidgets.textDisplay(
                              Constants.lsm2ContactNo, Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            // labelText: Constants.lsm2ContactNo,
                            keyboardType: TextInputType.number,
                            initialValue: state.model.lsm2ContactNo,
                            textFormKey: Keys.lsm2ContactNOKey,
                            hintText: '',
                            isEnable: true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.lsm2ContactNo = value;
                              context
                                  .read<GeneralInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Business POC 1
                          CommonWidgets.textDisplay(
                            Constants.businessPoc1,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.bu1?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (BaseUser user) {
                                  BlocProvider.of<GeneralInfoCubit>(context)
                                      .updateDropdownValues(
                                    bu1: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Business POC 1 Contact No
                          CommonWidgets.textDisplay(
                              Constants.businessPoc1ContactNo,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.bu1ContactNo,
                            textFormKey: Keys.bu1ContactNOKey,
                            hintText: '',
                            isEnable: true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.bu1ContactNo = value;
                              context
                                  .read<GeneralInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Business POC 2

                          CommonWidgets.textDisplay(
                            Constants.businessPoc2,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.bu2?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (BaseUser user) {
                                  BlocProvider.of<GeneralInfoCubit>(context)
                                      .updateDropdownValues(
                                    bu2: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Business POC 2 Contact No
                          CommonWidgets.textDisplay(
                              Constants.businessPoc2ContactNo,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.bu2ContactNo,
                            textFormKey: Keys.bu2ContactNOKey,
                            hintText: '',
                            isEnable: true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.bu2ContactNo = value;
                              context
                                  .read<GeneralInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Business POC 1Department
                          CommonWidgets.textDisplay(
                            Constants.businessPoc1Department,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.bu1Dept?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().departmentDialog(
                                context: context,
                                departments: state.departments,
                                onTap: (Department department) {
                                  BlocProvider.of<GeneralInfoCubit>(context)
                                      .updateDropdownValues(
                                          bu1Dept: department);
                                },
                              );
                            },
                          ),

                          ///Business POC 2 Department
                          CommonWidgets.textDisplay(
                            Constants.businessPoc2Department,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.bu2Dept?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().departmentDialog(
                                context: context,
                                departments: state.departments,
                                onTap: (Department department) {
                                  BlocProvider.of<GeneralInfoCubit>(context)
                                      .updateDropdownValues(
                                          bu2Dept: department);
                                },
                              );
                            },
                          ),

                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          if (state.model.annualPowerShutdown) ...[
                            ///System Vendor 1 Email
                            CommonWidgets.textDisplay(
                                Constants.systemVendor1Email,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.text,
                              initialValue: state.model.systemVendor1,
                              textFormKey: Keys.systemVendor1EmailKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.systemVendor1 = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Vendor 1 Contact No
                            CommonWidgets.textDisplay(
                                Constants.vendor1ContactNO,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.text,
                              initialValue: state.model.systemVendor1ContactNo,
                              textFormKey: Keys.vendor1Contact1Key,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.systemVendor1ContactNo = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            //
                            // ///Primary Service Engineer Name
                            // CommonWidgets.horizentaltextHandling(
                            //     Constants.primaryServiceEngineerName,
                            //     state.model.vendor1Primary ?? ''),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),
                            //
                            // ///Primary Service Engineer Contact
                            // CommonWidgets.horizentaltextHandling(
                            //     Constants.primaryServiceEngineerContact,
                            //     state.model.vendor1PrimaryContact ?? ''),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),
                            //
                            // ///Secondary Service Engineer Name
                            // CommonWidgets.horizentaltextHandling(
                            //     Constants.secondaryServiceEngineerName,
                            //     state.model.vendor1Secondary ?? ''),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),
                            //
                            // ///Secondary Service Engineer Contact
                            // CommonWidgets.horizentaltextHandling(
                            //     Constants.secondaryServiceEngineerContact,
                            //     state.model.vendor1SecondaryContact ?? ''),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///System Vendor 2 Email
                            CommonWidgets.textDisplay(
                                Constants.systemVendor2Email,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.text,
                              initialValue: state.model.systemVendor2,
                              textFormKey: Keys.systemVendor2EmailKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.systemVendor2 = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Vendor 2 Contact No
                            CommonWidgets.textDisplay(
                                Constants.vendor2ContactNO,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.text,
                              initialValue: state.model.systemVendor2ContactNo,
                              textFormKey: Keys.vendor2ContactKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.systemVendor2ContactNo = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // ///Primary Service Engineer Contact
                            // CommonWidgets.horizentaltextHandling(
                            //     Constants.primaryServiceEngineerContact,
                            //     state.model.vendor2PrimaryContact ?? ''),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),
                            //
                            // ///Primary Service Engineer Contact
                            // CommonWidgets.horizentaltextHandling(
                            //     Constants.primaryServiceEngineerContact,
                            //     state.model.vendor2PrimaryContact ?? ''),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),
                            //
                            // ///Secondary Service Engineer Name
                            // CommonWidgets.horizentaltextHandling(
                            //     Constants.secondaryServiceEngineerName,
                            //     state.model.vendor2Secondary ?? ''),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),
                            //
                            // ///Secondary Service Engineer Contact
                            // CommonWidgets.horizentaltextHandling(
                            //     Constants.secondaryServiceEngineerContact,
                            //     state.model.vendor2SecondaryContact ?? ''),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///System Vendor 3 Email
                            CommonWidgets.textDisplay(
                                Constants.systemVendor3Email,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.text,
                              initialValue: state.model.systemVendor3,
                              textFormKey: Keys.systemVendor2EmailKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.systemVendor3 = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Vendor 2 Contact No
                            CommonWidgets.textDisplay(
                                Constants.vendor3ContactNO,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.text,
                              initialValue: state.model.systemVendor2ContactNo,
                              textFormKey: Keys.vendor2ContactKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.systemVendor2ContactNo = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // ///Primary Service Engineer Contact
                            // CommonWidgets.horizentaltextHandling(
                            //     Constants.primaryServiceEngineerContact,
                            //     state.model.vendor3PrimaryContact ?? ''),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),
                            //
                            // ///Primary Service Engineer Contact
                            // CommonWidgets.horizentaltextHandling(
                            //     Constants.primaryServiceEngineerContact,
                            //     state.model.vendor3PrimaryContact ?? ''),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),
                            //
                            // ///Secondary Service Engineer Name
                            // CommonWidgets.horizentaltextHandling(
                            //     Constants.secondaryServiceEngineerName,
                            //     state.model.vendor3Secondary ?? ''),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),
                            //
                            // ///Secondary Service Engineer Contact
                            // CommonWidgets.horizentaltextHandling(
                            //     Constants.secondaryServiceEngineerContact,
                            //     state.model.vendor3SecondaryContact ?? ''),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],

                          ///Requester Department
                          CommonWidgets.textDisplay(
                            Constants.requesterDepartment,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.requesterDepartment?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().departmentDialog(
                                context: context,
                                departments: state.departments,
                                onTap: (Department department) {
                                  BlocProvider.of<GeneralInfoCubit>(context)
                                      .updateDropdownValues(
                                          requesterDepartment: department);
                                },
                              );
                            },
                          ),

                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Event Protection Officer
                          CommonWidgets.textDisplay(
                            Constants.eventProtectionOfficers,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.epOfficers,
                            height: 70,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (BaseUser user) {
                                  BlocProvider.of<GeneralInfoCubit>(context)
                                      .updateDropdownValues(
                                    epOfficers: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          if (state.model.annualPowerShutdown) ...[
                            ///Is Extra Security Deployment Required
                            Row(children: [
                              CommonWidgets.textDisplay(
                                Constants.isExtraSecurityDeploymentRequired,
                                Styles.textStyleBlack14,
                              ),
                              Checkbox(
                                  activeColor: AppColors.navigationSkybluecolor,
                                  focusColor: AppColors.navigationSkybluecolor,
                                  value: state.model.extraSecurityDeployed,
                                  onChanged: (bool? value) {
                                    state.model.extraSecurityDeployed = value!;
                                    BlocProvider.of<GeneralInfoCubit>(context)
                                        .onCheckBoxChange(state.model);
                                  })
                            ]),
                          ],

                          if (state.model.extraSecurityDeployed) ...[
                            ///Vendor Id
                            CommonWidgets.textDisplay(
                                Constants.guardingVendorId,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: state.model.vendorId,
                              textFormKey: Keys.vendorIdKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.vendorId = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Guarding Agency POC
                            CommonWidgets.textDisplay(
                                Constants.guardingAgencyPOC,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: state.model.guardingVendorPoc,
                              textFormKey: Keys.vendorAgencyPOCKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.guardingVendorPoc = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///No. Of Security Officers
                            CommonWidgets.textDisplay(
                                Constants.numOfSecurityOfficers,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  '${state.model.securityOfficerCount ?? ''}',
                              textFormKey: Keys.noOfSecurityOfficersKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (int value) {
                                state.model.securityOfficerCount = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Total Duty Hours
                            CommonWidgets.textDisplay(Constants.totalDutyHours,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  '${state.model.securityOfficerCountHrs ?? ''}',
                              textFormKey: Keys.noOfSecurityOfficersHrsKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (int value) {
                                state.model.securityOfficerCountHrs = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///No. Of Security Supervisors
                            CommonWidgets.textDisplay(
                                Constants.numOfSecuritySupervisor,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  '${state.model.securitySupervisorCount ?? ''}',
                              textFormKey: Keys.noOfSecuritySupervisorsKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (int value) {
                                state.model.securitySupervisorCount = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Total Duty Hours
                            CommonWidgets.textDisplay(Constants.totalDutyHours,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  '${state.model.securitySupervisorCountHrs ?? ''}',
                              textFormKey: Keys.noOfSecuritySupervisorsHrsKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (int value) {
                                state.model.securitySupervisorCountHrs = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///No. Of Security Guards
                            CommonWidgets.textDisplay(
                                Constants.numOfSecurityGuards,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  '${state.model.securityGuardCount ?? ''}',
                              textFormKey: Keys.noOfSecurityGuardsKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (int value) {
                                state.model.securityGuardCount = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Total Duty Hours
                            CommonWidgets.textDisplay(Constants.totalDutyHours,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  '${state.model.securityGuardCountHrs ?? ''}',
                              textFormKey: Keys.noOfSecurityGuardsHrsKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (int value) {
                                state.model.securityGuardCountHrs = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///No. Of Security Facilitators
                            CommonWidgets.textDisplay(
                                Constants.numOfSecurityFacilitators,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  '${state.model.securityFacilitatorCount ?? ''}',
                              textFormKey: Keys.noOfSecurityGuardsKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (int value) {
                                state.model.securityFacilitatorCount = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Total Duty Hours
                            CommonWidgets.textDisplay(Constants.totalDutyHours,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  '${state.model.securityFacilitatorCountHrs ?? ''}',
                              textFormKey: Keys.noOfSecurityFacilitatorHrsKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (int value) {
                                state.model.securityFacilitatorCountHrs = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Proposed Vendor
                            CommonWidgets.textDisplay(
                              Constants.proposedVendors,
                              Styles.textStyleBlack14,
                            ),
                            TextfieldAddButton(
                              title: '${state.model.proposedVendors ?? ''}',
                              height: 60,
                              isDisableColor: false,
                              onTap: () {
                                BaseDepartmentDialog().departmentDialog(
                                  context: context,
                                  departments: state.departments,
                                  onTap: (List<Department> proposedVendors) {
                                    BlocProvider.of<GeneralInfoCubit>(context)
                                        .updateDropdownValues(
                                            proposedVendors: proposedVendors);
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Budget Costs
                            CommonWidgets.textDisplay(
                                Constants.budget, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: '${state.model.budget ?? ''}',
                              textFormKey: Keys.budgetKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (double value) {
                                state.model.budget = value;
                                context
                                    .read<GeneralInfoCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                          ],
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          //     ///Po Number
                          //     CommonWidgets.textDisplay(Constants.poNumber,
                          //         Styles.textStyleBlack14),
                          //     CommonWidgets.verticalSpacerWidget(height * 0.001),
                          //     FlutterInputField(
                          //       keyboardType: TextInputType.number,
                          //       initialValue:
                          //       state.model.poNumber,
                          //       textFormKey: Keys.poNumberKey,
                          //       hintText: '',
                          //       isEnable: true,
                          //       isDisableColor:false,
                          //       onChange: (String value) {
                          //         state.model.poNumber = value;
                          //         context
                          //             .read<GeneralInfoCubit>()
                          //             .onModelValueChange(state.model);
                          //       },
                          //       validateTextField: (String? user) {},
                          //     ),
                          //     CommonWidgets.verticalSpacerWidget(height * 0.01),
                          //
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                        ]),
                      ),

                      /// SubmitButton
                      if (disableForm) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cancelButtonDisplay(),
                            if(state.model.status == 0)...[
                              submitButtonDisplay()

                            ],
                          ],
                        ),
                      ],
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

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<GeneralInfoCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }

  Widget locationWidgetdislay(GeneralInfoState state) {
    return GestureDetector(
      onTap: () {
        if (state.model.id == null ||
            (state.model.location?.name ?? '').isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              // print(state.getLocationsResponse);
              return CustomExpansionListTexts(
                getLocationsresponse: state.locations,
                onTap: (Mumbai? list) async {
                  log('list?.name-----${list?.name}');

                  Location location = Location();
                  location.id = list?.id;
                  location.name = list?.name;
                  state.model.location = location;

                  BlocProvider.of<GeneralInfoCubit>(context)
                      .updateDropdownValues(location: location);
                },
              );
            },
          );
        }
      },
      child: SelectedTileValueWidget(name: state.model.location?.name ?? ''),
    );
  }
}
