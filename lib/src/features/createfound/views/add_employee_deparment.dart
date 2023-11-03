import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_state.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_state.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';

import '../../lawenforcement/controllers/law_enforcement_state.dart';

class AddEmployeeDepartment extends StatefulWidget {
  const AddEmployeeDepartment({
    super.key,
    required this.title,
    this.lawState,
    this.createFoundState,
    this.createPassMgmtState,
  });

  final String title;
  final LawEnforcementState? lawState;
  final CreateFoundState? createFoundState;
  final CreatePassMgmtState? createPassMgmtState;

  @override
  State<AddEmployeeDepartment> createState() => AddEmployeeDepartmentState();
}

class AddEmployeeDepartmentState extends State<AddEmployeeDepartment> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController keyTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _addArticle(String name, String key) async {
    showLoadingDialog(context);
    if (widget.lawState != null) {
      await lawenforcementCubit.createOrganisation(
          name, 'ARTICLE_LIST', context, widget.title);
    } else if (widget.createFoundState != null) {
      await createFoundArticleCubit.createOrganisation(
          name, 'ARTICLE_LIST', context);
    } else if (widget.createPassMgmtState != null) {
      await createpassmgmtCubit.createOrganisation(
          name, 'ARTICLE_LIST', context, widget.title);
    }
  }

  void _createEmployeeDepartment(String name, String key) async {
    showLoadingDialog(context);
    if (widget.lawState != null) {
      await lawenforcementCubit.createEmplyeeDepartments(
          name, 'EMPLOYEE_DEPARTMENTS', context);
    } else if (widget.createFoundState != null) {
      await createFoundArticleCubit.createEmplyeeDepartments(
          name, 'EMPLOYEE_DEPARTMENTS', context);
    } else if (widget.createPassMgmtState != null) {
      await createpassmgmtCubit.createEmployeeDepartments(
          name, 'EMPLOYEE_DEPARTMENTS', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
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
          height: height / 2.8,
          width: width,
          child: Scaffold(
            body: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          Constants.name,
                          style: Styles.textStyleBlack16,
                        ),
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        textFieldController: nameTextController,
                        textFormKey: Keys.nameTextController,
                        hintText: '',
                        onChange: (String username) {
                          //this.username = username;
                          setState(() {});
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          Constants.key,
                          style: Styles.textStyleBlack16,
                        ),
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        textFieldController: keyTextController,
                        textFormKey: Keys.keyTextController,
                        hintText: '',
                        onChange: (String username) {
                          //this.username = username;
                          setState(() {});
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.03),
                      buttonViews(context, width),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buttonViews(BuildContext context, double width) {
    return Container(
      color: AppColors.backgroundWhitecolor,
      child: Row(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[cancelButton(width), saveButton(width)],
      ),
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
      boardercolor: AppColors.textgreyThemecolor,
      onTap: () {
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        try {
          // final ValidLoginDetails validLoginDetails =
          //     ValidLoginDetails(userName: username, password: password);
          // widget.onValidLogin(validLoginDetails);
          //Navigator.pushNamed(context, homePageRoute);
          Navigator.of(context).pop();
        } catch (e) {
          // present userwith error message
        }
      },
    );
  }

  Widget saveButton(double width) {
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
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        if (nameTextController.text.isEmpty) {
          Validator().showToast(
            context,
            "Please enter the name",
          );
        } else {
          try {
            if (Constants.addarticletype == widget.title) {
              _addArticle(nameTextController.text, keyTextController.text);
            } else if (Constants.addemployeedepartment == widget.title) {
              _createEmployeeDepartment(
                  nameTextController.text, keyTextController.text);
            }
          } catch (e) {
            // present userwith error message
          }
        }
      },
    );
  }
}
