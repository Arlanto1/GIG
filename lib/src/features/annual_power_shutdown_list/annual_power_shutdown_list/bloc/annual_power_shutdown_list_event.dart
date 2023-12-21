part of 'annual_power_shutdown_list_bloc.dart';


abstract class AnnualPowerShutdownListEvent extends Equatable {
  const AnnualPowerShutdownListEvent();
  @override
  List<Object?> get props => [];
}

class FetchData extends AnnualPowerShutdownListEvent{

  final int startPos;
  final int maxPos;

  const FetchData({required this.startPos, required this.maxPos});
}
