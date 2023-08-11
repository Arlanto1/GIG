part of 'inward_cubit.dart';

enum FormStatus { loading, initial, submitting, success, error }

class InwardState extends Equatable {
  final FormStatus status;

  final MaterialMovementModel materialMovement;
  final GetLocations? locations;
  final GetUserDetails? loggedInUserDetails;
  final List<T1Analyst>? users;

  final String? message;

  factory InwardState.initial({
    required MaterialMovementModel model,
    required GetLocations locations,
    required GetUserDetails loggedInUserDetails,
    required List<T1Analyst>? atomStaticUser,
    required String errorMessage,
  }) {
    return InwardState(
      status: FormStatus.initial,
      materialMovement: model,
      locations: locations,
      loggedInUserDetails: loggedInUserDetails,
      users: atomStaticUser,
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
    this.users,
    this.message,
  });

  InwardState copyWith({
    FormStatus? status,
    MaterialMovementModel? materialMovement,
    GetLocations? locations,
    GetUserDetails? loggedInUserDetails,
    List<T1Analyst>? users,
    String? message,
  }) {
    return InwardState(
      status: status ?? this.status,
      materialMovement: materialMovement ?? this.materialMovement,
      locations: locations ?? this.locations,
      loggedInUserDetails: loggedInUserDetails ?? this.loggedInUserDetails,
      users: users ?? this.users,
      message: message ?? this.message,
    );
  }
}
