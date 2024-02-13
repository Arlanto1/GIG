import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/duty_post_name_master_details/views/add_duty_post_location_name_pop_up.dart';

class DutyPostNameMasterDetailsView extends StatefulWidget {
  final DutyPostNameMasterModel? model;
  final String title;

  const DutyPostNameMasterDetailsView({
    super.key,
    this.model,
    required this.title,
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

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Duty Post Master',
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

        initializeDates();
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSubmitButton: state.model.status != 5 ? true : false,
            showSaveButton: state.model.status != 5 ? true : false,
            showDisLikeButton: false,
            showLikeButton: false,
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
          backgroundColor: AppColors.backgroundWhitecolor,
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
                              if (widget.model != null) {
                                BaseDropDown().assetTypeDialog(
                                  context: context,
                                  dropDownValues: dutyPostNameMasterStatusValues
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
                              '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Date of creation
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.inputDate ??
                              //     state.labels?.defaultLocale.inputDate ??
                                  Constants.date,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDate()
                              .creationDateDisplay(state.model.inputDate ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Location
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.location ??
                              //  state.labels?.defaultLocale.location ??
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
                                BlocProvider.of<DutyPostNameMasterDetailsCubit>(
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
                              //  state.labels?.locale.poc ??
                              //    state.labels?.defaultLocale.poc ??
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
                                ),
                                // ),
                                const SizedBox(width: 10),
                                const Text(
                                  Constants.addDutyPostLocationName,
                                  style: TextStyle(
                                    color: AppColors.navigationSkybluecolor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: getDutyPostLocationName(
                                state.model.locationNames ?? [], height, state),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          /// SubmitButton
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cancelButtonDisplay(state),
                              submitButtonDisplay()
                            ],
                          ),

                          CommonWidgets.verticalSpacerWidget(height * 0.04),
                        ],
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
      List<String> list, double height, DutyPostNameMasterDetailsState state) {
    List<Widget> widgets = [];
    for (String dutyPostLocationName in list) {
      TextEditingController dutyPostLocationNameController =
          TextEditingController();
      dutyPostLocationNameController.text = dutyPostLocationName;
      widgets.add(Row(
        children: [
          Text(
            dutyPostLocationName,
            textAlign: TextAlign.start,
          ),
          GestureDetector(
            onTap: () {
              // Implement the logic to delete the corresponding record
              // For example, you can show a confirmation dialog and delete the record if confirmed
              deleteDutyPostLocationName(dutyPostLocationName, state);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(
                AppIcon.closeicon,
                color: AppColors.black,
              ),
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
            color: AppColors.lightgreyBackground,
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
      String locationName, DutyPostNameMasterDetailsState state) {
    setState(() {
      // Assuming your state has a list of duty post location names
      // Update the state to remove the specified location name
      state.model.locationNames?.remove(locationName);
    });
  }

  Widget cancelButtonDisplay(DutyPostNameMasterDetailsState state) {
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

  void updateRecordStatus(DutyPostNameMasterDetailsState state) {
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
