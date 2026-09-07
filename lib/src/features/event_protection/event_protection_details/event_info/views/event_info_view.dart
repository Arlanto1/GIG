//   import 'dart:core';
//   import 'dart:developer';
//   import 'dart:ui';
//
//   import 'package:db_atom/index.dart';
//   import 'package:db_atom/src/common_widgets/base_widget/opacity_absorb_widget.dart';
//   import 'package:html_editor_enhanced/html_editor.dart';
// import 'package:intl/intl.dart';
//
//   class EventInfoView extends StatefulWidget {
//     const EventInfoView({
//       super.key,
//       required this.title,
//       required this.editForm,
//       required this.isEventProtection,
//       required this.eventProtectionId,
//       required this.isCSREventProtection,
//       required this.isSportEventProtection,
//       this.isAnnualPowerShutdown = false,
//     });
//
//     final String title;
//     final bool editForm;
//     final bool isEventProtection;
//     final String eventProtectionId;
//     final bool isCSREventProtection;
//     final bool isSportEventProtection;
//     final bool isAnnualPowerShutdown;
//     @override
//     State<EventInfoView> createState() => _EventInfoViewState();
//   }
//
//   class _EventInfoViewState extends State<EventInfoView> {
//     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//     // final QuillEditorController quillController = QuillEditorController();
//     final HtmlEditorController quillController = HtmlEditorController();
//
//     User? userDetails;
//     List<ImageContent>? guardFiles;
//     List<ImageContent> getFiles = [];
//     TextEditingController dateController = TextEditingController();
//     TextEditingController addEmailController = TextEditingController();
//     TextEditingController cctvDateController = TextEditingController();
//     TextEditingController accessDateController = TextEditingController();
//     TextEditingController intruderDateController = TextEditingController();
//     TextEditingController cctvEndDateController = TextEditingController();
//     TextEditingController accessEndDateController = TextEditingController();
//     TextEditingController intruderEndDateController = TextEditingController();
//
//     bool showSaveButtons = false;
//
//     String? initialisedFromDate;
//     String? initialisedToDate;
//     String? initialisedStartDate;
//     List<Map<String, dynamic>> emailTemplateList = [];
//     bool isTemplateLoading = false;
//     bool isLoading = false;
//
//     String selectedTemplateHtml = "";
//     String? updatedEmailText;
//
//     @override
//     void initState() {
//       super.initState();
//       BlocProvider.of<EventInfoCubit>(context).initializeValues();
//     }
//
//     @override
//     void dispose() {
//       dateController.dispose();
//       addEmailController.dispose();
//       // quillController.dispose();
//       super.dispose();
//     }
//
//     double? calculateOfflineHours({
//       required String startDate,
//       required String endDate,
//     }) {
//       if (startDate.trim().isEmpty ||
//           endDate.trim().isEmpty) {
//         log('CCTV calculation skipped: date is empty');
//         return null;
//       }
//
//       try {
//         final formatter =
//         DateFormat(Constants.fulldateFormat);
//
//         final DateTime start =
//         formatter.parse(startDate);
//
//         final DateTime end =
//         formatter.parse(endDate);
//
//         log('Parsed CCTV Start: $start');
//         log('Parsed CCTV End: $end');
//
//         if (end.isBefore(start)) {
//           log(
//             'CCTV End Date is before Start Date',
//           );
//           return null;
//         }
//
//         final Duration difference =
//         end.difference(start);
//
//         final double hours =
//             difference.inMinutes / 60.0;
//
//         log(
//           'CCTV Offline Difference: '
//               '${difference.inMinutes} minutes',
//         );
//
//         log(
//           'CCTV Offline Hours: $hours',
//         );
//
//         return hours;
//       } catch (e) {
//         log(
//           'CCTV offline hours calculation error: $e',
//         );
//         return null;
//       }
//     }
//
//     String _formatOfflineHours(double hours) {
//       if (hours == hours.roundToDouble()) {
//         return hours.toInt().toString();
//       }
//
//       return hours.toStringAsFixed(2);
//     }
//     @override
//     Widget build(BuildContext context) {
//       final size = MediaQuery.of(context).size;
//       final height = size.height;
//
//       return BlocConsumer<EventInfoCubit, EventInfoState>(
//           // listenWhen: (previous, current) =>
//           //     previous.status != current.status &&
//           //     (current.status == FormStatus.success ||
//           //         current.status == FormStatus.templateLoaded  ),
//           // listener: (context, state) {
//           //  if (state.status == FormStatus.loading) return; // guard
//           //
//           //   Navigator.pop(context); // dismiss loader
//           //
//           //   if (state.status == FormStatus.formError) {
//           //     ScaffoldMessenger.of(context).showSnackBar(
//           //       SnackBar(
//           //         content: Text(state.message ?? 'Something went wrong'),
//           //         backgroundColor: Colors.red,
//           //       ),
//           //     );
//           //     return; //  don't navigate
//           //   }
//           //   Navigator.pop(context);
//           //   log('-state.status---${state.status}----');
//           //   Utils().formError(state, context);
//           //   if (state.status == FormStatus.success) {
//           //     log('123 ${state.status}');
//           //     var dialog = CustomAlertDialog(
//           //       title: 'Event Protection',
//           //       message: state.message ?? '',
//           //       positiveBtnText: Constants.ok,
//           //       onPositivePressed: () {
//           //         // TODO: Need to improve this code
//           //         Navigator.pop(context);
//           //         Navigator.pop(context);
//           //         // Navigator.popAndPushNamed(
//           //         //   context,
//           //         //   keyManagementIssuanceListRoute,
//           //         // );
//           //       },
//           //     );
//           //     showDialog(
//           //         context: context,
//           //         barrierDismissible: false,
//           //         builder: (BuildContext context) => dialog);
//           //   }
//           //   if (state.status == FormStatus.addArticleFound) {
//           //     Navigator.pop(context);
//           //     Navigator.pushNamed(
//           //       context,
//           //       articleFoundNewDetailsRoute,
//           //       arguments: {
//           //         ConstantsArgument.eventId: state.model.id,
//           //         ConstantsArgument.eventProtectionId: widget.eventProtectionId,
//           //       },
//           //     );
//           //   }
//
//           // listenWhen: (previous, current) =>
//           // previous.status != current.status &&
//           //     (current.status == FormStatus.success ||
//           //         current.status == FormStatus.templateLoaded ||
//           //         current.status == FormStatus.formError), // ✅ now included
//
//           // listener: (context, state) {
//           //   // ✅ Show error and STOP — no pop, no navigation
//           //   if (state.status == FormStatus.formError) {
//           //     ScaffoldMessenger.of(context).showSnackBar(
//           //       SnackBar(
//           //         content: Text(state.message ?? 'Something went wrong'),
//           //         backgroundColor: Colors.red,
//           //       ),
//           //     );
//           //     return;
//           //   }
//           //
//           //   // ✅ Only pop for success/templateLoaded
//           //   Navigator.pop(context);
//           //
//           //   if (state.status == FormStatus.success) {
//           //     var dialog = CustomAlertDialog(
//           //       title: 'Event Protection',
//           //       message: state.message ?? '',
//           //       positiveBtnText: Constants.ok,
//           //       onPositivePressed: () {
//           //         Navigator.pop(context);
//           //         Navigator.pop(context);
//           //       },
//           //     );
//           //     showDialog(
//           //       context: context,
//           //       barrierDismissible: false,
//           //       builder: (BuildContext context) => dialog,
//           //     );
//           //   }
//           //
//           //   if (state.status == FormStatus.addArticleFound) {
//           //     Navigator.pop(context);
//           //     Navigator.pushNamed(
//           //       context,
//           //       articleFoundNewDetailsRoute,
//           //       arguments: {
//           //         ConstantsArgument.eventId: state.model.id,
//           //         ConstantsArgument.eventProtectionId: widget.eventProtectionId,
//           //       },
//           //     );
//           //   }
//           //   // return BlocConsumer<EventInfoCubit, EventInfoState>(
//           //   //     listenWhen: (previous, current) =>
//           //   //     previous.status != current.status,
//           //   //
//           //   //     listener: (context, state) {
//           //   //       log('LISfTENER CALLED: ${state.status}');
//           //   //
//           //   //       Utils().formError(state, context);
//           //   //
//           //   //       if (state.status == FormStatus.loading) {
//           //   //         log('SUCCESS TRIGGERED');
//           //   //
//           //   //         var dialog = CustomAlertDialog(
//           //   //           title: 'Event Protection',
//           //   //           message: state.message ?? '',
//           //   //           positiveBtnText: Constants.ok,
//           //   //           onPositivePressed: () {
//           //   //             Navigator.pop(context);
//           //   //             Navigator.pop(context);
//           //   //           },
//           //   //         );
//           //   //
//           //   //         showDialog(
//           //   //           context: context,
//           //   //           barrierDismissible: false,
//           //   //           builder: (_) => dialog,
//           //   //         );
//           //   //       }
//           //   //
//           //   //       if (state.status == FormStatus.addArticleFound) {
//           //   //         Navigator.pop(context);
//           //   //         Navigator.pushNamed(
//           //   //           context,
//           //   //           articleFoundNewDetailsRoute,
//           //   //           arguments: {
//           //   //             ConstantsArgument.eventId: state.model.id,
//           //   //             ConstantsArgument.eventProtectionId: widget.eventProtectionId,
//           //   //           },
//           //   //         );
//           //   //       }
//           // },
//
//           listener: (context, state) {
//             if (state.status == FormStatus.formError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message ?? 'Something went wrong'),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//               return;
//             }
//
//             if (state.status == FormStatus.templateLoaded) {
//               // just dismiss loading if you showed one, no dialog needed
//               return;
//             }
//
//             // if (state.status == FormStatus.success) {
//             //   showDialog(
//             //     context: context,
//             //     barrierDismissible: false,
//             //     builder: (BuildContext dialogContext) {
//             //       return CustomAlertDialog(
//             //         title: widget.title,
//             //         message: state.message ?? '',
//             //         positiveBtnText: Constants.ok,
//             //         onPositivePressed: () {
//             //           Navigator.pop(dialogContext); // closes dialog
//             //           if (context.mounted) {
//             //             Navigator.pop(context);     // pops the page
//             //           }
//             //         },
//             //       );
//             //     },
//             //   );
//             //   return;
//             // }
//
//             if (state.status == FormStatus.success) {
//               showDialog(
//                 context: context,
//                 barrierDismissible: false,
//                 builder: (BuildContext dialogContext) {
//                   return CustomAlertDialog(
//                     title: 'Event Protection',
//                     message: state.message ?? '',
//                     positiveBtnText: Constants.ok,
//                     onPositivePressed: () {
//                       Navigator.pop(dialogContext); // close dialog
//
//                       if (!context.mounted) return;
//
//                       String route;
//                       Map<String, dynamic>? routeArgs;
//
//                       if (widget.isEventProtection) {
//                         route = eventProtectionListRoute;
//                       } else if (widget.isCSREventProtection) {
//                         route = csrEventListRoute;
//                         routeArgs = {
//                           ConstantsArgument.isCSREvent: true,
//                           ConstantsArgument.isSportEvent: false,
//                         };
//                       } else if (widget.isSportEventProtection) {
//                         route = csrEventListRoute;
//                         routeArgs = {
//                           ConstantsArgument.isCSREvent: false,
//                           ConstantsArgument.isSportEvent: true,
//                         };
//                       } else {
//                         route = annualPowerShutdownListRoute;
//                       }
//
//                       Navigator.pushNamedAndRemoveUntil(
//                         context,
//                         route,
//                             (route) => route.isFirst, // keep the first/root route, only clear what's above it
//                         arguments: routeArgs,
//                       );
//                     },
//                   );
//                 },
//               );
//               // return;
//             }
//             if (state.status == FormStatus.addArticleFound) {
//               Navigator.pop(context);
//               Navigator.pushNamed(
//                 context,
//                 articleFoundNewDetailsRoute,
//                 arguments: {
//                   ConstantsArgument.eventId: state.model.id,
//                   ConstantsArgument.eventProtectionId: widget.eventProtectionId,
//                 },
//               );
//               return;
//             }
//           },
//           builder: (context, state) {
//
//             log('-ISSPORT-${widget.isSportEventProtection}---');
//             log('-isCSR-${widget.isCSREventProtection}---');
//
//             if (state.status == FormStatus.loading) {
//               return const BaseLoader();
//             }
//             if (state.status == FormStatus.addAttachment ||
//                 state.status == FormStatus.initial) {
//               guardFiles = state.guardAttachments ?? [];
//               // guardFiles = state.model.images;
//             }
//
//             if (state.status == FormStatus.addAttachment ||
//                 state.status == FormStatus.initial) {
//               getFiles = state.loadAttachments ?? [];
//             }
//             if (state.eventDuration == ConstantsIntValue.eventDurationBefore) {
//               if (!state.model.eventStartedAt.isEmptyOrNull &&
//                   dateController.text.isEmpty) {
//                 log('state.model.eventStartedAt--- ${state.model.eventStartedAt}');
//                 dateController.text = Utils.timestampToDateConversion(
//                     int.tryParse(state.model.eventStartedAt ?? '0'),
//                     Constants.fulldateFormat);
//               }
//               initialisedFromDate = DateTime.fromMillisecondsSinceEpoch(
//                       (int.tryParse('${state.model.startDate}') ?? 0) * 1000)
//                   .toString();
//               initialisedStartDate = DateTime.fromMillisecondsSinceEpoch(
//                       (int.tryParse('${state.model.startDate}') ?? 0) * 1000)
//                   .toString();
//               initialisedToDate = DateTime.fromMillisecondsSinceEpoch(
//                       (int.tryParse('${state.model.endDate}') ?? 0) * 1000)
//                   .toString();
//               log('initialisedToDate--- $initialisedToDate');
//               log('initialisedStartDate--- $initialisedStartDate');
//               log('initialisedFromDate--- $initialisedFromDate');
//               log('cctvDateController--- $cctvDateController');
//
//               if (!state.model.cctvSystemOfflineStartDate.isEmptyOrNull &&
//                   cctvDateController.text.isEmpty) {
//               cctvDateController.text = Utils.timestampToDateConversion(
//                   int.tryParse(state.model.cctvSystemOfflineStartDate ?? 'null'),
//                   Constants.fulldateFormat);
//   }
//               if (!state.model.accessSystemOfflineStartDate.isEmptyOrNull &&
//                   accessDateController.text.isEmpty) {
//                 accessDateController.text = Utils.timestampToDateConversion(
//                     int.tryParse(
//                         state.model.accessSystemOfflineStartDate ?? 'null'),
//                     Constants.fulldateFormat);
//               }
//
//               if (!state.model.intruderSystemOfflineStartDate.isEmptyOrNull &&
//                   intruderDateController.text.isEmpty) {
//                 intruderDateController.text = Utils.timestampToDateConversion(
//                     int.tryParse(
//                         state.model.intruderSystemOfflineStartDate ?? 'null'),
//                     Constants.fulldateFormat);
//               }
//
//               if (!state.model.cctvSystemOfflineEndDate.isEmptyOrNull &&
//                   cctvEndDateController.text.isEmpty) {
//                 cctvEndDateController.text = Utils.timestampToDateConversion(
//                     int.tryParse(state.model.cctvSystemOfflineEndDate ?? 'null'),
//                     Constants.fulldateFormat);
//               }
//               if (!state.model.accessSystemOfflineEndDate.isEmptyOrNull &&
//                   accessEndDateController.text.isEmpty) {
//                 accessEndDateController.text = Utils.timestampToDateConversion(
//                     int.tryParse(
//                         state.model.accessSystemOfflineEndDate ?? 'null'),
//                     Constants.fulldateFormat);
//               }
//
//               if (!state.model.intruderSystemOfflineEndDate.isEmptyOrNull &&
//                   intruderEndDateController.text.isEmpty) {
//                 intruderEndDateController.text = Utils.timestampToDateConversion(
//                     int.tryParse(
//                         state.model.intruderSystemOfflineEndDate ?? 'null'),
//                     Constants.fulldateFormat);
//               }
//             }
//
//             // if (state.eventDuration == ConstantsIntValue.eventDurationAfter) {
//             //   if (!state.model.eventConcludedAt.isEmptyOrNull &&
//             //       dateController.text.isEmpty) {
//             //     log('state.model.eventConcludedAt--- ${state.model.eventConcludedAt}');
//             //     dateController.text = Utils.timestampToDateConversion(
//             //         int.tryParse(state.model.eventConcludedAt ?? 'null'),
//             //         Constants.fulldateFormat);
//             //   }
//             //   initialisedFromDate = DateTime.fromMillisecondsSinceEpoch(
//             //           (int.tryParse('${state.model.eventStartedAt}') ?? 0) * 1000)
//             //       .toString();
//             //   initialisedStartDate = DateTime.fromMillisecondsSinceEpoch(
//             //           (int.tryParse('${state.model.eventStartedAt}') ?? 0) * 1000)
//             //       .toString();
//             //   DateTime currentDate = DateTime.now();
//             //   DateTime newDateTime = currentDate.add(const Duration(days: 1));
//             //   initialisedToDate = newDateTime.toString();
//             //   log('initialisedToDate--- $initialisedToDate');
//             //   log('initialisedStartDate--- $initialisedStartDate');
//             //   log('initialisedFromDate--- $initialisedFromDate');
//             // }
//
//             // if (state.eventDuration == ConstantsIntValue.eventDurationAfter) {
//             //
//             // initialisedFromDate = DateTime.fromMillisecondsSinceEpoch(
//             // (int.tryParse('${state.model.eventStartedAt}') ?? 0) * 1000).toString();
//             // initialisedStartDate = initialisedFromDate;
//             //
//             // final DateTime eventStart =
//             // DateTime.tryParse(initialisedFromDate ?? '') ?? DateTime.now();
//             // final DateTime currentDate = DateTime.now();
//             //
//             // // "Concluded" must be on/after the event's own start — not just "now".
//             // // Guards against device-clock skew or future-dated eventStartedAt values
//             // // ever putting toDate before fromDate.
//             // final DateTime baseline =
//             // eventStart.isAfter(currentDate) ? eventStart : currentDate;
//             // final DateTime newDateTime = baseline.add(const Duration(days: 1));
//             // initialisedToDate = newDateTime.toString();
//             //
//             // log('initialisedToDate--- $initialisedToDate');
//             // log('initialisedStartDate--- $initialisedStartDate');
//             // log('initialisedFromDate--- $initialisedFromDate');
//             // }
//
//             if (state.eventDuration == ConstantsIntValue.eventDurationAfter) {
//               // Populate "Event Concluded At" from the API — this line was dropped
//               // when the block was rewritten, which is why the field showed blank
//               // even though the API returned eventConcludedAt.
//               if (!state.model.eventConcludedAt.isEmptyOrNull &&
//                   dateController.text.isEmpty) {
//                 log('state.model.eventConcludedAt--- ${state.model.eventConcludedAt}');
//                 dateController.text = Utils.timestampToDateConversion(
//                     int.tryParse(state.model.eventConcludedAt ?? 'null'),
//                     Constants.fulldateFormat);
//               }
//
//               initialisedFromDate = DateTime.fromMillisecondsSinceEpoch(
//                   (int.tryParse('${state.model.eventStartedAt}') ?? 0) * 1000)
//                   .toString();
//               initialisedStartDate = initialisedFromDate;
//
//               final DateTime eventStart =
//                   DateTime.tryParse(initialisedFromDate ?? '') ?? DateTime.now();
//               final DateTime currentDate = DateTime.now();
//
//               final DateTime baseline =
//               eventStart.isAfter(currentDate) ? eventStart : currentDate;
//               final DateTime newDateTime = baseline.add(const Duration(days: 1));
//               initialisedToDate = newDateTime.toString();
//
//               // Populate CCTV / Access / Intruder "offline end date" fields from the
//               // API. This previously only ran inside the eventDurationBefore branch,
//               // so opening a record in "after" (concluded) mode never loaded these
//               // saved values — the fields looked empty even though the data existed.
//               if (!state.model.cctvSystemOfflineEndDate.isEmptyOrNull &&
//                   cctvEndDateController.text.isEmpty) {
//                 cctvEndDateController.text = Utils.timestampToDateConversion(
//                     int.tryParse(state.model.cctvSystemOfflineEndDate ?? 'null'),
//                     Constants.fulldateFormat);
//               }
//               if (!state.model.accessSystemOfflineEndDate.isEmptyOrNull &&
//                   accessEndDateController.text.isEmpty) {
//                 accessEndDateController.text = Utils.timestampToDateConversion(
//                     int.tryParse(state.model.accessSystemOfflineEndDate ?? 'null'),
//                     Constants.fulldateFormat);
//               }
//               if (!state.model.intruderSystemOfflineEndDate.isEmptyOrNull &&
//                   intruderEndDateController.text.isEmpty) {
//                 intruderEndDateController.text = Utils.timestampToDateConversion(
//                     int.tryParse(state.model.intruderSystemOfflineEndDate ?? 'null'),
//                     Constants.fulldateFormat);
//               }
//
//               log('initialisedToDate--- $initialisedToDate');
//               log('initialisedStartDate--- $initialisedStartDate');
//               log('initialisedFromDate--- $initialisedFromDate');
//             }
//             log('--widget.editForm---${widget.editForm}--');
//             log('state.model.canEdit${state.model.canEdit}--');
//
//             // if (state.model.status != 4) {
//             //   showSaveButtons = true;
//             // }
//
//             // if (state.model.lock.isEmptyOrNull) {
//             //   showSaveButtons = true;
//             // }
//             // if(state.model.canEdit == true && state.model.lock.isEmptyOrNull){
//             //   showSaveButtons == true;
//             // }
//             //
//             // if(state.model.readOnly == false && state.model.lock.isEmptyOrNull){
//             //   showSaveButtons == true;
//             // }
//
//             showSaveButtons = state.model.canEdit == true && state.model.lock.isEmptyOrNull;
//             log('state.model.lock.isEmptyOrNull${state.model.lock.isEmptyOrNull}--');
//             log('state.model.canEdit${state.model.canEdit}--');
//
//             log('-showSaveButtons-${showSaveButtons}---');
//
//             log('-csrrr-${widget.isSportEventProtection}---');
//             return Scaffold(
//               appBar: BaseAppBar().buildAppHeader(
//                 context: context,
//                 title: widget.title,
//                 showPopUp: false,
//                 showSaveButton: showSaveButtons ,
//                 showSubmitButton: showSaveButtons,
//                 showDisLikeButton: false,
//                 showLikeButton: false,
//                 onTapSave: () {
//                   FocusScope.of(context).unfocus();
//                   BlocProvider.of<EventInfoCubit>(context).submitForm(
//                       isSaveOnly: true, updatedEmailText: updatedEmailText ?? '');
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                 },
//                 // onTapSubmit: () {
//                 //   FocusScope.of(context).unfocus();
//                 //   BlocProvider.of<EventInfoCubit>(context).submitForm(
//                 //       isSaveOnly: false,
//                 //       updatedEmailText: updatedEmailText ?? '');
//                 //   Navigator.pop(context);
//                 //   Navigator.pop(context);
//                 //   String route = widget.isEventProtection
//                 //       ? eventProtectionListRoute
//                 //       : widget.isCSREventProtection
//                 //           ? csrEventListRoute
//                 //           : annualPowerShutdownListRoute;
//                 //
//                 //   Navigator.pushNamedAndRemoveUntil(
//                 //     context,
//                 //     route,
//                 //     (route) => false,
//                 //   );
//                 // },
//                 // onTapSubmit: () async {
//                 //   FocusScope.of(context).unfocus();
//                 //
//                 //   final success = await BlocProvider.of<EventInfoCubit>(context).submitForm(
//                 //     isSaveOnly: false,
//                 //     updatedEmailText: updatedEmailText ?? '',
//                 //   );
//                 //
//                 //   if (!success) return; //  API failed — stay on page
//                 //   //
//                 //   if (!context.mounted) return; // safety check after await
//                 //   //
//                 //   // // Navigator.pop(context);
//                 //   // // Navigator.pop(context);
//                 //   //
//                 //   // String route = widget.isEventProtection
//                 //   //     ? eventProtectionListRoute
//                 //   //     : widget.isCSREventProtection || widget.isSportEventProtection
//                 //   //     ? csrEventListRoute
//                 //   //     : annualPowerShutdownListRoute;
//                 //   //
//                 //   // Navigator.pushNamedAndRemoveUntil(
//                 //   //   context,
//                 //   //   route,
//                 //   //       (route) => false,
//                 //   // );
//                 // },
//                 // onTapSubmit: () async {
//                 //   FocusScope.of(context).unfocus();
//                 //   final success = await BlocProvider.of<EventInfoCubit>(context)
//                 //       .submitForm(isSaveOnly: false, updatedEmailText: updatedEmailText ?? '');
//                 //
//                 //   if (!success) return;
//                 //   if (!context.mounted) return;
//                 //
//                 //   setState(() {
//                 //     showSaveButtons = false;
//                 //   });
//                 //
//                 //   Navigator.pop(context);
//                 //   Navigator.pop(context);
//                 // },
//
//                 // onTapSubmit: () async {
//                 //   FocusScope.of(context).unfocus();
//                 //   final success = await BlocProvider.of<EventInfoCubit>(context).submitForm(
//                 //     isSaveOnly: false,
//                 //     updatedEmailText: updatedEmailText ?? '',
//                 //   );
//                 //
//                 //   if (!success) return; // API failed — stay on page
//                 //   if (!context.mounted) return;
//                 //
//                 //   setState(() {
//                 //     showSaveButtons = false;
//                 //   });
//                 //
//                 //   // Determine which list this event type belongs to
//                 //   final String route = widget.isEventProtection
//                 //       ? eventProtectionListRoute
//                 //       : widget.isCSREventProtection || widget.isSportEventProtection
//                 //       ? csrEventListRoute
//                 //       : annualPowerShutdownListRoute;
//                 //
//                 //   // Rebuilds the list page from scratch — its initState (and therefore
//                 //   // its list-fetch API call) runs again, so the submitted record shows
//                 //   // up with fresh data instead of a stale cached list.
//                 //   Navigator.pushNamedAndRemoveUntil(
//                 //     context,
//                 //     route,
//                 //         (route) => false, // clears the whole stack back to the list
//                 //   );
//                 // },
//                 onTapSubmit: () async {
//                   FocusScope.of(context).unfocus();
//                   final success = await BlocProvider.of<EventInfoCubit>(context).submitForm(
//                     isSaveOnly: false,
//                     updatedEmailText: updatedEmailText ?? '',
//                   );
//
//                   if (!success) return; // API failed — stay on page
//                   if (!context.mounted) return;
//
//                   setState(() {
//                     showSaveButtons = false;
//                   });
//
//                   String route;
//                   Map<String, dynamic>? routeArgs;
//
//                   if (widget.isEventProtection) {
//                     route = eventProtectionListRoute;
//                   } else if (widget.isCSREventProtection) {
//                     route = csrEventListRoute;
//                     routeArgs = {
//                       ConstantsArgument.isCSREvent: true,
//                       ConstantsArgument.isSportEvent: false,
//                     };
//                   } else if (widget.isSportEventProtection) {
//                     route = csrEventListRoute;
//                     routeArgs = {
//                       ConstantsArgument.isCSREvent: false,
//                       ConstantsArgument.isSportEvent: true,
//                     };
//                   } else {
//                     route = annualPowerShutdownListRoute;
//                   }
//
//                   // Navigator.pushNamedAndRemoveUntil(
//                   //   context,
//                   //   route,
//                   //       (route) => false, // clears the whole stack back to the list
//                   //   // arguments: routeArgs,
//                   // );
//                   Navigator.pushNamedAndRemoveUntil(
//                     context,
//                     route,
//                         (route) => route.isFirst, // keep the first/root route, only clear what's above it
//                       arguments: routeArgs,
//                   );
//                 },
//               ),
//               backgroundColor: Colors.transparent,
//               body: Stack(
//                 children: [
//                   ///  FULL SCREEN BACKGROUND IMAGE
//                   Positioned.fill(
//                     child: Image.asset(
//                       'assets/images/bg2.png',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//
//                   //  GLASS BLUR OVERLAY
//                   Positioned.fill(
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
//                       child: Container(
//                         color: Colors.black.withValues(alpha: 0.15),
//                       ),
//                     ),
//                   ),
//
//                   //  CONTENT (FORCED TO FULL HEIGHT)
//                   LayoutBuilder(builder: (context, constraints) {
//                     return SingleChildScrollView(
//                         child: ConstrainedBox(
//                             constraints: BoxConstraints(
//                               minHeight: constraints.maxHeight,
//                             ),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   color: Colors.transparent,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Form(
//                                         key: _formKey,
//                                         autovalidateMode: state.model.status == 30
//                                             ? AutovalidateMode.disabled
//                                             : AutovalidateMode.onUserInteraction,
//                                         child: Column(
//                                           children: [
//                                             if (!state
//                                                 .model.lock.isEmptyOrNull) ...[
//                                               RecordLockedWidget(
//                                                   text: '${state.model.lock}'),
//                                             ],
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 20.0, right: 20),
//                                               child: Column(
//                                                 children: [
//                                                   CommonWidgets
//                                                       .verticalSpacerWidget(
//                                                           height * 0.02),
//
//                                                   /// Event Started At / Event Concluded At
//                                                   if (state.eventDuration !=
//                                                       1) ...[
//                                                     CommonWidgets.textDisplay(
//                                                       state.eventDuration == 0
//                                                           ? Constants
//                                                               .eventStartedAt
//                                                           : Constants
//                                                               .eventConcludedAt,
//                                                       Styles.textStyleWhite14,
//                                                       isMandatory: true
//                                                     ),
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                         height * 0.01),
//                                                     BaseDate()
//                                                         .datePickerWidgetLoading(
//                                                       context: context,
//                                                       textController:
//                                                           dateController,
//                                                       isDisabled:
//                                                           !showSaveButtons,
//                                                       onlyDate: false,
//                                                       // startDate: DateTime
//                                                       //         .fromMillisecondsSinceEpoch(int.parse(
//                                                       //                 '${state.model.startDate}') *
//                                                       //             1000)
//                                                       //     .toString(),
//                                                       // fromDate: DateTime.fromMillisecondsSinceEpoch(
//                                                       //         int.parse(
//                                                       //                 '${state.model.startDate}') *
//                                                       //             1000)
//                                                       //     .toString(),
//                                                       // toDate: DateTime.fromMillisecondsSinceEpoch(
//                                                       //         int.parse('${state.model.endDate}') *
//                                                       //             1000)
//                                                       //     .toString(),
//                                                       startDate:
//                                                           initialisedStartDate,
//                                                       fromDate:
//                                                           initialisedFromDate,
//                                                       toDate: initialisedToDate,
//                                                       onChange: (String value) {
//                                                         dateController.text =
//                                                             value;
//                                                         log('dateControllerValue --- $value');
//                                                         state.model.date = value;
//                                                         BlocProvider.of<
//                                                                     EventInfoCubit>(
//                                                                 context)
//                                                             .onModelValueChange(
//                                                                 state.model);
//                                                       },
//                                                     ),
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                             height * 0.02),
//                                                   ],
//
//
//                                                   ///Additional Emails
//                                                   CommonWidgets.textDisplay(
//                                                       Constants.additionalEmails,
//                                                       Styles.textStyleWhite14,
//                                                       isMandatory: true
//                                                   ),
//                                                   CommonWidgets
//                                                       .verticalSpacerWidget(
//                                                           height * 0.01),
//                                                   Opacity(
//                                                     opacity:
//                                                         showSaveButtons ? 1 : 0.5,
//                                                     child: GestureDetector(
//                                                       onTap: () {
//                                                         if (!showSaveButtons) {
//                                                           return;
//                                                         }
//                                                         addEmail();
//                                                       },
//                                                       child: Row(
//                                                         children: <Widget>[
//                                                           // Expanded(
//                                                           //child:
//                                                           const SizedBox(
//                                                               width: 14),
//                                                           SvgPicture.asset(
//                                                             AppIcon.plusCircle,
//                                                             colorFilter:
//                                                                 const ColorFilter
//                                                                     .mode(
//                                                               AppColors.white,
//                                                               BlendMode.srcIn,
//                                                             ),
//                                                             // color: AppColors.navigationSkyBlueColor,
//                                                           ),
//                                                           // ),
//                                                           const SizedBox(
//                                                               width: 10),
//                                                           const Text(
//                                                             Constants
//                                                                 .additionalEmails,
//                                                             style: TextStyle(
//                                                                 color: AppColors
//                                                                     .white,
//                                                                 decoration:
//                                                                     TextDecoration
//                                                                         .underline,
//                                                                 decorationColor:
//                                                                     AppColors
//                                                                         .white),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//
//                                                   ///Get email
//                                                   getEmail(
//                                                       state.additionalEmails ??
//                                                           []),
//                                                   CommonWidgets
//                                                       .verticalSpacerWidget(
//                                                           height * 0.02),
//
//                                                   if ((state.eventDuration == ConstantsIntValue.eventDurationBefore &&
//                                                       (widget.isSportEventProtection || widget.isCSREventProtection))) ...[
//                                                     /// Additional Information
//                                                     CommonWidgets.textDisplay(
//                                                       // state.labels?.locale.additionalInformation ??
//                                                       //     state.labels?.defaultLocale.additionalInformation ??
//                                                         Constants.additionalinformation,
//                                                         Styles.textStyleWhite16,
//                                                         isMandatory: true),
//                                                     FlutterInputField(
//                                                       lineHeight: 5,
//                                                       characterLimit:
//                                                       Constants.characterLimitDescTextFormField,
//                                                       initialValue: state.model.additionalInfo4,
//                                                       textFormKey: Keys.premisesRoundTknCommentsKey,
//                                                       hintText: Constants.informationhere,
//                                                       showBorder: true,
//                                                       textInputAction: TextInputAction.newline,
//                                                       textInputType: TextInputType.multiline,
//                                                       isEnable: true,
//                                                       isDisableColor: false,
//                                                       onChange: (String value) {
//                                                         state.model.additionalInfo4 = value;
//                                                         context
//                                                             .read<EventInfoCubit>()
//                                                             .onModelValueChange(state.model);
//                                                       },
//                                                       validateTextField: (String? user) {},
//                                                     ),
//                                                     CommonWidgets.verticalSpacerWidget(height * 0.02),
//                                                   ],
//
//                                                   if ((state.eventDuration == ConstantsIntValue.eventDurationBefore) &&
//                                                     widget.isAnnualPowerShutdown) ...[
//                                                     /// CCTV System Offline
//                                                     Row(children: [
//                                                       CommonWidgets.textDisplay(
//                                                         // state.labels?.locale.extraSecurityDeployed ??
//                                                         //     state.labels?.defaultLocale
//                                                         //         .extraSecurityDeployed ??
//                                                         Constants
//                                                             .cCTvSystemOffline,
//                                                         Styles.textStyleWhite16,
//                                                         isMandatory: true
//                                                       ),
//                                                       Opacity(
//                                                         opacity: showSaveButtons
//                                                             ? 1
//                                                             : 0.5,
//                                                         child: Checkbox(
//                                                             activeColor:
//                                                                 const Color(
//                                                                     0xFF071130),
//                                                             focusColor:
//                                                                 const Color(
//                                                                     0xFF071130),
//                                                             value: state.model
//                                                                 .cctvSystemOffline,
//                                                             onChanged:
//                                                                 showSaveButtons
//                                                                     ? (bool?
//                                                                         value) {
//                                                                         state.model
//                                                                                 .cctvSystemOffline =
//                                                                             value!;
//                                                                         BlocProvider.of<EventInfoCubit>(
//                                                                                 context)
//                                                                             .onCheckBoxChange(
//                                                                                 state.model);
//                                                                       }
//                                                                     : null),
//                                                       )
//                                                     ]),
//
//                                                     if (state.model
//                                                             .cctvSystemOffline ==
//                                                         true) ...[
//                                                       CommonWidgets.textDisplay(
//                                                         // state.labels?.locale.extraSecurityDeployed ??
//                                                         //     state.labels?.defaultLocale
//                                                         //         .extraSecurityDeployed ??
//                                                         Constants.startDate,
//                                                         Styles.textStyleWhite16,
//                                                           isMandatory: true
//                                                       ),
//                                                       BaseDate()
//                                                           .datePickerWidgetLoading(
//                                                         context: context,
//                                                         textController:
//                                                             cctvDateController,
//                                                         isDisabled:
//                                                             !showSaveButtons,
//                                                         onlyDate: false,
//                                                         // onChange: (String value) {
//                                                         //   cctvDateController
//                                                         //       .text = value;
//                                                         //   log('dateControllerValue --- $value');
//                                                         //   state.model
//                                                         //           .cctvSystemOfflineStartDate =
//                                                         //       value;
//                                                         //   BlocProvider.of<
//                                                         //               EventInfoCubit>(
//                                                         //           context)
//                                                         //       .onModelValueChange(
//                                                         //           state.model);
//                                                         // },
//                                                         onChange: (String value) {
//                                                           cctvDateController.text = value;
//
//                                                           state.model.cctvSystemOfflineStartDate = value;
//
//                                                           final double? offlineHours = calculateOfflineHours(
//                                                             startDate: cctvDateController.text,
//                                                             endDate: cctvEndDateController.text,
//                                                           );
//
//                                                           if (offlineHours != null) {
//                                                             state.model.cctvSystemOfflineHours = offlineHours;
//                                                           }
//
//                                                           context
//                                                               .read<EventInfoCubit>()
//                                                               .onModelValueChange(state.model);
//                                                         },
//                                                       ),
//                                                     ],
//
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                         height * 0.02),
//                                                     /// Access System Offline
//                                                     Row(children: [
//                                                       CommonWidgets.textDisplay(
//                                                         // state.labels?.locale.extraSecurityDeployed ??
//                                                         //     state.labels?.defaultLocale
//                                                         //         .extraSecurityDeployed ??
//                                                         Constants
//                                                             .accessSystemOffline,
//                                                         Styles.textStyleWhite16,
//                                                           isMandatory: true
//                                                       ),
//                                                       Opacity(
//                                                         opacity: 1,
//                                                         child: Checkbox(
//                                                             activeColor:
//                                                                 const Color(
//                                                                     0xFF071130),
//                                                             focusColor:
//                                                                 const Color(
//                                                                     0xFF071130),
//                                                             value: state.model
//                                                                 .accessSystemOffline,
//                                                             onChanged:
//                                                                 showSaveButtons
//                                                                     ? (bool?
//                                                                         value) {
//                                                                         state.model
//                                                                                 .accessSystemOffline =
//                                                                             value!;
//                                                                         BlocProvider.of<EventInfoCubit>(
//                                                                                 context)
//                                                                             .onCheckBoxChange(
//                                                                                 state.model);
//                                                                       }
//                                                                     : null),
//                                                       )
//                                                     ]),
//
//                                                     if (state.model
//                                                             .accessSystemOffline ==
//                                                         true) ...[
//                                                       CommonWidgets.textDisplay(
//                                                         // state.labels?.locale.extraSecurityDeployed ??
//                                                         //     state.labels?.defaultLocale
//                                                         //         .extraSecurityDeployed ??
//                                                         Constants.startDate,
//                                                         Styles.textStyleWhite16,
//                                                           isMandatory: true
//                                                       ),
//                                                       BaseDate()
//                                                           .datePickerWidgetLoading(
//                                                         context: context,
//                                                         textController:
//                                                             accessDateController,
//                                                         isDisabled:
//                                                             !showSaveButtons,
//                                                         onlyDate: false,
//                                                         onChange: (String value) {
//                                                           accessDateController
//                                                               .text = value;
//                                                           log('dateControllerValue --- $value');
//                                                           state.model
//                                                                   .accessSystemOfflineStartDate =
//                                                               value;
//                                                           BlocProvider.of<
//                                                                       EventInfoCubit>(
//                                                                   context)
//                                                               .onModelValueChange(
//                                                                   state.model);
//                                                         },
//                                                       ),
//                                                     ],
//
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                         height * 0.02),
//                                                     /// Intruder System Offline
//                                                     Row(children: [
//                                                       CommonWidgets.textDisplay(
//                                                         // state.labels?.locale.extraSecurityDeployed ??
//                                                         //     state.labels?.defaultLocale
//                                                         //         .extraSecurityDeployed ??
//                                                         Constants
//                                                             .intruderSystemOffline,
//                                                         Styles.textStyleWhite16,
//                                                           isMandatory: true
//                                                       ),
//                                                       Opacity(
//                                                         opacity: 1,
//                                                         child: Checkbox(
//                                                             activeColor:
//                                                                 const Color(
//                                                                     0xFF071130),
//                                                             focusColor:
//                                                                 const Color(
//                                                                     0xFF071130),
//                                                             value: state.model
//                                                                 .intruderSystemOffline,
//                                                             onChanged:
//                                                                 showSaveButtons
//                                                                     ? (bool?
//                                                                         value) {
//                                                                         state.model
//                                                                                 .intruderSystemOffline =
//                                                                             value!;
//                                                                         BlocProvider.of<EventInfoCubit>(
//                                                                                 context)
//                                                                             .onCheckBoxChange(
//                                                                                 state.model);
//                                                                       }
//                                                                     : null),
//                                                       )
//                                                     ]),
//
//                                                     if (state.model
//                                                             .intruderSystemOffline ==
//                                                         true) ...[
//                                                       CommonWidgets.textDisplay(
//                                                         // state.labels?.locale.extraSecurityDeployed ??
//                                                         //     state.labels?.defaultLocale
//                                                         //         .extraSecurityDeployed ??
//                                                         Constants.startDate,
//                                                         Styles.textStyleWhite16,
//                                                           isMandatory: true
//                                                       ),
//                                                       BaseDate()
//                                                           .datePickerWidgetLoading(
//                                                         context: context,
//                                                         textController:
//                                                             intruderDateController,
//                                                         isDisabled:
//                                                             !showSaveButtons,
//                                                         onlyDate: false,
//                                                         onChange: (String value) {
//                                                           intruderDateController
//                                                               .text = value;
//                                                           log('dateControllerValue --- $value');
//                                                           state.model
//                                                                   .intruderSystemOfflineStartDate =
//                                                               value;
//                                                           BlocProvider.of<
//                                                                       EventInfoCubit>(
//                                                                   context)
//                                                               .onModelValueChange(
//                                                                   state.model);
//                                                         },
//                                                       ),
//                                                     ],
//                                                   ],
//                                                   CommonWidgets
//                                                       .verticalSpacerWidget(
//                                                       height * 0.02),
//
//
//                                                   if ((state.eventDuration == ConstantsIntValue.eventDurationAfter) &&
//                                                       widget.isAnnualPowerShutdown) ...[
//                                                     if(state.model.cctvSystemOffline == true)...[
//
//                                                       /// CCTV System Offline end Date
//                                                       CommonWidgets.textDisplay(
//                                                         // state.labels?.locale.extraSecurityDeployed ??
//                                                         //     state.labels?.defaultLocale
//                                                         //         .extraSecurityDeployed ??
//                                                           Constants.cCTvSystemOfflineEndDate,
//                                                           Styles.textStyleWhite16,
//                                                           isMandatory: true
//                                                       ),
//                                                       BaseDate()
//                                                           .datePickerWidgetLoading(
//                                                         context: context,
//                                                         textController:
//                                                         cctvEndDateController,
//                                                         isDisabled:
//                                                         !showSaveButtons,
//                                                         onlyDate: false,
//                                                         // onChange: (String value) {
//                                                         //   cctvEndDateController
//                                                         //       .text = value;
//                                                         //   log('dateControllerValue --- $value');
//                                                         //   state.model
//                                                         //       .cctvSystemOfflineEndDate =
//                                                         //       value;
//                                                         //   BlocProvider.of<
//                                                         //       EventInfoCubit>(
//                                                         //       context)
//                                                         //       .onModelValueChange(
//                                                         //       state.model);
//                                                         // },
//                                                         onChange: (String value) {
//                                                           cctvEndDateController.text = value;
//
//                                                           log('CCTV End Date --- $value');
//
//                                                           state.model.cctvSystemOfflineEndDate = value;
//
//                                                           final double? offlineHours = calculateOfflineHours(
//                                                             startDate: cctvDateController.text,
//                                                             endDate: cctvEndDateController.text,
//                                                           );
//
//                                                           if (offlineHours != null) {
//                                                             state.model.cctvSystemOfflineHours = offlineHours;
//                                                           }
//
//                                                           log(
//                                                             'CCTV Start Date --- ${cctvDateController.text}',
//                                                           );
//
//                                                           log(
//                                                             'CCTV End Date --- ${cctvEndDateController.text}',
//                                                           );
//
//                                                           log(
//                                                             'CCTV Offline Hours --- ${state.model.cctvSystemOfflineHours}',
//                                                           );
//
//                                                           BlocProvider.of<EventInfoCubit>(context)
//                                                               .onModelValueChange(state.model);
//                                                         },
//                                                       ),
//
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                         height * 0.02),
//
//                                                     /// CCTV System offline Hours
//                                                     CommonWidgets.textDisplay(
//                                                         Constants.cCTvSystemOfflineHours,
//                                                         Styles.textStyleWhite14,
//                                                         isMandatory: true),
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                         height * 0.01),
//                                                     FlutterInputField(
//                                                       textInputType:
//                                                       TextInputType.text,
//                                                       initialValue:
//                                                       '${state.model.cctvSystemOfflineHours ?? ''}',
//                                                       textFormKey:
//                                                       Keys.lsm1ContactNOKey,
//                                                       hintText: '',
//                                                       isEnable:  false,
//                                                       characterLimit: Constants
//                                                           .characterLimitContactNo,
//                                                       isDisableColor: true,
//                                                       onChange: (String value) {
//                                                       },
//                                                       validateTextField:
//                                                           (String? user) {},
//                                                     ),
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                         height * 0.02),
// ],
//                                                     if(state.model.accessSystemOffline == true)...[
//
//                     /// Access System Offline end Date
//
//                                                     CommonWidgets.textDisplay(
//                                                         // state.labels?.locale.extraSecurityDeployed ??
//                                                         //     state.labels?.defaultLocale
//                                                         //         .extraSecurityDeployed ??
//                                                           Constants.accessSystemOfflineEndDate,
//                                                           Styles.textStyleWhite16,
//                                                           isMandatory: true
//                                                       ),
//                                                       BaseDate()
//                                                           .datePickerWidgetLoading(
//                                                         context: context,
//                                                         textController:
//                                                         accessEndDateController,
//                                                         isDisabled:
//                                                         !showSaveButtons,
//                                                         onlyDate: false,
//                                                         onChange: (String value) {
//                                                           accessEndDateController
//                                                               .text = value;
//                                                           log('dateControllerValue --- $value');
//                                                           state.model
//                                                               .accessSystemOfflineEndDate =
//                                                               value;
//                                                           BlocProvider.of<
//                                                               EventInfoCubit>(
//                                                               context)
//                                                               .onModelValueChange(
//                                                               state.model);
//                                                         },
//                                                       ),
//
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                         height * 0.02),
//
//
//                                                     /// Access System offline Hours
//                                                     CommonWidgets.textDisplay(
//                                                         Constants.accessSystemOfflineHours,
//                                                         Styles.textStyleWhite14,
//                                                         isMandatory: true),
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                         height * 0.01),
//                                                     FlutterInputField(
//                                                       textInputType:
//                                                       TextInputType.text,
//                                                       initialValue:
//                                                       '${state.model.accessSystemOfflineHours ?? ''}',
//                                                       textFormKey:
//                                                       Keys.lsm1ContactNOKey,
//                                                       hintText: '',
//                                                       isEnable:  false,
//                                                       characterLimit: Constants
//                                                           .characterLimitContactNo,
//                                                       isDisableColor: true,
//                                                       onChange: (String value) {
//                                                       },
//                                                       validateTextField:
//                                                           (String? user) {},
//                                                     ),
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                         height * 0.02),
//                                                     ],
//                                                     // /// Intruder System Offline End Date
//                                                     //   CommonWidgets.textDisplay(
//                                                     //     // state.labels?.locale.extraSecurityDeployed ??
//                                                     //     //     state.labels?.defaultLocale
//                                                     //     //         .extraSecurityDeployed ??
//                                                     //       Constants.intruderSystemOfflineEndDate,
//                                                     //       Styles.textStyleWhite16,
//                                                     //       isMandatory: true
//                                                     //   ),
//                                                     //   BaseDate()
//                                                     //       .datePickerWidgetLoading(
//                                                     //     context: context,
//                                                     //     textController:
//                                                     //     intruderDateController,
//                                                     //     isDisabled:
//                                                     //     !showSaveButtons,
//                                                     //     onlyDate: false,
//                                                     //     onChange: (String value) {
//                                                     //       intruderDateController
//                                                     //           .text = value;
//                                                     //       log('dateControllerValue --- $value');
//                                                     //       state.model
//                                                     //           .intruderSystemOfflineEndDate =
//                                                     //           value;
//                                                     //       BlocProvider.of<
//                                                     //           EventInfoCubit>(
//                                                     //           context)
//                                                     //           .onModelValueChange(
//                                                     //           state.model);
//                                                     //     },
//                                                     //   ),
//                                                   ],
//                                                   CommonWidgets
//                                                       .verticalSpacerWidget(
//                                                       height * 0.02),
//                                                   if (state.eventDuration ==
//                                                           ConstantsIntValue
//                                                               .eventDurationAfter &&
//                                                      !widget
//                                                           .isAnnualPowerShutdown ) ...[
//                                                     ///Total Attendies
//                                                     CommonWidgets.textDisplay(
//                                                         Constants.totalAttendies,
//                                                         Styles.textStyleWhite14,
//                                                         isMandatory: true),
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                             height * 0.01),
//                                                     FlutterInputField(
//                                                       textInputType:
//                                                           TextInputType.text,
//                                                       initialValue:
//                                                           '${state.model.totalAttendance ?? ''}',
//                                                       textFormKey:
//                                                           Keys.lsm1ContactNOKey,
//                                                       hintText: '',
//                                                       isEnable: showSaveButtons
//                                                           ? true
//                                                           : false,
//                                                       characterLimit: Constants
//                                                           .characterLimitContactNo,
//                                                       isDisableColor:
//                                                           showSaveButtons
//                                                               ? false
//                                                               : true,
//                                                       onChange: (String value) {
//                                                         state.model
//                                                                 .totalAttendance =
//                                                             int.tryParse(value);
//                                                         context
//                                                             .read<
//                                                                 EventInfoCubit>()
//                                                             .onModelValueChange(
//                                                                 state.model);
//                                                       },
//                                                       validateTextField:
//                                                           (String? user) {},
//                                                     ),
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                             height * 0.02),
//                                                   ],
//
//
//                                                   /// View Email Notification List
//                                                   CommonWidgets.textDisplay(
//                                                       'View Notifications',
//                                                       Styles.textStyleWhite14),
//
//                                                   CommonWidgets
//                                                       .verticalSpacerWidget(
//                                                           height * 0.02),
//
//                                                   ///  TEMPLATE LIST
//                                                   Container(
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               7),
//                                                       border: Border.all(
//                                                           color: Colors.white,
//                                                           width: .7),
//                                                     ),
//                                                     child: Column(
//                                                       children: [
//                                                         /// ===== HEADER =====
//                                                         Container(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                                   horizontal: 16,
//                                                                   vertical: 12),
//                                                           color: Colors.white
//                                                               .withValues(
//                                                                   alpha: 0.1),
//                                                           child: Row(
//                                                             children: [
//                                                               const Expanded(
//                                                                 child: Text(
//                                                                   "Id",
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               IconButton(
//                                                                 icon: showSaveButtons
//                                                                     ?
//                                                                 const Icon(
//                                                                         Icons.add,
//                                                                         color: Colors
//                                                                             .white)
//                                                                     : const SizedBox(),
//                                                                 tooltip:
//                                                                     'Fetch Template',
//                                                                 onPressed: showSaveButtons ?
//                                                                     () async {
//                                                                   try {
//                                                                     final cubit =
//                                                                         context.read<
//                                                                             EventInfoCubit>();
//                                                                     cubit
//                                                                         .clearAttachments();
//                                                                     context
//                                                                         .read<
//                                                                             EventInfoCubit>()
//                                                                         .clearAttachments();
//                                                                     final response =
//                                                                         await context
//                                                                             .read<
//                                                                                 EventInfoCubit>()
//                                                                             .getNotificationDetailsById(
//                                                                               widget.eventProtectionId,
//                                                                             );
//
//                                                                     // context.read<EventInfoCubit>().addAttachment(response.images ?? []);
//                                                                     final html =
//                                                                         response
//                                                                             .notification;
//                                                                     if (html ==
//                                                                             null ||
//                                                                         html
//                                                                             .trim()
//                                                                             .isEmpty) {
//                                                                       debugPrint(
//                                                                           "HTML is empty");
//                                                                       return;
//                                                                     }
//                                                                     openTemplatePreview(
//                                                                       html: html,
//                                                                       templateId:
//                                                                           null,
//                                                                     );
//                                                                   } catch (e, s) {
//                                                                     debugPrint(
//                                                                         "Failed to load template: $e");
//                                                                     debugPrintStack(
//                                                                         stackTrace:
//                                                                             s);
//                                                                   }
//                                                                 } : null,
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//
//                                                         /// ===== LOADER =====
//                                                         if (state
//                                                                 .isTemplateLoading ==
//                                                             true)
//                                                           const Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     12),
//                                                             child:
//                                                                 CircularProgressIndicator(
//                                                                     color: Colors
//                                                                         .white),
//                                                           ),
//
//                                                         /// ===== EMPTY STATE =====
//                                                         if (state.isTemplateLoading ==
//                                                                 false &&
//                                                             (state.emailTemplates!
//                                                                 .isEmpty))
//                                                           const Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     12),
//                                                             child: Text(
//                                                               "No templates loaded",
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .white70),
//                                                             ),
//                                                           ),
//
//                                                         /// ===== TEMPLATE LIST =====
//                                                         ...?state.emailTemplates
//                                                             ?.map((item) {
//                                                           return Container(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .symmetric(
//                                                                     horizontal:
//                                                                         20,
//                                                                     vertical: 10),
//                                                             decoration:
//                                                                 const BoxDecoration(
//                                                               border: Border(
//                                                                 bottom: BorderSide(
//                                                                     color: Colors
//                                                                         .white24),
//                                                               ),
//                                                             ),
//                                                             child: Row(
//                                                               children: [
//                                                                 Expanded(
//                                                                   child: Text(
//                                                                     item["id"]
//                                                                         .toString(),
//                                                                     style: Styles
//                                                                         .textStyleWhite14,
//                                                                   ),
//                                                                 ),
//                                                                 isLoading
//                                                                     ? const SizedBox(
//                                                                         width: 24,
//                                                                         height:
//                                                                             24,
//                                                                         child:
//                                                                             CircularProgressIndicator(
//                                                                           strokeWidth:
//                                                                               2,
//                                                                           color: Colors
//                                                                               .white,
//                                                                         ),
//                                                                       )
//                                                                     : IconButton(
//                                                                         icon:
//                                                                             const Icon(
//                                                                           Icons
//                                                                               .remove_red_eye,
//                                                                           color: Colors
//                                                                               .white,
//                                                                         ),
//                                                                         onPressed:
//                                                                             () async {
//                                                                           final id =
//                                                                               item["id"];
//                                                                           if (id ==
//                                                                               null) {
//                                                                             return;
//                                                                           }
//
//                                                                           setState(
//                                                                               () {
//                                                                             isLoading =
//                                                                                 true;
//                                                                           });
//
//                                                                           try {
//                                                                             final cubit =
//                                                                                 context.read<EventInfoCubit>();
//
//                                                                             cubit
//                                                                                 .clearAttachments();
//
//                                                                             final response =
//                                                                                 await cubit.getNotificationById(id.toString());
//
//                                                                             debugPrint(
//                                                                                 "API images: ${response.images}");
//                                                                             debugPrint(
//                                                                                 "API images length: ${response.images?.length}");
//
//                                                                             cubit.addAttachment(
//                                                                                 response.images);
//
//                                                                             final html =
//                                                                                 response.notification;
//                                                                             if (html == null ||
//                                                                                 html.trim().isEmpty) {
//                                                                               debugPrint("HTML is empty");
//                                                                               return;
//                                                                             }
//
//                                                                             // await Future.delayed(const Duration(milliseconds: 10));
//
//                                                                             if (!context
//                                                                                 .mounted) {
//                                                                               return;
//                                                                             }
//
//                                                                             openTemplatePreview(
//                                                                               html:
//                                                                                   html,
//                                                                               templateId:
//                                                                                   id as int?,
//                                                                             );
//                                                                           } catch (e, s) {
//                                                                             debugPrint(
//                                                                                 "Failed to load template: $e");
//                                                                             debugPrintStack(
//                                                                                 stackTrace: s);
//                                                                           } finally {
//                                                                             if (mounted) {
//                                                                               setState(() {
//                                                                                 isLoading = false;
//                                                                               });
//                                                                             }
//                                                                           }
//                                                                         },
//                                                                       ),
//                                                               ],
//                                                             ),
//                                                           );
//                                                         }),
//                                                       ],
//                                                     ),
//                                                   ),
//
//                                                   CommonWidgets
//                                                       .verticalSpacerWidget(
//                                                           height * 0.02),
//
//                                                   /// Will show for only Event Protection
//                                                     if ((widget
//                                                         .isEventProtection && state.eventDuration ==
//                                                         ConstantsIntValue
//                                                             .eventDurationAfter) || (widget.isCSREventProtection && state.eventDuration ==
//                                                         ConstantsIntValue
//                                                             .eventDurationAfter) ||( widget.isAnnualPowerShutdown  && state.eventDuration == ConstantsIntValue
//                                                         .eventDurationAfter)) ...[
//                                                       Center(
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             /// Add Button
//                                                             // OpacityAbsorbInkWellWidget(
//                                                             //   absorbing:
//                                                             //       !showSaveButtons,
//                                                             //   onTap: () {
//                                                             //     Navigator
//                                                             //         .pushNamed(
//                                                             //       context,
//                                                             //       articleFoundNewDetailsRoute,
//                                                             //       arguments: {
//                                                             //         ConstantsArgument
//                                                             //                 .eventId:
//                                                             //             state
//                                                             //                 .model
//                                                             //                 .id,
//                                                             //         ConstantsArgument
//                                                             //                 .eventProtectionId:
//                                                             //             widget
//                                                             //                 .eventProtectionId,
//                                                             //         ConstantsArgument
//                                                             //                 .location:
//                                                             //             state
//                                                             //                 .model
//                                                             //                 .location,
//                                                             //         ConstantsArgument.title: "Article Found",
//                                                             //       },
//                                                             //     );
//                                                             //   },
//                                                             //   child:
//                                                             //       const AddViewButton(
//                                                             //     label:
//                                                             //         'Add Article Found',
//                                                             //
//                                                             //   ),
//                                                             // ),
//                                                             /// Add Button
//                                                             OpacityAbsorbInkWellWidget(
//                                                               absorbing: !showSaveButtons,
//                                                               onTap: () async {
//                                                                 await Navigator.pushNamed(
//                                                                   context,
//                                                                   articleFoundNewDetailsRoute,
//                                                                   arguments: {
//                                                                     ConstantsArgument.eventId: state.model.id,
//                                                                     ConstantsArgument.eventProtectionId: widget.eventProtectionId,
//                                                                     ConstantsArgument.location: state.model.location,
//                                                                     ConstantsArgument.title: "Article Found",
//                                                                   },
//                                                                 );
//
//                                                                 if (!context.mounted) return;
//
//                                                                 BlocProvider.of<EventInfoCubit>(context).initializeValues();
//                                                               },
//                                                               child: const AddViewButton(
//                                                                 label: 'Add Article Found',
//                                                               ),
//                                                             ),
//
//                                                             /// Show List Button
//                                                             if (!state
//                                                                     .foundArticles
//                                                                     .isEmptyOrNull
//                                                                 // && state.model.status! >= 22
//                                                                 ) ...[
//                                                               submitButtonDisplay(
//                                                                 label: Constants
//                                                                     .showList,
//                                                                 onTap: () {
//                                                                   Navigator
//                                                                       .pushNamed(
//                                                                     context,
//                                                                     articleFoundNewListRoute,
//                                                                     arguments: {
//                                                                       ConstantsArgument
//                                                                               .eventId:
//                                                                           state
//                                                                               .model
//                                                                               .id,
//                                                                       ConstantsArgument
//                                                                               .eventProtectionId:
//                                                                           widget
//                                                                               .eventProtectionId,
//                                                                     },
//                                                                   );
//                                                                 },
//                                                               ),
//                                                             ],
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                     CommonWidgets
//                                                         .verticalSpacerWidget(
//                                                             height * 0.02),
//
//                                                 ],
//                                               ),
//                                             ),
//                                             CommonWidgets.verticalSpacerWidget(
//                                                 height * 0.02),
//                                           ],
//                                         ),
//                                       ),
//
//                                       /// SubmitButton
//                                       // Row(
//                                       //   mainAxisAlignment:
//                                       //       MainAxisAlignment.spaceEvenly,
//                                       //   children: [
//                                       //     cancelButtonDisplay(),
//                                       //     if (showSaveButtons) ...[
//                                       //       submitButtonDisplay(
//                                       //         onTap: () async {
//                                       //           FocusScope.of(context).unfocus();
//                                       //           BlocProvider.of<EventInfoCubit>(
//                                       //                   context)
//                                       //               .submitForm(
//                                       //                   isSaveOnly: false,
//                                       //                   updatedEmailText:
//                                       //                       updatedEmailText ??
//                                       //                           '');
//                                       //         },
//                                       //       ),
//                                       //     ],
//                                       //   ],
//                                       // ),
//                                       CommonWidgets.verticalSpacerWidget(
//                                           height * 0.04),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                               // ),
//                             )));
//                   }),
//                 ],
//               ),
//             );
//           });
//     }
//
//     void openTemplatePreview({
//       required String html,
//       int? templateId,
//     }) {
//       Navigator.push(
//         context,
//         PageRouteBuilder(
//           //  replace MaterialPageRoute
//           opaque: true, //  hides previous page completely
//           pageBuilder: (_, __, ___) => BlocProvider.value(
//             value: context.read<EventInfoCubit>(),
//             child: TemplatePreviewPage(
//               html: html,
//               templateId: templateId,
//               eventProtectionId: widget.eventProtectionId,
//               showSaveButtons: showSaveButtons,
//               getFiles: getFiles,
//             ),
//           ),
//         ),
//       );
//     }
//
//     void addEmail() {
//       final exampleCubit = context.read<EventInfoCubit>();
//       showDialog(
//         context: context,
//         builder: (dialogContext) {
//           return BlocProvider<EventInfoCubit>.value(
//             value: exampleCubit,
//             child: BlocBuilder<EventInfoCubit, EventInfoState>(
//               builder: (context, state) {
//                 var height = MediaQuery.of(dialogContext).size.height;
//                 var width = MediaQuery.of(dialogContext).size.width;
//                 return AlertDialog(
//                   backgroundColor: Colors.transparent, //  important for gradient
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   content: Container(
//                     height: height * 0.25,
//                     width: width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color(0xFF2C3550), // dark blue
//                           Color(0xFF3E4A6B), // lighter blue
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       border: Border.all(
//                         color:
//                             Colors.white.withValues(alpha: 0.5), // subtle border
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Column(
//                         children: [
//                           CommonWidgets.textDisplay(
//                             Constants.additionalEmails,
//                             Styles.textStyleWhite16, //  change to white
//                           ),
//                           CommonWidgets.verticalSpacerWidget(height * 0.01),
//                           FlutterInputField(
//                             lineHeight: 1,
//                             controller: addEmailController,
//                             textFormKey: Keys.equipmentNoKey,
//                             hintText: 'Enter email',
//                             isEnable: true,
//                             isDisableColor: false,
//                             onChange: (String value) {},
//                             validateTextField: (String value) {},
//                           ),
//                           if (state.status == FormStatus.invalidEmail) ...[
//                             const SizedBox(height: 6),
//                             const Text(
//                               'Please enter a valid email',
//                               style: TextStyle(color: Colors.redAccent),
//                             ),
//                           ],
//                           const Spacer(),
//                           submitButtonDisplay(
//                             onTap: () {
//                               BlocProvider.of<EventInfoCubit>(this.context)
//                                   .onAddEmail(addEmailController.text);
//
//                               if (EmailValidator.validate(
//                                   addEmailController.text)) {
//                                 addEmailController.clear();
//                                 Navigator.pop(dialogContext);
//                               }
//                               // Navigator.pop(context);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       );
//     }
//
//     Widget cancelButtonDisplay() {
//       return AppButton(
//         width: Constants.cancelButtonWidth,
//         backgroundColor: Colors.white,
//         key: const Key(Keys.cancelButton),
//         buttonText: Constants.close,
//         buttonTextKey: Keys.cancelButton,
//         onTap: () {
//           Navigator.pop(context);
//           CommonServices().unlock();
//         },
//       );
//     }
//
//     Widget submitButtonDisplay({
//       required Function onTap,
//       String? label = Constants.submit,
//     }) {
//       return AppButton(
//         width: 150,
//         buttonText: label,
//         buttonTextKey: Keys.submitButton,
//         onTap: onTap,
//       );
//     }
//
//     void onPressedRemoveEmail(String email) {
//       BlocProvider.of<EventInfoCubit>(context).removeEmail(email);
//     }
//
//     Widget getEmail(List<String> emails) {
//       List<Widget> widgets = [];
//
//       for (String email in emails) {
//         widgets.add(Row(
//           children: [
//             Text(
//               email,
//               textAlign: TextAlign.start,
//               style: Styles.textStyleWhite14,
//             ),
//             Opacity(
//               opacity: showSaveButtons ? 1 : 0.5,
//               child: IconButton(
//                 icon: const Icon(
//                   Icons.delete,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   if (showSaveButtons) {
//                     onPressedRemoveEmail(email);
//                   }
//                   // onPressedRemoveEmail(email);
//                 },
//               ),
//             ),
//           ],
//         ));
//         widgets.add(const SizedBox(height: 2));
//       }
//
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: widgets,
//       );
//     }
//
//     ///[getHtmlText] to get the html text from editor
//     Future<String> getHtmlText() async {
//       String? htmlText = await quillController.getText();
//       debugPrint(htmlText);
//       return htmlText;
//     }
//
//     void setHtmlText(String text) {
//       quillController.setText(text); // just call it, don't await
//     }
//
//     // void insertNetworkImage(String url) {
//     //   quillController.insertNetworkImage(url: url); // just call it
//     // }
//
//     // void insertHtmlText(String text) {
//     //   quillController.insertHtml(html: text); // just call it
//     // }
//
//     void clearEditor() {
//       quillController.clear(); // call directly
//     }
//
//     void enableEditor(bool enable) {
//       quillController.enable(); // call directly
//     }
//
//     Widget uploadWidget(EventInfoState state) {
//       return Container(
//         height: 60,
//         decoration: BoxDecoration(
//             border: Border.all(
//               color: const Color(0xFFCACACA),
//               width: 1.0,
//             ),
//             borderRadius: const BorderRadius.all(Radius.circular(8))),
//         child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//           Padding(
//             padding: const EdgeInsets.only(right: 5.0),
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 fixedSize: const Size(120, 50),
//                 backgroundColor: Colors.transparent,
//               ),
//               onPressed: () {
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext dialogContext) {
//                       return UploadAttachment(
//                         // userdetails: state.loggedInUserDetails ?? User(),
//                         // getFiles: getFiles,
//                         // inwardState: state,
//                         onImageSelected: (ImageContent data) {
//                           log('-------function---onImageSelected---------');
//                           List<ImageContent>? files = [];
//                           files.add(data);
//                           for (ImageContent image in getFiles.toList()) {
//                             files.add(image);
//                           }
//                           BlocProvider.of<EventInfoCubit>(context)
//                               .addAttachment(files);
//                         },
//                       );
//                     });
//               },
//
//               icon: SvgPicture.asset(
//                 //AppIcon.dropdownicon,
//                 AppIcon.uploadIcon,
//                 //fit: BoxFit.,
//                 colorFilter: const ColorFilter.mode(
//                   AppColors.backgroundWhiteColor,
//                   BlendMode.srcIn,
//                 ),
//                 // color: AppColors.backgroundWhiteColor,
//                 width: 13,
//                 height: 13,
//                 key: const Key(Keys.userIcon),
//               ),
//               label: const Text(
//                 Constants.clicktoupload,
//                 style: Styles.textStyleRegularNormalWhite12,
//               ), // <-- Text
//             ),
//           ),
//         ]),
//       );
//     }
//   }
//
//   class TemplatePreviewPage extends StatefulWidget {
//     const TemplatePreviewPage({
//       super.key,
//       required this.html,
//       required this.templateId,
//       required this.eventProtectionId,
//       required this.showSaveButtons,
//       required this.getFiles,
//     });
//
//     final String html;
//     final int? templateId;
//     final String eventProtectionId;
//     final bool showSaveButtons;
//     final List<ImageContent> getFiles;
//
//     @override
//     State<TemplatePreviewPage> createState() => _TemplatePreviewPageState();
//   }
//
//   class _TemplatePreviewPageState extends State<TemplatePreviewPage> {
//     final HtmlEditorController quillController = HtmlEditorController();
//     List<ImageContent> localAttachments = [];
//
//     @override
//     Widget build(BuildContext context) {
//       final height = MediaQuery.of(context).size.height;
//       final width = MediaQuery.of(context).size.width;
//
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF2C3550),
//           title: Text(
//             widget.templateId == null
//                 ? "Create Email Template"
//                 : "Edit Email Template #${widget.templateId}",
//             style: const TextStyle(color: Colors.white, fontSize: 16),
//           ),
//           iconTheme: const IconThemeData(color: Colors.white),
//           actions: [
//             if (widget.templateId == null)
//               IconButton(
//                 tooltip: "Submit",
//                 icon: const Icon(Icons.send, color: Colors.white),
//                 onPressed: () async {
//                   final html = await quillController.getText();
//                   if (html.trim().isEmpty) return;
//
//                   await context.read<EventInfoCubit>().submitTemplateAndRefresh(
//                         html: html,
//                         id: widget.templateId,
//                       );
//
//                   await context
//                       .read<EventInfoCubit>()
//                       .getNotificationDetailsById(widget.eventProtectionId);
//
//                   if (context.mounted) Navigator.pop(context);
//                 },
//               ),
//             IconButton(
//               tooltip: "Close",
//               icon: const Icon(Icons.close, color: Colors.white),
//               onPressed: () async {
//                 await context
//                     .read<EventInfoCubit>()
//                     .getNotificationDetailsById(widget.eventProtectionId);
//                 if (context.mounted) Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             /// Background
//             Positioned.fill(
//               child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
//             ),
//
//             /// Blur overlay
//             Positioned.fill(
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
//                 child: Container(
//                   color: Colors.black.withValues(alpha: 0.15),
//                 ),
//               ),
//             ),
//
//             /// Content
//             BlocBuilder<EventInfoCubit, EventInfoState>(
//               builder: (context, state) {
//                 final isLoading = state.status == FormStatus.loading;
//
//                 return Stack(
//                   children: [
//                     /// ===== MAIN CONTENT =====
//                     Column(
//                       children: [
//                         /// ===== HTML EDITOR =====
//                         SizedBox(
//                           height: height * 0.5,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             child: HtmlEditor(
//                               controller: quillController,
//                               htmlToolbarOptions: const HtmlToolbarOptions(
//                                 toolbarPosition: ToolbarPosition.aboveEditor,
//                                 textStyle: Styles.textStyleBlack16,
//                               ),
//                               htmlEditorOptions: HtmlEditorOptions(
//                                 darkMode: false,
//                                 initialText: widget.html,
//                                 autoAdjustHeight: false,
//                               ),
//                               otherOptions: OtherOptions(height: height * 1.2),
//                               callbacks: Callbacks(
//                                 onInit: () {
//                                   quillController.setText("""
//   <style>
//   body { background-color: transparent !important; color: white !important; }
//   * { color: white !important; }
//   </style>
//   ${widget.html}
//   """);
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 20),
//
//                         /// ===== UPLOAD =====
//                         if (widget.showSaveButtons)
//                           // Padding(
//                           //   padding: const EdgeInsets.symmetric(horizontal: 12),
//                           //   child: Column(
//                           //     crossAxisAlignment: CrossAxisAlignment.start,
//                           //     children: [
//                           //       CommonWidgets.textDisplay(
//                           //         Constants.upload,
//                           //         Styles.textStyleWhite16,
//                           //       ),
//                           //       _uploadWidget(context, state),
//                           //     ],
//                           //   ),
//                           // ),
//
//
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CommonWidgets.textDisplay(
//                                   Constants.upload,
//                                   Styles.textStyleWhite16,
//                                 ),
//                                 _uploadWidget(context, state),
//                               ],
//                             ),
//                           ),
//
//                         const SizedBox(height: 12),
//                         const SizedBox(height: 12),
//
//                         /// ===== ATTACHMENTS =====
//                         // if ((state.loadAttachments ?? []).isNotEmpty)
//                         //   Expanded(
//                         //     child: Padding(
//                         //       padding: const EdgeInsets.symmetric(horizontal: 12),
//                         //       child: Container(
//                         //         width: width,
//                         //         decoration: BoxDecoration(
//                         //           borderRadius: BorderRadius.circular(12),
//                         //           border: Border.all(
//                         //             color: Colors.white.withValues(alpha: 0.35),
//                         //             width: 0.8,
//                         //           ),
//                         //           color: Colors.white.withValues(alpha: 0.03),
//                         //         ),
//                         //         child: ClipRRect(
//                         //           borderRadius: BorderRadius.circular(12),
//                         //           child: SingleChildScrollView(
//                         //             padding: const EdgeInsets.all(8),
//                         //             child: BaseImageUpload().getAttachment(
//                         //               height: height,
//                         //               attachments: List<ImageContent>.from(
//                         //                   state.loadAttachments ?? []),
//                         //               files: List<ImageContent>.from(
//                         //                   state.loadAttachments ?? []),
//                         //               moduleCode: '',
//                         //               isDisabled: !widget.showSaveButtons,
//                         //               showDeleteIcon: true,
//                         //             ),
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     ),
//                         //   ),
//                         // if ((state.loadAttachments ?? []).isNotEmpty)
//                           // Expanded(
//                           //   child: Padding(
//                           //     padding: const EdgeInsets.symmetric(horizontal: 12),
//                           //     child: Container(
//                           //       width: width,
//                           //       decoration: BoxDecoration(
//                           //         borderRadius: BorderRadius.circular(12),
//                           //         border: Border.all(
//                           //           color: Colors.white.withValues(alpha: 0.35),
//                           //           width: 0.8,
//                           //         ),
//                           //         color: Colors.white.withValues(alpha: 0.03),
//                           //       ),
//                           //       child: ClipRRect(
//                           //         borderRadius: BorderRadius.circular(12),
//                           //         child: SingleChildScrollView(
//                           //           padding: const EdgeInsets.all(8),
//                           //           child: BaseImageUpload().getAttachment(
//                           //             height: height,
//                           //             attachments: List<ImageContent>.from(
//                           //                 state.loadAttachments ?? []),
//                           //             files: List<ImageContent>.from(
//                           //                 state.loadAttachments ?? []),
//                           //             moduleCode: '',
//                           //             isDisabled: widget.templateId != null,
//                           //             showDeleteIcon: widget.templateId == null,
//                           //             onDelete: (index, imageData) {
//                           //               context.read<EventInfoCubit>().removeAttachment(imageData);
//                           //             },
//                           //           ),
//                           //         ),
//                           //       ),
//                           //     ),
//                           //   ),
//                           // ),
//
//                           if ((state.loadAttachments ?? []).isNotEmpty)
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                                 child: Container(
//                                   width: width,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(
//                                       color: Colors.white.withValues(alpha: 0.35),
//                                       width: 0.8,
//                                     ),
//                                     color: Colors.white.withValues(alpha: 0.03),
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: SingleChildScrollView(
//                                       padding: const EdgeInsets.all(8),
//                                       child: BaseImageUpload().getAttachment(
//                                         height: height,
//                                         attachments: List<ImageContent>.from(
//                                             state.loadAttachments ?? []),
//                                         files: List<ImageContent>.from(
//                                             state.loadAttachments ?? []),
//                                         moduleCode: '',
//                                         isDisabled: widget.templateId != null,
//                                         showDeleteIcon: widget.templateId == null,
//                                         onDelete:  (index, imageData) {
//                                           context.read<EventInfoCubit>().removeAttachment(imageData);
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                         SizedBox(height: height * 0.015),
//                       ],
//                     ),
//
//                     /// ===== BLUR LOADER OVERLAY =====
//                     if (isLoading)
//                       Positioned.fill(
//                         child: BackdropFilter(
//                           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                           child: Container(
//                             color: Colors.transparent,
//                             child: const Center(
//                               child:
//                                   CircularProgressIndicator(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 );
//               },
//             )
//           ],
//         ),
//       );
//     }
//
//     // Widget _uploadWidget(BuildContext context, EventInfoState state) {
//     //   return Container(
//     //     height: 60,
//     //     decoration: BoxDecoration(
//     //       border: Border.all(color: const Color(0xFFCACACA), width: 1.0),
//     //       borderRadius: const BorderRadius.all(Radius.circular(8)),
//     //     ),
//     //     child: Row(
//     //       mainAxisAlignment: MainAxisAlignment.end,
//     //       children: [
//     //         Padding(
//     //           padding: const EdgeInsets.only(right: 5.0),
//     //           child: ElevatedButton.icon(
//     //             style: ElevatedButton.styleFrom(
//     //               fixedSize: const Size(120, 50),
//     //               backgroundColor: Colors.transparent,
//     //             ),
//     //             onPressed: () {
//     //               showDialog(
//     //                 context: context,
//     //                 builder: (BuildContext dialogContext) {
//     //                   return UploadAttachment(
//     //                     onImageSelected: (ImageContent data) {
//     //                       List<ImageContent> files = [];
//     //                       files.add(data);
//     //                       for (ImageContent image in widget.getFiles.toList()) {
//     //                         files.add(image);
//     //                       }
//     //                       context.read<EventInfoCubit>().addAttachment(files);
//     //                     },
//     //                   );
//     //                 },
//     //               );
//     //             },
//     //             icon: SvgPicture.asset(
//     //               AppIcon.uploadIcon,
//     //               colorFilter: const ColorFilter.mode(
//     //                 AppColors.backgroundWhiteColor,
//     //                 BlendMode.srcIn,
//     //               ),
//     //               width: 13,
//     //               height: 13,
//     //             ),
//     //             label: const Text(
//     //               Constants.clicktoupload,
//     //               style: Styles.textStyleRegularNormalWhite12,
//     //             ),
//     //           ),
//     //         ),
//     //       ],
//     //     ),
//     //   );
//     // }
//     Widget _uploadWidget(
//         BuildContext context, EventInfoState state) {
//       return Container(
//         height: 60,
//         decoration: BoxDecoration(
//           border: Border.all(color: const Color(0xFFCACACA), width: 1.0),
//           borderRadius: const BorderRadius.all(Radius.circular(8)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 5.0),
//               child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   fixedSize: const Size(120, 50),
//                   backgroundColor: Colors.transparent,
//                 ),
//                 onPressed: widget.templateId == null
//                     ? () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext dialogContext) {
//                       return UploadAttachment(
//                         // onImageSelected: (ImageContent data) {
//                         //   final updated = [
//                         //     data,
//                         //     ...localAttachments
//                         //   ]; //  prepend
//                         //   setState(() {
//                         //     localAttachments =
//                         //         updated; //  instant UI update
//                         //   });
//                         //   context
//                         //       .read<EventInfoCubit>()
//                         //       .addAttachment(updated); //  sync cubit
//                         // },
//                         onImageSelected: (ImageContent data) {
//                           final current = List<ImageContent>.from(state.loadAttachments ?? []);
//                           final updated = [data, ...current];
//                           context.read<EventInfoCubit>().addAttachment(updated);
//                         },
//                       );
//                     },
//                   );
//                 }
//                     : null,
//                 icon: widget.templateId == null
//                     ? SvgPicture.asset(
//                   AppIcon.uploadIcon,
//                   colorFilter: const ColorFilter.mode(
//                     AppColors.backgroundWhiteColor,
//                     BlendMode.srcIn,
//                   ),
//                   width: 13,
//                   height: 13,
//                 )
//                     : null,
//                 label: const Text(
//                   Constants.clicktoupload,
//                   style: Styles.textStyleRegularNormalWhite12,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }


import 'dart:core';
import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/base_widget/opacity_absorb_widget.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

class EventInfoView extends StatefulWidget {
  const EventInfoView({
    super.key,
    required this.title,
    required this.editForm,
    required this.isEventProtection,
    required this.eventProtectionId,
    required this.isCSREventProtection,
    required this.isSportEventProtection,
    this.isAnnualPowerShutdown = false,
  });

  final String title;
  final bool editForm;
  final bool isEventProtection;
  final String eventProtectionId;
  final bool isCSREventProtection;
  final bool isSportEventProtection;
  final bool isAnnualPowerShutdown;
  @override
  State<EventInfoView> createState() => _EventInfoViewState();
}

class _EventInfoViewState extends State<EventInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final QuillEditorController quillController = QuillEditorController();
  final HtmlEditorController quillController = HtmlEditorController();

  User? userDetails;
  List<ImageContent>? guardFiles;
  List<ImageContent> getFiles = [];
  TextEditingController dateController = TextEditingController();
  TextEditingController addEmailController = TextEditingController();
  TextEditingController cctvDateController = TextEditingController();
  TextEditingController accessDateController = TextEditingController();
  TextEditingController intruderDateController = TextEditingController();
  TextEditingController cctvEndDateController = TextEditingController();
  TextEditingController accessEndDateController = TextEditingController();
  TextEditingController intruderEndDateController = TextEditingController();

  // Dedicated controllers for the read-only "Offline Hours" fields.
  // FlutterInputField only applies `initialValue` once (inside its own
  // internal State.initState) and ignores it on later rebuilds, so simply
  // recomputing state.model.cctvSystemOfflineHours / accessSystemOfflineHours
  // and passing it back in as `initialValue` never refreshes the on-screen
  // text — the model value changes (as seen in the logs) but the field
  // stays blank. Driving the field with an explicit controller instead,
  // and setting `.text` ourselves whenever the hours are recalculated,
  // makes the UI actually update.
  TextEditingController cctvOfflineHoursController = TextEditingController();
  TextEditingController accessOfflineHoursController = TextEditingController();
  TextEditingController intruderOfflineHoursController = TextEditingController();

  bool showSaveButtons = false;

  String? initialisedFromDate;
  String? initialisedToDate;
  String? initialisedStartDate;
  List<Map<String, dynamic>> emailTemplateList = [];
  bool isTemplateLoading = false;
  bool isLoading = false;

  String selectedTemplateHtml = "";
  String? updatedEmailText;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EventInfoCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    dateController.dispose();
    addEmailController.dispose();
    cctvOfflineHoursController.dispose();
    accessOfflineHoursController.dispose();
    // quillController.dispose();
    super.dispose();
  }

  double? calculateOfflineHours({
    required String startDate,
    required String endDate,
  }) {
    if (startDate.trim().isEmpty ||
        endDate.trim().isEmpty) {
      log('CCTV calculation skipped: date is empty');
      return null;
    }

    try {
      final formatter =
      DateFormat(Constants.fulldateFormat);

      final DateTime start =
      formatter.parse(startDate);

      final DateTime end =
      formatter.parse(endDate);

      log('Parsed CCTV Start: $start');
      log('Parsed CCTV End: $end');

      if (end.isBefore(start)) {
        log(
          'CCTV End Date is before Start Date',
        );
        return null;
      }

      final Duration difference =
      end.difference(start);

      final double hours =
          difference.inMinutes / 60.0;

      log(
        'CCTV Offline Difference: '
            '${difference.inMinutes} minutes',
      );

      log(
        'CCTV Offline Hours: $hours',
      );

      return hours;
    } catch (e) {
      log(
        'CCTV offline hours calculation error: $e',
      );
      return null;
    }
  }

  String _formatOfflineHours(double hours) {
    if (hours == hours.roundToDouble()) {
      return hours.toInt().toString();
    }

    return hours.toStringAsFixed(2);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return BlocConsumer<EventInfoCubit, EventInfoState>(
        listener: (context, state) {
          if (state.status == FormStatus.formError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'Something went wrong'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          if (state.status == FormStatus.templateLoaded) {
            // just dismiss loading if you showed one, no dialog needed
            return;
          }

          if (state.status == FormStatus.success) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return CustomAlertDialog(
                  title: 'Event Protection',
                  message: state.message ?? '',
                  positiveBtnText: Constants.ok,
                  onPositivePressed: () {
                    Navigator.pop(dialogContext); // close dialog

                    if (!context.mounted) return;

                    String route;
                    Map<String, dynamic>? routeArgs;

                    if (widget.isEventProtection) {
                      route = eventProtectionListRoute;
                    } else if (widget.isCSREventProtection) {
                      route = csrEventListRoute;
                      routeArgs = {
                        ConstantsArgument.isCSREvent: true,
                        ConstantsArgument.isSportEvent: false,
                      };
                    } else if (widget.isSportEventProtection) {
                      route = csrEventListRoute;
                      routeArgs = {
                        ConstantsArgument.isCSREvent: false,
                        ConstantsArgument.isSportEvent: true,
                      };
                    } else {
                      route = annualPowerShutdownListRoute;
                    }

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      route,
                          (route) => route.isFirst, // keep the first/root route, only clear what's above it
                      arguments: routeArgs,
                    );
                  },
                );
              },
            );
            // return;
          }
          if (state.status == FormStatus.addArticleFound) {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              articleFoundNewDetailsRoute,
              arguments: {
                ConstantsArgument.eventId: state.model.id,
                ConstantsArgument.eventProtectionId: widget.eventProtectionId,
              },
            );
            return;
          }
        },
        builder: (context, state) {

          log('-ISSPORT-${widget.isSportEventProtection}---');
          log('-isCSR-${widget.isCSREventProtection}---');

          if (state.status == FormStatus.loading) {
            return const BaseLoader();
          }
          if (state.status == FormStatus.addAttachment ||
              state.status == FormStatus.initial) {
            guardFiles = state.guardAttachments ?? [];
            // guardFiles = state.model.images;
          }

          if (state.status == FormStatus.addAttachment ||
              state.status == FormStatus.initial) {
            getFiles = state.loadAttachments ?? [];
          }
          if (state.eventDuration == ConstantsIntValue.eventDurationBefore) {
            if (!state.model.eventStartedAt.isEmptyOrNull &&
                dateController.text.isEmpty) {
              log('state.model.eventStartedAt--- ${state.model.eventStartedAt}');
              dateController.text = Utils.timestampToDateConversion(
                  int.tryParse(state.model.eventStartedAt ?? '0'),
                  Constants.fulldateFormat);
            }
            initialisedFromDate = DateTime.fromMillisecondsSinceEpoch(
                (int.tryParse('${state.model.startDate}') ?? 0) * 1000)
                .toString();
            initialisedStartDate = DateTime.fromMillisecondsSinceEpoch(
                (int.tryParse('${state.model.startDate}') ?? 0) * 1000)
                .toString();
            initialisedToDate = DateTime.fromMillisecondsSinceEpoch(
                (int.tryParse('${state.model.endDate}') ?? 0) * 1000)
                .toString();
            log('initialisedToDate--- $initialisedToDate');
            log('initialisedStartDate--- $initialisedStartDate');
            log('initialisedFromDate--- $initialisedFromDate');
            log('cctvDateController--- $cctvDateController');

            if (!state.model.cctvSystemOfflineStartDate.isEmptyOrNull &&
                cctvDateController.text.isEmpty) {
              cctvDateController.text = Utils.timestampToDateConversion(
                  int.tryParse(state.model.cctvSystemOfflineStartDate ?? 'null'),
                  Constants.fulldateFormat);
            }
            if (!state.model.accessSystemOfflineStartDate.isEmptyOrNull &&
                accessDateController.text.isEmpty) {
              accessDateController.text = Utils.timestampToDateConversion(
                  int.tryParse(
                      state.model.accessSystemOfflineStartDate ?? 'null'),
                  Constants.fulldateFormat);
            }

            if (!state.model.intruderSystemOfflineStartDate.isEmptyOrNull &&
                intruderDateController.text.isEmpty) {
              intruderDateController.text = Utils.timestampToDateConversion(
                  int.tryParse(
                      state.model.intruderSystemOfflineStartDate ?? 'null'),
                  Constants.fulldateFormat);
            }

            if (!state.model.cctvSystemOfflineEndDate.isEmptyOrNull &&
                cctvEndDateController.text.isEmpty) {
              cctvEndDateController.text = Utils.timestampToDateConversion(
                  int.tryParse(state.model.cctvSystemOfflineEndDate ?? 'null'),
                  Constants.fulldateFormat);
            }
            if (!state.model.accessSystemOfflineEndDate.isEmptyOrNull &&
                accessEndDateController.text.isEmpty) {
              accessEndDateController.text = Utils.timestampToDateConversion(
                  int.tryParse(
                      state.model.accessSystemOfflineEndDate ?? 'null'),
                  Constants.fulldateFormat);
            }

            if (!state.model.intruderSystemOfflineEndDate.isEmptyOrNull &&
                intruderEndDateController.text.isEmpty) {
              intruderEndDateController.text = Utils.timestampToDateConversion(
                  int.tryParse(
                      state.model.intruderSystemOfflineEndDate ?? 'null'),
                  Constants.fulldateFormat);
            }
          }

          if (state.eventDuration == ConstantsIntValue.eventDurationAfter) {
            // Populate "Event Concluded At" from the API — this line was dropped
            // when the block was rewritten, which is why the field showed blank
            // even though the API returned eventConcludedAt.
            if (!state.model.eventConcludedAt.isEmptyOrNull &&
                dateController.text.isEmpty) {
              log('state.model.eventConcludedAt--- ${state.model.eventConcludedAt}');
              dateController.text = Utils.timestampToDateConversion(
                  int.tryParse(state.model.eventConcludedAt ?? 'null'),
                  Constants.fulldateFormat);
            }

            initialisedFromDate = DateTime.fromMillisecondsSinceEpoch(
                (int.tryParse('${state.model.eventStartedAt}') ?? 0) * 1000)
                .toString();
            initialisedStartDate = initialisedFromDate;

            final DateTime eventStart =
                DateTime.tryParse(initialisedFromDate ?? '') ?? DateTime.now();
            final DateTime currentDate = DateTime.now();

            final DateTime baseline =
            eventStart.isAfter(currentDate) ? eventStart : currentDate;
            final DateTime newDateTime = baseline.add(const Duration(days: 1));
            initialisedToDate = newDateTime.toString();

            // Populate CCTV / Access / Intruder "offline start date" fields from
            // the API. Without this, opening a record directly in "after" mode
            // leaves cctvDateController/accessDateController text empty, so
            // calculateOfflineHours() sees an empty startDate and bails out even
            // though the model already has a saved start date from the "before"
            // step — this is why Offline Hours never appeared on end-date select.
            if (!state.model.cctvSystemOfflineStartDate.isEmptyOrNull &&
                cctvDateController.text.isEmpty) {
              cctvDateController.text = Utils.timestampToDateConversion(
                  int.tryParse(state.model.cctvSystemOfflineStartDate ?? 'null'),
                  Constants.fulldateFormat);
            }
            if (!state.model.accessSystemOfflineStartDate.isEmptyOrNull &&
                accessDateController.text.isEmpty) {
              accessDateController.text = Utils.timestampToDateConversion(
                  int.tryParse(state.model.accessSystemOfflineStartDate ?? 'null'),
                  Constants.fulldateFormat);
            }
            if (!state.model.intruderSystemOfflineStartDate.isEmptyOrNull &&
                intruderDateController.text.isEmpty) {
              intruderDateController.text = Utils.timestampToDateConversion(
                  int.tryParse(state.model.intruderSystemOfflineStartDate ?? 'null'),
                  Constants.fulldateFormat);
            }

            // Populate CCTV / Access / Intruder "offline end date" fields from the
            // API. This previously only ran inside the eventDurationBefore branch,
            // so opening a record in "after" (concluded) mode never loaded these
            // saved values — the fields looked empty even though the data existed.
            if (!state.model.cctvSystemOfflineEndDate.isEmptyOrNull &&
                cctvEndDateController.text.isEmpty) {
              cctvEndDateController.text = Utils.timestampToDateConversion(
                  int.tryParse(state.model.cctvSystemOfflineEndDate ?? 'null'),
                  Constants.fulldateFormat);
            }
            if (!state.model.accessSystemOfflineEndDate.isEmptyOrNull &&
                accessEndDateController.text.isEmpty) {
              accessEndDateController.text = Utils.timestampToDateConversion(
                  int.tryParse(state.model.accessSystemOfflineEndDate ?? 'null'),
                  Constants.fulldateFormat);
            }
            if (!state.model.intruderSystemOfflineEndDate.isEmptyOrNull &&
                intruderEndDateController.text.isEmpty) {
              intruderEndDateController.text = Utils.timestampToDateConversion(
                  int.tryParse(state.model.intruderSystemOfflineEndDate ?? 'null'),
                  Constants.fulldateFormat);
            }

            // If both start and end dates are already available on load (e.g. the
            // start date was set on a previous "before" visit and the end date was
            // already saved), compute the Offline Hours immediately so the field
            // isn't blank until the user re-touches the end-date picker.
            if (state.model.cctvSystemOffline == true) {
              final double? cctvHours = calculateOfflineHours(
                startDate: cctvDateController.text,
                endDate: cctvEndDateController.text,
              );
              if (cctvHours != null) {
                state.model.cctvSystemOfflineHours = cctvHours;
                cctvOfflineHoursController.text =
                    _formatOfflineHours(cctvHours);
              }
            }
            if (state.model.accessSystemOffline == true) {
              final double? accessHours = calculateOfflineHours(
                startDate: accessDateController.text,
                endDate: accessEndDateController.text,
              );
              if (accessHours != null) {
                state.model.accessSystemOfflineHours = accessHours;
                accessOfflineHoursController.text =
                    _formatOfflineHours(accessHours);
              }
            }

            log('initialisedToDate--- $initialisedToDate');
            log('initialisedStartDate--- $initialisedStartDate');
            log('initialisedFromDate--- $initialisedFromDate');
          }
          log('--widget.editForm---${widget.editForm}--');
          log('state.model.canEdit${state.model.canEdit}--');

          showSaveButtons = state.model.canEdit == true && state.model.lock.isEmptyOrNull;
          log('state.model.lock.isEmptyOrNull${state.model.lock.isEmptyOrNull}--');
          log('state.model.canEdit${state.model.canEdit}--');

          log('-showSaveButtons-${showSaveButtons}---');

          log('-csrrr-${widget.isSportEventProtection}---');
          return Scaffold(
            appBar: BaseAppBar().buildAppHeader(
              context: context,
              title: widget.title,
              showPopUp: false,
              showSaveButton: showSaveButtons ,
              showSubmitButton: showSaveButtons,
              showDisLikeButton: false,
              showLikeButton: false,
              onTapSave: () {
                FocusScope.of(context).unfocus();
                BlocProvider.of<EventInfoCubit>(context).submitForm(
                    isSaveOnly: true, updatedEmailText: updatedEmailText ?? '');
                Navigator.pop(context);
                Navigator.pop(context);
              },
              onTapSubmit: () async {
                FocusScope.of(context).unfocus();
                final success = await BlocProvider.of<EventInfoCubit>(context).submitForm(
                  isSaveOnly: false,
                  updatedEmailText: updatedEmailText ?? '',
                );

                if (!success) return; // API failed — stay on page
                if (!context.mounted) return;

                setState(() {
                  showSaveButtons = false;
                });

                String route;
                Map<String, dynamic>? routeArgs;

                if (widget.isEventProtection) {
                  route = eventProtectionListRoute;
                } else if (widget.isCSREventProtection) {
                  route = csrEventListRoute;
                  routeArgs = {
                    ConstantsArgument.isCSREvent: true,
                    ConstantsArgument.isSportEvent: false,
                  };
                } else if (widget.isSportEventProtection) {
                  route = csrEventListRoute;
                  routeArgs = {
                    ConstantsArgument.isCSREvent: false,
                    ConstantsArgument.isSportEvent: true,
                  };
                } else {
                  route = annualPowerShutdownListRoute;
                }

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  route,
                      (route) => route.isFirst, // keep the first/root route, only clear what's above it
                  arguments: routeArgs,
                );
              },
            ),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                ///  FULL SCREEN BACKGROUND IMAGE
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/bg2.png',
                    fit: BoxFit.cover,
                  ),
                ),

                //  GLASS BLUR OVERLAY
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.15),
                    ),
                  ),
                ),

                //  CONTENT (FORCED TO FULL HEIGHT)
                LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Form(
                                      key: _formKey,
                                      autovalidateMode: state.model.status == 30
                                          ? AutovalidateMode.disabled
                                          : AutovalidateMode.onUserInteraction,
                                      child: Column(
                                        children: [
                                          if (!state
                                              .model.lock.isEmptyOrNull) ...[
                                            RecordLockedWidget(
                                                text: '${state.model.lock}'),
                                          ],
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0, right: 20),
                                            child: Column(
                                              children: [
                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                    height * 0.02),

                                                /// Event Started At / Event Concluded At
                                                if (state.eventDuration !=
                                                    1) ...[
                                                  CommonWidgets.textDisplay(
                                                      state.eventDuration == 0
                                                          ? Constants
                                                          .eventStartedAt
                                                          : Constants
                                                          .eventConcludedAt,
                                                      Styles.textStyleWhite14,
                                                      isMandatory: true
                                                  ),
                                                  CommonWidgets
                                                      .verticalSpacerWidget(
                                                      height * 0.01),
                                                  BaseDate()
                                                      .datePickerWidgetLoading(
                                                    context: context,
                                                    textController:
                                                    dateController,
                                                    isDisabled:
                                                    !showSaveButtons,
                                                    onlyDate: false,
                                                    startDate:
                                                    initialisedStartDate,
                                                    fromDate:
                                                    initialisedFromDate,
                                                    toDate: initialisedToDate,
                                                    onChange: (String value) {
                                                      dateController.text =
                                                          value;
                                                      log('dateControllerValue --- $value');
                                                      state.model.date = value;
                                                      BlocProvider.of<
                                                          EventInfoCubit>(
                                                          context)
                                                          .onModelValueChange(
                                                          state.model);
                                                    },
                                                  ),
                                                  CommonWidgets
                                                      .verticalSpacerWidget(
                                                      height * 0.02),
                                                ],


                                                ///Additional Emails
                                                CommonWidgets.textDisplay(
                                                    Constants.additionalEmails,
                                                    Styles.textStyleWhite14,
                                                    isMandatory: true
                                                ),
                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                    height * 0.01),
                                                Opacity(
                                                  opacity:
                                                  showSaveButtons ? 1 : 0.5,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (!showSaveButtons) {
                                                        return;
                                                      }
                                                      addEmail();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        const SizedBox(
                                                            width: 14),
                                                        SvgPicture.asset(
                                                          AppIcon.plusCircle,
                                                          colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                            AppColors.white,
                                                            BlendMode.srcIn,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        const Text(
                                                          Constants
                                                              .additionalEmails,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              decoration:
                                                              TextDecoration
                                                                  .underline,
                                                              decorationColor:
                                                              AppColors
                                                                  .white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                ///Get email
                                                getEmail(
                                                    state.additionalEmails ??
                                                        []),
                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                    height * 0.02),

                                                if ((state.eventDuration == ConstantsIntValue.eventDurationBefore &&
                                                    (widget.isSportEventProtection || widget.isCSREventProtection))) ...[
                                                  /// Additional Information
                                                  CommonWidgets.textDisplay(
                                                      Constants.additionalinformation,
                                                      Styles.textStyleWhite16,
                                                      isMandatory: true),
                                                  FlutterInputField(
                                                    lineHeight: 5,
                                                    characterLimit:
                                                    Constants.characterLimitDescTextFormField,
                                                    initialValue: state.model.additionalInfo4,
                                                    textFormKey: Keys.premisesRoundTknCommentsKey,
                                                    hintText: Constants.informationhere,
                                                    showBorder: true,
                                                    textInputAction: TextInputAction.newline,
                                                    textInputType: TextInputType.multiline,
                                                    isEnable: showSaveButtons ? true : false,
                                                    isDisableColor: showSaveButtons ? false : true,
                                                    onChange: (String value) {
                                                      state.model.additionalInfo4 = value;
                                                      context
                                                          .read<EventInfoCubit>()
                                                          .onModelValueChange(state.model);
                                                    },
                                                    validateTextField: (String? user) {},
                                                  ),
                                                  CommonWidgets.verticalSpacerWidget(height * 0.02),
                                                ],

                                                if ((state.eventDuration == ConstantsIntValue.eventDurationBefore) &&
                                                    widget.isAnnualPowerShutdown) ...[
                                                  /// CCTV System Offline
                                                  Row(children: [
                                                    CommonWidgets.textDisplay(
                                                        Constants
                                                            .cCTvSystemOffline,
                                                        Styles.textStyleWhite16,
                                                        isMandatory: true
                                                    ),
                                                    Opacity(
                                                      opacity: showSaveButtons
                                                          ? 1
                                                          : 0.5,
                                                      child: Checkbox(
                                                          activeColor:
                                                          const Color(
                                                              0xFF071130),
                                                          focusColor:
                                                          const Color(
                                                              0xFF071130),
                                                          value: state.model
                                                              .cctvSystemOffline,
                                                          onChanged:
                                                          showSaveButtons
                                                              ? (bool?
                                                          value) {
                                                            state.model
                                                                .cctvSystemOffline =
                                                            value!;
                                                            BlocProvider.of<EventInfoCubit>(
                                                                context)
                                                                .onCheckBoxChange(
                                                                state.model);
                                                          }
                                                              : null),
                                                    )
                                                  ]),

                                                  if (state.model
                                                      .cctvSystemOffline ==
                                                      true) ...[
                                                    CommonWidgets.textDisplay(
                                                        Constants.startDate,
                                                        Styles.textStyleWhite16,
                                                        isMandatory: true
                                                    ),
                                                    BaseDate()
                                                        .datePickerWidgetLoading(
                                                      context: context,
                                                      textController:
                                                      cctvDateController,
                                                      isDisabled:
                                                      !showSaveButtons,
                                                      onlyDate: false,
                                                      onChange: (String value) {
                                                        cctvDateController.text = value;

                                                        state.model.cctvSystemOfflineStartDate = value;

                                                        final double? offlineHours = calculateOfflineHours(
                                                          startDate: cctvDateController.text,
                                                          endDate: cctvEndDateController.text,
                                                        );

                                                        if (offlineHours != null) {
                                                          state.model.cctvSystemOfflineHours = offlineHours;
                                                          cctvOfflineHoursController.text =
                                                              _formatOfflineHours(offlineHours);
                                                        }

                                                        context
                                                            .read<EventInfoCubit>()
                                                            .onModelValueChange(state.model);
                                                      },
                                                    ),
                                                  ],

                                                  CommonWidgets
                                                      .verticalSpacerWidget(
                                                      height * 0.02),
                                                  /// Access System Offline
                                                  Row(children: [
                                                    CommonWidgets.textDisplay(
                                                        Constants
                                                            .accessSystemOffline,
                                                        Styles.textStyleWhite16,
                                                        isMandatory: true
                                                    ),
                                                    Opacity(
                                                      opacity: 1,
                                                      child: Checkbox(
                                                          activeColor:
                                                          const Color(
                                                              0xFF071130),
                                                          focusColor:
                                                          const Color(
                                                              0xFF071130),
                                                          value: state.model
                                                              .accessSystemOffline,
                                                          onChanged:
                                                          showSaveButtons
                                                              ? (bool?
                                                          value) {
                                                            state.model
                                                                .accessSystemOffline =
                                                            value!;
                                                            BlocProvider.of<EventInfoCubit>(
                                                                context)
                                                                .onCheckBoxChange(
                                                                state.model);
                                                          }
                                                              : null),
                                                    )
                                                  ]),

                                                  if (state.model
                                                      .accessSystemOffline ==
                                                      true) ...[
                                                    CommonWidgets.textDisplay(
                                                        Constants.startDate,
                                                        Styles.textStyleWhite16,
                                                        isMandatory: true
                                                    ),
                                                    BaseDate()
                                                        .datePickerWidgetLoading(
                                                      context: context,
                                                      textController:
                                                      accessDateController,
                                                      isDisabled:
                                                      !showSaveButtons,
                                                      onlyDate: false,
                                                      onChange: (String value) {
                                                        accessDateController.text = value;

                                                        state.model.accessSystemOfflineStartDate = value;

                                                        final double? offlineHours = calculateOfflineHours(
                                                          startDate: accessDateController.text,
                                                          endDate: accessEndDateController.text,
                                                        );

                                                        if (offlineHours != null) {
                                                          state.model.accessSystemOfflineHours = offlineHours;
                                                          accessOfflineHoursController.text =
                                                              _formatOfflineHours(offlineHours);
                                                        }

                                                        context
                                                            .read<EventInfoCubit>()
                                                            .onModelValueChange(state.model);
                                                      },
                                                    ),
                                                  ],

                                                  CommonWidgets
                                                      .verticalSpacerWidget(
                                                      height * 0.02),
                                                  /// Intruder System Offline
                                                  Row(children: [
                                                    CommonWidgets.textDisplay(
                                                        Constants
                                                            .intruderSystemOffline,
                                                        Styles.textStyleWhite16,
                                                        isMandatory: true
                                                    ),
                                                    Opacity(
                                                      opacity: 1,
                                                      child: Checkbox(
                                                          activeColor:
                                                          const Color(
                                                              0xFF071130),
                                                          focusColor:
                                                          const Color(
                                                              0xFF071130),
                                                          value: state.model
                                                              .intruderSystemOffline,
                                                          onChanged:
                                                          showSaveButtons
                                                              ? (bool?
                                                          value) {
                                                            state.model
                                                                .intruderSystemOffline =
                                                            value!;
                                                            BlocProvider.of<EventInfoCubit>(
                                                                context)
                                                                .onCheckBoxChange(
                                                                state.model);
                                                          }
                                                              : null),
                                                    )
                                                  ]),

                                                  if (state.model
                                                      .intruderSystemOffline ==
                                                      true) ...[
                                                    CommonWidgets.textDisplay(
                                                        Constants.startDate,
                                                        Styles.textStyleWhite16,
                                                        isMandatory: true
                                                    ),
                                                    BaseDate()
                                                        .datePickerWidgetLoading(
                                                      context: context,
                                                      textController:
                                                      intruderDateController,
                                                      isDisabled:
                                                      !showSaveButtons,
                                                      onlyDate: false,
                                                      onChange: (String value) {
                                                        intruderDateController
                                                            .text = value;
                                                        log('dateControllerValue --- $value');
                                                        state.model
                                                            .intruderSystemOfflineStartDate =
                                                            value;
                                                        BlocProvider.of<
                                                            EventInfoCubit>(
                                                            context)
                                                            .onModelValueChange(
                                                            state.model);
                                                      },
                                                    ),
                                                  ],
                                                ],
                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                    height * 0.02),


                                                if ((state.eventDuration == ConstantsIntValue.eventDurationAfter) &&
                                                    widget.isAnnualPowerShutdown) ...[
                                                  if(state.model.cctvSystemOffline == true)...[

                                                    /// CCTV System Offline end Date
                                                    CommonWidgets.textDisplay(
                                                        Constants.cCTvSystemOfflineEndDate,
                                                        Styles.textStyleWhite16,
                                                        isMandatory: true
                                                    ),
                                                    BaseDate()
                                                        .datePickerWidgetLoading(
                                                      context: context,
                                                      textController:
                                                      cctvEndDateController,
                                                      isDisabled:
                                                      !showSaveButtons,
                                                      onlyDate: false,
                                                      onChange: (String value) {
                                                        cctvEndDateController.text = value;

                                                        log('CCTV End Date --- $value');

                                                        state.model.cctvSystemOfflineEndDate = value;

                                                        final double? offlineHours = calculateOfflineHours(
                                                          startDate: cctvDateController.text,
                                                          endDate: cctvEndDateController.text,
                                                        );

                                                        if (offlineHours != null) {
                                                          state.model.cctvSystemOfflineHours = offlineHours;
                                                          cctvOfflineHoursController.text =
                                                              _formatOfflineHours(offlineHours);
                                                        }

                                                        log(
                                                          'CCTV Start Date --- ${cctvDateController.text}',
                                                        );

                                                        log(
                                                          'CCTV End Date --- ${cctvEndDateController.text}',
                                                        );

                                                        log(
                                                          'CCTV Offline Hours --- ${state.model.cctvSystemOfflineHours}',
                                                        );

                                                        BlocProvider.of<EventInfoCubit>(context)
                                                            .onModelValueChange(state.model);
                                                      },
                                                    ),

                                                    CommonWidgets
                                                        .verticalSpacerWidget(
                                                        height * 0.02),

                                                    /// CCTV System offline Hours
                                                    CommonWidgets.textDisplay(
                                                        Constants.cCTvSystemOfflineHours,
                                                        Styles.textStyleWhite14,
                                                        isMandatory: true),
                                                    CommonWidgets
                                                        .verticalSpacerWidget(
                                                        height * 0.01),
                                                    FlutterInputField(
                                                      textInputType:
                                                      TextInputType.text,
                                                      controller:
                                                      cctvOfflineHoursController,
                                                      textFormKey:
                                                      Keys.cctvOfflineHoursKey,
                                                      hintText: '',
                                                      isEnable:  false,
                                                      characterLimit: Constants
                                                          .characterLimitContactNo,
                                                      isDisableColor: true,
                                                      onChange: (String value) {
                                                      },
                                                      validateTextField:
                                                          (String? user) {},
                                                    ),
                                                    CommonWidgets
                                                        .verticalSpacerWidget(
                                                        height * 0.02),
                                                  ],
                                                  if(state.model.accessSystemOffline == true)...[

                                                    /// Access System Offline end Date

                                                    CommonWidgets.textDisplay(
                                                        Constants.accessSystemOfflineEndDate,
                                                        Styles.textStyleWhite16,
                                                        isMandatory: true
                                                    ),
                                                    BaseDate()
                                                        .datePickerWidgetLoading(
                                                      context: context,
                                                      textController:
                                                      accessEndDateController,
                                                      isDisabled:
                                                      !showSaveButtons,
                                                      onlyDate: false,
                                                      onChange: (String value) {
                                                        accessEndDateController.text = value;

                                                        log('Access End Date --- $value');

                                                        state.model.accessSystemOfflineEndDate = value;

                                                        final double? offlineHours = calculateOfflineHours(
                                                          startDate: accessDateController.text,
                                                          endDate: accessEndDateController.text,
                                                        );

                                                        if (offlineHours != null) {
                                                          state.model.accessSystemOfflineHours = offlineHours;
                                                          accessOfflineHoursController.text =
                                                              _formatOfflineHours(offlineHours);
                                                        }

                                                        log(
                                                          'Access Start Date --- ${accessDateController.text}',
                                                        );

                                                        log(
                                                          'Access End Date --- ${accessEndDateController.text}',
                                                        );

                                                        log(
                                                          'Access Offline Hours --- ${state.model.accessSystemOfflineHours}',
                                                        );

                                                        BlocProvider.of<
                                                            EventInfoCubit>(
                                                            context)
                                                            .onModelValueChange(
                                                            state.model);
                                                      },
                                                    ),

                                                    CommonWidgets
                                                        .verticalSpacerWidget(
                                                        height * 0.02),


                                                    /// Access System offline Hours
                                                    CommonWidgets.textDisplay(
                                                        Constants.accessSystemOfflineHours,
                                                        Styles.textStyleWhite14,
                                                        isMandatory: true),
                                                    CommonWidgets
                                                        .verticalSpacerWidget(
                                                        height * 0.01),
                                                    FlutterInputField(
                                                      textInputType:
                                                      TextInputType.text,
                                                      controller:
                                                      accessOfflineHoursController,
                                                      textFormKey:
                                                      Keys.accessSystemOfflineHoursKey,
                                                      hintText: '',
                                                      isEnable:  false,
                                                      characterLimit: Constants
                                                          .characterLimitContactNo,
                                                      isDisableColor: true,
                                                      onChange: (String value) {
                                                      },
                                                      validateTextField:
                                                          (String? user) {},
                                                    ),
                                                    CommonWidgets
                                                        .verticalSpacerWidget(
                                                        height * 0.02),
                                                  ],

                                                  if(state.model.intruderSystemOffline == true)...[

                                                    /// Intruder System Offline end Date

                                                    CommonWidgets.textDisplay(
                                                        Constants.intruderSystemOfflineEndDate,
                                                        Styles.textStyleWhite16,
                                                        isMandatory: true
                                                    ),
                                                    BaseDate()
                                                        .datePickerWidgetLoading(
                                                      context: context,
                                                      textController:
                                                      intruderEndDateController,
                                                      isDisabled:
                                                      !showSaveButtons,
                                                      onlyDate: false,
                                                      onChange: (String value) {
                                                        intruderEndDateController.text = value;

                                                        log('Intruder End Date --- $value');

                                                        state.model.intruderSystemOfflineEndDate = value;

                                                        final double? offlineHours = calculateOfflineHours(
                                                          startDate: intruderDateController.text,
                                                          endDate: intruderEndDateController.text,
                                                        );

                                                        if (offlineHours != null) {
                                                          state.model.intruderSystemOfflineHours = offlineHours;
                                                          intruderOfflineHoursController.text =
                                                              _formatOfflineHours(offlineHours);
                                                        }

                                                        log(
                                                          'Intruder Start Date --- ${accessDateController.text}',
                                                        );

                                                        log(
                                                          'Intruder End Date --- ${accessEndDateController.text}',
                                                        );

                                                        log(
                                                          'Intruder Offline Hours --- ${state.model.accessSystemOfflineHours}',
                                                        );

                                                        BlocProvider.of<
                                                            EventInfoCubit>(
                                                            context)
                                                            .onModelValueChange(
                                                            state.model);
                                                      },
                                                    ),

                                                    CommonWidgets
                                                        .verticalSpacerWidget(
                                                        height * 0.02),


                                                    /// Intruder System offline Hours
                                                    CommonWidgets.textDisplay(
                                                        Constants.intruderSystemOfflineHours,
                                                        Styles.textStyleWhite14,
                                                        isMandatory: true),
                                                    CommonWidgets
                                                        .verticalSpacerWidget(
                                                        height * 0.01),
                                                    FlutterInputField(
                                                      textInputType:
                                                      TextInputType.text,
                                                      controller:
                                                      intruderOfflineHoursController,
                                                      textFormKey:
                                                      Keys.intruderSystemOfflineHoursKey,
                                                      hintText: '',
                                                      isEnable:  false,
                                                      characterLimit: Constants
                                                          .characterLimitContactNo,
                                                      isDisableColor: true,
                                                      onChange: (String value) {
                                                      },
                                                      validateTextField:
                                                          (String? user) {},
                                                    ),
                                                    CommonWidgets
                                                        .verticalSpacerWidget(
                                                        height * 0.02),
                                                  ],
                                                ],
                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                    height * 0.02),
                                                if (state.eventDuration ==
                                                    ConstantsIntValue
                                                        .eventDurationAfter &&
                                                    !widget
                                                        .isAnnualPowerShutdown ) ...[
                                                  ///Total Attendies
                                                  CommonWidgets.textDisplay(
                                                      Constants.totalAttendies,
                                                      Styles.textStyleWhite14,
                                                      isMandatory: true),
                                                  CommonWidgets
                                                      .verticalSpacerWidget(
                                                      height * 0.01),
                                                  FlutterInputField(
                                                    textInputType:
                                                    TextInputType.text,
                                                    initialValue:
                                                    '${state.model.totalAttendance ?? ''}',
                                                    textFormKey:
                                                    Keys.lsm1ContactNOKey,
                                                    hintText: '',
                                                    isEnable: showSaveButtons
                                                        ? true
                                                        : false,
                                                    characterLimit: Constants
                                                        .characterLimitContactNo,
                                                    isDisableColor:
                                                    showSaveButtons
                                                        ? false
                                                        : true,
                                                    onChange: (String value) {
                                                      state.model
                                                          .totalAttendance =
                                                          int.tryParse(value);
                                                      context
                                                          .read<
                                                          EventInfoCubit>()
                                                          .onModelValueChange(
                                                          state.model);
                                                    },
                                                    validateTextField:
                                                        (String? user) {},
                                                  ),
                                                  CommonWidgets
                                                      .verticalSpacerWidget(
                                                      height * 0.02),
                                                ],


                                                /// View Email Notification List
                                                CommonWidgets.textDisplay(
                                                    'View Notifications',
                                                    Styles.textStyleWhite14),

                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                    height * 0.02),

                                                ///  TEMPLATE LIST
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        7),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: .7),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      /// ===== HEADER =====
                                                      Container(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 16,
                                                            vertical: 12),
                                                        color: Colors.white
                                                            .withValues(
                                                            alpha: 0.1),
                                                        child: Row(
                                                          children: [
                                                            const Expanded(
                                                              child: Text(
                                                                "Id",
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
                                                            IconButton(
                                                              icon: showSaveButtons
                                                                  ?
                                                              const Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white)
                                                                  : const SizedBox(),
                                                              tooltip:
                                                              'Fetch Template',
                                                              onPressed: showSaveButtons ?
                                                                  () async {
                                                                try {
                                                                  final cubit =
                                                                  context.read<
                                                                      EventInfoCubit>();
                                                                  cubit
                                                                      .clearAttachments();
                                                                  context
                                                                      .read<
                                                                      EventInfoCubit>()
                                                                      .clearAttachments();
                                                                  final response =
                                                                  await context
                                                                      .read<
                                                                      EventInfoCubit>()
                                                                      .getNotificationDetailsById(
                                                                    widget.eventProtectionId,
                                                                  );

                                                                  final html =
                                                                      response
                                                                          .notification;
                                                                  if (html ==
                                                                      null ||
                                                                      html
                                                                          .trim()
                                                                          .isEmpty) {
                                                                    debugPrint(
                                                                        "HTML is empty");
                                                                    return;
                                                                  }
                                                                  openTemplatePreview(
                                                                    html: html,
                                                                    templateId:
                                                                    null,
                                                                  );
                                                                } catch (e, s) {
                                                                  debugPrint(
                                                                      "Failed to load template: $e");
                                                                  debugPrintStack(
                                                                      stackTrace:
                                                                      s);
                                                                }
                                                              } : null,
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      /// ===== LOADER =====
                                                      if (state
                                                          .isTemplateLoading ==
                                                          true)
                                                        const Padding(
                                                          padding:
                                                          EdgeInsets.all(
                                                              12),
                                                          child:
                                                          CircularProgressIndicator(
                                                              color: Colors
                                                                  .white),
                                                        ),

                                                      /// ===== EMPTY STATE =====
                                                      if (state.isTemplateLoading ==
                                                          false &&
                                                          (state.emailTemplates!
                                                              .isEmpty))
                                                        const Padding(
                                                          padding:
                                                          EdgeInsets.all(
                                                              12),
                                                          child: Text(
                                                            "No templates loaded",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white70),
                                                          ),
                                                        ),

                                                      /// ===== TEMPLATE LIST =====
                                                      ...?state.emailTemplates
                                                          ?.map((item) {
                                                        return Container(
                                                          padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              20,
                                                              vertical: 10),
                                                          decoration:
                                                          const BoxDecoration(
                                                            border: Border(
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                      .white24),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  item["id"]
                                                                      .toString(),
                                                                  style: Styles
                                                                      .textStyleWhite14,
                                                                ),
                                                              ),
                                                              isLoading
                                                                  ? const SizedBox(
                                                                width: 24,
                                                                height:
                                                                24,
                                                                child:
                                                                CircularProgressIndicator(
                                                                  strokeWidth:
                                                                  2,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                                  : IconButton(
                                                                icon:
                                                                const Icon(
                                                                  Icons
                                                                      .remove_red_eye,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  final id =
                                                                  item["id"];
                                                                  if (id ==
                                                                      null) {
                                                                    return;
                                                                  }

                                                                  setState(
                                                                          () {
                                                                        isLoading =
                                                                        true;
                                                                      });

                                                                  try {
                                                                    final cubit =
                                                                    context.read<EventInfoCubit>();

                                                                    cubit
                                                                        .clearAttachments();

                                                                    final response =
                                                                    await cubit.getNotificationById(id.toString());

                                                                    debugPrint(
                                                                        "API images: ${response.images}");
                                                                    debugPrint(
                                                                        "API images length: ${response.images?.length}");

                                                                    cubit.addAttachment(
                                                                        response.images);

                                                                    final html =
                                                                        response.notification;
                                                                    if (html == null ||
                                                                        html.trim().isEmpty) {
                                                                      debugPrint("HTML is empty");
                                                                      return;
                                                                    }

                                                                    if (!context
                                                                        .mounted) {
                                                                      return;
                                                                    }

                                                                    openTemplatePreview(
                                                                      html:
                                                                      html,
                                                                      templateId:
                                                                      id as int?,
                                                                    );
                                                                  } catch (e, s) {
                                                                    debugPrint(
                                                                        "Failed to load template: $e");
                                                                    debugPrintStack(
                                                                        stackTrace: s);
                                                                  } finally {
                                                                    if (mounted) {
                                                                      setState(() {
                                                                        isLoading = false;
                                                                      });
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    ],
                                                  ),
                                                ),

                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                    height * 0.02),

                                                /// Will show for only Event Protection
                                                if ((widget
                                                    .isEventProtection && state.eventDuration ==
                                                    ConstantsIntValue
                                                        .eventDurationAfter) || (widget.isCSREventProtection && state.eventDuration ==
                                                    ConstantsIntValue
                                                        .eventDurationAfter) ||( widget.isAnnualPowerShutdown  && state.eventDuration == ConstantsIntValue
                                                    .eventDurationAfter)) ...[
                                                  Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        /// Add Button
                                                        OpacityAbsorbInkWellWidget(
                                                          absorbing: !showSaveButtons,
                                                          onTap: () async {
                                                            await Navigator.pushNamed(
                                                              context,
                                                              articleFoundNewDetailsRoute,
                                                              arguments: {
                                                                ConstantsArgument.eventId: state.model.id,
                                                                ConstantsArgument.eventProtectionId: widget.eventProtectionId,
                                                                ConstantsArgument.location: state.model.location,
                                                                ConstantsArgument.title: "Article Found",
                                                              },
                                                            );

                                                            if (!context.mounted) return;

                                                            BlocProvider.of<EventInfoCubit>(context).initializeValues();
                                                          },
                                                          child: const AddViewButton(
                                                            label: 'Add Article Found',
                                                          ),
                                                        ),

                                                        /// Show List Button
                                                        if (!state
                                                            .foundArticles
                                                            .isEmptyOrNull
                                                        ) ...[
                                                          submitButtonDisplay(
                                                            label: Constants
                                                                .showList,
                                                            onTap: () {
                                                              Navigator
                                                                  .pushNamed(
                                                                context,
                                                                articleFoundNewListRoute,
                                                                arguments: {
                                                                  ConstantsArgument
                                                                      .eventId:
                                                                  state
                                                                      .model
                                                                      .id,
                                                                  ConstantsArgument
                                                                      .eventProtectionId:
                                                                  widget
                                                                      .eventProtectionId,
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                                CommonWidgets
                                                    .verticalSpacerWidget(
                                                    height * 0.02),

                                              ],
                                            ),
                                          ),
                                          CommonWidgets.verticalSpacerWidget(
                                              height * 0.02),
                                        ],
                                      ),
                                    ),

                                    CommonWidgets.verticalSpacerWidget(
                                        height * 0.04),
                                  ],
                                ),
                              ),
                            ],
                          )));
                }),
              ],
            ),
          );
        });
  }

  void openTemplatePreview({
    required String html,
    int? templateId,
  }) {
    Navigator.push(
      context,
      PageRouteBuilder(
        //  replace MaterialPageRoute
        opaque: true, //  hides previous page completely
        pageBuilder: (_, __, ___) => BlocProvider.value(
          value: context.read<EventInfoCubit>(),
          child: TemplatePreviewPage(
            html: html,
            templateId: templateId,
            eventProtectionId: widget.eventProtectionId,
            showSaveButtons: showSaveButtons,
            getFiles: getFiles,
          ),
        ),
      ),
    );
  }

  void addEmail() {
    final exampleCubit = context.read<EventInfoCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider<EventInfoCubit>.value(
          value: exampleCubit,
          child: BlocBuilder<EventInfoCubit, EventInfoState>(
            builder: (context, state) {
              var height = MediaQuery.of(dialogContext).size.height;
              var width = MediaQuery.of(dialogContext).size.width;
              return AlertDialog(
                backgroundColor: Colors.transparent, //  important for gradient
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Container(
                  height: height * 0.25,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2C3550), // dark blue
                        Color(0xFF3E4A6B), // lighter blue
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color:
                      Colors.white.withValues(alpha: 0.5), // subtle border
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        CommonWidgets.textDisplay(
                          Constants.additionalEmails,
                          Styles.textStyleWhite16, //  change to white
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        FlutterInputField(
                          lineHeight: 1,
                          controller: addEmailController,
                          textFormKey: Keys.equipmentNoKey,
                          hintText: 'Enter email',
                          isEnable: true,
                          isDisableColor: false,
                          onChange: (String value) {},
                          validateTextField: (String value) {},
                        ),
                        if (state.status == FormStatus.invalidEmail) ...[
                          const SizedBox(height: 6),
                          const Text(
                            'Please enter a valid email',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ],
                        const Spacer(),
                        submitButtonDisplay(
                          onTap: () {
                            BlocProvider.of<EventInfoCubit>(this.context)
                                .onAddEmail(addEmailController.text);

                            if (EmailValidator.validate(
                                addEmailController.text)) {
                              addEmailController.clear();
                              Navigator.pop(dialogContext);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
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

  Widget submitButtonDisplay({
    required Function onTap,
    String? label = Constants.submit,
  }) {
    return AppButton(
      width: 150,
      buttonText: label,
      buttonTextKey: Keys.submitButton,
      onTap: onTap,
    );
  }

  void onPressedRemoveEmail(String email) {
    BlocProvider.of<EventInfoCubit>(context).removeEmail(email);
  }

  Widget getEmail(List<String> emails) {
    List<Widget> widgets = [];

    for (String email in emails) {
      widgets.add(Row(
        children: [
          Text(
            email,
            textAlign: TextAlign.start,
            style: Styles.textStyleWhite14,
          ),
          Opacity(
            opacity: showSaveButtons ? 1 : 0.5,
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                if (showSaveButtons) {
                  onPressedRemoveEmail(email);
                }
              },
            ),
          ),
        ],
      ));
      widgets.add(const SizedBox(height: 2));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  ///[getHtmlText] to get the html text from editor
  Future<String> getHtmlText() async {
    String? htmlText = await quillController.getText();
    debugPrint(htmlText);
    return htmlText;
  }

  void setHtmlText(String text) {
    quillController.setText(text); // just call it, don't await
  }

  void clearEditor() {
    quillController.clear(); // call directly
  }

  void enableEditor(bool enable) {
    quillController.enable(); // call directly
  }

  Widget uploadWidget(EventInfoState state) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFCACACA),
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(120, 50),
              backgroundColor: Colors.transparent,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return UploadAttachment(
                      onImageSelected: (ImageContent data) {
                        log('-------function---onImageSelected---------');
                        List<ImageContent>? files = [];
                        files.add(data);
                        for (ImageContent image in getFiles.toList()) {
                          files.add(image);
                        }
                        BlocProvider.of<EventInfoCubit>(context)
                            .addAttachment(files);
                      },
                    );
                  });
            },

            icon: SvgPicture.asset(
              AppIcon.uploadIcon,
              colorFilter: const ColorFilter.mode(
                AppColors.backgroundWhiteColor,
                BlendMode.srcIn,
              ),
              width: 13,
              height: 13,
              key: const Key(Keys.userIcon),
            ),
            label: const Text(
              Constants.clicktoupload,
              style: Styles.textStyleRegularNormalWhite12,
            ), // <-- Text
          ),
        ),
      ]),
    );
  }
}

