part of 'annual_power_shutdown_list_bloc.dart';

abstract class AnnualPowerShutdownListEvent extends Equatable {
  const AnnualPowerShutdownListEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends AnnualPowerShutdownListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchData({required this.startPos, required this.maxPos,required this.newSearch, required this.filters});
}

class InitializeValuesAPS extends AnnualPowerShutdownListEvent {
  const InitializeValuesAPS();
}

class RefreshList extends AnnualPowerShutdownListEvent {
  const RefreshList();
}
