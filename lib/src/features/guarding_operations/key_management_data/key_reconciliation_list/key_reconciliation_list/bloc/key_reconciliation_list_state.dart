part of 'key_reconciliation_list_bloc.dart';

class KeyReconciliationListState extends Equatable {
  final List<KeyReconciliationListModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  final KMUiLabels? labels;
  final String? message;
  final CommonFilters? commonFilters;
  final Locations? locations;
  final ExtraProperties? extraProperties;

  const KeyReconciliationListState({
    this.list = const <KeyReconciliationListModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
    this.message,
    this.locations,
    this.commonFilters,
    this.extraProperties,
  });

  KeyReconciliationListState copyWith({
    List<KeyReconciliationListModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    KMUiLabels? labels,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    ExtraProperties? extraProperties,
  }) {
    return KeyReconciliationListState(
      list: items ?? list,
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
  List<Object?> get props => [list, hasReachedMax, status];
}
