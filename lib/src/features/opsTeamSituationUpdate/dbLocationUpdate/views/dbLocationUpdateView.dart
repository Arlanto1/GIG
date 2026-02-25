import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';

import '../../model/opsTeamSitutationModel.dart';
import '../../services/opsSituationUpdateService.dart';
import '../cubit/dbLocationUpdateCubit.dart';

class DBLocationUpdateView extends StatefulWidget {
  final LsmLocationUpdate? model;
  final String title;
  final ExtraProperties? extraProperties;

  const DBLocationUpdateView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<DBLocationUpdateView> createState() =>
      _DBLocationUpdateViewState();
}

class _DBLocationUpdateViewState
    extends State<DBLocationUpdateView> {
  OpsSituationUpdateServices service = OpsSituationUpdateServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController specificLocationController = TextEditingController();
  TextEditingController currentRainSitController = TextEditingController();
  TextEditingController impactDBTransController = TextEditingController();
  TextEditingController overallImpactController = TextEditingController();
  TextEditingController waterLogOutsideController = TextEditingController();
  TextEditingController curTrafficSiteController = TextEditingController();
  TextEditingController incidentSiteController = TextEditingController();
  TextEditingController disIncidentSiteController = TextEditingController();

  bool isReadOnly = false;
  List<ImageContent> uploadFiles = [];

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DbLocationUpdateCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<DbLocationUpdateCubit, DbLocationUpdateState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          Navigator.pop(context, true); // optional: return success flag
        }
        if (state.model.specificLocation != null) {
          specificLocationController.text = state.model.specificLocation!;
        }

        if (state.model.rainFallStatus != null) {
          currentRainSitController.text = state.model.rainFallStatus!;
        }
        if (state.model.impactOnDbTransport != null) {
          impactDBTransController.text = state.model.impactOnDbTransport!;
        }
        if (state.model.overallImpact != null) {
          overallImpactController.text = state.model.overallImpact!;
        }
        if (state.model.waterLogging != null) {
          waterLogOutsideController.text = state.model.waterLogging!;
        }
        if (state.model.trafficStatus != null) {
          curTrafficSiteController.text = state.model.trafficStatus!;
        }

        if (state.model.incidentSite != null) {
          incidentSiteController.text = state.model.incidentSite!;
        }

        if (state.model.distance != null) {
          disIncidentSiteController.text = state.model.distance!;
        }


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
              // Navigator.pop(context);
              // return;
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
              BlocProvider.of<DbLocationUpdateCubit>(context).submitForm(
                isSaveOnly: true,
                navigateToNextScreen: false,
              );
            },
            // onTapSubmit: () {
            //   FocusScope.of(context).unfocus();
            //   BlocProvider.of<BuildingOccRepCubit>(context)
            //       .submitForm(
            //     isSaveOnly: false,
            //     navigateToNextScreen: false,
            //   );
            // },
          ),
          backgroundColor: Colors.transparent,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  getBodybuilder(DbLocationUpdateState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      uploadFiles = state.uploadAttachments;
      uploadFiles = state.model.images ?? [];
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

        // color: AppColors.newColor3,
        // color: AppColors.navigationSkyBlueColor,
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.transparent,
                // decoration: const ShapeDecoration(
                //     color: AppColors.backgroundWhiteColor,
                //     shape: RoundedRectangleBorder(
                //       borderRadius:
                //           BorderRadius.vertical(top: Radius.circular(20.0)),
                //     )),
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
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(
                            children: [
                              // if (!state.model.lock.isEmptyOrNull) ...[
                              //   RecordLockedWidget(text: '${state.model.lock}'),
                              // ],
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Specific Location
                              CommonWidgets.textDisplay(
                                Constants.specificLocation,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              FlutterInputField(
                                controller: specificLocationController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.visitorsNameKey,
                                hintText: '',
                                isEnable: true,
                                isDisableColor: false,
                                onChange: (String value) {
                                  widget.model?.specificLocation = value;
                                  specificLocationController.text = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Current Rain Situation
                              CommonWidgets.textDisplay(
                                Constants.currentRainSituation,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              FlutterInputField(
                                controller: currentRainSitController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.visitorsNameKey,
                                hintText: '',
                                isEnable: true,
                                isDisableColor: false,
                                onChange: (String value) {
                                  widget.model?.rainFallStatus = value;
                                  currentRainSitController.text = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Impact on DB Transport
                              CommonWidgets.textDisplay(
                                Constants.impactOnDbTrans,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              FlutterInputField(
                                controller: impactDBTransController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.visitorsNameKey,
                                hintText: '',
                                isEnable: true,
                                isDisableColor: false,
                                onChange: (String value) {
                                  widget.model?.impactOnDbTransport = value;
                                  impactDBTransController.text = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Overall Impact
                              CommonWidgets.textDisplay(
                                Constants.overallImpact,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              FlutterInputField(
                                controller: overallImpactController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.visitorsNameKey,
                                hintText: '',
                                isEnable: true,
                                isDisableColor: false,
                                onChange: (String value) {
                                  widget.model?.overallImpact = value;
                                  overallImpactController.text = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              ///Water Logging Outside Premises
                              CommonWidgets.textDisplay(
                                Constants.waterLoggingOutside,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              FlutterInputField(
                                controller: waterLogOutsideController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.visitorsNameKey,
                                hintText: '',
                                isEnable: true,
                                isDisableColor: false,
                                onChange: (String value) {
                                  widget.model?.waterLogging = value;
                                  waterLogOutsideController.text = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Current Traffic Situation
                              CommonWidgets.textDisplay(
                                Constants.trafficSituation,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              FlutterInputField(
                                controller: curTrafficSiteController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.visitorsNameKey,
                                hintText: '',
                                isEnable: true,
                                isDisableColor: false,
                                onChange: (String value) {
                                  widget.model?.trafficStatus = value;
                                  curTrafficSiteController.text = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Incident Site
                              CommonWidgets.textDisplay(
                                Constants.incidentSite,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              FlutterInputField(
                                controller: incidentSiteController,
                                textInputType: TextInputType.text,
                                textFormKey: Keys.visitorsNameKey,
                                hintText: '',
                                isEnable: true,
                                isDisableColor: false,
                                onChange: (String value) {
                                  widget.model?.incidentSite = value;
                                  incidentSiteController.text = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              /// Distance from Incident Site
                              CommonWidgets.textDisplay(
                                Constants.distanceIncidentSite,
                                isMandatory: true,
                                Styles.textStyleWhite14,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              FlutterInputField(
                                controller: disIncidentSiteController,
                                textInputType: TextInputType.number,
                                textFormKey: Keys.visitorsNameKey,
                                hintText: '',
                                isEnable: true,
                                isDisableColor: false,
                                onChange: (String value) {
                                  widget.model?.distance = value;
                                  disIncidentSiteController.text = value;
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),


                              ///Attachments
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.evidenceInfo ??
                                  //     state
                                  //         .labels?.defaultLocale.evidenceInfo ??
                                      Constants.attachments,
                                  Styles.textStyleWhite16),
                              widget.model == null
                                  ? CommonWidgets.verticalSpacerWidget(
                                  height * 0.001)
                                  : Container(),
                              // if (state.model.status == 0 ||
                              //     state.model.status == null) ...[
                                BaseImageUpload().uploadWidget(
                                  context: context,
                                  isDisabled: isReadOnly,
                                  loggedInUserDetails:
                                  state.loggedInUserDetails!,
                                  getFiles: uploadFiles,
                                  onImageSelected: (ImageContent data) {
                                    List<ImageContent>? files = [];
                                    files.add(data);
                                    for (ImageContent image in uploadFiles) {
                                      files.add(image);
                                    }
                                    BlocProvider.of<
                                        DbLocationUpdateCubit>(
                                        context)
                                        .addAttachment(
                                      data: files,
                                      images: files,
                                    );
                                  },
                                ),
                              // ],

                              /// Attachments
                              IgnorePointer(
                                ignoring: false,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: BaseImageUpload().getAttachment(
                                    height: height,
                                    attachments: state.uploadAttachments,
                                    files: uploadFiles,
                                    moduleCode: '',
                                      isDisabled: false,
                                    showDeleteIcon:true
                                    // state.model.status == null ||
                                    //     state.model.status == 0,
                                  ),
                                ),
                              ),
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
                              CommonWidgets.verticalSpacerWidget(height * 0.04),
                            ],
                          ),
                        ),
                        // if (state.model.status == 2 ||
                        //     state.model.status == ConstantsIntValue.cancelledStatus ||
                        //     isReadOnly) ...[
                        //   Container(
                        //     padding: const EdgeInsets.all(5.0),
                        //     decoration: ShapeDecoration(
                        //       color: AppColors.newColor3,
                        //       shape: const RoundedRectangleBorder(
                        //         borderRadius:
                        //         BorderRadius.vertical(top: Radius.circular(0.0)),
                        //       ),
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         cancelButtonDisplay(),
                        //       ],
                      ),
                    ),
                  ],
                  //   CommonWidgets.verticalSpacerWidget(height * 0.04),
                ),
              )
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
        BlocProvider.of<DbLocationUpdateCubit>(context).submitForm();
      },
    );
  }
}
