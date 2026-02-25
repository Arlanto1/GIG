import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';

import '../../model/opsTeamSitutationModel.dart';
import '../../services/opsSituationUpdateService.dart';
import '../cubit/buildingOccRepCubit.dart';

class BuildingOccupancyReportView extends StatefulWidget {
  final LsmOccupancyReport? model;
  final String title;
  final ExtraProperties? extraProperties;

  const BuildingOccupancyReportView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<BuildingOccupancyReportView> createState() =>
      _BuildingOccupancyReportViewState();
}

class _BuildingOccupancyReportViewState
    extends State<BuildingOccupancyReportView> {
  OpsSituationUpdateServices service = OpsSituationUpdateServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController fteCwrController = TextEditingController();
  TextEditingController supportStaffController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  bool isReadOnly = false;

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BuildingOccRepCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<BuildingOccRepCubit, BuildingOccRepState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          Navigator.pop(context, true); // optional: return success flag
        }
        fteCwrController.text =
            widget.model?.contingentWorker?.toString() ?? '';
        supportStaffController.text =
            widget.model?.supportStaff?.toString() ?? '';
        int fte = widget.model?.contingentWorker ?? 0;
        int staff = widget.model?.supportStaff ?? 0;
        totalController.text = (fte + staff).toString();
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.popOnly &&
            state.status != FormStatus.navigateToNextScreen) {
          log('000${state.status == FormStatus.popOnly}');
          var dialog = CustomAlertDialog(
            title: 'Building Occupancy Report',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              Navigator.pop(context);
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            // pdfAPIName:
            // '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.slaViolationPenaltyDetailsModuleCode}',
            showSaveButton: true,
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<BuildingOccRepCubit>(context).submitForm(
                isSaveOnly: true,
                navigateToNextScreen: false,
              );
            },
          ),
          backgroundColor: Colors.transparent,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  getBodybuilder(BuildingOccRepState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    return SizedBox.expand(
        child: Stack(
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
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      AbsorbPointer(
                        absorbing: isReadOnly,
                        child: Form(
                          key: _formKey,
                          autovalidateMode: isReadOnly
                              ? AutovalidateMode.disabled
                              : AutovalidateMode.onUserInteraction,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Column(
                              children: [
                                // if (!state.model.lock.isEmptyOrNull) ...[
                                //   RecordLockedWidget(text: '${state.model.lock}'),
                                // ],
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.03),

                                ///Location
                                CommonWidgets.textDisplay(
                                  state.labels?.locale.location ??
                                      state.labels?.defaultLocale.location ??
                                      Constants.location,
                                  Styles.textStyleWhite16,
                                  isMandatory: true,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                                BaseLocationDropdown().locationWidgetDisplay(
                                  selectedLocationName:
                                      state.model.locationId?.name ?? '',
                                  isEnabled: !isReadOnly,
                                  context: context,
                                  locations: state.locations!,
                                  onTap: (Organisation? location) async {
                                    log('location?.name-----${location?.name}');

                                    state.model.locationId = location;

                                    BlocProvider.of<BuildingOccRepCubit>(
                                      context,
                                    ).updateLocationDropdownValue(
                                      location: location,
                                    );
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// FTE and CWR
                                CommonWidgets.textDisplay(
                                  Constants.fteAndCwr,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                FlutterInputField(
                                  controller: fteCwrController,
                                  textInputType: TextInputType.number,
                                  textFormKey: Keys.visitorsNameKey,
                                  hintText: '',
                                  isEnable: true,
                                  isDisableColor: false,
                                  onChange: (String value) {
                                    int fte = int.tryParse(value) ?? 0;

                                    // Update model
                                    widget.model?.contingentWorker = fte;

                                    int staff = int.tryParse(
                                            supportStaffController.text) ??
                                        0;
                                    int total = fte + staff;

                                    totalController.text = total.toString();
                                    widget.model?.total = total;
                                  },
                                  validateTextField: (String? user) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Support Staff
                                CommonWidgets.textDisplay(
                                  Constants.supportStaff,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                FlutterInputField(
                                  controller: supportStaffController,
                                  textInputType: TextInputType.number,
                                  textFormKey: Keys.visitorsNameKey,
                                  hintText: '',
                                  isEnable: true,
                                  isDisableColor: false,
                                  onChange: (String value) {
                                    int staff = int.tryParse(value) ?? 0;

                                    // Update model
                                    widget.model?.supportStaff = staff;

                                    int fte =
                                        int.tryParse(fteCwrController.text) ??
                                            0;
                                    int total = fte + staff;

                                    totalController.text = total.toString();
                                    widget.model?.total = total;
                                  },
                                  validateTextField: (String? user) {},
                                ),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Total (read-only)
                                CommonWidgets.textDisplay(
                                  Constants.total,
                                  isMandatory: true,
                                  Styles.textStyleWhite14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                FlutterInputField(
                                  controller: totalController,
                                  textInputType: TextInputType.number,
                                  textFormKey: Keys.visitorsNameKey,
                                  hintText: '',
                                  isEnable: false,
                                  // read-only
                                  isDisableColor: true,
                                  onChange: (String value) {},
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.04),

                                /// SubmitButton
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // if ((state.model.status != 2 &&
                                    //     state.model.status != -1 &&
                                    //     !isReadOnly)) ...[
                                    cancelButtonDisplay(),
                                    submitButtonDisplay()
                                    // ],
                                  ],
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.04),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    //   CommonWidgets.verticalSpacerWidget(height * 0.04),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
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
        BlocProvider.of<BuildingOccRepCubit>(context).submitForm();
      },
    );
  }
}
