part of 'key_history_record_bloc.dart';

class KeyHistoryRecordState extends Equatable {
  final List<KeyManagementMasterModel> list;
  final bool hasReachedMax;
  final FormStatus status;
  final String? message;
  final KMUiLabels? labels;
  final ExtraProperties? extraProperties;

  const KeyHistoryRecordState({
    this.list = const <KeyManagementMasterModel>[],
    this.hasReachedMax = false,
    this.message,
    this.status = FormStatus.initial,
    this.labels,
    this.extraProperties,
  });

  KeyHistoryRecordState copyWith({
    List<KeyManagementMasterModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    KMUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return KeyHistoryRecordState(
      list: items ?? list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      labels: labels ?? this.labels,
      extraProperties: extraProperties ?? this.extraProperties,
    );
  }

  @override
  List<Object?> get props => [list, hasReachedMax, status];
}
