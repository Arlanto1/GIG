part of 'inward_outward_bloc.dart';

class InwardOutwardState extends Equatable {
  final List<MaterialMovementModel> items;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const InwardOutwardState(
      {this.items = const <MaterialMovementModel>[],
      this.hasReachedMax = false,
      this.status = LawEnforcementListStateType.initial});

  InwardOutwardState copyWith({
    List<MaterialMovementModel>? items,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return InwardOutwardState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
