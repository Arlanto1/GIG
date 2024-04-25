part of 'sla_violation_penalty_list_bloc.dart';

class SLAViolationPenaltyListState extends Equatable {
  final List<SLAViolationPenaltyModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final SlaUiLabels? labels;
  final String? message;
  final CommonFilters? commonFilters;
  final Locations? locations;
  final ExtraProperties? extraProperties;

  const SLAViolationPenaltyListState({
    this.items = const <SLAViolationPenaltyModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
    this.message,
    this.locations,
    this.commonFilters,
    this.extraProperties,
  });

  SLAViolationPenaltyListState copyWith({
    List<SLAViolationPenaltyModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    SlaUiLabels? labels,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    ExtraProperties? extraProperties,
  }) {
    return SLAViolationPenaltyListState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      labels: labels ?? this.labels,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
      extraProperties: extraProperties ?? this.extraProperties,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
