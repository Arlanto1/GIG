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
  });

  final String title;
  final Function onSubmit;
  final ContactRecord model;
  final List<Organisation> users;
  final BuildContext mainContext;
  final String rankType;

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

  @override
  void initState() {
    super.initState();

    log('---widget.contact.state---${widget.model.state}-----');
    rankController.text = widget.model.rank?.name ?? '';
    nameController.text = widget.model.email ?? '';
    stateController.text = widget.model.state ?? '';
    contactNoController.text = widget.model.contactNo ?? '';

    if(widget.model.escalationLevel != null) {
      Label matchingLabel = escalationLevelDropDownValues.firstWhere(
              (label) =>
          label.value == widget.model.escalationLevel.toString());

      escalationLevelController.text = matchingLabel.key;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      Column(
                        children: [
                          /// Rank
                          CommonWidgets.textDisplay(
                            widget.rankType == Constants.contactZone
                                ? Constants.zone
                                : Constants.rank,
                            Styles.textStyleBlack14,
                            isMandatory: true,
                          ),
                          TextfieldAddButton(
                            title: rankController.text,
                            height: 70,
                            isDisableColor: false,
                            onTap: () {
                              BaseOrganisationDialog().userDialog(
                                context: context,
                                entities: widget.users,
                                onTap: (Organisation user) {
                                  log('-user.name----${user.name}-');

                                  rankController.text = user.name ?? '';

                                  widget.model.rank ??= Organisation();
                                  widget.model.rank = user;
                                  log('-widget.contact.rank?.name----${widget.model.rank?.name}-');

                                  setState(() {});
                                  // BlocProvider.of<ContactListingBloc>(context)
                                  //     .updateApproverEmailsValue(
                                  //         approver1EmailUser: user);
                                },

                              );
                            },
                          )
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      /// State
                      if (widget.rankType == Constants.contactZone) ...[
                        CommonWidgets.textDisplay(
                          Constants.state,
                          isMandatory: true,
                          Styles.textStyleBlack14,
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        FlutterInputField(
                          initialValue: stateController.text,
                          textInputType: TextInputType.text,
                          textFormKey: Keys.nameKey,
                          hintText: '',
                          isEnable: true,
                          isDisableColor: false,
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
                            isMandatory: true,
                            Styles.textStyleBlack14),
                        BaseDropDown().getDropDown(
                          isDisabled: true,
                          textController: escalationLevelController,
                          items: escalationLevelDropDownValues,
                          onTap: () {
                            BaseDropDown().assetTypeDialog(
                              context: context,
                              dropDownValues: escalationLevelDropDownValues
                                  .map((label) => label.key)
                                  .toList(),
                              onTap: (String value) {
                                Label? selectedLabel;
                                selectedLabel =
                                    escalationLevelDropDownValues.firstWhere(
                                  (label) => label.key == value,
                                  orElse: () => const Label(key: '', value: ''),
                                );
                                widget.model.escalationLevel =
                                    int.tryParse(selectedLabel.value);
                                escalationLevelController.text =
                                    selectedLabel.key;
                                setState(() {});
                              },
                            );
                          },
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                      ],

                      /// Name
                      CommonWidgets.textDisplay(
                        widget.rankType == Constants.contactZone
                            ? Constants.areaNameManager
                            : Constants.name,
                        isMandatory: true,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: nameController.text,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.nameKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
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
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        initialValue: widget.model.contactNo ?? '',
                        textInputType: TextInputType.number,
                        textFormKey: Keys.phoneNumberKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          log('-widget.contact.rank?.name--value--$value-');
                          widget.model.contactNo = value;
                          log('-widget.contact.contactNo?.name----${widget.model.contactNo}-');
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
        saveButton(width, widget.onSubmit)
      ],
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
      backgroundColor: AppColors.white,
      boarderColor: AppColors.textgreyThemecolor,
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
      boarderColor: AppColors.navigationSkybluecolor,
      backgroundColor: AppColors.navigationSkybluecolor,
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
              ? 'Please enter Area Name Manager.'
              : 'Please enter Name.');
    }
    if (widget.rankType == Constants.contactZone) {
      if (widget.model.state.isEmptyOrNull) {
        return const ErrorResponse(
            status: false, message: 'Please enter Name.');
      }
      if (widget.model.escalationLevel == null) {
        return const ErrorResponse(
            status: false, message: 'Please enter Escalation Level.');
      }
    }
    // if (widget.contact.contactNo.isEmptyOrNull) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter Contact No.');
    // }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
