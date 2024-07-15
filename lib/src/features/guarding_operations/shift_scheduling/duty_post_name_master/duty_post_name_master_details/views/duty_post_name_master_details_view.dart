import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/duty_post_name_master_details/views/add_duty_post_location_name_pop_up.dart';

class DutyPostNameMasterDetailsView extends StatefulWidget {
  final DutyPostNameMasterModel? model;
  final String title;
  final ExtraProperties? extraProperties;

  const DutyPostNameMasterDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<DutyPostNameMasterDetailsView> createState() =>
      _DutyPostNameMasterDetailsViewState();
}

class _DutyPostNameMasterDetailsViewState
    extends State<DutyPostNameMasterDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController genderController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController rankController = TextEditingController();

  bool isDisabled = true;
  bool isReadOnly = false;
  bool showSaveSubmitButtons = false;

  get model => null;

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DutyPostNameMasterDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<DutyPostNameMasterDetailsCubit,
        DutyPostNameMasterDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Duty Post Name Master',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                dutyPostNameMasterListRoute,
                arguments: {},
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
      },
      builder: (context, state) {
        if (state.model.status == 0 && !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == 1 && !state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == null) {
          isReadOnly = false;
        }
        if (widget.extraProperties != null &&
            !widget.extraProperties!.hasWritePermission!) {
          isReadOnly = true;
        }
        showSaveSubmitButtons = (state.model.status == 0 ||
                state.model.status == 1 ||
                state.model.status == null ||
                isReadOnly == false) &&
            state.model.lock.isEmptyOrNull;
        initializeDates();
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSubmitButton: showSaveSubmitButtons,
            showSaveButton: showSaveSubmitButtons,
            showDisLikeButton: false,
            showLikeButton: false,
            pdfAPIName: '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.dutyPostNameMasterModuleCode}',
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<DutyPostNameMasterDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<DutyPostNameMasterDetailsCubit>(context)
                  .submitForm(isSaveOnly: false);
            },
          ),
          backgroundColor: AppColors.backgroundWhiteColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {}

  getBodybuilder(DutyPostNameMasterDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
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
                autovalidateMode: state.model.status == 4
                    ? AutovalidateMode.disabled
                    : AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AbsorbPointer(
                      absorbing: isReadOnly || !state.model.lock.isEmptyOrNull,
                      child: Padding(
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

                            /// Status
                            CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                              isDisabled: true,
                              textController: statusController,
                              items: dutyPostNameMasterStatusValues,
                              initialValue: '${state.model.status ?? 0}',
                              onTap: () {
                                if (!isDisabled) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues:
                                        dutyPostNameMasterStatusValues
                                            .map((label) => label.key)
                                            .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          dutyPostNameMasterStatusValues
                                              .firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      BlocProvider.of<
                                                  DutyPostNameMasterDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                              status: int.tryParse(
                                                  selectedLabel.value));
                                    },
                                  );
                                }
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

                            /// Date of creation
                            CommonWidgets.textDisplay(
                                state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.date,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDate().creationDateDisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Location
                            CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseLocationDropdown().locationWidgetDisplay(
                                context: context,
                                locations: state.locations ?? Locations(),
                                selectedLocationName:
                                    state.model.location?.name ?? '',
                                onTap: (Organisation? location) {
                                  BlocProvider.of<
                                              DutyPostNameMasterDetailsCubit>(
                                          context)
                                      .updateDropdownValues(location: location);
                                }),
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

                            /// DutyPost Location Name
                            CommonWidgets.textDisplay(
                              state.labels?.locale.postName ??
                                  state.labels?.defaultLocale.postName ??
                                  Constants.dutyPostLocationName,
                              Styles.textStyleBlack14,
                              //isMandatory: true
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            GestureDetector(
                              onTap: () {
                                log('--onTap------');

                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return AddDutyPostLocationNamePopUp(
                                      model: model,
                                      mainContext: context,
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(width: 14),
                                  SvgPicture.asset(
                                    AppIcon.pluscircle,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.navigationSkyBlueColor,
                                      BlendMode.srcIn,
                                    ),
                                    // color: AppColors.navigationSkyBlueColor,
                                  ),
                                  // ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    Constants.addDutyPostLocationName,
                                    style: TextStyle(
                                      color: AppColors.navigationSkyBlueColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: getDutyPostLocationName(
                                  state.model.dpName ?? [], height, state),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.03),
                            if (widget.model?.id != null) ...[
                              /// Modified Date
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.date ??
                                //     state.labels?.defaultLocale.date ??
                                Constants.modifiedOn,
                                Styles.textStyleBlack14,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseDate().creationDateDisplay(
                                  state.model.modifiedDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Modified By
                              CommonWidgets.horizentaltextHandling(
                                  // state.labels?.locale.entrySecurity ??
                                  //     state.labels?.defaultLocale.entrySecurity ??
                                  Constants.modifiedBy,
                                  isMandatory: true,
                                  '${state.model.modifiedBy}'),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            if(state.model.lock.isEmptyOrNull)...[
                            /// SubmitButton
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                cancelButtonDisplay(state),
                                if (showSaveSubmitButtons) ...[
                                  submitButtonDisplay()
                                ],
                              ],
                            )
                            ],

                            CommonWidgets.verticalSpacerWidget(height * 0.04),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getDutyPostLocationName(
      List<DpName> list, double height, DutyPostNameMasterDetailsState state) {
    log('-list--${list.length}--');
    List<Widget> widgets = [];
    for (DpName dutyPostLocationName in list) {
      TextEditingController dutyPostLocationNameController =
          TextEditingController();
      dutyPostLocationNameController.text =
          dutyPostLocationName.dutyPostName ?? '';
      bool isTransportShift =
          dutyPostLocationName.transportShift ?? false; // Add this line
      widgets.add(Row(
        children: [
          Text(
            dutyPostLocationName.dutyPostName ?? '',
            textAlign: TextAlign.start,
          ),
          Checkbox(
            // Add this Checkbox widget
            value: isTransportShift,
            activeColor: AppColors.navigationSkyBlueColor,
            focusColor: AppColors.navigationSkyBlueColor,
            onChanged: (value) {
              // Implement logic to update the transport shift value
              setState(() {
                dutyPostLocationName.transportShift = value;
              });
            },
          ),
          GestureDetector(
            onTap: () {
              // Implement the logic to delete the corresponding record
              // For example, you can show a confirmation dialog and delete the record if confirmed
              deleteDutyPostLocationName(dutyPostLocationName, state);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: BaseIcons().closeIcon(),
            ), //
          ),
        ],
      ));
      widgets.add(const SizedBox(height: 2));
      widgets.add(CommonWidgets.verticalSpacerWidget(height * 0.01));
    }
    if (widgets.isNotEmpty) {
      return [
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightGreyBackground,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets,
            ),
          ),
        ),
      ];
    } else {
      return []; // Or provide a default list based on your requirements
    }
  }

  void deleteDutyPostLocationName(
      DpName locationName, DutyPostNameMasterDetailsState state) {
    setState(() {
      // Assuming your state has a list of duty post location names
      // Update the state to remove the specified location name
      state.model.dpName?.remove(locationName);
    });
  }

  Widget cancelButtonDisplay(DutyPostNameMasterDetailsState state) {
    return AppButton(
      width: Constants.cancelButtonWidth,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: state.model.id == null || !state.model.lock.isEmptyOrNull
          ? Constants.close
          : Constants.cancelRecord,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        if (state.model.id == null) {
          Navigator.pop(context);
          return;
        }
        var dialog = CustomAlertDialog(
            title: Constants.cancelRecord,
            message: Constants.cancelRecordWarningMessage,
            onPositivePressed: () {
              // Navigator.pop(context);
              Navigator.pop(context);
              updateRecordStatus(state);
            },
            positiveBtnText: Constants.yes,
            negativeBtnText: Constants.no);
        showDialog(context: context, builder: (BuildContext context) => dialog);
      },
    );
  }

  void updateRecordStatus(DutyPostNameMasterDetailsState state) {
    log('-updateRecordStatus-${widget.model?.status}--');
    if (state.model.id != null && widget.model?.status != 1) {
      BlocProvider.of<DutyPostNameMasterDetailsCubit>(context)
          .updateStatus(id: state.model.id.toString());
      Navigator.popAndPushNamed(context, dutyPostNameMasterListRoute);
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
        BlocProvider.of<DutyPostNameMasterDetailsCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }
}
