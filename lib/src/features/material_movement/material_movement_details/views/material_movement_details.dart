import 'dart:convert';
import 'dart:developer';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/add_button_widget.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_department_dialog.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_drop_down.dart';
import 'package:db_atom/src/common_widgets/base_widget/radio_buttons_yes_no.dart';
import 'package:db_atom/src/common_widgets/base_widget/record_locked_widget.dart';
import 'package:db_atom/src/common_widgets/base_widget/selected_tile_value_widget.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/custom_pop_list_texts.dart';
import 'package:db_atom/src/common_widgets/image_download.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/signature/signature_controller.dart';
import 'package:db_atom/src/common_widgets/signature/signature_func.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common_widgets/base_widget/date_picker_dialog.dart';
import '../../../../enums/form_status.dart';
import '../../../../models/base_user.dart';
import '../../../../models/organisation.dart';
import '../../../../utils/customalert.dart';
import '../../../../utils/util.dart';

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
  List<CreateImage> getFiles = [];
  List<FoundImage> getAttachments = [];
  TextEditingController takenOutOnDateController = TextEditingController();
  TextEditingController expectedDateOfReturnController =
      TextEditingController();
  TextEditingController actualDateOfReturnController =
  TextEditingController();
  bool isDisabled = false;
  List<String> returnableDropDownValues = const [
    "Returnable",
    "Non Returnable"
  ];

  SignatureController receiverSignatureController = SignatureController();
  SignatureController securitySignatureController = SignatureController();

  @override
  void initState() {
    super.initState();
    receiverSignatureController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white);

    securitySignatureController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white);
    BlocProvider.of<MaterialMovementDetailsCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    receiverSignatureController.dispose();
    securitySignatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
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
        log('--isDisabled--1--$isDisabled-----');
        if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
          isDisabled = true;
        }
        log('--isDisabled--2--$isDisabled-----');

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: state.model.status != 6 &&
                    state.model.status != 1 &&
                    !isDisabled
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

  void initializeDates() {
    expectedDateOfReturnController.text = Utils.timestamptoDateConversion(
        int.tryParse(widget.materialMovement?.expectedDateOfReturn ?? '0'),
        Constants.dateFormat);
    // actualDateOfReturnController.text = Utils.timestamptoDateConversion(
    //     int.tryParse(widget.materialMovement?.actualDateOfReturn ?? '0'),
    //     Constants.dateFormat);
    takenOutOnDateController.text = Utils.timestamptoDateConversion(
        int.tryParse(widget.materialMovement?.takenOutOn ?? '0'),
        Constants.dateFormat);
  }

  getBodybuilder(MaterialMovementDetailsState state, height) {
    log('-state.materialMovement.status---${state.model.status}--');

    returnableTextController.text =
        state.model.returnable! ? 'Returnable' : 'Non Returnable';

    if (state.status == FormStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      log('---getAttachments----builder----${getAttachments.length}-----');
      getFiles = state.loadAttachments ?? [];
      log('---getFiles----builder----${getFiles.length}-----');
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
                child: AbsorbPointer(
                  absorbing: state.model.status == 6,
                  child: Form(
                      key: _formKey,
                      autovalidateMode: isDisabled
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
                                if (!state.model.lock.isEmptyOrNull) ...[
                                  RecordLockedWidget(
                                      text: '${state.model.lock}'),
                                ],
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    Constants.generalinformation,
                                    style: Styles.styleHeaderGreyText16,
                                  ),
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

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
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Non Returnable
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                BaseDropDown().getDropDown(
                                    isDisabled: state.model.status != 6,
                                    textController: returnableTextController,
                                    onTap: () {
                                      if (!isDisabled & !widget.isInward) {
                                        BaseDropDown().assetTypeDialog(
                                            context: context,
                                            dropDownValues:
                                                returnableDropDownValues,
                                            onTap: (String value) {
                                              bool isReturnable =
                                                  value == 'Returnable'
                                                      ? true
                                                      : false;
                                              state.model.returnable =
                                                  isReturnable;
                                              BlocProvider.of<
                                                          MaterialMovementDetailsCubit>(
                                                      context)
                                                  .updateDropdownValues(
                                                      isReturnable:
                                                          isReturnable);
                                            });
                                      }
                                    }),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

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
                                  initialValue:
                                      getStatusString(state.model.status ?? 0),
                                  onChange: (String value) {},
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Created By
                                CommonWidgets.verticalTextHandling(
                                    Constants.createdby,
                                    '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Location
                                CommonWidgets.textDisplay(Constants.location,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                locationWidgetdislay(state),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Date of creation
                                CommonWidgets.textDisplay(
                                    Constants.dateofcreation,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                datecreateWidgetdisplay(
                                    state.model.inputDate ?? ''),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Sl No.
                                CommonWidgets.horizentaltextHandling(
                                    Constants.slno, state.model.slNo ?? ''),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Challan/ Invoice Nos/ Gate Pass
                                CommonWidgets.textDisplay(
                                    Constants.challan, Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  keyboardType: TextInputType.name,
                                  textFormKey: Keys.challanKey,
                                  initialValue: state.model.challanNo,
                                  hintText: '',
                                  isEnable: state.model.status != 6,
                                  isDisableColor: state.model.status == 6,
                                  onChange: (String value) {
                                    state.model.challanNo = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                if (widget.isInward) ...[
                                  /// PO Number
                                  CommonWidgets.textDisplay(Constants.poNumber,
                                      Styles.textStyleBlack14),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    keyboardType: TextInputType.text,
                                    initialValue: state.model.poNumber,
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
                                    isDisableColor:
                                        (widget.materialMovement != null &&
                                                (widget.materialMovement
                                                        ?.poNumber !=
                                                    null))
                                            ? true
                                            : false,
                                    onChange: (String value) {
                                      state.model.poNumber = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
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
                                  initialValue: state.model.materialDescription,
                                  textFormKey: Keys.materialBreifDescKey,
                                  hintText: Constants.informationhere,
                                  showBorder: true,
                                  isEnable: state.model.status != 6,
                                  isDisableColor: state.model.status == 6,
                                  onChange: (String value) {
                                    state.model.materialDescription = value;
                                    context
                                        .read<MaterialMovementDetailsCubit>()
                                        .onModelValueChange(state.model);
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Quantity
                                CommonWidgets.textDisplay(Constants.quantity,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 220,
                                      child: FlutterInputField(
                                        keyboardType: const TextInputType
                                            .numberWithOptions(
                                          decimal: true,
                                        ),
                                        initialValue:
                                            '${state.model.quantity ?? ''}',
                                        textFormKey: Keys.quantityKey,
                                        hintText: '',
                                        isEnable: state.model.status != 6,
                                        isDisableColor: state.model.status == 6,
                                        onChange: (String? value) {
                                          if (value != null) {
                                            state.model.quantity =
                                                int.parse(value);
                                          }
                                          context
                                              .read<
                                                  MaterialMovementDetailsCubit>()
                                              .onModelValueChange(state.model);
                                        },
                                        validateTextField: (String? user) {},
                                      ),
                                    ),
                                    // CommonWidgets.horizontalSpacerWidget(
                                    //     width * 0.01),
                                    TileWidget(
                                      name: state.model.unit?.name ?? 'Unit',
                                      width: 70,
                                    ),
                                    // CommonWidgets.horizontalSpacerWidget(
                                    //     width * 0.01),

                                    InkWell(
                                        onTap: () {
                                          quantityUnitDialog(
                                              context: context,
                                              quantityUnits:
                                                  state.quantityUnits);
                                        },
                                        child: const AddButtonWidget(
                                          height: 50,
                                        )),
                                  ],
                                ),

                                // quantityUnitPopUp(state),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Outward Details Fields
                                if (!widget.isInward) ...[
                                  /// Equipment No/Identification
                                  CommonWidgets.textDisplay(
                                      Constants.equipmentNo,
                                      Styles.textStyleBlack14),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    lineHeight: 6,
                                    initialValue: state.model.modelInfo,
                                    showBorder: true,
                                    textFormKey: Keys.equipmentNoKey,
                                    hintText: '',
                                    isEnable: state.model.status != 6,
                                    isDisableColor: state.model.status == 6,
                                    onChange: (String value) {
                                      state.model.modelInfo = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Address
                                  CommonWidgets.textDisplay(Constants.address,
                                      Styles.textStyleBlack14),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    lineHeight: 6,
                                    initialValue: state.model.address,
                                    showBorder: true,
                                    textFormKey: Keys.addressKey,
                                    hintText: '',
                                    isEnable: state.model.status != 6,
                                    isDisableColor: state.model.status == 6,
                                    onChange: (String value) {
                                      state.model.address = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
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
                                      widget.materialMovement?.status != 6
                                          ? TextfieldAddButton(
                                              title: state.model.requestorEmail,
                                              height: 70,
                                              isDisableColor:
                                                  state.model.status != 6
                                                      ? false
                                                      : true,
                                              onTap: () {
                                                if (state.model.status != 6) {
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
                                              initialValue:
                                                  state.model.requestorEmail,
                                              textFormKey:
                                                  Keys.requesterEmailKey,
                                              hintText: '',
                                              isEnable: state.model.status != 6,
                                              isDisableColor:
                                                  state.model.status == 6,
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
                                    initialValue:
                                        state.model.requestorEmployeeId,
                                    textFormKey: Keys.requestorEmployeeKey,
                                    hintText: '',
                                    isEnable: state.model.status != 6,
                                    isDisableColor: state.model.status == 6,
                                    onChange: (String value) {
                                      state.model.requestorEmployeeId = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
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
                                  widget.materialMovement?.status == 6
                                      ? FlutterInputField(
                                          initialValue: state
                                              .model.requestorDepartment?.name,
                                          textFormKey:
                                              Keys.requesterDepartmentKey,
                                          hintText: '',
                                          isEnable: state.model.status == 6,
                                          isDisableColor:
                                              state.model.status == 6,
                                          onChange: (String value) {
                                            state.model.requestorDepartment
                                                ?.name = value;
                                            context
                                                .read<
                                                    MaterialMovementDetailsCubit>()
                                                .onModelValueChange(
                                                    state.model);
                                          },
                                          validateTextField: (String? user) {},
                                        )
                                      : TextfieldAddButton(
                                          title: state
                                              .model.requestorDepartment?.name,
                                          height: 70,
                                          isDisableColor:
                                              state.model.status != 6
                                                  ? false
                                                  : true,
                                          onTap: () {
                                            if (state.model.status != 6) {
                                              BaseDepartmentDialog()
                                                  .departmentDialog(
                                                context: context,
                                                departments: state.departments,
                                                onTap:
                                                    (Organisation department) {
                                                  state
                                                      .model
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
                                  CommonWidgets.textDisplay(Constants.sentTo,
                                      Styles.textStyleBlack14),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  FlutterInputField(
                                    keyboardType: TextInputType.text,
                                    initialValue: state.model.sentTo,
                                    textFormKey: Keys.sentToKey,
                                    hintText: '',
                                    isEnable: state.model.status != 6,
                                    isDisableColor: state.model.status == 6,
                                    onChange: (String value) {
                                      state.model.sentTo = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Purpose
                                  CommonWidgets.textDisplay(Constants.purpose,
                                      Styles.textStyleBlack14),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  FlutterInputField(
                                    keyboardType: TextInputType.text,
                                    initialValue: state.model.purpose,
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
                                      state.model.purpose = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  /// Prepared By
                                  CommonWidgets.textDisplay(
                                      Constants.preparedBy,
                                      Styles.textStyleBlack14),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),

                                  FlutterInputField(
                                    // keyboardType: TextInputType.number,
                                    initialValue: state.model.preparedBy,
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
                                      state.model.preparedBy = value;
                                      BlocProvider.of<
                                                  MaterialMovementDetailsCubit>(
                                              context)
                                          .onModelValueChange(state.model);
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
                                  widget.materialMovement?.status == 6
                                      ? FlutterInputField(
                                          initialValue: state
                                              .model.preparedByDepartment?.name,
                                          textFormKey:
                                              Keys.preparedByDepartmentKey,
                                          hintText: '',
                                          isEnable: state.model.status != 6,
                                          isDisableColor:
                                              state.model.status == 6,
                                          onChange: (String value) {
                                            state.model.preparedByDepartment
                                                ?.name = value;
                                            context
                                                .read<
                                                    MaterialMovementDetailsCubit>()
                                                .onModelValueChange(
                                                    state.model);
                                          },
                                          validateTextField: (String? user) {},
                                        )
                                      : TextfieldAddButton(
                                          title: state
                                              .model.preparedByDepartment?.name,
                                          height: 70,
                                          isDisableColor:
                                              state.model.status != 6
                                                  ? false
                                                  : true,
                                          onTap: () {
                                            if (state.model.status != 6) {
                                              BaseDepartmentDialog()
                                                  .departmentDialog(
                                                context: context,
                                                departments: state.departments,
                                                onTap:
                                                    (Organisation department) {
                                                  state
                                                      .model
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
                                      widget.materialMovement?.status != 6
                                          ? TextfieldAddButton(
                                              title: state.model.approver1Email,
                                              height: 70,
                                              isDisableColor:
                                                  state.model.status != 6
                                                      ? false
                                                      : true,
                                              onTap: () {
                                                if (state.model.status != 6) {
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
                                              initialValue:
                                                  state.model.approver1Email,
                                              textFormKey:
                                                  Keys.approver1EmailKey,
                                              hintText: '',
                                              isEnable: state.model.status != 6,
                                              isDisableColor:
                                                  state.model.status == 6,
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
                                  widget.materialMovement?.status == 6
                                      ? FlutterInputField(
                                          initialValue: state
                                              .model.approver1Department?.name,
                                          textFormKey:
                                              Keys.aprrover1DepartmentKey,
                                          hintText: '',
                                          isEnable: state.model.status != 6,
                                          isDisableColor:
                                              state.model.status == 6,
                                          onChange: (String value) {
                                            state.model.approver1Department
                                                ?.name = value;
                                            context
                                                .read<
                                                    MaterialMovementDetailsCubit>()
                                                .onModelValueChange(
                                                    state.model);
                                          },
                                          validateTextField: (String? user) {},
                                        )
                                      : TextfieldAddButton(
                                          title: state
                                              .model.approver1Department?.name,
                                          height: 70,
                                          isDisableColor:
                                              state.model.status != 6
                                                  ? false
                                                  : true,
                                          onTap: () {
                                            if (state.model.status != 6) {
                                              BaseDepartmentDialog()
                                                  .departmentDialog(
                                                context: context,
                                                departments: state.departments,
                                                onTap:
                                                    (Organisation department) {
                                                  state
                                                      .model
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
                                      widget.materialMovement?.status != 6
                                          ? TextfieldAddButton(
                                              title: state.model.approver2Email,
                                              height: 70,
                                              isDisableColor:
                                                  state.model.status != 6
                                                      ? false
                                                      : true,
                                              onTap: () {
                                                if (state.model.status != 6) {
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
                                              initialValue:
                                                  state.model.approver2Email,
                                              textFormKey:
                                                  Keys.approver2EmailKey,
                                              hintText: '',
                                              isEnable: state.model.status != 6,
                                              isDisableColor:
                                                  state.model.status == 6,
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
                                  widget.materialMovement?.status == 6
                                      ? FlutterInputField(
                                          initialValue: state
                                              .model.approver2Department?.name,
                                          textFormKey: Keys.approver2EmailKey,
                                          hintText: '',
                                          isEnable: state.model.status != 6,
                                          isDisableColor:
                                              state.model.status == 6,
                                          onChange: (String value) {
                                            state.model.approver2Department
                                                ?.name = value;
                                            context
                                                .read<
                                                    MaterialMovementDetailsCubit>()
                                                .onModelValueChange(
                                                    state.model);
                                          },
                                          validateTextField: (String? user) {},
                                        )
                                      : TextfieldAddButton(
                                          title: state
                                              .model.approver2Department?.name,
                                          height: 70,
                                          isDisableColor:
                                              state.model.status != 6
                                                  ? false
                                                  : true,
                                          onTap: () {
                                            if (state.model.status != 6) {
                                              BaseDepartmentDialog()
                                                  .departmentDialog(
                                                context: context,
                                                departments: state.departments,
                                                onTap:
                                                    (Organisation department) {
                                                  state
                                                      .model
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

                                  if (state.model.returnable == true) ...[
                                    /// Expected Date Of Return
                                    CommonWidgets.textDisplay(
                                        Constants.expectedDateOfReturn,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    BaseDate().datePickerWidgetLoading(

                                        textController:
                                            expectedDateOfReturnController,onlyDate: true,
                                        onChange: (String value) {
                                          state.model.expectedDateOfReturn =
                                          Utils().formatTime(value);
                                          BlocProvider.of<
                                                      MaterialMovementDetailsCubit>(
                                                  context)
                                              .onModelValueChange(state.model);
                                        },
                                        context: context,),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                  ],

                                  /// If Status is Approved(status=2), Inward Pending(status=5), Submitted(status=1)
                                  if (state.model.status == 2 ||
                                      state.model.status == 5 ||
                                      state.model.status == 1 ||
                                      state.model.status == 6) ...[
                                    /// If Status is Approved(status=2) and Inward Pending(status=5)
                                    if (state.model.status == 2 ||
                                        state.model.status == 5 ||
                                        state.model.status == 6) ...[
                                      ///Expected Date of Return

                                      /// Approved By
                                      CommonWidgets.verticalTextHandling(
                                          Constants.approvedBy,
                                          state.model.approvedBy ?? ''),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),

                                      /// Approved Date
                                      CommonWidgets.verticalTextHandling(
                                          Constants.approvedDate,
                                          state.model.approvedDate ?? ''),

                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),

                                      /// Taken Out By
                                      CommonWidgets.textDisplay(
                                          Constants.takenOutBy,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),

                                      FlutterInputField(
                                        initialValue: state.model.takenOutEmail,
                                        textFormKey: Keys.takenOutByKey,
                                        hintText: '',
                                        isEnable: state.model.status == 2,
                                        isDisableColor: state.model.status != 2,
                                        onChange: (String value) {
                                          state.model.takenOutEmail = value;
                                          context
                                              .read<
                                                  MaterialMovementDetailsCubit>()
                                              .onModelValueChange(state.model);
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
                                        initialValue:
                                            state.model.takenOutContactNo,
                                        textFormKey: Keys.takenOutContactKey,
                                        hintText: '',
                                        isEnable: state.model.status == 2,
                                        isDisableColor: state.model.status != 2,
                                        onChange: (String value) {
                                          state.model.takenOutContactNo = value;
                                          context
                                              .read<
                                                  MaterialMovementDetailsCubit>()
                                              .onModelValueChange(state.model);
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
                                        initialValue:
                                            state.model.takenOutAddress,
                                        textFormKey: Keys.takenOutAddressKey,
                                        hintText: '',
                                        showBorder: true,
                                        isEnable: state.model.status == 2,
                                        isDisableColor: state.model.status != 2,
                                        onChange: (String value) {
                                          state.model.takenOutAddress = value;
                                          context
                                              .read<
                                                  MaterialMovementDetailsCubit>()
                                              .onModelValueChange(state.model);
                                        },
                                        validateTextField: (String? user) {},
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),

                                      //if (state.materialMovement.status == 2 && state.isInward == false) ...[
                                    /// Taken Out On
                                      CommonWidgets.textDisplay(
                                          Constants.takenOutOn,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),

                                      BaseDate().datePickerWidgetLoading(
                                          textController:
                                              takenOutOnDateController,onlyDate: true,
                                          onChange: (String value) {
                                            state.model.takenOutOn = Utils().formatTime(value);
                                            BlocProvider.of<
                                                        MaterialMovementDetailsCubit>(
                                                    context)
                                                .onModelValueChange(
                                                    state.model);
                                          },
                                          context: context,),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                    ]
                                  ],

                                  /// If Status is Rejected(status=3)
                                  if (state.model.status == 3) ...[
                                    /// Rejected By
                                    CommonWidgets.verticalTextHandling(
                                        Constants.rejectedBy,
                                        state.model.rejectedBy ?? ''),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Rejected Date
                                    CommonWidgets.verticalTextHandling(
                                        Constants.rejectedDate,
                                        state.model.rejectedDate ?? ''),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Rejected Comment
                                    CommonWidgets.verticalTextHandling(
                                        Constants.rejectedComment,
                                        state.model.rejectionComment ?? ''),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                  ],
                                ],

                                if (widget.isInward) ...[
                                  /// Senders Name
                                  CommonWidgets.textDisplay(
                                      Constants.sendersName,
                                      Styles.textStyleBlack14),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    keyboardType: TextInputType.name,
                                    initialValue:
                                        state.model.materialComingFrom,
                                    textFormKey: Keys.sendersKey,
                                    hintText: '',
                                    isEnable: state.model.status != 6,
                                    isDisableColor: state.model.status == 6,
                                    onChange: (String value) {
                                      state.model.materialComingFrom = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
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
                                    initialValue:
                                        state.model.materialFromAddress,
                                    showBorder: true,
                                    textFormKey: Keys.materialComingFromKey,
                                    hintText: Constants.informationhere,
                                    isEnable: state.model.status != 6,
                                    isDisableColor: state.model.status == 6,
                                    onChange: (String value) {
                                      state.model.materialFromAddress = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
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
                                    status: state.model.status ?? 0,
                                    selectedValue:
                                        state.model.originalReceiver ? 1 : 0,
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
                                        !state.model.originalReceiver
                                            ? Constants.receivedFor
                                            : Constants.receivedBy,
                                        Styles.textStyleBlack14,
                                      ),
                                      widget.materialMovement?.status != 6
                                          ? TextfieldAddButton(
                                              title: state.model.receiverEmail,
                                              height: 70,
                                              isDisableColor:
                                                  state.model.status != 6
                                                      ? false
                                                      : true,
                                              onTap: () {
                                                if (state.model.status != 6) {
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
                                              initialValue:
                                                  state.model.otherReceiverName,
                                              textFormKey:
                                                  Keys.depositorTextController,
                                              hintText: '',
                                              isEnable: state.model.status != 6,
                                              isDisableColor:
                                                  state.model.status == 6,
                                              onChange: (String username) {},
                                              validateTextField:
                                                  (String? user) {},
                                            ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                    ],
                                  ),
                                  if (!state.model.originalReceiver) ...[],

                                  /// Received for Employee Id
                                  CommonWidgets.textDisplay(
                                      !state.model.originalReceiver
                                          ? Constants.receivedForEmployeeId
                                          : Constants.receiverEmployeeId,
                                      Styles.textStyleBlack14),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                  FlutterInputField(
                                    initialValue:
                                        state.model.receiverEmployeeId,
                                    textFormKey:
                                        Keys.claimantEmpIdTextController,
                                    isEnable: state.model.status != 6,
                                    isDisableColor: state.model.status == 6,
                                    hintText: '',
                                    onChange: (String value) {
                                      state.model.receiverEmployeeId = value;
                                      context
                                          .read<MaterialMovementDetailsCubit>()
                                          .onModelValueChange(state.model);
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
                                  widget.materialMovement?.status == 6
                                      ? FlutterInputField(
                                          initialValue: state
                                              .model.receiverDepartmenttName,
                                          textFormKey:
                                              Keys.receiverDepartmentKey,
                                          hintText: '',
                                          isEnable: state.model.status != 6,
                                          isDisableColor:
                                              state.model.status == 6,
                                          onChange: (String value) {
                                            state.model
                                                    .receiverDepartmenttName =
                                                value;
                                            context
                                                .read<
                                                    MaterialMovementDetailsCubit>()
                                                .onModelValueChange(
                                                    state.model);
                                          },
                                          validateTextField: (String? user) {},
                                        )
                                      : TextfieldAddButton(
                                          title: state
                                              .model.receiverDepartmenttName,
                                          height: 70,
                                          isDisableColor:
                                              state.model.status != 6
                                                  ? false
                                                  : true,
                                          onTap: () {
                                            // if (widget.materialMovement != null) {
                                            BaseDepartmentDialog()
                                                .departmentDialog(
                                              context: context,
                                              departments: state.departments,
                                              onTap: (Organisation department) {
                                                state.model
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

                                  if (!state.model.originalReceiver) ...[
                                    /// Received by
                                    CommonWidgets.textDisplay(
                                        Constants.receivedBy,
                                        Styles.textStyleBlack14),

                                    FlutterInputField(
                                      initialValue:
                                          state.model.otherReceiverName,
                                      textFormKey: Keys.receivedByKey,
                                      isEnable: state.model.status != 6,
                                      isDisableColor: state.model.status == 6,
                                      hintText: '',
                                      onChange: (String value) {
                                        state.model.otherReceiverName = value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(state.model);
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
                                      initialValue:
                                          state.model.otherReceiverEmployeeId,
                                      textFormKey:
                                          Keys.claimantEmpIdTextController,
                                      isEnable: state.model.status != 6,
                                      isDisableColor: state.model.status == 6,
                                      hintText: '',
                                      onChange: (String value) {
                                        state.model.otherReceiverEmployeeId =
                                            value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(state.model);
                                      },
                                      validateTextField: (String? user) {},
                                    ),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                  ],

                                  /// Receiver Signature test
                                  buildSignature(
                                    controller: receiverSignatureController,
                                    label: Constants.receiverSignature,
                                    spaceHeight: height,
                                    state: state,
                                  ),

                                  /// Security Signature
                                  buildSignature(
                                    controller: securitySignatureController,
                                    label: Constants.securitySignature,
                                    spaceHeight: height,
                                    state: state,
                                  ),
                                  // CommonWidgets.textDisplay(
                                  //     Constants.securitySignature,
                                  //     Styles.textStyleBlack14),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //     height * 0.001),
                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     // Navigate to the new page when the button is clicked
                                  //     Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             const SignatureHomePage(),
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: const Text('Give Signature'),
                                  // ),
                                  // CommonWidgets.verticalSpacerWidget(
                                  //     height * 0.01),
],
                                if (state.model.status == 2 ||
                                  state.model.status == 5 ||
                                  state.model.status == 6 ||
                                  widget.isInward ||
                                  !widget.isInward) ...[  /// Is Material Physically Checked
                                  CommonWidgets.textDisplay(
                                      Constants.isPhysicallyChecked,
                                      Styles.textStyleBlack14),
                                  RadioButtonsYesNo(
                                      status: state.model.status ?? 0,
                                      selectedValue:
                                          state.model.materialPhysicallyChecked
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
                                  if (!state
                                      .model.materialPhysicallyChecked) ...[
                                    CommonWidgets.textDisplay(Constants.comment,
                                        Styles.textStyleBlack14),
                                    FlutterInputField(
                                      initialValue:
                                          state.model.materialNotCheckedComment,
                                      textFormKey:
                                          Keys.claimantEmpIdTextController,
                                      isEnable: state.model.status != 6,
                                      isDisableColor: state.model.status == 6,
                                      hintText: '',
                                      onChange: (String value) {
                                        state.model.materialNotCheckedComment =
                                            value;
                                        context
                                            .read<
                                                MaterialMovementDetailsCubit>()
                                            .onModelValueChange(state.model);
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
                                        Constants.upload,
                                        Styles.textStyleBlack14)
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
                            if (state.model.status != 6 &&
                                state.model.status != 1 &&
                                !isDisabled) ...[
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
                          ])),
                ))
          ],
        ),
      ),
    );
  }

  Column buildSignature({
    required SignatureController controller,
    required String label,
    required double spaceHeight,
    required MaterialMovementDetailsState state,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonWidgets.textDisplay(label, Styles.textStyleBlack14),
            IconButton(
              onPressed: () {
                controller.clear();
              },
              iconSize: 20,
              color: Colors.grey,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        CommonWidgets.verticalSpacerWidget(spaceHeight * 0.001),
        ElevatedButton(
          onPressed: () async {
            String imageBytes = await exportSignature(context, controller);
            ImageContent imageContent = ImageContent();
            imageContent.imageContent = imageBytes;
            (state.model.receiverSign ??= []).add(imageContent);
            BlocProvider.of<MaterialMovementDetailsCubit>(context)
                .onModelValueChange(state.model);
          },
          child: const Icon(Icons.add),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            border: Border.all(
              color: AppColors.gerylightBackground,
              width: 1, // Border width
            ),
          ),
          height: 100,
          width: double.infinity,
          child: Signature(
            controller: controller,
            backgroundColor: Colors.white,
          ),
        ),
        CommonWidgets.verticalSpacerWidget(spaceHeight * 0.01),
      ],
    );
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
      isDisableColor: state.model.quantity == null ? false : true,
      onTap: () {
        if (state.model.status != 6) {
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
                            getFiles: getFiles,
                            inwardState: state,
                            onImageSelected: (CreateImage data) {
                              log('-------function---onImageSelected---------');
                              List<CreateImage>? files = [];
                              files.add(data);
                              for (CreateImage image in getFiles.toList()) {
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
    return getFiles.isNotEmpty || getAttachments.isNotEmpty
        ? CommonWidgets.verticalSpacerWidget(height * 0.01)
        : Container();
  }

  Widget getAttachement(MaterialMovementDetailsState state, double height) {
    return (state.loadAttachments == null ||
            state.loadAttachments!.isEmpty ||
            widget.materialMovement == null)
        ? state.loadAttachments!.isEmpty
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
                state.model.location = location;

                BlocProvider.of<MaterialMovementDetailsCubit>(context)
                    .updateDropdownValues(location: location);
              },
            );
          },
        );
        // }
      },
      child: SelectedTileValueWidget(name: state.model.location?.name ?? ''),
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

  Future<String> exportSignature(
    BuildContext context,
    SignatureController controller,
  ) async {
    log('--exportSignature----');
    final exportController = SignatureController(
      penStrokeWidth: 2,
      exportBackgroundColor: Colors.white,
      penColor: Colors.black,
      points: controller.points,
    );

    Uint8List? signature = await exportController.toPngBytes();
    log('--signature--$signature--');
    String bs4str = base64Encode(signature!);
    log('--bs4str--$bs4str--');

    // TODO: signature check if these bytes can be saved to API

    //clean up the memory
    exportController.dispose();

    return bs4str;
    // saveSignature(context, signature!);
  }

  Future? saveSignature(BuildContext context, Uint8List signature) async {
    final status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    //making signature name unique
    final time = DateTime.now().toIso8601String().replaceAll('.', ':');
    final name = 'signature_$time';
    print(name);

    final result = await ImageGallerySaver.saveImage(signature, name: name);
    final isSuccessful = result['isSuccess'];

    if (isSuccessful) {
    } else {}
  }
}
