part of 'sla_violation_bloc.dart';

class SLAViolationState extends Equatable {
  final List<EventProtectionModel> items;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const SLAViolationState(
      {this.items = const <EventProtectionModel>[],
        this.hasReachedMax = false,
        this.status = LawEnforcementListStateType.initial});

  SLAViolationState copyWith({
    List<EventProtectionModel>? items,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return SLAViolationState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
