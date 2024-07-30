import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_master/duty_post_master_details/cubits/duty_post_master_details_cubit.dart';

class DutyPostMasterDetailsView extends StatefulWidget {
  final DutyPostMasterModel? model;
  final String title;
  final ExtraProperties? extraProperties;

  const DutyPostMasterDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<DutyPostMasterDetailsView> createState() =>
      _DutyPostMasterDetailsViewState();
}

class _DutyPostMasterDetailsViewState extends State<DutyPostMasterDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController totalController = TextEditingController();
  TextEditingController rankController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  final FocusNode aShiftFocusNode = FocusNode();

  bool isDisabled = true;
  bool isReadOnly = false;

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    totalController.text = (((widget.model?.shiftA ?? 0) +
            (widget.model?.shiftB ?? 0) +
            (widget.model?.shiftC ?? 0) +
            (widget.model?.shiftG ?? 0))
        .toString());
    widget.model?.total = int.tryParse(totalController.text);
    BlocProvider.of<DutyPostMasterDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<DutyPostMasterDetailsCubit, DutyPostMasterDetailsState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
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
      },
      builder: (context, state) {
        // if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        // if (state.model.status == null) {
        //   isReadOnly = false;
        // }
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isReadOnly = true;
        // }
        initializeDates();
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: widget.title,
              showPopUp: false,
              showSaveButton:
                  isReadOnly || !state.model.lock.isEmptyOrNull ? false : true,
              showSubmitButton:
                  isReadOnly || !state.model.lock.isEmptyOrNull ? false : true,
              showDisLikeButton: false,
              showLikeButton: false,
              pdfAPIName: '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.dutyPostMasterModuleCode}',

              onTapSave: () {
                FocusScope.of(context).unfocus();
                BlocProvider.of<DutyPostMasterDetailsCubit>(context)
                    .submitForm(isSaveOnly: true);
              },
              onTapSubmit: () {
                FocusScope.of(context).unfocus();
                BlocProvider.of<DutyPostMasterDetailsCubit>(context)
                    .submitForm(isSaveOnly: false);
              }),
          backgroundColor: AppColors.backgroundWhiteColor,
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
                // autovalidateMode: state.model == 4
                //     ? AutovalidateMode.disabled
                //     : AutovalidateMode.onUserInteraction,
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

                            /// Created By
                            CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.createdBy ??
                                    state.labels?.defaultLocale.createdBy ??
                                    Constants.createdby,
                                isMandatory: true,
                                '${state.model.createdBy?.firstName ?? ''} ${state.model.createdBy?.lastName ?? ''}'),
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
                                state.model.createdDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            // /// Status
                            // CommonWidgets.textDisplay(
                            //     state.labels?.locale.status ??
                            //         state.labels?.defaultLocale.status ??
                            //         Constants.status,
                            //     Styles.textStyleBlack14,
                            //     isMandatory: true),
                            // CommonWidgets.verticalSpacerWidget(height * 0.001),
                            // CommonWidgets.verticalSpacerWidget(height * 0.001),
                            // BaseDropDown().getDropDown(
                            //   isDisabled: true,
                            //   textController: statusController,
                            //   items: dutyPostMasterStatusValues,
                            //   initialValue: '${state.model.status ?? 1}',
                            //   onTap: () {
                            //     if (!isDisabled) {
                            //       BaseDropDown().assetTypeDialog(
                            //         context: context,
                            //         dropDownValues: dutyPostMasterStatusValues
                            //             .map((label) => label.key)
                            //             .toList(),
                            //         onTap: (String value) {
                            //           Label? selectedLabel;
                            //           selectedLabel =
                            //               dutyPostMasterStatusValues.firstWhere(
                            //             (label) => label.key == value,
                            //             orElse: () =>
                            //                 const Label(key: '', value: ''),
                            //           );
                            //           BlocProvider.of<DutyPostMasterDetailsCubit>(
                            //                   context)
                            //               .updateDropdownValues(
                            //                   status: int.tryParse(
                            //                       selectedLabel.value));
                            //         },
                            //       );
                            //     }
                            //   },
                            // ),
                            // CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Location
                            CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseLocationDropdown().locationWidgetDisplay(
                                isEnabled: isReadOnly ||
                                        !state.model.lock.isEmptyOrNull
                                    ? false
                                    : true,
                                context: context,
                                locations: state.locations ?? Locations(),
                                selectedLocationName:
                                    state.model.location?.name ?? '',
                                onTap: (Organisation? location) {
                                  BlocProvider.of<DutyPostMasterDetailsCubit>(
                                          context)
                                      .updateDropdownValues(location: location);
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Duty Post Name
                            CommonWidgets.textDisplay(
                                state.labels?.locale.postName ??
                                    state.labels?.defaultLocale.postName ??
                                    Constants.dutyPostName,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            TextFieldAddButton(
                              title: state.model.dutyPostLocation?.name,
                              height: 70,
                              isDisableColor:
                                  isReadOnly || !state.model.lock.isEmptyOrNull
                                      ? true
                                      : false,
                              onTap: () {
                                if (isReadOnly ||
                                    state.model.lock.isEmptyOrNull) {
                                  BaseOrganisationDialog().departmentDialog(
                                    context: context,
                                    organisations: state.dutyPosts ?? [],
                                    onTap: (Organisation? org) {
                                      // state.model.dutyPostLocation?.name =
                                      //     org.name;

                                      BlocProvider.of<
                                                  DutyPostMasterDetailsCubit>(
                                              context)
                                          .updateDropdownValues(
                                              dutyPostName: org);
                                    },
                                  );
                                }
                              },
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Rank
                            CommonWidgets.textDisplay(
                                state.labels?.locale.rankId ??
                                    state.labels?.defaultLocale.rankId ??
                                    Constants.rank,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled: false,
                                textController: rankController,
                                items: guardRankDropDownValues,
                                initialValue: state.model.rankId.toString(),
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
                                              guardRankDropDownValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      DutyPostMasterDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  rankId: int.tryParse(
                                                      selectedLabel.value));
                                          FocusScope.of(context)
                                              .requestFocus(aShiftFocusNode);
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// A Shift(7AM-3PM)
                            CommonWidgets.textDisplay(
                                state.labels?.locale.shiftA ??
                                    state.labels?.defaultLocale.shiftA ??
                                    Constants.aShift,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.guardingPOCKey,
                              initialValue: '${state.model.shiftA ?? ''}',
                              hintText: '',
                              focusNode: aShiftFocusNode,
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.shiftA = int.tryParse(value);
                                int shiftA = state.model.shiftA ?? 0;
                                int shiftB = state.model.shiftB ?? 0;
                                int shiftC = state.model.shiftC ?? 0;
                                int shiftG = state.model.shiftG ?? 0;
                                totalController.text =
                                    (shiftA + shiftB + shiftC + shiftG)
                                        .toString();
                                state.model.total =
                                    int.tryParse(totalController.text);
                                context
                                    .read<DutyPostMasterDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// B Shift(3PM-11PM)
                            CommonWidgets.textDisplay(
                                state.labels?.locale.shiftB ??
                                    state.labels?.defaultLocale.shiftB ??
                                    Constants.bShift,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.guardingPOCKey,
                              initialValue: '${state.model.shiftB ?? ''}',
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.shiftB = int.tryParse(value);
                                int shiftA = state.model.shiftA ?? 0;
                                int shiftB = state.model.shiftB ?? 0;
                                int shiftC = state.model.shiftC ?? 0;
                                int shiftG = state.model.shiftG ?? 0;
                                totalController.text =
                                    (shiftA + shiftB + shiftC + shiftG)
                                        .toString();
                                state.model.total =
                                    int.tryParse(totalController.text);
                                context
                                    .read<DutyPostMasterDetailsCubit>()
                                    .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// C Shift(11PM-7AM)
                            CommonWidgets.textDisplay(
                                state.labels?.locale.shiftC ??
                                    state.labels?.defaultLocale.shiftC ??
                                    Constants.cShift,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.guardingPOCKey,
                              initialValue: '${state.model.shiftC ?? ''}',
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.shiftC = int.tryParse(value);
                                int shiftA = state.model.shiftA ?? 0;
                                int shiftB = state.model.shiftB ?? 0;
                                int shiftC = state.model.shiftC ?? 0;
                                int shiftG = state.model.shiftG ?? 0;
                                totalController.text =
                                    (shiftA + shiftB + shiftC + shiftG)
                                        .toString();
                                state.model.total =
                                    int.tryParse(totalController.text);
                                // context
                                //     .read<DutyPostMasterDetailsCubit>()
                                //     .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// G Shift(9AM-6PM)
                            CommonWidgets.textDisplay(
                                state.labels?.locale.shiftG ??
                                    state.labels?.defaultLocale.shiftG ??
                                    Constants.gShift,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.guardingPOCKey,
                              initialValue: '${state.model.shiftG ?? ''}',
                              hintText: '',
                              isEnable: true,
                              isDisableColor: false,
                              onChange: (String value) {
                                state.model.shiftG = int.tryParse(value);
                                int shiftA = state.model.shiftA ?? 0;
                                int shiftB = state.model.shiftB ?? 0;
                                int shiftC = state.model.shiftC ?? 0;
                                int shiftG = state.model.shiftG ?? 0;
                                totalController.text =
                                    (shiftA + shiftB + shiftC + shiftG)
                                        .toString();
                                state.model.total =
                                    int.tryParse(totalController.text);
                                // context
                                //     .read<DutyPostMasterDetailsCubit>()
                                //     .onModelValueChange(state.model);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///  Total
                            CommonWidgets.textDisplay(
                                state.labels?.locale.total ??
                                    state.labels?.defaultLocale.total ??
                                    Constants.total,
                                isMandatory: true,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              textInputType: TextInputType.number,
                              textFormKey: Keys.guardingPOCKey,
                              //           initialValue: (((state.model.shiftA ?? 0) +
                              //           (state.model.shiftB ?? 0))
                              // .toString()),
                              controller: totalController,
                              hintText: '',
                              isEnable: false,
                              isDisableColor: true,
                              onChange: (int value) {
                                state.model.total = value;
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            CommonWidgets.verticalSpacerWidget(height * 0.02),



                          ],
                        ),
                      ),
                    ),

                    /// SubmitButton
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cancelButtonDisplay(),
                        if (!isReadOnly &&
                            state.model.lock.isEmptyOrNull) ...[
                          submitButtonDisplay()
                        ],
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

  Widget cancelButtonDisplay() {
    return AppButton(
      width: Constants.cancelButtonWidth,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.close,
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
}
