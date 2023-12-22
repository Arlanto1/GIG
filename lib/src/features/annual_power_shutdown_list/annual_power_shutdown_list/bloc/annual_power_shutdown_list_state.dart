part of 'annual_power_shutdown_list_bloc.dart';

class AnnualPowerShutdownListState extends Equatable {
  final List<AnnualPowerShutDownModel> items;
  final bool hasReachedMax;
  final FormStatus status;

  const AnnualPowerShutdownListState(
      {this.items = const <AnnualPowerShutDownModel>[],
        this.hasReachedMax = false,
        this.status = FormStatus.initial});

  AnnualPowerShutdownListState copyWith({
    List<AnnualPowerShutDownModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
  }) {
    return AnnualPowerShutdownListState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
