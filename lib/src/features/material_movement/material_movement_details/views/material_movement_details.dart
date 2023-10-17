import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/add_button_widget.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_department_dialog.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_drop_down.dart';
import 'package:db_atom/src/common_widgets/base_widget/radio_buttons_yes_no.dart';
import 'package:db_atom/src/common_widgets/base_widget/selected_tile_value_widget.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/custom_pop_list_texts.dart';
import 'package:db_atom/src/common_widgets/image_download.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/user.dart';
import 'package:db_atom/src/features/createfound/views/add_employee_deparment.dart';
import 'package:db_atom/src/features/createfound/views/upload_attachment.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common_widgets/base_widget/date_picker_dialog.dart';
import '../../../../enums/form_status.dart';
import '../../../../models/base_user.dart';
import '../../../../models/organisation.dart';
import '../../../../utils/customalert.dart';

class MaterialMovementDetails extends StatefulWidget {
  final MaterialMovementModel? materialMovement;
  final bool isInward;
  final String title;

  const MaterialMovementDetails({
    super.key,
    this.materialMovement,
    required this.isInward,
    required this.title,
  });

  @override
  State<MaterialMovementDetails> createState() =>
      _MaterialMovementDetailsState();
}

class _MaterialMovementDetailsState extends State<MaterialMovementDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController returnableTextController = TextEditingController();
  User? userDetails;
  List<CreateImage>? getFiles;
  List<FoundImage>? getAttachments;
  TextEditingController takenOutOnDateController = TextEditingController();
  TextEditingController expectedDateOfReturnController =
      TextEditingController();
  bool isDisabled = true;
  List<String> returnableDropDownValues = const [
    "Returnable",
    "Non Returnable"
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MaterialMovementDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<MaterialMovementDetailsCubit,
        MaterialMovementDetailsState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Material Movement',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPostivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                  context, materialMovementInwardsOutwardsRoute,
                  arguments: {"isInward": widget.isInward});
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
            title: widget.title,
            showPopUp: false,
            showSaveButton: state.materialMovement.status != 6 &&
                    state.materialMovement.status != 3
                ? true
                : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<MaterialMovementDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  getBodybuilder(MaterialMovementDetailsState state, height) {
    log('-state.materialMovement.status---${state.materialMovement.status}--');

    returnableTextController.text =
        state.materialMovement.returnable! ? 'Returnable' : 'Non Returnable';

    if (state.status == FormStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      log('---getAttachments----builder----${getAttachments?.length}-----');
      getFiles = state.loadAttachments ?? [];
      log('---getFiles----builder----${getFiles?.length}-----');
    }

    if (state.materialMovement.status == 1) {
      isDisabled = false;
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
              child: AbsorbPointer(
                absorbing: state.materialMovement.status == 6,
                child: Form(
                    key: _formKey,
                    autovalidateMode: state.materialMovement.status == 6
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

                              /// Material Movement Type
                              CommonWidgets.textDisplay(
                                  'Material Movement Type',
                                  Styles.textStyleBlack14),

                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue:
                                    widget.isInward ? 'Inward' : 'Outward',
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Non Returnable
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                  isDisabled:
                                      state.materialMovement.status != 6,
                                  textController: returnableTextController,
                                  onTap: () {
                                    if (isDisabled & !widget.isInward) {
                                      BaseDropDown().assetTypeDialog(
                                          context: context,
                                          dropDownValues:
                                              returnableDropDownValues,
                                          onTap: (String value) {
                                            bool isReturnable =
                                                value == 'Returnable'
                                                    ? true
                                                    : false;
                                            state.materialMovement.returnable =
                                                isReturnable;
                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .updateDropdownValues(
                                                    isReturnable: isReturnable);
                                          });
                                    }
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Status
                              CommonWidgets.textDisplay(
                                  Constants.status, Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: getStatusString(
                                    state.materialMovement.status ?? 0),
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Created By
                              CommonWidgets.verticalTextHandling(
                                  Constants.createdby,
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
                              datecreateWidgetdisplay(
                                  state.materialMovement.inputDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Sl No.
                              CommonWidgets.horizentaltextHandling(
                                  Constants.slno,
                                  state.materialMovement.slNo ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Challan/ Invoice Nos/ Gate Pass
                              CommonWidgets.textDisplay(
                                  Constants.challan, Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                keyboardType: TextInputType.name,
                                textFormKey: Keys.challanKey,
                                initialValue: state.materialMovement.challanNo,
                                hintText: '',
                                isEnable: state.materialMovement.status != 6,
                                isDisableColor:
                                    state.materialMovement.status == 6,
                                onChange: (String value) {
                                  state.materialMovement.challanNo = value;
                                  context
                                      .read<MaterialMovementDetailsCubit>()
                                      .onModelValueChange(
                                          state.materialMovement);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              if (widget.isInward) ...[
                                /// PO Number
                                CommonWidgets.textDisplay(Constants.poNumber,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  keyboardType: TextInputType.number,
                                  initialValue: state.materialMovement.poNumber,
                                  textFormKey: Keys.poNumberKey,
                                  hintText: '',
                                  isEnable: widget.materialMovement != null
                                      ? true
                                      : (widget.materialMovement != null &&
                                              (widget.materialMovement
                                                      ?.poNumber ==
                                                  null))
                                          ? false
                                          : true,
                                  isDisableColor: (widget.materialMovement !=
                                              null &&
                                          (widget.materialMovement?.poNumber !=
                                              null))
                                      ? true
                                      : false,
                                  onChange: (String value) {
                                    state.materialMovement.poNumber = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(
                                            state.materialMovement);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              /// Material Brief Description
                              CommonWidgets.textDisplay(
                                  Constants.materialBriefDescription,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                initialValue:
                                    state.materialMovement.materialDescription,
                                textFormKey: Keys.materialBreifDescKey,
                                hintText: Constants.informationhere,
                                showBorder: true,
                                isEnable: state.materialMovement.status != 6,
                                isDisableColor:
                                    state.materialMovement.status == 6,
                                onChange: (String value) {
                                  state.materialMovement.materialDescription =
                                      value;
                                  context
                                      .read<MaterialMovementDetailsCubit>()
                                      .onModelValueChange(
                                          state.materialMovement);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Quantity
                              CommonWidgets.textDisplay(
                                  Constants.quantity, Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 220,
                                    child: FlutterInputField(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                      initialValue:
                                          '${state.materialMovement.quantity ?? ''}',
                                      textFormKey: Keys.quantityKey,
                                      hintText: '',
                                      isEnable:
                                          state.materialMovement.status != 6,
                                      isDisableColor:
                                          state.materialMovement.status == 6,
                                      onChange: (String? value) {
                                        if (value != null) {
                                          state.materialMovement.quantity =
                                              int.parse(value);
                                        }
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(
                                                state.materialMovement);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                  ),
                                  // CommonWidgets.horizontalSpacerWidget(
                                  //     width * 0.01),
                                  TileWidget(
                                    name: state.materialMovement.unit?.name ??
                                        'Unit',
                                    width: 70,
                                  ),
                                  // CommonWidgets.horizontalSpacerWidget(
                                  //     width * 0.01),
                                  InkWell(
                                      onTap: () {
                                        quantityUnitDialog(
                                            context: context,
                                            quantityUnits: state.quantityUnits);
                                      },
                                      child: const AddButtonWidget(
                                        height: 50,
                                      )),
                                ],
                              ),

                              // quantityUnitPopUp(state),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Outward Details Fields
                              if (!widget.isInward) ...[
                                /// Equipment No/Identification
                                CommonWidgets.textDisplay(Constants.equipmentNo,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.materialMovement.modelInfo,
                                  textFormKey: Keys.equipmentNoKey,
                                  hintText: '',
                                  isEnable: state.materialMovement.status != 6,
                                  isDisableColor:
                                      state.materialMovement.status == 6,
                                  onChange: (String value) {
                                    state.materialMovement.modelInfo = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(
                                            state.materialMovement);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Address
                                CommonWidgets.textDisplay(
                                    Constants.address, Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue: state.materialMovement.address,
                                  textFormKey: Keys.addressKey,
                                  hintText: '',
                                  isEnable: widget.materialMovement == null
                                      ? true
                                      : (widget.materialMovement != null &&
                                              (widget.materialMovement
                                                          ?.address ??
                                                      '')
                                                  .isEmpty)
                                          ? true
                                          : false,
                                  isDisableColor:
                                      (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                              ?.address ??
                                                          '')
                                                      .isEmpty) ||
                                              widget.materialMovement == null
                                          ? false
                                          : true,
                                  onChange: (String value) {
                                    state.materialMovement.address = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(
                                            state.materialMovement);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Requestor Email
                                Column(
                                  children: [
                                    CommonWidgets.textDisplay(
                                      Constants.requestorEmail,
                                      Styles.textStyleBlack14,
                                    ),
                                    widget.materialMovement != 6
                                        ? TextfieldAddButton(
                                            title: state.materialMovement
                                                .requestorEmail,
                                            height: 70,
                                            isDisableColor:
                                                state.materialMovement.status !=
                                                        6
                                                    ? false
                                                    : true,
                                            onTap: () {
                                              if (state.materialMovement
                                                      .status !=
                                                  6) {
                                                BaseDepartmentDialog()
                                                    .userDialog(
                                                  context: context,
                                                  users: state.emailUsers!,
                                                  onTap: (BaseUser user) {
                                                    BlocProvider.of<
                                                                MaterialMovementDetailsCubit>(
                                                            context)
                                                        .updateDropdownValues(
                                                            requesterEmailUser:
                                                                user);
                                                  },
                                                );
                                              }
                                            })
                                        : FlutterInputField(
                                            initialValue: state.materialMovement
                                                .requestorEmail,
                                            textFormKey: Keys.requesterEmailKey,
                                            hintText: '',
                                            isEnable:
                                                state.materialMovement.status !=
                                                    6,
                                            isDisableColor:
                                                state.materialMovement.status ==
                                                    6,
                                            onChange: (String username) {},
                                            validateTextField:
                                                (String? user) {},
                                          ),
                                  ],
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Requestor Employee Id
                                CommonWidgets.textDisplay(
                                    Constants.requestorEmployeeId,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                FlutterInputField(
                                  keyboardType: TextInputType.number,
                                  initialValue: state
                                      .materialMovement.requestorEmployeeId,
                                  textFormKey: Keys.requestorEmployeeKey,
                                  hintText: '',
                                  isEnable: state.materialMovement.status != 6,
                                  isDisableColor:
                                      state.materialMovement.status == 6,
                                  onChange: (String value) {
                                    state.materialMovement.requestorEmployeeId =
                                        value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(
                                            state.materialMovement);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Requester Department
                                CommonWidgets.textDisplay(
                                  Constants.requestorDepartment,
                                  Styles.textStyleBlack14,
                                ),
                                widget.materialMovement == 6
                                    ? FlutterInputField(
                                        initialValue: state.materialMovement
                                            .requestorDepartment?.name,
                                        textFormKey:
                                            Keys.requesterDepartmentKey,
                                        hintText: '',
                                        isEnable:
                                            state.materialMovement.status == 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          state
                                              .materialMovement
                                              .requestorDepartment
                                              ?.name = value;
                                          context
                                              .read<
                                                  MaterialMovementDetailsCubit>()
                                              .onModelValueChange(
                                                  state.materialMovement);
                                        },
                                        validateTextField: (String? user) {},
                                      )
                                    : TextfieldAddButton(
                                        title: state.materialMovement
                                            .requestorDepartment?.name,
                                        height: 70,
                                        isDisableColor:
                                            state.materialMovement.status != 6
                                                ? false
                                                : true,
                                        onTap: () {
                                          if (state.materialMovement.status !=
                                              6) {
                                            BaseDepartmentDialog()
                                                .departmentDialog(
                                              context: context,
                                              departments: state.departments,
                                              onTap: (Organisation department) {
                                                state
                                                    .materialMovement
                                                    .requestorDepartment
                                                    ?.name = department.name;

                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateDropdownValues(
                                                        requesterDepartment:
                                                            department);
                                              },
                                            );
                                            // leodepartmentsDialog(state);
                                          }
                                        },
                                      ),

                                // dbwanttodepartmentaddButtonwidgetLoading(state),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Sent To
                                CommonWidgets.textDisplay(
                                    Constants.sentTo, Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                FlutterInputField(
                                  keyboardType: TextInputType.text,
                                  initialValue: state.materialMovement.sentTo,
                                  textFormKey: Keys.sentToKey,
                                  hintText: '',
                                  isEnable: state.materialMovement.status != 6,
                                  isDisableColor:
                                      state.materialMovement.status == 6,
                                  onChange: (String value) {
                                    state.materialMovement.sentTo = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(
                                            state.materialMovement);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Purpose
                                CommonWidgets.textDisplay(
                                    Constants.purpose, Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                FlutterInputField(
                                  keyboardType: TextInputType.text,
                                  initialValue: state.materialMovement.purpose,
                                  textFormKey: Keys.purposeKey,
                                  hintText: '',
                                  isEnable: widget.materialMovement == null
                                      ? true
                                      : (widget.materialMovement != null &&
                                              (widget.materialMovement
                                                      ?.purpose ==
                                                  null))
                                          ? false
                                          : true,
                                  isDisableColor: (widget.materialMovement !=
                                              null &&
                                          (widget.materialMovement?.purpose !=
                                              null))
                                      ? true
                                      : false,
                                  onChange: (String value) {
                                    state.materialMovement.purpose = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(
                                            state.materialMovement);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Prepared By
                                CommonWidgets.textDisplay(Constants.preparedBy,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                FlutterInputField(
                                  // keyboardType: TextInputType.number,
                                  initialValue:
                                      state.materialMovement.preparedBy,
                                  textFormKey: Keys.preparedByKey,
                                  hintText: '',
                                  isEnable: widget.materialMovement == null
                                      ? true
                                      : (widget.materialMovement != null &&
                                              (widget.materialMovement
                                                      ?.preparedBy ==
                                                  null))
                                          ? false
                                          : true,
                                  isDisableColor:
                                      (widget.materialMovement != null &&
                                              (widget.materialMovement
                                                      ?.preparedBy !=
                                                  null))
                                          ? true
                                          : false,
                                  onChange: (String value) {
                                    state.materialMovement.preparedBy = value;
                                    BlocProvider.of<
                                                MaterialMovementDetailsCubit>(
                                            context)
                                        .onModelValueChange(
                                            state.materialMovement);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Prepared By Department
                                CommonWidgets.textDisplay(
                                  Constants.preparedByDepartment,
                                  Styles.textStyleBlack14,
                                ),
                                widget.materialMovement == 6
                                    ? FlutterInputField(
                                        initialValue: state.materialMovement
                                            .preparedByDepartment?.name,
                                        textFormKey:
                                            Keys.preparedByDepartmentKey,
                                        hintText: '',
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          state
                                              .materialMovement
                                              .preparedByDepartment
                                              ?.name = value;
                                          context
                                              .read<
                                                  MaterialMovementDetailsCubit>()
                                              .onModelValueChange(
                                                  state.materialMovement);
                                        },
                                        validateTextField: (String? user) {},
                                      )
                                    : TextfieldAddButton(
                                        title: state.materialMovement
                                            .preparedByDepartment?.name,
                                        height: 70,
                                        isDisableColor:
                                            state.materialMovement.status != 6
                                                ? false
                                                : true,
                                        onTap: () {
                                          if (state.materialMovement.status !=
                                              6) {
                                            BaseDepartmentDialog()
                                                .departmentDialog(
                                              context: context,
                                              departments: state.departments,
                                              onTap: (Organisation department) {
                                                state
                                                    .materialMovement
                                                    .preparedByDepartment
                                                    ?.name = department.name;

                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateDropdownValues(
                                                        preparedByDepartment:
                                                            department);
                                              },
                                            );
                                            // leodepartmentsDialog(state);
                                          }
                                        },
                                      ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Approver1 Email
                                Column(
                                  children: [
                                    CommonWidgets.textDisplay(
                                      Constants.approver1Email,
                                      Styles.textStyleBlack14,
                                    ),
                                    widget.materialMovement != 6
                                        ? TextfieldAddButton(
                                            title: state.materialMovement
                                                .approver1Email,
                                            height: 70,
                                            isDisableColor:
                                                state.materialMovement.status !=
                                                        6
                                                    ? false
                                                    : true,
                                            onTap: () {
                                              if (state.materialMovement
                                                      .status !=
                                                  6) {
                                                BaseDepartmentDialog()
                                                    .userDialog(
                                                  context: context,
                                                  users: state.emailUsers!,
                                                  onTap: (BaseUser user) {
                                                    BlocProvider.of<
                                                                MaterialMovementDetailsCubit>(
                                                            context)
                                                        .updateDropdownValues(
                                                            approver1EmailUser:
                                                                user);
                                                  },
                                                );
                                              }
                                            })
                                        : FlutterInputField(
                                            initialValue: state.materialMovement
                                                .approver1Email,
                                            textFormKey: Keys.approver1EmailKey,
                                            hintText: '',
                                            isEnable:
                                                state.materialMovement.status !=
                                                    6,
                                            isDisableColor:
                                                state.materialMovement.status ==
                                                    6,
                                            onChange: (String username) {},
                                            validateTextField:
                                                (String? user) {},
                                          ),
                                  ],
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Approver1 By Department
                                CommonWidgets.textDisplay(
                                  Constants.approver1Department,
                                  Styles.textStyleBlack14,
                                ),
                                widget.materialMovement == 6
                                    ? FlutterInputField(
                                        initialValue: state.materialMovement
                                            .approver1Department?.name,
                                        textFormKey:
                                            Keys.aprrover1DepartmentKey,
                                        hintText: '',
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          state
                                              .materialMovement
                                              .approver1Department
                                              ?.name = value;
                                          context
                                              .read<
                                                  MaterialMovementDetailsCubit>()
                                              .onModelValueChange(
                                                  state.materialMovement);
                                        },
                                        validateTextField: (String? user) {},
                                      )
                                    : TextfieldAddButton(
                                        title: state.materialMovement
                                            .approver1Department?.name,
                                        height: 70,
                                        isDisableColor:
                                            state.materialMovement.status != 6
                                                ? false
                                                : true,
                                        onTap: () {
                                          if (state.materialMovement.status !=
                                              6) {
                                            BaseDepartmentDialog()
                                                .departmentDialog(
                                              context: context,
                                              departments: state.departments,
                                              onTap: (Organisation department) {
                                                state
                                                    .materialMovement
                                                    .approver1Department
                                                    ?.name = department.name;

                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateDropdownValues(
                                                        approver1Department:
                                                            department);
                                              },
                                            );
                                            // leodepartmentsDialog(state);
                                          }
                                        },
                                      ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Approver2 Email
                                Column(
                                  children: [
                                    CommonWidgets.textDisplay(
                                      Constants.approver2Email,
                                      Styles.textStyleBlack14,
                                    ),
                                    widget.materialMovement != 6
                                        ? TextfieldAddButton(
                                            title: state.materialMovement
                                                .approver2Email,
                                            height: 70,
                                            isDisableColor:
                                                state.materialMovement.status !=
                                                        6
                                                    ? false
                                                    : true,
                                            onTap: () {
                                              if (state.materialMovement
                                                      .status !=
                                                  6) {
                                                BaseDepartmentDialog()
                                                    .userDialog(
                                                  context: context,
                                                  users: state.emailUsers!,
                                                  onTap: (BaseUser user) {
                                                    BlocProvider.of<
                                                                MaterialMovementDetailsCubit>(
                                                            context)
                                                        .updateDropdownValues(
                                                            approver2EmailUser:
                                                                user);
                                                  },
                                                );
                                              }
                                            })
                                        : FlutterInputField(
                                            initialValue: state.materialMovement
                                                .approver2Email,
                                            textFormKey: Keys.approver2EmailKey,
                                            hintText: '',
                                            isEnable:
                                                state.materialMovement.status !=
                                                    6,
                                            isDisableColor:
                                                state.materialMovement.status ==
                                                    6,
                                            onChange: (String username) {},
                                            validateTextField:
                                                (String? user) {},
                                          ),
                                  ],
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Approver2 By Department
                                /// Approver1 By Department
                                CommonWidgets.textDisplay(
                                  Constants.approver2Department,
                                  Styles.textStyleBlack14,
                                ),
                                widget.materialMovement == 6
                                    ? FlutterInputField(
                                        initialValue: state.materialMovement
                                            .approver2Department?.name,
                                        textFormKey: Keys.approver2EmailKey,
                                        hintText: '',
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          state
                                              .materialMovement
                                              .approver2Department
                                              ?.name = value;
                                          context
                                              .read<
                                                  MaterialMovementDetailsCubit>()
                                              .onModelValueChange(
                                                  state.materialMovement);
                                        },
                                        validateTextField: (String? user) {},
                                      )
                                    : TextfieldAddButton(
                                        title: state.materialMovement
                                            .approver2Department?.name,
                                        height: 70,
                                        isDisableColor:
                                            state.materialMovement.status != 6
                                                ? false
                                                : true,
                                        onTap: () {
                                          if (state.materialMovement.status !=
                                              6) {
                                            BaseDepartmentDialog()
                                                .departmentDialog(
                                              context: context,
                                              departments: state.departments,
                                              onTap: (Organisation department) {
                                                state
                                                    .materialMovement
                                                    .approver2Department
                                                    ?.name = department.name;

                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateDropdownValues(
                                                        approver2Department:
                                                            department);
                                              },
                                            );
                                            // leodepartmentsDialog(state);
                                          }
                                        },
                                      ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                if (state.materialMovement.returnable ==
                                    true) ...[
                                  /// Expected Date Of Return
                                  CommonWidgets.textDisplay(
                                      Constants.expectedDateOfReturn,
                                      Styles.textStyleBlack14),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  BaseDate().datePickerWidgetLoading(
                                      textController:
                                          expectedDateOfReturnController,
                                      onChange: (String value) {
                                        log('--expectedDateOfReturnController-value-${expectedDateOfReturnController.text}------');
                                        widget.materialMovement
                                            ?.expectedDateOfReturn = value;
                                        BlocProvider.of<
                                                    MaterialMovementDetailsCubit>(
                                                context)
                                            .onModelValueChange(
                                                state.materialMovement);
                                      },
                                      context: context),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                ],

                                /// If Status is Approved(status=2), Inward Pending(status=5), Submitted(status=1)
                                if (state.materialMovement.status == 2 ||
                                    state.materialMovement.status == 5 ||
                                    state.materialMovement.status == 1 ||
                                    state.materialMovement.status == 6) ...[
                                  /// If Status is Approved(status=2) and Inward Pending(status=5)
                                  if (state.materialMovement.status == 2 ||
                                      state.materialMovement.status == 5 ||
                                      state.materialMovement.status == 6) ...[
                                    ///Expected Date of Return

                                    /// Approved By
                                    CommonWidgets.verticalTextHandling(
                                        Constants.approvedBy,
                                        state.materialMovement.approvedBy ??
                                            ''),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Approved Date
                                    CommonWidgets.verticalTextHandling(
                                        Constants.approvedDate,
                                        state.materialMovement.approvedDate ??
                                            ''),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Taken Out By
                                    CommonWidgets.textDisplay(
                                        Constants.takenOutBy,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),

                                    FlutterInputField(
                                      initialValue:
                                          state.materialMovement.takenOutEmail,
                                      textFormKey: Keys.takenOutByKey,
                                      hintText: '',
                                      isEnable:
                                          state.materialMovement.status == 2,
                                      isDisableColor:
                                          state.materialMovement.status != 2,
                                      onChange: (String value) {
                                        state.materialMovement.takenOutEmail =
                                            value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(
                                                state.materialMovement);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Taken Out By Contact No.
                                    CommonWidgets.textDisplay(
                                        Constants.takenOutByContactNo,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),

                                    FlutterInputField(
                                      initialValue: state
                                          .materialMovement.takenOutContactNo,
                                      textFormKey: Keys.takenOutContactKey,
                                      hintText: '',
                                      isEnable:
                                          state.materialMovement.status == 2,
                                      isDisableColor:
                                          state.materialMovement.status != 2,
                                      onChange: (String value) {
                                        state.materialMovement
                                            .takenOutContactNo = value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(
                                                state.materialMovement);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Taken Out Address
                                    CommonWidgets.textDisplay(
                                        Constants.takenOutAddress,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),

                                    FlutterInputField(
                                      initialValue: state
                                          .materialMovement.takenOutAddress,
                                      textFormKey: Keys.takenOutAddressKey,
                                      hintText: '',
                                      isEnable:
                                          state.materialMovement.status == 2,
                                      isDisableColor:
                                          state.materialMovement.status != 2,
                                      onChange: (String value) {
                                        state.materialMovement.takenOutAddress =
                                            value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(
                                                state.materialMovement);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Taken Out On
                                    CommonWidgets.textDisplay(
                                        Constants.takenOutOn,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),

                                    BaseDate().datePickerWidgetLoading(
                                        textController:
                                            takenOutOnDateController,
                                        onChange: (String value) {
                                          state.materialMovement.takenOutOn =
                                              value;
                                          BlocProvider.of<
                                                      MaterialMovementDetailsCubit>(
                                                  context)
                                              .onModelValueChange(
                                                  state.materialMovement);
                                        },
                                        context: context),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                  ]
                                ],

                                /// If Status is Rejected(status=3)
                                if (state.materialMovement.status == 3) ...[
                                  /// Rejected By
                                  CommonWidgets.verticalTextHandling(
                                      Constants.rejectedBy,
                                      state.materialMovement.rejectedBy ?? ''),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Rejected Date
                                  CommonWidgets.verticalTextHandling(
                                      Constants.rejectedDate,
                                      state.materialMovement.rejectedDate ??
                                          ''),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Rejected Comment
                                  CommonWidgets.verticalTextHandling(
                                      Constants.rejectedComment,
                                      state.materialMovement.rejectionComment ??
                                          ''),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                ],
                              ],

                              if (widget.isInward) ...[
                                /// Senders Name
                                CommonWidgets.textDisplay(Constants.sendersName,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  keyboardType: TextInputType.name,
                                  initialValue:
                                      state.materialMovement.materialComingFrom,
                                  textFormKey: Keys.sendersKey,
                                  hintText: '',

                                  isEnable: state.materialMovement.status != 6,
                                  isDisableColor:
                                      state.materialMovement.status == 6,
                                  onChange: (String value) {
                                    state.materialMovement.materialComingFrom =
                                        value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(
                                            state.materialMovement);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Material Coming From Address
                                CommonWidgets.textDisplay(
                                    Constants
                                        .materialComingFromBriefDescription,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue: state
                                      .materialMovement.materialFromAddress,
                                  showBorder: true,
                                  textFormKey: Keys.materialComingFromKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.materialMovement.status != 6,
                                  isDisableColor:
                                      state.materialMovement.status == 6,
                                  onChange: (String value) {
                                    state.materialMovement.materialFromAddress =
                                        value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(
                                            state.materialMovement);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Is original receiver receiving
                                CommonWidgets.textDisplay(
                                    Constants.isOriginalReceiverReceiving,
                                    Styles.textStyleBlack14),
                                RadioButtonsYesNo(
                                  status: state.materialMovement.status ?? 0,
                                  selectedValue:
                                      state.materialMovement.originalReceiver
                                          ? 1
                                          : 0,
                                  onChangedYes:
                                      widget.materialMovement?.status == 6
                                          ? null
                                          : (val) {
                                              BlocProvider.of<
                                                          MaterialMovementDetailsCubit>(
                                                      context)
                                                  .showFields(
                                                isOriginalReceiverReceiving:
                                                    true,
                                              );
                                            },
                                  onChangedNo:
                                      widget.materialMovement?.status == 6
                                          ? null
                                          : (val) {
                                              BlocProvider.of<
                                                          MaterialMovementDetailsCubit>(
                                                      context)
                                                  .showFields(
                                                isOriginalReceiverReceiving:
                                                    false,
                                              );
                                            },
                                ),

                                /// Received For
                                Column(
                                  children: [
                                    CommonWidgets.textDisplay(
                                      !state.materialMovement.originalReceiver
                                          ? Constants.receivedFor
                                          : Constants.receivedBy,
                                      Styles.textStyleBlack14,
                                    ),
                                    widget.materialMovement != 6
                                        ? TextfieldAddButton(
                                            title: state
                                                .materialMovement.receiverEmail,
                                            height: 70,
                                            isDisableColor:
                                                state.materialMovement.status !=
                                                        6
                                                    ? false
                                                    : true,
                                            onTap: () {
                                              if (state.materialMovement
                                                      .status !=
                                                  6) {
                                                BaseDepartmentDialog()
                                                    .userDialog(
                                                  context: context,
                                                  users: state.emailUsers!,
                                                  onTap: (BaseUser user) {
                                                    BlocProvider.of<
                                                                MaterialMovementDetailsCubit>(
                                                            context)
                                                        .updateDropdownValues(
                                                            receiverEmailUser:
                                                                user);
                                                  },
                                                );
                                              }
                                            })
                                        : FlutterInputField(
                                            initialValue: state.materialMovement
                                                .otherReceiverName,
                                            textFormKey:
                                                Keys.depositorTextController,
                                            hintText: '',
                                            isEnable:
                                                state.materialMovement.status !=
                                                    6,
                                            isDisableColor:
                                                state.materialMovement.status ==
                                                    6,
                                            onChange: (String username) {},
                                            validateTextField:
                                                (String? user) {},
                                          ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                  ],
                                ),
                                if (!state.materialMovement.originalReceiver)
                                  ...[],

                                /// Received for Employee Id
                                CommonWidgets.textDisplay(
                                    !state.materialMovement.originalReceiver
                                        ? Constants.receivedForEmployeeId
                                        : Constants.receiverEmployeeId,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                                FlutterInputField(
                                  initialValue:
                                      state.materialMovement.receiverEmployeeId,
                                  textFormKey: Keys.claimantEmpIdTextController,
                                  isEnable: state.materialMovement.status != 6,
                                  isDisableColor:
                                      state.materialMovement.status == 6,
                                  hintText: '',
                                  onChange: (String value) {
                                    state.materialMovement.receiverEmployeeId =
                                        value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(
                                            state.materialMovement);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Receiver Department
                                CommonWidgets.textDisplay(
                                  Constants.receiverDepartment,
                                  Styles.textStyleBlack14,
                                ),
                                widget.materialMovement == 6
                                    ? FlutterInputField(
                                        initialValue: state.materialMovement
                                            .receiverDepartmenttName,
                                        textFormKey: Keys.receiverDepartmentKey,
                                        hintText: '',
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          state.materialMovement
                                              .receiverDepartmenttName = value;
                                          context
                                              .read<
                                                  MaterialMovementDetailsCubit>()
                                              .onModelValueChange(
                                                  state.materialMovement);
                                        },
                                        validateTextField: (String? user) {},
                                      )
                                    : TextfieldAddButton(
                                        title: state.materialMovement
                                            .receiverDepartmenttName,
                                        height: 70,
                                        isDisableColor:
                                            state.materialMovement.status != 6
                                                ? false
                                                : true,
                                        onTap: () {
                                          // if (widget.materialMovement != null) {
                                          BaseDepartmentDialog()
                                              .departmentDialog(
                                            context: context,
                                            departments: state.departments,
                                            onTap: (Organisation department) {
                                              state.materialMovement
                                                      .receiverDepartmenttName =
                                                  department.name;

                                              BlocProvider.of<
                                                          MaterialMovementDetailsCubit>(
                                                      context)
                                                  .updateDropdownValues(
                                                      receiverDepartment:
                                                          department);
                                            },
                                          );
                                          // leodepartmentsDialog(state);
                                          // }
                                        },
                                      ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                if (!state
                                    .materialMovement.originalReceiver) ...[
                                  /// Received by
                                  CommonWidgets.textDisplay(
                                      Constants.receivedBy,
                                      Styles.textStyleBlack14),

                                  FlutterInputField(
                                    initialValue: state
                                        .materialMovement.otherReceiverName,
                                    textFormKey: Keys.receivedByKey,
                                    isEnable:
                                        state.materialMovement.status != 6,
                                    isDisableColor:
                                        state.materialMovement.status == 6,
                                    hintText: '',
                                    onChange: (String value) {
                                      state.materialMovement.otherReceiverName =
                                          value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(
                                              state.materialMovement);
                                    },
                                    validateTextField: (String? user) {},
                                  ),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Received by Employee Id
                                  CommonWidgets.textDisplay(
                                      Constants.receiverEmployeeId,
                                      Styles.textStyleBlack14),

                                  FlutterInputField(
                                    initialValue: state.materialMovement
                                        .otherReceiverEmployeeId,
                                    textFormKey:
                                        Keys.claimantEmpIdTextController,
                                    isEnable:
                                        state.materialMovement.status != 6,
                                    isDisableColor:
                                        state.materialMovement.status == 6,
                                    hintText: '',
                                    onChange: (String value) {
                                      state.materialMovement
                                          .otherReceiverEmployeeId = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(
                                              state.materialMovement);
                                    },
                                    validateTextField: (String? user) {},
                                  ),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                ],

                                /// Receiver Signature
                                CommonWidgets.textDisplay(
                                    Constants.receiverSignature,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue:
                                      state.materialMovement.receiverEmail,
                                  textFormKey: Keys.receiverSignKey,
                                  hintText: Constants.informationhere,
                                  isEnable: state.materialMovement.status != 6,
                                  isDisableColor:
                                      state.materialMovement.status == 6,
                                  onChange: (String value) {
                                    state.materialMovement.entrySecurityName =
                                        value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(
                                            state.materialMovement);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Security Signature
                                CommonWidgets.textDisplay(
                                    Constants.securitySignature,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  lineHeight: 6,
                                  initialValue: state
                                      .materialMovement.materialDescription,
                                  textFormKey: Keys.securitySignKey,

                                  hintText: Constants.informationhere,
                                  isEnable: state.materialMovement.status != 6,
                                  isDisableColor:
                                      state.materialMovement.status == 6,
                                  onChange: (String value) {
                                    state.materialMovement.materialDescription =
                                        value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(
                                            state.materialMovement);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Is Material Physically Checked
                                CommonWidgets.textDisplay(
                                    Constants.isPhysicallyChecked,
                                    Styles.textStyleBlack14),
                                RadioButtonsYesNo(
                                    status: state.materialMovement.status ?? 0,
                                    selectedValue: state.materialMovement
                                            .materialPhysicallyChecked
                                        ? 1
                                        : 0,
                                    onChangedYes:
                                        widget.materialMovement?.status == 6
                                            ? null
                                            : (val) {
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .showFields(
                                                  isMaterialPhysicallyChecked:
                                                      true,
                                                  // materialMovement: materialMovement,
                                                );
                                              },
                                    onChangedNo:
                                        widget.materialMovement?.status == 6
                                            ? null
                                            : (val) {
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .showFields(
                                                  isMaterialPhysicallyChecked:
                                                      false,
                                                  // materialMovement: materialMovement,
                                                );
                                              }),

                                /// Comment
                                if (!state.materialMovement
                                    .materialPhysicallyChecked) ...[
                                  CommonWidgets.textDisplay(Constants.comment,
                                      Styles.textStyleBlack14),
                                  FlutterInputField(
                                    initialValue: state.materialMovement
                                        .materialNotCheckedComment,
                                    textFormKey:
                                        Keys.claimantEmpIdTextController,
                                    isEnable:
                                        state.materialMovement.status != 6,
                                    isDisableColor:
                                        state.materialMovement.status == 6,
                                    hintText: '',
                                    onChange: (String value) {
                                      state.materialMovement
                                          .materialNotCheckedComment = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(
                                              state.materialMovement);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                ],
                              ],

                              /// upload
                              widget.materialMovement == null
                                  ? CommonWidgets.textDisplay(
                                      Constants.upload, Styles.textStyleBlack14)
                                  : Container(),
                              widget.materialMovement == null
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),
                              widget.materialMovement == null
                                  ? uploadWidget(state)
                                  : Container(),

                              // Attachments
                              getSpaceattchment(height),
                              getAttachement(state, height),
                            ]),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// SubmitButton
                          if (state.materialMovement.status != 6 &&
                              state.materialMovement.status != 3) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                cancelButtonDisplay(),
                                submitButtonDisplay()
                              ],
                            ),
                          ],
                          CommonWidgets.verticalSpacerWidget(height * 0.04),
                        ])),
              ))
        ])));
  }

  String getStatusString(int status) {
    switch (status) {
      case 0:
        return 'Draft';
      case 1:
        return 'Submitted';
      case 2:
        return 'Approved';
      case 3:
        return 'Rejected';
      case 4:
        return 'Outward Waiting';
      case 5:
        return 'Inward Waiting';
      case 6:
        return 'Closed';
      case 7:
        return 'Cancelled';
      default:
        return 'Unknown Status';
    }
  }

  Widget quantityUnitPopUp(MaterialMovementDetailsState state) {
    return TextfieldAddButton(
      title: 'Quantity',
      height: 70,
      isDisableColor: state.materialMovement.quantity == null ? false : true,
      onTap: () {
        if (state.materialMovement.status != 6) {
          quantityUnitDialog(
              context: context, quantityUnits: state.quantityUnits);
        }
      },
    );
  }

  quantityUnitDialog({
    required BuildContext context,
    required List<Organisation> quantityUnits,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateQuantityUnitList: quantityUnits,
            leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return const AddEmployeeDepartment(
                      title: Constants.addQuantity,
                      // createoundstate:  state,
                    );
                  });
            },
            onTap: (Organisation unit) {
              BlocProvider.of<MaterialMovementDetailsCubit>(context)
                  .updateDropdownValues(quantityUnit: unit);
            },
          );
        });
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
        BlocProvider.of<MaterialMovementDetailsCubit>(context).submitForm();
      },
    );
  }

  Widget uploadWidget(MaterialMovementDetailsState state) {
    return widget.materialMovement == null
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
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(140, 50)),
                  onPressed: () {
                    // Navigator.pushNamed(context,
                    //     createFoundAttachmentRoute);
                    //UploadAttachment();
                    showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return UploadAttachment(
                            userdetails: state.loggedInUserDetails ?? User(),
                            getFiles: getFiles ?? [],
                            inwardState: state,
                            onImageSelected: (CreateImage data) {
                              log('-------function---onImageSelected---------');
                              List<CreateImage>? files = [];
                              files.add(data);
                              for (CreateImage image in getFiles!.toList()) {
                                files.add(image);
                              }
                              BlocProvider.of<MaterialMovementDetailsCubit>(
                                      context)
                                  .addAttchment(files);
                            },
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

  Widget getAttachement(MaterialMovementDetailsState state, double height) {
    return (state.loadAttachments == null ||
            state.loadAttachments!.isEmpty ||
            widget.materialMovement == null)
        ? state.loadAttachments?.length == 0 || getFiles == null
            ? Container()
            : attachmentListviews(getFiles, getAttachments)
        : attachmentListviews(getFiles, getAttachments);
  }

  Widget locationWidgetdislay(MaterialMovementDetailsState state) {
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
              onTap: (Organisation? list) async {
                log('list?.name-----${list?.name}');

                Organisation location = Organisation();
                location.id = list?.id;
                location.name = list?.name;
                state.materialMovement.location = location;

                BlocProvider.of<MaterialMovementDetailsCubit>(context)
                    .updateDropdownValues(location: location);
              },
            );
          },
        );
        // }
      },
      child: SelectedTileValueWidget(
          name: state.materialMovement.location?.name ?? ''),
    );
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

  Widget attachmentListviews(
    List<CreateImage>? attachmentListviews,
    List<FoundImage>? attachmentListviews1,
  ) {
    log('----attachmentListviews-----${attachmentListviews?.length}-----------');
    log('----attachmentListviews1-----${attachmentListviews1?.length}-----------');

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
            if (widget.materialMovement != null) {
              imagedata1 = attachmentListviews1?[index];
            } else {
              imagedata = attachmentListviews?[index];
            }

            return Column(
              children: <Widget>[
                ListTile(
                  trailing: widget.materialMovement != null
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
                  title: widget.materialMovement != null
                      ? Text(imagedata1?.title ?? '')
                      : Text(imagedata?.title ?? ''),
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
