part of 'violation_penalty_record_bloc.dart';

class ViolationPenaltyRecordState extends Equatable {
  final List<ViolationPenaltyRecord>? items;
  final bool hasReachedMax;
  final FormStatus status;
  final List<Organisation>? violationDescriptions;

  final String? message;

  const ViolationPenaltyRecordState({
    this.message,
    this.items = const <ViolationPenaltyRecord>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.violationDescriptions,
  });

  ViolationPenaltyRecordState copyWith({
    List<ViolationPenaltyRecord>? items,
    bool? hasReachedMax,
    FormStatus? status,
    List<Organisation>? violationDescriptions,
    String? message,
  }) {
    return ViolationPenaltyRecordState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      violationDescriptions:
          violationDescriptions ?? this.violationDescriptions,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [items, hasReachedMax, status, violationDescriptions];
}
