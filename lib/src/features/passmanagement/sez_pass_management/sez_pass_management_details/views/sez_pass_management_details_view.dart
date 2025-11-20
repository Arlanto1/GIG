import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/sez_pass_management/models/sez_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/sez_pass_management/sez_pass_management_details/cubits/sez_pass_management_details_cubit.dart';


class SezPassManagementDetailsView extends StatefulWidget {
  final SezPassManagementModel? model;
  final String title;
  final ExtraProperties? extraProperties;

  const SezPassManagementDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<SezPassManagementDetailsView> createState() =>
      _SezPassManagementDetailsViewState();
}

class _SezPassManagementDetailsViewState
    extends State<SezPassManagementDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController returnableTextController = TextEditingController();

  User? userDetails;
  List<ImageContent> getFiles = [];
  TextEditingController takenOutOnDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController expectedDateOfReturnController =
  TextEditingController();
  TextEditingController passValidFromController = TextEditingController();
  TextEditingController passValidUntilController= TextEditingController();
  bool isReadOnly = false;
  TextEditingController passTypeController =
  TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController companyNameController =TextEditingController();
  TextEditingController hostController = TextEditingController();
  TextEditingController updateStatusTextController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sezPassInfoController = TextEditingController();
  TextEditingController mTPApplicationNoController = TextEditingController();
  TextEditingController passCategoryController = TextEditingController();
  TextEditingController employeeIdFreeTextController = TextEditingController();
  TextEditingController returnedTimeController = TextEditingController();

  final FocusNode sentToFocusNode = FocusNode();

  List<ImageContent>? uploadFiles;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SezPassManagementDetailsCubit>(context).initializeValues();
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
    return BlocConsumer<SezPassManagementDetailsCubit,
        SezPassManagementDetailsState>(
      listener: (context, state) {
        log('-state.status--${state.status}--');
        log('123 ${state.message}--');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.sezPassManagementTitle,
            message: state.message,
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                  context, sezPassManagementListRoute, arguments: {
              });
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
      },
      builder: (context, state) {
        nameController.text = state.model.employee !=null ? '${state.model.employee?.firstName ?? ''} ${state.model.employee?.lastName ?? ''}' : state.model.employeeName ??'';
        hostController.text = state.model.host?.name ?? '';
        emailController.text = state.model.email??'';
        sezPassInfoController.text = state.model.passNo ?? '';
        mTPApplicationNoController.text = state.model.mifareNo??'';
        companyNameController.text= state.model.companyType?.name != 'FTE'? state.model.companyName ??'' : 'Deutsche Bank';
        employeeIdFreeTextController.text= state.model.employeeId??'';

        if (state.model.status == 0 && !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 1 && !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }

        if(state.model.status != null && state.model.status !=0){
          isReadOnly = true;
        }

        showSaveSubmitButtons = (widget.model == null ||
            state.model.status == 0 ||state.model.status == 1) && state.model.lock.isEmptyOrNull;

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: (widget.model == null ||
                state.model.status == 0) && state.status != FormStatus.loading,            pdfAPIName:
            '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.passManagementModuleCode}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<SezPassManagementDetailsCubit>(context).submitForm(
                isSaveOnly: true,
              );
            },
            showSubmitButton: showSaveSubmitButtons && state.status != FormStatus.loading,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<SezPassManagementDetailsCubit>(context).submitForm(
                isSaveOnly: false,
              );
            },
            showLikeButton: false,
            showDisLikeButton: false,
          ),
          backgroundColor: AppColors.lavender,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(SezPassManagementDetailsState state) {
    log('state.passValidUntil ${state.passValidUntil}');
    passValidFromController.text =
    state.model.passIssuedOn != null ? Utils.timestampToDateConversion(
        int.tryParse(state.model.passIssuedOn ?? '') ??
            DateTime
                .now()
                .millisecondsSinceEpoch, // Use current timestamp if null
        Constants.dateFormat) : '';


    passValidUntilController.text = state.model.endTime !=null ? Utils.timestampToDateConversion(
        int.tryParse(state.model.endTime ?? '') ??
            DateTime
                .now()
                .millisecondsSinceEpoch, // Use current timestamp if null
        Constants.dateFormat): Utils.timestampToDateConversion(
        int.tryParse(state.passValidUntil!) ?? DateTime.now().millisecondsSinceEpoch,
        Constants.dateFormat);

    if( (state.model.status == 2||state.model.status == 8 || state.model.status == 9)) {
      returnedTimeController.text = state.model.returnedTime != null
          ? Utils.timestampToDateConversion(
          int.tryParse(state.model.returnedTime ?? '') ??
              DateTime
                  .now()
                  .millisecondsSinceEpoch, // Fallback to current timestamp
          Constants.fulldateFormat) : '';
    }
  }


  getBodybuilder(SezPassManagementDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      uploadFiles = state.loadAttachments;
      uploadFiles = state.model.evidenceDocuments ?? [];
    }
    return Container(
      color: AppColors.lavender,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.lavender,
            ),
            Container(
              decoration: const ShapeDecoration(
                  color: AppColors.lavender,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.0)),
                  )),
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
                        absorbing: !showSaveSubmitButtons && IgnorePointer==false,
                        child: Column(
                          children: [
                            if (!state.model.lock.isEmptyOrNull) ...[
                              RecordLockedWidget(text: '${state.model.lock}'),
                            ],
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
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                              isDisabled: true,
                              textController: statusController,
                              items: passManagementStatusValues,
                              initialValue: '${state.model.status ?? 0}',
                              onTap: () {
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Created By
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                isMandatory: true,
                                '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),



                            /// Updated Status
                            if(widget.model?.status == 0 || widget.model?.status == 1)...[
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
                                  BaseOrganisationDialog()
                                      .departmentDialog(
                                    context: context,
                                    organisations:
                                    state.getStatus ?? [],
                                    onTap: (Organisation org) {
                                      if(org.name == "Lost") {
                                        Future.delayed(const Duration(
                                            milliseconds: 200), () {
                                          var dialog = CustomAlertDialog(
                                            title: Constants.updatestatus,
                                            message: "Are you sure you want to select \"${org
                                                .name}\"?",
                                            onPositivePressed: () {
                                              Navigator.pop(context);
                                              updateStatusTextController.text =
                                              org.name!;
                                              setState(() {});
                                              BlocProvider.of<
                                                  SezPassManagementDetailsCubit>(
                                                  context)
                                                  .updateDropdownValues(
                                                  updatedStatus: org);
                                            },
                                            positiveBtnText: Constants.yes,
                                            negativeBtnText: Constants.no,
                                          );

                                          showDialog(
                                            context: context,
                                            builder: (
                                                BuildContext context) => dialog,
                                          );
                                        });
                                      }else{
                                        updateStatusTextController.text =
                                        org.name!;
                                        setState(() {});
                                        BlocProvider.of<
                                            SezPassManagementDetailsCubit>(
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
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Location
                            CommonWidgets.textDisplay(
                              state.labels?.locale.location ??
                                  state.labels?.defaultLocale.location ??
                                  Constants.location,
                              Styles.textStyleWhite16,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseLocationDropdown().locationWidgetDisplay(
                                isEnabled: (!isReadOnly) &&
                                    !lock,
                                context: context,
                                locations: state.locations ?? Locations(),
                                selectedLocationName:
                                state.model.location?.name ?? '',
                                onTap: (Organisation? location) {
                                  BlocProvider.of<SezPassManagementDetailsCubit>(
                                      context)
                                      .updateLocationDropdownValue(
                                      location: location);
                                }),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                              state.labels?.locale.inputDate ??
                                  state.labels?.defaultLocale.inputDate ??
                                  Constants.dateofcreation,
                              Styles.textStyleWhite16,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
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
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

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
                                BlocProvider.of<SezPassManagementDetailsCubit>(
                                    context)
                                    .updateDropdownValues(
                                    entities: selectedEntities);
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              functionToCall: () {
                                // refresh the list
                                BlocProvider.of<SezPassManagementDetailsCubit>(
                                    context)
                                    .refreshList();
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Pass Type
                            CommonWidgets.textDisplay(
                              state.labels?.locale.passType ??
                                  state.labels?.defaultLocale
                                      .passType ??
                                Constants.passtype,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.passTypeName,
                              height: 70,
                              isDisableColor:  isReadOnly,
                              onTap: () {
                                if(!isReadOnly) {
                                  BaseOrganisationDialog().departmentDialog(
                                    context: context,
                                    organisations: state.passType!,
                                    onTap: (Organisation passType) {
                                      state.model.passTypeName = passType.name;
                                      BlocProvider.of<
                                          SezPassManagementDetailsCubit>(
                                          context)
                                          .updateDropdownValues(
                                          passType: passType);
                                    },
                                    leftImage: false,
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<
                                          SezPassManagementDetailsCubit>(
                                          context)
                                          .refreshList();
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),



                            /// Pass Category
                            CommonWidgets.textDisplay(
                                state.labels?.locale.category ??
                                    state.labels?.defaultLocale.category ??
                                    Constants.passCategory,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: passCategoryController,
                                items: passCategoryValues,
                                initialValue: '${state.model.category ?? 0}',
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: passCategoryValues
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            passCategoryValues.firstWhere(
                                                  (label) => label.key == value,
                                              orElse: () =>
                                              const Label(key: '', value: ''),
                                            );
                                        BlocProvider.of<SezPassManagementDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                            passCategory: int.tryParse(
                                                selectedLabel.value));
                                      },
                                    );
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Company Type
                            CommonWidgets.textDisplay(
                              state.labels?.locale.companyType ??
                                  state.labels?.defaultLocale
                                      .companyType ??
                                Constants.companyType,
                                Styles.textStyleWhite16,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.companyType?.name,
                              height: 70,
                              isDisableColor: isReadOnly,
                              onTap: () {
                                if(!isReadOnly) {
                                  BaseOrganisationDialog().departmentDialog(
                                    context: context,
                                    organisations: state.getCompanyTypeResponse,
                                    onTap: (Organisation companyType) {
                                      BlocProvider.of<
                                          SezPassManagementDetailsCubit>(
                                          context)
                                          .updateDropdownValues(
                                          companyType: companyType);
                                    },
                                    leftImage: false,
                                    orgName: 'ATOM_COMPANY_TYPES',
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<
                                          SezPassManagementDetailsCubit>(
                                          context)
                                          .refreshList();
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Company Name
                            CommonWidgets.textDisplay(
                              state.labels?.locale.companyName ??
                                  state.labels?.defaultLocale.companyName ??
                              Constants.companyName,
                              Styles.textStyleWhite16,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              textFormKey: Keys.challanKey,
                              controller: companyNameController,
                              characterLimit:
                              Constants.characterLimitIdTextFormField,
                              hintText: '',
                              isEnable: (state.model.companyType?.name != 'FTE') && ( state.model.status ==null || state.model.status ==0) ? true :false,
                              isDisableColor:false,
                              onChange: (String value) {
                                state.model.companyName = state.model.companyType?.name != 'FTE'? value : "Deutsche Bank";
                                context
                                    .read<SezPassManagementDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            /// category == Permanent
                            if(state.model.category == 1)...[
                              /// Employee Id
                              CommonWidgets.textDisplay(
                                state.labels?.locale.employeeId ??
                                    state.labels?.defaultLocale
                                        .employeeId ??
                                  Constants.employeeid,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              TextFieldAddButton(
                                title: state.model.employeeId,
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
                                            SezPassManagementDetailsCubit>(
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
                                            SezPassManagementDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                          employee: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<
                                            SezPassManagementDetailsCubit>(
                                            context)
                                            .refreshList();
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),
                            ],

                            if(state.model.category == 2 )...[
                              ///EmployeeId
                              CommonWidgets.textDisplay(
                                state.labels?.locale.employeeId ??
                                    state.labels?.defaultLocale
                                        .employeeId ??
                                  Constants.employeeid,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                controller: employeeIdFreeTextController,
                                textInputType: TextInputType.number,
                                textFormKey: Keys.contactNoKey,
                                hintText: '',
                                isEnable: !isReadOnly? true : false,
                                isDisableColor: true,
                                onChange: (String value) {
                                  state.model.employeeId = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),
                            ],

                            ///Name
                            CommonWidgets.textDisplay(
                              state.labels?.locale.employeeName ??
                                  state.labels?.defaultLocale
                                      .employeeName ??
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
                              // focusNode: employeeIdFocusNode,
                              isEnable: state.model.category ==2 && (state.model.status == null || state.model.status ==0)? true : false,
                              isDisableColor: true,
                              onChange: (String value) {
                                state.model.employeeName = value;
                                state.model.employee?.name = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),


                            if(state.model.category == 2)...[
                            /// Email
                            CommonWidgets.textDisplay(
                              state.labels?.locale.email ??
                                  state.labels?.defaultLocale
                                      .email ??
                                Constants.email,
                                isMandatory: true,
                                Styles.textStyleWhite16),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: emailController,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              isEnable: !isReadOnly,
                              isDisableColor: true,
                              onChange: (String value) {
                                state.model.email = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),
],
                            /// Sez Pass Info
                            CommonWidgets.textDisplay(
                              state.labels?.locale.sezPassInfo ??
                                  state.labels?.defaultLocale
                                      .sezPassInfo ??
                                Constants.sezPassInfo,
                                isMandatory: true,
                                Styles.textStyleWhite16),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: sezPassInfoController,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              isEnable: !isReadOnly,
                              isDisableColor: true,
                              onChange: (String value) {
                                state.model.passNo = value;
                                state.model.passInfo?.passNo = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),

                            /// MTP Application Number
                            CommonWidgets.textDisplay(
                              state.labels?.locale.mtpPassNo ??
                                  state.labels?.defaultLocale
                                      .mtpPassNo ??
                                Constants.mTPApplicationNo,
                                isMandatory: true,
                                Styles.textStyleWhite16),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: mTPApplicationNoController,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              // focusNode: employeeIdFocusNode,
                              isEnable: !isReadOnly,
                              isDisableColor: true,
                              onChange: (String value) {
                                state.model.mifareNo = value;
                                state.model.passInfo?.mifareNo = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),


                            /// Pass Issued On
                            CommonWidgets.textDisplay(
                              state.labels?.locale.passIssuedOn ??
                                  state.labels?.defaultLocale
                              .passIssuedOn ??
                              Constants.passIssuedOn,
                              isMandatory: true,
                              Styles.textStyleWhite16,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: passValidFromController,
                              isDisabled: state.model.status !=null && state.model.status !=0,
                              onlyDate: false,
                              showPastDate: true,
                              showFutureDate: false,
                              onChange: (String value) {
                                passValidFromController.text = value;
                                state.model.passIssuedOn =
                                    Utils().formatTime(value);
                                BlocProvider.of<
                                    SezPassManagementDetailsCubit>(
                                    context)
                                    .onModelValueChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Pass Valid Until
                            CommonWidgets.textDisplay(
                              state.labels?.locale.endTime ??
                                  state.labels?.defaultLocale
                              .endTime ??
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
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            if(state.model.status ==2 || state.model.status ==8 || state.model.status ==9)...[
                              /// Pass Collected By
                            CommonWidgets.horizentaltextHandling(
                              state.labels?.locale.handoverSecurity ??
                                  state.labels?.defaultLocale.handoverSecurity ??
                                Constants.passCollectedBy,
                                isMandatory: true,
                                '${state.model.handoverSecurity?.firstName ?? ''} ${state.model.handoverSecurity?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),



                            ///Pass Returned On
                            CommonWidgets.textDisplay(
                              state.labels?.locale.returnedTime ??
                                  state.labels?.defaultLocale.returnedTime ??
                              Constants.passReturnedOn,
                              Styles.textStyleWhite16,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                              BaseDate().datePickerWidgetLoading(
                                textController: returnedTimeController,
                                isDisabled: true,
                                onlyDate: false,
                                onChange: (String value) {
                                  BlocProvider.of<
                                      SezPassManagementDetailsCubit>(
                                      context)
                                      .onModelValueChange(state.model);
                                },
                                context: context,
                              ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ],


                            ///Attachments
                            CommonWidgets.textDisplay(
                              state.labels?.locale.evidenceInfo ??
                                  state.labels?.defaultLocale.evidenceInfo ??
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
                                  for (ImageContent image
                                  in uploadFiles ?? []) {
                                    files.add(image);
                                  }
                                  BlocProvider.of<
                                      SezPassManagementDetailsCubit>(
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
                                moduleCode: Constants.dayPassManagementModule,
                                isDisabled: false,
                                showDeleteIcon: state.model.status == null || state.model.status == 0 ,
                              ),
                            ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// SubmitButton
                            if (showSaveSubmitButtons) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                ),),),
            if (!showSaveSubmitButtons) ...[
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: const ShapeDecoration(
                  color: AppColors.backgroundWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(00.0)),
                  ),
                ),
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

  Widget submitButtonDisplay(SezPassManagementDetailsState state) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<SezPassManagementDetailsCubit>(context).submitForm(
        );
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
