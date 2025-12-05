import 'dart:developer';

import 'package:db_atom/index.dart';

class AddContactPopUp extends StatefulWidget {
  const AddContactPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.model,
    required this.mainContext,
    required this.users,
    required this.rankType,
    this.contactDetailModel,
    this.parentStatus,
    this.lock,
  });

  final String title;
  final Function onSubmit;
  final ContactRecord model;
  final List<Organisation> users;
  final BuildContext mainContext;
  final String rankType;
  final ContactDetailModel? contactDetailModel;
  final int? parentStatus;
  final String? lock;

  @override
  State<AddContactPopUp> createState() => AddContactPopUpState();
}

class AddContactPopUpState extends State<AddContactPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController rankController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController escalationLevelController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  String name = Constants.name;
  String rank = Constants.rank;
  bool isReadonly = true;

  @override
  void initState() {
    super.initState();

    log('---widget.rankType---${widget.rankType}-----');
    rankController.text = widget.model.rank?.name ?? '';
    nameController.text = widget.model.email ?? '';
    stateController.text = widget.model.state ?? '';
    contactNoController.text = widget.model.contactNo ?? '';

    if (widget.model.escalationLevel != null) {
      Label matchingLabel = escalationLevelDropDownValues.firstWhere(
          (label) => label.value == widget.model.escalationLevel.toString());

      escalationLevelController.text = matchingLabel.key;
    }
    if (widget.rankType == Constants.contactZone) {
      name = Constants.areaNameManager;
    }

    if (widget.rankType == Constants.contactGuardingAgencyEscalationRank) {
      name = Constants.name;
      rank = Constants.guardingAgencyRank;
    }

    if (widget.rankType == Constants.contactSupervisorRank) {
      rank = Constants.supervisorRank;
    }
    if (widget.rankType == Constants.contactZone) {
      rank = Constants.zone;
    }

    if (widget.rankType == Constants.contactSystemEscalationRank) {
      rank = Constants.systemSiEscalationMatrixRank;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isInteractionDisabled = widget.parentStatus != null &&
        widget.parentStatus != 0 &&
        widget.parentStatus != 1 &&
        widget.lock != null;

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      // insetPadding: ,
      title: null,

      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.newColor3.withValues(alpha: 0.7),
                AppColors.newColor,
                AppColors.newColor3.withValues(alpha: 0.7),
                // Color(0xFF6474C6).withOpacity(0.14)
              ],
              stops: [0.02, 0.35, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(27),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.6),
              width: 0.7,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.0),
                blurRadius: 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SizedBox(
            height: height / 1.8,
            width: width,
            child: Column(
              // clipBehavior: Clip.none,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    style: Styles.textFontSet(18, AppColors.white,
                        FontWeight.normal, Constants.customFontSemiBoldFamily),
                  ),
                ),
                CommonWidgets.verticalSpacerWidget(height * 0.01),
                const Divider(
                  thickness: 0.5,
                ),
                CommonWidgets.verticalSpacerWidget(height * 0.01),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            children: [
                              /// Rank
                              CommonWidgets.textDisplay(
                                rank,
                                Styles.textStyleWhite16,
                                //  isMandatory: true,
                              ),
                              TextFieldAddButton(
                                title: rankController.text,
                                height: 70,
                                isDisableColor: true,
                                onTap: () {
                                  // if(isReadonly){
                                  //   BaseOrganisationDialog().departmentDialog(
                                  //       context: widget.mainContext,
                                  //       organisations: widget.users,
                                  //       onTap: (Organisation user) {
                                  //         log('-user.name----${user.name}-');
                                  //
                                  //         rankController.text = user.name ?? '';
                                  //
                                  //         widget.model.rank ??= Organisation();
                                  //         widget.model.rank = user;
                                  //         log('-widget.contact.rank?.name----${widget.model.rank?.name}-');
                                  //
                                  //         setState(() {});
                                  //         FocusScope.of(context)
                                  //             .requestFocus(nameFocusNode);
                                  //       },
                                  //       orgName: widget.rankType ==
                                  //           Constants.contactGeneralRank
                                  //           ? 'CONTACT_GENERAL_RANK'
                                  //           : widget.rankType ==
                                  //           Constants
                                  //               .contactGuardingAgencyEscalationRank
                                  //           ? 'CONTACT_GUARDING_AGENCY_ESCALATION_RANK'
                                  //           : widget.rankType ==
                                  //           Constants.contactZone
                                  //           ? 'CONTACT_ZONE'
                                  //           : widget.rankType ==
                                  //           Constants
                                  //               .contactSystemEscalationRank
                                  //           ? 'CONTACT_SYSTEM_ESCALATION_RANK'
                                  //           : 'CONTACT_SUPERVISOR_RANK',
                                  //       createEntity: false,
                                  //       title: widget.rankType ==
                                  //           Constants.contactZone
                                  //           ? Constants.zone
                                  //           : widget.rankType ==
                                  //           Constants.contactGeneralRank
                                  //           ? Constants.rank
                                  //           : widget.rankType ==
                                  //           Constants
                                  //               .contactSystemEscalationRank
                                  //           ? Constants
                                  //           .systemSiEscalationMatrixRank
                                  //           : widget.rankType ==
                                  //           Constants
                                  //               .contactSupervisorRank
                                  //           ? Constants.supervisorRank
                                  //           : Constants
                                  //           .guardingAgencyRank,
                                  //       functionToCall: () {
                                  //         log('---functionToCall----');
                                  //         BlocProvider.of<ContactRecordBloc>(
                                  //             widget.mainContext)
                                  //             .add(
                                  //           const RefreshContactRecordsList(),
                                  //         );
                                  //       });
                                  // }
                                },
                              )
                            ],
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// State
                          if (widget.rankType == Constants.contactZone) ...[
                            CommonWidgets.textDisplay(
                              Constants.state,
                              //isMandatory: true,
                              Styles.textStyleWhite16,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            FlutterInputField(
                              initialValue: stateController.text,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.nameKey,
                              hintText: '',
                              focusNode: nameFocusNode,
                              isEnable: false,
                              isDisableColor: true,
                              onChange: (String value) {
                                log('-widget.contact.rank?.state--value--$value-');
                                widget.model.state = value;
                                log('-widget.contact.rank?.state----${widget.model.state}-');
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Escalation Level
                            CommonWidgets.textDisplay(
                                Constants.escalationLevel,
                                //isMandatory: true,
                                Styles.textStyleWhite16),
                            BaseDropDown().getDropDown(
                              isDisabled: true,
                              textController: escalationLevelController,
                              items: escalationLevelDropDownValues,
                              onTap: () {
                                // BaseDropDown().assetTypeDialog(
                                //   context: context,
                                //   dropDownValues: escalationLevelDropDownValues
                                //       .map((label) => label.key)
                                //       .toList(),
                                //   onTap: (String value) {
                                //     Label? selectedLabel;
                                //     selectedLabel =
                                //         escalationLevelDropDownValues.firstWhere(
                                //               (label) => label.key == value,
                                //           orElse: () =>
                                //           const Label(key: '', value: ''),
                                //         );
                                //     widget.model.escalationLevel =
                                //         int.tryParse(selectedLabel.value);
                                //     escalationLevelController.text =
                                //         selectedLabel.key;
                                //     setState(() {});
                                //   },
                                // );
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],

                          /// Name
                          CommonWidgets.textDisplay(
                            name,
                            //isMandatory: true,
                            Styles.textStyleWhite16,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          FlutterInputField(
                            initialValue: nameController.text,
                            textInputType: TextInputType.text,
                            textFormKey: Keys.nameKey,
                            hintText: '',
                            isEnable: false,
                            focusNode: widget.rankType != Constants.contactZone
                                ? nameFocusNode
                                : null,
                            isDisableColor: true,
                            onChange: (String value) {
                              log('-widget.contact.rank?.name--value--$value-');
                              widget.model.email = value;
                              log('-widget.contact.rank?.name----${widget.model.email}-');

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
                            Styles.textStyleWhite16,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          FlutterInputField(
                            initialValue: widget.model.contactNo ?? '',
                            textInputType: TextInputType.number,
                            textFormKey: Keys.phoneNumberKey,
                            hintText: '',
                            isEnable: false,
                            characterLimit: Constants.characterLimitContactNo,
                            isDisableColor: true,
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
                ),
              ],
            ),
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
      ],
    );
  }

  Widget cancelButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButtonText,
      foregroundColor: AppColors.white,
      textStyle: Styles.styleHeaderGreyText16,
      backgroundColor: const Color(0xFF071130),
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
      backgroundColor: const Color(0xFF071130),
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
    if (widget.model.rank?.name == null) {
      return ErrorResponse(
          status: false,
          message: widget.rankType == Constants.contactZone
              ? 'Please enter Zone.'
              : 'Please enter Rank.');
    }
    if (widget.model.email.isEmptyOrNull) {
      return ErrorResponse(
          status: false,
          message: widget.rankType == Constants.contactZone
              ? 'Please enter Area  Manager Name.'
              : 'Please enter Name.');
    }
    if (widget.rankType == Constants.contactZone) {
      if (widget.model.state.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter State.');
      }
      if (widget.model.escalationLevel == null) {
        return const ErrorResponse(
            status: false, message: 'Please enter Escalation Level.');
      }
    }
    if (!widget.model.contactNo.isEmptyOrNull &&
        (!Utils().isNumeric(widget.model.contactNo!) ||
            widget.model.contactNo!.length > 17 ||
            widget.model.contactNo!.length < 10)) {
      return const ErrorResponse(
        status: false,
        message: 'Please enter a valid contact Number.',
      );
    }
    // if (widget.contact.contactNo.isEmptyOrNull) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Contact No.');
    // }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
