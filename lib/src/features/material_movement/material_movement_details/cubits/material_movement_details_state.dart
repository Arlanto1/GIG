part of 'material_movement_details_cubit.dart';

enum FormStatus { loading, initial, submitting, addAttachment, success, error }

class MaterialMovementDetailsState extends Equatable {
  final FormStatus status;

  final MaterialMovementModel materialMovement;
  final GetLocations? locations;
  final GetUserDetails? loggedInUserDetails;
  final List<T1Analyst>? users;
  final List<EmployeeDepartment> departments;
  final List<CreateImage>? loadAttachments;
  final List<QuantityUnit> quantityUnits;

  final String? message;

  factory MaterialMovementDetailsState.initial({
    required MaterialMovementModel model,
    required GetLocations locations,
    required GetUserDetails loggedInUserDetails,
    required List<T1Analyst>? atomStaticUser,
    required String errorMessage,
    required List<EmployeeDepartment> departments,
    required List<CreateImage> loadAttachments,
    required List<QuantityUnit> quantityUnits,
  }) {
    return MaterialMovementDetailsState(
        status: FormStatus.initial,
        materialMovement: model,
        locations: locations,
        loggedInUserDetails: loggedInUserDetails,
        users: atomStaticUser,
        message: errorMessage,
        departments: departments,
        loadAttachments: loadAttachments,
        quantityUnits: quantityUnits);
  }

  ErrorResponse get isValid {
    if (materialMovement.location == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Location');
    }
    if (materialMovement.challanNo == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Challan No');
    }
    if (materialMovement.quantity == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Quantity');
    }

    if (materialMovement.materialDescription == null) {
      return const ErrorResponse(
          status: false, message: 'Please enter Material Description');
    }

    if (materialMovement.materialComingFrom == null) {
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
    required this.departments,
    this.loadAttachments,
    required this.quantityUnits,
    this.message,
  });

  MaterialMovementDetailsState copyWith({
    FormStatus? status,
    MaterialMovementModel? materialMovement,
    GetLocations? locations,
    GetUserDetails? loggedInUserDetails,
    List<T1Analyst>? users,
    List<EmployeeDepartment>? departments,
    List<CreateImage>? loadAttachments,
    List<QuantityUnit>? quantityUnits,
    String? message,
  }) {
    return MaterialMovementDetailsState(
      status: status ?? this.status,
      materialMovement: materialMovement ?? this.materialMovement,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      departments: departments ?? this.departments,
      loadAttachments: loadAttachments ?? this.loadAttachments,
      quantityUnits: quantityUnits ?? this.quantityUnits,
      message: message ?? this.message,
    );
  }
}

class ErrorResponse {
  final bool status;
  final String message;

  const ErrorResponse({
    required this.status,
    required this.message,
  });
}
