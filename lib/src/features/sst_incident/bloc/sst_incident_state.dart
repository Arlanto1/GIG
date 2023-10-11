part of 'sst_incident_bloc.dart';

class SstIncidentState extends Equatable {
  final List<EventProtectionModel> items;
  final bool hasReachedMax;
  final FormStatus status;

  const SstIncidentState(
      {this.items = const <EventProtectionModel>[],
        this.hasReachedMax = false,
        this.status = FormStatus.initial});

  SstIncidentState copyWith({
    List<EventProtectionModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
  }) {
    return SstIncidentState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
