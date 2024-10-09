part of 'ticketing_system_bloc.dart';

class TicketingSystemState extends Equatable {
  final List<TicketingSystems> items;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final SSLAUiLabels? labels;
  final ExtraProperties? extraProperties;

  const TicketingSystemState({
    this.items = const <TicketingSystems>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.locations,
    this.commonFilters,
    this.labels,
    this.extraProperties,
  });

  TicketingSystemState copyWith({
    List<TicketingSystems>? items,
    bool? hasReachedMax,
    FormStatus? status,
    CommonFilters? commonFilters,
    Locations? locations,
    String? message,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    SSLAUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return TicketingSystemState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      locations: locations ?? this.locations,
      commonFilters: commonFilters ?? this.commonFilters,
      labels: labels ?? this.labels,
      extraProperties: extraProperties ?? this.extraProperties,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
