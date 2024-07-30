import 'package:db_atom/index.dart';

class BaseAddUserDialog extends StatefulWidget {
  const BaseAddUserDialog({
    super.key,
    required this.title,
    required this.functionToCall,
    required this.roleName,
    required this.locationId,
  });

  final String title;
  final Function functionToCall;
  final String roleName;
  final int locationId;

  @override
  State<BaseAddUserDialog> createState() => BaseAddUserDialogState();
}

class BaseAddUserDialogState extends State<BaseAddUserDialog> {
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
                        FlutterInputField(
                          controller: emailTextController,
                          textFormKey: Keys.emailTextController,
                          textCapitalization: false,
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
      alignment: Alignment.bottomCenter,
      child: Container(
          color: AppColors.backgroundWhiteColor,
          child: createNewUserButton(width)),
    );
  }

  Widget createNewUserButton(double width) {
    return PopButton(
      width: width / 2,
      key: const Key(Keys.createnewuserButton),
      buttonText: Constants.createnewuser,
      buttonTextKey: Keys.createnewuserButtonText,
      boarderColor: AppColors.navigationSkyBlueColor,
      backgroundColor: AppColors.navigationSkyBlueColor,
      foregroundColor: Colors.white,
      textStyle: Styles.textStyleSemiBold16White,
      onTap: () async {
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
          var sca = ScaffoldMessenger.of(context);
          try {
            var nav = Navigator.of(context);
            CreateUserModel createUserData = await CommonServices().createUser(
              firstName: firstnameTextController.text,
              lastName: lastnameTextController.text,
              email: emailTextController.text,
              role: widget.roleName,
              locationId: widget.locationId,
              context: context,
            );

            nav.pop();
            widget.functionToCall();

            sca.showSnackBar(
              const SnackBar(
                content: Text('Added Successfully.'),
                duration: Duration(seconds: 3), // Adjust the duration
              ),
            );
          }  on GenericResponse catch (e) {
            sca.showSnackBar(
               SnackBar(backgroundColor: Colors.red,
                content: Text('${e.message}'),
                duration: const Duration(seconds: 3), // Adjust the duration
              ),
            );
            return;
          } on Exception catch (e) {
            sca.showSnackBar(
               SnackBar(
                content: Text('$e'),
                duration: const Duration(seconds: 3), // Adjust the duration
              ),
            );
          }
        }
      },
    );
  }
}
