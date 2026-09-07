// part of 'patrolling_details_cubit.dart';
//
// class PatrollingDetailsState extends Equatable {
//   final FormStatus status;
//   final PatrollingModel model;
//   final User? loggedInUserDetails;
//   final List<BaseUser>? users;
//   final String? message;
//   final SlaUiLabels? labels;
//   final List<Organisation> projects;
//   final List<Organisation> trackers;
//   final List<BaseUser> lsm;
//   final List<BaseUser>? securitySupervisor;
//   final List<BaseUser> owner;
//   final List<BaseUser>? dbSponsor;
//   final BaseUser? selectedOwner;
//   final int? eventId;
//   final List<ImageContent>? uploadAttachments;
//   final Locations locations;
//   final List<Organisation>? listOfModules;
//   final List<Organisation>? getStatus;
//   final List<Organisation>? listOfEntities;
//   final PatrollingOtherModel otherModel;
//   final bool showOwnerDialog;
//   final bool? isSaveOnly;
//
//   factory PatrollingDetailsState.initial({
//     required PatrollingModel model,
//     required User loggedInUserDetails,
//     required List<BaseUser>? users,
//     required String errorMessage,
//     required List<Organisation> priorities,
//     required final List<Organisation> projects,
//     required final List<Organisation> trackers,
//     required List<BaseUser> lsm,
//     required List<BaseUser> securitySupervisor,
//     required List<BaseUser> owner,
//     List<BaseUser>? dbSponsor,
//     required int? eventId,
//     List<ImageContent>? uploadAttachments,
//     required Locations locations,
//     required final List<Organisation>? listOfModules,
//     required final List<Organisation> getStatus,
//     required final List<Organisation>? listOfEntities,
//     required PatrollingOtherModel otherModel,
//   }) {
//     return PatrollingDetailsState(
//       status: FormStatus.initial,
//       model: model,
//       loggedInUserDetails: loggedInUserDetails,
//       users: users,
//       message: errorMessage,
//       locations: locations,
//       projects: projects,
//       trackers: trackers,
//       lsm: lsm,
//       securitySupervisor: securitySupervisor,
//       owner: owner,
//       dbSponsor:dbSponsor,
//       eventId: eventId,
//       uploadAttachments: uploadAttachments,
//       listOfModules: listOfModules,
//       getStatus: getStatus,
//       listOfEntities: listOfEntities,
//       otherModel: otherModel,
//     );
//   }
//
//   ErrorResponse get isValidDraft {
//     if (model.status == null) {
//       return const ErrorResponse(status: false, message: 'Please enter Status');
//     }
//     // if (model.title == null) {
//     //   return const ErrorResponse(
//     //       status: false, message: 'Please enter a valid title');
//     // }
//     // if (model.fromDate == null) {
//     //   return const ErrorResponse(
//     //       status: false, message: 'Start Date is required');
//     // }
//     // if (model.assignee == null) {
//     //   return const ErrorResponse(
//     //       status: false, message: 'Please select an assignee');
//     // }
//     // if (model.priority == null) {
//     //   return const ErrorResponse(
//     //       status: false, message: 'Please select a priority');
//     // }
//     // if (model.description == null) {
//     //   return const ErrorResponse(
//     //       status: false, message: 'Description cannot be blank');
//     // }
//
//     // if (model.dueDate != null && model.startDate != null) {
//     //   final dueDate = DateTime.parse(model.dueDate!);
//     //   final startDate = DateTime.parse(model.startDate!);
//     //
//     //   if (dueDate.isBefore(startDate) || dueDate.isAtSameMomentAs(startDate)) {
//     //     return const ErrorResponse(
//     //         status: false,
//     //         message: 'Due Date should be greater than Start Date');
//     //   }
//     // }
//
//     return const ErrorResponse(status: true, message: 'Form is Valid');
//   }
//
//   ErrorResponse get isValid {
//     // if (model.vendor == null) {
//     //   return const ErrorResponse(status: false, message: 'Please enter Vendor');
//     // }
//     // if (model.entity == null) {
//     //   return const ErrorResponse(status: false, message: 'Please enter Entity');
//     // }
//
//     return const ErrorResponse(status: true, message: 'Form is Valid');
//   }
//
//   @override
//   List<Object?> get props => [model, status, lsm,owner, otherModel,showOwnerDialog, isSaveOnly ];
//
//   const PatrollingDetailsState({
//     required this.status,
//     required this.model,
//     this.loggedInUserDetails,
//     this.users,
//     this.message,
//     this.labels,
//     required this.locations,
//     required this.projects,
//     required this.trackers,
//     required this.lsm,
//     required this.securitySupervisor,
//     this.owner = const [],
//     this.dbSponsor,
//     this.eventId,
//     this.uploadAttachments,
//     this.listOfModules,
//     this.getStatus,
//     this.listOfEntities,
//     required this.otherModel,
//     this.showOwnerDialog = false,
//     this.selectedOwner,
//     this.isSaveOnly,
//   });
//
//   PatrollingDetailsState copyWith({
//     FormStatus? status,
//     PatrollingModel? model,
//     User? loggedInUserDetails,
//     List<BaseUser>? lsm,
//     List<BaseUser>? securitySupervisor,
//     List<BaseUser>? owner,
//     List<BaseUser>? dbSponsor,
//     String? message,
//     SlaUiLabels? labels,
//     List<Organisation>? priorities,
//     List<Organisation>? projects,
//     List<Organisation>? trackers,
//     int? eventId,
//     List<ImageContent>? uploadAttachments,
//     Locations? locations,
//     List<Organisation>? listOfModules,
//     List<Organisation>? getStatus,
//     List<Organisation>? listOfEntities,
//     PatrollingOtherModel? otherModel,
//     bool? showOwnerDialog,
//     BaseUser? selectedOwner,
//   }) {
//     return PatrollingDetailsState(
//       status: status ?? this.status,
//       model: model ?? this.model,
//       loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
//       lsm: lsm ?? this.lsm,
//       securitySupervisor:securitySupervisor??this.securitySupervisor,
//       owner: owner ?? this.owner,
//       dbSponsor:dbSponsor??this.dbSponsor,
//       projects: projects ?? this.projects,
//       message: message ?? this.message,
//       labels: labels ?? this.labels,
//       locations: locations ?? this.locations,
//       trackers: trackers ?? this.trackers,
//       eventId: eventId ?? this.eventId,
//       uploadAttachments: uploadAttachments ?? this.uploadAttachments,
//       listOfModules: listOfModules ?? this.listOfModules,
//       getStatus: getStatus ?? this.getStatus,
//       listOfEntities: listOfEntities ?? this.listOfEntities,
//       otherModel: otherModel?? this.otherModel,
//       showOwnerDialog: showOwnerDialog ?? this.showOwnerDialog,
//       selectedOwner: selectedOwner ?? this.selectedOwner,
//     );
//   }
// }

