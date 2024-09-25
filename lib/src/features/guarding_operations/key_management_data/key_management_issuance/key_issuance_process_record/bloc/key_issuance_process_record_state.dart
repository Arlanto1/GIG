part of 'key_issuance_process_record_bloc.dart';

class KeyIssuanceProcessRecordState extends Equatable {
  final List<KeyIssuanceProcessRecord> items;
  final bool hasReachedMax;
  final FormStatus status;
  final List<Organisation>? keyDescriptions;
  final Organisation? keyDescription;
  final String? message;
  final KMUiLabels? labels;
  final ExtraProperties? extraProperties;
  final bool isEligibleToEdit;

  const KeyIssuanceProcessRecordState({
    this.message,
    this.items = const <KeyIssuanceProcessRecord>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.keyDescriptions,
    this.keyDescription,
    this.labels,
    this.extraProperties,
    this.isEligibleToEdit = false,
  });

  KeyIssuanceProcessRecordState copyWith({
    List<KeyIssuanceProcessRecord>? items,
    bool? hasReachedMax,
    FormStatus? status,
    List<Organisation>? keyDescriptions,
    Organisation? keyDescription,
    String? message,
    KMUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return KeyIssuanceProcessRecordState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      keyDescriptions: keyDescriptions ?? this.keyDescriptions,
      keyDescription: keyDescription ?? this.keyDescription,
      message: message ?? this.message,
      labels: labels ?? this.labels,
      extraProperties: extraProperties ?? this.extraProperties,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
