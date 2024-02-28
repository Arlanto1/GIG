part of 'event_protections_bloc.dart';

class EventProtectionsState extends Equatable {
  final List<EventProtectionModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final String? message;

  const EventProtectionsState(
      {this.items = const <EventProtectionModel>[],
      this.hasReachedMax = false,
      this.locations,
      this.commonFilters,
      this.message,
      this.status = FormStatus.initial});

  EventProtectionsState copyWith({
    List<EventProtectionModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    Locations? locations,
    String? message,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
  }) {
    return EventProtectionsState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
