part of 'violation_penalty_record_bloc.dart';

class ViolationPenaltyRecordState extends Equatable {
  final List<ViolationPenaltyRecord>? items;
  final bool hasReachedMax;
  final FormStatus status;
  final List<Organisation>? violationDescription;
  final String? message;

  const ViolationPenaltyRecordState({
    this.message,
    this.items = const <ViolationPenaltyRecord>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.violationDescription,
  });

  ViolationPenaltyRecordState copyWith({
    List<ViolationPenaltyRecord>? items,
    bool? hasReachedMax,
    FormStatus? status,
    List<Organisation>? violationDescription,
    String? message,
  }) {
    return ViolationPenaltyRecordState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      violationDescription: violationDescription ?? this.violationDescription,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
