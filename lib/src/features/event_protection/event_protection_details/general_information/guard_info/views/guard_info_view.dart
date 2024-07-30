import 'dart:developer';

import 'package:db_atom/index.dart';

class GuardInfoView extends StatefulWidget {
  final GuardInfoModel? guardInfoModel;

  const GuardInfoView({
    super.key,
    this.guardInfoModel,
  });

  @override
  State<GuardInfoView> createState() => _GuardInfoViewState();
}

class _GuardInfoViewState extends State<GuardInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  List<ImageContent>? getFiles;
  List<ImageContent>? guardFiles;
  TextEditingController eventStartDateController = TextEditingController();
  TextEditingController dateOfJoiningController = TextEditingController();

  TextEditingController statusController = TextEditingController();

  bool isDisabled = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GuardInfoCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<GuardInfoCubit, GuardInfoState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Guard Info Detail',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                guardingMasterDataRoute,
                arguments: {},
              );
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: '2222',
            showPopUp: false,
            showSaveButton: state.guardInfoModel.status != 4 ? true : false,
            showSubmitButton: state.guardInfoModel.status != 4 ? true : false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<GuardInfoCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<GuardInfoCubit>(context)
                  .submitForm(isSaveOnly: false);
            },
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  getBodybuilder(GuardInfoState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    return Container(
      color: AppColors.navigationSkyBlueColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkyBlueColor,
            ),
            Container(
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  )),
              child: Form(
                key: _formKey,
                autovalidateMode: state.guardInfoModel.status == 4
                    ? AutovalidateMode.disabled
                    : AutovalidateMode.onUserInteraction,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Column(children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              Constants.generalinformation,
                              style: Styles.styleHeaderGreyText16,
                            ),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /*   /// Status
                          CommonWidgets.textDisplay(
                              Constants.status, Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDropDown().getDropDown(
                              isDisabled: state.guardInfoModel.status != 6,
                              textController: statusController,
                              items: statusDropDownValues,
                              initialValue:
                                  '${state.guardInfoModel.status ?? 1}',
                              onTap: () {
                                if (state.guardInfoModel.id != null) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: statusDropDownValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          statusDropDownValues.firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      BlocProvider.of<GuardInfoCubit>(context)
                                          .updateDropdownValues(
                                              status: int.tryParse(
                                                  selectedLabel.value));
                                    },
                                  );
                                }
                              }),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
*/

                          ///Guarding Vendor Id
                          CommonWidgets.textDisplay(Constants.guardingVendorId,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue: state.guardInfoModel.vendorId,
                            textFormKey: Keys.vendorIdKey,
                            hintText: '',
                            isEnable: widget.guardInfoModel == null
                                ? true
                                : (widget.guardInfoModel != null &&
                                        (widget.guardInfoModel?.vendorId ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.guardInfoModel != null &&
                                    (widget.guardInfoModel?.vendorId != null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.guardInfoModel.vendorId = value;
                              context
                                  .read<GuardInfoCubit>()
                                  .onModelValueChange(state.guardInfoModel);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Guarding Agency POC
                          CommonWidgets.textDisplay(Constants.guardingAgencyPOC,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue:
                                state.guardInfoModel.guardingVendorPoc,
                            textFormKey: Keys.vendorAgencyPOCKey,
                            hintText: '',
                            isEnable: widget.guardInfoModel == null
                                ? true
                                : (widget.guardInfoModel != null &&
                                        (widget.guardInfoModel
                                                ?.guardingVendorPoc ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.guardInfoModel != null &&
                                    (widget.guardInfoModel?.guardingVendorPoc !=
                                        null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.guardInfoModel.guardingVendorPoc = value;
                              context
                                  .read<GuardInfoCubit>()
                                  .onModelValueChange(state.guardInfoModel);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///No. Of Security Officers
                          CommonWidgets.textDisplay(
                              Constants.numOfSecurityOfficers,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue:
                                '${state.guardInfoModel.securityOfficerCount ?? ''}',
                            textFormKey: Keys.noOfSecurityOfficersKey,
                            hintText: '',
                            isEnable: widget.guardInfoModel == null
                                ? true
                                : (widget.guardInfoModel != null &&
                                        (widget.guardInfoModel
                                                ?.securityOfficerCount ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.guardInfoModel != null &&
                                    (widget.guardInfoModel
                                            ?.securityOfficerCount !=
                                        null))
                                ? true
                                : false,
                            onChange: (int value) {
                              state.guardInfoModel.securityOfficerCount = value;
                              context
                                  .read<GuardInfoCubit>()
                                  .onModelValueChange(state.guardInfoModel);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Total Duty Hours
                          CommonWidgets.textDisplay(Constants.totalDutyHours,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue:
                                '${state.guardInfoModel.securityOfficerCountHrs ?? ''}',
                            textFormKey: Keys.noOfSecurityOfficersHrsKey,
                            hintText: '',
                            isEnable: widget.guardInfoModel == null
                                ? true
                                : (widget.guardInfoModel != null &&
                                        (widget.guardInfoModel
                                                ?.securityOfficerCountHrs ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.guardInfoModel != null &&
                                    (widget.guardInfoModel
                                            ?.securityOfficerCountHrs !=
                                        null))
                                ? true
                                : false,
                            onChange: (int value) {
                              state.guardInfoModel.securityOfficerCountHrs =
                                  value;
                              context
                                  .read<GuardInfoCubit>()
                                  .onModelValueChange(state.guardInfoModel);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///No. Of Security Supervisors
                          CommonWidgets.textDisplay(
                              Constants.numOfSecuritySupervisor,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue:
                                '${state.guardInfoModel.securitySupervisorCount ?? ''}',
                            textFormKey: Keys.noOfSecuritySupervisorsKey,
                            hintText: '',
                            isEnable: widget.guardInfoModel == null
                                ? true
                                : (widget.guardInfoModel != null &&
                                        (widget.guardInfoModel
                                                ?.securitySupervisorCount ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.guardInfoModel != null &&
                                    (widget.guardInfoModel
                                            ?.securitySupervisorCount !=
                                        null))
                                ? true
                                : false,
                            onChange: (int value) {
                              state.guardInfoModel.securitySupervisorCount =
                                  value;
                              context
                                  .read<GuardInfoCubit>()
                                  .onModelValueChange(state.guardInfoModel);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Total Duty Hours
                          CommonWidgets.textDisplay(Constants.totalDutyHours,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue:
                                '${state.guardInfoModel.securitySupervisorCountHrs ?? ''}',
                            textFormKey: Keys.noOfSecuritySupervisorsHrsKey,
                            hintText: '',
                            isEnable: widget.guardInfoModel == null
                                ? true
                                : (widget.guardInfoModel != null &&
                                        (widget.guardInfoModel
                                                ?.securitySupervisorCountHrs ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.guardInfoModel != null &&
                                    (widget.guardInfoModel
                                            ?.securitySupervisorCountHrs !=
                                        null))
                                ? true
                                : false,
                            onChange: (int value) {
                              state.guardInfoModel.securitySupervisorCountHrs =
                                  value;
                              context
                                  .read<GuardInfoCubit>()
                                  .onModelValueChange(state.guardInfoModel);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///No. Of Security Guards
                          CommonWidgets.textDisplay(
                              Constants.numOfSecurityGuards,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue:
                                '${state.guardInfoModel.securityGuardCount ?? ''}',
                            textFormKey: Keys.noOfSecurityGuardsKey,
                            hintText: '',
                            isEnable: widget.guardInfoModel == null
                                ? true
                                : (widget.guardInfoModel != null &&
                                        (widget.guardInfoModel
                                                ?.securityGuardCount ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.guardInfoModel != null &&
                                    (widget.guardInfoModel
                                            ?.securityGuardCount !=
                                        null))
                                ? true
                                : false,
                            onChange: (int value) {
                              state.guardInfoModel.securityGuardCount = value;
                              context
                                  .read<GuardInfoCubit>()
                                  .onModelValueChange(state.guardInfoModel);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Total Duty Hours
                          CommonWidgets.textDisplay(Constants.totalDutyHours,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue:
                                '${state.guardInfoModel.securityGuardCountHrs ?? ''}',
                            textFormKey: Keys.noOfSecurityGuardsHrsKey,
                            hintText: '',
                            isEnable: widget.guardInfoModel == null
                                ? true
                                : (widget.guardInfoModel != null &&
                                        (widget.guardInfoModel
                                                ?.securityGuardCountHrs ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.guardInfoModel != null &&
                                    (widget.guardInfoModel
                                            ?.securityGuardCountHrs !=
                                        null))
                                ? true
                                : false,
                            onChange: (int value) {
                              state.guardInfoModel.securityGuardCountHrs =
                                  value;
                              context
                                  .read<GuardInfoCubit>()
                                  .onModelValueChange(state.guardInfoModel);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///No. Of Security Facilitators
                          CommonWidgets.textDisplay(
                              Constants.numOfSecurityFacilitators,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue:
                                '${state.guardInfoModel.securityFacilitatorCount ?? ''}',
                            textFormKey: Keys.noOfSecurityGuardsKey,
                            hintText: '',
                            isEnable: widget.guardInfoModel == null
                                ? true
                                : (widget.guardInfoModel != null &&
                                        (widget.guardInfoModel
                                                ?.securityFacilitatorCount ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.guardInfoModel != null &&
                                    (widget.guardInfoModel
                                            ?.securityFacilitatorCount !=
                                        null))
                                ? true
                                : false,
                            onChange: (int value) {
                              state.guardInfoModel.securityFacilitatorCount =
                                  value;
                              context
                                  .read<GuardInfoCubit>()
                                  .onModelValueChange(state.guardInfoModel);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Total Duty Hours
                          CommonWidgets.textDisplay(Constants.totalDutyHours,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue:
                                '${state.guardInfoModel.securityFacilitatorCountHrs ?? ''}',
                            textFormKey: Keys.noOfSecurityFacilitatorHrsKey,
                            hintText: '',
                            isEnable: widget.guardInfoModel == null
                                ? true
                                : (widget.guardInfoModel != null &&
                                        (widget.guardInfoModel
                                                ?.securityFacilitatorCountHrs ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.guardInfoModel != null &&
                                    (widget.guardInfoModel
                                            ?.securityFacilitatorCountHrs !=
                                        null))
                                ? true
                                : false,
                            onChange: (int value) {
                              state.guardInfoModel.securityFacilitatorCountHrs =
                                  value;
                              context
                                  .read<GuardInfoCubit>()
                                  .onModelValueChange(state.guardInfoModel);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Proposed Vendor
                          CommonWidgets.textDisplay(
                            Constants.proposedVendors,
                            Styles.textStyleBlack14,
                          ),
                          TextFieldAddButton(
                            title:
                                '${state.guardInfoModel.proposedVendors ?? ''}',
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseOrganisationDialog().departmentDialog(
                                context: context,
                                organisations: state.departments,
                                onTap: (List<Organisation> proposedVendors) {
                                  BlocProvider.of<GuardInfoCubit>(context)
                                      .updateDropdownValues(
                                          proposedVendors: proposedVendors);
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Budget Costs
                          CommonWidgets.textDisplay(
                              Constants.budget, Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue:
                                '${state.guardInfoModel.budget ?? ''}',
                            textFormKey: Keys.budgetKey,
                            hintText: '',
                            isEnable: widget.guardInfoModel == null
                                ? true
                                : (widget.guardInfoModel != null &&
                                        (widget.guardInfoModel?.budget == null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.guardInfoModel != null &&
                                    (widget.guardInfoModel?.budget != null))
                                ? true
                                : false,
                            onChange: (double value) {
                              state.guardInfoModel.budget = value;
                              context
                                  .read<GuardInfoCubit>()
                                  .onModelValueChange(state.guardInfoModel);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///PO NUmber
                          CommonWidgets.textDisplay(
                              Constants.pONumber, Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue: state.guardInfoModel.poNumber,
                            textFormKey: Keys.pONumberKey,
                            hintText: '',
                            isEnable: widget.guardInfoModel == null
                                ? true
                                : (widget.guardInfoModel != null &&
                                        (widget.guardInfoModel?.poNumber ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.guardInfoModel != null &&
                                    (widget.guardInfoModel?.poNumber != null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.guardInfoModel.poNumber = value;
                              context
                                  .read<GuardInfoCubit>()
                                  .onModelValueChange(state.guardInfoModel);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                        ]),
                      ),

                      /// SubmitButton
                      //  if (state.guard.status != 4) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cancelButtonDisplay(),
                          submitButtonDisplay()
                        ],
                      ),
                      //],
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      
      width: Constants.cancelButtonWidth,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<GuardInfoCubit>(context).submitForm(isSaveOnly: false);
      },
    );
  }
}
