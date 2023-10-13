part of 'sst_incident_bloc.dart';

class SstIncidentState extends Equatable {
  final List<SstIncident> items;
  final bool hasReachedMax;
  final FormStatus status;

  const SstIncidentState(
      {this.items = const <SstIncident>[],
        this.hasReachedMax = false,
        this.status = FormStatus.initial});

  SstIncidentState copyWith({
    List<SstIncident>? items,
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