part of 'patrolling_details_cubit.dart';

class PatrollingDetailsState extends Equatable {
  final FormStatus status;
  final PatrollingModel model;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final String? message;
  final SlaUiLabels? labels;
  final List<Organisation> projects;
  final List<Organisation> trackers;
  final List<BaseUser> lsm;
  final List<BaseUser>? securitySupervisor;
  final List<BaseUser> owner;
  final List<BaseUser>? dbSponsor;
  final BaseUser? selectedOwner;
  final BaseUser? selectedDbSponsor;
  final int? eventId;
  final List<ImageContent>? uploadAttachments;
  final Locations locations;
  final List<Organisation>? listOfModules;
  final List<Organisation>? getStatus;
  final List<Organisation>? listOfEntities;
  final PatrollingOtherModel otherModel;
  final bool showOwnerDialog;
  final bool? isSaveOnly; // <-- NEW: distinguishes Save vs Submit on success


  factory PatrollingDetailsState.initial({
    required PatrollingModel model,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    required String errorMessage,
    required List<Organisation> priorities,
    required final List<Organisation> projects,
    required final List<Organisation> trackers,
    required List<BaseUser> lsm,
    required List<BaseUser> securitySupervisor,
    required List<BaseUser> owner,
    List<BaseUser>? dbSponsor,
    required int? eventId,
    List<ImageContent>? uploadAttachments,
    required Locations locations,
    required final List<Organisation>? listOfModules,
    required final List<Organisation> getStatus,
    required final List<Organisation>? listOfEntities,
    required PatrollingOtherModel otherModel,

  }) {
    return PatrollingDetailsState(
      status: FormStatus.initial,
      model: model,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      message: errorMessage,
      locations: locations,
      projects: projects,
      trackers: trackers,
      lsm: lsm,
      securitySupervisor: securitySupervisor,
      owner: owner,
      dbSponsor:dbSponsor,
      eventId: eventId,
      uploadAttachments: uploadAttachments,
      listOfModules: listOfModules,
      getStatus: getStatus,
      listOfEntities: listOfEntities,
      otherModel: otherModel,
    );
  }

