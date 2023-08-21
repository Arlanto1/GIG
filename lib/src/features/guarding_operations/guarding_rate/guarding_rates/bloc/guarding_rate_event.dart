part of 'guarding_rate_bloc.dart';

abstract class GuardingRateEvent extends Equatable {
  const GuardingRateEvent();
  @override
  List<Object?> get props => [];
}


class FetchList extends GuardingRateEvent{

  final int startPos;
  final int maxPos;

  const FetchList({required this.startPos, required this.maxPos});
}
