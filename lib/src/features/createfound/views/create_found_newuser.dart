import 'dart:developer';

import 'package:db_atom/index.dart';

import '../../passmanagement/daypassmgmt/createpassmgmt/services/create_pass_mgmt_services.dart';

class CreateFoundNewUser extends StatefulWidget {
  //const CreateFoundNewUser({super.key});
  const CreateFoundNewUser({
    super.key,
    required this.title,
    this.lawstate,
    this.createoundstate,
    this.createpassmgmtstate,
    required this.locationId,
    this.isDbUser = false,
  });

  final String title;
  final LawEnforcementState? lawstate;
  final CreateFoundState? createoundstate;
  final CreatePassMgmtState? createpassmgmtstate;
  final int locationId;
  final bool isDbUser;

  @override
  State<CreateFoundNewUser> createState() => CreateFoundNewUserState();
}

class CreateFoundNewUserState extends State<CreateFoundNewUser> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstnameTextController = TextEditingController();
  TextEditingController lastnameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  CreatePassMgmtService createpassmgmtServices = CreatePassMgmtService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getFoundNewuser();
  }

  void _getFoundNewuser(
      String firstname, String lastname, String email, int locationId) async {
    showLoadingDialog(context);
    if (widget.createoundstate != null) {
      log('---_getFoundNewuser------');
      await createFoundArticleCubit.createUser(
          firstname, lastname, email, 'ATOM_STATIC_USER', locationId, context);
    } else if (widget.createpassmgmtstate != null) {
      CreatePassMgmtCubit createPassMgmtCubit = CreatePassMgmtCubit(
          createpassmgmtServices:
              createpassmgmtServices); // Instantiate CreatePassMgmtCubit
      await createPassMgmtCubit.createUser(
          firstname, lastname, email, 'ATOM_STATIC_USER', locationId, context);
    } else if (widget.lawstate != null) {
      await lawEnforcementCubit.createUser(
          firstname, lastname, email, 'ATOM_STATIC_USER', locationId, context);
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
      surfaceTintColor: Colors.white,
      title: Text(
        Constants.newuser,
        style: Styles.textFontSet(18, AppColors.textGreyThemeColor,
            FontWeight.normal, Constants.customFontMediumFamily),
      ),
      backgroundColor: AppColors.backgroundWhiteColor,
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
                          controller: firstnameTextController,
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
                          controller: lastnameTextController,
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
                        if (!widget.isDbUser) ...[
                          FlutterInputField(
                            controller: emailTextController,
                            textFormKey: Keys.emailTextController,
                            textCapitalization: false,
                            hintText: '',
                            onChange: (String username) {
                              //this.username = username;
                              setState(() {});
                            },
                            validateTextField: (String? username) {
                              if (!Validator.isValidEmail(username)) {
                                return Constants.enterValidEmail;
                              }
                            },
                          )
                        ],
                        if (widget.isDbUser) ...[
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 200,
                                child: FlutterInputField(
                                  controller: emailTextController,
                                  textFormKey: Keys.emailTextController,
                                  textCapitalization: false,
                                  hintText: '',
                                  onChange: (String username) {
                                    //this.username = username;
                                    setState(() {});
                                  },
                                  validateTextField: (String? username) {
                                    if (!Validator.isValidEmail(username)) {
                                      return Constants.enterValidEmail;
                                    }
                                  },
                                ),
                              ),
                              const Text(dbEmailId)
                            ],
                          )
                        ],
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
          color: AppColors.backgroundWhiteColor,
          child: createNewuserButton(width)),
    );
  }

  Widget createNewuserButton(double width) {
    return PopButton(
      width: width / 1,
      key: const Key(Keys.createnewuserButton),
      buttonText: Constants.createnewuser,
      buttonTextKey: Keys.createnewuserButtonText,
      boarderColor: AppColors.navigationSkyBlueColor,
      backgroundColor: AppColors.navigationSkyBlueColor,
      foregroundColor: Colors.white,
      textStyle: Styles.textStyleSemiBold16White,
      onTap: () {

        late String dbEmail;
        if (widget.isDbUser) {
          dbEmail = '${emailTextController.text}@db.com';
        }
        log('--onTap---$dbEmail');
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        if (firstnameTextController.text.isEmpty ||
            lastnameTextController.text.isEmpty ||
            emailTextController.text.isEmpty) {
          Validator().showToast(
            context,
            "Please enter all the required fields",
          );

        } else if (widget.isDbUser && !Validator.isValidEmail(dbEmail)) {
          Validator().showToast(context, Constants.enterValidEmail);
        } else if (!widget.isDbUser &&
            !emailTextController.text.isEmptyOrNull &&
            !Validator.isValidEmail(emailTextController.text)) {
          Validator().showToast(context, Constants.enterValidEmail);
        } else {
          try {
            _getFoundNewuser(
                firstnameTextController.text,
                lastnameTextController.text,
                widget.isDbUser == true ? dbEmail : emailTextController.text,
                widget.locationId);
          } catch (e) {
            // present userwith error message
          }
        }
      },
    );
  }
}
