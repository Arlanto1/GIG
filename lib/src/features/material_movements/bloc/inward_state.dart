part of 'inward_bloc.dart';

@immutable
 class InwardState extends Equatable {

  final List<MaterialMovementModel> items;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const InwardState(
      {this.items = const <MaterialMovementModel>[],
        this.hasReachedMax = false,
        this.status = LawEnforcementListStateType.initial});


  InwardState copyWith({
    List<MaterialMovementModel>? items,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return InwardState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
