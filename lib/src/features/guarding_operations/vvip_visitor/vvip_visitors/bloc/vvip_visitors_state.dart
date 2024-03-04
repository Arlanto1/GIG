part of 'vvip_visitors_bloc.dart';

class VVIPVisitorsState extends Equatable {
  final List<VIVPVisitorModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final SlaUiLabels? labels;
  final String? message;
  final Locations? locations;
  final CommonFilters? commonFilters;

  const VVIPVisitorsState({
    this.items = const <VIVPVisitorModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
    this.message,
    this.locations,
    this.commonFilters,
  });

  VVIPVisitorsState copyWith({
    List<VIVPVisitorModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    SlaUiLabels? labels,
    String? message,
    CommonFilters? commonFilters,
    Locations? locations,
    List<Organisation>? regions,
    List<Organisation>? statuses,
  }) {
    return VVIPVisitorsState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      labels: labels ?? this.labels,
      message: message ?? this.message,
      locations: locations ?? this.locations,
      commonFilters: commonFilters ?? this.commonFilters,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
