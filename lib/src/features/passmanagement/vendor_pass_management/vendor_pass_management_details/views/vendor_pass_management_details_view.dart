import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/vendor_pass_management/models/vendor_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/vendor_pass_management/vendor_pass_management_details/cubits/vendor_pass_management_details_cubit.dart';

class VendorPassManagementDetailsView extends StatefulWidget {
  final VendorPassManagementModel? model;
  final String title;
  final ExtraProperties? extraProperties;

  const VendorPassManagementDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<VendorPassManagementDetailsView> createState() =>
      _VendorPassManagementDetailsViewState();
}

class _VendorPassManagementDetailsViewState
    extends State<VendorPassManagementDetailsView> {
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
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController visitorComingFromController = TextEditingController();
  TextEditingController hostController = TextEditingController();
  TextEditingController purposeOfVisitController = TextEditingController();
  TextEditingController photoIdentityController = TextEditingController();
  TextEditingController updateStatusTextController = TextEditingController();
  TextEditingController escortedByController = TextEditingController();
  TextEditingController escortedByEmployeeIdController =
      TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController returnedTimeController = TextEditingController();
  final FocusNode sentToFocusNode = FocusNode();

  List<ImageContent> uploadFiles = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VendorPassManagementDetailsCubit>(context)
        .initializeValues();
    //initializeDates(state);
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool showSaveSubmitButtons = false;
  bool lock = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<VendorPassManagementDetailsCubit,
        VendorPassManagementDetailsState>(
      listener: (context, state) {
        log('-state.status--${state.status}--');
        log('123 ${state.message}--');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.vendorPassManagementTitle,
            message: state.message,
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, vendorPassManagementListRoute,
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
        contactNumberController.text = state.model.contactNo ?? '';
        visitorComingFromController.text = state.model.visitorComingFrom ?? '';
        hostController.text =
            '${state.model.host?.firstName ?? ''} ${state.model.host?.lastName ?? ''}';
        vendorNameController.text = state.model.employeeName ?? '';
        purposeOfVisitController.text = state.model.visitingPurpose ?? '';
        escortedByController.text = state.model.escortedBy ?? '';
        companyNameController.text = state.model.companyName ?? '';
        escortedByEmployeeIdController.text =
            state.model.escortedEmployeeId ?? '';
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
              BlocProvider.of<VendorPassManagementDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: true,
              );
            },
            showSubmitButton:
                showSaveSubmitButtons && state.status != FormStatus.loading,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<VendorPassManagementDetailsCubit>(context)
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

  void initializeDates(VendorPassManagementDetailsState state) {
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
    state.model.endTime == passValidUntilController.text;
  }

  getBodybuilder(VendorPassManagementDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      uploadFiles = state.loadAttachments;
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Created By
                              CommonWidgets.horizentaltextHandling(
                                  state.labels?.locale.entrySecurity ??
                                      state.labels?.defaultLocale
                                          .entrySecurity ??
                                      Constants.createdby,
                                  isMandatory: true,
                                  '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Updated Status
                              if (widget.model?.status == 0 ||
                                  widget.model?.status == 1) ...[
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
                                        if (org.name == "Lost") {
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
                                                            VendorPassManagementDetailsCubit>(
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
                                                      VendorPassManagementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  updatedStatus: org);
                                        }
                                      },
                                    );
                                    // }
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

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
                                                VendorPassManagementDetailsCubit>(
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Sl No.
                              CommonWidgets.horizentaltextHandling(
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
                                  BlocProvider.of<
                                              VendorPassManagementDetailsCubit>(
                                          context)
                                      .updateDropdownValues(
                                          entities: selectedEntities);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                orgName: 'ATOM_ENTITIES',
                                functionToCall: () {
                                  // refresh the list
                                  BlocProvider.of<
                                              VendorPassManagementDetailsCubit>(
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
                                                    VendorPassManagementDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                passType: passType);
                                      },
                                      leftImage: false,
                                      orgName: '',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    VendorPassManagementDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Vendor Name
                              CommonWidgets.textDisplay(
                                state.labels?.locale.vendorName ??
                                    state.labels?.defaultLocale.vendorName ??
                                    Constants.vendorName,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.text,
                                textFormKey: Keys.challanKey,
                                controller: vendorNameController,
                                characterLimit:
                                    Constants.characterLimitIdTextFormField,
                                hintText: '',
                                isEnable: !isReadOnly,
                                isDisableColor: false,
                                onChange: (String value) {
                                  state.model.employeeName = value;
                                  context
                                      .read<VendorPassManagementDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),

                              ///Contact no
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.contactNo ??
                                      state.labels?.defaultLocale.contactNo ??
                                      Constants.contactNo,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                controller: contactNumberController,
                                textInputType: TextInputType.number,
                                textFormKey: Keys.contactNoKey,
                                characterLimit: 17,
                                hintText: '',
                                isEnable: !isReadOnly,
                                isDisableColor: isReadOnly,
                                onChange: (String value) {
                                  state.model.contactNo = value;
                                },
                                validateTextField: (String? user) {},
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
                                isEnable: !isReadOnly,
                                isDisableColor: false,
                                onChange: (String value) {
                                  state.model.companyName = value;
                                  context
                                      .read<VendorPassManagementDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

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
                                                    VendorPassManagementDetailsCubit>(
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
                                                    VendorPassManagementDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                          host: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<
                                                    VendorPassManagementDetailsCubit>(
                                                context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

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
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///  Visiting Department
                              CommonWidgets.textDisplay(
                                state.labels?.locale.visitingDepartment ??
                                    state.labels?.defaultLocale
                                        .visitingDepartment ??
                                    Constants.visitingDepartment,
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
                                                      VendorPassManagementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  department: department);
                                        },
                                        orgName: 'EMPLOYEE_DEPARTMENTS',
                                        createEntity: false,
                                        title: '',
                                        functionToCall: () {
                                          // refresh the list
                                          BlocProvider.of<
                                                      VendorPassManagementDetailsCubit>(
                                                  context)
                                              .refreshList();
                                        });
                                    FocusScope.of(context)
                                        .requestFocus(sentToFocusNode);
                                  }
                                },
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Reason for Vendor Pass
                              CommonWidgets.textDisplay(
                                state.labels?.locale.vendorPassReason ??
                                    state.labels?.defaultLocale
                                        .vendorPassReason ??
                                    Constants.reasonForVendorPass,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              TextFieldAddButton(
                                title: state.model.vendorPassReason?.name,
                                height: 70,
                                isDisableColor: isReadOnly,
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.vendorPassReason,
                                      onTap: (Organisation department) {
                                        BlocProvider.of<
                                                    VendorPassManagementDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                vendorPassReason: department);
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Vendor Pass No
                              CommonWidgets.textDisplay(
                                state.labels?.locale.vendorPassInfo ??
                                    state
                                        .labels?.defaultLocale.vendorPassInfo ??
                                    Constants.vendorPassNo,
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
                                        log('PassNo ${state.model.passNo}');
                                        BlocProvider.of<
                                                    VendorPassManagementDetailsCubit>(
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
                                              VendorPassManagementDetailsCubit>(
                                          context)
                                      .onModelValueChange(state.model);
                                },
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

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
                                isDisabled: true,
                                onlyDate: false,
                                onChange: (String value) {
                                  BlocProvider.of<
                                              VendorPassManagementDetailsCubit>(
                                          context)
                                      .onModelValueChange(state.model);
                                },
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Escorted By
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.escortedBy ??
                                      state.labels?.defaultLocale.escortedBy ??
                                      Constants.escortedby,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                controller: escortedByController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.contactNoKey,
                                hintText: '',
                                isEnable: !isReadOnly,
                                isDisableColor: isReadOnly,
                                onChange: (String value) {
                                  state.model.escortedBy = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Escorted By Employee Id
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.escortedEmployeeId ??
                                      state.labels?.defaultLocale
                                          .escortedEmployeeId ??
                                      Constants.escortedbyemployeeid,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                controller: escortedByEmployeeIdController,
                                textInputType: TextInputType.number,
                                textFormKey: Keys.contactNoKey,
                                hintText: '',
                                isEnable: !isReadOnly,
                                isDisableColor: isReadOnly,
                                onChange: (String value) {
                                  state.model.escortedEmployeeId = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (state.model.status == 2 ||
                                  state.model.status == 8 ||
                                  state.model.status == 9) ...[
                                /// Pass Collected By
                                CommonWidgets.horizentaltextHandling(
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
                                                VendorPassManagementDetailsCubit>(
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
                                                VendorPassManagementDetailsCubit>(
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
                                    attachments: state.loadAttachments,
                                    files: uploadFiles,
                                    moduleCode:
                                        Constants.passManagementModuleCode,
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
                                    submitButtonDisplay(state)
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

  Widget submitButtonDisplay(VendorPassManagementDetailsState state) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<VendorPassManagementDetailsCubit>(context).submitForm();
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
