import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/custom_pop_list_texts.dart';
import 'package:db_atom/src/common_widgets/image_download.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/views/add_employee_deparment.dart';
import 'package:db_atom/src/features/createfound/views/upload_attachment.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_state.dart';
import 'package:db_atom/src/features/material_movement/material_movement_details/cubits/inward_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../createfound/views/create_found_newuser.dart';
import '../../material_movements/models/material_movements_model.dart';

class MaterialMovementInwardDetails extends StatefulWidget {
  final MaterialMovementModel? materialMovement;

  const MaterialMovementInwardDetails({super.key, this.materialMovement});

  @override
  State<MaterialMovementInwardDetails> createState() =>
      _MaterialMovementInwardDetailsState();
}

class _MaterialMovementInwardDetailsState
    extends State<MaterialMovementInwardDetails> {
  final GlobalKey<FormState> lawenforcementFormKey = GlobalKey<FormState>();
  String receiverDepartmentName = '';
  TextEditingController receivedForTextController = TextEditingController();

  TextEditingController actualdateTextController = TextEditingController();
  GetUserDetails? userDetails;

  List<CreateImage>? getFiles;
  List<FoundImage>? getAttachments;
  late LawEnforcementState globalState;
  String? serialnumber;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<InwardCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: Constants.createMaterialMovementInwardTitle,
          showPopUp: false,
          showSaveButton: true,
          onTapSave: null,
        ),
        backgroundColor: AppColors.backgroundWhitecolor,
        body: BlocConsumer<InwardCubit, InwardState>(
          listener: (context, state) {
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
            if (state.status == FormStatus.loading) {
              return const Center(child: CircularProgressIndicator());
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
                          key: lawenforcementFormKey,
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
                                      initialValue: state.materialMovement
                                                  .inwardMovement ==
                                              true
                                          ? 'Inward'
                                          : 'Outward',
                                      onChange: (String value) {},
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Non Returnable
                                    FlutterInputField(
                                      isEnable: false,
                                      isDisableColor: true,
                                      initialValue:
                                          state.materialMovement.returnable ==
                                                  true
                                              ? 'Returnable'
                                              : ' Non Returnable',
                                      textFormKey: Keys.statusTextController,
                                      hintText: '',
                                      onChange: (String value) {},
                                      validateTextField: (String? user) {},
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
                                    datecreateWidgetdisplay(state),
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
                                      // textFieldController:
                                      //     challanTextController,
                                      textFormKey: Keys.challanKey,

                                      initialValue:
                                          state.materialMovement.challanNo,
                                      hintText: '',
                                      isEnable: widget.materialMovement == null
                                          ? true
                                          : (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                          ?.challanNo ==
                                                      null))
                                              ? false
                                              : true,
                                      isDisableColor:
                                          (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                          ?.challanNo !=
                                                      null))
                                              ? true
                                              : false,
                                      onChange: (String value) {
                                        state.materialMovement.challanNo =
                                            value;
                                        context
                                            .read<InwardCubit>()
                                            .onModelValueChange(
                                                state.materialMovement);
                                        log('value-challan---$value');
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

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
                                      textFormKey: Keys.generateUniqueKey(),
                                      hintText: '',
                                      isEnable: widget.materialMovement == null
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
                                        state.materialMovement.poNumber = value;
                                        context
                                            .read<InwardCubit>()
                                            .onModelValueChange(
                                                state.materialMovement);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

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
                                      textFormKey: Keys.generateUniqueKey(),
                                      hintText: Constants.informationhere,
                                      isEnable: widget.materialMovement == null
                                          ? true
                                          : (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                              ?.materialDescription ??
                                                          '')
                                                      .isEmpty)
                                              ? true
                                              : false,
                                      isDisableColor: (widget
                                                          .materialMovement !=
                                                      null &&
                                                  (widget.materialMovement
                                                              ?.materialDescription ??
                                                          '')
                                                      .isEmpty) ||
                                              widget.materialMovement == null
                                          ? false
                                          : true,
                                      onChange: (String value) {
                                        state.materialMovement
                                            .materialDescription = value;
                                        context
                                            .read<InwardCubit>()
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
                                    articleaddButtonwidgetLoading(state),

                                    // TextfieldAddButton(
                                    //   title: 'aaaa',
                                    //   height: 60,
                                    //   isDisableColor: widget.materialMovement == null ||
                                    //       (((state.materialMovement?.quantity ?? '') == null))
                                    //       ? false
                                    //       : true,
                                    //   onTap: () {
                                    //     if (widget.materialMovement == null ||
                                    //         (state.materialMovement != null &&
                                    //             ((state.materialMovement?.quantity ?? '') == null))) {
                                    //       leopurposeDialog(state);
                                    //     }
                                    //   },
                                    // ),

                                    FlutterInputField(
                                      keyboardType: TextInputType.number,
                                      initialValue:
                                          state.materialMovement.quantity !=
                                                  null
                                              ? state.materialMovement.quantity
                                                  .toString()
                                              : '',
                                      textFormKey: Keys.quantityKey,
                                      hintText: '',
                                      isEnable: widget.materialMovement == null
                                          ? true
                                          : (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                          ?.quantity ==
                                                      null))
                                              ? false
                                              : true,
                                      isDisableColor:
                                          (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                          ?.quantity !=
                                                      null))
                                              ? true
                                              : false,
                                      onChange: (String value) {
                                        state.materialMovement.quantity =
                                            int.tryParse(value);
                                        context
                                            .read<InwardCubit>()
                                            .onModelValueChange(
                                                state.materialMovement);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// Senders Name
                                    CommonWidgets.textDisplay(
                                        Constants.sendersName,
                                        Styles.textStyleBlack14),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.001),
                                    FlutterInputField(
                                      keyboardType: TextInputType.name,
                                      initialValue: state
                                          .materialMovement.materialComingFrom,
                                      textFormKey: Keys.generateUniqueKey(),
                                      hintText: '',
                                      isEnable: widget.materialMovement == null
                                          ? true
                                          : (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                          ?.materialComingFrom ==
                                                      null))
                                              ? false
                                              : true,
                                      isDisableColor: (widget
                                                      .materialMovement !=
                                                  null &&
                                              (widget.materialMovement
                                                      ?.materialComingFrom !=
                                                  null))
                                          ? true
                                          : false,
                                      onChange: (String value) {
                                        state.materialMovement
                                            .materialComingFrom = value;
                                        context
                                            .read<InwardCubit>()
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
                                      textFormKey: Keys.generateUniqueKey(),
                                      hintText: Constants.informationhere,
                                      isEnable: widget.materialMovement == null
                                          ? true
                                          : (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                              ?.materialFromAddress ??
                                                          '')
                                                      .isEmpty)
                                              ? true
                                              : false,
                                      isDisableColor: (widget
                                                          .materialMovement !=
                                                      null &&
                                                  (widget.materialMovement
                                                              ?.materialFromAddress ??
                                                          '')
                                                      .isEmpty) ||
                                              widget.materialMovement == null
                                          ? false
                                          : true,
                                      onChange: (String value) {
                                        state.materialMovement
                                            .materialFromAddress = value;
                                        context
                                            .read<InwardCubit>()
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
                                    radioButtonHandling(
                                      state.materialMovement.originalReceiver!
                                          ? 1
                                          : 0,
                                      state.materialMovement,
                                    ),

                                    /// Received For
                                    if (!state.materialMovement
                                        .originalReceiver!) ...[
                                      Column(
                                        children: [
                                          CommonWidgets.textDisplay(
                                            Constants.receivedFor,
                                            Styles.textStyleBlack14,
                                          ),
                                          widget.materialMovement == null
                                              ? TextfieldAddButton(
                                                  title: state.materialMovement
                                                      .otherReceiverName,
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
                                                      userDialog(state,
                                                          Constants.depositor);
                                                    }
                                                  })
                                              : FlutterInputField(
                                                  initialValue: state
                                                      .materialMovement
                                                      .otherReceiverName,
                                                  textFormKey: Keys
                                                      .depositorTextController,
                                                  hintText: '',
                                                  isEnable: widget
                                                              .materialMovement ==
                                                          null
                                                      ? true
                                                      : (widget.materialMovement !=
                                                                  null &&
                                                              (widget.materialMovement
                                                                          ?.otherReceiverName ??
                                                                      '')
                                                                  .isEmpty)
                                                          ? true
                                                          : false,
                                                  isDisableColor:
                                                      (widget.materialMovement !=
                                                              null)
                                                          ? false
                                                          : true,
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
                                      isEnable: widget.materialMovement == null
                                          ? true
                                          : (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                              ?.otherReceiverName ??
                                                          '')
                                                      .isEmpty)
                                              ? true
                                              : false,
                                      isDisableColor: (widget
                                                      .materialMovement !=
                                                  null &&
                                              (widget.materialMovement
                                                          ?.otherReceiverName ??
                                                      '')
                                                  .isEmpty)
                                          ? false
                                          : true,
                                      hintText: '',
                                      onChange: (String value) {
                                        state.materialMovement
                                            .otherReceiverEmployeeId = value;
                                        context
                                            .read<InwardCubit>()
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
                                            initialValue: state.materialMovement
                                                .receiverDepartmenttName,
                                            textFormKey:
                                                Keys.claimantTextController,
                                            hintText: receiverDepartmentName,
                                            isEnable: widget.materialMovement ==
                                                    null
                                                ? true
                                                : (widget.materialMovement !=
                                                            null &&
                                                        (widget.materialMovement
                                                                    ?.receiverDepartmenttName ??
                                                                '')
                                                            .isEmpty)
                                                    ? true
                                                    : false,
                                            isDisableColor: (widget
                                                            .materialMovement !=
                                                        null &&
                                                    (widget.materialMovement
                                                                ?.receiverDepartmenttName ??
                                                            '')
                                                        .isEmpty)
                                                ? false
                                                : true,
                                            onChange: (String value) {
                                              state.materialMovement
                                                      .receiverDepartmenttName =
                                                  value;
                                              context
                                                  .read<InwardCubit>()
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
                                                departmentDialog(state, 'name');
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
                                      isEnable: widget.materialMovement == null
                                          ? true
                                          : (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                              ?.otherReceiverName ??
                                                          '')
                                                      .isEmpty)
                                              ? true
                                              : false,
                                      isDisableColor: (widget
                                                      .materialMovement !=
                                                  null &&
                                              (widget.materialMovement
                                                          ?.otherReceiverName ??
                                                      '')
                                                  .isEmpty)
                                          ? false
                                          : true,
                                      hintText: '',
                                      onChange: (String value) {
                                        state.materialMovement
                                            .otherReceiverName = value;
                                        context
                                            .read<InwardCubit>()
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
                                      initialValue: state
                                          .materialMovement.receiverEmployeeId,
                                      textFormKey:
                                          Keys.claimantEmpIdTextController,
                                      isEnable: widget.materialMovement == null
                                          ? true
                                          : (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                              ?.receiverEmployeeId ??
                                                          '')
                                                      .isEmpty)
                                              ? true
                                              : false,
                                      isDisableColor: (widget
                                                      .materialMovement !=
                                                  null &&
                                              (widget.materialMovement
                                                          ?.receiverEmployeeId ??
                                                      '')
                                                  .isEmpty)
                                          ? false
                                          : true,
                                      hintText: '',
                                      onChange: (String value) {
                                        state.materialMovement
                                            .receiverEmployeeId = value;
                                        context
                                            .read<InwardCubit>()
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
                                      initialValue:
                                          state.materialMovement.receiverEmail,
                                      textFormKey: Keys.generateUniqueKey(),
                                      hintText: Constants.informationhere,
                                      isEnable: widget.materialMovement == null
                                          ? true
                                          : (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                              ?.receiverEmployeeId ??
                                                          '')
                                                      .isEmpty)
                                              ? true
                                              : false,
                                      isDisableColor: (widget
                                                          .materialMovement !=
                                                      null &&
                                                  (widget.materialMovement
                                                              ?.receiverEmployeeId ??
                                                          '')
                                                      .isEmpty) ||
                                              widget.materialMovement == null
                                          ? false
                                          : true,
                                      onChange: (String value) {
                                        state.materialMovement
                                            .entrySecurityName = value;
                                        context
                                            .read<InwardCubit>()
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
                                      textFormKey: Keys.generateUniqueKey(),
                                      hintText: Constants.informationhere,
                                      isEnable: widget.materialMovement == null
                                          ? true
                                          : (widget.materialMovement != null &&
                                                  (widget.materialMovement
                                                              ?.materialDescription ??
                                                          '')
                                                      .isEmpty)
                                              ? true
                                              : false,
                                      isDisableColor: (widget
                                                          .materialMovement !=
                                                      null &&
                                                  (widget.materialMovement
                                                              ?.materialDescription ??
                                                          '')
                                                      .isEmpty) ||
                                              widget.materialMovement == null
                                          ? false
                                          : true,
                                      onChange: (String value) {
                                        state.materialMovement
                                            .materialDescription = value;
                                        context
                                            .read<InwardCubit>()
                                            .onModelValueChange(
                                                state.materialMovement);
                                      },
                                      validateTextField: (String? user) {},
                                    ),
                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),

                                    /// upload
                                    widget.materialMovement == null
                                        ? Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      const Color(0xFFCACACA),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8))),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5.0),
                                                    child: ElevatedButton.icon(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              fixedSize:
                                                                  const Size(
                                                                      140, 50)),
                                                      onPressed: () {
                                                        // Navigator.pushNamed(context,
                                                        //     createFoundAttachmentRoute);
                                                        //UploadAttachment();
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                dialogContext) {
                                                              return UploadAttachment(
                                                                userdetails:
                                                                    userDetails,
                                                                getFiles:
                                                                    getFiles ??
                                                                        [],
                                                              );
                                                            });
                                                      },

                                                      icon: SvgPicture.asset(
                                                        //AppIcon.dropdownicon,
                                                        AppIcon.uploadicon,
                                                        //fit: BoxFit.,
                                                        color: AppColors
                                                            .backgroundWhitecolor,
                                                        width: 13,
                                                        height: 13,
                                                        key: const Key(
                                                            Keys.userIcon),
                                                      ),
                                                      // const Icon(
                                                      //   // <-- Icon
                                                      //   Icons.upload,
                                                      //   color: AppColors.backgroundWhitecolor,
                                                      //   size: 24.0,
                                                      // ),
                                                      label: const Text(
                                                        Constants.clicktoupload,
                                                        style: Styles
                                                            .textStyleRegularNormalWhite12,
                                                      ), // <-- Text
                                                    ),
                                                  ),
                                                ]),
                                          )
                                        : Container(),
                                    getAttachments != null ||
                                            getFiles != null ||
                                            getFiles?.length != 0 ||
                                            getAttachments?.length != 0
                                        ? CommonWidgets.verticalSpacerWidget(
                                            height * 0.01)
                                        : Container(),
                                    (getAttachments == null ||
                                            getAttachments?.length == 0 ||
                                            widget.materialMovement == null)
                                        ? getFiles?.length == 0 ||
                                                getFiles == null
                                            ? Container()
                                            : attachmentListviews(
                                                getFiles, getAttachments)
                                        : attachmentListviews(
                                            getFiles, getAttachments),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.01),
                                  ]),
                                ),

                                /// Attachments
                                getSpaceattchment(height),
                                getAttachement(height),

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

  userDialog(InwardState state, String name) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicatet1Analyst: state.users,
            leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return const CreateFoundNewUser();
                  });
            },
            onTap: (T1Analyst user) {
              BlocProvider.of<InwardCubit>(context)
                  .updateDropdownValues(user: user);
            },
          );
        });
  }

  departmentDialog(InwardState state, String name) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateemployeeDepartments: state.departments,
            leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddEmployeeDepartment(
                      title: '',
                    );
                  });
            },
            onTap: (EmployeeDepartment department) {
              BlocProvider.of<InwardCubit>(context)
                  .updateDropdownValues(department: department);
            },
          );
        });
  }

  Widget articleaddButtonwidgetLoading(InwardState state) {
    return TextfieldAddButton(
      title: state.materialMovement.otherReceiverName ?? '',
      height: 60,
      isDisableColor: state.materialMovement.quantity == null ? false : true,
      onTap: () {
        if (state.materialMovement.quantity == null) {
          articleTypeDialog(state);
        }
      },
    );
  }

  articleTypeDialog(InwardState state) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            // duplicatearticleList: state.getArticleTypeResponse?.articleList ?? [],
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
            onTap: (ArticleList list) {
              // print(list.name);
              // selectedArtclelist = list;
              // setState(() {});
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
        BlocProvider.of<InwardCubit>(context).submitForm();
      },
    );
  }

  // TODO: Need to use this as common widget
  Widget radioButtonHandling(
      int selectedValue, MaterialMovementModel materialMovement) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: widget.materialMovement != null
              ? AppColors.disabletextfieldBackground
              : AppColors.navigationSkybluecolor,
          focusColor: AppColors.navigationSkybluecolor,
          value: 1,
          groupValue: selectedValue,
          onChanged: materialMovement.status == 6
              ? null
              : (val) {
                  BlocProvider.of<InwardCubit>(context).showFields(
                      isOriginalReceiverReceiving: true,
                      materialMovement: materialMovement);
                },
        ),
        const Text(Constants.yes),
        Radio(
          activeColor: widget.materialMovement != null
              ? AppColors.disabletextfieldBackground
              : AppColors.navigationSkybluecolor,
          focusColor: AppColors.navigationSkybluecolor,
          value: 0,
          groupValue: selectedValue,
          onChanged: materialMovement.status == 6
              ? null
              : (val) {
                  BlocProvider.of<InwardCubit>(context).showFields(
                      isOriginalReceiverReceiving: false,
                      materialMovement: materialMovement);
                },
        ),
        const Text(Constants.no),
      ],
    );
  }

  // Widget radioButtonHandling(int selectedValue, String name) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: <Widget>[
  //       Radio(
  //         activeColor: widget.materialMovement != null
  //             ? AppColors.disabletextfieldBackground
  //             : AppColors.navigationSkybluecolor,
  //         focusColor: AppColors.navigationSkybluecolor,
  //         value: 1,
  //         groupValue: selectedValue,
  //         onChanged: (val) {
  //           print(name);
  //           //
  //           selectedValue = 1;
  //           BlocProvider.of<InwardCubit>(context).showFields(isOriginalReceiverReceiving: true);
  //         },
  //       ),
  //       const Text(Constants.yes),
  //       Radio(
  //         activeColor: widget.materialMovement != null
  //             ? AppColors.disabletextfieldBackground
  //             : AppColors.navigationSkybluecolor,
  //         value: 2,
  //         groupValue: selectedValue,
  //         onChanged: (val) {
  //           print(name);
  //           selectedValue = 0;
  //           BlocProvider.of<InwardCubit>(context).showFields(isOriginalReceiverReceiving: false);
  //         },
  //       ),
  //       const Text(Constants.no),
  //     ],
  //   );
  //   //return Container();
  // }

  Widget uploadWidget(InwardState state) {
    return // upload
        widget.materialMovement == null
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
                                userdetails: state.loggedInUserDetails ??
                                    GetUserDetails(),
                                getFiles: getFiles ?? [],
                                inwardState: state,
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
            widget.materialMovement == null)
        ? getFiles?.length == 0 || getFiles == null
            ? Container()
            : attachmentListviews(getFiles, getAttachments)
        : attachmentListviews(getFiles, getAttachments);
  }

  // Widget dbwanttodepartmentaddButtonwidgetLoading(LawEnforcementState state) {
  //   return TextfieldAddButton(
  //     title: state.selectedemployeeDepartmentResponse?.name ?? '',
  //     height: 60,
  //     isDisableColor: widget.materialMovement == null ||
  //             (state.selectedemployeeDepartmentResponse != null &&
  //                 ((state.selectedemployeeDepartmentResponse?.name ?? '')
  //                     .isEmpty))
  //         ? false
  //         : true,
  //     onTap: () {
  //       if (widget.materialMovement == null ||
  //           (state.materialMovement != null &&
  //               ((state.materialMovement.receiverDepartmenttName ?? '')
  //                   .isEmpty))) {
  //         //   articleTypeDialog(state);
  //         leodepartmentsDialog(state);
  //       }
  //     },
  //   );
  // }

  Widget locationWidgetdislay(InwardState state) {
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

                  BlocProvider.of<InwardCubit>(context)
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
      child: Container(
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFCACACA),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: (state.materialMovement.location?.name ?? '').isEmpty
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
                          state.materialMovement.location?.name ?? '',
                          style: Styles.textStyleBlack14,
                        ),
                      ),
                    ),
                  )
                ])),
    );
  }

  Widget datecreateWidgetdisplay(InwardState state) {
    return FlutterInputField(
      textFormKey: Keys.dateofcreationTextController,
      initialValue: state.materialMovement.inputDate,
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

// depositorDialog(CreateFoundState state, String name) {
//   showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return CustomListTexts(
//           duplicatedepostorList:
//               state.getDepositorResponse?.atomStaticUser ?? [],
//           leftimagename: AppIcon.addicon,
//           onLeftButtonTap: () {
//             Navigator.pop(context);
//             showDialog(
//                 barrierDismissible: false,
//                 context: context,
//                 builder: (BuildContext dialogContext) {
//                   return const CreateFoundNewUser();
//                 });
//           },
//           onTap: (AtomStaticUser list) {
//             print(list.name);
//             // if (name.toLowerCase() == 'depositor') {
//             //   selecteddepositorList = list;
//             // } else {
//             //   selectedClaimList = list;
//             // }
//             setState(() {});
//           },
//         );
//       });
// }
}
