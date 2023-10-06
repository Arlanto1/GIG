part of 'sla_violation_bloc.dart';


abstract class SLAViolationEvent extends Equatable {
  const SLAViolationEvent();
  @override
  List<Object?> get props => [];
}

class InwardFetch extends SLAViolationEvent{

  final int startPos;
  final int maxPos;

  const InwardFetch({required this.startPos, required this.maxPos});
}
