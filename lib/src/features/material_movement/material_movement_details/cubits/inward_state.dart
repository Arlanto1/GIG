part of 'inward_cubit.dart';

enum FormStatus { loading, initial, submitting, success, error }

class InwardState extends Equatable {
  final FormStatus status;

  final MaterialMovementModel materialMovement;
  final GetLocations? locations;
  final GetUserDetails? loggedInUserDetails;
  final String? message;

  factory InwardState.initial({
    required MaterialMovementModel model,
    required GetLocations locations,
    required GetUserDetails loggedInUserDetails,
    required String errorMessage,
  }) {
    return InwardState(
      status: FormStatus.initial,
      materialMovement: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      message: errorMessage,
    );
  }

  bool? get isValid => materialMovement.challanNo?.isNotEmpty;

  @override
  List<Object?> get props => [materialMovement, status];

  const InwardState({
    required this.status,
    required this.materialMovement,
    this.locations,
    this.loggedInUserDetails,
    this.message,
  });

  InwardState copyWith({
    FormStatus? status,
    MaterialMovementModel? materialMovement,
    GetLocations? locations,
    GetUserDetails? loggedInUserDetails,
    String? message,
  }) {
    return InwardState(
      status: status ?? this.status,
      materialMovement: materialMovement ?? this.materialMovement,
      locations: locations ?? this.locations,
      loggedInUserDetails:
      loggedInUserDetails ?? this.loggedInUserDetails,
      message: message ?? this.message,
    );
  }
}
