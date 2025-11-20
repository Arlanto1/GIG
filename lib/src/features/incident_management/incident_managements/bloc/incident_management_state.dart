part of 'incident_management_bloc.dart';

class IncidentManagementsState extends Equatable {
  final List<IncidentModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final String? message;
  final IMUiLabels? labels;
  final ExtraProperties? extraProperties;
  final DisplayMenu? displayMenu;

  const IncidentManagementsState(
      {this.items = const <IncidentModel>[],
      this.hasReachedMax = false,
      this.locations,
      this.commonFilters,
      this.message,
      this.labels,
      this.extraProperties,
      this.status = FormStatus.initial,
       this.displayMenu});

  IncidentManagementsState copyWith({
    List<IncidentModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    IMUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return IncidentManagementsState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
      labels: labels ?? this.labels,
      extraProperties: extraProperties ?? this.extraProperties,
      displayMenu: displayMenu?? this.displayMenu
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
