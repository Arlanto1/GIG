part of 'material_movement_bloc.dart';

class MaterialMovementState extends Equatable {
  final List<MaterialMovementModel> items;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const MaterialMovementState(
      {this.items = const <MaterialMovementModel>[],
      this.hasReachedMax = false,
      this.status = LawEnforcementListStateType.initial});

  MaterialMovementState copyWith({
    List<MaterialMovementModel>? items,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return MaterialMovementState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
