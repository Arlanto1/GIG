

import 'dart:developer';

import 'package:db_atom/index.dart';

import '../../../../common_widgets/base_widget/base_add_organisation_dialog.dart';
import '../../models/material_items_model.dart';
import '../bloc/material_items_bloc.dart';


class AddMaterialItemsPopUp extends StatefulWidget {
  const AddMaterialItemsPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.model,
    required this.mainContext,
    this.extraProperties,
    required this.parentStatus,
    required this.users,
    required this.isInward,
  });

  final String title;
  final Function onSubmit;
  final MaterialMovementItem model;
  final BuildContext mainContext;
  final ExtraProperties? extraProperties;
  final int parentStatus;
  final List<Organisation> users;
  final bool isInward;

  @override
  State<AddMaterialItemsPopUp> createState() => AddMaterialItemsPopUpState();
}

class AddMaterialItemsPopUpState extends State<AddMaterialItemsPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController materialDesController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController equipmentController = TextEditingController();

  bool isReadOnly = false;
  @override
  void initState() {
    super.initState();
    if (widget.model.id != null) {
      materialDesController.text =
          widget.model.materialDescription ?? '';

      quantityController.text =
          widget.model.quantity?.toString() ?? '';

      equipmentController.text =
          widget.model.modelInfo ?? '';

      unitController.text =
          widget.model.unit?.name ?? '';
    }

  }

  @override
  Widget build(BuildContext context) {
    MaterialItemsState state = const MaterialItemsState();

    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: Styles.textFontSet(18, AppColors.white,
              FontWeight.normal, Constants.customFontSemiBoldFamily),
        ),
      ),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return SizedBox(
          height: height / 1.8,
          width: width,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      /// Material Description
                      CommonWidgets.textDisplay(
                        Constants.materialBriefDescription,
                        isMandatory: true,
                        Styles.textStyleWhite14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      FlutterInputField(
                        controller: materialDesController,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.visitorsNameKey,
                        hintText: '',
                        isEnable: (widget.parentStatus == 0) &&
                            !(widget.extraProperties != null &&
                                !widget
                                    .extraProperties!.hasWritePermission!)
                            ? true
                            : false,
                        isDisableColor: (widget.parentStatus == 0) &&
                            !(widget.extraProperties != null &&
                                !widget
                                    .extraProperties!.hasWritePermission!)
                            ? false
                            : true,
                        onChange: (String value) {
                          widget.model.materialDescription = value;
                          materialDesController.text = value;
                          // BlocProvider.of<PayRateCubit>(widget.mainContext)
                          //     .onModelValueChange(widget.payRate);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// Quantity
                      CommonWidgets.textDisplay(
                        // state.labels?.locale.quantity ??
                        //     state.labels?.defaultLocale.quantity ??
                          Constants.quantity,
                          Styles.textStyleWhite16,
                          isMandatory: true),
                      //   (state.model.status !=
                      //       ConstantsIntValue.mmStatusDraft &&
                      //       widget.model != null) ||
                      //       (widget.isInward == true)
                      //       ? true
                      //       : false,
                      // ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 100,
                            child: FlutterInputField(
                              characterLimit: 5,
                              textInputType: TextInputType.number,
                              controller: quantityController,
                              // initialValue:
                              // '${widget.model.quantity ?? ''}',
                              textFormKey: Keys.quantityKey,
                              hintText: '',
                              // isEnable: state.model.status == 10 ||
                              //     state.model.status == -1 ||
                              //     state.model.status == 6 ||
                              //     state.model.status == 2 ||
                              //     state.model.status == 3 ||
                              //     state.model.status == 4 ||
                              //     state.model.status ==
                              //         ConstantsIntValue
                              //             .mmStatusInwardWaiting ||
                              //     !showSaveSubmitButtons ||
                              //     isReadOnly
                              //     ? false
                              //     : true,
                              // isDisableColor: state.model.status == 10 ||
                              //     state.model.status == -1 ||
                              //     state.model.status == 6 ||
                              //     state.model.status == 2 ||
                              //     state.model.status == 3 ||
                              //     state.model.status == 4 ||
                              //     !showSaveSubmitButtons ||
                              //     state.model.status ==
                              //         ConstantsIntValue
                              //             .mmStatusInwardWaiting ||
                              //     !state.model.lock.isEmptyOrNull
                              //     ? true
                              //     : false,
                              onChange: (String? value) {
                                if (value != null) {
                                  widget.model.quantity = int.parse(value);
                                  quantityController.text =value;

                                }

                              },
                              validateTextField: (String? user) {},
                            ),

                            // FlutterInputField(
                            //   // initialValue: '${widget.model.penaltyAmount}',
                            //   controller: penaltyAmountController,
                            //   textInputType: TextInputType.number,
                            //   textFormKey: Keys.phoneNumberKey,
                            //   hintText: '',
                            //   isEnable: false,
                            //   isDisableColor: true,
                            //   onChange: (String value) {
                            //     // widget.payRate.perHour = double.parse(value);
                            //     // BlocProvider.of<PayRateCubit>(widget.mainContext)
                            //     //     .onModelValueChange(widget.payRate);
                            //   },
                            //   validateTextField: (String? user) {},
                            // ),
                          ),
                          TileWidget(
                            name: widget.model.unit?.name ?? 'Unit',
                            width: 120,
                          ),
                          if (!isReadOnly) ...[
                            InkWell(
                              onTap: () {
                                BaseOrganisationDialog().departmentDialog(
                                  context: context,
                                  organisations: widget.users ?? [],
                                  onTap: (Organisation org) {
                                    unitController.text = org.name ?? '';


                                    setState(() {
                                      widget.model.unit = org;
                                    });
                                  },
                                );
                              },

                              child: const AddButtonWidget(
                                height: 50,
                              ),
                            ),
                          ],

                        ],
                      ),

                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      if(!widget.isInward)...[
                        CommonWidgets.textDisplay(
                          Constants.equipmentNo,
                          isMandatory: true,
                          Styles.textStyleWhite14,
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        FlutterInputField(
                          controller: equipmentController,
                          textInputType: TextInputType.text,
                          textFormKey: Keys.visitorsNameKey,
                          hintText: '',
                          isEnable: (widget.parentStatus == 0) &&
                              !(widget.extraProperties != null &&
                                  !widget
                                      .extraProperties!.hasWritePermission!)
                              ? true
                              : false,
                          isDisableColor: (widget.parentStatus == 0) &&
                              !(widget.extraProperties != null &&
                                  !widget
                                      .extraProperties!.hasWritePermission!)
                              ? false
                              : true,
                          onChange: (String value) {
                            widget.model.modelInfo = value;
                            equipmentController.text = value;
                            // BlocProvider.of<PayRateCubit>(widget.mainContext)
                            //     .onModelValueChange(widget.payRate);
                          },
                          validateTextField: (String? user) {},
                        ),
                      ],
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      CommonWidgets.verticalSpacerWidget(height * 0.02),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      buttonViews(widget.mainContext, width),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buttonViews(BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        cancelButton(width),
        if ((widget.parentStatus == 0) &&
            !(widget.extraProperties != null &&
                !widget.extraProperties!.hasWritePermission!)) ...[
          saveButton(width, widget.onSubmit)
        ]
      ],
    );
  }

  Widget cancelButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButtonText,
      foregroundColor: AppColors.textGreyThemeColor,
      textStyle: Styles.styleHeaderGreyText16,
      backgroundColor: AppColors.white,
      boarderColor: AppColors.textGreyThemeColor,
      onTap: () {
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      },
    );
  }

  Widget saveButton(double width, Function onSubmit) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.saveButton),
      buttonText: Constants.save,
      buttonTextKey: Keys.saveButtonText,
      boarderColor: AppColors.navigationSkyBlueColor,
      backgroundColor: AppColors.navigationSkyBlueColor,
      foregroundColor: Colors.white,
      textStyle: Styles.textStyleSemiBold16White,
      onTap: () {
        if (!isFormValid.status) {
          Validator().showToast(
            context,
            isFormValid.message,
          );
          return;
        }

        onSubmit(widget.model);
        Navigator.pop(context);
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
            // leftImageName: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return BaseAddOrganisationDialog(
                      title: Constants.addQuantity,
                      orgName: 'ATOM_MATERIAL_MOVEMENT_UNIT',
                      functionToCall: () {
                        // refresh the list
                        BlocProvider.of<MaterialMovementDetailsCubit>(context)
                            .refreshList();
                      },
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
  ErrorResponse get isFormValid {
    if (widget.model.materialDescription == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Material Description.');
    }
    if (widget.model.quantity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Quantity.');
    }

    if (widget.model.unit == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Unit.');
    }

    if (widget.model.modelInfo == null && !widget.isInward) {
      return const ErrorResponse(
          status: false, message: 'Please enter Equipment No.');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
