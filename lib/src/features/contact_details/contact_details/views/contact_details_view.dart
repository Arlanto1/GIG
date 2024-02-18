import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/services/common_services.dart';

class ContactDetailsView extends StatefulWidget {
  final ContactDetailModel? model;
  final String title;

  const ContactDetailsView({
    super.key,
    this.model,
    required this.title,
  });

  @override
  State<ContactDetailsView> createState() => _ContactDetailsViewState();
}

class _ContactDetailsViewState extends State<ContactDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController returnableTextController = TextEditingController();
  User? userDetails;
  List<ImageContent> getFiles = [];
  List<ImageContent> getAttachments = [];
  TextEditingController takenOutOnDateController = TextEditingController();
  TextEditingController expectedDateOfReturnController =
      TextEditingController();
  TextEditingController actualDateOfReturnController = TextEditingController();
  bool isReadOnly = false;
  List<String> returnableDropDownValues = const [
    "Returnable",
    "Non Returnable"
  ];

  SignatureController receiverSignatureController = SignatureController();
  SignatureController securitySignatureController = SignatureController();

  @override
  void initState() {
    super.initState();
    receiverSignatureController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white);

    securitySignatureController = SignatureController(
        penStrokeWidth: 2,
        penColor: Colors.black,
        exportBackgroundColor: Colors.white);
    BlocProvider.of<ContactDetailsCubit>(context).initializeValues();
    initializeDates();
  }

  @override
  void dispose() {
    receiverSignatureController.dispose();
    securitySignatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<ContactDetailsCubit, ContactDetailsState>(
      listener: (context, state) {
        log('--NN-state.status-${state.status}-------');

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Material Movement',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                contactDetailsListRoute,
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

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: state.model.status != 6 &&
                    // state.model.status != 1 &&
                    !isReadOnly
                ? true
                : false,
            showSubmitButton: state.model.status != 6 &&
                    // state.model.status != 1 &&
                    !isReadOnly
                ? true
                : false,
            showDisLikeButton: false,
            showLikeButton: false,
            popAndReplace: () {
              log('--popAndReplace-----');
              // Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                contactDetailsListRoute,
              );
            },
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<ContactDetailsCubit>(context).submitForm(
                isSaveOnly: true,
                navigateToNextScreen: false,
              );
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<ContactDetailsCubit>(context).submitForm(
                isSaveOnly: false,
                navigateToNextScreen: false,
              );
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {
    // TODO: Maybe we can remove this
  }

  getBodybuilder(ContactDetailsState state, height) {
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
              child: AbsorbPointer(
                absorbing: isReadOnly,
                child: Form(
                  key: _formKey,
                  autovalidateMode: isReadOnly
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

                            /// Created By
                            CommonWidgets.verticalTextHandling(
                                state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,isMandatory: true,
                                '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
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
                            FlutterInputField(
                              isEnable: false,
                              isDisableColor: true,
                              textFormKey: Keys.statusTextController,
                              hintText: '',
                              initialValue:
                                  getStatusString(state.model.status ?? 0),
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                              state.labels?.locale.date ??
                                  state.labels?.defaultLocale.date ??
                                  Constants.dateofcreation,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
                                state.model.inputDate ?? ''),
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
                            locationWidgetdislay(state),

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

                            /// Modified Date
                            CommonWidgets.textDisplay(
                              state.labels?.locale.date ??
                                  state.labels?.defaultLocale.date ??
                                  Constants.dateofcreation,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// General Contact
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                state.labels?.locale.generalContact ??
                                    state
                                        .labels?.defaultLocale.generalContact ??
                                    Constants.generalContact,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            GestureDetector(
                              onTap: () async {
                                NavigatorState nav = Navigator.of(context);
                                bool isSaveSuccess =
                                    await BlocProvider.of<ContactDetailsCubit>(
                                            context)
                                        .submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );

                                if (!isSaveSuccess) {
                                  return;
                                }
                                log('--state.model.id---${state.model.id}--');
                                List<Organisation> ranks =
                                    await CommonServices().getOrganisations(
                                        name: Constants.contactGeneralRank);

                                nav.pushNamed(
                                  contactRecordsRoute,
                                  arguments: {
                                    ConstantsArgument.title:
                                        Constants.generalContact,
                                    ConstantsArgument.type: 0,
                                    ConstantsArgument.id: state.model.id,
                                    ConstantsArgument.rankType:
                                        Constants.contactGeneralRank,
                                    ConstantsArgument.ranks: ranks,
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
                                    'Add/View Contact(s)',
                                    style: TextStyle(
                                      color: AppColors.navigationSkybluecolor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Guarding Agency Escalation Contact
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                state.labels?.locale
                                        .guardingAgencyEscalationContact ??
                                    state.labels?.defaultLocale
                                        .guardingAgencyEscalationContact ??
                                    Constants.guardingAgencyContact,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            GestureDetector(
                              onTap: () async {
                                NavigatorState nav = Navigator.of(context);
                                bool isSaveSuccess =
                                    await BlocProvider.of<ContactDetailsCubit>(
                                            context)
                                        .submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );

                                if (!isSaveSuccess) {
                                  return;
                                }
                                log('--state.model.id---${state.model.id}--');
                                List<Organisation> ranks =
                                    await CommonServices().getOrganisations(
                                        name: Constants
                                            .contactGuardingAgencyEscalationRank);
                                nav.pushNamed(
                                  contactRecordsRoute,
                                  arguments: {
                                    ConstantsArgument.title:
                                        Constants.guardingAgencyContact,
                                    ConstantsArgument.type: 1,
                                    ConstantsArgument.id: state.model.id,
                                    ConstantsArgument.rankType: Constants
                                        .contactGuardingAgencyEscalationRank,
                                    ConstantsArgument.ranks: ranks,
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
                                    'Add/View Contact(s)',
                                    style: TextStyle(
                                      color: AppColors.navigationSkybluecolor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// System Escalation Contact
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                state.labels?.locale.systemEscalationContact ??
                                    state.labels?.defaultLocale
                                        .systemEscalationContact ??
                                    Constants.systemEscalationContact,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            GestureDetector(
                              onTap: () async {
                                NavigatorState nav = Navigator.of(context);
                                bool isSaveSuccess =
                                    await BlocProvider.of<ContactDetailsCubit>(
                                            context)
                                        .submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );

                                if (!isSaveSuccess) {
                                  return;
                                }
                                log('--state.model.id---${state.model.id}--');
                                List<Organisation> ranks =
                                    await CommonServices().getOrganisations(
                                        name: Constants
                                            .contactSystemEscalationRank);
                                nav.pushNamed(
                                  contactRecordsRoute,
                                  arguments: {
                                    ConstantsArgument.title:
                                        Constants.systemEscalationContact,
                                    ConstantsArgument.type: 2,
                                    ConstantsArgument.id: state.model.id,
                                    ConstantsArgument.rankType:
                                        Constants.contactSystemEscalationRank,
                                    ConstantsArgument.ranks: ranks,
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
                                    'Add/View Contact(s)',
                                    style: TextStyle(
                                      color: AppColors.navigationSkybluecolor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Supervisor Contact
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                state.labels?.locale.supervisorRank ??
                                    state
                                        .labels?.defaultLocale.supervisorRank ??
                                    Constants.cmsEscalationContact,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            GestureDetector(
                              onTap: () async {
                                NavigatorState nav = Navigator.of(context);
                                bool isSaveSuccess =
                                    await BlocProvider.of<ContactDetailsCubit>(
                                            context)
                                        .submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );

                                if (!isSaveSuccess) {
                                  return;
                                }
                                log('--state.model.id---${state.model.id}--');
                                List<Organisation> ranks =
                                    await CommonServices().getOrganisations(
                                        name: Constants.contactSupervisorRank);
                                nav.pushNamed(
                                  contactRecordsRoute,
                                  arguments: {
                                    ConstantsArgument.title:
                                        Constants.cmsEscalationContact,
                                    ConstantsArgument.type: 3,
                                    ConstantsArgument.id: state.model.id,
                                    ConstantsArgument.rankType:
                                        Constants.contactSupervisorRank,
                                    ConstantsArgument.ranks: ranks,
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
                                    'Add/View Contact(s)',
                                    style: TextStyle(
                                      color: AppColors.navigationSkybluecolor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),

                            /// Zonal Escalation Contact
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                state.labels?.locale
                                        .guardingAgencyZonalManager ??
                                    state.labels?.defaultLocale
                                        .guardingAgencyZonalManager ??
                                    Constants.guardingAgencyZonalManagerContact,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            GestureDetector(
                              onTap: () async {
                                NavigatorState nav = Navigator.of(context);
                                bool isSaveSuccess =
                                    await BlocProvider.of<ContactDetailsCubit>(
                                            context)
                                        .submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );

                                if (!isSaveSuccess) {
                                  return;
                                }
                                log('--state.model.id---${state.model.id}--');
                                List<Organisation> ranks =
                                    await CommonServices().getOrganisations(
                                        name: Constants.contactZone);
                                nav.pushNamed(
                                  contactRecordsRoute,
                                  arguments: {
                                    ConstantsArgument.title: Constants
                                        .guardingAgencyZonalManagerContact,
                                    ConstantsArgument.type: 4,
                                    ConstantsArgument.id: state.model.id,
                                    ConstantsArgument.rankType:
                                        Constants.contactZone,
                                    ConstantsArgument.ranks: ranks,
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
                                    'Add/View Contact(s)',
                                    style: TextStyle(
                                      color: AppColors.navigationSkybluecolor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// SubmitButton
                      if ((state.model.status == 6) ? false : true) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cancelButtonDisplay(state),
                            // if ((state.model.status != 1
                            // || state.model.status == 1
                            // )) ...[
                            submitButtonDisplay(),
                            // ],
                          ],
                        ),
                      ],
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getStatusString(int status) {
    switch (status) {
      case 0:
        return 'Draft';
      case 1:
        return 'Active';
      default:
        return '';
    }
  }

  Widget cancelButtonDisplay(ContactDetailsState state) {
    return AppButton(
      // Customize the button properties as needed
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        updateRecordStatus(state);
      },
    );
  }

  void updateRecordStatus(ContactDetailsState state) {
    if (state.model.id != null) {
      BlocProvider.of<ContactDetailsCubit>(context)
          .updateStatus(id: state.model.id.toString());
      Navigator.popAndPushNamed(context, contactDetailsListRoute);
    } else {
      Navigator.pop(context);
    }
  }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();

        BlocProvider.of<ContactDetailsCubit>(context).submitForm();
      },
    );
  }

  Widget locationWidgetdislay(ContactDetailsState state) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return CustomExpansionListTexts(
              locationList: state.locations,
              onTap: (Organisation? list) async {
                Organisation location = Organisation();
                location.id = list?.id;
                location.name = list?.name;
                state.model.location = location;

                BlocProvider.of<ContactDetailsCubit>(context)
                    .updateDropdownValues(location: location);
              },
            );
          },
        );
      },
      child: SelectedTileValueWidget(name: state.model.location?.name ?? ''),
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
// getById(int id, int type) async {
//   showLoadingDialog(context);
//
//   ContactListResponseModel contactsModel =
//   await ContactDetailsServices().getCdById(id, type);
//
//   editDataLoading(contactsModel);
// }
// void editDataLoading(ContactListResponseModel? model) {
//   dismissLoadingDialog(context);
//   if (model != null) {
//     Navigator.pushNamed(
//       context,
//       contactDetailsRoute,
//       arguments: {
//         "model": model,
//         "title": Constants.contactDetails,
//       },
//     );
//   }
// }
}
