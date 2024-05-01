import 'dart:developer';

import 'package:db_atom/index.dart';

import '../../models/vvip_visitor_response_model.dart';
import '../cubits/vvip_visitor_details_cubit.dart';

class VVIPVisitorDetailsView extends StatefulWidget {
  final VIVPVisitorModel? model;
  final String title;
  final ExtraProperties? extraProperties;

  const VVIPVisitorDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<VVIPVisitorDetailsView> createState() => _VVIPVisitorDetailsViewState();
}

class _VVIPVisitorDetailsViewState extends State<VVIPVisitorDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController returnableTextController = TextEditingController();
  User? userDetails;
  bool isReadOnly = false;

  get model => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VVIPVisitorDetailsCubit>(context).initializeValues();
    initializeDates();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<VVIPVisitorDetailsCubit, VVIPVisitorDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'VVIP Visitors',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                vipVisitorsListRoute,
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
        // if (state.model.status == 6 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        if (state.model.status == null) {
          isReadOnly = false;
        }
        if (widget.extraProperties != null &&
            !widget.extraProperties!.hasWritePermission!) {
          isReadOnly = true;
        }
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            showSaveButton: state.model.status != -1 &&
                    state.model.status != 1 &&
                    !isReadOnly
                ? true
                : false,
            showSubmitButton: state.model.status != -1 &&
                    state.model.status != 1 &&
                    !isReadOnly
                ? true
                : false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<VVIPVisitorDetailsCubit>(context).submitForm(
                isSaveOnly: true,
                navigateToNextScreen: false,
              );
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<VVIPVisitorDetailsCubit>(context).submitForm(
                isSaveOnly: false,
                navigateToNextScreen: false,
              );
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void initializeDates() {
    // TODO: Maybe we can remove this
  }

  getBodybuilder(VVIPVisitorDetailsState state, height) {
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
                ),
              ),
              child: AbsorbPointer(
                absorbing: isReadOnly,
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
                            // if (!state.model.lock.isEmptyOrNull) ...[
                            //   RecordLockedWidget(text: '${state.model.lock}'),
                            // ],
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.generalinformation,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Created By
                            CommonWidgets.verticalTextHandling(
                                state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                isMandatory: true,
                                '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}'),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Status
                            CommonWidgets.textDisplay(
                              state.labels?.locale.status ??
                                  state.labels?.defaultLocale.status ??
                                  Constants.status,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              isEnable: false,
                              isDisableColor: true,
                              textFormKey: Keys.statusTextController,
                              hintText: '',
                              initialValue:
                                  getStatusString(state.model.status ?? 0),
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(
                              state.labels?.locale.inputDate ??
                                  state.labels?.defaultLocale.inputDate ??
                                  Constants.dateofcreation,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
                                state.model.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location
                            CommonWidgets.textDisplay(
                              state.labels?.locale.location ??
                                  state.labels?.defaultLocale.location ??
                                  Constants.location,
                              Styles.textStyleBlack14,
                              isMandatory: true,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            locationWidgetdislay(state),

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
                            if (state.model.status != null) ...[
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
                              datecreateWidgetdisplay(
                                  state.model.modifiedDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              /// Modified By
                              CommonWidgets.horizentaltextHandling(
                                  // state.labels?.locale.entrySecurity ??
                                  //     state.labels?.defaultLocale.entrySecurity ??
                                  Constants.modifiedBy,
                                  isMandatory: true,
                                  state.loggedInUserDetails?.email ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            /// VVIP Visitors
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.listVvipVisitors,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            GestureDetector(
                              onTap: () async {
                                NavigatorState nav = Navigator.of(context);
                                bool isSaveSuccess = await BlocProvider.of<
                                        VVIPVisitorDetailsCubit>(context)
                                    .submitForm(
                                  isSaveOnly: true,
                                  navigateToNextScreen: true,
                                );

                                if (!isSaveSuccess) {
                                  return;
                                }
                                log('--state.model.id---${state.model.id}--');

                                nav.pushNamed(
                                  vipVisitorsRecordsRoute,
                                  arguments: {
                                    ConstantsArgument.title:
                                        Constants.vVipVisitors,
                                    ConstantsArgument.id: state.model.id,
                                    // ConstantsArgument.violationDescription:
                                    //     Constants.slaViolation,
                                  },
                                );
                                //}
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    AppIcon.pluscircle,
                                    color: AppColors.navigationSkybluecolor,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Add/View VVIP Visitors',
                                    style: TextStyle(
                                      color: AppColors.navigationSkybluecolor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.02),
                          ],
                        ),
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// SubmitButton
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cancelButtonDisplay(state),
                          if ((state.model.status != -1 &&
                                      state.model.status != 1) &&
                                  !isReadOnly
                              ? true
                              : false) ...[submitButtonDisplay()],
                        ],
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ],
                  ),
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
      case -1:
        return 'Cancelled';
      case 0:
        return 'Created';
      case 1:
        return 'Submitted';
      default:
        return '';
    }
  }

  Widget cancelButtonDisplay(VVIPVisitorDetailsState state) {
    bool condition = widget.model?.id == null ||
        widget.model?.status == ConstantsIntValue.cancelledStatus ||
        widget.model?.status == 1;
    return AppButton(
      width: Constants.cancelButtonWidth,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: condition ? Constants.close : Constants.cancelRecord,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        if (condition) {
          Navigator.pop(context);
          return;
        }
        var dialog = CustomAlertDialog(
            title: Constants.cancelRecord,
            message: Constants.cancelRecordWarningMessage,
            onPositivePressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              updateRecordStatus(state);
            },
            positiveBtnText: Constants.yes,
            negativeBtnText: Constants.no);
        showDialog(context: context, builder: (BuildContext context) => dialog);
      },
    );
  }

  void updateRecordStatus(VVIPVisitorDetailsState state) {
    if (state.model.id != null) {
      BlocProvider.of<VVIPVisitorDetailsCubit>(context)
          .updateStatus(id: state.model.id.toString());
      Navigator.popAndPushNamed(
        context,
        vipVisitorsListRoute,
      );
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

        BlocProvider.of<VVIPVisitorDetailsCubit>(context).submitForm();
      },
    );
  }

  Widget locationWidgetdislay(VVIPVisitorDetailsState state) {
    return GestureDetector(
      onTap: () {
        if (state.model.status == 0 || state.model.status == null) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return CustomExpansionListTexts(
                locationList: state.locations,
                onTap: (Organisation? list) async {
                  Organisation location = Organisation();
                  location.id = list?.id;
                  location.name = list?.name;
                  state.model.location = location;

                  BlocProvider.of<VVIPVisitorDetailsCubit>(context)
                      .updateDropdownValues(location: location);
                },
              );
            },
          );
        }
      },
      child: SelectedTileValueWidget(name: state.model.location?.name ?? ''),
    );
  }

  Widget datecreateWidgetdisplay(String date) {
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
