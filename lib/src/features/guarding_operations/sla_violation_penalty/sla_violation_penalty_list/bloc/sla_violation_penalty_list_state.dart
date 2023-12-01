part of 'sla_violation_penalty_list_bloc.dart';

class SLAViolationPenaltyListState extends Equatable {
  final List<SLAViolationPenaltyModel> items;
  final bool hasReachedMax;
  final FormStatus status;

  const SLAViolationPenaltyListState(
      {this.items = const <SLAViolationPenaltyModel>[],
        this.hasReachedMax = false,
        this.status = FormStatus.initial});

  SLAViolationPenaltyListState copyWith({
    List<SLAViolationPenaltyModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
  }) {
    return SLAViolationPenaltyListState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
