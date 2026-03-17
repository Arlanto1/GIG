import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/ticketing_system/models/activityNote_model.dart';
import 'package:intl/intl.dart';

import '../../models/ticketing_system_model.dart';
import '../cubits/ticketing_system_details_cubit.dart';

class TicketingSystemDetailsView extends StatefulWidget {
  final TicketingSystemModel? model;
  final String title;

  const TicketingSystemDetailsView({
    super.key,
    this.model,
    required this.title,
  });

  @override
  State<TicketingSystemDetailsView> createState() =>
      _TicketingSystemDetailsView();
}

class _TicketingSystemDetailsView extends State<TicketingSystemDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController statusController = TextEditingController();
  TextEditingController ticketTypeController = TextEditingController();
  TextEditingController priorityTypController = TextEditingController();
  TextEditingController ticketRaisedForController = TextEditingController();
  TextEditingController ragStatusController = TextEditingController();
  TextEditingController toDateController =TextEditingController();
  User? userDetails;
  bool isReadOnly = false;
  bool showSaveSubmitButton = false;
  List<ImageContent> uploadFiles = [];
  List<ImageContent> getAttachments = [];

  TextEditingController toDateTextController = TextEditingController();
  TextEditingController startDateTextController = TextEditingController();
  TextEditingController activityDateController =TextEditingController();

  TextEditingController additionalInformationTextController =
      TextEditingController();

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TicketingSystemDetailsCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<TicketingSystemDetailsCubit,
        TicketingSystemDetailsState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.ticketingSystem,
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                ticketingSystemListRoute,
              );
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
      },
      builder: (context, state) {
        if (state.model.status == null) {
          isReadOnly = false;
        }
        showSaveSubmitButton =
            state.model.status != 9 && state.model.lock.isEmptyOrNull;
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.ticketingSystem,
            showPopUp: false,
            showSaveButton:
                false,
            showSubmitButton:  showSaveSubmitButton && state.status != FormStatus.loading
                ? true
                : false,
            showDisLikeButton: false,
            showLikeButton: false,
            // pdfAPIName:
            // '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.vipVisitorsDetailsModule}',
            onTapSave: () {
              // FocusScope.of(context).unfocus();
              // BlocProvider.of<TicketingSystemDetailsCubit>(context)
              //     .submitForm();
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<TicketingSystemDetailsCubit>(context).submitForm(
                isSaveOnly: false,
              );
            },
          ),
          backgroundColor: AppColors.newColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(TicketingSystemDetailsState state) {
    startDateTextController.text = state.model.fromDate != null
        ? Utils.timestampToDateConversion(
            int.tryParse(state.model.fromDate ?? '0'),
            Constants.fulldateFormat)
        : Utils().getCurrentDate();

    toDateController.text = state.model.toDate != null
        ? Utils.timestampToDateConversion(
        int.tryParse(state.model.toDate ?? '') ??
            DateTime.now()
                .millisecondsSinceEpoch, // Use current timestamp if null
        Constants.fulldateFormat)
        : '';
  }

  getBodybuilder(TicketingSystemDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      // uploadFiles = state.uploadAttachments;
      uploadFiles = state.model.attachments ?? [];
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
                child: AbsorbPointer(
                  absorbing: state.model.status == 9,
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
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  Constants.generalinformation,
                                  style: Styles.textStyleRegularNormalWhite18,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Status
                              CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),

                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              BaseDropDown().getDropDown(
                                isDisabled: false,
                                textController: statusController,
                                items: ticketStatusDropDownValues,
                                initialValue: '${state.model.status ??= 0}',
                                onTap: () {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues:
                                    ticketStatusDropDownValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          ticketStatusDropDownValues
                                              .firstWhere(
                                                (label) => label.key == value,
                                            orElse: () =>
                                            const Label(
                                              key: '',
                                              value: '',
                                            ),
                                          );

                                      BlocProvider.of<
                                          TicketingSystemDetailsCubit>(
                                          context)
                                          .updateDropdownValues(
                                        status: int.tryParse(
                                          selectedLabel.value,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Created By
                              CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.entrySecurity ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                isMandatory: true,
                                '${state.model.createdBy?.firstName ?? ''} ${state.model.createdBy?.lastName ?? ''}',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Date of creation
                              CommonWidgets.textDisplay(
                                state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              BaseDate().creationDateDisplay(
                                state.model.inputDate ?? '',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Location
                              CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              BaseLocationDropdown().locationWidgetDisplay(
                                selectedLocationName:
                                state.model.location?.name ?? '',
                                isEnabled: !isReadOnly,
                                context: context,
                                locations: state.locations,
                                onTap: (Organisation? location) async {
                                  log('location?.name-----${location?.name}');

                                  state.model.location = location;

                                  BlocProvider.of<TicketingSystemDetailsCubit>(
                                    context,
                                  ).updateLocationDropdownValue(
                                    location: location,
                                  );
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Ticket No.
                              CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.slNo ??
                                //     state.labels?.defaultLocale.slNo ??
                                   'Ticket No',
                                isMandatory: true,
                                state.model.ticketNo ?? '',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Ticket Type
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                    Constants.ticketType,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              BaseDropDown().getDropDown(
                                isDisabled: false,
                                textController: ticketTypeController,
                                items: ticketTypeDropDownValues,
                                initialValue: '${state.model.ticketType ??= 0}',
                                onTap: () {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues:
                                    ticketTypeDropDownValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          ticketTypeDropDownValues
                                              .firstWhere(
                                                (label) => label.key == value,
                                            orElse: () =>
                                            const Label(
                                              key: '',
                                              value: '',
                                            ),
                                          );

                                      BlocProvider.of<
                                          TicketingSystemDetailsCubit>(
                                          context)
                                          .updateDropdownValues(
                                        ticketType: int.tryParse(
                                          selectedLabel.value,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Start Date
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.inputDate ??
                                //     state.labels?.defaultLocale.inputDate ??
                                    Constants.startDate,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              BaseDate().creationDateDisplay(
                                state.model.fromDate ?? '',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// To date
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.startTime ??
                                //     state.labels?.defaultLocale.startTime ??
                                    Constants.toDate,
                                isMandatory: true,
                                Styles.textStyleWhite16,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDate().datePickerWidgetLoading(
                                textController: toDateController,
                                isDisabled: isReadOnly,
                                onlyDate: false,
                                showPastDate: false,
                                showFutureDate: true,
                                onChange: (String value) {
                                  toDateController.text = value;
                                  state.model.toDate =
                                      Utils().formatTime(value);
                                  BlocProvider.of<TicketingSystemDetailsCubit>(
                                      context)
                                      .onModelValueChange(state.model);
                                },
                                context: context,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Priority Type
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                Constants.priorityType,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              BaseDropDown().getDropDown(
                                isDisabled: false,
                                textController: priorityTypController,
                                items: priorityTypeDropDownValues,
                                initialValue: '${state.model.priorityType ??= 0}',
                                onTap: () {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues:
                                    priorityTypeDropDownValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          priorityTypeDropDownValues
                                              .firstWhere(
                                                (label) => label.key == value,
                                            orElse: () =>
                                            const Label(
                                              key: '',
                                              value: '',
                                            ),
                                          );

                                      BlocProvider.of<
                                          TicketingSystemDetailsCubit>(
                                          context)
                                          .updateDropdownValues(
                                        priorityType: int.tryParse(
                                          selectedLabel.value,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Assignee To
                              CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.entrySecurity ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                Constants.assignee,
                                isMandatory: true,
                                '${state.model.assignee}',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Affected Modules
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.entity ??
                                  //     state.labels?.defaultLocale.entity ??
                                      Constants.affectedModules,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.001),
                              BaseEntitiesSelection().entityDropDownSelection(
                                context: context,
                                selectedValues: state.model.modulesName ?? [],
                                all: state.listOfModules ?? [],
                                enabled: true,
                                onTap: (List<Organisation> selectedModulesName) {
                                  BlocProvider.of<TicketingSystemDetailsCubit>(context)
                                      .updateDropdownValues(
                                      modulesName: selectedModulesName);
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                orgName: 'ATOM_MODULES_NAME_LIST',
                                functionToCall: () {
                                  // refresh the list
                                  BlocProvider.of<TicketingSystemDetailsCubit>(context)
                                      .refreshList();
                                },
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Ticket Raised For
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                Constants.ticketRaisedFor,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              BaseDropDown().getDropDown(
                                isDisabled: false,
                                textController: ticketRaisedForController,
                                items: ticketRaisedForDropDownValues,
                                initialValue: '${state.model.issuedForm ??= 0}',
                                onTap: () {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues:
                                    ticketRaisedForDropDownValues
                                        .map((label) => label.key)
                                        .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          ticketRaisedForDropDownValues
                                              .firstWhere(
                                                (label) => label.key == value,
                                            orElse: () =>
                                            const Label(
                                              key: '',
                                              value: '',
                                            ),
                                          );

                                      BlocProvider.of<
                                          TicketingSystemDetailsCubit>(
                                          context)
                                          .updateDropdownValues(
                                        ticketRaisedFor: int.tryParse(
                                          selectedLabel.value,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Rag Status
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                Constants.ragStatus,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              BaseDropDown().getDropDown(
                                isDisabled: true,
                                textController: ragStatusController,
                                items: ragStatusDropDownValues,
                                initialValue: '${state.model.ragStatus ??= 0}',
                                onTap: () {
                                },
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Subject
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.detailDes ??
                                  //     state.labels?.defaultLocale.detailDes ??
                                  Constants.subject,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                characterLimit:
                                    Constants.characterLimitDescTextFormField,
                                initialValue: state.model.title,
                                showBorder: true,
                                textFormKey: Keys.incidentDescription,
                                hintText: Constants.informationhere,
                                isEnable: showSaveSubmitButton,
                                isDisableColor: !showSaveSubmitButton,
                                onChange: (String value) {
                                  state.model.title = value;
                                  context
                                      .read<TicketingSystemDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Issue Description
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.detailDes ??
                                //     state.labels?.defaultLocale.detailDes ??
                                  Constants.issueDes,
                                  isMandatory: true,
                                  Styles.textStyleWhite16),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                characterLimit:
                                Constants.characterLimitDescTextFormField,
                                initialValue: state.model.bugDescription,
                                showBorder: true,
                                textFormKey: Keys.incidentDescription,
                                hintText: Constants.informationhere,
                                isEnable: showSaveSubmitButton,
                                isDisableColor: !showSaveSubmitButton,
                                onChange: (String value) {
                                  state.model.bugDescription = value;
                                  context
                                      .read<TicketingSystemDetailsCubit>()
                                      .onModelValueChange(state.model);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (state.model.id != null) ...[

                                Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3F5167),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Activity Notes',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          final updatedNotes = List<ActivityNote>.from(
                                            state.model.activityNotes ?? [],
                                          )..add(
                                            ActivityNote(
                                              activityNotes: '',
                                              submittedDate:
                                              DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
                                              submitted: false,
                                            ),
                                          );

                                          context.read<TicketingSystemDetailsCubit>().updateActivityNotes(
                                            updatedNotes,
                                          );
                                        },
                                        child: const Icon(Icons.add,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 12),

                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                  state.model.activityNotes?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final note =
                                    state.model.activityNotes![index];
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.05),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.white24),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            /// 🔹 Top row: Title + Close icon
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                const Text(
                                                  'Activity Note',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    final updatedNotes = List<ActivityNote>.from(
                                                      state.model.activityNotes ?? [],
                                                    )..removeAt(index);

                                                    context.read<TicketingSystemDetailsCubit>().updateActivityNotes(
                                                      updatedNotes,
                                                    );
                                                  },

                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 8),

                                            /// 🔹 Activity text
                                            FlutterInputField(
                                              lineHeight: 5,
                                              initialValue: note.activityNotes,
                                              showBorder: true,
                                              isEnable: true,
                                              hintText: Constants.informationhere,
                                              // onChange: (value) {
                                              //   note.activityNotes = value;
                                              //   context
                                              //       .read<TicketingSystemDetailsCubit>()
                                              //       .updateActivityNotes(state.model);
                                              // },

                                              onChange: (String value) {
                                                note.activityNotes = value; // ✅ STRING
                                                context
                                                    .read<TicketingSystemDetailsCubit>()
                                                    .onModelValueChange(state.model);
                                              },
                                              // onChange: (String value) {
                                              //   final updatedNotes = List<ActivityNote>.from(
                                              //     state.model.activityNotes ?? [],
                                              //   );
                                              //
                                              //   updatedNotes[index] = ActivityNote(
                                              //     id: note.id,
                                              //     activityNotes: note.activityNotes,
                                              //     submittedDate: value,
                                              //     submitted: note.submitted,
                                              //   );
                                              //
                                              //   context.read<TicketingSystemDetailsCubit>()
                                              //       .updateActivityNotes(updatedNotes);
                                              // },
                                              textFormKey: '',
                                            ),

                                            const SizedBox(height: 10),

                                            /// 🔹 Date BELOW the activity text
                                            BaseDate().datePickerWidgetLoading(
                                              textController: TextEditingController(
                                                text: note.submittedDate,
                                              ),
                                              isDisabled: false,
                                              onlyDate: false,
                                              showPastDate: false,
                                              showFutureDate: true,
                                              onChange: (String value) {
                                                note.submittedDate = value; // ✅ STRING
                                                context
                                                    .read<TicketingSystemDetailsCubit>()
                                                    .onModelValueChange(state.model);
                                              },
                                              // onChange: (value) {
                                              //   final updatedNotes = List<ActivityNote>.from(
                                              //     state.model.activityNotes ?? [],
                                              //   );
                                              //
                                              //   updatedNotes[index] = ActivityNote(
                                              //     id: note.id,
                                              //     activityNotes: value,
                                              //     submittedDate: note.submittedDate,
                                              //     submitted: note.submitted,
                                              //   );
                                              //
                                              //   context.read<TicketingSystemDetailsCubit>()
                                              //       .updateActivityNotes(updatedNotes);
                                              // },
                                              context: context,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],

                              if(state.model.id != null)...[
                              /// Modified By
                              CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.entrySecurity ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                Constants.modifiedBy,
                                isMandatory: true,
                                '${state.model.modifiedBy}',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Modified Date
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.modifiedDate ??
                                //     state.labels?.defaultLocale.modifiedDate ??
                                    Constants.modifiedDate,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                height * 0.01,
                              ),
                              BaseDate().creationDateDisplay(
                                state.model.modifiedDate ?? '',
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
],
                              /// upload
                              CommonWidgets.textDisplay(Constants.uploadPhoto,
                                  Styles.textStyleWhite16),
                              BaseImageUpload().uploadWidget(
                                context: context,
                                isDisabled: !showSaveSubmitButton,
                                loggedInUserDetails:
                                    state.loggedInUserDetails ?? User(),
                                getFiles: uploadFiles,
                                onImageSelected: (ImageContent data) {
                                  List<ImageContent>? files = [];
                                  files.add(data);
                                  for (ImageContent image in uploadFiles) {
                                    files.add(image);
                                  }
                                  BlocProvider.of<TicketingSystemDetailsCubit>(
                                          context)
                                      .addAttachment(
                                    data: files,
                                    images: files,
                                  );
                                },
                              ),


                              /// Attachments
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: BaseImageUpload().getAttachment(
                                  height: height,
                                  attachments: state.model.attachments,
                                  files: uploadFiles,
                                  moduleCode: '',
                                  // isDisabled: disableForm,
                                ),
                              ),

                              CommonWidgets.verticalSpacerWidget(height * 0.01),


                            ],
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.02),

                        /// SubmitButton
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if ((state.model.status != 9) ? true : false) ...[
                              cancelButtonDisplay(),
                              submitButtonDisplay()
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if ((state.model.status == 9)) ...[
                Container(
                  padding: const EdgeInsets.all(5.0),
                  color:Colors.transparent,
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

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.save,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<TicketingSystemDetailsCubit>(context).submitForm();
      },
    );
  }

}
