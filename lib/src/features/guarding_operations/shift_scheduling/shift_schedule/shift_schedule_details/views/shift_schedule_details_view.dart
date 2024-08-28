import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/add_poc_pop_up.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/cubits/duty_post_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/shift_schedule/shift_schedule_details/views/duty_post_details/duty_post_details_newwwww.dart';

class ShiftScheduleDetailsView extends StatefulWidget {
  final ExtraProperties? extraProperties;

  const ShiftScheduleDetailsView({
    super.key,
    this.extraProperties,
  });

  @override
  State<ShiftScheduleDetailsView> createState() =>
      _ShiftScheduleDetailsViewState();
}

class _ShiftScheduleDetailsViewState extends State<ShiftScheduleDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController rankController = TextEditingController();

  // bool isDisabled = true;
  bool isReadOnly = false;

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShiftScheduleDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<ShiftScheduleDetailsCubit, ShiftScheduleDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Message',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                shiftScheduleListRoute,
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
        if (state.status == FormStatus.navigateToNextScreen) {
          log('---state.model.fromDate--${state.model.fromDate}--');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<DutyPostDetailsCubit>(
                create: (_) => DutyPostDetailsCubit(
                  parentModel: state.selectedDutyPostModel ?? DutyPostModel(),
                  id: state.model.id.toString(),
                  shiftScheduleId: state.model.id!,
                ),
                child: DutyPostDetailsNewwwww(
                  model: state.selectedDutyPostModel ?? DutyPostModel(),
                  shiftScheduleId: state.model.id!,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        log('(state.model.status != -1 || !isReadOnly $isReadOnly');
        if (state.model.status == ConstantsIntValue.cancelledStatus) {
          isReadOnly = true;
        }
        if (!state.model.lock.isEmptyOrNull) {
          isReadOnly = true;
        }
        if (state.model.status == null) {
          isReadOnly = false;
        }
        if (!state.model.isEligibleToEdit) {
          isReadOnly = true;
        }

        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isReadOnly = true;
        // }
        initializeDates(state);
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: Constants.shiftSchedule,
              // title: widget.title,
              showPopUp: false,
              showSaveButton: !isReadOnly,
              showSubmitButton: !isReadOnly,
              showDisLikeButton: false,
              showLikeButton: false,
              pdfAPIName:
                  '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.shiftScheduleModuleCode}',
              onTapSave: () {
                FocusScope.of(context).unfocus();
                BlocProvider.of<ShiftScheduleDetailsCubit>(context)
                    .submitForm(isSaveOnly: true);
              },
              onTapSubmit: () {
                FocusScope.of(context).unfocus();
                BlocProvider.of<ShiftScheduleDetailsCubit>(context)
                    .submitForm(isSaveOnly: false);
              }),
          backgroundColor: AppColors.backgroundWhiteColor,
          body: getBodybuilder(state, height),
        );
      },
    );
  }

  void initializeDates(ShiftScheduleDetailsState state) {
    if (state.model.fromDate != null) {
      fromDateController.text = Utils.timestampToDateConversion(
          int.parse(state.model.fromDate ?? '0'), Constants.dateFormat);
    }

    if (state.model.toDate != null) {
      toDateController.text = Utils.timestampToDateConversion(
          int.parse(state.model.toDate ?? '0'), Constants.dateFormat);
    }
  }

  getBodybuilder(ShiftScheduleDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    log('-isReadOnly-----${!isReadOnly}- ${state.model.lock.isEmptyOrNull}---');
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
                      absorbing: isReadOnly,
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
                            BaseDropDown().getDropDown(
                              isDisabled: true,
                              textController: statusController,
                              items: shiftScheduleStatusDropDownValues,
                              initialValue: '${state.model.status ?? 0}',
                              onTap: () {
                                if (!isReadOnly) {
                                  BaseDropDown().assetTypeDialog(
                                    context: context,
                                    dropDownValues:
                                        shiftScheduleStatusDropDownValues
                                            .map((label) => label.key)
                                            .toList(),
                                    onTap: (String value) {
                                      Label? selectedLabel;
                                      selectedLabel =
                                          shiftScheduleStatusDropDownValues
                                              .firstWhere(
                                        (label) => label.key == value,
                                        orElse: () =>
                                            const Label(key: '', value: ''),
                                      );
                                      BlocProvider.of<
                                                  ShiftScheduleDetailsCubit>(
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
                                state.labels?.locale.createdBy ??
                                    state.labels?.defaultLocale.createdBy ??
                                    Constants.createdby,
                                isMandatory: true,
                                '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                                state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDate().creationDateDisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location
                            CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            AbsorbPointer(
                                absorbing: state.model.status == null ||
                                        state.model.status ==
                                            ConstantsIntValue.shiftScheduleDraft
                                    ? false
                                    : true,
                                child: BaseLocationDropdown()
                                    .locationWidgetDisplay(
                                        context: context,
                                        locations:
                                            state.locations ?? Locations(),
                                        selectedLocationName:
                                            state.model.location?.name ?? '',
                                        onTap: (Organisation? location) {
                                          BlocProvider.of<
                                                      ShiftScheduleDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  location: location);
                                        })),
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

                            /// Vendor
                            CommonWidgets.textDisplay(
                              state.labels?.locale.vendor ??
                                  state.labels?.defaultLocale.vendor ??
                                  Constants.vendor,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            TextFieldAddButton(
                              title: state.model.vendor?.name,
                              height: 60,
                              isDisableColor: isReadOnly,
                              onTap: () {
                                if (!isReadOnly) {
                                  BaseOrganisationDialog().departmentDialog(
                                      context: context,
                                      organisations: state.vendors,
                                      onTap: (Organisation department) {
                                        BlocProvider.of<
                                                    ShiftScheduleDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                vendor: department);
                                      },
                                      orgName: 'ATOM_VENDORS',
                                      createEntity: false,
                                      title: 'Add Vendors',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                                    ShiftScheduleDetailsCubit>(
                                                context)
                                            .refreshList();
                                      });
                                }
                              },
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Duty Type
                            CommonWidgets.textDisplay(
                                state.labels?.locale.dutyType ??
                                    state.labels?.defaultLocale.dutyType ??
                                    Constants.dutyType,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: isReadOnly,
                                textController: rankController,
                                items: shiftDutyTypeDropDownValues,
                                initialValue: state.model.dutyType.toString(),
                                onTap: () {
                                  if (!isReadOnly) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues:
                                            shiftDutyTypeDropDownValues
                                                .map((label) => label.key)
                                                .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              shiftDutyTypeDropDownValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      ShiftScheduleDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  dutyType: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// POC
                            CommonWidgets.textDisplay(
                                // state.labels?.locale.poc ??
                                //     state.labels?.defaultLocale.poc ??
                                Constants.poc,
                                Styles.textStyleBlack14,
                                isMandatory: true),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            if (!isReadOnly) ...[
                              GestureDetector(
                                onTap: () {
                                  log('--onTap------');
                                  if (!isReadOnly) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) {
                                        return AddPOCPopUp(
                                          model: model,
                                          mainContext: context,
                                        );
                                      },
                                    );
                                  }
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
                                      Constants.addPOC,
                                      style: TextStyle(
                                        color: AppColors.navigationSkyBlueColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            Column(
                              children: getPOCs(state, height),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// From Date
                            CommonWidgets.textDisplay(
                              state.labels?.locale.fromDate ??
                                  state.labels?.defaultLocale.fromDate ??
                                  Constants.fromDate,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: fromDateController,
                              onlyDate: true,
                              showPastDate: false,
                              startDate: state.availableDate?.fromDate,
                              isDisabled: isReadOnly,
                              onChange: (String value) {
                                state.model.fromDate =
                                    Utils().formatTime(value);
                                BlocProvider.of<ShiftScheduleDetailsCubit>(
                                        context)
                                    .onCheckBoxChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// To Date
                            CommonWidgets.textDisplay(
                              state.labels?.locale.toDate ??
                                  state.labels?.defaultLocale.toDate ??
                                  Constants.toDate,
                              isMandatory: true,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: toDateController,
                              onlyDate: true,
                              showPastDate: false,
                              startDate: state.model.fromDate,
                              isDisabled: isReadOnly,
                              onChange: (String value) {
                                state.model.toDate = Utils().formatTime(value);
                                BlocProvider.of<ShiftScheduleDetailsCubit>(
                                        context)
                                    .onCheckBoxChange(state.model);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            if (state.model.id != null) ...[
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
                                  state.model.modifiedBy ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],
                          ],
                        ),
                      ),
                    ),

                    /// List of Duty Posts
                    if (!state.model.fromDate.isEmptyOrNull &&
                        !state.model.toDate.isEmptyOrNull) ...[
                      DutyPostListWidget(
                          dutyPosts: state.dutyPosts ?? [],
                          onTap: (int? id, int? dustyPostNameId,
                              DutyPostModel? dutyPostModel) {
                            log('--id---$id-dustyPostNameId--$dustyPostNameId--state.model.id---${state.model.id}');

                            if (dustyPostNameId != null) {
                              BlocProvider.of<ShiftScheduleDetailsCubit>(
                                      context)
                                  .submitForm(
                                isSaveOnly: true,
                                navigateToNextScreen: true,
                                dutyPostNameId: dustyPostNameId,
                              );
                            }

                            if (id != null) {
                              BlocProvider.of<ShiftScheduleDetailsCubit>(
                                      context)
                                  .getDutyPostById(id);
                            }
                          }),
                    ],
                    CommonWidgets.verticalSpacerWidget(height * 0.02),

                    /// SubmitButton
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cancelButtonDisplay(),
                        if (!isReadOnly) ...[submitButtonDisplay()],
                      ],
                    ),

                    CommonWidgets.verticalSpacerWidget(height * 0.04),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getPOCs(ShiftScheduleDetailsState state, double height) {
    log('-getPOCs-state.pocs--${state.pocs.toString()}--');

    List<Widget> widgets = [];
    for (String poc in state.pocs ?? []) {
      TextEditingController pocController = TextEditingController();
      pocController.text = poc;
      // for (String poc in state.pocs ?? []) {
      //   TextEditingController pocController = TextEditingController();
      //   pocController.text = poc;
      widgets.add(
        Row(
          children: [
            Expanded(
              child: Text(
                poc,
                textAlign: TextAlign.start,
              ),
            ),
            if (state.model.status == null ||
                state.model.status == ConstantsIntValue.shiftScheduleDraft) ...[
              IconButton(
                icon: const Icon(Icons.close), // Cancel icon
                onPressed: () {
                  if (state.model.status == null ||
                      state.model.status ==
                          ConstantsIntValue.shiftScheduleDraft) {
                    // Remove the POC from the state
                    state.pocs?.remove(poc);
                    // Trigger UI update
                    BlocProvider.of<ShiftScheduleDetailsCubit>(context)
                        .onCheckBoxChange(state.model);
                  }
                },
              ),
            ]
          ],
        ),
      );

      widgets.add(const SizedBox(height: 1));
      widgets.add(CommonWidgets.verticalSpacerWidget(height * 0.001));
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

  // Widget cancelButtonDisplay(ShiftScheduleDetailsState state) {
  //   return AppButton(
  //     width: Constants.cancelButtonWidth,
  //     backgroundColor: Colors.white,
  //     key: const Key(Keys.cancelButton),
  //     buttonText: state.model.id == null || !state.model.lock.isEmptyOrNull
  //         ? Constants.close
  //         : Constants.cancelRecord,
  //     buttonTextKey: Keys.cancelButton,
  //     onTap: () {
  //       if (state.model.id == null) {
  //         Navigator.pop(context);
  //         return;
  //       }
  //       var dialog = CustomAlertDialog(
  //           title: Constants.cancelRecord,
  //           message: Constants.cancelRecordWarningMessage,
  //           onPositivePressed: () {
  //             Navigator.pop(context);
  //             Navigator.pop(context);
  //             updateRecordStatus(state);
  //           },
  //           positiveBtnText: Constants.yes,
  //           negativeBtnText: Constants.no);
  //       showDialog(context: context, builder: (BuildContext context) => dialog);
  //     },
  //   );
  // }

  // void updateRecordStatus(ShiftScheduleDetailsState state) {
  //   if (state.model.id != null) {
  //     BlocProvider.of<ShiftScheduleDetailsCubit>(context)
  //         .updateStatus(id: state.model.id.toString());
  //     Navigator.popAndPushNamed(
  //       context,
  //       shiftScheduleListRoute,
  //     );
  //   } else {
  //     Navigator.pop(context);
  //   }
  // }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<ShiftScheduleDetailsCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }
}
