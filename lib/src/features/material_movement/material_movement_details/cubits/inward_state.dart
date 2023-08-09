part of 'inward_cubit.dart';

enum FormStatus { initial, submitting, success, error }

class InwardState extends Equatable {
  final FormStatus status;

  final MaterialMovementModel materialMovement;
  final GetLocations? locations;
  final String? errorMessage;

  factory InwardState.initial(
      {required MaterialMovementModel model, required GetLocations locations, required String errorMessage}) {
    return InwardState(
        status: FormStatus.initial,
        materialMovement: model,
        locations: locations,
      errorMessage: errorMessage,
    );
  }

  bool? get isValid => materialMovement.challanNo?.isNotEmpty;

  @override
  List<Object?> get props => [materialMovement, status];

  const InwardState({
    required this.status,
    required this.materialMovement,
    required this.locations,
  required this.errorMessage
  });

  InwardState copyWith({
    FormStatus? status,
    MaterialMovementModel? materialMovement,
    GetLocations? locations,
    String? errorMessage,
  }) {
    return InwardState(
      status: status ?? this.status,
      materialMovement: materialMovement ?? this.materialMovement,
      locations: locations ?? this.locations,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

}