class TemplatePreviewPage extends StatefulWidget {
  const TemplatePreviewPage({
    super.key,
    required this.html,
    required this.templateId,
    required this.eventProtectionId,
    required this.showSaveButtons,
    required this.getFiles,
  });

  final String html;
  final int? templateId;
  final String eventProtectionId;
  final bool showSaveButtons;
  final List<ImageContent> getFiles;

  @override
  State<TemplatePreviewPage> createState() => _TemplatePreviewPageState();
}

class _TemplatePreviewPageState extends State<TemplatePreviewPage> {
  final HtmlEditorController quillController = HtmlEditorController();
  List<ImageContent> localAttachments = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3550),
        title: Text(
          widget.templateId == null
              ? "Create Email Template"
              : "Edit Email Template #${widget.templateId}",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (widget.templateId == null)
            IconButton(
              tooltip: "Submit",
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () async {
                final html = await quillController.getText();
                if (html.trim().isEmpty) return;

                await context.read<EventInfoCubit>().submitTemplateAndRefresh(
                  html: html,
                  id: widget.templateId,
                );

                await context
                    .read<EventInfoCubit>()
                    .getNotificationDetailsById(widget.eventProtectionId);

                if (context.mounted) Navigator.pop(context);
              },
            ),
          IconButton(
            tooltip: "Close",
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () async {
              await context
                  .read<EventInfoCubit>()
                  .getNotificationDetailsById(widget.eventProtectionId);
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          /// Background
          Positioned.fill(
            child: Image.asset('assets/images/bg2.png', fit: BoxFit.cover),
          ),

          /// Blur overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Container(
                color: Colors.black.withValues(alpha: 0.15),
              ),
            ),
          ),

          /// Content
          BlocBuilder<EventInfoCubit, EventInfoState>(
            builder: (context, state) {
              final isLoading = state.status == FormStatus.loading;

              return Stack(
                children: [
                  /// ===== MAIN CONTENT =====
                  Column(
                    children: [
                      /// ===== HTML EDITOR =====
                      SizedBox(
                        height: height * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: HtmlEditor(
                            controller: quillController,
                            htmlToolbarOptions: const HtmlToolbarOptions(
                              toolbarPosition: ToolbarPosition.aboveEditor,
                              textStyle: Styles.textStyleBlack16,
                            ),
                            htmlEditorOptions: HtmlEditorOptions(
                              darkMode: false,
                              initialText: widget.html,
                              autoAdjustHeight: false,
                            ),
                            otherOptions: OtherOptions(height: height * 1.2),
                            callbacks: Callbacks(
                              onInit: () {
                                quillController.setText("""
  <style>
  body { background-color: transparent !important; color: white !important; }
  * { color: white !important; }
  </style>
  ${widget.html}
  """);
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// ===== UPLOAD =====
                      if (widget.showSaveButtons)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidgets.textDisplay(
                                Constants.upload,
                                Styles.textStyleWhite16,
                              ),
                              _uploadWidget(context, state),
                            ],
                          ),
                        ),

                      const SizedBox(height: 12),
                      const SizedBox(height: 12),

                      /// ===== ATTACHMENTS =====
                      if ((state.loadAttachments ?? []).isNotEmpty)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.35),
                                  width: 0.8,
                                ),
                                color: Colors.white.withValues(alpha: 0.03),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(8),
                                  child: BaseImageUpload().getAttachment(
                                    height: height,
                                    attachments: List<ImageContent>.from(
                                        state.loadAttachments ?? []),
                                    files: List<ImageContent>.from(
                                        state.loadAttachments ?? []),
                                    moduleCode: '',
                                    isDisabled: widget.templateId != null,
                                    showDeleteIcon: widget.templateId == null,
                                    onDelete:  (index, imageData) {
                                      context.read<EventInfoCubit>().removeAttachment(imageData);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      SizedBox(height: height * 0.015),
                    ],
                  ),

                  /// ===== BLUR LOADER OVERLAY =====
                  if (isLoading)
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: Colors.transparent,
                          child: const Center(
                            child:
                            CircularProgressIndicator(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget _uploadWidget(
      BuildContext context, EventInfoState state) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCACACA), width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(120, 50),
                backgroundColor: Colors.transparent,
              ),
              onPressed: widget.templateId == null
                  ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return UploadAttachment(
                      onImageSelected: (ImageContent data) {
                        final current = List<ImageContent>.from(state.loadAttachments ?? []);
                        final updated = [data, ...current];
                        context.read<EventInfoCubit>().addAttachment(updated);
                      },
                    );
                  },
                );
              }
                  : null,
              icon: widget.templateId == null
                  ? SvgPicture.asset(
                AppIcon.uploadIcon,
                colorFilter: const ColorFilter.mode(
                  AppColors.backgroundWhiteColor,
                  BlendMode.srcIn,
                ),
                width: 13,
                height: 13,
              )
                  : null,
              label: const Text(
                Constants.clicktoupload,
                style: Styles.textStyleRegularNormalWhite12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}