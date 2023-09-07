part of 'event_protections_bloc.dart';

class EventProtectionsState extends Equatable {
  final List<MaterialMovementModel> items;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const EventProtectionsState(
      {this.items = const <MaterialMovementModel>[],
        this.hasReachedMax = false,
        this.status = LawEnforcementListStateType.initial});

  EventProtectionsState copyWith({
    List<MaterialMovementModel>? items,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return EventProtectionsState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
