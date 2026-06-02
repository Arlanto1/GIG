import 'package:db_atom/index.dart';

class AddNewFields extends StatefulWidget {
  const AddNewFields({
    super.key,
    required this.title,
    this.lawEnforcementState,
    this.createFoundState,
    this.createPassmgmtState,
    this.payRateState,
    this.entityFun,
  });

  final String title;
  final LawEnforcementState? lawEnforcementState;
  final CreateFoundState? createFoundState;
  final CreatePassMgmtState? createPassmgmtState;
  final PayRateState? payRateState;
  final Function? entityFun;

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
    if (widget.lawEnforcementState != null) {
      if (widget.title == Constants.addcompanytype) {
        await lawEnforcementCubit.createOrganisation(
            name, 'ATOM_COMPANY_TYPES', context, widget.title);
      } else if (widget.title == Constants.addreasonfordaypass ||
          widget.title == Constants.addreasonforvendorpass) {
        await lawEnforcementCubit.createOrganisation(
            name, 'DAY_PASS_REASON', context, widget.title);
      } else if (widget.title == Constants.addentitytype) {
        await lawEnforcementCubit.createOrganisation(
            name, 'ATOM_ENTITIES', context, widget.title);
      } else if (widget.title == Constants.addpurposeofvisittype) {
        await lawEnforcementCubit.createOrganisation(
            name, 'ATOM_LEO_PURPOSE_VISIT', context, widget.title);
      } else if (widget.title == Constants.addleoofficialtype) {
        await lawEnforcementCubit.createOrganisation(
            name, 'ATOM_LEO_DEPARTMENTS', context, widget.title);
      }
    } else if (widget.createPassmgmtState != null) {
      if (widget.title == Constants.addcompanytype) {
        await createPassMgmtCubit.createOrganisation(
            name, 'ATOM_COMPANY_TYPES', context, widget.title);
      } else if (widget.title == Constants.addreasonfordaypass) {
        await createPassMgmtCubit.createOrganisation(
            name, 'DAY_PASS_REASON', context, widget.title);
      } else if (widget.title == Constants.addreasonforvendorpass) {
        await createPassMgmtCubit.createOrganisation(
            name, 'VENDOR_PASS_REASON', context, widget.title);
      } else if (widget.title == Constants.addentitytype) {
        await createPassMgmtCubit.createOrganisation(
            name, 'ATOM_ENTITIES', context, widget.title);
      }
    } else if (widget.payRateState != null) {
      await createPassMgmtCubit.createOrganisation(
          name, 'ATOM_ENTITIES', context, widget.title);
    }
  }

  void _createEmployeeDepartment(String name, String key) async {
    showLoadingDialog(context);
    if (widget.lawEnforcementState != null) {
      await lawEnforcementCubit.createEmployeeDepartments(
          name, 'EMPLOYEE_DEPARTMENTS', context);
    } else if (widget.createFoundState != null) {
      await createFoundArticleCubit.createEmployeeDepartments(
          name, 'EMPLOYEE_DEPARTMENTS', context);
    } else if (widget.createPassmgmtState != null) {
      await createPassMgmtCubit.createEmployeeDepartments(
          name, 'EMPLOYEE_DEPARTMENTS', context);
    }
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
      backgroundColor: AppColors.backgroundWhiteColor,
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
                          child: CommonWidgets.textDisplay(
                            Constants.name,
                            Styles.textStyleBlack14,
                            isMandatory: true,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
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
                            style: Styles.textStyleGrey16,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
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
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Description',
                            style: Styles.textStyleGrey16,
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
                            style: Styles.textStyleGrey16,
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
                            style: Styles.textStyleGrey16,
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
      onTap: () {
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        if (nameTextController.text.isEmpty) {
          Validator().showToast(
            context,
            "Please enter the name",
          );
        }
        else {
          try {
            if (Constants.addcompanytype == widget.title ||
                Constants.addreasonfordaypass == widget.title ||
                Constants.addreasonforvendorpass == widget.title ||
                Constants.addentitytype == widget.title ||
                Constants.addpurposeofvisittype == widget.title ||
                Constants.addleoofficialtype == widget.title) {
              _addCompany(nameTextController.text, keyTextController.text);
            } else if (Constants.addEmployeeDepartment == widget.title) {
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