  ErrorResponse get isValidDraft {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status, lsm, owner,dbSponsor, otherModel, showOwnerDialog, isSaveOnly];

  const PatrollingDetailsState({
    required this.status,
    required this.model,
    this.loggedInUserDetails,
    this.users,
    this.message,
    this.labels,
    required this.locations,
    required this.projects,
    required this.trackers,
    required this.lsm,
    required this.securitySupervisor,
    this.owner = const [],
    this.dbSponsor,
    this.eventId,
    this.uploadAttachments,
    this.listOfModules,
    this.getStatus,
    this.listOfEntities,
    required this.otherModel,
    this.showOwnerDialog = false,
    this.selectedOwner,
    this.selectedDbSponsor,
    this.isSaveOnly, // <-- NEW
  });

  PatrollingDetailsState copyWith({
    FormStatus? status,
    PatrollingModel? model,
    User? loggedInUserDetails,
    List<BaseUser>? lsm,
    List<BaseUser>? securitySupervisor,
    List<BaseUser>? owner,
    List<BaseUser>? dbSponsor,
    String? message,
    SlaUiLabels? labels,
    List<Organisation>? priorities,
    List<Organisation>? projects,
    List<Organisation>? trackers,
    int? eventId,
    List<ImageContent>? uploadAttachments,
    Locations? locations,
    List<Organisation>? listOfModules,
    List<Organisation>? getStatus,
    List<Organisation>? listOfEntities,
    PatrollingOtherModel? otherModel,
    bool? showOwnerDialog,
    BaseUser? selectedOwner,
    BaseUser? selectedDbSponsor,

    bool? isSaveOnly, // <-- NEW
  }) {
    return PatrollingDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      lsm: lsm ?? this.lsm,
      securitySupervisor:securitySupervisor??this.securitySupervisor,
      owner: owner ?? this.owner,
      dbSponsor:dbSponsor??this.dbSponsor,
      projects: projects ?? this.projects,
      message: message ?? this.message,
      labels: labels ?? this.labels,
      locations: locations ?? this.locations,
      trackers: trackers ?? this.trackers,
      eventId: eventId ?? this.eventId,
      uploadAttachments: uploadAttachments ?? this.uploadAttachments,
      listOfModules: listOfModules ?? this.listOfModules,
      getStatus: getStatus ?? this.getStatus,
      listOfEntities: listOfEntities ?? this.listOfEntities,
      otherModel: otherModel?? this.otherModel,
      showOwnerDialog: showOwnerDialog ?? this.showOwnerDialog,
      selectedOwner: selectedOwner ?? this.selectedOwner,
      selectedDbSponsor:selectedDbSponsor?? this.selectedDbSponsor,
      isSaveOnly: isSaveOnly ?? this.isSaveOnly, // <-- NEW
    );
  }
}