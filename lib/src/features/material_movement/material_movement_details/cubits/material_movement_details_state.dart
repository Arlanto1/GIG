part of 'material_movement_details_cubit.dart';

class MaterialMovementDetailsState extends Equatable {
  final FormStatus status;

  final MaterialMovementModel materialMovement;
  final GetLocations? locations;
  final User? loggedInUserDetails;
  final List<BaseUser>? users;
  final List<BaseUser>? emailUsers;
  final List<Organisation> departments;
  final List<CreateImage>? loadAttachments;
  final List<QuantityUnit> quantityUnits;
  final int? eventId;
  final String? message;

  factory MaterialMovementDetailsState.initial({
    required MaterialMovementModel model,
    required GetLocations locations,
    required User loggedInUserDetails,
    required List<BaseUser>? users,
    final List<BaseUser>? emailUsers,
    required String errorMessage,
    required List<Organisation> departments,
    required List<CreateImage> loadAttachments,
    required List<QuantityUnit> quantityUnits,
    required int? eventId,
  }) {
    return MaterialMovementDetailsState(
        status: FormStatus.initial,
        materialMovement: model,
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

  ErrorResponse get isValid {
    if (materialMovement.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (materialMovement.challanNo.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Challan No');
    }
    if (materialMovement.quantity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Quantity');
    }
    if (materialMovement.materialDescription.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Material Description');
    }
    if (materialMovement.materialComingFrom.isEmptyOrNull) {
      return const ErrorResponse(
          status: false, message: 'Please enter Material Coming From');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [materialMovement, status];

  const MaterialMovementDetailsState({
    required this.status,
    required this.materialMovement,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    this.emailUsers,
    required this.departments,
    this.loadAttachments,
    required this.quantityUnits,
    this.eventId,
    this.message,
  });

  MaterialMovementDetailsState copyWith({
    FormStatus? status,
    MaterialMovementModel? materialMovement,
    GetLocations? locations,
    User? loggedInUserDetails,
    List<BaseUser>? users,
    List<BaseUser>? emailUsers,
    List<Organisation>? departments,
    List<CreateImage>? loadAttachments,
    List<QuantityUnit>? quantityUnits,
    int? eventId,
    String? message,
  }) {
    return MaterialMovementDetailsState(
      status: status ?? this.status,
      materialMovement: materialMovement ?? this.materialMovement,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      emailUsers: emailUsers ?? this.emailUsers,
      departments: departments ?? this.departments,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      quantityUnits: quantityUnits ?? this.quantityUnits,
      eventId: eventId ?? this.eventId,
      message: message ?? this.message,
    );
  }
}
