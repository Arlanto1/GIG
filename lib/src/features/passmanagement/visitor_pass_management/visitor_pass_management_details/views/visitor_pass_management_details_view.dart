import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/models/visitor_pass_management_model.dart';
import 'package:db_atom/src/features/passmanagement/visitor_pass_management/visitor_pass_management_details/cubits/visitor_pass_management_details_cubit.dart';


class VisitorPassManagementDetailsView extends StatefulWidget {
  final VisitorPassManagementModel? model;
  final String title;
  final ExtraProperties? extraProperties;

  const VisitorPassManagementDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<VisitorPassManagementDetailsView> createState() =>
      _VisitorPassManagementDetailsViewState();
}

class _VisitorPassManagementDetailsViewState
    extends State<VisitorPassManagementDetailsView> {
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
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController visitorNameController =TextEditingController();
  TextEditingController visitorComingFromController = TextEditingController();
  TextEditingController hostController = TextEditingController();
  TextEditingController purposeOfVisitController = TextEditingController();
  TextEditingController photoIdentityController=TextEditingController();
  TextEditingController updateStatusTextController =TextEditingController();
  TextEditingController escortedByController = TextEditingController();
  TextEditingController escortedByEmployeeIdController = TextEditingController();
  TextEditingController returnedTimeController = TextEditingController();

  final FocusNode sentToFocusNode = FocusNode();

  List<ImageContent>? uploadFiles;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VisitorPassManagementDetailsCubit>(context).initializeValues();
    //initializeDates(state);
  }

  static const String moduleCode = Constants.passManagementModuleCode;

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
    return BlocConsumer<VisitorPassManagementDetailsCubit,
        VisitorPassManagementDetailsState>(
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
              Navigator.popAndPushNamed(
                  context, visitorPassManagementListRoute, arguments: {
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
        contactNumberController.text = state.model.contactNo ??'';
        visitorComingFromController.text = state.model.visitorComingFrom ?? '';
        hostController.text = state.model.host?.name ?? '';
        visitorNameController.text=  state.model.employeeName ??'';
        purposeOfVisitController.text = state.model.visitingPurpose??'';
        escortedByController.text = state.model.escortedBy??'';

        escortedByEmployeeIdController.text = state.model.escortedEmployeeId ??'';
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
            showSaveButton: showSaveSubmitButtons && state.status != FormStatus.loading,
            pdfAPIName:
            '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.passManagementModuleCode}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<VisitorPassManagementDetailsCubit>(context).submitForm(
                isSaveOnly: true,
              );
            },
            showSubmitButton: showSaveSubmitButtons && state.status != FormStatus.loading,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<VisitorPassManagementDetailsCubit>(context).submitForm(
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

  void initializeDates(VisitorPassManagementDetailsState state) {

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

    if( (state.model.status == 2||state.model.status == 8 || state.model.status == 9)) {
      returnedTimeController.text = state.model.returnedTime != null
          ? Utils.timestampToDateConversion(
          int.tryParse(state.model.returnedTime ?? '') ??
              DateTime
                  .now()
                  .millisecondsSinceEpoch, // Fallback to current timestamp
          Constants.fulldateFormat) : '';
    }
    state.model.startTime == passValidFromController.text;
    state.model.endTime == passValidUntilController.text;
  }

  getBodybuilder(VisitorPassManagementDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      getFiles = state.loadAttachments ?? [];
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
                                          VisitorPassManagementDetailsCubit>(
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
                                  BlocProvider.of<VisitorPassManagementDetailsCubit>(
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
                                BlocProvider.of<VisitorPassManagementDetailsCubit>(
                                    context)
                                    .updateDropdownValues(
                                    entities: selectedEntities);
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              orgName: 'ATOM_ENTITIES',
                              functionToCall: () {
                                // refresh the list
                                BlocProvider.of<VisitorPassManagementDetailsCubit>(
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
                                          VisitorPassManagementDetailsCubit>(
                                          context)
                                          .updateDropdownValues(
                                          passType: passType);
                                    },
                                    leftImage: false,
                                    orgName: '',
                                    functionToCall: () {
                                      // refresh the list
                                      BlocProvider.of<
                                          VisitorPassManagementDetailsCubit>(
                                          context)
                                          .refreshList();
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Visitor Name
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.challanNo ??
                              //     state.labels?.defaultLocale.challanNo ??
                              Constants.visitorName,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.text,
                              textFormKey: Keys.challanKey,
                              // initialValue: '',
                              controller: visitorNameController,
                              characterLimit:
                              Constants.characterLimitIdTextFormField,
                              hintText: '',
                              isEnable: !isReadOnly,
                              isDisableColor:false,
                              onChange: (String value) {
                                state.model.employeeName = value;
                                context
                                    .read<VisitorPassManagementDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            CommonWidgets.verticalSpacerWidget(height * 0.001),


                            // if(state.model.companyType?.name == 'CWR T2' )...[
                            //   ///EmployeeId
                            //   CommonWidgets.textDisplay(
                            //     // state.labels?.locale.name ??
                            //     //     state.labels?.defaultLocale
                            //     //         .name ??
                            //       Constants.employeeid,
                            //       isMandatory: true,
                            //       Styles.textStyleBlack14),
                            //   CommonWidgets.verticalSpacerWidget(
                            //       height * 0.001),
                            //   FlutterInputField(
                            //     textInputType: TextInputType.number,
                            //     textFormKey: Keys.contactNoKey,
                            //     hintText: '',
                            //     // focusNode: employeeIdFocusNode,
                            //     isEnable: state.model.companyType?.name == 'CWR T2' && !isReadOnly? true : false,
                            //     isDisableColor: true,
                            //     onChange: (String value) {
                            //       state.model.employeeId = value;
                            //     },
                            //     validateTextField: (String? user) {},
                            //   ),
                            //   CommonWidgets.verticalSpacerWidget(
                            //       height * 0.01),
                            // ],

                            ///Contact no
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.name ??
                              //     state.labels?.defaultLocale
                              //         .name ??
                                Constants.contactNo,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: contactNumberController,
                              textInputType: TextInputType.number,
                              textFormKey: Keys.contactNoKey,
                              characterLimit: 17,
                              hintText: '',
                              // focusNode: employeeIdFocusNode,
                              isEnable: !isReadOnly,
                              isDisableColor: isReadOnly,
                              onChange: (String value) {
                                state.model.contactNo = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),

                            ///Visitor Coming From
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.name ??
                              //     state.labels?.defaultLocale
                              //         .name ??
                                Constants.visitorComingFrom,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: visitorComingFromController,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              // focusNode: employeeIdFocusNode,
                              isEnable: !isReadOnly,
                              isDisableColor: isReadOnly,
                              onChange: (String value) {
                                state.model.visitorComingFrom = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),

                         /// Photo Identity Validation Type
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.name ??
                              //     state.labels?.defaultLocale
                              //         .name ??
                                Constants.photoIdentityType,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: photoIdentityController,
                                items: photoIdentityValidationValues,
                                initialValue: state.model.idValidationType.toString(),
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: photoIdentityValidationValues
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            photoIdentityValidationValues.firstWhere(
                                                  (label) => label.key == value,
                                              orElse: () =>
                                              const Label(key: '', value: ''),
                                            );
                                        BlocProvider.of<VisitorPassManagementDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                            validateType: int.tryParse(
                                                selectedLabel.value));
                                      },
                                    );
                                  }
                                }),

                            ///Purpose of Visit
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.name ??
                              //     state.labels?.defaultLocale
                              //         .name ??
                                Constants.purposeOfVisit,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: purposeOfVisitController,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              // focusNode: employeeIdFocusNode,
                              isEnable: !isReadOnly,
                              isDisableColor: isReadOnly,
                              onChange: (String value) {
                                state.model.visitingPurpose= value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),

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
                                            VisitorPassManagementDetailsCubit>(
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
                                            VisitorPassManagementDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                          host: user,
                                        );
                                        // refresh the list
                                        BlocProvider.of<
                                            VisitorPassManagementDetailsCubit>(
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



                            ///  Visiting Department
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.requestorDepartment ??
                              //     state.labels?.defaultLocale
                              //         .requestorDepartment ??
                              Constants.visitingDepartment,
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
                                            VisitorPassManagementDetailsCubit>(
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
                                            VisitorPassManagementDetailsCubit>(
                                            context)
                                            .refreshList();
                                      });
                                  FocusScope.of(context)
                                      .requestFocus(sentToFocusNode);
                                }
                              },
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Visitor Pass No
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.requestorDepartment ??
                              //     state.labels?.defaultLocale
                              //         .requestorDepartment ??
                              Constants.visitorPassNo,
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
                                      BlocProvider.of<VisitorPassManagementDetailsCubit>(
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
                                    VisitorPassManagementDetailsCubit>(
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
                                    VisitorPassManagementDetailsCubit>(
                                    context)
                                    .onModelValueChange(state.model);
                                //},
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            CommonWidgets.textDisplay(
                              // state.labels?.locale.investigationRequired ??
                              //     state.labels?.defaultLocale
                              //         .investigationRequired ??
                                Constants.escortedByHost,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.model.status ?? 0,
                                selectedValue:
                                state.model.escortedByHost  ? 1 : 0,
                                onChangedYes: isReadOnly
                                    ? null
                                    : (val) {
                                  state.model.escortedByHost= true;
                                  BlocProvider.of<
                                      VisitorPassManagementDetailsCubit>(
                                      context)
                                      .onCheckBoxChange(state.model);
                                },
                                onChangedNo: isReadOnly
                                    ? null
                                    : (val) {
                                  state.model.escortedByHost = false;
                                  BlocProvider.of<
                                      VisitorPassManagementDetailsCubit>(
                                      context)
                                      .onCheckBoxChange(state.model);
                                }),


                        if(state.model.escortedByHost == false)...[

                          /// Escorted By
                          CommonWidgets.textDisplay(
                            // state.labels?.locale.name ??
                            //     state.labels?.defaultLocale
                            //         .name ??
                              Constants.escortedby,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(
                              height * 0.001),
                          FlutterInputField(
                            controller: escortedByController,
                            textInputType: TextInputType.text,
                            textFormKey: Keys.contactNoKey,
                            hintText: '',
                            // focusNode: employeeIdFocusNode,
                            isEnable: !isReadOnly,
                            isDisableColor: isReadOnly,
                            onChange: (String value) {
                              state.model.escortedBy= value;
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(
                              height * 0.01),

                          /// Escorted By Employee Id
                          CommonWidgets.textDisplay(
                            // state.labels?.locale.name ??
                            //     state.labels?.defaultLocale
                            //         .name ??
                              Constants.escortedbyemployeeid,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(
                              height * 0.001),
                          FlutterInputField(
                            controller: escortedByEmployeeIdController,
                            textInputType: TextInputType.number,
                            textFormKey: Keys.contactNoKey,
                            hintText: '',
                            // focusNode: employeeIdFocusNode,
                            isEnable: !isReadOnly,
                            isDisableColor: isReadOnly,
                            onChange: (String value) {
                              state.model.escortedEmployeeId= value;
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(
                              height * 0.01),
                        ],


                            if(state.model.status ==2 || state.model.status ==8 || state.model.status ==9)...[
                        ///Pass Collected By
                            CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.p ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                    Constants.passCollectedBy,
                                isMandatory: true,
                                '${state.model.handoverSecurity?.firstName ?? ''} ${state.model.handoverSecurity?.lastName ?? ''}'),
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
                          BaseDate().datePickerWidgetLoading(
                            textController: returnedTimeController,
                            isDisabled: true,
                            onlyDate: false,
                            onChange: (String value) {
                              BlocProvider.of<
                                  VisitorPassManagementDetailsCubit>(
                                  context)
                                  .onModelValueChange(state.model);
                              //},
                            },
                            context: context,
                          ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
],
                            ///Attachments
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.attachment ??
                              //     state.labels?.defaultLocale.attachment ??
                                Constants.photoOfVisitor,
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
                                  in uploadFiles ?? []) {
                                    files.add(image);
                                  }
                                  BlocProvider.of<
                                      VisitorPassManagementDetailsCubit>(
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
                                attachments: state.loadAttachments,
                                files: uploadFiles,
                                moduleCode: Constants.passManagementModuleCode,
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

  Widget submitButtonDisplay(VisitorPassManagementDetailsState state) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<VisitorPassManagementDetailsCubit>(context).submitForm(
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
