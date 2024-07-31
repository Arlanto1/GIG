import 'dart:developer';

import 'package:db_atom/index.dart';

class BaseAddOrganisationDialog extends StatefulWidget {
  const BaseAddOrganisationDialog({
    super.key,
    required this.title,
    required this.orgName,
    required this.functionToCall,
    this.createEntity,
  });

  final String title;
  final String orgName;
  final Function functionToCall;
  final bool? createEntity;

  @override
  State<BaseAddOrganisationDialog> createState() =>
      BaseAddOrganisationDialogState();
}

class BaseAddOrganisationDialogState extends State<BaseAddOrganisationDialog> {
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: Styles.textFontSet(18, AppColors.textGreyThemeColor,
              FontWeight.normal, Constants.customFontSemiBoldFamily),
        ),
      ),
      surfaceTintColor: Colors.white,
      // backgroundColor: AppColors.backgroundWhitecolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height / 1.82,
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
                        FlutterInputField(
                          controller: nameTextController,
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
                        FlutterInputField(
                          controller: keyTextController,
                          textFormKey: Keys.keyTextController,
                          hintText: '',
                          onChange: (String username) {
                            //this.username = username;
                            setState(() {});
                          },
                          validateTextField: (String? user) {},
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.03),
                        if (widget.createEntity ?? true) ...[
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
                            controller: descriptionTextController,
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
                            controller: optionsTextController,
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
                            controller: weightTextController,
                            textFormKey: Keys.keyTextController,
                            hintText: '',
                            onChange: (String username) {
                              //this.username = username;
                              setState(() {});
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.03),
                        ],
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
      color: AppColors.backgroundWhiteColor,
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
      foregroundColor: AppColors.textGreyThemeColor,
      textStyle: Styles.styleHeaderGreyText16,
      boarderColor: AppColors.textGreyThemeColor,
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
      boarderColor: AppColors.navigationSkyBlueColor,
      backgroundColor: AppColors.navigationSkyBlueColor,
      foregroundColor: Colors.white,
      textStyle: Styles.textStyleSemiBold16White,
      onTap: () async {
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        if (nameTextController.text.isEmpty) {
          Validator().showToast(
            context,
            "Please enter the name",
          );
        } else {
          var sca = ScaffoldMessenger.of(context);
          try {
            var nav = Navigator.of(context);
            var createOrganisation = await CommonServices().createOrganisation(
                name: nameTextController.text,
                keyname: keyTextController.text,
                orgName: widget.orgName);

            log('-createOrganisation---${createOrganisation.toString()}--');
            nav.pop();
            widget.functionToCall();

            sca.showSnackBar(
              const SnackBar(
                content: Text('Added Successfully.'),
                duration: Duration(seconds: 3), // Adjust the duration
              ),
            );
          } on GenericResponse catch (e) {
            sca.showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
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
