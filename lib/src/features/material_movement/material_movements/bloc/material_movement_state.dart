part of 'material_movement_bloc.dart';

class MaterialMovementState extends Equatable {
  final List<MaterialMovementModel> items;
  final bool hasReachedMax;
  final FormStatus status;
 final Locations? locations;
  final String? message;

  const MaterialMovementState({
    this.items = const <MaterialMovementModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.locations,
  });

  MaterialMovementState copyWith({
    List<MaterialMovementModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
  }) {
    return MaterialMovementState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      locations: locations ?? this.locations,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
