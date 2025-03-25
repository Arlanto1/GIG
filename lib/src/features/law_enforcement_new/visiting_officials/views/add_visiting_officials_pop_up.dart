
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/sla_violation_penalty/violation_penalty_record/bloc/violation_penalty_record_bloc.dart';
import 'package:db_atom/src/features/law_enforcement_new/visiting_officials/bloc/visiting_officials_bloc.dart';

class AddVisitingOfficialsPopUp extends StatefulWidget {
  const AddVisitingOfficialsPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.model,
    required this.mainContext,
    // required this.departments,
    required this.isLocked,
    this.parentStatus,
  });

  final String title;
  final Function onSubmit;
  final VisitingOfficialsModel model;
  final BuildContext mainContext;
  // final List<Organisation> departments;
  final int? parentStatus;
  final bool isLocked;

  @override
  State<AddVisitingOfficialsPopUp> createState() => _AddVisitingOfficialsPopUpState();
}

class _AddVisitingOfficialsPopUpState extends State<AddVisitingOfficialsPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController officeAddressController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController contactNumController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();

  bool isReadonly = false;

  late List<Organisation> updatedDepartmentList;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.model.name ?? '';
    departmentController.text = widget.model.department?.name ?? '';
    designationController.text = widget.model.designation ?? '';
    officeAddressController.text = widget.model.address ?? '';
    emailIdController.text = widget.model.email ?? '';
    contactNumController.text = widget.model.contactNo ?? '';

    /// updated department list after adding new department
    // updatedDepartmentList = widget.departments;    //

  }

  @override
  Widget build(BuildContext context) {
    VisitingOfficialsState state = const VisitingOfficialsState();
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
        if (widget.parentStatus == ConstantsIntValue.lawDistributedStatus ||
            widget.parentStatus == ConstantsIntValue.cancelledStatus) {
          isReadonly = true;
        }
        if (widget.isLocked) {
          isReadonly = true;
        }
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

                      /// Name
                      CommonWidgets.textDisplay(
                        // state.labels?.locale.totalViolations ??
                        //     state.labels?.defaultLocale.totalViolations ??
                            Constants.name,
                        Styles.textStyleBlack14,
                        //isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        // initialValue: '${widget.model.totalViolations ?? ''}',
                        textInputType: TextInputType.text,
                        controller: nameController,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable:!isReadonly,
                        isDisableColor: false,
                        onChange: (String value) {
                          // widget.model.totalViolations = num.parse(value);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Designation
                      CommonWidgets.textDisplay(
                        // state.labels?.locale.totalViolations ??
                        //     state.labels?.defaultLocale.totalViolations ??
                        Constants.designation,
                        Styles.textStyleBlack14,
                        //isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        // initialValue: '${widget.model.totalViolations ?? ''}',
                        textInputType: TextInputType.text,
                        controller: designationController ,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable: !isReadonly,
                        isDisableColor: false,
                        onChange: (String value) {
                          // widget.model.totalViolations = num.parse(value);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Department
                      CommonWidgets.textDisplay(
                        // state.labels?.locale.visitingOfficialDepartment ??
                        //     state.labels?.defaultLocale
                        //         .visitingOfficialDepartment ??
                            Constants.department,
                        Styles.textStyleBlack14,
                        //  isMandatory: true,
                      ),
                      TextFieldAddButton(
                        title: departmentController.text,
                        height: 70,
                        isDisableColor: false,
                        onTap: () {
                          // if (widget.showSaveButton) {
                          BaseOrganisationDialog().departmentDialog(
                            context: context,
                            organisations: updatedDepartmentList ?? [],
                            onTap: (Organisation dep) {
                              departmentController.text = dep.name ?? '';
                              widget.model.department ??= Organisation();
                              widget.model.department = dep;
                              setState(() {});
                            },
                            leftImage: false,
                            orgName: 'ATOM_LEO_DEPARTMENTS',
                            createEntity: true,
                            title: Constants.department,
                            functionToCall: () async {
                              updatedDepartmentList = await CommonServices().getOrganisations(
                                name: 'ATOM_LEO_DEPARTMENTS',
                              );
                              setState(() {}); // Refresh UI after fetching data
                            },
                          );

                          // }
                        },
                      ),



                      /// Office Address
                      CommonWidgets.textDisplay(
                        // state.labels?.locale.totalViolations ??
                        //     state.labels?.defaultLocale.totalViolations ??
                        Constants.officeAddress,
                        Styles.textStyleBlack14,
                        //isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        // initialValue: '${widget.model.totalViolations ?? ''}',
                        textInputType: TextInputType.text,
                        // controller: totalNoOfViolationsController,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable: !isReadonly,
                        isDisableColor: false,
                        onChange: (String value) {
                          widget.model.address = value;
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Email Id
                      CommonWidgets.textDisplay(
                        // state.labels?.locale.totalViolations ??
                        //     state.labels?.defaultLocale.totalViolations ??
                            Constants.emailId,
                        Styles.textStyleBlack14,
                        //isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        // initialValue: '${widget.model.totalViolations ?? ''}',
                        textInputType: TextInputType.text,
                        // controller: totalNoOfViolationsController,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable: !isReadonly,
                        isDisableColor: false,
                        onChange: (String value) {
                          widget.model.email = value;
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Contact Num
                      CommonWidgets.textDisplay(
                        // state.labels?.locale.c ??
                        //     state.labels?.defaultLocale.totalPenaltyAmount ??
                            Constants.contactNo,
                        Styles.textStyleBlack14,
                        //isMandatory: true,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        textInputType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        controller: contactNumController,
                        hintText: '',
                        isEnable: false,
                        isDisableColor: true,
                        onChange: (String value) {
                          widget.model.contactNo = value;
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
        if (!isReadonly) ...[saveButton(width, widget.onSubmit)]
      ],
    );
  }

  Widget cancelButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.close,
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

  ErrorResponse get isFormValid {
    // if (widget.model.violation == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Violation.');
    // }
    // if (widget.model.staffCategory == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Staff Category.');
    // }
    // if (widget.model.totalViolations == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Total No of Violations');
    // }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
