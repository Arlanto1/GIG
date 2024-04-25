part of 'key_loss_destruction_list_bloc.dart';

class KeyLossDestructionListState extends Equatable {
  final List<KeyLossDestructionListModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  final KLDUiLabels? labels;
  final String? message;
  final CommonFilters? commonFilters;
  final Locations? locations;
  final ExtraProperties? extraProperties;

  const KeyLossDestructionListState({
    this.list = const <KeyLossDestructionListModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
    this.message,
    this.locations,
    this.commonFilters,
    this.extraProperties,
  });

  KeyLossDestructionListState copyWith({
    List<KeyLossDestructionListModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    KLDUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return KeyLossDestructionListState(
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
