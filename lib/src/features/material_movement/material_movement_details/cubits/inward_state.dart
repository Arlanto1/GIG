part of 'inward_cubit.dart';

enum FormStatus { loading, initial, submitting, addAttachment, success, error }

class InwardState extends Equatable {
  final FormStatus status;

  final MaterialMovementModel materialMovement;
  final GetLocations? locations;
  final GetUserDetails? loggedInUserDetails;
  final List<T1Analyst>? users;
  final List<EmployeeDepartment> departments;
  final List<CreateImage>? loadAttachments;

  final String? message;

  factory InwardState.initial({
    required MaterialMovementModel model,
    required GetLocations locations,
    required GetUserDetails loggedInUserDetails,
    required List<T1Analyst>? atomStaticUser,
    required String errorMessage,
    required List<EmployeeDepartment> departments,
    required List<CreateImage> loadAttachments,
  }) {
    return InwardState(
      status: FormStatus.initial,
      materialMovement: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: atomStaticUser,
      message: errorMessage,
      departments: departments,
      loadAttachments: loadAttachments,
    );
  }

  ErrorResponse get isValid {
    if (materialMovement.location == null) {
      return const ErrorResponse(status: false, message: 'Please enter Location');
    }
    if (materialMovement.challanNo == null) {
      return const ErrorResponse(status: false, message: 'Please enter Challan No');
    }
    if (materialMovement.quantity == null) {
      return const ErrorResponse(status: false, message: 'Please enter Quantity');
    }

    if (materialMovement.materialDescription == null) {
      return const ErrorResponse(status: false, message: 'Please enter Material Description');
    }

    if (materialMovement.materialComingFrom == null) {
      return const ErrorResponse(status: false, message: 'Please enter Material Coming From');
    }

    return const ErrorResponse(status: true, message: 'Form is Valid');
  }

  @override
  List<Object?> get props => [materialMovement, status];

  const InwardState({
    required this.status,
    required this.materialMovement,
    this.locations,
    this.loggedInUserDetails,
    this.users,
    required this.departments,
    this.loadAttachments,
    this.message,
  });

  InwardState copyWith({
    FormStatus? status,
    MaterialMovementModel? materialMovement,
    GetLocations? locations,
    GetUserDetails? loggedInUserDetails,
    List<T1Analyst>? users,
    List<EmployeeDepartment>? departments,
    List<CreateImage>? loadAttachments,
    String? message,
  }) {
    return InwardState(
      status: status ?? this.status,
      materialMovement: materialMovement ?? this.materialMovement,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      departments: departments ?? this.departments,
      loadAttachments: loadAttachments ?? this.loadAttachments,
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