import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/add_button_widget.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/department_dialog.dart';
import 'package:db_atom/src/common_widgets/base_widget/radio_buttons_yes_no.dart';
import 'package:db_atom/src/common_widgets/base_widget/selected_tile_value_widget.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/custom_pop_list_texts.dart';
import 'package:db_atom/src/common_widgets/custom_simple_list_texts.dart';
import 'package:db_atom/src/common_widgets/image_download.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/views/add_employee_deparment.dart';
import 'package:db_atom/src/features/createfound/views/upload_attachment.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/models/quantity_units.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../common_widgets/date_time_picker.dart';
import '../../../../models/base_user.dart';
import '../../../../models/department.dart';

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
  String receiverDepartmentName = '';
  TextEditingController returnableTextController = TextEditingController();
  GetUserDetails? userDetails;
  List<CreateImage>? getFiles;
  List<FoundImage>? getAttachments;
  TextEditingController takenOutOnDateController = TextEditingController();
  TextEditingController expectedDateOfReturnController =
      TextEditingController();
  bool isDisabled = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MaterialMovementDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: widget.title,
          showPopUp: false,
          showSaveButton: true,
          onTapSave: () {
            FocusScope.of(context).unfocus();
            BlocProvider.of<MaterialMovementDetailsCubit>(context)
                .submitForm(isSaveOnly: true);
          },
        ),
        backgroundColor: AppColors.backgroundWhitecolor,
        body: BlocConsumer<MaterialMovementDetailsCubit,
            MaterialMovementDetailsState>(
          listener: (context, state) {
            log('--state.status-2-listener--${state.status}----');

            log('-listener--response--msg--${state.message}---');

            if (state.status == FormStatus.success) {
              Utils.dynamicAlert(
                  context, state.message ?? '', 'Material Movement', '');
            }
            if (state.status == FormStatus.error) {
              Validator().showToast(
                context,
                state.message ?? 'Invalid Information',
              );
            }
          },
          builder: (context, state) {
            returnableTextController.text = state.materialMovement.returnable!
                ? 'Returnable'
                : 'Non Returnable';

            log('--builder---${state.materialMovement.returnable}------');
            if (state.status == FormStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            log('--status-2-builder--${state.status}----');

            if (state.status == FormStatus.addAttachment || state.status == FormStatus.initial) {
              log('---getAttachments----builder----${getAttachments?.length}-----');
              getFiles = state.loadAttachments ?? [];
              log('---getFiles----builder----${getFiles?.length}-----');
            }

            if (state.materialMovement.status == 2) {
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
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.0)),
                          )),
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
                                      initialValue: widget.isInward
                                          ? 'Inward'
                                          : 'Outward',
                                      onChange: (String value) {},
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Non Returnable
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    GestureDetector(
                                      onTap: () {
                                        if (widget.materialMovement == null) {
                                          assetTypeDialog(state);
                                        }
                                      },
                                      child: FlutterInputField(
                                        textFieldController:
                                            returnableTextController,
                                        textFormKey: Keys.returnableKey,
                                        hintText: '',
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          log('val----$value');
                                          // state.materialMovement.returnable = value;
                                        },
                                        validateTextField: (String? user) {},
                                        suffixWidget: IconButton(
                                            icon: SvgPicture.asset(
                                                width: 10,
                                                height: 10,
                                                AppIcon.dropdownicon,
                                                key: const Key('closed_eye')),
                                            onPressed: () {}),
                                      ),

                                      //   FlutterInputField(
                                      //       isEnable: false,
                                      //       isDisableColor: widget.isInward,
                                      //       initialValue: state.materialMovement
                                      //                   .returnable ==
                                      //               true
                                      //           ? 'Returnable'
                                      //           : 'Non Returnable',
                                      //       textFormKey: Keys.returnableKey,
                                      //       hintText: '',
                                      //       onChange: (String value) {
                                      //         bool isReturnable =
                                      //         value == 'Returnable'
                                      //             ? true
                                      //             : false;
                                      //         state.materialMovement
                                      //             .returnable = isReturnable;
                                      //         BlocProvider.of<InwardCubit>(
                                      //             context)
                                      //             .updateDropdownValues(
                                      //             isReturnable: isReturnable);
                                      //       },
                                      //       suffixWidget: IconButton(
                                      //           icon: SvgPicture.asset(
                                      //               width: 10,
                                      //               height: 10,
                                      //               AppIcon.dropdownicon,
                                      //               key: const Key('closed_eye')),
                                      //           onPressed: () {})),
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Status
                                    CommonWidgets.textDisplay(Constants.status,
                                        Styles.textStyleBlack14),
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
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Created By
                                    CommonWidgets.verticalTextHandling(
                                        Constants.createdby,
                                        state.loggedInUserDetails?.name ?? ''),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Location
                                    CommonWidgets.textDisplay(
                                        Constants.location,
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
                                        state.materialMovement.inputDate ?? ''),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Sl No.
                                    CommonWidgets.horizentaltextHandling(
                                        Constants.slno,
                                        state.materialMovement.slNo ?? ''),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Challan/ Invoice Nos/ Gate Pass
                                    CommonWidgets.textDisplay(Constants.challan,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    FlutterInputField(
                                      keyboardType: TextInputType.name,
                                      textFormKey: Keys.challanKey,
                                      initialValue:
                                          state.materialMovement.challanNo,
                                      hintText: '',
                                      isEnable:
                                          state.materialMovement.status != 6,
                                      isDisableColor:
                                          state.materialMovement.status == 6,
                                      onChange: (String value) {
                                        state.materialMovement.challanNo =
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

                                    if (widget.isInward) ...[
                                      /// PO Number
                                      CommonWidgets.textDisplay(
                                          Constants.poNumber,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      FlutterInputField(
                                        keyboardType: TextInputType.number,
                                        initialValue:
                                            state.materialMovement.poNumber,
                                        textFormKey: Keys.poNumberKey,
                                        hintText: '',
                                        isEnable:
                                            widget.materialMovement == null
                                                ? true
                                                : (widget.materialMovement !=
                                                            null &&
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
                                          state.materialMovement.poNumber =
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
                                    ],

                                    /// Material Brief Description
                                    CommonWidgets.textDisplay(
                                        Constants.materialBriefDescription,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    FlutterInputField(
                                      lineHeight: 6,
                                      initialValue: state
                                          .materialMovement.materialDescription,
                                      textFormKey: Keys.materialBreifDescKey,
                                      hintText: Constants.informationhere,
                                      isEnable:
                                          state.materialMovement.status != 6,
                                      isDisableColor:
                                          state.materialMovement.status == 6,
                                      onChange: (String value) {
                                        state.materialMovement
                                            .materialDescription = value;
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

                                    /// Quantity
                                    CommonWidgets.textDisplay(
                                        Constants.quantity,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 250,
                                          child: FlutterInputField(
                                            keyboardType: TextInputType.number,
                                            initialValue:
                                                state.materialMovement.sentTo,
                                            textFormKey: Keys.sentToKey,
                                            hintText: '',
                                            isEnable:
                                                state.materialMovement.status !=
                                                    6,
                                            isDisableColor:
                                                state.materialMovement.status ==
                                                    6,
                                            onChange: (String value) {
                                              state.materialMovement.quantity =
                                                  value as int;
                                              context
                                                  .read<
                                                      MaterialMovementDetailsCubit>()
                                                  .onModelValueChange(
                                                      state.materialMovement);
                                            },
                                            validateTextField:
                                                (String? user) {},
                                          ),
                                        ),
                                        // CommonWidgets.horizontalSpacerWidget(
                                        //     width * 0.01),
                                        TileWidget(
                                          name: state.materialMovement.unit
                                                  ?.name ??
                                              'Unit',
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
                                        initialValue: state.materialMovement
                                            .materialFromAddress,
                                        textFormKey: Keys.equipmentNoKey,
                                        hintText: '',
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          state.materialMovement
                                              .materialFromAddress = value;
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

                                      /// Address
                                      CommonWidgets.textDisplay(
                                          Constants.address,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      FlutterInputField(
                                        lineHeight: 6,
                                        initialValue:
                                            state.materialMovement.address,
                                        textFormKey: Keys.addressKey,
                                        hintText: '',
                                        isEnable:
                                            widget.materialMovement == null
                                                ? true
                                                : (widget.materialMovement !=
                                                            null &&
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
                                                    widget.materialMovement ==
                                                        null
                                                ? false
                                                : true,
                                        onChange: (String value) {
                                          state.materialMovement.address =
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

                                      /// Requester Email
                                      Column(
                                        children: [
                                          CommonWidgets.textDisplay(
                                            Constants.requestorEmail,
                                            Styles.textStyleBlack14,
                                          ),
                                          widget.materialMovement == null
                                              ? TextfieldAddButton(
                                                  title: state.materialMovement
                                                      .requestorEmail,
                                                  height: 70,
                                                  isDisableColor:
                                                      widget.materialMovement ==
                                                              null
                                                          ? false
                                                          : true,
                                                  onTap: () {
                                                    if (widget
                                                            .materialMovement ==
                                                        null) {
                                                      BaseDialog().userDialog(
                                                        context: context,
                                                        users:
                                                            state.emailUsers!,
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
                                                  initialValue: state
                                                      .materialMovement
                                                      .receiverEmail,
                                                  textFormKey:
                                                      Keys.requesterEmailKey,
                                                  hintText: '',
                                                  isEnable: state
                                                          .materialMovement
                                                          .status !=
                                                      6,
                                                  isDisableColor: state
                                                          .materialMovement
                                                          .status ==
                                                      6,
                                                  onChange:
                                                      (String username) {},
                                                  validateTextField:
                                                      (String? user) {},
                                                ),
                                          CommonWidgets.verticalSpacerWidget(
                                              height * 0.01),
                                        ],
                                      ),

                                      /// Requestor Employee Id
                                      CommonWidgets.textDisplay(
                                          Constants.requestorEmployeeId,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),

                                      FlutterInputField(
                                        keyboardType: TextInputType.number,
                                        initialValue: state.materialMovement
                                            .requestorEmployeeId,
                                        textFormKey: Keys.requestorEmployeeKey,
                                        hintText: '',
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          state.materialMovement
                                              .requestorEmployeeId = value;
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

                                      /// Requester Department
                                      Column(
                                        children: [
                                          CommonWidgets.textDisplay(
                                            Constants.requestorDepartment,
                                            Styles.textStyleBlack14,
                                          ),
                                          widget.materialMovement == null
                                              ? TextfieldAddButton(
                                                  title: state
                                                      .materialMovement
                                                      .requestorDepartment
                                                      ?.name,
                                                  height: 70,
                                                  isDisableColor:
                                                      widget.materialMovement ==
                                                              null
                                                          ? false
                                                          : true,
                                                  onTap: () {
                                                    if (widget
                                                            .materialMovement ==
                                                        null) {
                                                      BaseDialog()
                                                          .departmentDialog(
                                                        context: context,
                                                        departments:
                                                            state.departments,
                                                        onTap: (BaseUser user) {
                                                          BlocProvider.of<
                                                                      MaterialMovementDetailsCubit>(
                                                                  context)
                                                              .updateDropdownValues(
                                                                  user: user);
                                                        },
                                                      );
                                                    }
                                                  })
                                              : FlutterInputField(
                                                  initialValue: state
                                                      .materialMovement
                                                      .receiverEmail,
                                                  textFormKey: Keys
                                                      .depositorTextController,
                                                  hintText: '',
                                                  isEnable: state
                                                          .materialMovement
                                                          .status !=
                                                      6,
                                                  isDisableColor: state
                                                          .materialMovement
                                                          .status ==
                                                      6,
                                                  onChange:
                                                      (String username) {},
                                                  validateTextField:
                                                      (String? user) {},
                                                ),
                                          CommonWidgets.verticalSpacerWidget(
                                              height * 0.01),
                                        ],
                                      ),

                                      /// Sent To
                                      CommonWidgets.textDisplay(
                                          Constants.sentTo,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),

                                      FlutterInputField(
                                        keyboardType: TextInputType.number,
                                        initialValue:
                                            state.materialMovement.sentTo,
                                        textFormKey: Keys.sentToKey,
                                        hintText: '',
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          state.materialMovement.sentTo = value;
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

                                      /// Purpose
                                      CommonWidgets.textDisplay(
                                          Constants.purpose,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),

                                      FlutterInputField(
                                        keyboardType: TextInputType.text,
                                        initialValue:
                                            state.materialMovement.purpose,
                                        textFormKey: Keys.purposeKey,
                                        hintText: '',
                                        isEnable:
                                            widget.materialMovement == null
                                                ? true
                                                : (widget.materialMovement !=
                                                            null &&
                                                        (widget.materialMovement
                                                                ?.purpose ==
                                                            null))
                                                    ? false
                                                    : true,
                                        isDisableColor:
                                            (widget.materialMovement != null &&
                                                    (widget.materialMovement
                                                            ?.purpose !=
                                                        null))
                                                ? true
                                                : false,
                                        onChange: (String value) {
                                          state.materialMovement.purpose =
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

                                      /// Prepared By
                                      CommonWidgets.textDisplay(
                                          Constants.preparedBy,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),

                                      FlutterInputField(
                                        // keyboardType: TextInputType.number,
                                        initialValue:
                                            state.materialMovement.preparedBy,
                                        textFormKey: Keys.preparedByKey,
                                        hintText: '',
                                        isEnable:
                                            widget.materialMovement == null
                                                ? true
                                                : (widget.materialMovement !=
                                                            null &&
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
                                          state.materialMovement.preparedBy =
                                              value;
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
                                      widget.materialMovement != null
                                          ? FlutterInputField(
                                              initialValue: state
                                                  .materialMovement
                                                  .preparedByDepartment
                                                  ?.name,
                                              textFormKey:
                                                  Keys.preparedByDepartmentKey,
                                              hintText: '',
                                              isEnable: state.materialMovement
                                                      .status !=
                                                  6,
                                              isDisableColor: state
                                                      .materialMovement
                                                      .status ==
                                                  6,
                                              onChange: (String value) {},
                                              validateTextField:
                                                  (String? user) {},
                                            )
                                          : TextfieldAddButton(
                                              title: state.materialMovement
                                                  .preparedByDepartment?.name,
                                              height: 60,
                                              isDisableColor:
                                                  widget.materialMovement ==
                                                          null
                                                      ? false
                                                      : true,
                                              onTap: () {
                                                if (widget.materialMovement ==
                                                    null) {
                                                  BaseDialog().departmentDialog(
                                                    context: context,
                                                    departments:
                                                        state.departments,
                                                    onTap: (Department
                                                        department) {
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

                                      /// Approver1 Email
                                      Column(
                                        children: [
                                          CommonWidgets.textDisplay(
                                            Constants.approver1Email,
                                            Styles.textStyleBlack14,
                                          ),
                                          widget.materialMovement == null
                                              ? TextfieldAddButton(
                                                  title: state.materialMovement
                                                      .approver1Email,
                                                  height: 70,
                                                  isDisableColor:
                                                      widget.materialMovement ==
                                                              null
                                                          ? false
                                                          : true,
                                                  onTap: () {
                                                    if (widget
                                                            .materialMovement ==
                                                        null) {
                                                      BaseDialog().userDialog(
                                                        context: context,
                                                        users:
                                                            state.emailUsers!,
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
                                                  initialValue: state
                                                      .materialMovement
                                                      .approver1Email,
                                                  textFormKey: Keys
                                                      .depositorTextController,
                                                  hintText: '',
                                                  isEnable: state
                                                          .materialMovement
                                                          .status !=
                                                      6,
                                                  isDisableColor: state
                                                          .materialMovement
                                                          .status ==
                                                      6,
                                                  onChange:
                                                      (String username) {},
                                                  validateTextField:
                                                      (String? user) {},
                                                ),
                                          CommonWidgets.verticalSpacerWidget(
                                              height * 0.01),
                                        ],
                                      ),

                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),

                                      /// Approver1 By Department
                                      CommonWidgets.textDisplay(
                                        Constants.approver1Department,
                                        Styles.textStyleBlack14,
                                      ),
                                      widget.materialMovement != null
                                          ? FlutterInputField(
                                              initialValue: state
                                                  .materialMovement
                                                  .approver1Department
                                                  ?.name,
                                              textFormKey:
                                                  Keys.aprrover1DepartmentKey,
                                              hintText: '',
                                              isEnable: state.materialMovement
                                                      .status !=
                                                  6,
                                              isDisableColor: state
                                                      .materialMovement
                                                      .status ==
                                                  6,
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
                                              validateTextField:
                                                  (String? user) {},
                                            )
                                          : TextfieldAddButton(
                                              title: state.materialMovement
                                                  .approver1Department?.name,
                                              height: 60,
                                              isDisableColor:
                                                  widget.materialMovement ==
                                                          null
                                                      ? false
                                                      : true,
                                              onTap: () {
                                                BaseDialog().departmentDialog(
                                                  context: context,
                                                  departments:
                                                      state.departments,
                                                  onTap:
                                                      (Department department) {
                                                    BlocProvider.of<
                                                                MaterialMovementDetailsCubit>(
                                                            context)
                                                        .updateDropdownValues(
                                                            approver1Department:
                                                                department);
                                                  },
                                                );
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
                                          widget.materialMovement == null
                                              ? TextfieldAddButton(
                                                  title: state.materialMovement
                                                      .approver2Email,
                                                  height: 70,
                                                  isDisableColor:
                                                      widget.materialMovement ==
                                                              null
                                                          ? false
                                                          : true,
                                                  onTap: () {
                                                    if (widget
                                                            .materialMovement ==
                                                        null) {
                                                      BaseDialog().userDialog(
                                                        context: context,
                                                        users:
                                                            state.emailUsers!,
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
                                                  initialValue: state
                                                      .materialMovement
                                                      .approver2Email,
                                                  textFormKey: Keys
                                                      .depositorTextController,
                                                  hintText: '',
                                                  isEnable: state
                                                          .materialMovement
                                                          .status !=
                                                      6,
                                                  isDisableColor: state
                                                          .materialMovement
                                                          .status ==
                                                      6,
                                                  onChange:
                                                      (String username) {},
                                                  validateTextField:
                                                      (String? user) {},
                                                ),
                                          CommonWidgets.verticalSpacerWidget(
                                              height * 0.01),
                                        ],
                                      ),

                                      /// Approver2 By Department
                                      CommonWidgets.textDisplay(
                                        Constants.approver2Department,
                                        Styles.textStyleBlack14,
                                      ),
                                      widget.materialMovement != null
                                          ? FlutterInputField(
                                              initialValue: state
                                                  .materialMovement
                                                  .approver2Department
                                                  ?.name,
                                              textFormKey:
                                                  Keys.aprrover2DepartmentKey,
                                              hintText: '',
                                              isEnable: state.materialMovement
                                                      .status !=
                                                  6,
                                              isDisableColor: state
                                                      .materialMovement
                                                      .status ==
                                                  6,
                                              onChange: (String value) {},
                                              validateTextField:
                                                  (String? user) {},
                                            )
                                          : TextfieldAddButton(
                                              title: state.materialMovement
                                                  .approver2Department?.name,
                                              height: 60,
                                              isDisableColor:
                                                  widget.materialMovement ==
                                                          null
                                                      ? false
                                                      : true,
                                              onTap: () {
                                                if (widget.materialMovement ==
                                                    null) {
                                                  BaseDialog().departmentDialog(
                                                    context: context,
                                                    departments:
                                                        state.departments,
                                                    onTap: (Department
                                                        department) {
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

                                      /// If Status is Approved(status=2), Inward Pending(status=5), Submitted(status=1)
                                      if (state.materialMovement.status == 2 ||
                                          state.materialMovement.status == 5 ||
                                          state.materialMovement.status ==
                                              1) ...[
                                        if (state.materialMovement.returnable ==
                                            true) ...[
                                          /// Expected Date Of Return
                                          CommonWidgets.textDisplay(
                                              Constants.expectedDateOfReturn,
                                              Styles.textStyleBlack14),
                                          CommonWidgets.verticalSpacerWidget(
                                              height * 0.001),
                                          datepickerWidgetLoading(
                                            textfiled:
                                                expectedDateOfReturnController,
                                            isDisabled: isDisabled,
                                            onChange: (String value) {
                                              state.materialMovement
                                                  .expectedDateOfReturn = value;
                                              BlocProvider.of<
                                                          MaterialMovementDetailsCubit>(
                                                      context)
                                                  .onModelValueChange(
                                                      state.materialMovement);
                                            },
                                          ),
                                          CommonWidgets.verticalSpacerWidget(
                                              height * 0.01),
                                        ],

                                        /// If Status is Approved(status=2) and Inward Pending(status=5)
                                        if (state.materialMovement.status ==
                                                2 ||
                                            state.materialMovement.status ==
                                                5) ...[
                                          ///Expected Date of Return

                                          /// Approved By
                                          CommonWidgets.verticalTextHandling(
                                              Constants.approvedBy,
                                              state.materialMovement
                                                      .approvedBy ??
                                                  ''),
                                          CommonWidgets.verticalSpacerWidget(
                                              height * 0.01),

                                          /// Approved Date
                                          CommonWidgets.verticalTextHandling(
                                              Constants.approvedDate,
                                              state.materialMovement
                                                      .approvedDate ??
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
                                            initialValue: state
                                                .materialMovement.takenOutEmail,
                                            textFormKey: Keys.takenOutByKey,
                                            hintText: '',
                                            isEnable:
                                                state.materialMovement.status ==
                                                    2,
                                            isDisableColor:
                                                state.materialMovement.status !=
                                                    2,
                                            onChange: (String value) {
                                              state.materialMovement
                                                  .takenOutEmail = value;
                                              context
                                                  .read<
                                                      MaterialMovementDetailsCubit>()
                                                  .onModelValueChange(
                                                      state.materialMovement);
                                            },
                                            validateTextField:
                                                (String? user) {},
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
                                            initialValue: state.materialMovement
                                                .takenOutContactNo,
                                            textFormKey:
                                                Keys.takenOutContactKey,
                                            hintText: '',
                                            isEnable:
                                                state.materialMovement.status ==
                                                    2,
                                            isDisableColor:
                                                state.materialMovement.status !=
                                                    2,
                                            onChange: (String value) {
                                              state.materialMovement
                                                  .takenOutContactNo = value;
                                              context
                                                  .read<
                                                      MaterialMovementDetailsCubit>()
                                                  .onModelValueChange(
                                                      state.materialMovement);
                                            },
                                            validateTextField:
                                                (String? user) {},
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
                                            initialValue: state.materialMovement
                                                .takenOutAddress,
                                            textFormKey:
                                                Keys.takenOutAddressKey,
                                            hintText: '',
                                            isEnable:
                                                state.materialMovement.status ==
                                                    2,
                                            isDisableColor:
                                                state.materialMovement.status !=
                                                    2,
                                            onChange: (String value) {
                                              state.materialMovement
                                                  .takenOutAddress = value;
                                              context
                                                  .read<
                                                      MaterialMovementDetailsCubit>()
                                                  .onModelValueChange(
                                                      state.materialMovement);
                                            },
                                            validateTextField:
                                                (String? user) {},
                                          ),
                                          CommonWidgets.verticalSpacerWidget(
                                              height * 0.01),

                                          /// Taken Out On
                                          CommonWidgets.textDisplay(
                                              Constants.takenOutOn,
                                              Styles.textStyleBlack14),
                                          CommonWidgets.verticalSpacerWidget(
                                              height * 0.001),

                                          datepickerWidgetLoading(
                                            textfiled: takenOutOnDateController,
                                            onChange: (String value) {
                                              state.materialMovement
                                                  .takenOutOn = value;
                                              BlocProvider.of<
                                                          MaterialMovementDetailsCubit>(
                                                      context)
                                                  .onModelValueChange(
                                                      state.materialMovement);
                                            },
                                          ),
                                          CommonWidgets.verticalSpacerWidget(
                                              height * 0.01),
                                        ]
                                      ],

                                      /// If Status is Rejected(status=3)
                                      if (state.materialMovement.status ==
                                          3) ...[
                                        /// Rejected By
                                        CommonWidgets.verticalTextHandling(
                                            Constants.rejectedBy,
                                            state.materialMovement.rejectedBy ??
                                                ''),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                        /// Rejected Date
                                        CommonWidgets.verticalTextHandling(
                                            Constants.rejectedDate,
                                            state.materialMovement
                                                    .rejectedDate ??
                                                ''),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),

                                        /// Rejected Comment
                                        CommonWidgets.verticalTextHandling(
                                            Constants.rejectedComment,
                                            state.materialMovement
                                                    .rejectionComment ??
                                                ''),
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
                                        initialValue: state.materialMovement
                                            .materialComingFrom,
                                        textFormKey: Keys.sendersKey,
                                        hintText: '',
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          state.materialMovement
                                              .materialComingFrom = value;
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

                                      /// Material Coming From Address
                                      CommonWidgets.textDisplay(
                                          Constants
                                              .materialComingFromBriefDescription,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      FlutterInputField(
                                        lineHeight: 6,
                                        initialValue: state.materialMovement
                                            .materialFromAddress,
                                        textFormKey: Keys.materialComingFromKey,
                                        hintText: Constants.informationhere,
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          state.materialMovement
                                              .materialFromAddress = value;
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

                                      /// Is original receiver receiving
                                      CommonWidgets.textDisplay(
                                          Constants.isOriginalReceiverReceiving,
                                          Styles.textStyleBlack14),
                                      RadioButtonsYesNo(
                                          status:
                                              state.materialMovement.status ??
                                                  0,
                                          selectedValue: state.materialMovement
                                                  .originalReceiver
                                              ? 1
                                              : 0,
                                          onChangedYes:
                                              widget.materialMovement?.status ==
                                                      6
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
                                              widget.materialMovement?.status ==
                                                      6
                                                  ? null
                                                  : (val) {
                                                      BlocProvider.of<
                                                                  MaterialMovementDetailsCubit>(
                                                              context)
                                                          .showFields(
                                                        isOriginalReceiverReceiving:
                                                            false,
                                                      );
                                                    }),

                                      /// Received For
                                      if (!state.materialMovement
                                          .originalReceiver) ...[
                                        Column(
                                          children: [
                                            CommonWidgets.textDisplay(
                                              Constants.receivedFor,
                                              Styles.textStyleBlack14,
                                            ),
                                            widget.materialMovement == null
                                                ? TextfieldAddButton(
                                                    title: state
                                                        .materialMovement
                                                        .receiverEmail,
                                                    height: 70,
                                                    isDisableColor:
                                                        widget.materialMovement ==
                                                                null
                                                            ? false
                                                            : true,
                                                    onTap: () {
                                                      if (widget
                                                              .materialMovement ==
                                                          null) {
                                                        BaseDialog().userDialog(
                                                          context: context,
                                                          users:
                                                              state.emailUsers!,
                                                          onTap:
                                                              (BaseUser user) {
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
                                                    initialValue: state
                                                        .materialMovement
                                                        .otherReceiverName,
                                                    textFormKey: Keys
                                                        .depositorTextController,
                                                    hintText: '',
                                                    isEnable: state
                                                            .materialMovement
                                                            .status !=
                                                        6,
                                                    isDisableColor: state
                                                            .materialMovement
                                                            .status ==
                                                        6,
                                                    onChange:
                                                        (String username) {},
                                                    validateTextField:
                                                        (String? user) {},
                                                  ),
                                            CommonWidgets.verticalSpacerWidget(
                                                height * 0.01),
                                          ],
                                        ),
                                      ],

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
                                              .read<
                                                  MaterialMovementDetailsCubit>()
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
                                      widget.materialMovement != null
                                          ? FlutterInputField(
                                              initialValue: state
                                                  .materialMovement
                                                  .receiverDepartmenttName,
                                              textFormKey:
                                                  Keys.claimantTextController,
                                              hintText: receiverDepartmentName,
                                              isEnable: state.materialMovement
                                                      .status !=
                                                  6,
                                              isDisableColor: state
                                                      .materialMovement
                                                      .status ==
                                                  6,
                                              onChange: (String value) {
                                                state.materialMovement
                                                        .receiverDepartmenttName =
                                                    value;
                                                context
                                                    .read<
                                                        MaterialMovementDetailsCubit>()
                                                    .onModelValueChange(
                                                        state.materialMovement);
                                              },
                                              validateTextField:
                                                  (String? user) {},
                                            )
                                          : TextfieldAddButton(
                                              title: state.materialMovement
                                                  .receiverDepartmenttName,
                                              height: 60,
                                              isDisableColor:
                                                  widget.materialMovement ==
                                                              null ||
                                                          receiverDepartmentName
                                                              .isEmpty
                                                      ? false
                                                      : true,
                                              onTap: () {
                                                if (widget.materialMovement ==
                                                        null ||
                                                    receiverDepartmentName
                                                        .isEmpty) {
                                                  BaseDialog().departmentDialog(
                                                    context: context,
                                                    departments:
                                                        state.departments,
                                                    onTap: (Department
                                                        department) {
                                                      BlocProvider.of<
                                                                  MaterialMovementDetailsCubit>(
                                                              context)
                                                          .updateDropdownValues(
                                                              receiverDepartment:
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

                                      /// Received By
                                      CommonWidgets.textDisplay(
                                          Constants.receivedBy,
                                          Styles.textStyleBlack14),

                                      FlutterInputField(
                                        initialValue: state
                                            .materialMovement.otherReceiverName,
                                        textFormKey:
                                            Keys.claimantEmpIdTextController,
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        hintText: '',
                                        onChange: (String value) {
                                          state.materialMovement
                                              .otherReceiverName = value;
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

                                      /// Received for Employee Id
                                      CommonWidgets.textDisplay(
                                          Constants.receivedForEmployeeId,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                      FlutterInputField(
                                        initialValue: state.materialMovement
                                            .receiverEmployeeId,
                                        textFormKey:
                                            Keys.claimantEmpIdTextController,
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        hintText: '',
                                        onChange: (String value) {
                                          state.materialMovement
                                              .receiverEmployeeId = value;
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

                                      /// Receiver Signature
                                      CommonWidgets.textDisplay(
                                          Constants.receiverSignature,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      FlutterInputField(
                                        lineHeight: 6,
                                        initialValue: state
                                            .materialMovement.receiverEmail,
                                        textFormKey: Keys.receiverSignKey,
                                        hintText: Constants.informationhere,
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          state.materialMovement
                                              .entrySecurityName = value;
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

                                      /// Security Signature
                                      CommonWidgets.textDisplay(
                                          Constants.securitySignature,
                                          Styles.textStyleBlack14),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.001),
                                      FlutterInputField(
                                        lineHeight: 6,
                                        initialValue: state.materialMovement
                                            .materialDescription,
                                        textFormKey: Keys.securitySignKey,
                                        hintText: Constants.informationhere,
                                        isEnable:
                                            state.materialMovement.status != 6,
                                        isDisableColor:
                                            state.materialMovement.status == 6,
                                        onChange: (String value) {
                                          state.materialMovement
                                              .materialDescription = value;
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

                                      /// Is Material Physically Checked
                                      CommonWidgets.textDisplay(
                                          Constants.isPhysicallyChecked,
                                          Styles.textStyleBlack14),
                                      RadioButtonsYesNo(
                                          status:
                                              state.materialMovement.status ??
                                                  0,
                                          selectedValue: state.materialMovement
                                                  .materialPhysicallyChecked
                                              ? 1
                                              : 0,
                                          onChangedYes:
                                              widget.materialMovement?.status ==
                                                      6
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
                                              widget.materialMovement?.status ==
                                                      6
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
                                        CommonWidgets.textDisplay(
                                            Constants.comment,
                                            Styles.textStyleBlack14),
                                        FlutterInputField(
                                          initialValue: state.materialMovement
                                              .otherReceiverName,
                                          textFormKey:
                                              Keys.claimantEmpIdTextController,
                                          isEnable:
                                              state.materialMovement.status !=
                                                  6,
                                          isDisableColor:
                                              state.materialMovement.status ==
                                                  6,
                                          hintText: '',
                                          onChange: (String value) {
                                            state.materialMovement
                                                    .materialNotCheckedComment =
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
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// SubmitButton
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      cancelButtonDisplay(),
                                      submitButtonDisplay()
                                    ]),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.04),
                              ])))
                ])));
          },
        )); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
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

  assetTypeDialog(MaterialMovementDetailsState state) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CustomSimpleListTexts(
            texts: const ["Returnable", "Non Returnable"],
            onTap: (String value) {
              bool isReturnable = value == 'Returnable' ? true : false;
              state.materialMovement.returnable = isReturnable;
              BlocProvider.of<MaterialMovementDetailsCubit>(context)
                  .updateDropdownValues(isReturnable: isReturnable);
            });
      },
    );
  }

  Widget quantityUnitPopUp(MaterialMovementDetailsState state) {
    return TextfieldAddButton(
      title: 'Quantity',
      height: 60,
      isDisableColor: state.materialMovement.quantity == null ? false : true,
      onTap: () {
        if (state.materialMovement.quantity == null) {
          quantityUnitDialog(
              context: context, quantityUnits: state.quantityUnits);
        }
      },
    );
  }

  quantityUnitDialog(
      {required BuildContext context,
      required List<QuantityUnit> quantityUnits}) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateQuantityUnitList: quantityUnits,
            leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddEmployeeDepartment(
                      title: Constants.addQuantity,
                      // createoundstate:  state,
                    );
                  });
            },
            onTap: (QuantityUnit unit) {
              BlocProvider.of<MaterialMovementDetailsCubit>(context)
                  .updateDropdownValues(quantityUnit: unit);
            },
          );
        });
  }

  Widget datepickerWidgetLoading({
    required TextEditingController textfiled,
    bool isDisabled = false,
    required Function onChange,
  }) {
    return GestureDetector(
      onTap: () {
        if (!isDisabled) {
          datePickerDialog(textfiled);
        }
      },
      child: FlutterInputField(
        textFieldController: textfiled,
        textFormKey: textfiled == textfiled
            ? Keys.founddateTextController
            : Keys.handedoverdateTextController,
        hintText: '',
        isEnable: !isDisabled,
        isDisableColor: isDisabled,
        onChange: onChange,
        validateTextField: (String? user) {},
        suffixWidget: GestureDetector(
          onTap: () async {
            if (textfiled.text.isEmpty) {
              datePickerDialog(textfiled);
              // state.materialMovement.tak
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
    DateTime? pickedDate = await showDateTimePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    String formattedDate = DateFormat(Constants.fulldateFormat)
        .format(pickedDate ?? DateTime.now());
    //you can implement different kind of Date Format here according to your requirement
    takenOutOnDateController.text = formattedDate;
    setState(() {
      // dateinput.text = formattedDate; //set output date to TextField value.
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
                            userdetails:
                                state.loggedInUserDetails ?? GetUserDetails(),
                            getFiles: getFiles ?? [],
                            inwardState: state,
                            onImageSelected: (CreateImage data) {
                              log('-------function---onImageSelected---------');
                              List<CreateImage>? files =[];
                              files.add(data);
                              for(CreateImage image in getFiles!.toList()) {
                                files.add(image);
                              }
                              BlocProvider.of<MaterialMovementDetailsCubit>(context).addAttchment(files);
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
    log('---getAttachments--------${getAttachments?.length}-----');

    return getAttachments != null ||
            getFiles != null ||
            getFiles?.length != 0 ||
            getAttachments?.length != 0
        ? CommonWidgets.verticalSpacerWidget(height * 0.01)
        : Container();
  }

  Widget getAttachement(MaterialMovementDetailsState state, double height) {
    log('---getAttachments----aaa----${getAttachments?.length}-----');

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
        if (widget.materialMovement == null ||
            (state.materialMovement.location?.name ?? '').isEmpty) {
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
                  state.materialMovement.location = location;

                  BlocProvider.of<MaterialMovementDetailsCubit>(context)
                      .updateDropdownValues(location: location);

                  // state.copyWith(
                  //   materialMovement: state.materialMovement,
                  // );
                  // log('--state.materialMovement.location-----${state.materialMovement.location?.name}---');

                  // TODO: Need to check this setState
                  // May be calling SlNo. API and then setting the state
                  // setState(() {});

                  // await lawenforcementCubit.getSerialnumberDetails(
                  //     list?.id.toString() ?? '', 'AF');
                  // // locationselectedText = list?.name ?? '';
                  // // locationSelectedlist = list;
                  // lawenforcementCubit.getlocationsResponseData(list);
                },
              );
            },
          );
        }
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
                ), //                           <-- Divider
              ],
            );
          }),
    );
  }
}
