part of 'pay_rate_bloc.dart';

class PayRateState extends Equatable {
  final List<GMRate> items;
  final bool hasReachedMax;
  final LawEnforcementListStateType status;

  const PayRateState(
      {this.items = const <GMRate>[],
        this.hasReachedMax = false,
        this.status = LawEnforcementListStateType.initial});

  PayRateState copyWith({
    List<GMRate>? items,
    bool? hasReachedMax,
    LawEnforcementListStateType? status,
  }) {
    return PayRateState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
