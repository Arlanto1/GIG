import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/selfPacedTraining/models/selfPacedTrainingModel.dart';
import 'package:db_atom/src/features/selfPacedTraining/selfPacedTrainingDetails/cubits/selfPacedTrainingDetailsCubit.dart';

class SelfPacedTrainingDetailsView extends StatefulWidget {
  const SelfPacedTrainingDetailsView(
      {super.key, this.extraProperties, this.model});

  final ExtraProperties? extraProperties;
  final SelfPacedTrainingModel? model;

  @override
  State<SelfPacedTrainingDetailsView> createState() =>
      _SelfPacedTrainingDetailsViewState();
}

class _SelfPacedTrainingDetailsViewState
    extends State<SelfPacedTrainingDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController incidentDateTimeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController assetTypeController = TextEditingController();
  TextEditingController assetController = TextEditingController();
  TextEditingController incidentTypeController = TextEditingController();
  TextEditingController claimantController = TextEditingController();

  bool disableForm = false;
  final FocusNode complainantFocusNode = FocusNode();
  final FocusNode incidentLocationFocusNode = FocusNode();
  final FocusNode incidentDescriptionFocusNode = FocusNode();
  final FocusNode complainantEmpIdFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SelfPacedTrainingDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<SelfPacedTrainingDetailsCubit,
        SelfPacedTrainingDetailsState>(
      listener: (context, state) {
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: Constants.incidentManagementTitle,
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () async {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                incidentManagementsRoute,
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
        log('--state.message-----${state.message}-');
      },
      builder: (context, state) {
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   disableForm = true;
        // }
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.generalInformation,
            showPopUp: false,
            showSaveButton: false,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            // pdfAPIName:
            // '${CommonApis.exportDetailPagePDF}${state.model
            //     .id}&moduleCode=${Constants.incidentManagementModule}',
            onTapSave: () {},
            onTapSubmit: () {},
          ),
          backgroundColor: AppColors.newColor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates(SelfPacedTrainingDetailsState state) {
    // DateTime dateTime;
    // dateTime = DateFormat("dd/MM/yyyy HH:mm:ss")
    //     .parse(startDateController.text);
    // int inputDate = dateTime.toUtc().millisecondsSinceEpoch ~/ 1000;
    // state.model.startDate = inputDate.toString();
    // }
  }

  getBodybuilder(SelfPacedTrainingDetailsState state, height) {
    initializeDates(state);
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    return Stack(
      children: [
        //  Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg2.png',
            fit: BoxFit.cover,
          ),
        ),

        //  Blur Layer
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
              // Container(height: height * 0.01, color: AppColors.newColor3),
              Container(
                color: Colors.transparent,
                // decoration: ShapeDecoration(
                //     color: AppColors.newColor3,
                //     shape: const RoundedRectangleBorder(
                //       borderRadius:
                //           BorderRadius.vertical(top: Radius.circular(20.0)),
                //     )),
                child: Form(
                  key: _formKey,
                  autovalidateMode: disableForm
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AbsorbPointer(
                          absorbing: disableForm,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Column(children: [
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  Constants.trainingSetup,
                                  style: Styles.textStyleRegularNormalWhite18,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Title
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.status ??
                                  //     state.labels?.defaultLocale.status ??
                                  Constants.title,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: '${state.model.title}',
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              ///Description
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                  Constants.description,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: '${state.model.description}',
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),



                              /// Questionnaire
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                  Constants.questionnaire,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: '${state.model.questionnaireName}',
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Recipient Group(s)
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                  Constants.recipientGroup,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: (state.model.trainingGroups ?? [])
                                    .map((group) => group.groupName ?? '')
                                    .join(', '),
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Launch Date
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.mo ??
                                //     state.labels?.defaultLocale.inputDate ??
                                  Constants.launchDate,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              BaseDate().creationDateDisplay(
                                  state.model.launchDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Due Date
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.mo ??
                                //     state.labels?.defaultLocale.inputDate ??
                                  Constants.duedate,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              BaseDate().creationDateDisplay(
                                  state.model.dueDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),




                              /// Passing Score
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                  Constants.passingScore,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: '${state.model.passingScore}',
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Status
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.status ??
                                      state.labels?.defaultLocale.status ??
                                      Constants.status,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: '${state.model.status ?? 0}',
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),



                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  Constants.audit,
                                  style: Styles.textStyleRegularNormalWhite18,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              ///Creator Name
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.status ??
                                  //     state.labels?.defaultLocale.status ??
                                  Constants.creatorName,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: '${state.model.creatorName}',
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Creator Email
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.status ??
                                  //     state.labels?.defaultLocale.status ??
                                  Constants.creatorEmail,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: '${state.model.creatorEmail}',
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Creation Date
                              CommonWidgets.textDisplay(
                                  state.labels?.locale.inputDate ??
                                      state.labels?.defaultLocale.inputDate ??
                                      Constants.creationDate,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              BaseDate().creationDateDisplay(
                                  state.model.creationDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Modified By
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.status ??
                                //     state.labels?.defaultLocale.status ??
                                  Constants.modifiedBy,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: '${state.model.modificatorName}',
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Modified Date
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.mo ??
                                  //     state.labels?.defaultLocale.inputDate ??
                                      Constants.modifiedDate,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                              BaseDate().creationDateDisplay(
                                  state.model.modificationDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ]),
                          ),
                        ),

                        /// SubmitButton
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cancelButtonDisplay(),
                          ],
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.04),
                      ]),
                ),
              ),
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
