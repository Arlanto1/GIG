part of 'notification_details_cubit.dart';

class NotificationDetailsState extends Equatable {
  final FormStatus status;
  final NotificationModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final String? message;
  final CdUiLabels? labels;

  factory NotificationDetailsState.initial({
    required NotificationModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
  }) {
    return NotificationDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      message: errorMessage,
    );
  }

  @override
  List<Object?> get props => [model, status];

  const NotificationDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.message,
    this.labels,
  });

  NotificationDetailsState copyWith({
    FormStatus? status,
    NotificationModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    String? message,
    final CdUiLabels? labels,
  }) {
    return NotificationDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      message: message ?? this.message,
      labels: labels ?? this.labels,
    );
  }
}
