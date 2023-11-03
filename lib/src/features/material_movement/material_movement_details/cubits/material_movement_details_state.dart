part of 'material_movement_details_cubit.dart';

class MaterialMovementDetailsState extends Equatable {
  final FormStatus status;

  final MaterialMovementModel model;
  final GetLocations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<Organisation> departments;
  final List<CreateImage>? loadAttachments;
  final List<Organisation> quantityUnits;
  final int? eventId;
  final String? message;
  final bool? isInward;
  final Language? language;

  factory MaterialMovementDetailsState.initial({
    required MaterialMovementModel model,
    required GetLocations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
    required List<Organisation> departments,
    required List<CreateImage> loadAttachments,
    required List<Organisation> quantityUnits,
    required int? eventId,
  }) {
    return MaterialMovementDetailsState(
        status: FormStatus.initial,
        model: model,
        locations: locations,
        loggedInUserDetails: loggedInUserDetails,
        users: users,
        emailUsers: emailUsers,
        message: errorMessage,
        departments: departments,
        loadAttachments: loadAttachments,
        quantityUnits: quantityUnits,
        eventId: eventId);
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
    if (model.challanNo.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Challan No');
    }
    if (model.quantity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Quantity');
    }
    if (model.inwardMovement ?? false) {
      if (model.materialComingFrom == null) {
        return const ErrorResponse(
            status: false, message: 'Please enter Sender\'s Name');
      }
    }

    if (model.unit == null) {
      return const ErrorResponse(status: false, message: 'Please enter Unit');
    }
    if (model.materialDescription.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Material Description');
    }

    if (!model.materialPhysicallyChecked == true &&
        isInward == true &&
        model.materialNotCheckedComment.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Comment is Mandatory');
    }
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [model, status];

  const MaterialMovementDetailsState({
    required this.status,
    required this.model,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    required this.departments,
    this.loadAttachments,
    required this.quantityUnits,
    this.eventId,
    this.message,
    this.isInward,
    this.language,
  });

  MaterialMovementDetailsState copyWith({
    FormStatus? status,
    MaterialMovementModel? model,
    GetLocations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<Organisation>? departments,
    List<CreateImage>? loadAttachments,
    List<Organisation>? quantityUnits,
    int? eventId,
    String? message,
    Language? language,
  }) {
    return MaterialMovementDetailsState(
      status: status ?? this.status,
      model: model ?? this.model,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      departments: departments ?? this.departments,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      quantityUnits: quantityUnits ?? this.quantityUnits,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
      language: language??this.language,
    );
  }
}
