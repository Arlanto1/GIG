import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_details/cubits/key_management_master_details_cubit.dart';

class KeyManagementMasterDetailsView extends StatefulWidget {
  final KeyManagementMasterModel? model;
  final String title;

  const KeyManagementMasterDetailsView({
    super.key,
    this.model,
    required this.title,
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
  bool isDisabled = true;
  bool isReadOnly = false;

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
        .initializeValues();
    widget.model?.total ==
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
        if (state.status == FormStatus.error) {
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
        }
      },
      builder: (context, state) {
        // if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        if (state.model.status == null) {
          isReadOnly = false;
        }

        initializeDates();
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: state.model.status != 5 ? true : false,
            showSubmitButton: state.model.status != 5 ? true : false,
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
          backgroundColor: AppColors.backgroundWhitecolor,
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
      color: AppColors.navigationSkybluecolor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkybluecolor,
            ),
            Container(
              decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhitecolor,
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
                          //if (!state.model.lock.isEmptyOrNull) ...[
                          //   RecordLockedWidget(text: '${state.model.lock}'),
                          // ],
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
                            isDisabled: state.model.status != 6,
                            textController: statusController,
                            items: keyManagementStatus,
                            initialValue: '${state.model.status ?? 0}',
                            onTap: () {
                              if (widget.model != null) {
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
                              state.labels?.locale.entrySecurity ??
                                  state.labels?.defaultLocale.entrySecurity ??
                                  Constants.createdby,
                              isMandatory: true,
                              '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
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

                          ///Location
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.location ??
                              //  state.labels?.defaultLocale.location ??
                              Constants.location,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          locationWidgetdislay(state),
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
                                BlocProvider.of<
                                            KeyManagementMasterDetailsCubit>(
                                        context)
                                    .updateDropdownValues(
                                        entities: selectedEntities);
                                Navigator.of(context).pop(); // Close the dialog
                              }),
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
                            keyboardType: TextInputType.text,
                            initialValue: state.model.floor,
                            textFormKey: Keys.guardingPOCKey,
                            hintText: '',
                            isEnable: true,
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
                          TextfieldAddButton(
                            title: state.model.doorType?.name,
                            height: 70,
                            isDisableColor:
                                state.model.status == 2 ? true : false,
                            onTap: () {
                              BaseOrganisationDialog().departmentDialog(
                                context: context,
                                organisations: state.departments,
                                onTap: (Organisation department) {
                                  state.model.doorType?.name = department.name;

                                  BlocProvider.of<
                                              KeyManagementMasterDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          doorType: department);
                                },
                              );
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
                            keyboardType: TextInputType.text,
                            initialValue: state.model.doorName,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.doorName == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
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
                              onChangedYes: widget.model?.status == 6
                                  ? null
                                  : (val) {
                                      state.model.doorAccessControl = true;
                                      BlocProvider.of<
                                                  KeyManagementMasterDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    },
                              onChangedNo: widget.model?.status == 6
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
                              onChangedYes: widget.model?.status == 6
                                  ? null
                                  : (val) {
                                      state.model.doorLockKey = true;
                                      BlocProvider.of<
                                                  KeyManagementMasterDetailsCubit>(
                                              context)
                                          .onCheckBoxChange(state.model);
                                    },
                              onChangedNo: widget.model?.status == 6
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
                            keyboardType: TextInputType.number,
                            initialValue: state.model.keyNo,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.keyNo == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
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
                              isDisabled: state.model.status != 6,
                              textController: keyTaggingController,
                              items: keyTaggingDropDownValues,
                              initialValue: state.model.keyTagging.toString(),
                              onTap: () {
                                //  if (isDisabled) {
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
                                //}
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
                            keyboardType: TextInputType.number,
                            initialValue: '${state.model.noKeys ?? ''}',
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.noKeys == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.noKeys = int.tryParse(value);
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// No. of  Master Keys
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.employeeCode ??
                              //state.labels?.defaultLocale.employeeCode ??
                              Constants.noOfMasterKeys,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: '${state.model.noMasterKey ?? ''}',
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.noMasterKey == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.noMasterKey = int.tryParse(value);
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///total Keys
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.budget ??
                              //     state.labels?.defaultLocale.budget ??
                              Constants.totalKeys,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: (((state.model.noKeys ?? 0) +
                                    (state.model.noMasterKey ?? 0))
                                .toString()),
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
                            keyboardType: TextInputType.text,
                            initialValue: state.model.keysStored,
                            textFormKey: Keys.guardingAgencyKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.keysStored == null))
                                    ? false
                                    : true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.keysStored = value;
                              context
                                  .read<KeyManagementMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Lock Change History
                          //if (state.model.status == 1) ...[
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
                                      KeyManagementMasterDetailsCubit>(context)
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
                                      Constants.lockChangeHistoryInt,
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SvgPicture.asset(
                                  AppIcon.pluscircle,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Add/View Lock Change History(S)',
                                  style: TextStyle(
                                    color: AppColors.navigationSkybluecolor,
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
                                      KeyManagementMasterDetailsCubit>(context)
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
                                      Constants.keyLostHistoryInt,
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SvgPicture.asset(
                                  AppIcon.pluscircle,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Add/View Key Lost History(S)',
                                  style: TextStyle(
                                    color: AppColors.navigationSkybluecolor,
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
                                      KeyManagementMasterDetailsCubit>(context)
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
                                      Constants.keyDamageHistoryInt,
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SvgPicture.asset(
                                  AppIcon.pluscircle,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Add/View Key Damage History(S)',
                                  style: TextStyle(
                                    color: AppColors.navigationSkybluecolor,
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
                                      KeyManagementMasterDetailsCubit>(context)
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
                                      Constants.keyDestroyHistoryInt,
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SvgPicture.asset(
                                  AppIcon.pluscircle,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Add/View Key Destroy History(S)',
                                  style: TextStyle(
                                    color: AppColors.navigationSkybluecolor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          //],
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          /// SubmitButton
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cancelButtonDisplay(),
                              submitButtonDisplay()
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
      // Customize the button properties as needed
      width: 150,
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
        BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }

  Widget locationWidgetdislay(KeyManagementMasterDetailsState state) {
    return GestureDetector(
      onTap: () {
        // if (widget.occurrence == null ||
        //     (state.occurrence.location?.name ?? '').isEmpty)
        //     {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            // print(state.getLocationsResponse);
            return CustomExpansionListTexts(
              locationList: state.locations,
              onTap: (Organisation? list) async {
                log('list?.name-----${list?.name}');

                Organisation location = Organisation();
                location.id = list?.id;
                location.name = list?.name;
                state.model.location = location;

                BlocProvider.of<KeyManagementMasterDetailsCubit>(context)
                    .updateDropdownValues(location: location);
              },
            );
          },
        );
        // }
      },
      child: SelectedTileValueWidget(name: state.model.location?.name ?? ''),
    );
  }
}
