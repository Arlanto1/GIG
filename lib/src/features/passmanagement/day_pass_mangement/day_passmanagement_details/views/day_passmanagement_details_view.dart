import 'dart:convert';
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
  bool isReadOnly = false;
  // List<String> returnableDropDownValues = const [
  //   "Returnable",
  //   "Non Returnable"
  // ];
  TextEditingController passTypeController =
  TextEditingController();
  TextEditingController nameController = TextEditingController();
  SignatureController securitySignatureController = SignatureController();
  TextEditingController materialComingFromBriefDescriptionController =
  TextEditingController();
  TextEditingController receiverEmailController = TextEditingController();
  TextEditingController receiverByEmailController = TextEditingController();
  TextEditingController requesterEmailController = TextEditingController();
  final FocusNode requestorEmployeeIdFocusNode = FocusNode();
  final FocusNode receivedForEmployeeIdFocusNode = FocusNode();
  final FocusNode sentToFocusNode = FocusNode();
  final FocusNode receivedByFocusNode = FocusNode();

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
  bool showLikeAndDislikeButton = false;
  bool editByRequester = false;
  bool editByCreatedByUser = false;
  bool lock = false;
  bool isApproverRequesterEmailDepartment = false;
  bool isEligibleToEdit = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<DayPassManagementDetailsCubit,
        DayPassManagementDetailsState>(
      listener: (context, state) {
        log('-state.status--${state.status}--');

        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.dayPassManagementTitle,
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                  context, dayPassManagementDetailsRoute, arguments: {
              });
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
        // receiverEmailController.text = state.model.receiverEmail ?? '';
        // receiverByEmailController.text = state.model.otherReceiverName ?? '';
        // requesterEmailController.text = state.model.requestorEmail ?? '';
        //
        // if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        // if (state.model.status == 10 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        // if (state.model.status == -1 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        // if (state.model.status == 0 && state.model.lock.isEmptyOrNull) {
        //   isReadOnly = false;
        // }
        // if (state.model.status == 4 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        // // if (state.model.status == 5 || !state.model.lock.isEmptyOrNull) {
        // //   isReadOnly = true;
        // // }
        // if (state.model.status != ConstantsIntValue.mmStatusInwardWaiting &&
        //     (state.model.status == null || state.model.status == 0)) {
        //   isApproverRequesterEmailDepartment = true;
        // }
        //
        // if (state.model.status == null) {
        //   isReadOnly = false;
        // }
        // if (state.model.isEligibleToEdit) {
        //   isEligibleToEdit = true;
        // }
        // String? requesterEmailUser = state.model.requestorEmail;
        //
        // log('123 ${state.model.requestorEmail}');
        // if ((state.model.status == ConstantsIntValue.businessUserReview ||
        //     state.model.status == ConstantsIntValue.mmStatusLSMRejected) &&
        //     (requesterEmailUser != null &&
        //         requesterEmailUser == '${state.loggedInUserDetails?.firstName} ${state.loggedInUserDetails?.lastName} (${state.loggedInUserDetails?.email})')) {
        //   isReadOnly = false;
        // }
        //
        // if (!state.model.lock.isEmptyOrNull) {
        //   lock = true;
        // }

        showLikeAndDislikeButton =
            (state.model.status == ConstantsIntValue.mmStatusLSMReview) &&
                (state.model.entrySecurity!.email
                    .equalsIgnoreCase(state.loggedInUserDetails?.email));

        // editByRequester = ((state.model.status ==
        //     ConstantsIntValue.businessUserReview ||
        //     state.model.status == ConstantsIntValue.mmStatusLSMRejected) &&
        //     (requesterEmailUser != null &&
        //         requesterEmailUser == '${state.loggedInUserDetails?.firstName} ${state.loggedInUserDetails?.lastName} (${state.loggedInUserDetails?.email})'));
        //
 editByCreatedByUser =
        ((state.model.status == ConstantsIntValue.mmStatusApproved ||
            state.model.status ==
                ConstantsIntValue.mmStatusInwardWaiting) &&
            ((state.model.entrySecurity!.email
                .equalsIgnoreCase(state.loggedInUserDetails?.email)) ||
                isEligibleToEdit));

        showSaveSubmitButtons = widget.model == null ||
            state.model.status == 0 ||
            (state.model.status != ConstantsIntValue.mmStatusLSMApproved &&
                state.model.status !=
                    ConstantsIntValue.mmStatusLSMReview) &&
                editByRequester ||
            editByCreatedByUser;

        // showLikeAndDislikeButton =
        //     (state.model.status == ConstantsIntValue.mmStatusLSMReview) &&
        //         (state.model.approver1Email
        //                 .equalsIgnoreCase(state.loggedInUserDetails?.email) ||
        //             state.model.approver2Email
        //                 .equalsIgnoreCase(state.loggedInUserDetails?.email));
        // showSaveSubmitButtons = (state.model.status == 0 ||
        //         state.model.status == 8 ||
        //         // state.model.status == 1 ||
        //         state.model.status == 6 ||
        //         state.model.status == 7 ||
        //         state.model.status == 9 ||
        //         state.model.status == null ||
        //         isReadOnly == false)  &&   state.model.status != ConstantsIntValue.mmStatusLSMReview &&
        //     state.model.lock.isEmptyOrNull;

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: showSaveSubmitButtons &&
                state.model.status != ConstantsIntValue.mmStatusClosed &&
                !lock,
            pdfAPIName:
            '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=$moduleCode',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<DayPassManagementDetailsCubit>(context).submitForm(
                isSaveOnly: true,
                 );
            },
            showSubmitButton: showSaveSubmitButtons &&
                state.model.status != ConstantsIntValue.mmStatusClosed &&
                !lock,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<DayPassManagementDetailsCubit>(context).submitForm(
                isSaveOnly: false,
              );
            }, showLikeButton: false,
            showDisLikeButton: false,
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(DayPassManagementDetailsState state) {
    // if (state.model.expectedDateOfReturn != null) {
    //   expectedDateOfReturnController.text = Utils.timestampToDateConversion(
    //       int.tryParse(state.model.expectedDateOfReturn ?? '0'),
    //       Constants.dateFormat);
    // }
    // if (state.model.actualDateOfReturn != null) {
    //   actualDateOfReturnController.text = Utils.timestampToDateConversion(
    //       int.tryParse(widget.model?.actualDateOfReturn ?? '0'),
    //       Constants.fulldateFormat);
    // }

    // if (state.model.takenOutDate != null) {
    //   takenOutOnDateController.text = Utils.timestampToDateConversion(
    //       int.tryParse(widget.model?.takenOutDate ?? '0'),
    //       Constants.fulldateFormat);
    // }
  }

  getBodybuilder(DayPassManagementDetailsState state, height) {
    initializeDates(state);
    log('-state.materialMovement.status---${state.model.status}--');


    // returnableTextController.text =
    // widget.returnable == true ? 'Returnable' : 'Non Returnable';
    //
    // if (widget.returnable == true) {
    //   returnableTextController.text == 'Returnable';
    // } else {
    //   returnableTextController.text == 'Non Returnable';
    // }
    // ((state.model.returnable ?? false) || (widget.returnable ?? false))
    //     ? 'Returnable'
    //     : 'Non Returnable';
    // if (returnableTextController.text == 'Returnable') {
    //   if (widget.returnable ?? true) {
    //     state.model.returnable = true;
    //   }
    // } else {
    //   state.model.returnable = false;
    // }
    // state.model.returnable ??= false ;
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      getFiles = state.loadAttachments ?? [];
    }
    // bool isQuantityDisabled = (state.model.status == 10 ||
    //     state.model.status == -1 ||
    //     state.model.status == 6 ||
    //     state.model.status == 2);

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
                        absorbing: !showSaveSubmitButtons || lock,
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
                                isEnabled: (state.model.status ==
                                    ConstantsIntValue.passCreatedStatus ||
                                    state.model.status == null) &&
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
                              enabled: true,
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
                // state.labels?.locale.passType ??
                // state.labels?.defaultLocale.passType ??
                    Constants.passtype,
                    Styles.textStyleBlack14,
                    isMandatory: true),
                  CommonWidgets.verticalSpacerWidget(
                      height * 0.001),
                  CommonWidgets.verticalSpacerWidget(
                      height * 0.001),
                  BaseDropDown().getDropDown(
                    isDisabled: state.model.status != 6,
                    textController: passTypeController,
                    items: dayPassTypeValues,
                    initialValue:
                    state.model.passType.toString(),
                    onTap: () {
                      BaseDropDown().assetTypeDialog(
                        context: context,
                        dropDownValues: dayPassTypeValues
                            .map((label) => label.key)
                            .toList(),
                        onTap: (String value) {
                          Label? selectedLabel;
                          selectedLabel =
                              dayPassTypeValues.firstWhere(
                                    (label) => label.key == value,
                                orElse: () =>
                                const Label(key: '', value: ''),
                              );
                          BlocProvider.of<DayPassManagementDetailsCubit>(
                              context)
                              .updateDropdownValues(
                              passType: int.tryParse(
                                  selectedLabel.value));
                        },
                      );
                    },
                  ),
                  CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Article Type
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
                              isDisableColor: false,
                              onTap: () {
                                BaseOrganisationDialog().departmentDialog(
                                  context: context,
                                  organisations: state.getCompanyTypeResponse,
                                  onTap: (Organisation companyType) {
                                    BlocProvider.of<DayPassManagementDetailsCubit>(
                                        context)
                                        .updateDropdownValues(
                                        companyType: companyType);
                                  },
                                  leftImage: false,
                                  orgName: 'ARTICLE_LIST',
                                  functionToCall: () {
                                    // refresh the list
                                    BlocProvider.of<DayPassManagementDetailsCubit>(
                                        context)
                                        .refreshList();
                                  },
                                );
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
                              initialValue: '',
                              characterLimit:
                              Constants.characterLimitIdTextFormField,
                              hintText: '',
                              isEnable: true,
                              isDisableColor:false,
                              onChange: (String value) {
                                state.model.companyName = value;
                                context
                                    .read<DayPassManagementDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            /// Employee Id
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.employeeID ??
                                //     state.labels?.defaultLocale
                                //         .employeeID ??
                                    Constants.employeeid,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.employeeID,
                              height: 60,
                              isDisableColor: false,
                              onTap: () {
                                // if (isEnabled) {
                                  BaseOrganisationDialog().userDialog(
                                    employeeId: true,
                                    context: context,
                                    users: state.emailUsers!,
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
                                // }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),

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
                              isEnable: false,
                              isDisableColor: true,
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.01),

                            ///Db Sponsor Employee Id
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.employeeID ??
                              //     state.labels?.defaultLocale
                              //         .employeeID ??
                                Constants.dbSponsorEmployeeId,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.employeeID,
                              height: 60,
                              isDisableColor: false,
                              onTap: () {
                                // if (isEnabled) {
                                BaseOrganisationDialog().userDialog(
                                  employeeId: true,
                                  context: context,
                                  users: state.emailUsers!,
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
                                // }
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
                              controller: nameController,
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

                            ///Host Employee Id
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.employeeID ??
                              //     state.labels?.defaultLocale
                              //         .employeeID ??
                                Constants.hostemployeeid,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            TextFieldAddButton(
                              title: state.model.employeeID,
                              height: 60,
                              isDisableColor: false,
                              onTap: () {
                                // if (isEnabled) {
                                BaseOrganisationDialog().userDialog(
                                  employeeId: true,
                                  context: context,
                                  users: state.emailUsers!,
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
                                // }
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
                              controller: nameController,
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


                            ///  Department
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.requestorDepartment ??
                              //     state.labels?.defaultLocale
                              //         .requestorDepartment ??
                                  Constants.department,
                              Styles.textStyleBlack14,
                              isMandatory: state.model.status !=
                                  ConstantsIntValue.mmStatusDraft &&
                                  widget.model != null
                                  ? true
                                  : false,
                            ),
                            TextFieldAddButton(
                              title: 'state.model.department?.name',
                              height: 70,
                              isDisableColor: false,
                              onTap: () {
                                if (
                                    !state.model.lock.isEmptyOrNull
                                    ? false
                                    : true) {
                                  BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.departments,
                                      onTap: (Organisation department) {
                                        // state.model.requestorDepartment
                                        //     ?.name = department.name;

                                        BlocProvider.of<
                                            DayPassManagementDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                            department:
                                            department);
                                      },
                                      orgName: 'EMPLOYEE_DEPARTMENTS',
                                      createEntity: false,
                                      title: 'Add Key Type',
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

                            // dbwanttodepartmentaddButtonwidgetLoading(state),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Reason for Day Pass
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.requestorDepartment ??
                              //     state.labels?.defaultLocale
                              //         .requestorDepartment ??
                              Constants.reasonfordaypass,
                              Styles.textStyleBlack14,
                              isMandatory: state.model.status !=
                                  ConstantsIntValue.mmStatusDraft &&
                                  widget.model != null
                                  ? true
                                  : false,
                            ),
                            TextFieldAddButton(
                              title: 'state.model.department?.name',
                              height: 70,
                              isDisableColor: false,
                              onTap: () {
                                if (
                                !state.model.lock.isEmptyOrNull
                                    ? false
                                    : true) {
                                  BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.departments,
                                      onTap: (Organisation department) {
                                        // state.model.requestorDepartment
                                        //     ?.name = department.name;

                                        BlocProvider.of<
                                            DayPassManagementDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                            department:
                                            department);
                                      },
                                      orgName: 'EMPLOYEE_DEPARTMENTS',
                                      createEntity: false,
                                      title: 'Add Key Type',
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

                            // dbwanttodepartmentaddButtonwidgetLoading(state),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),


                            /// Day Pass Number
                            CommonWidgets.textDisplay(
                              // state.labels?.locale.requestorDepartment ??
                              //     state.labels?.defaultLocale
                              //         .requestorDepartment ??
                              Constants.dayPassNo,
                              Styles.textStyleBlack14,
                              isMandatory: state.model.status !=
                                  ConstantsIntValue.mmStatusDraft &&
                                  widget.model != null
                                  ? true
                                  : false,
                            ),
                            TextFieldAddButton(
                              title: 'state.model.department?.name',
                              height: 70,
                              isDisableColor: false,
                              onTap: () {
                                if (
                                !state.model.lock.isEmptyOrNull
                                    ? false
                                    : true) {
                                  BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.departments,
                                      onTap: (Organisation department) {
                                        // state.model.requestorDepartment
                                        //     ?.name = department.name;

                                        BlocProvider.of<
                                            DayPassManagementDetailsCubit>(
                                            context)
                                            .updateDropdownValues(
                                            department:
                                            department);
                                      },
                                      orgName: 'EMPLOYEE_DEPARTMENTS',
                                      createEntity: false,
                                      title: 'Add Key Type',
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
                              isDisabled: false,
                              onlyDate: false,
                              // showPastDate: false,
                              // fromDate: initialisedStartDate,
                              // toDate: initialisedToDate,
                              onChange: (String value) {
                                // isDateSelectedByUser = true;
                                // keyReturnDueDateController.text = value;
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
                            // dbwanttodepartmentaddButtonwidgetLoading(state),
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
                              textController: passValidFromController,
                              isDisabled: false,
                              onlyDate: false,
                              // showPastDate: false,
                              // fromDate: initialisedStartDate,
                              // toDate: initialisedToDate,
                              onChange: (String value) {
                                // isDateSelectedByUser = true;
                                // keyReturnDueDateController.text = value;
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
                            // dbwanttodepartmentaddButtonwidgetLoading(state),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            /// SubmitButton
                      if (((state.model.status == 0 ||
                          state.model.status == 8 ||
                          state.model.status == 1 ||
                          state.model.status == 6 ||
                          state.model.status == 7 ||
                          state.model.status == 5 ||
                          state.model.status == 9 ||
                          state.model.status == null) &&
                          !lock)
                          ? true
                          : false) ...[
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
            if ((state.model.status == 2 ||
                state.model.status == 3 ||
                state.model.status == 4 ||
                state.model.status == 10 ||
                state.model.status == -1) ||
                lock) ...[
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

  AbsorbPointer buildSignature({
    required SignatureController controller,
    required String label,
    required double spaceHeight,
    required MaterialMovementDetailsState state,
  }) {
    bool isEditable = false;
    bool isSigned = false;
    bool isReceiver = label.equalsIgnoreCase(Constants.receiverSignature);
    if (isReceiver) {
      isSigned = state.model.receiverSign != null &&
          !state.model.receiverSign!.imageContent.isEmptyOrNull;
      isEditable = state.isReceiverSignEditable;
    } else {
      isSigned = state.model.entrySecuritySign != null &&
          !state.model.entrySecuritySign!.imageContent.isEmptyOrNull;
      isEditable = state.isEntrySecuritySignatureSignEditable;
    }

    return AbsorbPointer(
      absorbing: !state.model.lock.isEmptyOrNull ||
          state.model.status == -1 ||
          state.model.status == 10,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidgets.textDisplay(
                label,
                Styles.textStyleBlack14,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.clear();
                      if (isReceiver) {
                        BlocProvider.of<MaterialMovementDetailsCubit>(context)
                            .makeSignEditable(receiverSign: true);
                      } else {
                        BlocProvider.of<MaterialMovementDetailsCubit>(context)
                            .makeSignEditable(
                            entrySecuritySignatureSignEditable: true);
                      }
                    },
                    iconSize: 20,
                    color: Colors.grey,
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ],
          ),
          CommonWidgets.verticalSpacerWidget(spaceHeight * 0.001),
          ClipRect(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                border: Border.all(
                  color: AppColors.geryLightBackground,
                  width: 1, // Border width
                ),
              ),
              height: 100,
              width: double.infinity,
              child: (!isEditable && isSigned)
                  ? Image.memory(
                Uint8List.fromList(
                  base64Decode(
                    isReceiver
                        ? state.model.receiverSign!.imageContent ?? ''
                        : state.model.entrySecuritySign!.imageContent ??
                        '',
                  ),
                ),
                fit: BoxFit.none,
              )
                  : Signature(
                controller: controller,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          CommonWidgets.verticalSpacerWidget(spaceHeight * 0.01),
        ],
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
