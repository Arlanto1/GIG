part of 'sla_violation_penalty_list_bloc.dart';

abstract class SLAViolationPenaltyListEvent extends Equatable {
  const SLAViolationPenaltyListEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends SLAViolationPenaltyListEvent {
  final int startPos;
  final int maxPos;

  const FetchData({required this.startPos, required this.maxPos});
}
