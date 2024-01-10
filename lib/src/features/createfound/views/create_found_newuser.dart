import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_state.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_state.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_state.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';

class CreateFoundNewUser extends StatefulWidget {
  //const CreateFoundNewUser({super.key});
  CreateFoundNewUser(
      {super.key,
      required this.title,
      this.lawstate,
      this.createoundstate,
      this.createpassmgmtstate});

  final String title;
  LawEnforcementState? lawstate;
  CreateFoundState? createoundstate;
  CreatePassMgmtState? createpassmgmtstate;

  @override
  State<CreateFoundNewUser> createState() => CreateFoundNewUserState();
}

class CreateFoundNewUserState extends State<CreateFoundNewUser> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstnameTextController = TextEditingController();
  TextEditingController lastnameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getFoundNewuser();
  }

  void _getFoundNewuser(String firstname, String lastname, String email) async {
    showLoadingDialog(context);
    if (widget.createoundstate != null) {
      await createFoundArticleCubit.createUser(
          firstname, lastname, email, 'ATOM_STATIC_USER', context);
    }
    // else if (widget.createpassmgmtstate != null)
    // {
    //    await createpassmgmtCubit.createUser(
    //     firstname, lastname, email, 'ATOM_STATIC_USER', context);
    // }
    else if (widget.lawstate != null) {
      await lawEnforcementCubit.createUser(
          firstname, lastname, email, 'ATOM_STATIC_USER', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                  AppIcon.closeicon) //Icon(Icons.cancel) //Icon(Icons.cancel)
              )),
      title: Text(
        Constants.newuser,
        style: Styles.textFontSet(18, AppColors.textgreyThemecolor,
            FontWeight.normal, Constants.customFontMediumFamily),
      ),
      backgroundColor: AppColors.backgroundWhitecolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height / 1.8,
          width: width - 50,
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
                          alignment: Alignment.topCenter,
                          child: const Text(
                            Constants.newuserdesc,
                            style: Styles.textStyleRegularGrey16,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            Constants.firstname,
                            style: Styles.textStyleRegularGrey16,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        FlutterInputField(
                          textFieldController: firstnameTextController,
                          textFormKey: Keys.firstnameTextController,
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
                            Constants.lastname,
                            style: Styles.textStyleRegularGrey16,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        FlutterInputField(
                          textFieldController: lastnameTextController,
                          textFormKey: Keys.lastnameTextController,
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
                            Constants.email,
                            style: Styles.textStyleRegularGrey16,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        FlutterInputField(
                          textFieldController: emailTextController,
                          textFormKey: Keys.emailTextController,
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
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
          color: AppColors.backgroundWhitecolor,
          child: createNewuserButton(width)),
    );
  }

  Widget createNewuserButton(double width) {
    return PopButton(
      width: width / 2,
      key: const Key(Keys.createnewuserButton),
      buttonText: Constants.createnewuser,
      buttonTextKey: Keys.createnewuserButtonText,
      boarderColor: AppColors.navigationSkybluecolor,
      backgroundColor: AppColors.navigationSkybluecolor,
      foregroundColor: Colors.white,
      textStyle: Styles.textStyleSemiBold16White,
      onTap: () {
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        if (firstnameTextController.text.isEmpty ||
            lastnameTextController.text.isEmpty ||
            emailTextController.text.isEmpty) {
          Validator().showToast(
            context,
            "Please enter all the required fields",
          );
        } else {
          try {
            _getFoundNewuser(firstnameTextController.text,
                lastnameTextController.text, emailTextController.text);
          } catch (e) {
            // present userwith error message
          }
        }
      },
    );
  }
}
