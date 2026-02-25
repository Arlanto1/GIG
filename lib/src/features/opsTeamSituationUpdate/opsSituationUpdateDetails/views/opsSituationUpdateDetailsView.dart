import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';

import '../../model/opsTeamSitutationModel.dart';
import '../../model/requestmodel/buildingRepRequestModel.dart';
import '../../services/opsSituationUpdateService.dart';
import '../cubits/opsSituationUpdateDetailsCubit.dart';

class OpsSituationUpdateDetailsView extends StatefulWidget {
  final LsmSituationalModel? model;
  final String title;
  final ExtraProperties? extraProperties;

  const OpsSituationUpdateDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<OpsSituationUpdateDetailsView> createState() =>
      _OpsSituationUpdateDetailsViewState();
}

class _OpsSituationUpdateDetailsViewState
    extends State<OpsSituationUpdateDetailsView> {
  OpsSituationUpdateServices service = OpsSituationUpdateServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController statusController = TextEditingController();
  bool isReadOnly = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OpsSituationUpdateDetailsCubit>(context).initializeValues();
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
    return BlocConsumer<OpsSituationUpdateDetailsCubit,
        OpsSituationUpdateDetailsState>(
      listener: (context, state) {
        log(
          'LSM records: ${state.model.lsmOccupancyReport}',
        );
        log(
          'alertDetails${state.model.alertDetails}',
        );

        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success &&
            state.status != FormStatus.navigateToNextScreen) {
          log('000${state.status == FormStatus.popOnly}');
          var dialog = CustomAlertDialog(
            title: 'Ops Situational Team Update',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              return;
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
      },
      builder: (context, state) {
        // if (state.model.status == 2 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        // if (state.model.status == -1 || !state.model.lock.isEmptyOrNull) {
        //   isReadOnly = true;
        // }
        if (state.model.status == null) {
          isReadOnly = false;
        }
        // if (widget.extraProperties != null &&
        //     !widget.extraProperties!.hasWritePermission!) {
        //   isReadOnly = true;
        // }

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            pdfAPIName:
                '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.slaViolationPenaltyDetailsModuleCode}',
            showSaveButton: state.model.status != 3 &&
                    state.model.status != -1 &&
                    !isReadOnly &&
                    state.status != FormStatus.loading
                ? true
                : false,
            showSubmitButton: state.model.status != 3 &&
                    state.model.status != -1 &&
                    !isReadOnly &&
                    state.status != FormStatus.loading
                ? true
                : false,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<OpsSituationUpdateDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: true,
                navigateToNextScreen: false,
              );
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<OpsSituationUpdateDetailsCubit>(context)
                  .submitForm(
                isSaveOnly: false,
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

  void initializeDates() {
    // TODO: Maybe we can remove this
  }

  getBodybuilder(OpsSituationUpdateDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
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
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text(
                                  Constants.generalinformation,
                                  style: Styles.textStyleWhite16,
                                ),
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),

                              // General Information Fields
                              ///Created By
                              CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.entrySecurity ??
                                    state.labels?.defaultLocale.entrySecurity ??
                                    Constants.createdby,
                                '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}',
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Status
                              CommonWidgets.textDisplay(
                                state.labels?.locale.status ??
                                    state.labels?.defaultLocale.status ??
                                    Constants.status,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: Utils().buildLSMStatus(
                                    state.model.status ?? 0,
                                    returnTextOnly: true),
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Date of Creation
                              CommonWidgets.textDisplay(
                                state.labels?.locale.inputDate ??
                                    state.labels?.defaultLocale.inputDate ??
                                    Constants.dateofcreation,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              datecreateWidgetdisplay(
                                  state.model.inputDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Location
                              CommonWidgets.textDisplay(
                                state.labels?.locale.location ??
                                    state.labels?.defaultLocale.location ??
                                    Constants.location,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              BaseLocationDropdown().locationWidgetDisplay(
                                selectedLocationName:
                                    state.model.location?.name ?? '',
                                isEnabled: !isReadOnly,
                                context: context,
                                locations: state.locations!,
                                onTap: (Organisation? location) async {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Sl no
                              CommonWidgets.horizentaltextHandling(
                                state.labels?.locale.slNo ??
                                    state.labels?.defaultLocale.slNo ??
                                    Constants.slno,
                                state.model.slNo ?? '',
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Warning/Alert
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.typeOfService ??
                                  //     state.labels?.defaultLocale
                                  //         .typeOfService ??
                                  Constants.warningAlert,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                fillColor: true,
                                backgroundColor: Utils()
                                    .getStatusColor(state.model.alertType ?? 0),
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: Utils().buildWarning(
                                    state.model.alertType ?? 0,
                                    returnTextOnly: true),
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),

                              // BaseEntitiesSelection().entityDropDownSelection(
                              //   context: context,
                              //   selectedValues: state.model.typeOfService ?? [],
                              //   all: state.typeOfServices,
                              //   enabled: false,
                              //   onTap: (List<Organisation> p1) {  },
                              //   functionToCall: () {
                              //     BlocProvider.of<
                              //         OpsSituationUpdateDetailsCubit>(
                              //         context)
                              //         .refreshList();
                              //   },
                              // ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Forecast Type
                              CommonWidgets.textDisplay(
                                  // state.labels?.locale.typeOfService ??
                                  //     state.labels?.defaultLocale
                                  //         .typeOfService ??
                                  Constants.forecastType,
                                  Styles.textStyleWhite16,
                                  isMandatory: true),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                isEnable: false,
                                isDisableColor: true,
                                textFormKey: Keys.statusTextController,
                                hintText: '',
                                initialValue: Utils().buildForecastType(
                                    state.model.forecastType ?? 0,
                                    returnTextOnly: true),
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              // BaseEntitiesSelection().entityDropDownSelection(
                              //   context: context,
                              //   selectedValues: state.model.typeOfService ?? [],
                              //   all: state.typeOfServices,
                              //   enabled: false,
                              //   onTap: (List<Organisation> p1) {  },
                              //   functionToCall: () {
                              //     BlocProvider.of<
                              //         OpsSituationUpdateDetailsCubit>(
                              //         context)
                              //         .refreshList();
                              //   },
                              // ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              /// Description
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.poNumber ??
                                //     state.labels?.defaultLocale.poNumber ??
                                Constants.description,
                                Styles.textStyleWhite16,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                textInputType: TextInputType.text,
                                initialValue: state.model.alertDetails,
                                textFormKey: Keys.poNumberKey,
                                hintText: '',
                                isEnable: false,
                                isDisableColor: true,
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              if (state.model.status != 1 &&
                                  state.model.status != null) ...[
                                /// Mail To
                                CommonWidgets.textDisplay(
                                    // state.labels?.locale.distributionList ??
                                    //     state.labels?.defaultLocale
                                    //         .distributionList ??
                                    Constants.mailTo,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                BaseEntitiesSelection().entityDropDownSelection(
                                  context: context,
                                  selectedValues: state.model.mailListTo ?? [],
                                  all: state.mailTo ?? [],
                                  enabled: true,
                                  onTap: (List<Organisation> selectedGroups) {
                                    BlocProvider.of<
                                                OpsSituationUpdateDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                            mailTo: selectedGroups);
                                    Navigator.of(context).pop();
                                  },
                                  functionToCall: () {
                                    BlocProvider.of<
                                                OpsSituationUpdateDetailsCubit>(
                                            context)
                                        .refreshList();
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Mail Cc
                                CommonWidgets.textDisplay(
                                    // state.labels?.locale.distributionList ??
                                    //     state.labels?.defaultLocale
                                    //         .distributionList ??
                                    Constants.mailCc,
                                    Styles.textStyleWhite16,
                                    isMandatory: true),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),

                                BaseEntitiesSelection().entityDropDownSelection(
                                  context: context,
                                  selectedValues: state.model.mailListCc ?? [],
                                  all: state.mailCc ?? [],
                                  enabled: true,
                                  onTap: (List<Organisation> selectedGroups) {
                                    BlocProvider.of<
                                                OpsSituationUpdateDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                            mailCc: selectedGroups);
                                    Navigator.of(context).pop();
                                  },
                                  functionToCall: () {
                                    BlocProvider.of<
                                                OpsSituationUpdateDetailsCubit>(
                                            context)
                                        .refreshList();
                                  },
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),
                              ],

                              ///Modified By
                              CommonWidgets.horizentaltextHandling(
                                // state.labels?.locale.entrySecurity ??
                                //     state.labels?.defaultLocale.entrySecurity ??
                                Constants.modifiedBy,
                                state.model.modifiedBy ?? '',
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),

                              ///Modified Date
                              CommonWidgets.textDisplay(
                                // state.labels?.locale.mo ??
                                //     state.labels?.defaultLocale.inputDate ??
                                Constants.modifiedDate,
                                Styles.textStyleWhite16,
                                isMandatory: true,
                              ),
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              datecreateWidgetdisplay(
                                  state.model.modifiedDate ?? ''),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                              CommonWidgets.verticalSpacerWidget(height * 0.02),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// List of DB Location Update
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              Constants.listDbLocationUpdate,
                              style: Styles.textStyleWhite16,
                            ),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.02),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border:
                                  Border.all(color: Colors.white, width: .7),
                            ),
                            child: Column(
                              children: [
                                /// HEADER
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 13),
                                  color: Colors.white.withValues(alpha: 0.1),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Id",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const Expanded(
                                        child: Text(
                                          "Specific Location",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const Expanded(
                                        child: Text(
                                          "Incident Site",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                      ///  CREATE ICON
                                      InkWell(
                                        onTap: () async {
                                          try {
                                            if (!context.mounted) return;
                                            final result =
                                                await Navigator.pushNamed(
                                              context,
                                              dbLocUpdateDetailsRoute,
                                              arguments: {
                                                ConstantsArgument.title:
                                                    'DB Location Update',
                                                ConstantsArgument.model:
                                                    LsmLocationUpdate(),
                                                ConstantsArgument.parentId:
                                                    widget.model?.id,
                                              },
                                            );

                                            if (result == true &&
                                                context.mounted) {
                                              BlocProvider.of<
                                                          OpsSituationUpdateDetailsCubit>(
                                                      context)
                                                  .getLSMById(
                                                      widget.model!.id!);
                                            }
                                          } catch (e) {
                                            debugPrint(
                                                'Error opening DB Location Update: $e');
                                          }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "Edit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),

                                /// RECORDS
                                ...?state.model.lsmLocationUpdate?.map((item) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.white
                                                .withValues(alpha: 0.2)),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        /// ID
                                        Expanded(
                                          child: Text(
                                            '${item.id}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),

                                        /// LOCATION NAME
                                        Expanded(
                                          child: Text(
                                            // '${item.locationId}',
                                            '${item.specificLocation}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),

                                        Expanded(
                                          child: Text(
                                            '${item.incidentSite}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),

                                        /// DELETE BUTTON
                                        InkWell(
                                          // onTap: () async {
                                          //   final confirm = await showDialog<bool>(
                                          //     context: context,
                                          //     builder: (_) => AlertDialog(
                                          //       title: const Text('Delete Record'),
                                          //       content: const Text('Are you sure you want to delete this record?'),
                                          //       actions: [
                                          //         TextButton(
                                          //           onPressed: () => Navigator.pop(context, false),
                                          //           child: const Text('Cancel'),
                                          //         ),
                                          //         TextButton(
                                          //           onPressed: () => Navigator.pop(context, true),
                                          //           child: const Text('Delete'),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   );
                                          //
                                          //   if (confirm == true && context.mounted) {
                                          //     context.read<OpsSituationUpdateDetailsCubit>().deleteDBLocationUpdate(
                                          //       deleteId: item.id!,
                                          //       parentId: widget.model!.id!,
                                          //     );
                                          //     BlocProvider.of<OpsSituationUpdateDetailsCubit>(context)
                                          //         .getLSMById(widget.model!.id!);
                                          //   }
                                          // },

                                          onTap: () async {
                                            final confirm =
                                                await showDialog<bool>(
                                              context: context,
                                              barrierColor: Colors.black
                                                  .withValues(alpha: 0.2),
                                              builder: (context) {
                                                return Dialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 12,
                                                          sigmaY: 12),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blueGrey
                                                              .withValues(
                                                                  alpha: 0.15),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          border: Border.all(
                                                            color: Colors.white
                                                                .withValues(
                                                                    alpha: 0.3),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              'Delete Record',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 12),
                                                            const Text(
                                                              'Are you sure you want to delete this record?',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            const SizedBox(
                                                                height: 20),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          false),
                                                                  child:
                                                                      const Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 8),
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          true),
                                                                  child:
                                                                      const Text(
                                                                    'Delete',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );

                                            if (confirm == true &&
                                                context.mounted) {
                                              context
                                                  .read<
                                                      OpsSituationUpdateDetailsCubit>()
                                                  .deleteDBLocationUpdate(
                                                    deleteId: item.id!,
                                                    parentId: widget.model!.id!,
                                                  );

                                              context
                                                  .read<
                                                      OpsSituationUpdateDetailsCubit>()
                                                  .getLSMById(
                                                      widget.model!.id!);
                                            }
                                          },

                                          child: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),

                                        /// EDIT BUTTON
                                        InkWell(
                                          onTap: () async {
                                            try {
                                              final dbLocData = await service
                                                  .getDBLocUpdateById(
                                                      '${item.id}');
                                              if (!context.mounted) return;
                                              Navigator.pushNamed(
                                                context,
                                                dbLocUpdateDetailsRoute,
                                                arguments: {
                                                  ConstantsArgument.title:
                                                      'DB Location Update',
                                                  ConstantsArgument.model:
                                                      dbLocData,
                                                  ConstantsArgument.parentId:
                                                      widget.model?.id,
                                                },
                                              );
                                            } catch (e) {
                                              debugPrint(
                                                  'Error fetching LSM: $e');
                                              // optionally show snackbar / dialog
                                            }
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.02),

                    /// Building Occupancy Report
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              Constants.buildingReport,
                              style: Styles.textStyleWhite16,
                            ),
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.02),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border:
                                  Border.all(color: Colors.white, width: .7),
                            ),
                            child: Column(
                              children: [
                                /// HEADER
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  color: Colors.white.withValues(alpha: 0.1),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Id",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const Expanded(
                                        child: Text(
                                          "Location",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const Expanded(
                                        child: Text(
                                          "Total",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          try {
                                            if (!context.mounted) return;
                                            final result =
                                                await Navigator.pushNamed(
                                              context,
                                              buildingOccRepDetailsRoute,
                                              arguments: {
                                                ConstantsArgument.title:
                                                    'Building Occupancy Report',
                                                ConstantsArgument.model:
                                                    LsmOccupancyReport(),
                                                ConstantsArgument.parentId:
                                                    widget.model?.id,
                                              },
                                            );
                                            if (result == true &&
                                                context.mounted) {
                                              BlocProvider.of<
                                                          OpsSituationUpdateDetailsCubit>(
                                                      context)
                                                  .getLSMById(
                                                      widget.model!.id!);
                                            }
                                          } catch (e) {
                                            debugPrint(
                                                'Error opening Building Occupancy Report Update: $e');
                                          }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "Edit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),

                                /// RECORDS
                                ...?state.model.lsmOccupancyReport?.map((item) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.white
                                                .withValues(alpha: 0.2)),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        /// ID
                                        Expanded(
                                          child: Text(
                                            '${item.id}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),

                                        /// LOCATION NAME
                                        Expanded(
                                          child: Text(
                                            // '${item.locationId}',
                                            item.locationId!.name!,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),

                                        Expanded(
                                          child: Text(
                                            '${item.total}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),

                                        /// DELETE BUTTON
                                        InkWell(
                                          onTap: () async {
                                            final confirm =
                                                await showDialog<bool>(
                                              context: context,
                                              barrierColor: Colors.black
                                                  .withValues(alpha: 0.2),
                                              builder: (context) {
                                                return Dialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 12,
                                                          sigmaY: 12),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blueGrey
                                                              .withValues(
                                                                  alpha: 0.15),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          border: Border.all(
                                                            color: Colors.white
                                                                .withValues(
                                                                    alpha: 0.3),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              'Delete Record',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 12),
                                                            const Text(
                                                              'Are you sure you want to delete this record?',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            const SizedBox(
                                                                height: 20),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          false),
                                                                  child:
                                                                      const Text(
                                                                    'Cancel',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 8),
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          context,
                                                                          true),
                                                                  child:
                                                                      const Text(
                                                                    'Delete',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );

                                            if (confirm == true &&
                                                context.mounted) {
                                              context
                                                  .read<
                                                      OpsSituationUpdateDetailsCubit>()
                                                  .deleteBuildingOccReport(
                                                    deleteId: item.id!,
                                                    parentId: widget.model!.id!,
                                                  );
                                              BlocProvider.of<
                                                          OpsSituationUpdateDetailsCubit>(
                                                      context)
                                                  .getLSMById(
                                                      widget.model!.id!);
                                            }
                                          },
                                          child: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),

                                        /// EDIT BUTTON
                                        InkWell(
                                          onTap: () async {
                                            try {
                                              final occRepData = await service
                                                  .getBuildingReportById(
                                                      '${item.id}');
                                              if (!context.mounted) return;
                                              Navigator.pushNamed(
                                                context,
                                                buildingOccRepDetailsRoute,
                                                arguments: {
                                                  ConstantsArgument.title:
                                                      'Building Occupancy Report',
                                                  ConstantsArgument.model:
                                                      occRepData,
                                                  ConstantsArgument.parentId:
                                                      widget.model?.id,
                                                },
                                              );
                                            } catch (e) {
                                              debugPrint(
                                                  'Error fetching LSM: $e');
                                              // optionally show snackbar / dialog
                                            }
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.04),

                    /// SubmitButton
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if ((state.model.status != 3 &&
                            state.model.status != -1 &&
                            !isReadOnly)) ...[submitButtonDisplay()],
                        cancelButtonDisplay(),
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
              //     ),
              //   ),
              // ],
              CommonWidgets.verticalSpacerWidget(height * 0.04),
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
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<OpsSituationUpdateDetailsCubit>(context).submitForm();
      },
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
