import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_details/cubits/key_management_master_details_cubit.dart';

class KeyManagementMasterDetailsView extends StatefulWidget {
  final KeyManagementMasterModel? model;
  final String title;
  final ExtraProperties? extraProperties;

  const KeyManagementMasterDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<KeyManagementMasterDetailsView> createState() =>
      _KeyManagementMasterDetailsViewState();
}

class _KeyManagementMasterDetailsViewState
    extends State<KeyManagementMasterDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController keyTaggingController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController totalKeyController = TextEditingController();
  bool isDisabled = true;
  bool isReadOnly = false;
  bool showSaveSubmitButton = false;
  final FocusNode floorFocusNode = FocusNode();
  final FocusNode keyDescriptionFocusNode = FocusNode();
  final FocusNode noOfKeysFocusNode = FocusNode();

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
        .initializeValues();
    widget.model?.total ==
        (((widget.model?.noKeys ?? 0) + (widget.model?.noMasterKey ?? 0))
            .toString());
    totalKeyController.text =
        (((widget.model?.noKeys ?? 0) + (widget.model?.noMasterKey ?? 0))
            .toString());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<KeyManagementMasterDetailsCubit,
        KeyManagementMasterDetailsState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Key Management Master',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                keyManagementMasterListRoute,
                arguments: {},
              );
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);

          // Utils.dynamicAlert(
          //     context, state.message ?? '', 'Material Movement', '');
        }
      },
      builder: (context, state) {
        if (state.model.status == -1 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 2 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 0 && state.model.lock.isEmptyOrNull) {
          isReadOnly = false;
        }
        if (state.model.status == 1 && state.model.lock.isEmptyOrNull) {
          isReadOnly = false;
        }
        if (state.model.status == null) {
          isReadOnly = false;
        }

        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isReadOnly = true;
        // }

        showSaveSubmitButton = state.model.status != 2 &&
            state.model.status != -1 &&
            !isReadOnly &&
            state.model.lock.isEmptyOrNull;

        initializeDates();
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: showSaveSubmitButton ? true : false,
            showSubmitButton: showSaveSubmitButton ? true : false,
            showDisLikeButton: false,
            showLikeButton: false,
            pdfAPIName:
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.keyManagementMasterModule}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
                  .submitForm(isSaveOnly: false);
            },
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {}

  getBodybuilder(KeyManagementMasterDetailsState state, height) {
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
                autovalidateMode: state.model.status == 4
                    ? AutovalidateMode.disabled
                    : AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Column(
                        children: [
                          if (!state.model.lock.isEmptyOrNull) ...[
                            RecordLockedWidget(text: '${state.model.lock}'),
                          ],
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              Constants.generalinformation,
                              style: Styles.styleHeaderGreyText16,
                            ),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Status
                          CommonWidgets.textDisplay(
                              state.labels?.locale.status ??
                                  state.labels?.defaultLocale.status ??
                                  Constants.status,
                              Styles.textStyleBlack14,
                              isMandatory: true),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDropDown().getDropDown(
                            isDisabled: true,
                            textController: statusController,
                            items: keyManagementStatus,
                            initialValue: '${state.model.status ?? 0}',
                            onTap: () {
                              if (!isDisabled) {
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
                                    BlocProvider.of<
                                                KeyManagementMasterDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                            status: int.tryParse(
                                                selectedLabel.value));
                                  },
                                );
                              }
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Created By
                          CommonWidgets.horizentaltextHandling(
                              state.labels?.locale.createdBy ??
                                  state.labels?.defaultLocale.createdBy ??
                                  Constants.createdby,
                              isMandatory: true,
                              '${state.model.createdBy?.firstName ?? ''} ${state.model.createdBy?.lastName ?? ''}'),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Date of creation
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.inputDate ??
                              //     state.labels?.defaultLocale.inputDate ??
                              Constants.dateofcreation,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDate().creationDateDisplay(
                              state.model.createdDate ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Location
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.location ??
                              //  state.labels?.defaultLocale.location ??
                              Constants.location,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseLocationDropdown().locationWidgetDisplay(
                              isEnabled: showSaveSubmitButton,
                              context: context,
                              locations: state.locations ?? Locations(),
                              selectedLocationName:
                                  state.model.location?.name ?? '',
                              onTap: (Organisation? location) {
                                BlocProvider.of<
                                            KeyManagementMasterDetailsCubit>(
                                        context)
                                    .updateDropdownValues(location: location);
                              }),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Entity
                          CommonWidgets.textDisplay(
                            Constants.entity,
                            isMandatory: true,
                            Styles.textStyleBlack14,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),

                          BaseEntitiesSelection().entityDropDownSelection(
                            context: context,
                            selectedValues: state.model.entities ?? [],
                            all: state.listOfEntities ?? [],
                            enabled: !isReadOnly,
                            onTap: (List<Organisation> selectedEntities) {
                              log('--selectedEntities----${selectedEntities.length}');
                              BlocProvider.of<KeyManagementMasterDetailsCubit>(
                                      context)
                                  .updateDropdownValues(
                                      entities: selectedEntities);
                              Navigator.of(context).pop();
                              FocusScope.of(context)
                                  .requestFocus(floorFocusNode);
                              // Close the dialog
                            },
                            orgName: 'ATOM_ENTITIES',
                            functionToCall: () {
                              // refresh the list
                              BlocProvider.of<KeyManagementMasterDetailsCubit>(
                                      context)
                                  .refreshList();
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Sl No.
                          CommonWidgets.horizentaltextHandling(
                            state.labels?.locale.slNo ??
                                state.labels?.defaultLocale.slNo ??
                                Constants.slno,
                            state.model.slNo ?? '',
                            isMandatory: true,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Floor
                          CommonWidgets.textDisplay(
                              //  state.labels?.locale.guardingPOC ??
                              // state.labels?.defaultLocale.guardingPOC ??
                              Constants.floor,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.text,
                            initialValue: state.model.floor,
                            textFormKey: Keys.guardingPOCKey,
                            hintText: '',
                            isEnable: !isReadOnly,
                            focusNode: floorFocusNode,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.floor = value;
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Key Type
                          CommonWidgets.textDisplay(
                            //state.labels?.locale.vendor ??
                            //  state.labels?.defaultLocale.vendor ??
                            Constants.keyType,
                            isMandatory: true,
                            Styles.textStyleBlack14,
                          ),
                          TextFieldAddButton(
                            title: state.model.doorType?.name,
                            height: 70,
                            isDisableColor: isReadOnly,
                            onTap: () {
                              if (showSaveSubmitButton) {
                                BaseOrganisationDialog().departmentDialog(
                                    enabled: showSaveSubmitButton,
                                    context: context,
                                    organisations: state.departments,
                                    onTap: (Organisation department) {
                                      state.model.doorType?.name =
                                          department.name;

                                      BlocProvider.of<
                                                  KeyManagementMasterDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                              doorType: department);
                                      FocusScope.of(context).requestFocus(
                                          keyDescriptionFocusNode);
                                    },
                                    leftImage: true,
                                    orgName: 'KEY_MANAGEMENT_DOOR_TYPE',
                                    createEntity: true,
                                    title: 'Add Key Type',
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<
                                                  KeyManagementMasterDetailsCubit>(
                                              context)
                                          .refreshList();
                                    });
                              }

                              // leodepartmentsDialog(state);
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Key Description
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.employeeCode ??
                              //state.labels?.defaultLocale.employeeCode ??
                              Constants.keyDescription,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.text,
                            initialValue: state.model.doorName,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            focusNode: keyDescriptionFocusNode,
                            isEnable: !isReadOnly,
                            isDisableColor: isReadOnly,
                            onChange: (String value) {
                              state.model.doorName = value;
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Door Has Access Control
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.deploymentOrderSubmitted ??
                              //   state.labels?.defaultLocale
                              //     .deploymentOrderSubmitted ??
                              Constants.doorHasAccessControl,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue:
                                  state.model.doorAccessControl ? 1 : 0,
                              onChangedYes: !showSaveSubmitButton
                                  ? null
                                  : (val) {
                                      state.model.doorAccessControl = true;
                                      BlocProvider.of<
                                                  KeyManagementMasterDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    },
                              onChangedNo: !showSaveSubmitButton
                                  ? null
                                  : (val) {
                                      state.model.doorAccessControl = false;
                                      BlocProvider.of<
                                                  KeyManagementMasterDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    }),

                          /// Door Has Lock And Key Mechanism
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.deploymentOrderSubmitted ??
                              //   state.labels?.defaultLocale
                              //     .deploymentOrderSubmitted ??
                              Constants.doorHasLockAndKeyMechanism,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue: state.model.doorLockKey ? 1 : 0,
                              onChangedYes: !showSaveSubmitButton
                                  ? null
                                  : (val) {
                                      state.model.doorLockKey = true;
                                      BlocProvider.of<
                                                  KeyManagementMasterDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    },
                              onChangedNo: !showSaveSubmitButton
                                  ? null
                                  : (val) {
                                      state.model.doorLockKey = false;
                                      BlocProvider.of<
                                                  KeyManagementMasterDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    }),

                          /// Key No
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.employeeCode ??
                              //state.labels?.defaultLocale.employeeCode ??
                              Constants.keyNo,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.text,
                            initialValue: state.model.keyNo,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: !isReadOnly,
                            isDisableColor: isReadOnly,
                            onChange: (String value) {
                              state.model.keyNo = value;
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Key Tagging Done?
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.gender ??
                              //  state.labels?.defaultLocale.gender ??
                              Constants.keyTaggingDone,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDropDown().getDropDown(
                              isDisabled: !isReadOnly,
                              textController: keyTaggingController,
                              items: keyTaggingDropDownValues,
                              initialValue: state.model.keyTagging.toString(),
                              onTap: () {
                                if (!isReadOnly) {
                                  BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: keyTaggingDropDownValues
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            keyTaggingDropDownValues.firstWhere(
                                          (label) => label.key == value,
                                          orElse: () =>
                                              const Label(key: '', value: ''),
                                        );
                                        BlocProvider.of<
                                                    KeyManagementMasterDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                keyTagging: int.tryParse(
                                                    selectedLabel.value));
                                      });
                                  FocusScope.of(context)
                                      .requestFocus(noOfKeysFocusNode);
                                }
                              }),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// No. of  Keys
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.employeeCode ??
                              //state.labels?.defaultLocale.employeeCode ??
                              Constants.noOfKeys,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue: '${state.model.noKeys ?? ''}',
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            focusNode: noOfKeysFocusNode,
                            isEnable: !isReadOnly,
                            isDisableColor: isReadOnly,
                            onChange: (String value) {
                              state.model.noKeys = int.tryParse(value);

                              int noKeys = state.model.noKeys ?? 0;
                              int noMasterKey = state.model.noMasterKey ?? 0;
                              totalKeyController.text =
                                  (noKeys + noMasterKey).toString();
                              widget.model?.total =
                                  int.tryParse(totalKeyController.text);
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Number of  Master Keys
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.employeeCode ??
                              //state.labels?.defaultLocale.employeeCode ??
                              Constants.noOfMasterKeys,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            initialValue: '${state.model.noMasterKey ?? ''}',
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: !isReadOnly,
                            isDisableColor: isReadOnly,
                            onChange: (String value) {
                              state.model.noMasterKey = int.tryParse(value);

                              int noKeys = state.model.noKeys ?? 0;
                              int noMasterKey = state.model.noMasterKey ?? 0;
                              totalKeyController.text =
                                  (noKeys + noMasterKey).toString();

                              widget.model?.total =
                                  int.tryParse(totalKeyController.text);
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Total Keys
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.budget ??
                              //     state.labels?.defaultLocale.budget ??
                              Constants.totalKeys,
                              Styles.textStyleBlack14,
                              isMandatory: true),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.number,
                            controller: totalKeyController,
                            // initialValue: (((state.model.noKeys ?? 0) +
                            //         (state.model.noMasterKey ?? 0))
                            //     .toString()),
                            textFormKey: Keys.budgetKey,
                            hintText: '',
                            isEnable: !isDisabled,
                            isDisableColor: isDisabled,
                            onChange: (String value) {
                              // state.model.total = value;
                              // context
                              //     .read<KeyManagementMasterDetailsCubit>()
                              //     .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// How And Where The Keys Are Stored
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.employeeCode ??
                              //state.labels?.defaultLocale.employeeCode ??
                              Constants.howAndWhereTheKeysAreStored,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            textInputType: TextInputType.text,
                            initialValue: state.model.keysStored,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: !isReadOnly,
                            isDisableColor: isReadOnly,
                            onChange: (String value) {
                              state.model.keysStored = value;
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          if (widget.model?.id != null) ...[
                            /// Modified Date
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.date ??
                              //     state.labels?.defaultLocale.date ??
                              Constants.modifiedOn,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDate().creationDateDisplay(
                                state.model.modifiedDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Modified By
                            CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.entrySecurity ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                Constants.modifiedBy,
                                isMandatory: true,
                                '${state.model.modifiedBy}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// No. keys issued
                            CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.entrySecurity ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                Constants.noKeysIssued,
                                isMandatory: true,
                                ' ${state.model.noKeysIssued??''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Number of Keys Available
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.available ??
                                    state.labels?.defaultLocale.available ??
                                    Constants.noOfKeysAvailable,
                                '${state.model.available??''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Number of Keys Returned
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.returned ??
                                    state.labels?.defaultLocale.returned ??
                                    Constants.noOfKeysReturned,
                                '${state.model.returned??''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Number of Keys not Returned
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.notReturned ??
                                    state.labels?.defaultLocale.notReturned ??
                                    Constants.noOfKeysNotReturned,
                                '${state.model.notReturned??''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Number of Keys Lost
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.lost ??
                                    state.labels?.defaultLocale.lost ??
                                    Constants.noOfKeysLost,
                                '${state.model.lost??''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Number of Keys Damaged
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.damaged ??
                                    state.labels?.defaultLocale.damaged ??
                                    Constants.noOfKeysDamaged,
                                '${state.model.damaged??''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Number of Master Keys Issued
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.noKeysIssuedMaster ??
                                    state.labels?.defaultLocale
                                        .noKeysIssuedMaster ??
                                    Constants.noOfMasterKeysIssued,
                                '${state.model.noKeysIssuedMaster??''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Number of Master Keys Available
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.availableMaster ??
                                    state.labels?.defaultLocale
                                        .availableMaster ??
                                    Constants.noOfMasterKeysAvailable,
                                '${state.model.availableMaster??''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Number of Master Keys Returned
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.returnedMaster ??
                                    state
                                        .labels?.defaultLocale.returnedMaster ??
                                    Constants.noOfMasterKeysReturned,
                                '${state.model.returnedMaster??''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Number of Master Keys Not Returned
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.notReturnedMaster ??
                                    state.labels?.defaultLocale
                                        .notReturnedMaster ??
                                    Constants.noOfMasterKeysNotReturned,
                                '${state.model.notReturnedMaster??''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Number of Master Keys Lost
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.lostMaster ??
                                    state.labels?.defaultLocale.lostMaster ??
                                    Constants.noOfMasterKeysLost,
                                '${state.model.lostMaster??''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Number of Master Keys Damaged
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.damagedMaster ??
                                    state.labels?.defaultLocale.damagedMaster ??
                                    Constants.noOfMasterKeysDamaged,
                                '${state.model.damagedMaster??''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],

                          /// Lock Change History
                          if (widget.model?.noKeys != null &&
                              widget.model!.noKeys! > 0 &&
                              widget.model?.noMasterKey != null &&
                              widget.model!.noMasterKey! > 0 &&
                              state.model.status != null &&
                              state.model.status != 0 &&
                              widget.model?.id != null) ...[
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.lockChangeHistory,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            GestureDetector(
                              onTap: () async {
                                NavigatorState nav = Navigator.of(context);
                                bool isSaveSuccess = await BlocProvider.of<
                                            KeyManagementMasterDetailsCubit>(
                                        context)
                                    .submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );
                                if (!isSaveSuccess) {
                                  return;
                                }
                                nav.pushNamed(
                                  keyHistoryRecordsViewRoute,
                                  arguments: {
                                    ConstantsArgument.title:
                                        Constants.lockChangeHistory,
                                    ConstantsArgument.id: state.model.id,
                                    ConstantsArgument.type:
                                        ConstantsIntValue.lockChangeHistoryInt,
                                    ConstantsArgument.isLocked:
                                        state.model.lock,
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    AppIcon.pluscircle,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.navigationSkyBlueColor,
                                      BlendMode.srcIn,
                                    ),
                                    // color: AppColors.navigationSkyBlueColor,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Add/View Lock Change History(S)',
                                    style: TextStyle(
                                      color: AppColors.navigationSkyBlueColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Key Lost History
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.keyLostHistory,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            GestureDetector(
                              onTap: () async {
                                NavigatorState nav = Navigator.of(context);
                                bool isSaveSuccess = await BlocProvider.of<
                                            KeyManagementMasterDetailsCubit>(
                                        context)
                                    .submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );

                                log('-Key Lost History-isSaveSuccess--$isSaveSuccess---');
                                if (!isSaveSuccess) {
                                  return;
                                }

                                nav.pushNamed(
                                  keyHistoryRecordsViewRoute,
                                  arguments: {
                                    ConstantsArgument.title:
                                        Constants.keyLostHistory,
                                    ConstantsArgument.id: state.model.id,
                                    ConstantsArgument.type:
                                        ConstantsIntValue.keyLostHistoryInt,
                                    ConstantsArgument.isLocked:
                                        state.model.lock,
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    AppIcon.pluscircle,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.navigationSkyBlueColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Add/View Key Lost History(S)',
                                    style: TextStyle(
                                      color: AppColors.navigationSkyBlueColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Key Damage History
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.keyDamageHistory,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            GestureDetector(
                              onTap: () async {
                                NavigatorState nav = Navigator.of(context);
                                bool isSaveSuccess = await BlocProvider.of<
                                            KeyManagementMasterDetailsCubit>(
                                        context)
                                    .submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );
                                log('-Key Damage History-isSaveSuccess--$isSaveSuccess---');

                                if (!isSaveSuccess) {
                                  return;
                                }

                                log('--state.model.id---${state.model.id}---');

                                nav.pushNamed(
                                  keyHistoryRecordsViewRoute,
                                  arguments: {
                                    ConstantsArgument.title:
                                        Constants.keyDamageHistory,
                                    ConstantsArgument.id: state.model.id,
                                    ConstantsArgument.type:
                                        ConstantsIntValue.keyDamageHistoryInt,
                                    ConstantsArgument.isLocked:
                                        state.model.lock,
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    AppIcon.pluscircle,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.navigationSkyBlueColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Add/View Key Damage History(S)',
                                    style: TextStyle(
                                      color: AppColors.navigationSkyBlueColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Key Destroy History
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.keyDestroyHistory,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            GestureDetector(
                              onTap: () async {
                                NavigatorState nav = Navigator.of(context);
                                bool isSaveSuccess = await BlocProvider.of<
                                            KeyManagementMasterDetailsCubit>(
                                        context)
                                    .submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );

                                if (!isSaveSuccess) {
                                  return;
                                }

                                nav.pushNamed(
                                  keyHistoryRecordsViewRoute,
                                  arguments: {
                                    ConstantsArgument.title:
                                        Constants.keyDestroyHistory,
                                    ConstantsArgument.id: state.model.id,
                                    ConstantsArgument.type:
                                        ConstantsIntValue.keyDestroyHistoryInt,
                                    ConstantsArgument.isLocked:
                                        state.model.lock,
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    AppIcon.pluscircle,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.navigationSkyBlueColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Add/View Key Destroy History(S)',
                                    style: TextStyle(
                                      color: AppColors.navigationSkyBlueColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ],
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          /// SubmitButton
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cancelButtonDisplay(),
                              if (showSaveSubmitButton) ...[
                                submitButtonDisplay()
                              ],
                            ],
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.04),
                        ],
                      ),
                    ),
                  ],
                ),
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
      buttonText: Constants.close,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
        CommonServices().unlock();
      },
    );
  }

  // Widget cancelButtonDisplay(KeyManagementMasterDetailsState state) {
  //   bool condition = state.model.id == null ||
  //       !state.model.lock.isEmptyOrNull ||
  //       state.model.status == -1;
  //   return AppButton(
  //     width: Constants.cancelButtonWidth,
  //     backgroundColor: Colors.white,
  //     key: const Key(Keys.cancelButton),
  //     buttonText: condition ? Constants.close : Constants.cancelRecord,
  //     buttonTextKey: Keys.cancelButton,
  //     onTap: () {
  //       if (state.model.id == null) {
  //         Navigator.pop(context);
  //         return;
  //       }
  //       var dialog = CustomAlertDialog(
  //           title: Constants.cancelRecord,
  //           message: Constants.cancelRecordWarningMessage,
  //           onPositivePressed: () {
  //             Navigator.pop(context);
  //             Navigator.pop(context);
  //             updateRecordStatus(state);
  //           },
  //           positiveBtnText: Constants.yes,
  //           negativeBtnText: Constants.no);
  //       showDialog(context: context, builder: (BuildContext context) => dialog);
  //     },
  //   );
  // }

  // void updateRecordStatus(KeyManagementMasterDetailsState state) {
  //   if (state.model.id != null) {
  //     BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
  //         .updateStatus(id: state.model.id.toString());
  //     Navigator.popAndPushNamed(context, keyManagementMasterListRoute);
  //   } else {
  //     Navigator.pop(context);
  //   }
  // }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }
}
