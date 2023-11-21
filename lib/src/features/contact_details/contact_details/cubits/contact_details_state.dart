part of 'contact_details_cubit.dart';

class ContactDetailsState extends Equatable {
  final FormStatus status;

  final ContactDetailModel model;
  final Locations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<BaseUser>? approver1Users;
  final List<BaseUser>? approver2Users;
  final String? message;
  final Language? language;

  factory ContactDetailsState.initial({
    required ContactDetailModel model,
    required Locations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
  }) {
    return ContactDetailsState(
      status: FormStatus.initial,
      model: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: users,
      emailUsers: emailUsers,
      message: errorMessage,
    );
  }

  ErrorResponse get isValidDraft {
    if (model.status == null) {
      return const ErrorResponse(status: false, message: 'Please enter Status');
    }
    if (model.entrySecurity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Entry Security');
    }
    if (model.inputDate == null) {
      return const ErrorResponse(
          status: false, message: 'Created Date is required');
    }
    if (model.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }

    if (model.slNo.isEmptyOrNull) {
      return const ErrorResponse(status: false, message: 'Please enter SL No');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  ErrorResponse get isValid {
    if (model.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const ContactDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    this.message,
    this.language,
    this.approver1Users,
    this.approver2Users,
  });

  ContactDetailsState copyWith({
    FormStatus? status,
    ContactDetailModel? model,
    Locations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<BaseUser>? approver1Users,
    List<BaseUser>? approver2Users,
    String? message,
    Language? language,
  }) {
    return ContactDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      approver1Users: approver1Users ?? this.approver1Users,
      approver2Users: approver2Users ?? this.approver2Users,
      message: message ?? this.message,
      language: language ?? this.language,
       );
  }
}
