part of 'sla_violation_penalty_list_bloc.dart';

class SLAViolationPenaltyListState extends Equatable {
  final List<SLAViolationPenaltyModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final SlaUiLabels? labels;
  final String? message;

  const SLAViolationPenaltyListState(
      {this.items = const <SLAViolationPenaltyModel>[],
        this.hasReachedMax = false,
        this.status = FormStatus.initial,
       this.labels,
        this.message,
      });

  SLAViolationPenaltyListState copyWith({
    List<SLAViolationPenaltyModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    SlaUiLabels? labels,
    String? message,
  }) {
    return SLAViolationPenaltyListState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      labels: labels ?? this.labels,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
