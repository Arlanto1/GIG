import 'dart:developer';

import 'package:dart_extensions/dart_extensions.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_department_dialog.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_drop_down.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/contact_details/models/contact_info.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/models/responseModels/error_response_validation.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';

class AddContactPopUp extends StatefulWidget {
  const AddContactPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.contact,
    required this.mainContext,
    required this.users,
    required this.rankType,
  });

  final String title;
  final Function onSubmit;
  final ContactRecord contact;
  final List<Organisation> users;
  final BuildContext mainContext;
  final String rankType;

  @override
  State<AddContactPopUp> createState() => AddContactPopUpState();
}

class AddContactPopUpState extends State<AddContactPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController rankController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController escalationLevelController = TextEditingController();

  @override
  void initState() {
    super.initState();

    log('---widget.contact.state---${widget.contact.state}-----');
    rankController.text = widget.contact.rank?.name ?? '';
    nameController.text = widget.contact.email ?? '';
    stateController.text = widget.contact.state ?? '';
    contactNoController.text = widget.contact.contactNo ?? '';
    escalationLevelController.text =
        widget.contact.escalationLevel.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    log('---widget.users--len---${widget.users.length}--');

    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: Styles.textFontSet(18, AppColors.textgreyThemecolor,
              FontWeight.normal, Constants.customFontSemiBoldFamily),
        ),
      ),
      backgroundColor: AppColors.backgroundWhitecolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
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
                      Column(
                        children: [
                          /// Rank
                          CommonWidgets.textDisplay(
                            widget.rankType == Constants.contactZone
                                ? Constants.zone
                                : Constants.rank,
                            Styles.textStyleBlack14,
                            isMandatory: true,
                          ),
                          TextfieldAddButton(
                            title: rankController.text,
                            height: 70,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                entities: widget.users,
                                onTap: (Organisation user) {
                                  log('-user.name----${user.name}-');

                                  rankController.text = user.name ?? '';

                                  widget.contact.rank ??= Organisation();
                                  widget.contact.rank = user;
                                  log('-widget.contact.rank?.name----${widget.contact.rank?.name}-');

                                  setState(() {});
                                  // BlocProvider.of<ContactListingBloc>(context)
                                  //     .updateApproverEmailsValue(
                                  //         approver1EmailUser: user);
                                },
                              );
                            },
                          )
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// State
                      if (widget.rankType == Constants.contactZone) ...[
                        CommonWidgets.textDisplay(
                          Constants.state,
                          isMandatory: true,
                          Styles.textStyleBlack14,
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        FlutterInputField(
                          initialValue: stateController.text,
                          keyboardType: TextInputType.text,
                          textFormKey: Keys.nameKey,
                          hintText: '',
                          isEnable: true,
                          isDisableColor: false,
                          onChange: (String value) {
                            log('-widget.contact.rank?.state--value--$value-');
                            widget.contact.state = value;
                            log('-widget.contact.rank?.state----${widget.contact.state}-');
                          },
                          validateTextField: (String? user) {},
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// Escalation Level
                        CommonWidgets.textDisplay(
                            Constants.escalationLevel,
                            isMandatory: true,
                            Styles.textStyleBlack14),
                        BaseDropDown().getDropDown(
                          isDisabled: false,
                          textController: escalationLevelController,
                          items: escalationLevelDropDownValues,
                          initialValue: escalationLevelController.text,
                          onTap: () {
                            BaseDropDown().assetTypeDialog(
                              context: context,
                              dropDownValues: escalationLevelDropDownValues
                                  .map((label) => label.key)
                                  .toList(),
                              onTap: (String value) {
                                Label? selectedLabel;
                                selectedLabel =
                                    escalationLevelDropDownValues.firstWhere(
                                  (label) => label.key == value,
                                  orElse: () => const Label(key: '', value: ''),
                                );
                                widget.contact.escalationLevel =
                                    int.tryParse(selectedLabel.value);
                                escalationLevelController.text = selectedLabel.key;
                                setState(() {});
                                // BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                //         context)
                                //     .updateDropdownValues(
                                //         maritalStatus:
                                //             int.tryParse(selectedLabel.value));
                              },
                            );
                          },
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                      ],

                      /// Name
                      CommonWidgets.textDisplay(
                        widget.rankType == Constants.contactZone
                            ? Constants.areaNameManager
                            : Constants.name,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: nameController.text,
                        keyboardType: TextInputType.text,
                        textFormKey: Keys.nameKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          log('-widget.contact.rank?.name--value--$value-');
                          widget.contact.email = value;
                          log('-widget.contact.rank?.name----${widget.contact.email}-');

                          // widget.payRate.perHour = double.parse(value);
                          // BlocProvider.of<PayRateCubit>(widget.mainContext)
                          //     .onModelValueChange(widget.payRate);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Phone Number
                      CommonWidgets.textDisplay(
                        Constants.phoneNumber,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: widget.contact.contactNo ?? '',
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          log('-widget.contact.rank?.name--value--$value-');
                          widget.contact.contactNo = value;
                          log('-widget.contact.contactNo?.name----${widget.contact.contactNo}-');
                          // widget.payRate.perHour = double.parse(value);
                          // BlocProvider.of<PayRateCubit>(widget.mainContext)
                          //     .onModelValueChange(widget.payRate);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

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
        saveButton(width, widget.onSubmit)
      ],
    );
  }

  Widget cancelButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButtonText,
      foregroundColor: AppColors.textgreyThemecolor,
      textStyle: Styles.styleHeaderGreyText16,
      backgroundColor: AppColors.white,
      boardercolor: AppColors.textgreyThemecolor,
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
      boardercolor: AppColors.navigationSkybluecolor,
      backgroundColor: AppColors.navigationSkybluecolor,
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
        onSubmit(widget.contact);
        Navigator.pop(context);
      },
    );
  }

  ErrorResponse get isFormValid {
    if (widget.contact.rank?.name == null) {
      return const ErrorResponse(status: false, message: 'Please enter Rank.');
    }
    if (widget.contact.email.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter Name.');
    }
    // if (widget.contact.contactNo.isEmptyOrNull) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Contact No.');
    // }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
