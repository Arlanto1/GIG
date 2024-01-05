part of 'key_issuance_process_record_bloc.dart';

class KeyIssuanceProcessRecordState extends Equatable {
  final List<KeyIssuanceProcessRecord>? items;
  final bool hasReachedMax;
  final FormStatus status;
  final List<Organisation>? violationDescriptions;
  final Map<String, dynamic>? getKeyDescriptionValues;
  final String? message;
  final SlaUiLabels? labels;

  const KeyIssuanceProcessRecordState({
    this.message,
    this.items = const <KeyIssuanceProcessRecord>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.violationDescriptions,
    this.getKeyDescriptionValues,
    this.labels,
  });

  KeyIssuanceProcessRecordState copyWith({
    List<KeyIssuanceProcessRecord>? items,
    bool? hasReachedMax,
    FormStatus? status,
    List<Organisation>? violationDescriptions,
    Map<String, dynamic>? getKeyDescriptionValues,
    String? message,
    SlaUiLabels? labels,
  }) {
    return KeyIssuanceProcessRecordState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      violationDescriptions:
          violationDescriptions ?? this.violationDescriptions,
      getKeyDescriptionValues:
      getKeyDescriptionValues ?? this.getKeyDescriptionValues,
      message: message ?? this.message,
      labels: labels ?? this.labels,
    );
  }

  @override
  List<Object?> get props =>
      [items, hasReachedMax, status, violationDescriptions];
}
