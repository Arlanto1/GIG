import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/base_department_dialog.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/contact_details/models/contact_info.dart';
import 'package:db_atom/src/models/base_user.dart';
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
  });

  final String title;
  final Function onSubmit;
  final ContactInfo contact;
  final List<BaseUser> users;
  final BuildContext mainContext;

  @override
  State<AddContactPopUp> createState() => AddContactPopUpState();
}

class AddContactPopUpState extends State<AddContactPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController contactController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return SizedBox(
          height: height / 2,
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
                          CommonWidgets.textDisplay(
                            Constants.rank,
                            Styles.textStyleBlack14,
                            isMandatory: true,
                          ),
                          TextfieldAddButton(
                            title: widget.contact.contact?.name??'',
                            height: 70,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: widget.users,
                                onTap: (BaseUser user) {
                                  widget.contact.contact?.name = user.email;
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

                      /// Name
                      CommonWidgets.textDisplay(
                        Constants.name,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: widget.contact.email??'',
                        keyboardType: TextInputType.text,
                        textFormKey: Keys.nameKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
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
                        initialValue: '${widget.contact.contactNo??''}',
                        keyboardType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
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
      },
    );
  }

  ErrorResponse get isFormValid {
    if (widget.contact.contact == null) {
      return const ErrorResponse(status: false, message: 'Please enter Rank.');
    }
    if (widget.contact.email == null) {
      return const ErrorResponse(status: false, message: 'Please enter Name.');
    }
    if (widget.contact.contactNo == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Contact No.');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
