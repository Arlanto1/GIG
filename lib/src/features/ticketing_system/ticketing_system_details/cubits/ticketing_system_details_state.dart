part of 'ticketing_system_details_cubit.dart';

class TicketingSystemDetailsState extends Equatable {
  final FormStatus status;
  final TicketingSystemModel model;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final String? message;
  final SlaUiLabels? labels;
  final List<Organisation> priorities;
  final List<ImageContent> loadAttachments;

  factory TicketingSystemDetailsState.initial({
    required TicketingSystemModel model,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
    required List<Organisation> priorities,
    required List<ImageContent> loadAttachments,
  }) {
    return TicketingSystemDetailsState(
      status: FormStatus.initial,
      model: model,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      message: errorMessage,
      priorities: priorities,
        loadAttachments: loadAttachments,
    );
  }

  ErrorResponse get isValidDraft {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.title == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter a valid title');
    }
    if (model.startDate == null) {
      return const ErrorResponse(
          status: false, message: 'Start Date is required');
    }
    if (model.assignee == null) {
      return const ErrorResponse(
          status: false, message: 'Please select an assignee');
    }
    if (model.priority == null) {
      return const ErrorResponse(
          status: false, message: 'Please select a priority');
    }
    if (model.description == null) {
      return const ErrorResponse(
          status: false, message: 'Description cannot be blank');
    }


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
    required this.priorities,
    required this.loadAttachments
  });

  TicketingSystemDetailsState copyWith({
    FormStatus? status,
    TicketingSystemModel? model,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    String? message,
    SlaUiLabels? labels,
    List<Organisation>? priorities,
    List<ImageContent>? loadAttachments,
  }) {
    return TicketingSystemDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      message: message ?? this.message,
      labels: labels ?? this.labels,
      priorities: priorities ?? this.priorities,
      loadAttachments: loadAttachments ?? this.loadAttachments,
    );
  }
}
