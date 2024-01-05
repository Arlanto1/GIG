import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_management_master/key_management_master_details/cubits/key_management_master_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/duty_post_master_details/cubits/duty_post_master_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/models/duty_post_master_model.dart';

class DutyPostMasterDetailsView extends StatefulWidget {
  final DutyPostMasterModel? model;
  final String title;

  const DutyPostMasterDetailsView({
    super.key,
    this.model,
    required this.title,
  });

  @override
  State<DutyPostMasterDetailsView> createState() =>
      _DutyPostMasterDetailsViewState();
}

class _DutyPostMasterDetailsViewState extends State<DutyPostMasterDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController genderController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController rankController = TextEditingController();

  bool isDisabled = true;
  bool isReadOnly = false;

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DutyPostMasterDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<DutyPostMasterDetailsCubit, DutyPostMasterDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        log('-deploymentOrderSubmitted---${state.model.deploymentOrderSubmitted}----');

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
                dutyPostMasterListRoute,
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
            showSaveButton: state.model.status != 5 ? true : false,
            showSubmitButton: state.model.status != 5 ? true : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<DutyPostMasterDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {}

  getBodybuilder(DutyPostMasterDetailsState state, height) {
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
                            isDisabled: state.model.status != 6,
                            textController: statusController,
                            items: statusDropDownValues,
                            initialValue: '${state.model.status ?? 1}',
                            onTap: () {
                              if (widget.model != null) {
                                BaseDropDown().assetTypeDialog(
                                  context: context,
                                  dropDownValues: statusDropDownValues
                                      .map((label) => label.key)
                                      .toList(),
                                  onTap: (String value) {
                                    Label? selectedLabel;
                                    selectedLabel =
                                        statusDropDownValues.firstWhere(
                                      (label) => label.key == value,
                                      orElse: () =>
                                          const Label(key: '', value: ''),
                                    );
                                    BlocProvider.of<DutyPostMasterDetailsCubit>(
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
                              state.labels?.locale.inputDate ??
                                  state.labels?.defaultLocale.inputDate ??
                                  Constants.dateofcreation,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDate()
                              .creationDateDisplay(state.model.inputDate ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Location
                          CommonWidgets.textDisplay(
                              //state.labels?.locale.location ??
                              //  state.labels?.defaultLocale.location ??
                              Constants.location,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          locationWidgetDisplay(state),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Duty Post Name
                          CommonWidgets.textDisplay(
                              // state.labels?.locale.guardRank ??
                              //    state.labels?.defaultLocale.guardRank ??
                              Constants.dutyPostName,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDropDown().getDropDown(
                              isDisabled: state.model.status != 6,
                              textController: rankController,
                              items: guardRankDropDownValues,
                              initialValue: state.model.guardRank.toString(),
                              onTap: () {
                                if (isDisabled) {
                                  BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: guardRankDropDownValues
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            guardRankDropDownValues.firstWhere(
                                          (label) => label.key == value,
                                          orElse: () =>
                                              const Label(key: '', value: ''),
                                        );
                                        BlocProvider.of<
                                                    DutyPostMasterDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                guardRank: int.tryParse(
                                                    selectedLabel.value));
                                      });
                                }
                              }),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Rank
                          CommonWidgets.textDisplay(
                              state.labels?.locale.guardRank ??
                                  state.labels?.defaultLocale.guardRank ??
                                  Constants.rank,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          BaseDropDown().getDropDown(
                              isDisabled: state.model.status != 6,
                              textController: rankController,
                              items: guardRankDropDownValues,
                              initialValue: state.model.guardRank.toString(),
                              onTap: () {
                                if (isDisabled) {
                                  BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: guardRankDropDownValues
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            guardRankDropDownValues.firstWhere(
                                          (label) => label.key == value,
                                          orElse: () =>
                                              const Label(key: '', value: ''),
                                        );
                                        BlocProvider.of<
                                                    DutyPostMasterDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                guardRank: int.tryParse(
                                                    selectedLabel.value));
                                      });
                                }
                              }),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// A Shift(7AM-3PM)
                          CommonWidgets.textDisplay(
                              //  state.labels?.locale.guardingPOC ??
                              // state.labels?.defaultLocale.guardingPOC ??
                              Constants.aShift,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.guardingPOC,
                            textFormKey: Keys.guardingPOCKey,
                            hintText: '',
                            isEnable: true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.guardingPOC = value;
                              context
                                  .read<DutyPostMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// B Shift(3PM-11PM)
                          CommonWidgets.textDisplay(
                              //  state.labels?.locale.guardingPOC ??
                              // state.labels?.defaultLocale.guardingPOC ??
                              Constants.bShift,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.guardingPOC,
                            textFormKey: Keys.guardingPOCKey,
                            hintText: '',
                            isEnable: true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.guardingPOC = value;
                              context
                                  .read<DutyPostMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// C Shift(11PM-7AM)
                          CommonWidgets.textDisplay(
                              //  state.labels?.locale.guardingPOC ??
                              // state.labels?.defaultLocale.guardingPOC ??
                              Constants.cShift,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.guardingPOC,
                            textFormKey: Keys.guardingPOCKey,
                            hintText: '',
                            isEnable: true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.guardingPOC = value;
                              context
                                  .read<DutyPostMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// G Shift(9AM-6PM)
                          CommonWidgets.textDisplay(
                              //  state.labels?.locale.guardingPOC ??
                              // state.labels?.defaultLocale.guardingPOC ??
                              Constants.gShift,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.guardingPOC,
                            textFormKey: Keys.guardingPOCKey,
                            hintText: '',
                            isEnable: true,
                            isDisableColor: false,
                            onChange: (String value) {
                              state.model.guardingPOC = value;
                              context
                                  .read<DutyPostMasterDetailsCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///  Total
                          CommonWidgets.textDisplay(
                              //  state.labels?.locale.guardingPOC ??
                              // state.labels?.defaultLocale.guardingPOC ??
                              Constants.total,
                              isMandatory: true,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.guardingPOC,
                            textFormKey: Keys.guardingPOCKey,
                            hintText: '',
                            isEnable: false,
                            isDisableColor: true,
                            onChange: (String value) {
                              // state.model.guardingPOC = value;
                              // context
                              //     .read<DutyPostMasterDetailsCubit>()
                              //     .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          CommonWidgets.verticalSpacerWidget(height * 0.02),

                          /// SubmitButton
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cancelButtonDisplay(),
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

  String getStatusString(int status) {
    switch (status) {
      case 1:
        return 'Active';
      case 2:
        return 'InActive';
      case 3:
        return 'Leave';
      case 4:
        return 'Week Off ';
      default:
        return 'Unknown Status';
    }
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      // Customize the button properties as needed
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<DutyPostMasterDetailsCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }

  Widget locationWidgetDisplay(DutyPostMasterDetailsState state) {
    return GestureDetector(
      onTap: () {
        // if (widget.occurrence == null ||
        //     (state.occurrence.location?.name ?? '').isEmpty)
        //     {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            // print(state.getLocationsResponse);
            return CustomExpansionListTexts(
              locationList: state.locations,
              onTap: (Organisation? list) async {
                log('list?.name-----${list?.name}');

                Organisation location = Organisation();
                location.id = list?.id;
                location.name = list?.name;
                state.model.location = location;

                BlocProvider.of<DutyPostMasterDetailsCubit>(context)
                    .updateDropdownValues(location: location);
              },
            );
          },
        );
        // }
      },
      child: SelectedTileValueWidget(name: state.model.location?.name ?? ''),
    );
  }
}
