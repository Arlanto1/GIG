part of 'guarding_rates_bloc.dart';

abstract class GuardingRatesEvent extends Equatable {
  const GuardingRatesEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends GuardingRatesEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchData(
      {required this.startPos,
      required this.maxPos,
      required this.newSearch,
      required this.filters});
}

class InitializeValuesGR extends GuardingRatesEvent {
  const InitializeValuesGR();
}

class RefreshList extends GuardingRatesEvent {
  const RefreshList();
}
