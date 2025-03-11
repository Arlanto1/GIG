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

  final FocusNode sentToFocusNode = FocusNode();

  List<ImageContent>? uploadFiles;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SezPassManagementDetailsCubit>(context).initializeValues();
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

          // Utils.dynamicAlert(
          //     context, state.message ?? '', 'Day Pass Management', '');
        }
      },
      builder: (context, state) {
        nameController.text = state.model.employee !=null ? state.model.employee?.name ?? '' : state.model.employeeName ??'';
        hostController.text = state.model.host?.name ?? '';
        emailController.text = state.model.email??'';
        sezPassInfoController.text = state.model.passNo ?? '';
        mTPApplicationNoController.text = state.model.mifareNo??'';
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
              BlocProvider.of<SezPassManagementDetailsCubit>(context).submitForm(
                isSaveOnly: true,
              );
            },
            showSubmitButton: showSaveSubmitButtons ,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<SezPassManagementDetailsCubit>(context).submitForm(
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

  void initializeDates(SezPassManagementDetailsState state) {

    passValidFromController.text = state.model.startTime != null ?  Utils.timestampToDateConversion(
        int.tryParse(state.model.startTime ?? '') ??
            DateTime.now().millisecondsSinceEpoch, // Use current timestamp if null
        Constants.fulldateFormat) : '';

    passValidUntilController.text = state.model.endTime != null
        ? Utils.timestampToDateConversion(
        int.tryParse(state.model.endTime ?? '') ??
            DateTime.now().millisecondsSinceEpoch, // Fallback to current timestamp
        Constants.fulldateFormat)
        : Utils.timestampToDateConversion(
        DateTime.now().add(const Duration(hours: 12)).millisecondsSinceEpoch, // One day ahead
        Constants.fulldateFormat);
  }

  getBodybuilder(SezPassManagementDetailsState state, height) {
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
                            if(state.model.status !=null)...[
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
                                          SezPassManagementDetailsCubit>(
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
                                BlocProvider.of<SezPassManagementDetailsCubit>(
                                    context)
                                    .updateDropdownValues(
                                    entities: selectedEntities);
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              orgName: 'ATOM_ENTITIES',
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
                                          SezPassManagementDetailsCubit>(
                                          context)
                                          .updateDropdownValues(
                                          passType: passType);
                                    },
                                    leftImage: false,
                                    orgName: '',
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
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                    Constants.passCategory,
                                Styles.textStyleBlack14,
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
                                hintText: '',
                                // focusNode: employeeIdFocusNode,
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


                            /// Email
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.name ??
                              //     state.labels?.defaultLocale
                              //         .name ??
                                Constants.email,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: emailController,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              // focusNode: employeeIdFocusNode,
                              isEnable: !isReadOnly,
                              isDisableColor: true,
                              onChange: (String value) {
                                state.model.email = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),

                            /// Sez Pass Info
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.name ??
                              //     state.labels?.defaultLocale
                              //         .name ??
                                Constants.sezPassInfo,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              controller: sezPassInfoController,
                              textInputType: TextInputType.text,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              // focusNode: employeeIdFocusNode,
                              isEnable: !isReadOnly,
                              isDisableColor: true,
                              onChange: (String value) {
                                state.model.passNo = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),

                            /// MTP Application Number
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.name ??
                              //     state.labels?.defaultLocale
                              //         .name ??
                                Constants.mTPApplicationNo,
                                isMandatory: true,
                                Styles.textStyleBlack14),
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
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),


                            /// Pass Issued On
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.keyHandOverDue ??
                              //     state.labels?.defaultLocale
                              // .keyHandOverDue ??
                              Constants.passIssuedOn,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: passValidFromController,
                              isDisabled: false,
                              onlyDate: false,
                              showPastDate: true,
                              showFutureDate: false,
                              // fromDate: initialisedStartDate,
                              // toDate: initialisedToDate,
                              onChange: (String value) {
                                // isDateSelectedByUser = true;
                                passValidFromController.text = value;
                                // state.model.passV =
                                //     Utils().formatTime(value);
                                BlocProvider.of<
                                    SezPassManagementDetailsCubit>(
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
                                    SezPassManagementDetailsCubit>(
                                    context)
                                    .onModelValueChange(state.model);
                                //},
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Attachments
                            // CommonWidgets.textDisplay(
                            //   // state.labels?.locale.attachment ??
                            //   //     state.labels?.defaultLocale.attachment ??
                            //     Constants.evidenceDocuments,
                            //     Styles.textStyleBlack14),
                            // widget.model == null
                            //     ? CommonWidgets.verticalSpacerWidget(
                            //     height * 0.001)
                            //     : Container(),
                            // if (state.model.status == 0 ||
                            //     state.model.status == null) ...[
                            //   BaseImageUpload().uploadWidget(
                            //     context: context,
                            //     isDisabled: isReadOnly,
                            //     loggedInUserDetails:
                            //     state.loggedInUserDetails!,
                            //     getFiles: uploadFiles,
                            //     onImageSelected: (ImageContent data) {
                            //       List<ImageContent>? files = [];
                            //       files.add(data);
                            //       for (ImageContent image
                            //       in uploadFiles ?? []) {
                            //         files.add(image);
                            //       }
                            //       BlocProvider.of<
                            //           SezPassManagementDetailsCubit>(
                            //           context)
                            //           .addAttachment(
                            //         data: files,
                            //         images: files,
                            //       );
                            //     },
                            //   ),
                            // ],
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
                            if (!isReadOnly) ...[
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
            if (isReadOnly) ...[
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
