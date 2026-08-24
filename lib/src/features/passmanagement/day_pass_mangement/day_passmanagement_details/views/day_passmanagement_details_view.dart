import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';

import '../../models/day_pass_management_model.dart';
import '../cubits/day_passmanagement_details_cubit.dart';

class DayPassManagementDetailsView extends StatefulWidget {
  final DayPassManagementModel? model;
  final String title;
  final ExtraProperties? extraProperties;

  const DayPassManagementDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<DayPassManagementDetailsView> createState() =>
      _DayPassManagementDetailsViewState();
}

class _DayPassManagementDetailsViewState
    extends State<DayPassManagementDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController returnableTextController = TextEditingController();

  User? userDetails;
  List<ImageContent> getFiles = [];
  TextEditingController takenOutOnDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController expectedDateOfReturnController =
      TextEditingController();
  TextEditingController passValidFromController = TextEditingController();
  TextEditingController passValidUntilController = TextEditingController();
  bool isReadOnly = false;
  TextEditingController passTypeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController dbSponsorController = TextEditingController();
  TextEditingController hostController = TextEditingController();
  TextEditingController updateStatusTextController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();
  TextEditingController returnedTimeController = TextEditingController();

  final FocusNode sentToFocusNode = FocusNode();

  List<ImageContent> uploadFiles = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DayPassManagementDetailsCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool showSaveSubmitButtons = false;
  bool lock = false;
  String? previousPassValidUntileTime;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<DayPassManagementDetailsCubit,
        DayPassManagementDetailsState>(
      listener: (context, state) {
        log('-state.status--${state.status}--');
        log('123 ${state.message}--');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.dayPassManagementTitle,
            message: state.message,
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, dayPassManagementListRoute,
                  arguments: {});
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
      },
      builder: (context, state) {
        nameController.text = state.model.employee != null
            ? '${state.model.employee?.firstName ?? ''} ${state.model.employee?.lastName ?? ''}'
            : state.model.employeeName ?? '';
        dbSponsorController.text =
            '${state.model.host?.firstName ?? ''} ${state.model.host?.lastName ?? ''}';
        hostController.text = state.model.host?.name ?? '';
        employeeIdController.text = state.model.employeeId ?? '';
        companyNameController.text = state.model.companyType?.name != 'FTE'
            ? state.model.companyName ?? ''
            : 'Deutsche Bank';
        if (state.model.status == 0 && !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 1 && !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }

        if (state.model.status != null && state.model.status != 0) {
          isReadOnly = true;
        }

        showSaveSubmitButtons = (widget.model == null ||
                state.model.status == 0 ||
                state.model.status == 1) &&
            state.model.lock.isEmptyOrNull;

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: (widget.model == null || state.model.status == 0) &&
                state.status != FormStatus.loading,
            pdfAPIName:
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.passManagementModuleCode}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<DayPassManagementDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: true,
              );
            },
            showSubmitButton:
                showSaveSubmitButtons && state.status != FormStatus.loading,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<DayPassManagementDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: false,
              );
            },
            showLikeButton: false,
            showDisLikeButton: false,
          ),
          backgroundColor: Colors.transparent,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(DayPassManagementDetailsState state) {
    passValidFromController.text = state.model.startTime == null
        ? Utils.timestampToDateConversion(
            DateTime.now().millisecondsSinceEpoch, Constants.fulldateFormat)
        : Utils.timestampToDateConversion(
            int.tryParse(state.model.startTime ?? '') ??
                DateTime.now().millisecondsSinceEpoch,
            Constants.fulldateFormat);

    passValidUntilController.text = state.model.endTime != null
        ? Utils.timestampToDateConversion(
            int.tryParse(state.model.endTime ?? '') ??
                DateTime.now()
                    .millisecondsSinceEpoch, // Fallback to current timestamp
            Constants.fulldateFormat)
        : Utils.timestampToDateConversion(
            DateTime.now()
                .add(const Duration(hours: 12))
                .millisecondsSinceEpoch, // One day ahead
            Constants.fulldateFormat);

    if ((state.model.status == 2 ||
        state.model.status == 8 ||
        state.model.status == 9)) {
      returnedTimeController.text = state.model.returnedTime != null
          ? Utils.timestampToDateConversion(
              int.tryParse(state.model.returnedTime ?? '') ??
                  DateTime.now()
                      .millisecondsSinceEpoch, // Fallback to current timestamp
              Constants.fulldateFormat)
          : '';
    }
    state.model.startTime == passValidFromController.text;
    // state.model.endTime == passValidUntilController.text;
  }

  getBodybuilder(DayPassManagementDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      uploadFiles = state.uploadAttachments;
      uploadFiles = state.model.evidenceDocuments ?? [];
    }

    return Stack(
      children: [
        // 🔹 Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg2.png',
            fit: BoxFit.cover,
          ),
        ),

        // 🔹 Blur Layer
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            child: Container(
              color: Colors.black.withValues(alpha: 0.08), // optional tint
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
                child: Form(
                  key: _formKey,
                  autovalidateMode: isReadOnly
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AbsorbPointer(
                          absorbing:
                              !showSaveSubmitButtons && IgnorePointer == false,
                          child: Column(
                            children: [
                              if (!state.model.lock.isEmptyOrNull) ...[
                                RecordLockedWidget(text: '${state.model.lock}'),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  Constants.generalinformation,
                                  style: Styles.textStyleRegularNormalWhite18,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Status
                              CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: statusController,
                                items: passManagementStatusValues,
                                initialValue: '${state.model.status ?? 0}',
                                onTap: () {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Created By
                              CommonWidgets.horizontalTextHandling(
                                  state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.createdby,
                                  isMandatory: true,
                                  '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Updated Status
                              if (
                                  widget.model?.status == 1 ||
                                  widget.model?.status == 3) ...[
                                CommonWidgets.textDisplay(
                                    isMandatory: true,
                                    state.labels?.locale.updateStatus ??
                                        state.labels?.defaultLocale
                                            .updateStatus ??
                                        Constants.updatestatus,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                TextFieldAddButton(
                                  title: updateStatusTextController.text,
                                  height: 70,
                                  isDisableColor: widget.model != null &&
                                      !widget.model!.lock.isEmptyOrNull,
                                  onTap: () {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.getStatus ?? [],
                                      onTap: (Organisation org) {
                                        if (org.name == 'Lost') {
                                          Future.delayed(
                                              const Duration(milliseconds: 200),
                                              () {
                                            var dialog = CustomAlertDialog(
                                              title: Constants.updatestatus,
                                              message:
                                                  "Are you sure you want to select \"${org.name}\"?",
                                              onPositivePressed: () {
                                                Navigator.pop(context);
                                                updateStatusTextController
                                                    .text = org.name!;
                                                setState(() {});
                                                BlocProvider.of<
                                                            DayPassManagementDetailsCubit>(
                                                        context)
                                                    .updateDropdownValues(
                                                        updatedStatus: org);
                                              },
                                              positiveBtnText: Constants.yes,
                                              negativeBtnText: Constants.no,
                                            );

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  dialog,
                                            );
                                          });
                                        } else {
                                          updateStatusTextController.text =
                                              org.name!;
                                          setState(() {});
                                          BlocProvider.of<
                                                      DayPassManagementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  updatedStatus: org);
                                        }
                                      },
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Location
                              CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseLocationDropdown().locationWidgetDisplay(
                                  isEnabled: (!isReadOnly) && !lock,
                                  context: context,
                                  locations: state.locations ?? Locations(),
                                  selectedLocationName:
                                      state.model.location?.name ?? '',
                                  onTap: (Organisation? location) {
                                    BlocProvider.of<
                                                DayPassManagementDetailsCubit>(
                                            context)
                                        .updateLocationDropdownValue(
                                            location: location);
                                  }),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Date of creation
                              CommonWidgets.textDisplay(
                                state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              dateCreateWidgetDisplay(
                                  state.model.inputDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Sl No.
                              CommonWidgets.horizontalTextHandling(
                                state.labels?.locale.slNo ??
                                    state.labels?.defaultLocale.slNo ??
                                    Constants.slno,
                                state.model.slNo ?? '',
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Entity
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.entity ??
                                      state.labels?.defaultLocale.entity ??
                                      Constants.entity,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              BaseEntitiesSelection().entityDropDownSelection(
                                context: context,
                                selectedValues: state.model.entities ?? [],
                                all: state.listOfEntities ?? [],
                                enabled: !isReadOnly,
                                onTap: (List<Organisation> selectedEntities) {
                                  bool hasDws = selectedEntities.any((e) => e.name == 'DWS');

                                  //  Get selected location name
                                  String? locationName = state.model.location?.name;
                                  // Check if location is allowed
                                  bool isValidLocation = locationName == 'Business Bay' ||
                                      locationName == 'VTP' ||
                                      locationName == 'NKB';

                                  if (hasDws && isValidLocation) {
                                    state.model.passTypeName = "DWS Day Pass";
                                  } else {
                                    state.model.passTypeName = "Day Pass";
                                  }
                                  if (selectedEntities.length > 1) {
                                    showDialog(
                                      context: context,
                                      barrierColor: Colors.black.withValues(alpha: 0.3),
                                      builder: (context) {
                                        return Dialog(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                              child: Container(
                                                padding: const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.black.withValues(alpha: 0.15),
                                                  border: Border.all(
                                                    color: Colors.white.withValues(alpha: 0.3),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      "Validation",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    const Text(
                                                      "Multiple entities selection is restricted.",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                                                        elevation: 0,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text("OK"),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                    return;
                                  }
                                  BlocProvider.of<
                                              DayPassManagementDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          entities: selectedEntities);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                functionToCall: () {
                                  // refresh the list
                                  BlocProvider.of<
                                              DayPassManagementDetailsCubit>(
                                          context)
                                      .refreshList();
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Pass Type
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.passType ??
                                      state.labels?.defaultLocale.passType ??
                                      Constants.passtype,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.passTypeName,
                                height: 70,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.passType!,
                                      onTap: (Organisation passType) {
                                        state.model.passTypeName =
                                            passType.name;
                                        BlocProvider.of<
                                                    DayPassManagementDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                passType: passType);
                                      },
                                      leftImage: false,
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    DayPassManagementDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Company Type
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.companyType ??
                                      state.labels?.defaultLocale.companyType ??
                                      Constants.companyType,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.companyType?.name,
                                height: 70,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations:
                                          state.getCompanyTypeResponse,
                                      onTap: (Organisation companyType) {
                                        BlocProvider.of<
                                                    DayPassManagementDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                companyType: companyType);
                                      },
                                      leftImage: false,
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    DayPassManagementDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Company Name
                              CommonWidgets.textDisplay(
                                state.labels?.locale.companyName ??
                                    state.labels?.defaultLocale.companyName ??
                                    Constants.companyName,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.text,
                                textFormKey: Keys.challanKey,
                                controller: companyNameController,
                                characterLimit:
                                    Constants.characterLimitIdTextFormField,
                                hintText: '',
                                isEnable:
                                    (state.model.companyType?.name != 'FTE') &&
                                            (state.model.status == null ||
                                                state.model.status == 0)
                                        ? true
                                        : false,
                                isDisableColor: false,
                                onChange: (String value) {
                                  state.model.companyName =
                                      state.model.companyType?.name != 'FTE'
                                          ? value
                                          : "Deutsche Bank";
                                  context
                                      .read<DayPassManagementDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              if (state.model.companyType?.name !=
                                      'Exceptions' &&
                                  state.model.companyType?.name !=
                                      'CWR T2') ...[
                                /// Employee Id
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.employeeId ??
                                        state
                                            .labels?.defaultLocale.employeeId ??
                                        Constants.employeeid,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.employee?.employeeId,
                                  height: 70,
                                  isDisableColor: isReadOnly,
                                  onTap: () {
                                    if (!isReadOnly) {
                                      BaseOrganisationDialog().userDialog(
                                        employeeId: true,
                                        context: context,
                                        users: state.employee!,
                                        isDbUser: true,
                                        onTap: (BaseUser user) {
                                          BlocProvider.of<
                                                      DayPassManagementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                            employee: user,
                                          );
                                        },
                                        roleName:
                                            ConstantUserRoles.atomStaticUser,
                                        locationId: state.model.location!.id!,
                                        functionToCall: (BaseUser user) {
                                          BlocProvider.of<
                                                      DayPassManagementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                            employee: user,
                                          );
                                          // refresh the list
                                          BlocProvider.of<
                                                      DayPassManagementDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        },
                                      );
                                    }
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              if (state.model.companyType?.name ==
                                  'CWR T2') ...[
                                ///EmployeeId
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.employeeId ??
                                        state
                                            .labels?.defaultLocale.employeeId ??
                                        Constants.employeeid,
                                    isMandatory: true,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  textInputType: TextInputType.number,
                                  textFormKey: Keys.contactNoKey,
                                  controller: employeeIdController,
                                  hintText: '',
                                  isEnable: state.model.companyType?.name ==
                                              'CWR T2' &&
                                          !isReadOnly
                                      ? true
                                      : false,
                                  isDisableColor: true,
                                  onChange: (String value) {
                                    state.model.employeeId = value;
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              ///Name
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.employeeName ??
                                      state
                                          .labels?.defaultLocale.employeeName ??
                                      Constants.name,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                controller: nameController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.contactNoKey,
                                hintText: '',
                                isEnable: (state.model.companyType?.name ==
                                                'Exceptions' ||
                                            state.model.companyType?.name ==
                                                'CWR T2') &&
                                        (state.model.status == null ||
                                            state.model.status == 0)
                                    ? true
                                    : false,
                                isDisableColor: true,
                                onChange: (String value) {
                                  state.model.employeeName = value;
                                  state.model.employee?.name = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (state.model.companyType?.name == 'CWR T1' ||
                                  state.model.companyType?.name ==
                                      'CWR T2') ...[
                                ///Db Sponsor Employee Id
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.cwrSponsorEmployeeId ??
                                        state.labels?.defaultLocale
                                            .cwrSponsorEmployeeId ??
                                        Constants.dbSponsorEmployeeId,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.host?.employeeId,
                                  height: 70,
                                  isDisableColor: isReadOnly,
                                  onTap: () {
                                    if (!isReadOnly) {
                                      BaseOrganisationDialog().userDialog(
                                        employeeId: true,
                                        context: context,
                                        users: state.host!,
                                        isDbUser: true,
                                        onTap: (BaseUser user) {
                                          BlocProvider.of<
                                                      DayPassManagementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                            host: user,
                                          );
                                        },
                                        roleName:
                                            ConstantUserRoles.atomStaticUser,
                                        locationId: state.model.location!.id!,
                                        functionToCall: (BaseUser user) {
                                          BlocProvider.of<
                                                      DayPassManagementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                            host: user,
                                          );
                                          // refresh the list
                                          BlocProvider.of<
                                                      DayPassManagementDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        },
                                      );
                                    }
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///DB Sponsor
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.cwrSponsor ??
                                        state
                                            .labels?.defaultLocale.cwrSponsor ??
                                        Constants.dbSponsor,
                                    isMandatory: true,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  controller: dbSponsorController,
                                  textInputType: TextInputType.text,
                                  textFormKey: Keys.contactNoKey,
                                  hintText: '',
                                  isEnable: false,
                                  isDisableColor: true,
                                  onChange: (String value) {},
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],
                              if (state.model.companyType?.name ==
                                  'Exceptions') ...[
                                ///Host Employee Id
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.hostEmployeeId ??
                                        state.labels?.defaultLocale
                                            .hostEmployeeId ??
                                        Constants.hostemployeeid,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                TextFieldAddButton(
                                  title: state.model.hostEmployeeId,
                                  height: 70,
                                  isDisableColor: isReadOnly,
                                  onTap: () {
                                    if (!isReadOnly) {
                                      BaseOrganisationDialog().userDialog(
                                        employeeId: true,
                                        context: context,
                                        users: state.host!,
                                        isDbUser: true,
                                        onTap: (BaseUser user) {
                                          BlocProvider.of<
                                                      DayPassManagementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                            host: user,
                                          );
                                        },
                                        roleName:
                                            ConstantUserRoles.atomStaticUser,
                                        locationId: state.model.location!.id!,
                                        functionToCall: (BaseUser user) {
                                          BlocProvider.of<
                                                      DayPassManagementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                            host: user,
                                          );
                                          // refresh the list
                                          BlocProvider.of<
                                                      DayPassManagementDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        },
                                      );
                                    }
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                ///Host
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.host ??
                                        state.labels?.defaultLocale.host ??
                                        Constants.host,
                                    isMandatory: true,
                                    Styles.textStyleWhite16),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                FlutterInputField(
                                  controller: hostController,
                                  textInputType: TextInputType.text,
                                  textFormKey: Keys.contactNoKey,
                                  hintText: '',
                                  isEnable: false,
                                  isDisableColor: true,
                                  onChange: (String value) {},
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              ///  Department
                              CommonWidgets.textDisplay(
                                state.labels?.locale.department ??
                                    state.labels?.defaultLocale.department ??
                                    Constants.department,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              TextFieldAddButton(
                                title: state.model.department?.name,
                                height: 70,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseOrganisationDialog().departmentDialog(
                                        context: context,
                                        organisations: state.departments,
                                        onTap: (Organisation department) {
                                          state.model.department?.name =
                                              department.name;
                                          BlocProvider.of<
                                                      DayPassManagementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  department: department);
                                        },
                                        createEntity: false,
                                        functionToCall: () {
                                          // refresh the list
                                          BlocProvider.of<
                                                      DayPassManagementDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        });
                                    FocusScope.of(context)
                                        .requestFocus(sentToFocusNode);
                                  }
                                },
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Reason for Day Pass
                              CommonWidgets.textDisplay(
                                state.labels?.locale.dayPassReason ??
                                    state.labels?.defaultLocale.dayPassReason ??
                                    Constants.reasonfordaypass,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              TextFieldAddButton(
                                title: state.model.dayPassReason?.name,
                                height: 70,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.dayPassReason,
                                      onTap: (Organisation department) {
                                        state.model.endTime = previousPassValidUntileTime;
                                        previousPassValidUntileTime = null;
                                        BlocProvider.of<
                                                    DayPassManagementDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                dayPassReason: department);
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (state.model.dayPassReason?.name ==
                                      'External Regulators' ||
                                  state.model.dayPassReason?.name ==
                                      'External auditors') ...[
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.exceptionalApproval ??
                                        state.labels?.defaultLocale
                                            .exceptionalApproval ??
                                        Constants.exceptionalApproval,
                                    isMandatory: true,
                                    Styles.textStyleWhite16),
                                RadioButtonsYesNo(
                                    status: state.model.status ?? 0,
                                    selectedValue:
                                        state.model.exceptionalApproval ? 1 : 0,
                                    onChangedYes: isReadOnly
                                        ? null
                                        : (val) {
                                      previousPassValidUntileTime ??= state.model.endTime;
                                            state.model.exceptionalApproval =
                                                true;
                                            BlocProvider.of<
                                                        DayPassManagementDetailsCubit>(
                                                    context)
                                                .onCheckBoxChange(state.model);
                                          },
                                    onChangedNo: isReadOnly
                                        ? null
                                        : (val) {
                                            state.model.exceptionalApproval =
                                                false;
                                            state.model.endTime = previousPassValidUntileTime;
                                            previousPassValidUntileTime = null;
                                            BlocProvider.of<
                                                        DayPassManagementDetailsCubit>(
                                                    context)
                                                .onCheckBoxChange(state.model);
                                          }),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              /// Day Pass No
                              CommonWidgets.textDisplay(
                                state.labels?.locale.dayPassInfo ??
                                    state.labels?.defaultLocale.dayPassInfo ??
                                    Constants.dayPassNo,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              TextFieldAddButton(
                                title: state.model.passNo,
                                height: 70,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.passNo!,
                                      onTap: (Organisation department) {
                                        state.model.passNo = department.name;
                                        BlocProvider.of<
                                                    DayPassManagementDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                passNo: department);
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Pass Valid From
                              CommonWidgets.textDisplay(
                                state.labels?.locale.startTime ??
                                    state.labels?.defaultLocale.startTime ??
                                    Constants.passvlidfrom,
                                isMandatory: true,
                                Styles.textStyleWhite16,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDate().datePickerWidgetLoading(
                                textController: passValidFromController,
                                isDisabled: true,
                                onlyDate: false,
                                onChange: (String value) {
                                  passValidFromController.text = value;
                                  BlocProvider.of<
                                              DayPassManagementDetailsCubit>(
                                          context)
                                      .onModelValueChange(state.model);
                                },
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Pass Valid Until
                              CommonWidgets.textDisplay(
                                state.labels?.locale.endTime ??
                                    state.labels?.defaultLocale.endTime ??
                                    Constants.passvliduntil,
                                isMandatory: true,
                                Styles.textStyleWhite16,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              BaseDate().datePickerWidgetLoading(
                                textController: passValidUntilController,
                                isDisabled: (state.model.companyType?.name ==
                                                'Exceptions' ||
                                            state.model.dayPassReason?.name ==
                                                'New joiner waiting for access card' ||
                                            state.model.dayPassReason?.name ==
                                                'New Joiner waiting for photo ID' || ((state.model.dayPassReason?.name ==
                                    'External auditors' || state.model.dayPassReason?.name ==
                                    'External Regulators')&&  state.model.exceptionalApproval == true)) &&
                                        !isReadOnly
                                    ? false
                                    : true,
                                onlyDate: false,
                                showPastDate: false,
                                showFutureDate: true,
                                onChange: (String value) {
                                  state.model.endTime =
                                      Utils().formatTime(value);
                                  BlocProvider.of<
                                              DayPassManagementDetailsCubit>(
                                          context)
                                      .onModelValueChange(state.model);
                                },
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              if (state.model.status == 2 ||
                                  state.model.status == 8 ||
                                  state.model.status == 9) ...[
                                /// Pass Collected By
                                CommonWidgets.horizontalTextHandling(
                                    state.labels?.locale.handoverSecurity ??
                                        state.labels?.defaultLocale
                                            .handoverSecurity ??
                                        Constants.passCollectedBy,
                                    isMandatory: true,
                                    '${state.model.handoverSecurity?.firstName ?? ''} ${state.model.handoverSecurity?.lastName ?? ''}'),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                ///Pass Returned On
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.returnedTime ??
                                      state
                                          .labels?.defaultLocale.returnedTime ??
                                      Constants.passReturnedOn,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                BaseDate().datePickerWidgetLoading(
                                  textController: returnedTimeController,
                                  isDisabled: true,
                                  onlyDate: false,
                                  onChange: (String value) {
                                    BlocProvider.of<
                                                DayPassManagementDetailsCubit>(
                                            context)
                                        .onModelValueChange(state.model);
                                  },
                                  context: context,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              ///Attachments
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.evidenceInfo ??
                                      state
                                          .labels?.defaultLocale.evidenceInfo ??
                                      Constants.evidenceDocuments,
                                  Styles.textStyleWhite16),
                              widget.model == null
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),
                              if (state.model.status == 0 ||
                                  state.model.status == null) ...[
                                BaseImageUpload().uploadWidget(
                                  context: context,
                                  isDisabled: isReadOnly,
                                  loggedInUserDetails:
                                      state.loggedInUserDetails!,
                                  getFiles: uploadFiles,
                                  onImageSelected: (ImageContent data) {
                                    List<ImageContent>? files = [];
                                    files.add(data);
                                    for (ImageContent image in uploadFiles) {
                                      files.add(image);
                                    }
                                    BlocProvider.of<
                                                DayPassManagementDetailsCubit>(
                                            context)
                                        .addAttachment(
                                      data: files,
                                      images: files,
                                    );
                                  },
                                ),
                              ],

                              /// Attachments
                              IgnorePointer(
                                ignoring: false,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: BaseImageUpload().getAttachment(
                                    height: height,
                                    attachments: state.uploadAttachments,
                                    files: uploadFiles,
                                    moduleCode:
                                        Constants.dayPassManagementModule,
                                    isDisabled: false,
                                    showDeleteIcon:
                                        state.model.status == null ||
                                            state.model.status == 0,
                                  ),
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// SubmitButton
                              if (showSaveSubmitButtons) ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    cancelButtonDisplay(),
                                    if (showSaveSubmitButtons) ...[
                                      submitButtonDisplay(state)
                                    ],
                                  ],
                                ),
                              ],
                              CommonWidgets.verticalSpacerWidget(height * 0.04),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!showSaveSubmitButtons) ...[
                Container(
                  padding: const EdgeInsets.all(5.0),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cancelButtonDisplay(),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
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

  Widget submitButtonDisplay(DayPassManagementDetailsState state) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<DayPassManagementDetailsCubit>(context).submitForm();
      },
    );
  }

  Widget dateCreateWidgetDisplay(String date) {
    return FlutterInputField(
      textFormKey: Keys.dateofcreationTextController,
      initialValue: date,
      hintText: '',
      isEnable: false,
      isDisableColor: true,
      onChange: (String value) {},
      validateTextField: (String? user) {},
    );
  }
}
