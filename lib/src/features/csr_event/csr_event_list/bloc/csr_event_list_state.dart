part of 'csr_event_list_bloc.dart';

class CSREventState extends Equatable {
  final List<CSREventGiModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final String? message;
  final EPUiLabels? labels;
  final ExtraProperties? extraProperties;
  final DisplayMenu? displayMenu;


  const CSREventState({
    this.items = const <CSREventGiModel>[],
    this.hasReachedMax = false,
    this.locations,
    this.commonFilters,
    this.message,
    this.labels,
    this.status = FormStatus.initial,
    this.extraProperties,
    this.displayMenu
  });

  CSREventState copyWith({
    List<CSREventGiModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    Locations? locations,
    String? message,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    EPUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return CSREventState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
      labels: labels ?? this.labels,
      extraProperties: extraProperties ?? this.extraProperties,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
