import 'dart:developer';

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
  TextEditingController passValidUntilController= TextEditingController();
  bool isReadOnly = false;
  TextEditingController passTypeController =
  TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController companyNameController =TextEditingController();
  TextEditingController dbSponsorController = TextEditingController();
  TextEditingController hostController = TextEditingController();
  TextEditingController updateStatusTextController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();

  final FocusNode sentToFocusNode = FocusNode();

  List<ImageContent> uploadFiles = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DayPassManagementDetailsCubit>(context).initializeValues();
    //initializeDates(state);
  }

  static const String moduleCode = Constants.materialMovementModuleCode;

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
              Navigator.popAndPushNamed(
                  context, dayPassManagementListRoute, arguments: {
              });
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);

          // Utils.dynamicAlert(
          //     context, state.message ?? '', 'Day Pass Management', '');
        }
      },
      builder: (context, state) {
        nameController.text = state.model.employee !=null ? state.model.employee?.name ?? '' : state.model.employeeName ??'';
        dbSponsorController.text = state.model.host?.name ?? '';
        hostController.text = state.model.host?.name ?? '';
        employeeIdController.text = state.model.employeeId??'';
        companyNameController.text= state.model.companyType?.name != 'FTE'? state.model.companyName ??'' : 'Deutsche Bank';

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
            showSaveButton: showSaveSubmitButtons,
            pdfAPIName:
            '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=$moduleCode',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<DayPassManagementDetailsCubit>(context).submitForm(
                isSaveOnly: true,
                 );
            },
            showSubmitButton: showSaveSubmitButtons ,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<DayPassManagementDetailsCubit>(context).submitForm(
                isSaveOnly: false,
              );
            },
            showLikeButton: false,
            showDisLikeButton: false,
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(DayPassManagementDetailsState state) {

    passValidFromController.text = state.model.startTime == null
   ? Utils.timestampToDateConversion(
        DateTime.now().millisecondsSinceEpoch,
        Constants.fulldateFormat) : Utils.timestampToDateConversion(
        int.tryParse(state.model.startTime ?? '') ??
            DateTime.now().millisecondsSinceEpoch,
        Constants.fulldateFormat);

    passValidUntilController.text = state.model.endTime != null
        ? Utils.timestampToDateConversion(
        int.tryParse(state.model.endTime ?? '') ??
            DateTime.now().millisecondsSinceEpoch, // Fallback to current timestamp
        Constants.fulldateFormat) :Utils.timestampToDateConversion(
        DateTime.now().add(const Duration(hours: 12)).millisecondsSinceEpoch, // One day ahead
        Constants.fulldateFormat);

    state.model.startTime == passValidFromController.text;
    state.model.endTime == passValidUntilController.text;

  }

  getBodybuilder(DayPassManagementDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    // if (state.status == FormStatus.addAttachment ||
    //     state.status == FormStatus.initial) {
    //   getFiles = state.loadAttachments ?? [];
    // }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      uploadFiles = state.uploadAttachments;
      uploadFiles = state.model.evidenceDocuments ?? [];
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
                        absorbing: !showSaveSubmitButtons,
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
                            if(state.model.status == 0 || state.model.status == 1)...[
                              CommonWidgets.textDisplay(
                                  isMandatory: true,
                                  // state.labels?.locale.get ??
                                  //     state.labels?.defaultLocale
                                  //         .updateStatus ??
                                  Constants.updatestatus,
                                  Styles.textStyleBlack14),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              TextFieldAddButton(
                                title: updateStatusTextController.text,
                                height: 60,
                                isDisableColor: widget.model != null &&
                                    !widget.model!.lock.isEmptyOrNull,
                                onTap: () {
                                  BaseOrganisationDialog()
                                      .departmentDialog(
                                    context: context,
                                    organisations:
                                    state.getStatus ?? [],
                                    onTap: (Organisation org) {
                                      updateStatusTextController
                                          .text = org.name!;
                                      setState(() {});
                                      BlocProvider.of<
                                          DayPassManagementDetailsCubit>(
                                          context)
                                          .updateDropdownValues(
                                          updatedStatus: org);
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
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            // locationWidgetdislay(state),
                            BaseLocationDropdown().locationWidgetDisplay(
                                isEnabled: (!isReadOnly) &&
                                    !lock,
                                context: context,
                                locations: state.locations ?? Locations(),
                                selectedLocationName:
                                state.model.location?.name ?? '',
                                onTap: (Organisation? location) {
                                  BlocProvider.of<DayPassManagementDetailsCubit>(
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
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
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
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            BaseEntitiesSelection().entityDropDownSelection(
                              context: context,
                              selectedValues: state.model.entities ?? [],
                              all: state.listOfEntities ?? [],
                              enabled: !isReadOnly,
                              onTap: (List<Organisation> selectedEntities) {
                                log('--selectedEntities----${selectedEntities.length}');
                                BlocProvider.of<DayPassManagementDetailsCubit>(
                                    context)
                                    .updateDropdownValues(
                                    entities: selectedEntities);
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              orgName: 'ATOM_ENTITIES',
                              functionToCall: () {
                                // refresh the list
                                BlocProvider.of<DayPassManagementDetailsCubit>(
                                    context)
                                    .refreshList();
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Pass Type
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.companyType ??
                              //     state.labels?.defaultLocale
                              //         .companyType ??
                                Constants.passtype,
                                Styles.textStyleBlack14,
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
                                          DayPassManagementDetailsCubit>(
                                          context)
                                          .updateDropdownValues(
                                          passType: passType);
                                    },
                                    leftImage: false,
                                    orgName: '',
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
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Company Type
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.companyType ??
                                //     state.labels?.defaultLocale
                                //         .companyType ??
                                    Constants.companyType,
                                Styles.textStyleBlack14,
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
                                      DayPassManagementDetailsCubit>(
                                      context)
                                      .updateDropdownValues(
                                      companyType: companyType);
                                },
                                leftImage: false,
                                orgName: 'ATOM_COMPANY_TYPES',
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
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Company Name
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.challanNo ??
                              //     state.labels?.defaultLocale.challanNo ??
                                  Constants.companyName,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              textFormKey: Keys.challanKey,
                              // initialValue: '',
                              controller: companyNameController,
                              characterLimit:
                              Constants.characterLimitIdTextFormField,
                              hintText: '',
                              isEnable: (state.model.companyType?.name != 'FTE') && ( state.model.status ==null || state.model.status ==0) ? true :false,
                              isDisableColor:false,
                              onChange: (String value) {
                                state.model.companyName = state.model.companyType?.name != 'FTE'? value : "Deutsche Bank";
                                context
                                    .read<DayPassManagementDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                      if(state.model.companyType?.name != 'Exceptions' && state.model.companyType?.name != 'CWR T2')...[
                    /// Employee Id
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.employeeID ??
                                //     state.labels?.defaultLocale
                                //         .employeeID ??
                                    Constants.employeeid,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.employee?.employeeId,
                              height: 60,
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
                                height * 0.01),
],

                            if(state.model.companyType?.name == 'CWR T2' )...[
                            ///EmployeeId
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.name ??
                              //     state.labels?.defaultLocale
                              //         .name ??
                                Constants.employeeid,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.contactNoKey,
                              controller: employeeIdController,
                              hintText: '',
                              // focusNode: employeeIdFocusNode,
                              isEnable: state.model.companyType?.name == 'CWR T2' && !isReadOnly? true : false,
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
                                // state.labels?.locale.name ??
                                //     state.labels?.defaultLocale
                                //         .name ??
                                    Constants.name,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: nameController,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              // focusNode: employeeIdFocusNode,
                              isEnable: (state.model.companyType?.name == 'Exceptions' || state.model.companyType?.name == 'CWR T2') && state.model.status == null ||state.model.status == 0 ? true : false,
                              isDisableColor: true,
                              onChange: (String value) {
                                state.model.employeeName = value;
                                state.model.employee?.name = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),

                            if(state.model.companyType?.name == 'CWR T1' ||state.model.companyType?.name == 'CWR T2' )...[
                            ///Db Sponsor Employee Id
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.employeeID ??
                              //     state.labels?.defaultLocale
                              //         .employeeID ??
                                Constants.dbSponsorEmployeeId,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.host?.employeeId,
                              height: 60,
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
                                height * 0.01),
                            ///DB Sponsor
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.name ??
                              //     state.labels?.defaultLocale
                              //         .name ??
                                Constants.dbSponsor,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: dbSponsorController,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              // focusNode: employeeIdFocusNode,
                              isEnable: false,
                              isDisableColor: true,
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),
],
              if(state.model.companyType?.name == 'Exceptions')...[
                ///Host Employee Id
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.employeeID ??
                              //     state.labels?.defaultLocale
                              //         .employeeID ??
                                Constants.hostemployeeid,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.hostEmployeeId,
                              height: 60,
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
                                height * 0.01),

                            ///Host
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.name ??
                              //     state.labels?.defaultLocale
                              //         .name ??
                                Constants.host,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: hostController,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              // focusNode: employeeIdFocusNode,
                              isEnable: false,
                              isDisableColor: true,
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),
],
                            ///  Department
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.requestorDepartment ??
                              //     state.labels?.defaultLocale
                              //         .requestorDepartment ??
                                  Constants.department,
                              Styles.textStyleBlack14,
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
                                        state.model.department
                                            ?.name = department.name;
                                        BlocProvider.of<
                                            DayPassManagementDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                            department:
                                            department);
                                      },
                                      orgName: 'EMPLOYEE_DEPARTMENTS',
                                      createEntity: false,
                                      title: '',
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

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Reason for Day Pass
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.requestorDepartment ??
                              //     state.labels?.defaultLocale
                              //         .requestorDepartment ??
                              Constants.reasonfordaypass,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            TextFieldAddButton(
                              title: state.model.dayPassReason?.name,
                              height: 60,
                              isDisableColor: isReadOnly,
                              onTap: () {
                                if (!isReadOnly) {
                                  BaseOrganisationDialog().departmentDialog(
                                    context: context,
                                    organisations: state.dayPassReason,
                                    onTap: (Organisation department) {
                                      BlocProvider.of<DayPassManagementDetailsCubit>(
                                          context)
                                          .updateDropdownValues(
                                          dayPassReason: department);
                                    },
                                  );
                                 }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            if (state.model.dayPassReason?.name ==
                                'External Regulators'||
                                state.model.dayPassReason?.name ==
                                   'External auditors') ...[
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.investigationRequired ??
                                //     state.labels?.defaultLocale
                                //         .investigationRequired ??
                                  Constants.exceptionalApproval,
                                  isMandatory: true,
                                  Styles.textStyleBlack14),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                  state.model.exceptionalApproval ? 1 : 0,
                                  onChangedYes: isReadOnly
                                      ? null
                                      : (val) {
                                    state.model.exceptionalApproval= true;
                                    BlocProvider.of<
                                        DayPassManagementDetailsCubit>(
                                        context)
                                        .onCheckBoxChange(state.model);
                                  },
                                  onChangedNo: isReadOnly
                                      ? null
                                      : (val) {
                                    state.model.exceptionalApproval = false;
                                    BlocProvider.of<
                                        DayPassManagementDetailsCubit>(
                                        context)
                                        .onCheckBoxChange(state.model);
                                  }),

                              // RadioButtonsYesNo(
                              //     status: state.model.status ?? 0,
                              //     selectedValue:
                              //     state.model.exceptionalApproval ? 1 : 0,
                              //     onChangedYes: isReadOnly
                              //         ? null
                              //         : (val) {
                              //       state.model.exceptionalApproval =
                              //       true;
                              //       BlocProvider.of<
                              //           DayPassManagementDetailsCubit>(
                              //           context)
                              //           .onCheckBoxChange(state.model);
                              //     },
                              //     onChangedNo: isReadOnly
                              //         ? null
                              //         : (val) {
                              //       state.model.exceptionalApproval =
                              //       false;
                              //       BlocProvider.of<
                              //           DayPassManagementDetailsCubit>(
                              //           context)
                              //           .onCheckBoxChange(state.model);
                              //     }),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                            /// Day Pass No
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.requestorDepartment ??
                              //     state.labels?.defaultLocale
                              //         .requestorDepartment ??
                              Constants.dayPassNo,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            TextFieldAddButton(
                              title: state.model.passNo,
                              height: 60,
                              isDisableColor: isReadOnly,
                              onTap: () {
                                if (!isReadOnly) {
                                BaseOrganisationDialog().departmentDialog(
                                  context: context,
                                  organisations: state.passNo!,
                                  onTap: (Organisation department) {
                                    state.model.passNo = department.name;
                                    log('PassNo ${state.model.passNo }');
                                    BlocProvider.of<DayPassManagementDetailsCubit>(
                                        context)
                                        .updateDropdownValues(
                                        passNo: department);
                                  },
                                );
                                 }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Pass Valid From
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.keyHandOverDue ??
                              //     state.labels?.defaultLocale
                                      // .keyHandOverDue ??
                                  Constants.passvlidfrom,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: passValidFromController,
                              isDisabled: true,
                              onlyDate: false,
                              // showPastDate: false,
                              // fromDate: initialisedStartDate,
                              // toDate: initialisedToDate,
                              onChange: (String value) {
                                // isDateSelectedByUser = true;
                                passValidFromController.text = value;
                                log('keyReturnDueDateControllerValue22 --- $value');
                                // state.model.passV =
                                //     Utils().formatTime(value);
                                BlocProvider.of<
                                    DayPassManagementDetailsCubit>(
                                    context)
                                    .onModelValueChange(state.model);
                                //},
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Pass Valid Until
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.keyHandOverDue ??
                              //     state.labels?.defaultLocale
                              // .keyHandOverDue ??
                              Constants.passvliduntil,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: passValidUntilController,
                              isDisabled: true,
                              onlyDate: false,
                              // showPastDate: false,
                              // fromDate: initialisedStartDate,
                              // toDate: initialisedToDate,
                              onChange: (String value) {
                                // isDateSelectedByUser = true;
                                // keyReturnDueDateController.text = value;
                                // state.model.passV =
                                //     Utils().formatTime(value);
                                BlocProvider.of<
                                    DayPassManagementDetailsCubit>(
                                    context)
                                    .onModelValueChange(state.model);
                                //},
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            if(state.model.status !=null && state.model.status !=0 && state.model.status !=1)...[
                            /// Pass Collected By
                            CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.entrySecurity ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                    Constants.passCollectedBy,
                                isMandatory: true,
                                '${state.model.handOverSecurity?.firstName ?? ''} ${state.model.handOverSecurity?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),



                           ///Pass Returned On
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.inputDate ??
                              //     state.labels?.defaultLocale.inputDate ??
                                  Constants.passReturnedOn,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
                                state.model.returnedTime ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

],
                            ///Attachments
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.attachment ??
                                //     state.labels?.defaultLocale.attachment ??
                                    Constants.evidenceDocuments,
                                Styles.textStyleBlack14),
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
                                  in uploadFiles) {
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
                              child: BaseImageUpload().getAttachment(
                                height: height,
                                attachments: state.uploadAttachments,
                                files: uploadFiles,
                                moduleCode: Constants.dayPassManagementModule,
                                isDisabled: false,
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

  Widget submitButtonDisplay(DayPassManagementDetailsState state) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<DayPassManagementDetailsCubit>(context).submitForm(
        );
      },
    );
  }

  Widget datecreateWidgetdisplay(String date) {
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
