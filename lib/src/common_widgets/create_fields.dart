import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_state.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rate_details/pay_rates/cubits/pay_rate_cubit.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_state.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_state.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';



class AddNewFields extends StatefulWidget {
  AddNewFields(
      {super.key, required this.title, this.lawstate, this.createoundstate,this.createpassmgmtstate, this.payRateState,this.entityFun});
  final String title;
  LawEnforcementState? lawstate;
  CreateFoundState? createoundstate;
  CreatePassMgmtState? createpassmgmtstate;
  PayRateState? payRateState;
  Function? entityFun;

  @override
  State<AddNewFields> createState() => AddNewFieldsState();
}

class AddNewFieldsState extends State<AddNewFields> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController keyTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController optionsTextController = TextEditingController();
  TextEditingController weightTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _addCompany(String name, String key) async {
    showLoadingDialog(context);
    if (widget.lawstate != null) {
      if(widget.title == Constants.addcompanytype)
      {
      await lawEnforcementCubit.createOrganisation(
          name, 'ATOM_COMPANY_TYPES', context,widget.title);
      }
      else if(widget.title == Constants.addreasonfordaypass ||widget.title == Constants.addreasonforvendorpass )
      {
         await lawEnforcementCubit.createOrganisation(
          name, 'DAY_PASS_REASON', context,widget.title);
      }
      else if(widget.title == Constants.addentitytype )
      {
         await lawEnforcementCubit.createOrganisation(
          name, 'ATOM_ENTITIES', context,widget.title);
      }
      else if(widget.title == Constants.addpurposeofvisittype )
      {
         await lawEnforcementCubit.createOrganisation(
          name, 'ATOM_LEO_PURPOSE_VISIT', context,widget.title);
      }
      else if(widget.title == Constants.addleoofficialtype )
      {
         await lawEnforcementCubit.createOrganisation(
          name, 'ATOM_LEO_DEPARTMENTS', context,widget.title);
      }
    } else if (widget.createpassmgmtstate != null) {
      if(widget.title == Constants.addcompanytype)
      {
      await createPassMgmtCubit.createOrganisation(
          name, 'ATOM_COMPANY_TYPES', context,widget.title);
      }
      else if(widget.title == Constants.addreasonfordaypass ||widget.title == Constants.addreasonforvendorpass )
      {
         await createPassMgmtCubit.createOrganisation(
          name, 'DAY_PASS_REASON', context,widget.title);
      }
      else if(widget.title == Constants.addentitytype )
      {
         await createPassMgmtCubit.createOrganisation(
          name, 'ATOM_ENTITIES', context,widget.title);
      }
      
     
    } else if (widget.payRateState != null) {


      await createPassMgmtCubit.createOrganisation(
          name, 'ATOM_ENTITIES', context,widget.title);
    }
  }

  void _createEmployeeDepartment(String name, String key) async {
    showLoadingDialog(context);
    if (widget.lawstate != null) {
      await lawEnforcementCubit.createEmplyeeDepartments(
          name, 'EMPLOYEE_DEPARTMENTS', context);
    } else if (widget.createoundstate != null) {
      await createFoundArticleCubit.createEmplyeeDepartments(
          name, 'EMPLOYEE_DEPARTMENTS', context);
    }
    else if (widget.createpassmgmtstate != null) {
      await createPassMgmtCubit.createEmployeeDepartments(
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
            body: SingleChildScrollView(
              child: Stack(
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
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Description',
                            style: Styles.textStyleBlack16,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        FlutterInputField(
                          textFieldController: descriptionTextController,
                          textFormKey: Keys.keyTextController,
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
                            'Options (<key>=<value>)',
                            style: Styles.textStyleBlack16,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        FlutterInputField(
                          textFieldController: optionsTextController,
                          textFormKey: Keys.keyTextController,
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
                            'Weight',
                            style: Styles.textStyleBlack16,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        FlutterInputField(
                          textFieldController: weightTextController,
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
      boarderColor: AppColors.textgreyThemecolor,
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
      boarderColor: AppColors.navigationSkybluecolor,
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
        }
         else if (keyTextController.text.isEmpty) {
          Validator().showToast(
            context,
            "Please enter the key",
          );
        }
         else if (descriptionTextController.text.isEmpty) {
          Validator().showToast(
            context,
            "Please enter the description",
          );
        }
         else if (optionsTextController.text.isEmpty) {
          Validator().showToast(
            context,
            "Please enter the options",
          );
        }
         else if (weightTextController.text.isEmpty) {
          Validator().showToast(
            context,
            "Please enter the weight",
          );
        }
         else {
          try {
            if (Constants.addcompanytype == widget.title || Constants.addreasonfordaypass == widget.title || Constants.addreasonforvendorpass == widget.title || Constants.addentitytype == widget.title ||
            Constants.addpurposeofvisittype == widget.title || Constants.addleoofficialtype == widget.title  ) {
              _addCompany(nameTextController.text, keyTextController.text);
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
