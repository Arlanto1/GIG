part of 'incident_management_bloc.dart';

class IncidentManagementsState extends Equatable {
  final List<EventProtectionModel> items;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const IncidentManagementsState(
      {this.items = const <EventProtectionModel>[],
        this.hasReachedMax = false,
        this.status = LawEnforcementListStateType.initial});

  IncidentManagementsState copyWith({
    List<EventProtectionModel>? items,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return IncidentManagementsState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
