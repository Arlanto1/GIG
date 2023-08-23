part of 'guarding_rates_bloc.dart';

abstract class GuardingRatesEvent extends Equatable {
  const GuardingRatesEvent();
  @override
  List<Object?> get props => [];
}


class FetchList extends GuardingRatesEvent{

  final int startPos;
  final int maxPos;

  const FetchList({required this.startPos, required this.maxPos});
}
