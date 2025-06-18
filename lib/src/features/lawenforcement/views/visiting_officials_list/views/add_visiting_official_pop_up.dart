import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/lawenforcement/views/visiting_officials_list/bloc/visiting_officials_list_bloc.dart';

class AddVisitingOfficialPopUp extends StatefulWidget {
  const AddVisitingOfficialPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.model,
    required this.mainContext,
    required this.departments,
    required this.showSaveButton,
    // required this.parentIsEligibleToEdit,
  });

  final String title;
  final Function onSubmit;
  final LawVisitingOfficial model;
  final List<Organisation> departments;
  final BuildContext mainContext;
  final bool showSaveButton;
  // final bool parentIsEligibleToEdit;


  @override
  State<AddVisitingOfficialPopUp> createState() =>
      AddVisitingOfficialPopUpState();
}

class AddVisitingOfficialPopUpState extends State<AddVisitingOfficialPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController officeAddressController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  final FocusNode officeAddressFocusNode = FocusNode();

  late List<Organisation> updatedDepartmentList;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.model.name ?? '';
    departmentController.text = widget.model.department?.name ?? '';
    designationController.text = widget.model.designation ?? '';
    officeAddressController.text = widget.model.address ?? '';
    emailIdController.text = widget.model.email ?? '';
    contactNoController.text = widget.model.contactNo ?? '';

    /// updated department list after adding new department
    updatedDepartmentList = widget.departments;
  }

  @override
  Widget build(BuildContext context) {
    VisitingOfficialListState state =
        const VisitingOfficialListState(departments: []);
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
                        state.labels?.locale.visitingOfficialName ??
                            state.labels?.defaultLocale.visitingOfficialName ??
                            Constants.name,
                        //isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: nameController.text,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.nameKey,
                        hintText: '',
                        isEnable: widget.showSaveButton ,
                        isDisableColor: false,
                        onChange: (String value) {
                          log('-widget.contact.rank?.name--value--$value-');
                          widget.model.name = value;
                          log('-widget.contact.rank?.name----${widget.model.name}-');

                          // widget.payRate.perHour = double.parse(value);
                          // BlocProvider.of<PayRateCubit>(widget.mainContext)
                          //     .onModelValueChange(widget.payRate);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Designation
                      CommonWidgets.textDisplay(
                        state.labels?.locale.visitingOfficialDesignation ??
                            state.labels?.defaultLocale
                                .visitingOfficialDesignation ??
                            Constants.designation,
                        //isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: designationController.text,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.nameKey,
                        hintText: '',
                        isEnable: widget.showSaveButton,
                        isDisableColor: false,
                        onChange: (String value) {
                          log('-value--$value-');
                          widget.model.designation = value;
                          log('-widget.model.designation----${widget.model.designation}-');

                          // widget.payRate.perHour = double.parse(value);
                          // BlocProvider.of<PayRateCubit>(widget.mainContext)
                          //     .onModelValueChange(widget.payRate);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Department
                      CommonWidgets.textDisplay(
                        state.labels?.locale.visitingOfficialDepartment ??
                            state.labels?.defaultLocale
                                .visitingOfficialDepartment ??
                            Constants.department,
                        Styles.textStyleBlack14,
                        //  isMandatory: true,
                      ),
                      TextFieldAddButton(
                        title: departmentController.text,
                        height: 70,
                        isDisableColor: !widget.showSaveButton,
                        onTap: () {
                          if (widget.showSaveButton) {
                            BaseOrganisationDialog().departmentDialog(
                                context: context,
                                organisations: updatedDepartmentList,
                                onTap: (Organisation user) {
                                  log('-user.name----${user.name}-');

                                  departmentController.text = user.name ?? '';

                                  widget.model.department ??= Organisation();
                                  widget.model.department = user;
                                  log('-widget.model.department?.name----${widget.model.department?.name}-');

                                  setState(() {});
                                  FocusScope.of(context)
                                      .requestFocus(officeAddressFocusNode);
                                },
                                leftImage: false,
                                orgName: 'ATOM_LEO_DEPARTMENTS',
                                createEntity: true,
                                title: Constants.department,
                                functionToCall: () async {
                                  updatedDepartmentList =
                                      await CommonServices().getOrganisations(
                                    name: 'ATOM_LEO_DEPARTMENTS',
                                  );

                                  // BlocProvider.of<VisitingOfficialListBloc>(
                                  //         context)
                                  //     .add(const RefreshList());
                                });
                          }
                        },
                      ),

                      /// Office Address
                      CommonWidgets.textDisplay(
                        state.labels?.locale.visitingOfficialAddress ??
                            state.labels?.defaultLocale
                                .visitingOfficialAddress ??
                            Constants.officeAddress,
                        //isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: officeAddressController.text,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.nameKey,
                        hintText: '',
                        focusNode: officeAddressFocusNode,
                        isEnable: widget.showSaveButton,
                        isDisableColor: false,
                        onChange: (String value) {
                          log('-value--$value-');
                          widget.model.address = value;
                          log('-widget.model.address----${widget.model.address}-');

                          // widget.payRate.perHour = double.parse(value);
                          // BlocProvider.of<PayRateCubit>(widget.mainContext)
                          //     .onModelValueChange(widget.payRate);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Email Id
                      CommonWidgets.textDisplay(
                        state.labels?.locale.visitingOfficialEmail ??
                            state.labels?.defaultLocale.visitingOfficialEmail ??
                            Constants.emailId,
                        //isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: emailIdController.text,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.nameKey,
                        hintText: '',
                        isEnable: widget.showSaveButton,
                        isDisableColor: false,
                        onChange: (String value) {
                          log('-value--$value-');
                          widget.model.email = value;
                          log('-widget.model.email----${widget.model.email}-');

                          // widget.payRate.perHour = double.parse(value);
                          // BlocProvider.of<PayRateCubit>(widget.mainContext)
                          //     .onModelValueChange(widget.payRate);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// Contact No
                      CommonWidgets.textDisplay(
                        state.labels?.locale.visitingOfficialContactNo ??
                            state.labels?.defaultLocale
                                .visitingOfficialContactNo ??
                            Constants.phoneNumber,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: widget.model.contactNo ?? '',
                        textInputType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable: widget.showSaveButton,
                        characterLimit: Constants.characterLimitContactNo,
                        isDisableColor: false,
                        onChange: (String value) {
                          log('-widget.contact.rank?.name--value--$value-');
                          widget.model.contactNo = value;
                          log('contactNo---${widget.model.contactNo?.length != 10}-');
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
        if (widget.showSaveButton) ...[saveButton(width, widget.onSubmit)],
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
    if (widget.model.name.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter Name.');
    }
    if (widget.model.designation.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Designation');
    }
    if (widget.model.department?.name == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Department');
    }
    if (widget.model.address == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Office Address');
    }

    // if (widget.model.contactNo.isEmptyOrNull) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Phone Number.');
    // }

    if (!widget.model.email.isEmptyOrNull &&
        !EmailValidator.validate(widget.model.email!)) {
      return const ErrorResponse(
        status: false,
        message: 'Please enter a valid email.',
      );
    }
    if ((!Utils().isNumeric(widget.model.contactNo!) ||
            widget.model.contactNo!.length < 10 ||
            widget.model.contactNo!.length > 17) &&
        !widget.model.contactNo.isEmptyOrNull) {
      return const ErrorResponse(
        status: false,
        message: 'Please enter a valid contact number.',
      );
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
