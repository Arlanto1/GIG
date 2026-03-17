part of 'ticketing_system_details_cubit.dart';

class TicketingSystemDetailsState extends Equatable {
  final FormStatus status;
  final TicketingSystemModel model;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final String? message;
  final SlaUiLabels? labels;
  final List<Organisation> projects;
  final List<Organisation> trackers;
  final List<BaseUser>? assignee;
  final int? eventId;
  final List<ImageContent>? uploadAttachments;
  final Locations locations;
  final List<Organisation>? listOfModules;
  final List<Organisation>? getStatus;

  factory TicketingSystemDetailsState.initial({
    required TicketingSystemModel model,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    required String errorMessage,
    required List<Organisation> priorities,
    required final List<Organisation> projects,
    required final List<Organisation> trackers,
    List<BaseUser>? assignee,
    required int? eventId,
    List<ImageContent>? uploadAttachments,
    required Locations locations,
    required final List<Organisation>? listOfModules,
    required final List<Organisation> getStatus,
  }) {
    return TicketingSystemDetailsState(
      status: FormStatus.initial,
      model: model,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      message: errorMessage,
      locations: locations,
      projects: projects,
      trackers: trackers,
      assignee: assignee,
      eventId: eventId,
      uploadAttachments: uploadAttachments,
      listOfModules: listOfModules,
      getStatus: getStatus,
    );
  }

  ErrorResponse get isValidDraft {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    // if (model.title == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please enter a valid title');
    // }
    // if (model.fromDate == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Start Date is required');
    // }
    // if (model.assignee == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please select an assignee');
    // }
    // if (model.priority == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Please select a priority');
    // }
    // if (model.description == null) {
    //   return const ErrorResponse(
    //       status: false, message: 'Description cannot be blank');
    // }

    // if (model.dueDate != null && model.startDate != null) {
    //   final dueDate = DateTime.parse(model.dueDate!);
    //   final startDate = DateTime.parse(model.startDate!);
    //
    //   if (dueDate.isBefore(startDate) || dueDate.isAtSameMomentAs(startDate)) {
    //     return const ErrorResponse(
    //         status: false,
    //         message: 'Due Date should be greater than Start Date');
    //   }
    // }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    // if (model.vendor == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter Vendor');
    // }
    // if (model.entity == null) {
    //   return const ErrorResponse(status: false, message: 'Please enter Entity');
    // }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const TicketingSystemDetailsState({
    required this.status,
    required this.model,
    this.loggedInUserDetails,
    this.users,
    this.message,
    this.labels,
    required this.locations,
    required this.projects,
    required this.trackers,
    this.assignee,
    this.eventId,
    this.uploadAttachments,
    this.listOfModules,
    this.getStatus,
  });

  TicketingSystemDetailsState copyWith({
    FormStatus? status,
    TicketingSystemModel? model,
    User? loggedInUserDetails,
    List<BaseUser>? assignee,
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
  }) {
    return TicketingSystemDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      assignee: assignee ?? this.assignee,
      projects: projects ?? this.projects,
      message: message ?? this.message,
      labels: labels ?? this.labels,
      locations: locations ?? this.locations,
      trackers: trackers ?? this.trackers,
      eventId: eventId ?? this.eventId,
      uploadAttachments: uploadAttachments ?? this.uploadAttachments,
      listOfModules: listOfModules ?? this.listOfModules,
      getStatus: getStatus ?? this.getStatus,
    );
  }
}
