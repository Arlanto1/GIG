part of 'female_drop_pick_up_bloc.dart';

class FemaleDropPickUpState extends Equatable {
  final List<FemaleDropPickUp> items;
  final bool hasReachedMax;
  final FormStatus status;

  const FemaleDropPickUpState(
      {this.items = const <FemaleDropPickUp>[],
      this.hasReachedMax = false,
      this.status = FormStatus.initial});

  FemaleDropPickUpState copyWith({
    List<FemaleDropPickUp>? items,
    bool? hasReachedMax,
    FormStatus? status,
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
