import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:intl/intl.dart';

import 'add_date_pop_up.dart';

class GuardingMasterDataDetails extends StatefulWidget {
  final GuardingMastersDataModel? guardingMasterData;
  final String title;

  const GuardingMasterDataDetails({
    super.key,
    this.guardingMasterData,
    required this.title,
  });

  @override
  State<GuardingMasterDataDetails> createState() =>
      _GuardingMasterDataDetailsState();
}

class _GuardingMasterDataDetailsState extends State<GuardingMasterDataDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  List<ImageContent>? getFiles;
  List<ImageContent>? guardFiles;
  List<ImageContent>? deploymentFiles;
  List<ImageContent>? bioDataFiles;
  List<ImageContent>? permanentAddressFiles;
  List<ImageContent>? localAddressFiles;
  List<ImageContent>? pVCFiles;
  List<ImageContent>? trainingFiles;
  List<ImageContent>? mSGBAFiles;
  List<ImageContent>? medicalFiles;
  List<ImageContent>? getAttachments;
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController dateOfJoiningController = TextEditingController();
  TextEditingController participationDateController = TextEditingController();
  TextEditingController pvcIssuedDateController = TextEditingController();
  TextEditingController pvcExpiryDateController = TextEditingController();
  TextEditingController medicalCertificateValidUntilController =
      TextEditingController();
  TextEditingController dateOfFirstCovidDoseController =
      TextEditingController();
  TextEditingController dateOfSecondCovidDoseController =
      TextEditingController();
  TextEditingController dateOfPrecautionaryCovidDose = TextEditingController();
  TextEditingController ertCertificationDate = TextEditingController();
  TextEditingController firstAidTrainingCompletionDate =
      TextEditingController();
  TextEditingController mSGBExemptionDateController = TextEditingController();

  TextEditingController rankController = TextEditingController();
  TextEditingController dutyTypeController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController deploymentTypeController = TextEditingController();
  TextEditingController systemAccessController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController mSGbFormBSubmittedController = TextEditingController();
  bool isDisabled = true;
  bool isReadOnly = false;

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GuardingMasterDataDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<GuardingMasterDataDetailsCubit,
        GuardingMasterDataDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        log('-deploymentOrderSubmitted---${state.model.deploymentOrderSubmitted}----');

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Guarding Master Data',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPostivePressed: () {
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
        if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
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
              BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                  .submitForm(isSaveOnly: false);
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {
    dateOfBirthController.text = Utils.timestamptoDateConversion(
        int.tryParse(widget.guardingMasterData?.dateOfBirth ?? '0'),
        Constants.dateFormat);

    dateOfJoiningController.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.dateOfJoining ?? '0'),
        Constants.dateFormat);

    mSGBExemptionDateController.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.msgbExemptionDate ?? '0'),
        Constants.dateFormat);

    pvcIssuedDateController.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.pvcIssuedDate ?? '0'),
        Constants.dateFormat);
    // pvcExpiryDateController.text = Utils.timestamptoDateConversion(
    //     int.parse(widget.guardingMasterData?.pvcExpiryDate ?? '0'),
    //     Constants.dateFormat);

    pvcExpiryDateController.text = DateFormat(Constants.dateFormat).format(
      DateFormat("dd/MM/yyyy")
          .parse(pvcIssuedDateController.text)
          .add(const Duration(days: 1096, hours: 0, minutes: 0)),
    );
    medicalCertificateValidUntilController.text =
        Utils.timestamptoDateConversion(
            int.parse(
                widget.guardingMasterData?.medicalCertificateValidUntil ?? '0'),
            Constants.dateFormat);

    dateOfFirstCovidDoseController.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.covidFirstDoseDate ?? '0'),
        Constants.dateFormat);

    dateOfSecondCovidDoseController.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.covidSecondDoseDate ?? '0'),
        Constants.dateFormat);

    dateOfPrecautionaryCovidDose.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.covidPrecautionaryDoseDate ?? '0'),
        Constants.dateFormat);

    ertCertificationDate.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.ertCertificationDate ?? '0'),
        Constants.dateFormat);
    firstAidTrainingCompletionDate.text = Utils.timestamptoDateConversion(
        int.parse(
            widget.guardingMasterData?.firstAidTrainingCompletionDate ?? '0'),
        Constants.dateFormat);
  }

  getBodybuilder(GuardingMasterDataDetailsState state, height) {
    //returnableTextController.text =
    // state.materialMovement.returnable! ? 'Returnable' : 'Non Returnable';

    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      // log('---getAttachments----builder----${getAttachments?.length}-----');
      // getFiles = state.loadAttachments ?? [];
      // log('---guardAttachments----builder----${state.guardAttachments?.length}-----');

      guardFiles = state.guardAttachments ?? [];
      deploymentFiles = state.deploymentAttachments;
      bioDataFiles = state.bioDataAttachments;
      permanentAddressFiles = state.permanentAddressAttachments;
      localAddressFiles = state.localAddressAttachments;
      pVCFiles = state.pVCAttachments;
      trainingFiles = state.trainingAttachments;
      mSGBAFiles = state.mSGBAttachments;
      medicalFiles = state.medicalAttachments;
    }

    return Container(
        color: AppColors.navigationSkybluecolor,
        child: SingleChildScrollView(
            child: Column(children: [
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
                          child: Column(children: [
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
                              isDisabled: state.model.status != 6,
                              textController: statusController,
                              items: statusDropDownValues,
                              initialValue: '${state.model.status ?? 1}',
                              onTap: () {
                                if (widget.guardingMasterData != null) {
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
                                                  GuardingMasterDataDetailsCubit>(
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
                                state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDate().creationDateDisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Building  Location
                            CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.buildingLocation,
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

                            TextfieldAddButton(
                                title: state.model.entity?.name ?? '',
                                height: 70,
                                isDisableColor: false,
                                onTap: () {
                                  BaseDepartmentDialog().userDialog(
                                    context: context,
                                    entities: state.listOfEntities,
                                    // TODO: Need to change EntrySecurity to BaseUser
                                    onTap: (Organisation entity) {
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                        entity: entity,
                                      );
                                    },
                                  );
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

                            /// Guard Name
                            Column(
                              children: [
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.guard ??
                                      state.labels?.defaultLocale.guard ??
                                      Constants.name,
                                  isMandatory: true,
                                  Styles.textStyleBlack14,
                                ),
                                TextfieldAddButton(
                                  title: state.model.guard?.name,
                                  height: 70,
                                  isDisableColor: false,
                                  onTap: () {
                                    BaseDepartmentDialog().userDialog(
                                      context: context,
                                      users: state.emailUsers!,
                                      // TODO: Need to change EntrySecurity to BaseUser
                                      onTap: (BaseUser user) {
                                        BlocProvider.of<
                                                    GuardingMasterDataDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          guard: user,
                                        );
                                      },
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],
                            ),

                            /// upload Photo
                            CommonWidgets.textDisplay(
                                Constants.uploadPhoto, Styles.textStyleBlack14),
                            widget.guardingMasterData == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            BaseImageUpload().uploadWidget(
                              context: context,
                              loggedInUserDetails:
                                  state.loggedInUserDetails ?? User(),
                              getFiles: guardFiles,
                              onImageSelected: (ImageContent data) {
                                log('-------function---onImageSelected---------');
                                List<ImageContent>? files = [];
                                files.add(data);
                                for (ImageContent image in guardFiles ?? []) {
                                  files.add(image);
                                }
                                log('-------function---${files.length}---------');

                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .addAttachment(
                                  guardImages: files,
                                );
                              },
                            ),
                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.guardAttachments,
                              files: guardFiles,
                              showDownloadIcon: widget.guardingMasterData
                                          ?.photoGraph?.imageContent !=
                                      null
                                  ? true
                                  : false,
                            ),

                            /// Guarding Vendor
                            CommonWidgets.textDisplay(
                              state.labels?.locale.vendor ??
                                  state.labels?.defaultLocale.vendor ??
                                  Constants.guardingVendor,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            TextfieldAddButton(
                              title: state.model.vendor?.name,
                              height: 60,
                              isDisableColor: false,
                              onTap: () {
                                BaseDepartmentDialog().departmentDialog(
                                  context: context,
                                  departments: state.departments,
                                  onTap: (Organisation department) {
                                    BlocProvider.of<
                                                GuardingMasterDataDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                            vendor: department);
                                  },
                                );
                              },
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Guarding Partner POC
                            CommonWidgets.textDisplay(
                                state.labels?.locale.guardingPOC ??
                                    state.labels?.defaultLocale.guardingPOC ??
                                    Constants.guardingPoc,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.text,
                              initialValue: state.model.guardingPOC,
                              textFormKey: Keys.guardingPOCKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.guardingPOC = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Guarding Agency Employee Code
                            CommonWidgets.textDisplay(
                                state.labels?.locale.employeeCode ??
                                    state.labels?.defaultLocale.employeeCode ??
                                    Constants.guardingAgencyEmpCode,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: state.model.employeeCode,
                              textFormKey: Keys.guardingAgencyKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.employeeCode ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.employeeCode = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Rank
                            CommonWidgets.textDisplay(
                                state.labels?.locale.guardRank ??
                                    state.labels?.defaultLocale.guardRank ??
                                    Constants.rank,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: state.model.status != 6,
                                textController: rankController,
                                items: guardRankDropDownValues,
                                initialValue: state.model.guardRank.toString(),
                                onTap: () {
                                  if (isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues: guardRankDropDownValues
                                            .map((label) => label.key)
                                            .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              guardRankDropDownValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      GuardingMasterDataDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  guardRank: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// DB Employee ID
                            CommonWidgets.textDisplay(
                                state.labels?.locale.dbEmployeeId ??
                                    state.labels?.defaultLocale.dbEmployeeId ??
                                    Constants.dbEmployeeId,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: state.model.dbEmployeeId,
                              textFormKey: Keys.dbEmployeeIDKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.dbEmployeeId ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.dbEmployeeId = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Type of Duty
                            CommonWidgets.textDisplay(
                                state.labels?.locale.dutyType ??
                                    state.labels?.defaultLocale.dutyType ??
                                    Constants.typeOfDuty,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: state.model.status != 6,
                                textController: dutyTypeController,
                                items: dutyTypeDropDownValues,
                                initialValue: state.model.dutyType.toString(),
                                onTap: () {
                                  if (isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues: dutyTypeDropDownValues
                                            .map((label) => label.key)
                                            .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              dutyTypeDropDownValues.firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      GuardingMasterDataDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  dutyType: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Gender
                            CommonWidgets.textDisplay(
                                state.labels?.locale.gender ??
                                    state.labels?.defaultLocale.gender ??
                                    Constants.gender,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                              isDisabled: state.model.status != 6,
                              textController: genderController,
                              items: genderDropDownValues,
                              initialValue: state.model.gender.toString(),
                              onTap: () {
                                if (isDisabled) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: genderDropDownValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          genderDropDownValues.firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                              gender: int.tryParse(
                                                  selectedLabel.value));
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Marital Status
                            CommonWidgets.textDisplay(
                                state.labels?.locale.maritalStatus ??
                                    state.labels?.defaultLocale.maritalStatus ??
                                    Constants.maritalStatus,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: state.model.status != 6,
                                textController: maritalStatusController,
                                items: maritalStatusDropDownValues,
                                initialValue:
                                    state.model.maritalStatus.toString(),
                                onTap: () {
                                  if (isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues:
                                            maritalStatusDropDownValues
                                                .map((label) => label.key)
                                                .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              maritalStatusDropDownValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      GuardingMasterDataDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  maritalStatus: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Contact Num
                            CommonWidgets.textDisplay(
                                state.labels?.locale.contactNo ??
                                    state.labels?.defaultLocale.contactNo ??
                                    Constants.mobileNum,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: state.model.contactNo,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.contactNo ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.contactNo = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Dependents No
                            CommonWidgets.textDisplay(
                                state.labels?.locale.dependentsNo ??
                                    state.labels?.defaultLocale.dependentsNo ??
                                    Constants.dependentsNo,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: '${state.model.dependentsNo ?? ''}',
                              textFormKey: Keys.dependentsKey,
                              hintText: '',
                              isEnable: isDisabled,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.dependentsNo = int.tryParse(value);
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of Birth
                            CommonWidgets.textDisplay(
                              state.labels?.locale.dateOfBirth ??
                                  state.labels?.defaultLocale.dateOfBirth ??
                                  Constants.dateOfBirth,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: dateOfBirthController,
                              onlyDate: true,
                              showFutureDate: false,
                              onChange: (String value) {
                                state.model.dateOfBirth =
                                    Utils().formatTime(value);
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date Of Joining
                            CommonWidgets.textDisplay(
                              state.labels?.locale.dateOfJoining ??
                                  state.labels?.defaultLocale.dateOfJoining ??
                                  Constants.dateOfJoining,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              onlyDate: true,
                              textController: dateOfJoiningController,
                              onChange: (String value) {
                                state.model.dateOfJoining =
                                    Utils().formatTime(value);

                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                                // pvcIssuedDateController.text = state.guardingMasterData.pvcIssuedDate??'';
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Type of Deployment
                            CommonWidgets.textDisplay(
                                state.labels?.locale.typeOfDeployment ??
                                    state.labels?.defaultLocale
                                        .typeOfDeployment ??
                                    Constants.typeOfDeployment,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                              isDisabled: state.model.status != 6,
                              textController: deploymentTypeController,
                              items: deploymentTypeDropDownValues,
                              initialValue:
                                  state.model.typeOfDeployment.toString(),
                              onTap: () {
                                if (isDisabled) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues: deploymentTypeDropDownValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          deploymentTypeDropDownValues
                                              .firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                        typeOfDeployment:
                                            int.tryParse(selectedLabel.value),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Deployment order Submitted?
                            CommonWidgets.textDisplay(
                                state.labels?.locale.deploymentOrderSubmitted ??
                                    state.labels?.defaultLocale
                                        .deploymentOrderSubmitted ??
                                    Constants.deploymentOrderSubmitted,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                              status: state.model.status ?? 0,
                              selectedValue:
                                  state.model.deploymentOrderSubmitted ? 1 : 0,
                              onChangedYes: widget.guardingMasterData?.status ==
                                      6
                                  ? null
                                  : (val) {
                                      state.model.deploymentOrderSubmitted =
                                          true;
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .showFields(
                                              deploymentOrderSubmitted: true);
                                      //.onModelValueChange(state.guardingMasterData
                                      //);
                                    },
                              onChangedNo: widget.guardingMasterData?.status ==
                                      4
                                  ? null
                                  : (val) {
                                      state.model.deploymentOrderSubmitted =
                                          false;
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .showFields(
                                              deploymentOrderSubmitted: false);
                                    },
                            ),
                            if (state.model.deploymentOrderSubmitted) ...[
                              /// upload Deployment Order File
                              CommonWidgets.textDisplay(
                                  Constants.uploadDeploymentOrderFile,
                                  Styles.textStyleBlack14),
                              widget.guardingMasterData == null
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),
                              BaseImageUpload().uploadWidget(
                                context: context,
                                loggedInUserDetails:
                                    state.loggedInUserDetails ?? User(),
                                getFiles: deploymentFiles,
                                onImageSelected: (ImageContent data) {
                                  log('-------function---onImageSelected---------');
                                  List<ImageContent>? files = [];
                                  files.add(data);
                                  for (ImageContent image
                                      in deploymentFiles ?? []) {
                                    files.add(image);
                                  }
                                  BlocProvider.of<
                                              GuardingMasterDataDetailsCubit>(
                                          context)
                                      .addAttachment(deploymentFiles: files);
                                },
                              ),
                              // Attachments
                              BaseImageUpload().getAttachment(
                                height: height,
                                attachments: state.deploymentAttachments,
                                files: deploymentFiles,
                                showDownloadIcon:
                                    widget.guardingMasterData != null
                                        ? true
                                        : false,
                              ),
                            ],

                            /// Height
                            CommonWidgets.textDisplay(
                                state.labels?.locale.height ??
                                    state.labels?.defaultLocale.height ??
                                    Constants.height,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: '${state.model.height ?? ''}',
                              textFormKey: Keys.heightKey,
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.height = int.tryParse(value);
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Weight
                            CommonWidgets.textDisplay(
                                state.labels?.locale.weight ??
                                    state.labels?.defaultLocale.weight ??
                                    Constants.weight,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: '${state.model.weight ?? ''}',
                              textFormKey: Keys.weightKey,
                              hintText: '',
                              isEnable: isDisabled,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.weight = int.tryParse(value);
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Chest
                            CommonWidgets.textDisplay(
                                state.labels?.locale.chest ??
                                    state.labels?.defaultLocale.chest ??
                                    Constants.chest,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: '${state.model.chest ?? ''}',
                              textFormKey: Keys.chestKey,
                              hintText: '',
                              isEnable: isDisabled,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.chest = int.tryParse(value);
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Local Language
                            CommonWidgets.textDisplay(
                                state.labels?.locale.localLanguage ??
                                    state.labels?.defaultLocale.localLanguage ??
                                    Constants.localLanguage,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.text,
                              initialValue: state.model.localLanguage,
                              textFormKey: Keys.languageKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.localLanguage ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor:
                                  (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.localLanguage !=
                                              null))
                                      ? true
                                      : false,
                              onChange: (String value) {
                                state.model.localLanguage = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Local Language Proficiency
                            CommonWidgets.textDisplay(
                                state.labels?.locale.localLangProficiency ??
                                    state.labels?.defaultLocale
                                        .localLangProficiency ??
                                    Constants.localLanguageProficiency,
                                isMandatory: true,
                                Styles.textStyleBlack14),

                            localLanguageProficiency(state),

                            ///Hindi Language Proficiency
                            CommonWidgets.textDisplay(
                                state.labels?.locale.hindiLangProficiency ??
                                    state.labels?.defaultLocale
                                        .hindiLangProficiency ??
                                    Constants.hindiLanguageProficiency,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            hindiLanguageProficiency(state),

                            ///English Language Proficiency
                            CommonWidgets.textDisplay(
                                state.labels?.locale.englishLangProficiency ??
                                    state.labels?.defaultLocale
                                        .englishLangProficiency ??
                                    Constants.englishLanguageProficiency,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            englishLanguageProficiency(state),

                            /// Physically Fit
                            CommonWidgets.textDisplay(
                                state.labels?.locale.physicallyFit ??
                                    state.labels?.defaultLocale.physicallyFit ??
                                    Constants.physicallyFit,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.physicallyFit ? 1 : 0,
                                onChangedYes:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.model.physicallyFit = true;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .onCheckBoxChange(state.model);
                                          },
                                onChangedNo:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.model.physicallyFit = false;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .onCheckBoxChange(state.model);
                                          }),

                            /// Security Experience
                            CommonWidgets.textDisplay(
                                state.labels?.locale.securityExperience ??
                                    state.labels?.defaultLocale
                                        .securityExperience ??
                                    Constants.securityExperience,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue: state.model.securityExperience,
                              textFormKey: Keys.securityExperienceKey,
                              hintText: Constants.informationhere,
                              isEnable: state.model.status != 6,
                              isDisableColor: state.model.status == 6,
                              showBorder: true,
                              onChange: (String value) {
                                state.model.securityExperience = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload Bio Data
                            CommonWidgets.textDisplay(
                                state.labels?.locale.bopData ??
                                    state.labels?.defaultLocale.bopData ??
                                    Constants.uploadBioData,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseImageUpload().uploadWidget(
                              context: context,
                              loggedInUserDetails:
                                  state.loggedInUserDetails ?? User(),
                              getFiles: bioDataFiles,
                              onImageSelected: (ImageContent data) {
                                log('-------function---onImageSelected---------');
                                List<ImageContent>? files = [];
                                files.add(data);
                                for (ImageContent image in bioDataFiles ?? []) {
                                  files.add(image);
                                }
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .addAttachment(bioDataFiles: files);
                              },
                            ),
                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.bioDataAttachments,
                              files: bioDataFiles,
                              showDownloadIcon:
                                  widget.guardingMasterData != null
                                      ? true
                                      : false,
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // CommonWidgets.textDisplay(Constants.uploadBioData,
                            //     Styles.textStyleBlack14),
                            // widget.guardingMasterData == null
                            //     ? CommonWidgets.verticalSpacerWidget(
                            //         height * 0.001)
                            //     : Container(),
                            // BaseImageUpload().uploadWidget(
                            //   context: context,
                            //   loggedInUserDetails:
                            //       state.loggedInUserDetails ?? User(),
                            //   getFiles: bioDataFiles,
                            //   onImageSelected: (ImageContent data) {
                            //     log('-------function---onImageSelected---------');
                            //     List<ImageContent>? files = [];
                            //     files.add(data);
                            //     for (ImageContent image in bioDataFiles ?? []) {
                            //       files.add(image);
                            //     }
                            //     BlocProvider.of<GuardingMasterDataDetailsCubit>(
                            //             context)
                            //         .addAttachment(bioDataFiles: files);
                            //   },
                            // ),
                            // // Attachments
                            // BaseImageUpload().getAttachment(
                            //   height: height,
                            //   attachments: state.bioDataAttachments,
                            //   files: bioDataFiles,
                            //   showDownloadIcon:
                            //       widget.guardingMasterData != null
                            //           ? true
                            //           : false,
                            // ),
                            //
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// permanent Address
                            CommonWidgets.textDisplay(
                                state.labels?.locale.permanentAddress ??
                                    state.labels?.defaultLocale
                                        .permanentAddress ??
                                    Constants.permanentAddress,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue: state.model.permanentAddress,
                              textFormKey: Keys.permanentAddressKey,
                              showBorder: true,
                              hintText: Constants.informationhere,
                              isEnable: state.model.status != 6,
                              isDisableColor: state.model.status == 6,
                              onChange: (String value) {
                                state.model.permanentAddress = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload Permanent Address Proof
                            CommonWidgets.textDisplay(
                                state.labels?.locale.permanentAddressProof ??
                                    state.labels?.defaultLocale
                                        .permanentAddressProof ??
                                    Constants.uploadPermanentAddressProof,
                                Styles.textStyleBlack14),
                            widget.guardingMasterData == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            BaseImageUpload().uploadWidget(
                              context: context,
                              loggedInUserDetails:
                                  state.loggedInUserDetails ?? User(),
                              getFiles: permanentAddressFiles,
                              onImageSelected: (ImageContent data) {
                                log('-------function---onImageSelected---------');
                                List<ImageContent>? files = [];
                                files.add(data);
                                for (ImageContent image
                                    in permanentAddressFiles ?? []) {
                                  files.add(image);
                                }
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .addAttachment(
                                        permanentAddressFiles: files);
                              },
                            ),
                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.permanentAddressAttachments,
                              files: permanentAddressFiles,
                              showDownloadIcon:
                                  widget.guardingMasterData != null
                                      ? true
                                      : false,
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Local Address
                            CommonWidgets.textDisplay(
                                state.labels?.locale.localAddress ??
                                    state.labels?.defaultLocale.localAddress ??
                                    Constants.localAddress,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue: state.model.localAddress,
                              textFormKey: Keys.localAddressKey,
                              hintText: Constants.informationhere,
                              showBorder: true,
                              isEnable: state.model.status != 6,
                              isDisableColor: state.model.status == 6,
                              onChange: (String value) {
                                state.model.localAddress = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload Local Address Proof
                            CommonWidgets.textDisplay(
                                state.labels?.locale.localAddressProof ??
                                    state.labels?.defaultLocale
                                        .localAddressProof ??
                                    Constants.uploadLocalAddressProof,
                                Styles.textStyleBlack14),
                            widget.guardingMasterData == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            BaseImageUpload().uploadWidget(
                              context: context,
                              loggedInUserDetails:
                                  state.loggedInUserDetails ?? User(),
                              getFiles: localAddressFiles,
                              onImageSelected: (ImageContent data) {
                                log('-------function---onImageSelected---------');
                                List<ImageContent>? files = [];
                                files.add(data);
                                for (ImageContent image
                                    in localAddressFiles ?? []) {
                                  files.add(image);
                                }
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .addAttachment(localAddressFiles: files);
                              },
                            ),
                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.localAddressAttachments,
                              files: localAddressFiles,
                              showDownloadIcon:
                                  widget.guardingMasterData != null
                                      ? true
                                      : false,
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Qualifications
                            CommonWidgets.textDisplay(
                              state.labels?.locale.qualifications ??
                                  state.labels?.defaultLocale.qualifications ??
                                  Constants.qualifications,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            qualificationAddButtonWidgetLoading(
                              context: context,
                              state: state,
                              selectedValues: state.model.qualifications ?? [],
                              all: state.listOfQualifications ?? [],
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// PVC Issued Date
                            CommonWidgets.textDisplay(
                              state.labels?.locale.pvcIssuedDate ??
                                  state.labels?.defaultLocale.pvcIssuedDate ??
                                  Constants.pvcIssuedDate,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: pvcIssuedDateController,
                              onlyDate: true,
                              onChange: (String value) {
                                log('---value-$value------');
                                log('-----pvcIssuedDateController---value-${pvcIssuedDateController.text}------');
                                state.model.pvcIssuedDate =
                                    Utils().formatTime(value);
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// PVC Expiry Date
                            CommonWidgets.textDisplay(
                              state.labels?.locale.pvcExpiryDate ??
                                  state.labels?.defaultLocale.pvcExpiryDate ??
                                  Constants.pvcExpiryDate,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: pvcExpiryDateController,
                              isDisabled: true,
                              onChange: (String value) {
                                // log('--fr-value-${pvcExpiryDateController
                                //     .text}------');
                                // state.model.pvcExpiryDate =
                                //     Utils().formatTime(value);
                                //
                                //   BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                //       context
                                //   ).onModelValueChange(state.model);
                                // //},
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload File
                            widget.guardingMasterData == null
                                ? CommonWidgets.textDisplay(
                                    Constants.uploadfile,
                                    Styles.textStyleBlack14)
                                : Container(),
                            widget.guardingMasterData == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            widget.guardingMasterData == null
                                ? BaseImageUpload().uploadWidget(
                                    context: context,
                                    loggedInUserDetails:
                                        state.loggedInUserDetails ?? User(),
                                    getFiles: pVCFiles,
                                    onImageSelected: (ImageContent data) {
                                      log('-------function---onImageSelected---------');
                                      List<ImageContent>? files = [];
                                      files.add(data);
                                      for (ImageContent image
                                          in pVCFiles ?? []) {
                                        files.add(image);
                                      }
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .addAttachment(pVCFiles: files);
                                    },
                                  )
                                : Container(),

                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.pVCAttachments,
                              files: pVCFiles,
                              showDownloadIcon:
                                  widget.guardingMasterData != null
                                      ? true
                                      : false,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Training Certificate
                            CommonWidgets.textDisplay(
                                state.labels?.locale
                                        .trainingCertificateProvided ??
                                    state.labels?.defaultLocale
                                        .trainingCertificateProvided ??
                                    Constants.trainingCertificate,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.trainingCertificateProvided
                                        ? 1
                                        : 0,
                                onChangedYes:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.model
                                                    .trainingCertificateProvided =
                                                true;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .onCheckBoxChange(state.model);
                                          },
                                onChangedNo:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.model
                                                    .trainingCertificateProvided =
                                                false;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .onCheckBoxChange(state.model);
                                          }),
                            if (state.model.trainingCertificateProvided) ...[
                              /// upload Training Certificate
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.trainingCertificates ??
                                      state.labels?.defaultLocale
                                          .trainingCertificates ??
                                      Constants.uploadTrainingCertificate,
                                  Styles.textStyleBlack14),
                              widget.guardingMasterData == null
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),
                              BaseImageUpload().uploadWidget(
                                context: context,
                                loggedInUserDetails:
                                    state.loggedInUserDetails ?? User(),
                                getFiles: trainingFiles,
                                onImageSelected: (ImageContent data) {
                                  log('-------function---onImageSelected---------');
                                  List<ImageContent>? files = [];
                                  files.add(data);
                                  for (ImageContent image
                                      in trainingFiles ?? []) {
                                    files.add(image);
                                  }
                                  BlocProvider.of<
                                              GuardingMasterDataDetailsCubit>(
                                          context)
                                      .addAttachment(trainingFiles: files);
                                },
                              ),
                              // Attachments
                              BaseImageUpload().getAttachment(
                                height: height,
                                attachments: state.trainingAttachments,
                                files: trainingFiles,
                                showDownloadIcon:
                                    widget.guardingMasterData != null
                                        ? true
                                        : false,
                              ),
                            ],
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Medical Certificate Valid Until
                            CommonWidgets.textDisplay(
                              state.labels?.locale
                                      .medicalCertificateValidUntil ??
                                  state.labels?.defaultLocale
                                      .medicalCertificateValidUntil ??
                                  Constants.medicalCertificateValidUntil,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              onlyDate: false,
                              showPastDate: false,
                              textController:
                                  medicalCertificateValidUntilController,
                              onChange: (String value) {
                                log('--fr-value-${medicalCertificateValidUntilController.text}------');
                                state.model.medicalCertificateValidUntil =
                                    Utils().formatTime(value);
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload Medical Certificates
                            CommonWidgets.textDisplay(
                                state.labels?.locale.medicalCertificates ??
                                    state.labels?.defaultLocale
                                        .medicalCertificates ??
                                    Constants.uploadMedicalCertificate,
                                Styles.textStyleBlack14),
                            widget.guardingMasterData == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            BaseImageUpload().uploadWidget(
                              context: context,
                              loggedInUserDetails:
                                  state.loggedInUserDetails ?? User(),
                              getFiles: medicalFiles,
                              onImageSelected: (ImageContent data) {
                                log('-------function---onImageSelected---------');
                                List<ImageContent>? files = [];
                                files.add(data);
                                for (ImageContent image in medicalFiles ?? []) {
                                  files.add(image);
                                }
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .addAttachment(medicalFiles: files);
                              },
                            ),
                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.medicalAttachments,
                              files: medicalFiles,
                              showDownloadIcon:
                                  widget.guardingMasterData != null
                                      ? true
                                      : false,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// System Access
                            CommonWidgets.textDisplay(
                                state.labels?.locale.systemAccess ??
                                    state.labels?.defaultLocale.systemAccess ??
                                    Constants.systemAccess,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: state.model.status != 6,
                                textController: systemAccessController,
                                items: systemAccessDropDownValues,
                                initialValue:
                                    state.model.systemAccess.toString(),
                                onTap: () {
                                  if (isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues:
                                            systemAccessDropDownValues
                                                .map((label) => label.key)
                                                .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              systemAccessDropDownValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      GuardingMasterDataDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  systemAccess: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// OnBoarded
                            CommonWidgets.textDisplay(
                                state.labels?.locale.onboarded ??
                                    state.labels?.defaultLocale.onboarded ??
                                    Constants.onBoarded,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue: state.model.onboarded ? 1 : 0,
                                onChangedYes:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.model.onboarded = true;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .onCheckBoxChange(state.model);
                                          },
                                onChangedNo:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.model.onboarded = false;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .onCheckBoxChange(state.model);
                                          }),

                            /// ESIC No
                            CommonWidgets.textDisplay(
                                state.labels?.locale.esicNo ??
                                    state.labels?.defaultLocale.esicNo ??
                                    Constants.esicNo,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: state.model.esicNo,
                              textFormKey: Keys.esicKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData?.esicNo ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor:
                                  (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData?.esicNo !=
                                              null))
                                      ? true
                                      : false,
                              onChange: (String value) {
                                state.model.esicNo = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// UAN  No
                            CommonWidgets.textDisplay(
                                state.labels?.locale.uanNo ??
                                    state.labels?.defaultLocale.uanNo ??
                                    Constants.uanNo,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: state.model.uanNo,
                              textFormKey: Keys.uanNoKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData?.uanNo ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor:
                                  (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData?.uanNo !=
                                              null))
                                      ? true
                                      : false,
                              onChange: (String value) {
                                state.model.uanNo = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///MSGB Exempted
                            CommonWidgets.textDisplay(
                                state.labels?.locale.msgbExempted ??
                                    state.labels?.defaultLocale.msgbExempted ??
                                    Constants.mSGBExempted,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue: state.model.msgbExempted ? 1 : 0,
                                onChangedYes:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.model.msgbExempted = true;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .showFields(msgbExempted: true);
                                            //.onModelValueChange(state.guardingMasterData
                                            //);
                                          },
                                onChangedNo:
                                    widget.guardingMasterData?.status == 4
                                        ? null
                                        : (val) {
                                            state.model.msgbExempted = false;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .showFields(
                                                    msgbExempted: false);
                                          }),

                            if (state.model.msgbExempted) ...[
                              /// MSGB Exemption Date
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.msgbExemptionDate ??
                                      state.labels?.defaultLocale
                                          .msgbExemptionDate ??
                                      Constants.mSGBExemptionDate,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDate().datePickerWidgetLoading(
                                onlyDate: true,
                                textController: mSGBExemptionDateController,
                                onChange: (String value) {
                                  state.model.msgbExemptionDate =
                                      Utils().formatTime(value);

                                  BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                      context)
                                      .onModelValueChange(state.model);
                                },
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            if (!state.model.msgbExempted) ...[
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.msgbFormBSubmitted ??
                                      state.labels?.defaultLocale
                                          .msgbFormBSubmitted ??
                                      Constants.mSGBFormBSubmitted,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                  isDisabled: state.model.status != 6,
                                  textController: mSGbFormBSubmittedController,
                                  items: mSGBFormBSubmittedDropDownValues,
                                  initialValue:
                                      state.model.msgbFormBSubmitted.toString(),
                                  onTap: () {
                                    if (isDisabled) {
                                      BaseDropDown().assetTypeDialog(
                                          context: context,
                                          dropDownValues:
                                              mSGBFormBSubmittedDropDownValues
                                                  .map((label) => label.key)
                                                  .toList(),
                                          onTap: (String value) {
                                            Label? selectedLabel;
                                            selectedLabel =
                                                mSGBFormBSubmittedDropDownValues
                                                    .firstWhere(
                                              (label) => label.key == value,
                                              orElse: () => const Label(
                                                  key: '', value: ''),
                                            );
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .updateDropdownValues(
                                                    msgbFormBSubmitted:
                                                        int.tryParse(
                                                            selectedLabel
                                                                .value));
                                          });
                                    }
                                  }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            /// Date of First Covid Dose
                            CommonWidgets.textDisplay(
                              state.labels?.locale.covidFirstDoseDate ??
                                  state.labels?.defaultLocale
                                      .covidFirstDoseDate ??
                                  Constants.dateOfFirstCovidDose,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              onlyDate: false,
                              showFutureDate: false,
                              textController: dateOfFirstCovidDoseController,
                              onChange: (String value) {
                                log('--fr-value-${dateOfFirstCovidDoseController.text}------');
                                state.model.covidFirstDoseDate =
                                    Utils().formatTime(value);
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of Second Covid Dose
                            CommonWidgets.textDisplay(
                              state.labels?.locale.covidSecondDoseDate ??
                                  state.labels?.defaultLocale
                                      .covidSecondDoseDate ??
                                  Constants.dateOfSecondCovidDose,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              onlyDate: false,
                              showFutureDate: false,
                              textController: dateOfSecondCovidDoseController,
                              onChange: (String value) {
                                log('--fr-value-${dateOfSecondCovidDoseController.text}------');
                                state.model.covidSecondDoseDate =
                                    Utils().formatTime(value);
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of Precautionary Covid Dose
                            CommonWidgets.textDisplay(
                              state.labels?.locale.covidPrecautionaryDoseDate ??
                                  state.labels?.defaultLocale
                                      .covidPrecautionaryDoseDate ??
                                  Constants.dateOfPrecautionaryCovidDose,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              onlyDate: false,
                              showFutureDate: false,
                              textController: dateOfPrecautionaryCovidDose,
                              onChange: (String value) {
                                log('--fr-value-${dateOfPrecautionaryCovidDose.text}------');
                                state.model.covidPrecautionaryDoseDate =
                                    Utils().formatTime(value);
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// ERT Certification Date
                            CommonWidgets.textDisplay(
                              state.labels?.locale.ertCertificationDate ??
                                  state.labels?.defaultLocale
                                      .ertCertificationDate ??
                                  Constants.ertCertificationDate,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              onlyDate: false,
                              showFutureDate: false,
                              textController: ertCertificationDate,
                              onChange: (String value) {
                                log('--fr-value-${ertCertificationDate.text}------');
                                state.model.ertCertificationDate =
                                    Utils().formatTime(value);
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// First Aid Training Completion Date
                            CommonWidgets.textDisplay(
                              state.labels?.locale
                                      .firstAidTrainingCompletionDate ??
                                  state.labels?.defaultLocale
                                      .firstAidTrainingCompletionDate ??
                                  Constants.firstAidTrainingCompletionDate,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              onlyDate: false,
                              showFutureDate: false,
                              textController: firstAidTrainingCompletionDate,
                              onChange: (String value) {
                                log('--fr-value-${firstAidTrainingCompletionDate.text}------');
                                state.model.firstAidTrainingCompletionDate =
                                    Utils().formatTime(value);
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// CSR Participation
                            CommonWidgets.textDisplay(
                                state.labels?.locale.csrParticipation ??
                                    state.labels?.defaultLocale
                                        .csrParticipation ??
                                    Constants.csrParticipation,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.csrParticipation ? 1 : 0,
                                onChangedYes:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.model.csrParticipation = true;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .showFields(
                                                    csrParticipation: true);
                                          },
                                onChangedNo:
                                    widget.guardingMasterData?.status == 4
                                        ? null
                                        : (val) {
                                            state.model.csrParticipation =
                                                false;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .showFields(
                                                    csrParticipation: false);
                                          }),

                            if (state.model.csrParticipation) ...[
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.csrParticipationDates ??
                                      state.labels?.defaultLocale
                                          .csrParticipationDates ??
                                      Constants.csrParticipationDate,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return AddDatePopUp(
                                          guardingMasterData:
                                              guardingMasterData,
                                          mainContext: context,
                                          onSubmit: (GuardingMastersDataModel
                                              guardingMasterData) {
                                            //loginFormKey.currentState!.validate();
                                            FocusScope.of(context).unfocus();
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .submitForm(isSaveOnly: true);
                                          },
                                        );
                                      });
                                },
                                child: Row(
                                  children: <Widget>[
                                    // Expanded(
                                    //child:
                                    const SizedBox(width: 14),
                                    SvgPicture.asset(
                                      AppIcon.pluscircle,
                                      //color: AppColors.navigationSkybluecolor,
                                    ),
                                    // ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      Constants.addParticipationDates,
                                      style: TextStyle(
                                        color: AppColors.navigationSkybluecolor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            Column(
                              children: getParticipationDates(state, height),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Special Achivements
                            CommonWidgets.textDisplay(
                                state.labels?.locale.specialAchievement ??
                                    state.labels?.defaultLocale
                                        .specialAchievement ??
                                    Constants.specialAchievements,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                    state.model.specialAchievement ? 1 : 0,
                                onChangedYes:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.model.specialAchievement =
                                                true;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .showFields(
                                                    specialAchievement: true);
                                            // .onModelValueChange(state.guardingMasterData
                                            // );
                                          },
                                onChangedNo:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.model.specialAchievement =
                                                false;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .showFields(
                                                    specialAchievement: false);
                                          }),

                            if (state.model.specialAchievement) ...[
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                initialValue:
                                    state.model.specialAchievementText,
                                textFormKey: Keys.specialAchievementsKey,
                                hintText: Constants.informationhere,
                                isEnable: state.model.status != 6,
                                isDisableColor: state.model.status == 6,
                                onChange: (String value) {
                                  state.model.specialAchievementText = value;
                                  context
                                      .read<GuardingMasterDataDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            /// Additional Initiatives Info
                            CommonWidgets.textDisplay(
                                state.labels?.locale.additionalInitiatives ??
                                    state.labels?.defaultLocale
                                        .additionalInitiatives ??
                                    Constants.additionalInitiativesInfo,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue: state.model.additionalInitiatives,
                              textFormKey: Keys.additionInitiativesKey,
                              hintText: Constants.informationhere,
                              showBorder: true,
                              isEnable: state.model.status != 6,
                              isDisableColor: state.model.status == 6,
                              onChange: (String value) {
                                state.model.additionalInitiatives = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                          ]),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// SubmitButton
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cancelButtonDisplay(),
                            submitButtonDisplay()
                          ],
                        ),

                        CommonWidgets.verticalSpacerWidget(height * 0.04),
                      ])))
        ])));
  }

  Row localLanguageProficiency(GuardingMasterDataDetailsState state) {
    return Row(
      children: [
        LanguageCheckBox(
          context: context,
          label: Constants.read,
          value: state.model.localLangProficiencyR ?? false,
          onChanged: (bool? value) {
            state.model.localLangProficiencyR = value;
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .onCheckBoxChange(state.model);
          },
        ),
        LanguageCheckBox(
          context: context,
          label: Constants.write,
          value: state.model.localLangProficiencyW ?? false,
          onChanged: (bool? value) {
            state.model.localLangProficiencyW = value;
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .onCheckBoxChange(state.model);
          },
        ),
        LanguageCheckBox(
          context: context,
          label: Constants.speak,
          value: state.model.localLangProficiencyS ?? false,
          onChanged: (bool? value) {
            state.model.localLangProficiencyS = value;
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .onCheckBoxChange(state.model);
          },
        )
      ],
    );
  }

  Row hindiLanguageProficiency(GuardingMasterDataDetailsState state) {
    return Row(
      children: [
        LanguageCheckBox(
          context: context,
          label: Constants.read,
          value: state.model.hindiLangProficiencyR ?? false,
          onChanged: (bool? value) {
            state.model.hindiLangProficiencyR = value;
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .onCheckBoxChange(state.model);
          },
        ),
        LanguageCheckBox(
          context: context,
          label: Constants.write,
          value: state.model.hindiLangProficiencyW ?? false,
          onChanged: (bool? value) {
            state.model.hindiLangProficiencyW = value;
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .onCheckBoxChange(state.model);
          },
        ),
        LanguageCheckBox(
          context: context,
          label: Constants.speak,
          value: state.model.hindiLangProficiencyS ?? false,
          onChanged: (bool? value) {
            state.model.hindiLangProficiencyS = value;
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .onCheckBoxChange(state.model);
          },
        )
      ],
    );
  }

  Row englishLanguageProficiency(GuardingMasterDataDetailsState state) {
    return Row(
      children: [
        LanguageCheckBox(
          context: context,
          label: Constants.read,
          value: state.model.englishLangProficiencyR ?? false,
          onChanged: (bool? value) {
            state.model.englishLangProficiencyR = value;
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .onCheckBoxChange(state.model);
          },
        ),
        LanguageCheckBox(
          context: context,
          label: Constants.write,
          value: state.model.englishLangProficiencyW ?? false,
          onChanged: (bool? value) {
            state.model.englishLangProficiencyW = value;
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .onCheckBoxChange(state.model);
          },
        ),
        LanguageCheckBox(
          context: context,
          label: Constants.speak,
          value: state.model.englishLangProficiencyS ?? false,
          onChanged: (bool? value) {
            state.model.englishLangProficiencyS = value;
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .onCheckBoxChange(state.model);
          },
        )
      ],
    );
  }

  List<Widget> getParticipationDates(
      GuardingMasterDataDetailsState state, height) {
    List<Widget> widgets = [];

    log('-state.participationDates---${state.participationDates?.length}---');
    for (String date in state.participationDates ?? []) {
      TextEditingController dateController = TextEditingController();
      // dateController.text = Utils.timestamptoDateConversion(
      //     int.parse(widget.guardingMasterData?.dateOfBirth ?? '0'),
      //     Constants.dateFormat);
      dateController.text = date;
      widgets.add(
        BaseDate().datePickerWidgetLoading(
          textController: dateController,
          onChange: (String value) {
            log('--fr-value-${dateController.text}------');
            // widget.guardingMasterData?.inputDate = value;
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .onModelValueChange(state.model);
          },
          context: context,
        ),
      );
      widgets.add(CommonWidgets.verticalSpacerWidget(height * 0.01));
    }
    return widgets;
  }

  String getStatusString(int status) {
    switch (status) {
      case 1:
        return 'Active';
      case 2:
        return 'InActive';
      case 3:
        return 'Leave';
      case 4:
        return 'Week Off ';
      default:
        return 'Unknown Status';
    }
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
        BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }

  // Widget uploadWidget({
  //   required BuildContext context,
  //   required EntrySecurity loggedInUserDetails,
  //   required Function onImageSelected,
  //   // required List<CreateImage>? getFiles,
  // }) {
  //   return Container(
  //     height: 60,
  //     decoration: BoxDecoration(
  //         border: Border.all(
  //           color: const Color(0xFFCACACA),
  //           width: 1.0,
  //         ),
  //         borderRadius: const BorderRadius.all(Radius.circular(8))),
  //     child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
  //       Padding(
  //         padding: const EdgeInsets.only(right: 5.0),
  //         child: ElevatedButton.icon(
  //           style:
  //           ElevatedButton.styleFrom(fixedSize: const Size(140, 50)),
  //           onPressed: () {
  //             showDialog(
  //                 context: context,
  //                 builder: (BuildContext dialogContext) {
  //                   return UploadAttachment(
  //                     userdetails: loggedInUserDetails,
  //                     getFiles: getFiles ?? [],
  //                     onImageSelected: onImageSelected,
  //                   );
  //                 });
  //           },
  //
  //           icon: SvgPicture.asset(
  //             //AppIcon.dropdownicon,
  //             AppIcon.uploadicon,
  //             //fit: BoxFit.,
  //             color: AppColors.backgroundWhitecolor,
  //             width: 13,
  //             height: 13,
  //             key: const Key(Keys.userIcon),
  //           ),
  //           label: const Text(
  //             Constants.clicktoupload,
  //             style: Styles.textStyleRegularNormalWhite12,
  //           ),
  //         ),
  //       ),
  //     ]),
  //   );
  // }

  Widget locationWidgetdislay(GuardingMasterDataDetailsState state) {
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

                BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
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

  Widget attachmentListviews(
    List<ImageContent>? attachmentListviews,
    List<ImageContent>? attachmentListviews1,
  ) {
    log('----attachmentListviews---cc--${attachmentListviews?.length}-----------');
    log('----attachmentListviews1----found-${attachmentListviews1?.length}-----------');

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFCACACA),
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              attachmentListviews1?.length ?? attachmentListviews?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            ImageContent? imagedata;
            ImageContent? imagedata1;
            if (widget.guardingMasterData != null) {
              imagedata1 = attachmentListviews1?[index];
            } else {
              imagedata = attachmentListviews?[index];
            }

            return Column(
              children: <Widget>[
                ListTile(
                  trailing: widget.guardingMasterData != null
                      ? SvgPicture.asset(AppIcon.download,
                          color: AppColors.boldgreyBackground)
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                  onTap: () {
                    DownloadImage().saveImage(
                        context, imagedata1?.id ?? 0, imagedata1?.title ?? '');
                  },
                  title: widget.guardingMasterData != null
                      ? Text(imagedata1?.title ?? '')
                      : Text(imagedata?.title ?? ''),
                ),

                const Divider(
                  color: Color(0xFFCACACA),
                  thickness: 1,
                ), //
              ],
            );
          }),
    );
  }

  Widget qualificationAddButtonWidgetLoading({
    required BuildContext context,
    required GuardingMasterDataDetailsState state,
    required List<Organisation> selectedValues,
    required List<Organisation> all,
  }) {
    String title = '';
    log('--selectedValues.length-${selectedValues.length}--');
    if (selectedValues.isNotEmpty) {
      for (int i = 0; i < selectedValues.length; i++) {
        Organisation qualification = selectedValues[i];
        log('--entity name-${qualification.name}--');

        String value = qualification.name ?? '';
        title = '$title  $value';
      }
    }

    return TextfieldAddButton(
      title: title,
      height: (selectedValues.length) > 4
          ? (selectedValues.length) > 9
              ? 140
              : 100
          : 60,
      isDisableColor: false,
      onTap: () {
        _showQualificationSelectionDialog(context, state);
      },
    );
  }

  void _showQualificationSelectionDialog(
      BuildContext context, GuardingMasterDataDetailsState state) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomMultipleSelectionListTexts(
          onLeftButtonTap: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AddNewFields(
                    title: Constants.addQualificationType,
                  );
                });
          },
          allItems: state.listOfQualifications ?? [],
          selectedValues: state.model.qualifications ?? [],
          onTap: (List<Organisation> selectedQualifications) {
            log('--selectedEntities----${selectedQualifications.length}');
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .updateDropdownValues(qualifications: selectedQualifications);
            Navigator.of(context).pop(); // Close the dialog
          },
          leftImageName: AppIcon.addicon, // Provide your left button icon
        );
      },
    );
  }
}
