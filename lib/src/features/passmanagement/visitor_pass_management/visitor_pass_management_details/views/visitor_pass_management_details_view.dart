
import 'dart:developer';
import 'dart:ui';

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
  TextEditingController passValidUntilController = TextEditingController();
  bool isReadOnly = false;
  TextEditingController passTypeController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController visitorNameController = TextEditingController();
  TextEditingController visitorComingFromController = TextEditingController();
  TextEditingController hostController = TextEditingController();
  TextEditingController purposeOfVisitController = TextEditingController();
  TextEditingController photoIdentityController = TextEditingController();
  TextEditingController updateStatusTextController = TextEditingController();
  TextEditingController escortedByController = TextEditingController();
  TextEditingController escortedByEmployeeIdController =
      TextEditingController();
  TextEditingController returnedTimeController = TextEditingController();
  TextEditingController visitorLapSerialNumController = TextEditingController();

  final FocusNode sentToFocusNode = FocusNode();

  List<ImageContent>? uploadFiles;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VisitorPassManagementDetailsCubit>(context)
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
    return BlocConsumer<VisitorPassManagementDetailsCubit,
        VisitorPassManagementDetailsState>(
      listener: (context, state) {
        log('-state.status--${state.status}--');
        log('123 ${state.message}--');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.visitorPassManagementTitle,
            message: state.message,
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, visitorPassManagementListRoute,
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
        visitorNameController.text = state.model.employeeName ?? '';
        purposeOfVisitController.text = state.model.visitingPurpose ?? '';
        escortedByController.text = state.model.escortedBy ?? '';
        visitorLapSerialNumController.text = state.model.otherIdInfo ?? '';

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
            state.model.lock.isEmptyOrNull ;

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: (widget.model == null || state.model.status == 0) &&
                state.status != FormStatus.loading,
            pdfAPIName:
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=PM',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<VisitorPassManagementDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: true,
              );
            },
            // visitorPassId: state.model.status != null ? true : false,
            showSubmitButton:  showSaveSubmitButtons && state.status != FormStatus.loading &&  state.model.status != 8,
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<VisitorPassManagementDetailsCubit>(context).submitForm(
                // isSaveOnly: false,
              );
              // if (state.model.id != null) {
              //   final pdfUrl = '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=VPM';
              //   DownloadImage().exportPdf(context, 'export.pdf', '/$pdfUrl');
              // }
            },

            // onTapSubmit: () async {
            //   FocusScope.of(context).unfocus();
            //
            //   final stateCubit = BlocProvider.of<VisitorPassManagementDetailsCubit>(context);
            //   final modelId = stateCubit.state.model.id;
            //
            //   // 1️⃣ Only if we have ID, download PDF first
            //   if (modelId != null) {
            //     final pdfUrl = '${CommonApis.exportDetailPagePDF}$modelId&moduleCode=VPM';
            //
            //     // await ensures PDF is downloaded before moving on
            //     await DownloadImage().exportPdf(context, 'export.pdf', '/$pdfUrl');
            //   }
            //
            //   // 2️⃣ Submit/save the record AFTER PDF is done
            //   await stateCubit.submitForm(isSaveOnly: false);
            // },
            // onTapSubmit: () async {
            //   FocusScope.of(context).unfocus();
            //
            //   final cubit = BlocProvider.of<VisitorPassManagementDetailsCubit>(
            //       context);
            //   final modelId = cubit.state.model.id;
            //
            //   if (modelId != null) {
            //     final pdfUrl = '${CommonApis
            //         .exportDetailPagePDF}$modelId&moduleCode=VPM';
            //
            //     // Just await PDF download (no return value)
            //     await DownloadImage().exportPdf(
            //         context, 'export.pdf', '/$pdfUrl');
            //
            //     // After download, unlock and submit
            //     CommonServices().unlock();
            //     await cubit.submitForm(isSaveOnly: false);
            //
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(
            //           content: Text('Record submitted successfully')),
            //     );
            //   }
            // },
            // onTapSubmit: () async {
            //   FocusScope.of(context).unfocus();
            //
            //   final cubit =
            //       BlocProvider.of<VisitorPassManagementDetailsCubit>(context);
            //   final state = cubit.state;
            //
            //   final validation = state.isValid;
            //   if (!validation.status) {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //         content: Text(validation.message),
            //         backgroundColor: Colors.red,
            //       ),
            //     );
            //     return;
            //   }
            //
            //   final modelId = state.model.id;
            //   if (modelId == null) return;
            //
            //   //VALIDATION PASSED → OPEN PDF
            //   final pdfUrl =
            //       '${CommonApis.exportDetailPagePDF}$modelId&moduleCode=VPM';
            //
            //   await DownloadImage()
            //       .exportPdf(context, 'export.pdf', '/$pdfUrl');
            //
            //   CommonServices().unlock();
            //   await cubit.submitForm(isSaveOnly: false);
            //
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(
            //       content: Text('Record submitted successfully'),
            //       backgroundColor: Colors.green,
            //     ),
            //   );
            // },

            showLikeButton: false,
            showDisLikeButton: false,
          ),
          backgroundColor: Colors.transparent,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(VisitorPassManagementDetailsState state) {
    passValidFromController.text = Utils.timestampToDateConversion(
        int.tryParse(state.model.startTime ?? '') ??
            DateTime.now().millisecondsSinceEpoch,
        Constants.fulldateFormat);

    // state.model.startTime == passValidFromController.text;

    // passValidUntilController.text = Utils.timestampToDateConversion(
    //   DateTime.fromMillisecondsSinceEpoch(
    //     int.tryParse(state.model.startTime ?? '') ??
    //         DateTime.now().millisecondsSinceEpoch,
    //   )
    //       .add(const Duration(hours: 24))
    //       .millisecondsSinceEpoch,
    //   Constants.fulldateFormat,
    // );

// Get the start timestamp from the model
    int startTimestamp = int.tryParse(state.model.startTime ?? '') ??
        DateTime.now().millisecondsSinceEpoch ~/ 1000; // in seconds

// // Convert start timestamp to formatted date string for "Valid From"
//     passValidFromController.text = Utils.timestampToDateConversion(
//         startTimestamp, Constants.fulldateFormat);


    // Convert start timestamp to DateTime
    DateTime validFrom =
    DateTime.fromMillisecondsSinceEpoch(startTimestamp * 1000);

// Set Valid Until to 8:00 PM of the same day
    DateTime validUntil = DateTime(
      validFrom.year,
      validFrom.month,
      validFrom.day,
      20, // 8 PM
      0,
      0,
    );

// Set text fields
    passValidFromController.text = Utils.timestampToDateConversion(
        startTimestamp, Constants.fulldateFormat);


    passValidUntilController.text = Utils.timestampToDateConversion(
      validUntil.millisecondsSinceEpoch ~/ 1000,
      Constants.fulldateFormat,
    );

    // Convert back to timestamp (seconds)
    int untilTimestamp = validUntil.millisecondsSinceEpoch ~/ 1000;

// Update model endTime as string
    state.model.endTime = untilTimestamp.toString();


// Calculate "Valid Until" as 12 hours after start
//     int untilTimestamp = startTimestamp + 12 * 60 * 60; // 12 hours in seconds
//
// // Convert until timestamp to formatted date string
//     passValidUntilController.text = Utils.timestampToDateConversion(
//         untilTimestamp, Constants.fulldateFormat);
//
// // Update model endTime as string
//     state.model.endTime = untilTimestamp.toString();

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

    // state.model.endTime == passValidUntilController.text;
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
                              CommonWidgets.horizontalTextHandling(
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
                                                            VisitorPassManagementDetailsCubit>(
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
                                                      VisitorPassManagementDetailsCubit>(
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
                                                VisitorPassManagementDetailsCubit>(
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
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              dateCreateWidgetDisplay(
                                  state.model.inputDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Sl No.
                              CommonWidgets.horizontalTextHandling(
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
                                                      child: const Text("OK", style: Styles.textStyleWhite16,),
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
                                      VisitorPassManagementDetailsCubit>(
                                      context)
                                      .updateDropdownValues(
                                      entities: selectedEntities);
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                functionToCall: () {
                                  // refresh the list
                                  BlocProvider.of<
                                      VisitorPassManagementDetailsCubit>(
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
                                state.labels?.locale.visitorName ??
                                    state.labels?.defaultLocale.visitorName ??
                                    Constants.visitorName,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.text,
                                textFormKey: Keys.challanKey,
                                controller: visitorNameController,
                                characterLimit:
                                    Constants.characterLimitIdTextFormField,
                                hintText: '',
                                isEnable: !isReadOnly,
                                isDisableColor: false,
                                onChange: (String value) {
                                  state.model.employeeName = value;
                                  context
                                      .read<VisitorPassManagementDetailsCubit>()
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              ///Visitor Coming From
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.visitorComingFrom ??
                                      state.labels?.defaultLocale
                                          .visitorComingFrom ??
                                      Constants.visitorComingFrom,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                controller: visitorComingFromController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.contactNoKey,
                                hintText: '',
                                isEnable: !isReadOnly,
                                isDisableColor: isReadOnly,
                                onChange: (String value) {
                                  state.model.visitorComingFrom = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Photo Identity Validation Type
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.visitorImage ??
                                      state
                                          .labels?.defaultLocale.visitorImage ??
                                      Constants.photoIdentityType,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDropDown().getDropDown(
                                  isDisabled: true,
                                  textController: photoIdentityController,
                                  items: photoIdentityValidationValues,
                                  initialValue:
                                      state.model.idValidationType.toString(),
                                  onTap: () {
                                    if (!isReadOnly) {
                                      BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues:
                                            photoIdentityValidationValues
                                                .map((label) => label.key)
                                                .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              photoIdentityValidationValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      VisitorPassManagementDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  validateType: int.tryParse(
                                                      selectedLabel.value));
                                        },
                                      );
                                    }
                                  }),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),

                              ///Purpose of Visit
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.visitingPurpose ??
                                      state.labels?.defaultLocale
                                          .visitingPurpose ??
                                      Constants.purposeOfVisit,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                controller: purposeOfVisitController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.contactNoKey,
                                hintText: '',
                                isEnable: !isReadOnly,
                                isDisableColor: isReadOnly,
                                onChange: (String value) {
                                  state.model.visitingPurpose = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

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
                                                      VisitorPassManagementDetailsCubit>(
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
                                state.labels?.locale.visitorPassInfo ??
                                    state.labels?.defaultLocale
                                        .visitorPassInfo ??
                                    Constants.visitorPassNo,
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
                                                    VisitorPassManagementDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                passNo: department);
                                      },
                                    );
                                  }
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Visitor's laptop serial number
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.escortedBy ??
                                  //     state
                                  //         .labels?.defaultLocale.escortedBy ??
                                      Constants.visitorsLapSerialNum,
                                  isMandatory: false,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                controller: visitorLapSerialNumController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.contactNoKey,
                                hintText: '',
                                isEnable: !isReadOnly,
                                isDisableColor: isReadOnly,
                                onChange: (String value) {
                                  state.model.otherIdInfo = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.01),

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
                                // state.model.status == 0 ||
                                //         state.model.status == null
                                //     ? false
                                //     : true,
                                onlyDate: false,
                                showPastDate: false,
                                showFutureDate: true,
                                // nextDateOnly: true,
                                onChange: (String value) {
                                  passValidFromController.text = value;

                                  int startTimestamp =
                                      Utils.dateToTimestampConversion(
                                          value, Constants.fulldateFormat);
                                  state.model.startTime =
                                      startTimestamp.toString();
                                  int untilTimestamp =
                                      startTimestamp + 12 * 60 * 60;

                                  passValidUntilController.text =
                                      Utils.timestampToDateConversion(
                                          untilTimestamp * 1000,
                                          Constants.fulldateFormat);

                                  state.model.endTime =
                                      untilTimestamp.toString();
                                  BlocProvider.of<
                                              VisitorPassManagementDetailsCubit>(
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
                                onChange: (String value) {},
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Escorted By
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.escortedByHost ??
                                      state.labels?.defaultLocale
                                          .escortedByHost ??
                                      Constants.escortedByHost,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              RadioButtonsYesNo(
                                  status: state.model.status ?? 0,
                                  selectedValue:
                                      state.model.escortedByHost ? 1 : 0,
                                  onChangedYes: isReadOnly
                                      ? null
                                      : (val) {
                                          state.model.escortedByHost = true;
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

                              if (state.model.escortedByHost == false) ...[
                                /// Escorted By
                                CommonWidgets.textDisplay(
                                    state.labels?.locale.escortedBy ??
                                        state
                                            .labels?.defaultLocale.escortedBy ??
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
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

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
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              if (state.model.status == 2 ||
                                  state.model.status == 8 ||
                                  state.model.status == 9) ...[
                                ///Pass Collected By
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
                                                VisitorPassManagementDetailsCubit>(
                                            context)
                                        .onModelValueChange(state.model);
                                  },
                                  context: context,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],

                              ///Attachments
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.visitorImage ??
                                      state
                                          .labels?.defaultLocale.visitorImage ??
                                      Constants.photoOfVisitor,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

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

  Widget submitButtonDisplay(VisitorPassManagementDetailsState state) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<VisitorPassManagementDetailsCubit>(context)
            .submitForm();
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
