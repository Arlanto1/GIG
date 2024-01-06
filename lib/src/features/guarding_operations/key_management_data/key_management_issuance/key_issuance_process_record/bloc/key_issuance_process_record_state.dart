part of 'key_issuance_process_record_bloc.dart';

class KeyIssuanceProcessRecordState extends Equatable {
  final List<KeyIssuanceProcessRecord>? items;
  final bool hasReachedMax;
  final FormStatus status;
  final List<Organisation>? keyDescriptions;
  final String? message;
  final SlaUiLabels? labels;

  const KeyIssuanceProcessRecordState({
    this.message,
    this.items = const <KeyIssuanceProcessRecord>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.keyDescriptions,
    this.labels,
  });

  KeyIssuanceProcessRecordState copyWith({
    List<KeyIssuanceProcessRecord>? items,
    bool? hasReachedMax,
    FormStatus? status,
    List<Organisation>? keyDescriptions,
    String? message,
    SlaUiLabels? labels,
  }) {
    return KeyIssuanceProcessRecordState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      keyDescriptions:
      keyDescriptions ?? this.keyDescriptions,
      message: message ?? this.message,
      labels: labels ?? this.labels,
    );
  }

  @override
  List<Object?> get props =>
      [items, hasReachedMax, status];
}
