import 'dart:developer';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_circular_loader.dart';
import 'package:db_atom/src/common_widgets/base_widget/basicWidgetFunctions.dart';
import 'package:db_atom/src/common_widgets/base_widget/record_locked_widget.dart';
import 'package:db_atom/src/common_widgets/base_widget/selected_tile_value_widget.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constant_agruments.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common_widgets/base_widget/base_department_dialog.dart';
import '../../../../../common_widgets/base_widget/base_entities_dropdown.dart';
import '../../../../../common_widgets/textfiled_addbutton.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../models/base_user.dart';
import '../../../../../models/organisation.dart';
import '../../../../../utils/customalert.dart';
import '../../models/sla_violation_penalty_response_model.dart';
import '../cubits/sla_violation_penalty_details_cubit.dart';
import 'add_poc_pop_up.dart';

class SLAViolationPenaltyDetailsView extends StatefulWidget {
  final SLAViolationPenaltyModel? model;
  final String title;

  const SLAViolationPenaltyDetailsView({
    super.key,
    this.model,
    required this.title,
  });

  @override
  State<SLAViolationPenaltyDetailsView> createState() =>
      _ContactDetailsViewState();
}

class _ContactDetailsViewState extends State<SLAViolationPenaltyDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController returnableTextController = TextEditingController();
  User? userDetails;
  TextEditingController guardingAgencyPOCController = TextEditingController();
  bool isReadOnly = false;

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context)
        .initializeValues();
    initializeDates();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<SLAViolationPenaltyDetailsCubit,
        SLAViolationPenaltyDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'SLA Violation Penalty',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPostivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                slaViolationPenaltyListRoute,
              );
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
        if (state.status == FormStatus.error) {
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
        }
      },
      builder: (context, state) {
        if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == null) {
          isReadOnly = false;
        }

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: state.model.status != 6 &&
                    state.model.status != 1 &&
                    !isReadOnly
                ? true
                : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: true,
                navigateToNextScreen: true,
              );
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {
    // TODO: Maybe we can remove this
  }

  getBodybuilder(SLAViolationPenaltyDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    bool isQuantityDisabled =
        (state.model.status == 6 || state.model.status == 1);
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
              child: AbsorbPointer(
                absorbing: isReadOnly,
                child: Form(
                  key: _formKey,
                  autovalidateMode: isReadOnly
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Column(
                          children: [
                            if (!state.model.lock.isEmptyOrNull) ...[
                              RecordLockedWidget(text: '${state.model.lock}'),
                            ],
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.generalinformation,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Created By
                            CommonWidgets.verticalTextHandling(
                                Constants.createdby,
                                '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Status
                            CommonWidgets.textDisplay(
                              Constants.status,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              isEnable: false,
                              isDisableColor: true,
                              textFormKey: Keys.statusTextController,
                              hintText: '',
                              initialValue:
                                  getStatusString(state.model.status ?? 0),
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                              Constants.dateofcreation,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location
                            CommonWidgets.textDisplay(
                              Constants.location,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            locationWidgetdislay(state),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Sl No.
                            CommonWidgets.horizentaltextHandling(
                              Constants.slno,
                              state.model.slNo ?? '',
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Vendor
                            CommonWidgets.textDisplay(
                                Constants.vendor, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseEntitiesSelection().entityDropDownSelection(
                                context: context,
                                selectedValues: state.model.vendor ?? [],
                                all: state.vendors ?? [],
                                enabled: !isReadOnly,
                                onTap: (List<Organisation> selectedVendors) {
                                  log('--selectedEntities----${selectedVendors.length}');
                                  BlocProvider.of<
                                              SLAViolationPenaltyDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          vendors: selectedVendors);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Entity
                            CommonWidgets.textDisplay(
                                Constants.entity, Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseEntitiesSelection().entityDropDownSelection(
                                context: context,
                                selectedValues: state.model.entity ?? [],
                                all: state.listOfEntities ?? [],
                                enabled: !isReadOnly,
                                onTap: (List<Organisation> selectedEntities) {
                                  log('--selectedEntities----${selectedEntities.length}');
                                  BlocProvider.of<
                                              SLAViolationPenaltyDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          entities: selectedEntities);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Type Of Service
                            CommonWidgets.textDisplay(Constants.typeOfService,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseEntitiesSelection().entityDropDownSelection(
                                context: context,
                                selectedValues: state.model.typeOfService ?? [],
                                all: state.typeOfServices ?? [],
                                enabled: !isReadOnly,
                                onTap:
                                    (List<Organisation> selectedTypeOfVendors) {
                                  log('--selectedEntities----${selectedTypeOfVendors.length}');
                                  BlocProvider.of<
                                              SLAViolationPenaltyDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          typeOfServices:
                                              selectedTypeOfVendors);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// ASL
                            CommonWidgets.textDisplay(
                                Constants.aSL, Styles.textStyleBlack14,
                                isMandatory: true),
                            TextfieldAddButton(
                              title: state.model.approver?.name,
                              height: 60,
                              isDisableColor: isReadOnly,
                              onTap: () {
                                BaseDepartmentDialog().userDialog(
                                  context: context,
                                  enabled: !isReadOnly,
                                  users: state.users!,
                                  onTap: (BaseUser user) {
                                    BlocProvider.of<
                                                SLAViolationPenaltyDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                      user: user,
                                    );
                                  },
                                );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Guarding Agency POC
                              CommonWidgets.textDisplay(
                                  Constants.guardingAgencyPOC,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return AddPOCPopUp(
                                          model:
                                          model,
                                          mainContext: context,
                                          onSubmit: (SLAViolationPenaltyModel
                                          model) {
                                            //loginFormKey.currentState!.validate();
                                            FocusScope.of(context).unfocus();
                                            BlocProvider.of<
                                                SLAViolationPenaltyDetailsCubit>(
                                                context)
                                                .submitForm(isSaveOnly: true);
                                          },
                                        );
                                      });
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
                                      Constants.addGuardingAgencyPOC,
                                      style: TextStyle(
                                        color: AppColors.navigationSkybluecolor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Column(
                              children: getPOC(state, height),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // ///Guarding Agency POC
                            // CommonWidgets.textDisplay(
                            //     Constants.guardingAgencyPOC,
                            //     Styles.textStyleBlack14,
                            //     isMandatory: true),
                            // //if (!disableForm) ...[
                            // GestureDetector(
                            //   onTap: () {
                            //     addGuardingAgencyPOC();
                            //   },
                            //   child: Row(
                            //     children: <Widget>[
                            //       const SizedBox(width: 14),
                            //       SvgPicture.asset(
                            //         AppIcon.pluscircle,
                            //       ),
                            //       const SizedBox(width: 10),
                            //       const Text(
                            //         'Add Guarding Agency POC',
                            //         style: TextStyle(
                            //           color: AppColors.navigationSkybluecolor,
                            //           decoration: TextDecoration.underline,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // BasicWidgetFunctions().getStringText(
                            //     strings: state.pocs ?? []),
                            // // ],
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Violation Penalty
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.violationPenalty,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            GestureDetector(
                              // onTap: () async {
                              //   NavigatorState nav = Navigator.of(context);
                              //   nav.pushNamed(
                              //     slaViolationPenaltyListingRoute,
                              //     arguments: {
                              //       ConstantsArgument.title:
                              //       Constants.generalContact,
                              //       ConstantsArgument.id: state.model.id,
                              //     },
                              //   );
                              // },
                              onTap: () async {
                                NavigatorState nav = Navigator.of(context);
                                bool isSaveSuccess = await BlocProvider.of<
                                            SLAViolationPenaltyDetailsCubit>(
                                        context)
                                    .submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );

                                if (!isSaveSuccess) {
                                  return;
                                }
                                log('--state.model.id---${state.model.id}--');

                                nav.pushNamed(
                                  slaViolationPenaltyRecordsRoute,
                                  arguments: {
                                    ConstantsArgument.title:
                                        Constants.violationPenalty,
                                    ConstantsArgument.id: state.model.id,
                                    ConstantsArgument.violationDescription:
                                        Constants.slaViolation,
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    AppIcon.pluscircle,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Add/View Violation Penalty(S)',
                                    style: TextStyle(
                                      color: AppColors.navigationSkybluecolor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                          ],
                        ),
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// SubmitButton
                      if ((state.model.status == 6 || state.model.status == 1)
                          ? false
                          : true) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cancelButtonDisplay(),
                            submitButtonDisplay()
                          ],
                        ),
                      ],
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ],
                  ),
                ),
              ),
            ),
            if (state.model.status == 6 || state.model.status == 1) ...[
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
      ),
    );
  }

  String getStatusString(int status) {
    switch (status) {
      case 0:
        return 'Draft';
      case 1:
        return 'Active';
      default:
        return '';
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

        BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context).submitForm();
      },
    );
  }

  Widget locationWidgetdislay(SLAViolationPenaltyDetailsState state) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return CustomExpansionListTexts(
              locationList: state.locations,
              onTap: (Organisation? list) async {
                Organisation location = Organisation();
                location.id = list?.id;
                location.name = list?.name;
                state.model.location = location;

                BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context)
                    .updateDropdownValues(location: location);
              },
            );
          },
        );
      },
      child: SelectedTileValueWidget(name: state.model.location?.name ?? ''),
    );
  }

  Widget submitButton(
      {required Function onTap, String? label = Constants.submit}) {
    return AppButton(
      width: 150,
      buttonText: label,
      buttonTextKey: Keys.submitButton,
      onTap: onTap,
    );
  }

  void addGuardingAgencyPOC() {
    final cubit = context.read<SLAViolationPenaltyDetailsCubit>();
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<SLAViolationPenaltyDetailsCubit>.value(
          value: cubit,
          child: BlocBuilder<SLAViolationPenaltyDetailsCubit,
              SLAViolationPenaltyDetailsState>(
            builder: (context, state) {
              return AlertDialog(
                backgroundColor: AppColors.backgroundWhitecolor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Builder(
                  builder: (context) {
                    var height = MediaQuery.of(context).size.height;
                    var width = MediaQuery.of(context).size.width;
                    return SizedBox(
                      height: height * 0.19,
                      width: width,
                      child: Center(
                        child: Column(
                          children: [
                            CommonWidgets.textDisplay('Add Guarding Agency POC',
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 1,
                              textFieldController: guardingAgencyPOCController,
                              textFormKey: Keys.equipmentNoKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {},
                              validateTextField: (String value) {},
                            ),
                            if (state.status == FormStatus.invalidEmail) ...[
                              const Text(
                                'Please enter valid email',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            const Spacer(),
                            submitButton(
                              onTap: () async {
                                state.model.poc ??= '';
                                (state.model.poc ?? '') +
                                    guardingAgencyPOCController.text;
                                BlocProvider.of<
                                            SLAViolationPenaltyDetailsCubit>(
                                        this.context)
                                    .onCheckBoxChange(state.model);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> getPOC(
      SLAViolationPenaltyDetailsState state, height) {
    List<Widget> widgets = [];
    log('-state.poc.length---${state.pocs?.length}---');
    for (String poc in state.pocs ?? []) {
      TextEditingController pocController = TextEditingController();
      pocController.text = poc;
      widgets.add(
        FlutterInputField(
          lineHeight: 1,
          textFieldController: pocController,
          textFormKey: Keys.equipmentNoKey,
          hintText: '',
          isEnable: true,
          isDisableColor: false,
          onChange: (String value) {
             widget.model?.poc = value;
            BlocProvider.of<SLAViolationPenaltyDetailsCubit>(context)
                .onModelValueChange(state.model);
          },
        ),
      );
      widgets.add(CommonWidgets.verticalSpacerWidget(height * 0.01));
    }
    return widgets;
  }
  Widget datecreateWidgetdisplay(String date) {
    return FlutterInputField(
      textFormKey: Keys.dateofcreationTextController,
      initialValue: date,
      hintText: '',
      isEnable: false,
      isDisableColor: true,
      onChange: (String value) {},
      validateTextField: (String? user) {},
    );
  }
// getLawEnforcementId(int id) async {
//   showLoadingDialog(context);
//
//   SLAViolationPenaltyModel contactsModel =
//   await SLAViolationPenaltyServices().getGvpById(id);
//
//   editDataLoading(contactsModel);
// }
// void editDataLoading(SLAViolationPenaltyModel? model) {
//   dismissLoadingDialog(context);
//   if (model != null) {
//     Navigator.pushNamed(
//       context,
//       slaViolationPenaltyDetailsRoute,
//       arguments: {
//         "model": model,
//         "title": Constants.slaViolationPenalty,
//       },
//     );
//   }
// }
}
