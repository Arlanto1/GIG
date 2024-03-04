part of 'sst_incident_bloc.dart';

class SstIncidentState extends Equatable {
  final List<SstIncident> items;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final Locations? locations;
  final CommonFilters? commonFilters;

  const SstIncidentState({
    this.items = const <SstIncident>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.locations,
    this.commonFilters,
  });

  SstIncidentState copyWith({
    List<SstIncident>? items,
    bool? hasReachedMax,
    FormStatus? status,
    CommonFilters? commonFilters,
    Locations? locations,
    String? message,
    List<Organisation>? regions,
    List<Organisation>? statuses,
  }) {
    return SstIncidentState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      locations: locations ?? this.locations,
      commonFilters: commonFilters ?? this.commonFilters,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
