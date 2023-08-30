part of 'female_drop_pick_up_bloc.dart';

class FemaleDropPickUpState extends Equatable {
  final List<FemaleDropPickUp> items;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const FemaleDropPickUpState(
      {this.items = const <FemaleDropPickUp>[],
        this.hasReachedMax = false,
        this.status = LawEnforcementListStateType.initial});

  FemaleDropPickUpState copyWith({
    List<FemaleDropPickUp>? items,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return FemaleDropPickUpState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}