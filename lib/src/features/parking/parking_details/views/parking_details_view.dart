// // // // // import 'dart:developer';
// // // // // import 'dart:ui';
// // // // //
// // // // // import 'package:db_atom/index.dart';
// // // // // import 'package:db_atom/src/features/parking/models/parking_model.dart';
// // // // // import 'package:db_atom/src/features/parking/parking_details/cubits/parking_details_cubit.dart';
// // // // //
// // // // // class ParkingDetailsView extends StatefulWidget {
// // // // //   final ParkingModel? model;
// // // // //   final String title;
// // // // //   final ExtraProperties? extraProperties;
// // // // //
// // // // //   const ParkingDetailsView({
// // // // //     super.key,
// // // // //     this.model,
// // // // //     required this.title,
// // // // //     this.extraProperties,
// // // // //   });
// // // // //
// // // // //   @override
// // // // //   State<ParkingDetailsView> createState() =>
// // // // //       _ParkingDetailsViewState();
// // // // // }
// // // // //
// // // // // class _ParkingDetailsViewState
// // // // //     extends State<ParkingDetailsView> {
// // // // //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// // // // //   User? userDetails;
// // // // //   TextEditingController statusController = TextEditingController();
// // // // //   TextEditingController timeOfVisitController = TextEditingController();
// // // // //   TextEditingController customerVisitorsController =
// // // // //   TextEditingController();
// // // // //   TextEditingController empVisitorsController = TextEditingController();
// // // // //   TextEditingController totalVisitorsController = TextEditingController();
// // // // //   TextEditingController empHeadCountController = TextEditingController();
// // // // //   TextEditingController totalParkingSlotsController = TextEditingController();
// // // // //   TextEditingController occParkingSlotsController = TextEditingController();
// // // // //   TextEditingController availableParkingSlotsController = TextEditingController();
// // // // //   TextEditingController parkingUtilizationPercentController = TextEditingController();
// // // // //   TextEditingController remarksController = TextEditingController();
// // // // //   TextEditingController externalParkingController = TextEditingController();
// // // // //
// // // // //   List<ImageContent> uploadFiles = [];
// // // // //
// // // // //   bool isReadOnly = false;
// // // // //
// // // // //   get model => null;
// // // // //
// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     BlocProvider.of<ParkingDetailsCubit>(context).initializeValues();
// // // // //     // initializeDates(state);
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   void dispose() {
// // // // //     super.dispose();
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final size = MediaQuery.of(context).size;
// // // // //     double height = size.height;
// // // // //     return BlocConsumer<ParkingDetailsCubit, ParkingDetailsState>(
// // // // //       listener: (context, state) {
// // // // //         log('-state.status---${state.status}----');
// // // // //         Utils().formError(state, context);
// // // // //         Utils().errorAndLogout(state, context);
// // // // //         if (state.status == FormStatus.success) {
// // // // //           var dialog = CustomAlertDialog(
// // // // //             title: 'Parking',
// // // // //             message: state.message ?? '',
// // // // //             positiveBtnText: Constants.ok,
// // // // //             onPositivePressed: () {
// // // // //               Navigator.pop(context);
// // // // //               Navigator.pop(context);
// // // // //               Navigator.popAndPushNamed(context, parkingListRoute);
// // // // //             },
// // // // //           );
// // // // //           showDialog(
// // // // //               context: context,
// // // // //               barrierDismissible: false,
// // // // //               builder: (BuildContext context) => dialog);
// // // // //         }
// // // // //       },
// // // // //       builder: (context, state) {
// // // // //
// // // // //         if (state.model.status == 1) {
// // // // //           isReadOnly = false;
// // // // //         }
// // // // //         if (state.model.status == -1) {
// // // // //           isReadOnly = false;
// // // // //         }
// // // // //
// // // // //         // if (widget.extraProperties != null &&
// // // // //         //     !widget.extraProperties!.hasWritePermission!) {
// // // // //         //   isReadOnly = true;
// // // // //         // }
// // // // //         return Scaffold(
// // // // //           appBar: BaseAppBar().buildAppHeader(
// // // // //             context: context,
// // // // //             title: widget.title,
// // // // //             showPopUp: false,
// // // // //             pdfAPIName:
// // // // //             '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.leoModuleCode}',
// // // // //             showSaveButton:
// // // // //             !isReadOnly,
// // // // //             showSubmitButton:
// // // // //             !isReadOnly,
// // // // //             showDisLikeButton: false,
// // // // //             showLikeButton: false,
// // // // //             onTapSave: () {
// // // // //               FocusScope.of(context).unfocus();
// // // // //               BlocProvider.of<ParkingDetailsCubit>(context).submitForm(
// // // // //                 isSaveOnly: true,
// // // // //               );
// // // // //             },
// // // // //             onTapSubmit: () {
// // // // //               FocusScope.of(context).unfocus();
// // // // //               BlocProvider.of<ParkingDetailsCubit>(context).submitForm(
// // // // //                 isSaveOnly: false,
// // // // //               );
// // // // //             },
// // // // //           ),
// // // // //           backgroundColor: Colors.transparent,
// // // // //           body: getBodybuilder(state, height),
// // // // //         );
// // // // //       },
// // // // //     ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
// // // // //   }
// // // // //
// // // // //
// // // // //   getBodybuilder(ParkingDetailsState state, height) {
// // // // //     customerVisitorsController.text = state.model.customerVisitors?.toString() ?? '';
// // // // //     empVisitorsController.text = state.model.employeeVisitors?.toString() ?? '';
// // // // //     totalVisitorsController.text = state.model.totalVisitors?.toString() ?? '';
// // // // //     empHeadCountController.text = state.model.employeeHeadCount?.toString() ?? '';
// // // // //     totalParkingSlotsController.text = state.model.totalParkingSlots?.toString() ?? '';
// // // // //     occParkingSlotsController.text = state.model.occupiedParkingSlots?.toString() ?? '';
// // // // //     availableParkingSlotsController.text = state.model.availableParkingSlots?.toString() ?? '';
// // // // //     parkingUtilizationPercentController.text = state.model.parkingUtilizationPercent?.toString() ?? '';
// // // // //     remarksController.text = state.model.remarks?.toString() ?? '';
// // // // //     externalParkingController.text = state.model.externalParkingRequired?.toString() ?? '';
// // // // //     if (state.status == FormStatus.loading) {
// // // // //       return const BaseLoader();
// // // // //     }
// // // // //
// // // // //     return SizedBox(
// // // // //         width: double.infinity,
// // // // //         height: height,
// // // // //         child:  Stack(
// // // // //       children: [
// // // // //         //  Background Image
// // // // //         Positioned.fill(
// // // // //           child: Image.asset(
// // // // //             'assets/images/bg2.png',
// // // // //             fit: BoxFit.cover,
// // // // //           ),
// // // // //         ),
// // // // //
// // // // //         //  Blur Layer
// // // // //         Positioned.fill(
// // // // //           child: BackdropFilter(
// // // // //             filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
// // // // //             child: Container(
// // // // //               color: Colors.black.withValues(alpha: 0.08), // optional tint
// // // // //             ),
// // // // //           ),
// // // // //         ),
// // // // //
// // // // //         SingleChildScrollView(
// // // // //           child: Column(
// // // // //             children: [
// // // // //               Container(
// // // // //                 color: Colors.transparent,
// // // // //                 child: Column(
// // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                   mainAxisAlignment: MainAxisAlignment.start,
// // // // //                   mainAxisSize: MainAxisSize.max,
// // // // //                   children: [
// // // // //                     AbsorbPointer(
// // // // //                       absorbing: isReadOnly,
// // // // //                       child: Form(
// // // // //                         key: _formKey,
// // // // //                         autovalidateMode: isReadOnly
// // // // //                             ? AutovalidateMode.disabled
// // // // //                             : AutovalidateMode.onUserInteraction,
// // // // //                         child: Padding(
// // // // //                           padding: const EdgeInsets.only(left: 20.0, right: 20),
// // // // //                           child: Column(
// // // // //                             children: [
// // // // //                               // if (!state.model.lock.isEmptyOrNull) ...[
// // // // //                               //   RecordLockedWidget(text: '${state.model.lock}'),
// // // // //                               // ],
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // // //                               Container(
// // // // //                                 alignment: Alignment.topLeft,
// // // // //                                 child: const Text(
// // // // //                                   Constants.generalinformation,
// // // // //                                   style: Styles.textStyleRegularNormalWhite18,
// // // // //                                 ),
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // // //
// // // // //                               ///Status
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 // state.labels?.locale.status ??
// // // // //                                 //     state.labels?.defaultLocale.status ??
// // // // //                                     Constants.status,
// // // // //                                 Styles.textStyleWhite16,
// // // // //                                 isMandatory: true,
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               FlutterInputField(
// // // // //                                 isEnable: false,
// // // // //                                 isDisableColor: true,
// // // // //                                 textFormKey: Keys.statusTextController,
// // // // //                                 hintText: '',
// // // // //                                 initialValue: Utils().parkingStatus(
// // // // //                                     state.model.status ?? 0,
// // // // //                                     returnTextOnly: true),
// // // // //                                 onChange: (String value) {},
// // // // //                                 validateTextField: (String? user) {},
// // // // //                               ),
// // // // //
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //                               ///Date of Creation
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 // state.labels?.locale.inputDate ??
// // // // //                                 //     state.labels?.defaultLocale.inputDate ??
// // // // //                                     Constants.dateofcreation,
// // // // //                                 Styles.textStyleWhite16,
// // // // //                                 isMandatory: true,
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               dateCreateWidgetDisplay(
// // // // //                                   state.model.inputDate ?? ''),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //                               ///Created By
// // // // //                               CommonWidgets.horizontalTextHandling(
// // // // //                                 // state.labels?.locale.entrySecurity ??
// // // // //                                 //     state.labels?.defaultLocale.entrySecurity ??
// // // // //                                     Constants.createdby,
// // // // //                                 '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}',
// // // // //                                 isMandatory: true,
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //                               ///Location
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 // state.labels?.locale.location ??
// // // // //                                 //     state.labels?.defaultLocale.location ??
// // // // //                                     Constants.location,
// // // // //                                 Styles.textStyleWhite16,
// // // // //                                 isMandatory: true,
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               BaseLocationDropdown().locationWidgetDisplay(
// // // // //                                   context: context,
// // // // //                                   isEnabled: !isReadOnly,
// // // // //                                   locations: state.locations ?? Locations(),
// // // // //                                   selectedLocationName:
// // // // //                                   state.model.location?.name ?? '',
// // // // //                                   onTap: (Organisation? location) {
// // // // //                                     // BlocProvider.of<ParkingDetailsCubit>(
// // // // //                                     //     context)
// // // // //                                     //     .updateLocationDropdownValue(
// // // // //                                     //     location: location);
// // // // //                                   }),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //
// // // // //
// // // // //                               /// Customers Visitors
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                   // state.labels?.locale.dbOfficialEmail ??
// // // // //                                   //     state.labels?.defaultLocale
// // // // //                                   //         .dbOfficialEmail ??
// // // // //                                       Constants.customerVisitors,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite16),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               FlutterInputField(
// // // // //                                 controller: customerVisitorsController,
// // // // //                                 textInputType: TextInputType.number,
// // // // //                                 textFormKey: Keys.contactNoKey,
// // // // //                                 hintText: '',
// // // // //                                 isEnable: !isReadOnly,
// // // // //                                 isDisableColor: isReadOnly,
// // // // //                                 onChange: (int value) {
// // // // //                                   state.model.customerVisitors = value;
// // // // //                                 },
// // // // //                                 validateTextField: (String? user) {},
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //                               /// Employee Visitors
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 // state.labels?.locale.dbOfficialEmail ??
// // // // //                                 //     state.labels?.defaultLocale
// // // // //                                 //         .dbOfficialEmail ??
// // // // //                                   Constants.empVisitors,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite16),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               FlutterInputField(
// // // // //                                 controller: empVisitorsController,
// // // // //                                 textInputType: TextInputType.number,
// // // // //                                 textFormKey: Keys.contactNoKey,
// // // // //                                 hintText: '',
// // // // //                                 isEnable: !isReadOnly,
// // // // //                                 isDisableColor: isReadOnly,
// // // // //                                 onChange: (int value) {
// // // // //                                   state.model.employeeVisitors = value;
// // // // //                                 },
// // // // //                                 validateTextField: (String? user) {},
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //                               /// Total Visitors
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 // state.labels?.locale.dbOfficialEmail ??
// // // // //                                 //     state.labels?.defaultLocale
// // // // //                                 //         .dbOfficialEmail ??
// // // // //                                   Constants.totalVisitors,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite16),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               FlutterInputField(
// // // // //                                 controller: totalVisitorsController,
// // // // //                                 textInputType: TextInputType.number,
// // // // //                                 textFormKey: Keys.contactNoKey,
// // // // //                                 hintText: '',
// // // // //                                 isEnable: !isReadOnly,
// // // // //                                 isDisableColor: isReadOnly,
// // // // //                                 onChange: (int value) {
// // // // //                                   state.model.totalVisitors = value;
// // // // //                                 },
// // // // //                                 validateTextField: (String? user) {},
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //                               ///Employee Head Count
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 // state.labels?.locale.dbOfficialEmail ??
// // // // //                                 //     state.labels?.defaultLocale
// // // // //                                 //         .dbOfficialEmail ??
// // // // //                                   Constants.empHeadCount,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite16),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               FlutterInputField(
// // // // //                                 controller: empHeadCountController,
// // // // //                                 textInputType: TextInputType.number,
// // // // //                                 textFormKey: Keys.contactNoKey,
// // // // //                                 hintText: '',
// // // // //                                 isEnable: !isReadOnly,
// // // // //                                 isDisableColor: isReadOnly,
// // // // //                                 onChange: (int value) {
// // // // //                                   state.model.employeeHeadCount = value;
// // // // //                                 },
// // // // //                                 validateTextField: (String? user) {},
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //                               ///Total Parking Slots
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 // state.labels?.locale.dbOfficialEmail ??
// // // // //                                 //     state.labels?.defaultLocale
// // // // //                                 //         .dbOfficialEmail ??
// // // // //                                   Constants.totalParkingSlots,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite16),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               FlutterInputField(
// // // // //                                 controller: totalParkingSlotsController,
// // // // //                                 textInputType: TextInputType.number,
// // // // //                                 textFormKey: Keys.contactNoKey,
// // // // //                                 hintText: '',
// // // // //                                 isEnable: !isReadOnly,
// // // // //                                 isDisableColor: isReadOnly,
// // // // //                                 onChange: (int value) {
// // // // //                                   state.model.totalParkingSlots = value;
// // // // //                                 },
// // // // //                                 validateTextField: (String? user) {},
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //                               ///Occupied Parking Slots
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 // state.labels?.locale.dbOfficialEmail ??
// // // // //                                 //     state.labels?.defaultLocale
// // // // //                                 //         .dbOfficialEmail ??
// // // // //                                   Constants.occParkingSlots,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite16),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               FlutterInputField(
// // // // //                                 controller: occParkingSlotsController,
// // // // //                                 textInputType: TextInputType.number,
// // // // //                                 textFormKey: Keys.contactNoKey,
// // // // //                                 hintText: '',
// // // // //                                 isEnable: !isReadOnly,
// // // // //                                 isDisableColor: isReadOnly,
// // // // //                                 onChange: (int value) {
// // // // //                                   state.model.occupiedParkingSlots = value;
// // // // //                                 },
// // // // //                                 validateTextField: (String? user) {},
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //                               ///Available Parking Slots
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 // state.labels?.locale.dbOfficialEmail ??
// // // // //                                 //     state.labels?.defaultLocale
// // // // //                                 //         .dbOfficialEmail ??
// // // // //                                   Constants.availableParkingSlots,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite16),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               FlutterInputField(
// // // // //                                 controller: availableParkingSlotsController,
// // // // //                                 textInputType: TextInputType.number,
// // // // //                                 textFormKey: Keys.contactNoKey,
// // // // //                                 hintText: '',
// // // // //                                 isEnable: !isReadOnly,
// // // // //                                 isDisableColor: isReadOnly,
// // // // //                                 onChange: (int value) {
// // // // //                                   state.model.availableParkingSlots = value;
// // // // //                                 },
// // // // //                                 validateTextField: (String? user) {},
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //                               ///Parking utilization %
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 // state.labels?.locale.dbOfficialEmail ??
// // // // //                                 //     state.labels?.defaultLocale
// // // // //                                 //         .dbOfficialEmail ??
// // // // //                                   Constants.parkingUtilizationPercent,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite16),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               FlutterInputField(
// // // // //                                 controller: parkingUtilizationPercentController,
// // // // //                                 textInputType: TextInputType.number,
// // // // //                                 textFormKey: Keys.contactNoKey,
// // // // //                                 hintText: '',
// // // // //                                 isEnable: !isReadOnly,
// // // // //                                 isDisableColor: isReadOnly,
// // // // //                                 onChange: (double value) {
// // // // //                                   state.model.parkingUtilizationPercent = value;
// // // // //                                 },
// // // // //                                 validateTextField: (String? user) {},
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //
// // // // //
// // // // //                               ///External parking Required
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 // state.labels?.locale.dbOfficialEmail ??
// // // // //                                 //     state.labels?.defaultLocale
// // // // //                                 //         .dbOfficialEmail ??
// // // // //                                   Constants.externalParkingRequired,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite16),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               FlutterInputField(
// // // // //                                 controller: externalParkingController,
// // // // //                                 textInputType: TextInputType.number,
// // // // //                                 textFormKey: Keys.contactNoKey,
// // // // //                                 hintText: '',
// // // // //                                 isEnable: !isReadOnly,
// // // // //                                 isDisableColor: isReadOnly,
// // // // //                                 onChange: (int value) {
// // // // //                                   state.model.externalParkingRequired = value;
// // // // //                                 },
// // // // //                                 validateTextField: (String? user) {},
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //
// // // // //                               ///Remarks
// // // // //                               CommonWidgets.textDisplay(
// // // // //                                 // state.labels?.locale.dbOfficialEmail ??
// // // // //                                 //     state.labels?.defaultLocale
// // // // //                                 //         .dbOfficialEmail ??
// // // // //                                   Constants.remarks,
// // // // //                                   isMandatory: true,
// // // // //                                   Styles.textStyleWhite16),
// // // // //                               CommonWidgets.verticalSpacerWidget(
// // // // //                                   height * 0.001),
// // // // //                               FlutterInputField(
// // // // //                                 controller: remarksController,
// // // // //                                 textInputType: TextInputType.number,
// // // // //                                 textFormKey: Keys.contactNoKey,
// // // // //                                 hintText: '',
// // // // //                                 isEnable: !isReadOnly,
// // // // //                                 isDisableColor: isReadOnly,
// // // // //                                 onChange: (String value) {
// // // // //                                   state.model.remarks = value;
// // // // //                                 },
// // // // //                                 validateTextField: (String? user) {},
// // // // //                               ),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //                               CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // // //
// // // // //
// // // // //
// // // // //                               // if (state.model.id != null) ...[
// // // // //                               //   /// Modified Date
// // // // //                               //   CommonWidgets.textDisplay(
// // // // //                               //     // state.labels?.locale.date ??
// // // // //                               //     //     state.labels?.defaultLocale.date ??
// // // // //                               //     Constants.modifiedOn,
// // // // //                               //     Styles.textStyleWhite16,
// // // // //                               //     isMandatory: true,
// // // // //                               //   ),
// // // // //                               //   CommonWidgets.verticalSpacerWidget(
// // // // //                               //       height * 0.001),
// // // // //                               //   datecreateWidgetdisplay(
// // // // //                               //       state.model.modifiedDate ?? ''),
// // // // //                               //   CommonWidgets.verticalSpacerWidget(
// // // // //                               //       height * 0.02),
// // // // //                               //
// // // // //                               //   /// Modified By
// // // // //                               //   CommonWidgets.horizontalTextHandling(
// // // // //                               //     // state.labels?.locale.entrySecurity ??
// // // // //                               //     //     state.labels?.defaultLocale.entrySecurity ??
// // // // //                               //       Constants.modifiedBy,
// // // // //                               //       isMandatory: true,
// // // // //                               //       state.model.modifiedBy ?? ''),
// // // // //                               //   CommonWidgets.verticalSpacerWidget(
// // // // //                               //       height * 0.01),
// // // // //                               // ],
// // // // //                             ],
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
// // // // //
// // // // //                     /// SubmitButton
// // // // //                     Row(
// // // // //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // //                       children: [
// // // // //
// // // // //                           cancelButtonDisplay(),
// // // // //                         if ((!isReadOnly)) ...[
// // // // //                           submitButtonDisplay()
// // // // //                         ],
// // // // //                       ],
// // // // //                     ),
// // // // //                     CommonWidgets.verticalSpacerWidget(height * 0.04),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //               CommonWidgets.verticalSpacerWidget(height * 0.04),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ],
// // // // //         ));
// // // // //   }
// // // // //
// // // // //   Widget cancelButtonDisplay() {
// // // // //     return AppButton(
// // // // //       width: Constants.cancelButtonWidth,
// // // // //       backgroundColor: Colors.white,
// // // // //       key: const Key(Keys.cancelButton),
// // // // //       buttonText: Constants.close,
// // // // //       buttonTextKey: Keys.cancelButton,
// // // // //       onTap: () {
// // // // //         Navigator.pop(context);
// // // // //         CommonServices().unlock();
// // // // //       },
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget submitButtonDisplay() {
// // // // //     return AppButton(
// // // // //       width: 150,
// // // // //       key: const Key(Keys.submitButton),
// // // // //       buttonText: Constants.submit,
// // // // //       buttonTextKey: Keys.submitButton,
// // // // //       onTap: () async {
// // // // //         FocusScope.of(context).unfocus();
// // // // //
// // // // //         BlocProvider.of<ParkingDetailsCubit>(context).submitForm();
// // // // //       },
// // // // //     );
// // // // //   }
// // // // //
// // // // //
// // // // //   Widget dateCreateWidgetDisplay(String date) {
// // // // //     return FlutterInputField(
// // // // //       textFormKey: Keys.dateofcreationTextController,
// // // // //       initialValue: date,
// // // // //       hintText: '',
// // // // //       isEnable: false,
// // // // //       isDisableColor: true,
// // // // //       onChange: (String value) {},
// // // // //       validateTextField: (String? user) {},
// // // // //     );
// // // // //   }
// // // // // }
// // // //
// // // // import 'dart:developer';
// // // // import 'dart:ui';
// // // //
// // // // import 'package:db_atom/index.dart';
// // // // import 'package:db_atom/src/features/parking/models/parking_model.dart';
// // // // import 'package:db_atom/src/features/parking/parking_details/cubits/parking_details_cubit.dart';
// // // //
// // // // class ParkingDetailsView extends StatefulWidget {
// // // //   final ParkingModel? model;
// // // //   final String title;
// // // //   final ExtraProperties? extraProperties;
// // // //
// // // //   const ParkingDetailsView({
// // // //     super.key,
// // // //     this.model,
// // // //     required this.title,
// // // //     this.extraProperties,
// // // //   });
// // // //
// // // //   @override
// // // //   State<ParkingDetailsView> createState() =>
// // // //       _ParkingDetailsViewState();
// // // // }
// // // //
// // // // class _ParkingDetailsViewState
// // // //     extends State<ParkingDetailsView> {
// // // //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// // // //   User? userDetails;
// // // //   TextEditingController statusController = TextEditingController();
// // // //   TextEditingController timeOfVisitController = TextEditingController();
// // // //   TextEditingController customerVisitorsController =
// // // //   TextEditingController();
// // // //   TextEditingController empVisitorsController = TextEditingController();
// // // //   TextEditingController totalVisitorsController = TextEditingController();
// // // //   TextEditingController empHeadCountController = TextEditingController();
// // // //   TextEditingController totalParkingSlotsController = TextEditingController();
// // // //   TextEditingController occParkingSlotsController = TextEditingController();
// // // //   TextEditingController availableParkingSlotsController = TextEditingController();
// // // //   TextEditingController parkingUtilizationPercentController = TextEditingController();
// // // //   TextEditingController remarksController = TextEditingController();
// // // //   TextEditingController externalParkingController = TextEditingController();
// // // //
// // // //   // Basement Parking Levels row controllers (index 0 = Basement 1 ... 3 = Basement 4)
// // // //   static const int _levelRowCount = 4;
// // // //   final List<TextEditingController> levelTotalControllers =
// // // //   List.generate(_levelRowCount, (_) => TextEditingController());
// // // //   final List<TextEditingController> levelOccupiedControllers =
// // // //   List.generate(_levelRowCount, (_) => TextEditingController());
// // // //   final List<TextEditingController> levelAvailableControllers =
// // // //   List.generate(_levelRowCount, (_) => TextEditingController());
// // // //   final List<TextEditingController> levelUtilizationControllers =
// // // //   List.generate(_levelRowCount, (_) => TextEditingController());
// // // //   final List<TextEditingController> levelRemarksControllers =
// // // //   List.generate(_levelRowCount, (_) => TextEditingController());
// // // //
// // // //   List<ImageContent> uploadFiles = [];
// // // //
// // // //   bool isReadOnly = false;
// // // //
// // // //   get model => null;
// // // //
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     BlocProvider.of<ParkingDetailsCubit>(context).initializeValues();
// // // //     // initializeDates(state);
// // // //   }
// // // //
// // // //   @override
// // // //   void dispose() {
// // // //     for (final c in levelTotalControllers) {
// // // //       c.dispose();
// // // //     }
// // // //     for (final c in levelOccupiedControllers) {
// // // //       c.dispose();
// // // //     }
// // // //     for (final c in levelAvailableControllers) {
// // // //       c.dispose();
// // // //     }
// // // //     for (final c in levelUtilizationControllers) {
// // // //       c.dispose();
// // // //     }
// // // //     for (final c in levelRemarksControllers) {
// // // //       c.dispose();
// // // //     }
// // // //     super.dispose();
// // // //   }
// // // //
// // // //   /// Recalculates Available Slots and Utilization % for a given basement
// // // //   /// row after Total Slots / Occupied Slots changes, and refreshes the UI.
// // // //   void _recalculateLevel(ParkingDetailsState state, int index) {
// // // //     final levels = state.model.parkingLevels;
// // // //     if (levels == null || index >= levels.length) return;
// // // //
// // // //     final total = levels[index].totalSlots ?? 0;
// // // //     final occupied = levels[index].occupiedSlots ?? 0;
// // // //     final available = total - occupied;
// // // //     final utilization = total > 0 ? (occupied / total) * 100 : 0.0;
// // // //
// // // //     levels[index].availableSlots = available < 0 ? 0 : available;
// // // //     levels[index].utilizationPercent =
// // // //         double.parse(utilization.toStringAsFixed(2));
// // // //
// // // //     setState(() {
// // // //       levelAvailableControllers[index].text =
// // // //           levels[index].availableSlots.toString();
// // // //       levelUtilizationControllers[index].text =
// // // //           levels[index].utilizationPercent!.toStringAsFixed(2);
// // // //     });
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final size = MediaQuery.of(context).size;
// // // //     double height = size.height;
// // // //     return BlocConsumer<ParkingDetailsCubit, ParkingDetailsState>(
// // // //       listener: (context, state) {
// // // //         log('-state.status---${state.status}----');
// // // //         Utils().formError(state, context);
// // // //         Utils().errorAndLogout(state, context);
// // // //         if (state.status == FormStatus.success) {
// // // //           var dialog = CustomAlertDialog(
// // // //             title: 'Parking',
// // // //             message: state.message ?? '',
// // // //             positiveBtnText: Constants.ok,
// // // //             onPositivePressed: () {
// // // //               Navigator.pop(context);
// // // //               Navigator.pop(context);
// // // //               Navigator.popAndPushNamed(context, parkingListRoute);
// // // //             },
// // // //           );
// // // //           showDialog(
// // // //               context: context,
// // // //               barrierDismissible: false,
// // // //               builder: (BuildContext context) => dialog);
// // // //         }
// // // //       },
// // // //       builder: (context, state) {
// // // //
// // // //         if (state.model.status == 1) {
// // // //           isReadOnly = false;
// // // //         }
// // // //         if (state.model.status == -1) {
// // // //           isReadOnly = false;
// // // //         }
// // // //
// // // //         // if (widget.extraProperties != null &&
// // // //         //     !widget.extraProperties!.hasWritePermission!) {
// // // //         //   isReadOnly = true;
// // // //         // }
// // // //         return Scaffold(
// // // //           appBar: BaseAppBar().buildAppHeader(
// // // //             context: context,
// // // //             title: widget.title,
// // // //             showPopUp: false,
// // // //             pdfAPIName:
// // // //             '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.leoModuleCode}',
// // // //             showSaveButton:
// // // //             !isReadOnly,
// // // //             showSubmitButton:
// // // //             !isReadOnly,
// // // //             showDisLikeButton: false,
// // // //             showLikeButton: false,
// // // //             onTapSave: () {
// // // //               FocusScope.of(context).unfocus();
// // // //               BlocProvider.of<ParkingDetailsCubit>(context).submitForm(
// // // //                 isSaveOnly: true,
// // // //               );
// // // //             },
// // // //             onTapSubmit: () {
// // // //               FocusScope.of(context).unfocus();
// // // //               BlocProvider.of<ParkingDetailsCubit>(context).submitForm(
// // // //                 isSaveOnly: false,
// // // //               );
// // // //             },
// // // //           ),
// // // //           backgroundColor: Colors.transparent,
// // // //           body: getBodybuilder(state, height),
// // // //         );
// // // //       },
// // // //     ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
// // // //   }
// // // //
// // // //
// // // //   getBodybuilder(ParkingDetailsState state, height) {
// // // //     customerVisitorsController.text = state.model.customerVisitors?.toString() ?? '';
// // // //     empVisitorsController.text = state.model.employeeVisitors?.toString() ?? '';
// // // //     totalVisitorsController.text = state.model.totalVisitors?.toString() ?? '';
// // // //     empHeadCountController.text = state.model.employeeHeadCount?.toString() ?? '';
// // // //     totalParkingSlotsController.text = state.model.totalParkingSlots?.toString() ?? '';
// // // //     occParkingSlotsController.text = state.model.occupiedParkingSlots?.toString() ?? '';
// // // //     availableParkingSlotsController.text = state.model.availableParkingSlots?.toString() ?? '';
// // // //     parkingUtilizationPercentController.text = state.model.parkingUtilizationPercent?.toString() ?? '';
// // // //     remarksController.text = state.model.remarks?.toString() ?? '';
// // // //     externalParkingController.text = state.model.externalParkingRequired?.toString() ?? '';
// // // //
// // // //     // Sync basement level row controllers from the model
// // // //     final levels = state.model.parkingLevels ?? [];
// // // //     for (int i = 0; i < _levelRowCount && i < levels.length; i++) {
// // // //       levelTotalControllers[i].text = levels[i].totalSlots?.toString() ?? '';
// // // //       levelOccupiedControllers[i].text = levels[i].occupiedSlots?.toString() ?? '';
// // // //       levelAvailableControllers[i].text = levels[i].availableSlots?.toString() ?? '0';
// // // //       levelUtilizationControllers[i].text = levels[i].utilizationPercent != null
// // // //           ? levels[i].utilizationPercent!.toStringAsFixed(2)
// // // //           : '0.00';
// // // //       levelRemarksControllers[i].text = levels[i].remarks ?? '';
// // // //     }
// // // //
// // // //     if (state.status == FormStatus.loading) {
// // // //       return const BaseLoader();
// // // //     }
// // // //
// // // //     return SizedBox(
// // // //         width: double.infinity,
// // // //         height: height,
// // // //         child:  Stack(
// // // //           children: [
// // // //             //  Background Image
// // // //             Positioned.fill(
// // // //               child: Image.asset(
// // // //                 'assets/images/bg2.png',
// // // //                 fit: BoxFit.cover,
// // // //               ),
// // // //             ),
// // // //
// // // //             //  Blur Layer
// // // //             Positioned.fill(
// // // //               child: BackdropFilter(
// // // //                 filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
// // // //                 child: Container(
// // // //                   color: Colors.black.withValues(alpha: 0.08), // optional tint
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //
// // // //             SingleChildScrollView(
// // // //               child: Column(
// // // //                 children: [
// // // //                   Container(
// // // //                     color: Colors.transparent,
// // // //                     child: Column(
// // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // //                       mainAxisAlignment: MainAxisAlignment.start,
// // // //                       mainAxisSize: MainAxisSize.max,
// // // //                       children: [
// // // //                         AbsorbPointer(
// // // //                           absorbing: isReadOnly,
// // // //                           child: Form(
// // // //                             key: _formKey,
// // // //                             autovalidateMode: isReadOnly
// // // //                                 ? AutovalidateMode.disabled
// // // //                                 : AutovalidateMode.onUserInteraction,
// // // //                             child: Padding(
// // // //                               padding: const EdgeInsets.only(left: 20.0, right: 20),
// // // //                               child: Column(
// // // //                                 children: [
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // //                                   Container(
// // // //                                     alignment: Alignment.topLeft,
// // // //                                     child: const Text(
// // // //                                       Constants.generalinformation,
// // // //                                       style: Styles.textStyleRegularNormalWhite18,
// // // //                                     ),
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // //
// // // //                                   ///Status
// // // //                                   CommonWidgets.textDisplay(
// // // //                                     Constants.status,
// // // //                                     Styles.textStyleWhite16,
// // // //                                     isMandatory: true,
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   FlutterInputField(
// // // //                                     isEnable: false,
// // // //                                     isDisableColor: true,
// // // //                                     textFormKey: Keys.statusTextController,
// // // //                                     hintText: '',
// // // //                                     initialValue: Utils().parkingStatus(
// // // //                                         state.model.status ?? 0,
// // // //                                         returnTextOnly: true),
// // // //                                     onChange: (String value) {},
// // // //                                     validateTextField: (String? user) {},
// // // //                                   ),
// // // //
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   ///Date of Creation
// // // //                                   CommonWidgets.textDisplay(
// // // //                                     Constants.dateofcreation,
// // // //                                     Styles.textStyleWhite16,
// // // //                                     isMandatory: true,
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   dateCreateWidgetDisplay(
// // // //                                       state.model.inputDate ?? ''),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   ///Created By
// // // //                                   CommonWidgets.horizontalTextHandling(
// // // //                                     Constants.createdby,
// // // //                                     '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}',
// // // //                                     isMandatory: true,
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   ///Location
// // // //                                   CommonWidgets.textDisplay(
// // // //                                     Constants.location,
// // // //                                     Styles.textStyleWhite16,
// // // //                                     isMandatory: true,
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   BaseLocationDropdown().locationWidgetDisplay(
// // // //                                       context: context,
// // // //                                       isEnabled: !isReadOnly,
// // // //                                       locations: state.locations ?? Locations(),
// // // //                                       selectedLocationName:
// // // //                                       state.model.location?.name ?? '',
// // // //                                       onTap: (Organisation? location) {}),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   /// Customers Visitors
// // // //                                   CommonWidgets.textDisplay(
// // // //                                       Constants.customerVisitors,
// // // //                                       isMandatory: true,
// // // //                                       Styles.textStyleWhite16),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   FlutterInputField(
// // // //                                     controller: customerVisitorsController,
// // // //                                     textInputType: TextInputType.number,
// // // //                                     textFormKey: Keys.contactNoKey,
// // // //                                     hintText: '',
// // // //                                     isEnable: !isReadOnly,
// // // //                                     isDisableColor: isReadOnly,
// // // //                                     onChange: (int value) {
// // // //                                       state.model.customerVisitors = value;
// // // //                                     },
// // // //                                     validateTextField: (String? user) {},
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   /// Employee Visitors
// // // //                                   CommonWidgets.textDisplay(
// // // //                                       Constants.empVisitors,
// // // //                                       isMandatory: true,
// // // //                                       Styles.textStyleWhite16),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   FlutterInputField(
// // // //                                     controller: empVisitorsController,
// // // //                                     textInputType: TextInputType.number,
// // // //                                     textFormKey: Keys.contactNoKey,
// // // //                                     hintText: '',
// // // //                                     isEnable: !isReadOnly,
// // // //                                     isDisableColor: isReadOnly,
// // // //                                     onChange: (int value) {
// // // //                                       state.model.employeeVisitors = value;
// // // //                                     },
// // // //                                     validateTextField: (String? user) {},
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   /// Total Visitors
// // // //                                   CommonWidgets.textDisplay(
// // // //                                       Constants.totalVisitors,
// // // //                                       isMandatory: true,
// // // //                                       Styles.textStyleWhite16),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   FlutterInputField(
// // // //                                     controller: totalVisitorsController,
// // // //                                     textInputType: TextInputType.number,
// // // //                                     textFormKey: Keys.contactNoKey,
// // // //                                     hintText: '',
// // // //                                     isEnable: !isReadOnly,
// // // //                                     isDisableColor: isReadOnly,
// // // //                                     onChange: (int value) {
// // // //                                       state.model.totalVisitors = value;
// // // //                                     },
// // // //                                     validateTextField: (String? user) {},
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   ///Employee Head Count
// // // //                                   CommonWidgets.textDisplay(
// // // //                                       Constants.empHeadCount,
// // // //                                       isMandatory: true,
// // // //                                       Styles.textStyleWhite16),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   FlutterInputField(
// // // //                                     controller: empHeadCountController,
// // // //                                     textInputType: TextInputType.number,
// // // //                                     textFormKey: Keys.contactNoKey,
// // // //                                     hintText: '',
// // // //                                     isEnable: !isReadOnly,
// // // //                                     isDisableColor: isReadOnly,
// // // //                                     onChange: (int value) {
// // // //                                       state.model.employeeHeadCount = value;
// // // //                                     },
// // // //                                     validateTextField: (String? user) {},
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   ///Total Parking Slots
// // // //                                   CommonWidgets.textDisplay(
// // // //                                       Constants.totalParkingSlots,
// // // //                                       isMandatory: true,
// // // //                                       Styles.textStyleWhite16),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   FlutterInputField(
// // // //                                     controller: totalParkingSlotsController,
// // // //                                     textInputType: TextInputType.number,
// // // //                                     textFormKey: Keys.contactNoKey,
// // // //                                     hintText: '',
// // // //                                     isEnable: !isReadOnly,
// // // //                                     isDisableColor: isReadOnly,
// // // //                                     onChange: (int value) {
// // // //                                       state.model.totalParkingSlots = value;
// // // //                                     },
// // // //                                     validateTextField: (String? user) {},
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   ///Occupied Parking Slots
// // // //                                   CommonWidgets.textDisplay(
// // // //                                       Constants.occParkingSlots,
// // // //                                       isMandatory: true,
// // // //                                       Styles.textStyleWhite16),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   FlutterInputField(
// // // //                                     controller: occParkingSlotsController,
// // // //                                     textInputType: TextInputType.number,
// // // //                                     textFormKey: Keys.contactNoKey,
// // // //                                     hintText: '',
// // // //                                     isEnable: !isReadOnly,
// // // //                                     isDisableColor: isReadOnly,
// // // //                                     onChange: (int value) {
// // // //                                       state.model.occupiedParkingSlots = value;
// // // //                                     },
// // // //                                     validateTextField: (String? user) {},
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   ///Available Parking Slots
// // // //                                   CommonWidgets.textDisplay(
// // // //                                       Constants.availableParkingSlots,
// // // //                                       isMandatory: true,
// // // //                                       Styles.textStyleWhite16),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   FlutterInputField(
// // // //                                     controller: availableParkingSlotsController,
// // // //                                     textInputType: TextInputType.number,
// // // //                                     textFormKey: Keys.contactNoKey,
// // // //                                     hintText: '',
// // // //                                     isEnable: !isReadOnly,
// // // //                                     isDisableColor: isReadOnly,
// // // //                                     onChange: (int value) {
// // // //                                       state.model.availableParkingSlots = value;
// // // //                                     },
// // // //                                     validateTextField: (String? user) {},
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   ///Parking utilization %
// // // //                                   CommonWidgets.textDisplay(
// // // //                                       Constants.parkingUtilizationPercent,
// // // //                                       isMandatory: true,
// // // //                                       Styles.textStyleWhite16),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   FlutterInputField(
// // // //                                     controller: parkingUtilizationPercentController,
// // // //                                     textInputType: TextInputType.number,
// // // //                                     textFormKey: Keys.contactNoKey,
// // // //                                     hintText: '',
// // // //                                     isEnable: !isReadOnly,
// // // //                                     isDisableColor: isReadOnly,
// // // //                                     onChange: (double value) {
// // // //                                       state.model.parkingUtilizationPercent = value;
// // // //                                     },
// // // //                                     validateTextField: (String? user) {},
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   ///External parking Required
// // // //                                   CommonWidgets.textDisplay(
// // // //                                       Constants.externalParkingRequired,
// // // //                                       isMandatory: true,
// // // //                                       Styles.textStyleWhite16),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   FlutterInputField(
// // // //                                     controller: externalParkingController,
// // // //                                     textInputType: TextInputType.number,
// // // //                                     textFormKey: Keys.contactNoKey,
// // // //                                     hintText: '',
// // // //                                     isEnable: !isReadOnly,
// // // //                                     isDisableColor: isReadOnly,
// // // //                                     onChange: (int value) {
// // // //                                       state.model.externalParkingRequired = value;
// // // //                                     },
// // // //                                     validateTextField: (String? user) {},
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   ///Remarks
// // // //                                   CommonWidgets.textDisplay(
// // // //                                       Constants.remarks,
// // // //                                       isMandatory: true,
// // // //                                       Styles.textStyleWhite16),
// // // //                                   CommonWidgets.verticalSpacerWidget(
// // // //                                       height * 0.001),
// // // //                                   FlutterInputField(
// // // //                                     controller: remarksController,
// // // //                                     textInputType: TextInputType.number,
// // // //                                     textFormKey: Keys.contactNoKey,
// // // //                                     hintText: '',
// // // //                                     isEnable: !isReadOnly,
// // // //                                     isDisableColor: isReadOnly,
// // // //                                     onChange: (String value) {
// // // //                                       state.model.remarks = value;
// // // //                                     },
// // // //                                     validateTextField: (String? user) {},
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //
// // // //                                   /// Basement Parking Levels
// // // //                                   Container(
// // // //                                     alignment: Alignment.topLeft,
// // // //                                     child: const Text(
// // // //                                       'Basement Parking Levels',
// // // //                                       style: Styles.textStyleRegularNormalWhite18,
// // // //                                     ),
// // // //                                   ),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.01),
// // // //                                   buildParkingLevelsTable(state),
// // // //                                   CommonWidgets.verticalSpacerWidget(height * 0.02),
// // // //                                 ],
// // // //                               ),
// // // //                             ),
// // // //                           ),
// // // //                         ),
// // // //
// // // //                         /// SubmitButton
// // // //                         Row(
// // // //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // //                           children: [
// // // //
// // // //                             cancelButtonDisplay(),
// // // //                             if ((!isReadOnly)) ...[
// // // //                               submitButtonDisplay()
// // // //                             ],
// // // //                           ],
// // // //                         ),
// // // //                         CommonWidgets.verticalSpacerWidget(height * 0.04),
// // // //                       ],
// // // //                     ),
// // // //                   ),
// // // //                   CommonWidgets.verticalSpacerWidget(height * 0.04),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ));
// // // //   }
// // // //
// // // //   /// Builds the Basement Parking Levels table:
// // // //   /// Basement Level | Total Slots | Occupied Slots | Available Slots (readonly)
// // // //   /// | Utilization % (readonly) | Remarks
// // // //   Widget buildParkingLevelsTable(ParkingDetailsState state) {
// // // //     const double labelColWidth = 120;
// // // //     const double inputColWidth = 150;
// // // //     const List<String> basementLabels = [
// // // //       'Basement 1',
// // // //       'Basement 2',
// // // //       'Basement 3',
// // // //       'Basement 4',
// // // //     ];
// // // //
// // // //     Widget headerCell(String text, double width) => SizedBox(
// // // //       width: width,
// // // //       child: Padding(
// // // //         padding: const EdgeInsets.symmetric(horizontal: 6),
// // // //         child: Text(
// // // //           text,
// // // //           style: Styles.textStyleWhite16,
// // // //         ),
// // // //       ),
// // // //     );
// // // //
// // // //     Widget headerRow = Row(
// // // //       children: [
// // // //         headerCell('Basement Level', labelColWidth),
// // // //         headerCell('Total Slots', inputColWidth),
// // // //         headerCell('Occupied Slots', inputColWidth),
// // // //         headerCell('Available Slots', inputColWidth),
// // // //         headerCell('Utilization %', inputColWidth),
// // // //         headerCell('Remarks', inputColWidth),
// // // //       ],
// // // //     );
// // // //
// // // //     List<Widget> dataRows = List.generate(_levelRowCount, (index) {
// // // //       return Padding(
// // // //         padding: const EdgeInsets.symmetric(vertical: 6),
// // // //         child: Row(
// // // //           crossAxisAlignment: CrossAxisAlignment.center,
// // // //           children: [
// // // //             SizedBox(
// // // //               width: labelColWidth,
// // // //               child: Text(
// // // //                 basementLabels[index],
// // // //                 style: Styles.textStyleWhite16,
// // // //               ),
// // // //             ),
// // // //
// // // //             /// Total Slots (editable)
// // // //             SizedBox(
// // // //               width: inputColWidth,
// // // //               child: FlutterInputField(
// // // //                 controller: levelTotalControllers[index],
// // // //                 textInputType: TextInputType.number,
// // // //                 textFormKey: '${Keys.contactNoKey}_level_total_$index',
// // // //                 hintText: '',
// // // //                 isEnable: !isReadOnly,
// // // //                 isDisableColor: isReadOnly,
// // // //                 onChange: (int value) {
// // // //                   final levels = state.model.parkingLevels;
// // // //                   if (levels != null && index < levels.length) {
// // // //                     levels[index].totalSlots = value;
// // // //                     _recalculateLevel(state, index);
// // // //                   }
// // // //                 },
// // // //                 validateTextField: (String? user) {},
// // // //               ),
// // // //             ),
// // // //             const SizedBox(width: 8),
// // // //
// // // //             /// Occupied Slots (editable)

import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/parking/models/parking_model.dart';
import 'package:db_atom/src/features/parking/parking_details/cubits/parking_details_cubit.dart';

class ParkingDetailsView extends StatefulWidget {
  final ParkingModel? model;
  final String title;
  final ExtraProperties? extraProperties;

  const ParkingDetailsView({
    super.key,
    this.model,
    required this.title,
    this.extraProperties,
  });

  @override
  State<ParkingDetailsView> createState() => _ParkingDetailsViewState();
}

class _ParkingDetailsViewState extends State<ParkingDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? userDetails;
  TextEditingController statusController = TextEditingController();
  TextEditingController timeOfVisitController = TextEditingController();
  TextEditingController customerVisitorsController = TextEditingController();
  TextEditingController empVisitorsController = TextEditingController();
  TextEditingController totalVisitorsController = TextEditingController();
  TextEditingController empHeadCountController = TextEditingController();
  TextEditingController totalParkingSlotsController = TextEditingController();
  TextEditingController occParkingSlotsController = TextEditingController();
  TextEditingController availableParkingSlotsController =
  TextEditingController();
  TextEditingController parkingUtilizationPercentController =
  TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController externalParkingController = TextEditingController();
  TextEditingController demandStatusController=TextEditingController();
  // Basement Parking Levels row controllers (index 0 = Basement 1 ... 3 = Basement 4)
  static const int _levelRowCount = 4;
  final List<TextEditingController> levelTotalControllers =
  List.generate(_levelRowCount, (_) => TextEditingController());
  final List<TextEditingController> levelOccupiedControllers =
  List.generate(_levelRowCount, (_) => TextEditingController());
  final List<TextEditingController> levelAvailableControllers =
  List.generate(_levelRowCount, (_) => TextEditingController());
  final List<TextEditingController> levelUtilizationControllers =
  List.generate(_levelRowCount, (_) => TextEditingController());
  final List<TextEditingController> levelRemarksControllers =
  List.generate(_levelRowCount, (_) => TextEditingController());

  // ---- Basement table layout / palette (matches the reference screenshot) --
  static const double _labelColWidth = 200;
  static const double _inputColWidth = 210;
  static const double _fieldHeight = 44;
  static const List<String> _basementLabels = [
    'Basement 1',
    'Basement 2',
    'Basement 3',
    'Basement 4',
  ];

  List<ImageContent> uploadFiles = [];

  bool isReadOnly = false;

  /// True while WE are writing into a controller from code (see [_setText]).
  bool _isSyncing = false;

  /// The last cubit state the controllers were filled from.
  ParkingDetailsState? _hydratedState;

  @override
  void initState() {
    super.initState();
    customerVisitorsController.addListener(_onVisitorsChanged);
    empVisitorsController.addListener(_onVisitorsChanged);
    BlocProvider.of<ParkingDetailsCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    customerVisitorsController.removeListener(_onVisitorsChanged);
    empVisitorsController.removeListener(_onVisitorsChanged);

    final controllers = <TextEditingController>[
      statusController,
      timeOfVisitController,
      customerVisitorsController,
      empVisitorsController,
      totalVisitorsController,
      empHeadCountController,
      totalParkingSlotsController,
      occParkingSlotsController,
      availableParkingSlotsController,
      parkingUtilizationPercentController,
      remarksController,
      externalParkingController,
      ...levelTotalControllers,
      ...levelOccupiedControllers,
      ...levelAvailableControllers,
      ...levelUtilizationControllers,
      ...levelRemarksControllers,
    ];
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  // ===========================================================================
  // THE FIX: the basement rows must always exist before anything reads them.
  // On a NEW record the API returns no parkingLevels, so the list was null and
  // every onChanged handler silently returned without writing to the model —
  // which is why Available / Utilization / the form totals stayed at 0.
  // ===========================================================================

  /// Builds an empty basement row, tagged with its level name so the backend
  /// can tell the four rows apart on create.
  ParkingLevelModel _newLevel(int index) {
    return ParkingLevelModel(
      parkingLevel: _basementLabels[index],
      totalSlots: null,
      occupiedSlots: null,
      availableSlots: 0,
      utilizationPercent: null,
    );
  }

  /// Guarantees `state.model.parkingLevels` is non-null and has exactly
  /// [_levelRowCount] rows, then returns it. Safe to call from build().
  List<ParkingLevelModel> _ensureLevels(ParkingDetailsState state) {
    var levels = state.model.parkingLevels;
    if (levels == null) {
      levels = <ParkingLevelModel>[];
      state.model.parkingLevels = levels;
    }
    while (levels.length < _levelRowCount) {
      levels.add(_newLevel(levels.length));
    }
    // Backfill the label on rows that came back from the API without one.
    for (int i = 0; i < _levelRowCount; i++) {
      levels[i].parkingLevel ??= _basementLabels[i];
    }
    return levels;
  }

  /// Converts a `0` value to `null` so the payload sends `null` instead of a
  /// literal zero for Parking Level fields (Total / Occupied / Available
  /// Slots and Utilization %).
  int? _zeroToNullInt(int value) => value == 0 ? null : value;

  double? _zeroToNullDouble(double value) => value == 0 ? null : value;

  /// Assigns [value] to [controller] only when it actually differs, and keeps
  /// the caret at the end.
  void _setText(TextEditingController controller, String value) {
    if (controller.text == value) return;
    final wasSyncing = _isSyncing;
    _isSyncing = true;
    controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
    _isSyncing = wasSyncing;
  }

  /// Fires whenever the user edits Customer Visitors or Employee Visitors.
  void _onVisitorsChanged() {
    if (_isSyncing || !mounted) return;

    final state = BlocProvider.of<ParkingDetailsCubit>(context).state;
    final customer = int.tryParse(customerVisitorsController.text.trim()) ?? 0;
    final employee = int.tryParse(empVisitorsController.text.trim()) ?? 0;

    // Ignore cursor / selection-only changes.
    if (state.model.customerVisitors == customer &&
        state.model.employeeVisitors == employee) {
      return;
    }

    setState(() {
      state.model.customerVisitors = customer;
      state.model.employeeVisitors = employee;
      _recalculateFormTotals(state);
    });
  }

  /// Fills every controller from the model. Called only when the cubit emits
  /// a new state (initial load, after save/submit, errors, etc.).
  void _hydrateControllers(ParkingDetailsState state) {
    _setText(customerVisitorsController,
        state.model.customerVisitors?.toString() ?? '');
    _setText(
        empVisitorsController, state.model.employeeVisitors?.toString() ?? '');
    _setText(empHeadCountController,
        state.model.employeeHeadCount?.toString() ?? '');
    _setText(remarksController, state.model.remarks?.toString() ?? '');
    _setText(externalParkingController,
        state.model.externalParkingRequired?.toString() ?? '');

    // Basement level rows — the list is created here if the record is new.
    final levels = _ensureLevels(state);
    for (int i = 0; i < _levelRowCount; i++) {
      _setText(levelTotalControllers[i], levels[i].totalSlots?.toString() ?? '');
      _setText(levelOccupiedControllers[i],
          levels[i].occupiedSlots?.toString() ?? '');
      // Display 0 for an empty/null Available value, even though the model
      // itself stores null (so the payload sends null rather than 0).
      _setText(levelAvailableControllers[i],
          (levels[i].availableSlots ?? 0).toString());
      _setText(
          levelUtilizationControllers[i],
          (levels[i].utilizationPercent ?? 0.0).toStringAsFixed(2));
      _setText(levelRemarksControllers[i], levels[i].remarks ?? '');
    }
  }

  /// Recalculates Available Slots and Utilization % for a single basement
  /// row, then rolls the change up into the form-level totals.
  void _recalculateLevel(ParkingDetailsState state, int index) {
    final levels = _ensureLevels(state);
    if (index >= levels.length) return;

    final total = levels[index].totalSlots ?? 0;
    final occupied = levels[index].occupiedSlots ?? 0;
    final available = total - occupied;
    final utilization = total > 0 ? (occupied / total) * 100 : 0.0;

    final availableValue = available < 0 ? 0 : available;
    final utilizationValue = double.parse(utilization.toStringAsFixed(2));

    // Store null instead of a literal 0 on the model for Total/Occupied and
    // Utilization (so those are sent as null), but Available Slots always
    // sends its real numeric value, including 0.
    levels[index].availableSlots = availableValue;
    levels[index].utilizationPercent = _zeroToNullDouble(utilizationValue);

    setState(() {
      _setText(levelAvailableControllers[index], availableValue.toString());
      _setText(levelUtilizationControllers[index],
          utilizationValue.toStringAsFixed(2));
      _recalculateFormTotals(state);
    });
  }

  void _recalculateFormTotals(ParkingDetailsState state) {
    // Total Visitors = Customer Visitors + Employee Visitors
    final customer = state.model.customerVisitors ?? 0;
    final employee = state.model.employeeVisitors ?? 0;
    final totalVisitors = customer + employee;
    // Store null instead of a literal 0 on the model (so the payload sends
    // null), but keep the on-screen field showing "0".
    state.model.totalVisitors = _zeroToNullInt(totalVisitors);
    _setText(totalVisitorsController, totalVisitors.toString());

    // Parking slot aggregates, rolled up from the basement levels table
    final levels = _ensureLevels(state);
    int totalSlots = 0;
    int occupiedSlots = 0;
    int availableSlots = 0;
    for (final level in levels) {
      totalSlots += level.totalSlots ?? 0;
      occupiedSlots += level.occupiedSlots ?? 0;
      availableSlots += level.availableSlots ?? 0;
    }

    final utilization =
    totalSlots > 0 ? (occupiedSlots / totalSlots) * 100 : 0.0;
    final utilizationValue = double.parse(utilization.toStringAsFixed(2));

    // Same null-when-zero treatment for the derived form-level totals.
    state.model.totalParkingSlots = _zeroToNullInt(totalSlots);
    state.model.occupiedParkingSlots = _zeroToNullInt(occupiedSlots);
    state.model.availableParkingSlots = _zeroToNullInt(availableSlots);
    state.model.parkingUtilizationPercent = _zeroToNullDouble(utilizationValue);

    _setText(totalParkingSlotsController, totalSlots.toString());
    _setText(occParkingSlotsController, occupiedSlots.toString());
    _setText(availableParkingSlotsController, availableSlots.toString());
    _setText(
        parkingUtilizationPercentController, utilization.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<ParkingDetailsCubit, ParkingDetailsState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Parking',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPositivePressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, parkingListRoute);
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);
        }
      },
      builder: (context, state) {
        if (state.model.status == 1) {
          isReadOnly = false;
        }
        if (state.model.status == -1) {
          isReadOnly = false;
        }

        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: widget.title,
            showPopUp: false,
            pdfAPIName:
            '${CommonApis.exportDetailPagePDF}${state.model.id}&moduleCode=${Constants.leoModuleCode}',
            showSaveButton: !isReadOnly,
            showSubmitButton: !isReadOnly,
            showDisLikeButton: false,
            showLikeButton: false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<ParkingDetailsCubit>(context).submitForm(
                isSaveOnly: true,
              );
            },
            onTapSubmit: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<ParkingDetailsCubit>(context).submitForm(
                isSaveOnly: false,
              );
            },
          ),
          backgroundColor: Colors.transparent,
          body: getBodybuilder(state, height),
        );
      },
    );
  }

  getBodybuilder(ParkingDetailsState state, height) {
    // Make sure the basement rows exist before the table is built, even if the
    // cubit is still loading a brand-new record.
    _ensureLevels(state);

    // Fill the controllers from the model ONLY when the cubit gave us a new
    // state, so a setState() rebuild (typing) never overwrites user input.
    if (!identical(_hydratedState, state)) {
      _hydratedState = state;
      _hydrateControllers(state);
    }

    // Keep all derived totals in sync (Total Visitors, parking slot totals).
    _recalculateFormTotals(state);

    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }

    return SizedBox(
        width: double.infinity,
        height: height,
        child: Stack(
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
                  color: Colors.black.withValues(alpha: 0.08),
                ),
              ),
            ),

            SingleChildScrollView(
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
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      Constants.generalinformation,
                                      style:
                                      Styles.textStyleRegularNormalWhite18,
                                    ),
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),

                                  ///Status
                                  CommonWidgets.textDisplay(
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
                                    initialValue: Utils().parkingStatus(
                                        state.model.status ?? 0,
                                        returnTextOnly: true),
                                    onChange: (String value) {},
                                    validateTextField: (String? user) {},
                                  ),

                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  ///Date of Creation
                                  CommonWidgets.textDisplay(
                                    Constants.dateofcreation,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  dateCreateWidgetDisplay(
                                      state.model.inputDate ?? ''),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  ///Created By
                                  CommonWidgets.horizontalTextHandling(
                                    Constants.createdby,
                                    '${state.model.entrySecurity?.firstName ?? ''} ${state.model.entrySecurity?.lastName ?? ''}',
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  ///Location
                                  CommonWidgets.textDisplay(
                                    Constants.location,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  BaseLocationDropdown().locationWidgetDisplay(
                                      context: context,
                                      isEnabled: !isReadOnly,
                                      locations: state.locations ?? Locations(),
                                      selectedLocationName:
                                      state.model.location?.name ?? '',
                                      onTap: (Organisation? location) {
                                        BlocProvider.of<ParkingDetailsCubit>(
                                            context)
                                            .updateLocationDropdownValue(
                                            location: location);
                                      }),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),


                                  /// Location Type
                                  CommonWidgets.textDisplay(
                                    Constants.locationType,
                                    Styles.textStyleWhite16,
                                    isMandatory: true,
                                  ),
                                  TextFieldAddButton(
                                    title: state.model.locationType?.name,
                                    height: 75,
                                    isDisableColor: isReadOnly,
                                    onTap: () {
                                      if (!isReadOnly) {
                                        BaseOrganisationDialog().departmentDialog(
                                          context: context,
                                          organisations: state.getLocationType.getLocationType ?? [],
                                          onTap: (Organisation locationType) {
                                            BlocProvider.of<ParkingDetailsCubit>(context)
                                                .updateDropdownValues(locationType: locationType);
                                          },
                                          leftImage: false,
                                          createEntity: false,
                                          functionToCall: () {
                                            BlocProvider.of<ParkingDetailsCubit>(context).refreshList();
                                          },
                                        );
                                      }
                                    },
                                  ),
                                  CommonWidgets.verticalSpacerWidget(height * 0.03),

                                  /// Customers Visitors (editable — feeds Total Visitors)
                                  CommonWidgets.textDisplay(
                                      Constants.customerVisitors,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller: customerVisitorsController,
                                    textInputType: TextInputType.number,
                                    textFormKey: Keys.contactNoKey,
                                    hintText: '',
                                    isEnable: !isReadOnly,
                                    isDisableColor: isReadOnly,
                                    onChange: (dynamic value) {
                                      _onVisitorsChanged();
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Employee Visitors (editable — feeds Total Visitors)
                                  CommonWidgets.textDisplay(
                                      Constants.empVisitors,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller: empVisitorsController,
                                    textInputType: TextInputType.number,
                                    textFormKey: Keys.contactNoKey,
                                    hintText: '',
                                    isEnable: !isReadOnly,
                                    isDisableColor: isReadOnly,
                                    onChange: (dynamic value) {
                                      _onVisitorsChanged();
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Total Visitors — DERIVED, read-only
                                  CommonWidgets.textDisplay(
                                      Constants.totalVisitors,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller: totalVisitorsController,
                                    textInputType: TextInputType.number,
                                    textFormKey: Keys.contactNoKey,
                                    hintText: '',
                                    isEnable: false,
                                    isDisableColor: true,
                                    onChange: (dynamic value) {},
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  ///Employee Head Count
                                  CommonWidgets.textDisplay(
                                      Constants.empHeadCount,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller: empHeadCountController,
                                    textInputType: TextInputType.number,
                                    textFormKey: Keys.contactNoKey,
                                    hintText: '',
                                    isEnable: !isReadOnly,
                                    isDisableColor: isReadOnly,
                                    onChange: (dynamic value) {
                                      state.model.employeeHeadCount =
                                          _zeroToNullInt(int.tryParse(
                                              empHeadCountController.text
                                                  .trim()) ??
                                              0);
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Basement Parking Levels
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      'Basement Parking Levels',
                                      style:
                                      Styles.textStyleRegularNormalWhite18,
                                    ),
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                  buildParkingLevelsTable(state),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Total Parking Slots — DERIVED, read-only
                                  CommonWidgets.textDisplay(
                                      Constants.totalParkingSlots,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller: totalParkingSlotsController,
                                    textInputType: TextInputType.number,
                                    textFormKey: Keys.contactNoKey,
                                    hintText: '',
                                    isEnable: false,
                                    isDisableColor: true,
                                    onChange: (dynamic value) {},
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Occupied Parking Slots — DERIVED, read-only
                                  CommonWidgets.textDisplay(
                                      Constants.occParkingSlots,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller: occParkingSlotsController,
                                    textInputType: TextInputType.number,
                                    textFormKey: Keys.contactNoKey,
                                    hintText: '',
                                    isEnable: false,
                                    isDisableColor: true,
                                    onChange: (dynamic value) {},
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Available Parking Slots — DERIVED, read-only
                                  CommonWidgets.textDisplay(
                                      Constants.availableParkingSlots,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller: availableParkingSlotsController,
                                    textInputType: TextInputType.number,
                                    textFormKey: Keys.contactNoKey,
                                    hintText: '',
                                    isEnable: false,
                                    isDisableColor: true,
                                    onChange: (dynamic value) {},
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  /// Parking Utilization % — DERIVED, read-only
                                  CommonWidgets.textDisplay(
                                      Constants.parkingUtilizationPercent,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller:
                                    parkingUtilizationPercentController,
                                    textInputType: TextInputType.number,
                                    textFormKey: Keys.contactNoKey,
                                    hintText: '',
                                    isEnable: false,
                                    isDisableColor: true,
                                    onChange: (dynamic value) {},
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),

                                  ///External parking Required
                                  CommonWidgets.textDisplay(
                                      Constants.externalParkingRequired,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller: externalParkingController,
                                    textInputType: TextInputType.number,
                                    textFormKey: Keys.contactNoKey,
                                    hintText: '',
                                    isEnable: !isReadOnly,
                                    isDisableColor: isReadOnly,
                                    onChange: (dynamic value) {
                                      state.model.externalParkingRequired =
                                          int.tryParse(externalParkingController
                                              .text
                                              .trim()) ??
                                              0;
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),


                                  /// Demand Status
                                  CommonWidgets.textDisplay(
                                    // state.labels?.locale.incidentType ??
                                    //     state.labels?.defaultLocale.incidentType ??
                                      Constants.incidentType,
                                      Styles.textStyleWhite16,
                                      isMandatory: true),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  BaseDropDown().getDropDown(
                                    isDisabled: isReadOnly,
                                    textController: demandStatusController,
                                    items: demandStatusDropDownValues,
                                    initialValue: '${state.model.parkingDemandStatus ?? 0}',
                                    onTap: () {
                                      BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues: demandStatusDropDownValues
                                            .map((label) => label.key)
                                            .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              demandStatusDropDownValues.firstWhere(
                                                    (label) => label.key == value,
                                                orElse: () =>
                                                const Label(key: '', value: ''),
                                              );
                                          BlocProvider.of<ParkingDetailsCubit>(
                                              context)
                                              .updateDropdownValues(
                                              demandStatus: int.tryParse(
                                                  selectedLabel.value));
                                        },
                                      );
                                    },
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                  ///Remarks
                                  CommonWidgets.textDisplay(Constants.remarks,
                                      isMandatory: true,
                                      Styles.textStyleWhite16),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.001),
                                  FlutterInputField(
                                    controller: remarksController,
                                    textInputType: TextInputType.text,
                                    textFormKey: Keys.contactNoKey,
                                    hintText: '',
                                    isEnable: !isReadOnly,
                                    isDisableColor: isReadOnly,
                                    onChange: (String value) {
                                      state.model.remarks = value;
                                    },
                                    validateTextField: (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.02),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// SubmitButton
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cancelButtonDisplay(),
                            if ((!isReadOnly)) ...[submitButtonDisplay()],
                          ],
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.04),
                      ],
                    ),
                  ),
                  CommonWidgets.verticalSpacerWidget(height * 0.04),
                ],
              ),
            ),
          ],
        ));
  }

  // ===========================================================================
  // Basement Parking Levels table
  // ===========================================================================

  Widget _tableField({
    required TextEditingController controller,
    required bool enabled,
    TextInputType keyboardType = TextInputType.number,
    ValueChanged<String>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: SizedBox(
        height: _fieldHeight,
        child: TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.transparent,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.white, width: 1.4),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  /// Basement levels table. Editing Total / Occupied Slots recalculates the
  /// row's Available + Utilization and rolls the result up into the form
  /// totals above via [_recalculateLevel] -> [_recalculateFormTotals].
  Widget buildParkingLevelsTable(ParkingDetailsState state) {
    Widget headerCell(String text) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );

    Widget labelCell(String text) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
      ),
    );

    TableRow buildRow(int index) {
      return TableRow(
        children: [
          labelCell(_basementLabels[index]),

          /// Total Slots (editable) — stored as null when 0
          _tableField(
            controller: levelTotalControllers[index],
            enabled: !isReadOnly,
            onChanged: (String value) {
              final levels = _ensureLevels(state);
              final parsed = int.tryParse(value.trim()) ?? 0;
              levels[index].totalSlots = _zeroToNullInt(parsed);
              _recalculateLevel(state, index);
            },
          ),

          /// Occupied Slots (editable) — stored as null when 0
          _tableField(
            controller: levelOccupiedControllers[index],
            enabled: !isReadOnly,
            onChanged: (String value) {
              final levels = _ensureLevels(state);
              final parsed = int.tryParse(value.trim()) ?? 0;
              levels[index].occupiedSlots = _zeroToNullInt(parsed);
              _recalculateLevel(state, index);
            },
          ),

          /// Available Slots (computed, read-only)
          _tableField(
            controller: levelAvailableControllers[index],
            enabled: false,
          ),

          /// Utilization % (computed, read-only)
          _tableField(
            controller: levelUtilizationControllers[index],
            enabled: false,
          ),

          /// Remarks (editable)
          _tableField(
            controller: levelRemarksControllers[index],
            enabled: !isReadOnly,
            keyboardType: TextInputType.text,
            onChanged: (String value) {
              final levels = _ensureLevels(state);
              levels[index].remarks = value;
            },
          ),
        ],
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: _labelColWidth + (_inputColWidth * 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: const TableBorder(
              horizontalInside: BorderSide(color: Colors.white),
              verticalInside: BorderSide(color: Colors.white),
            ),
            columnWidths: const {
              0: FixedColumnWidth(_labelColWidth),
              1: FixedColumnWidth(_inputColWidth),
              2: FixedColumnWidth(_inputColWidth),
              3: FixedColumnWidth(_inputColWidth),
              4: FixedColumnWidth(_inputColWidth),
              5: FixedColumnWidth(_inputColWidth),
            },
            children: [
              /// Header
              TableRow(
                decoration: const BoxDecoration(color: Colors.transparent),
                children: [
                  headerCell('Basement Level'),
                  headerCell('Total Slots'),
                  headerCell('Occupied Slots'),
                  headerCell('Available Slots'),
                  headerCell('Utilization %'),
                  headerCell('Remarks'),
                ],
              ),

              /// Data rows
              ...List.generate(_levelRowCount, buildRow),
            ],
          ),
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

        BlocProvider.of<ParkingDetailsCubit>(context).submitForm();
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