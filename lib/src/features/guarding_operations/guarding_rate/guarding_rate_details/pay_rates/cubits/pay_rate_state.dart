part of 'pay_rate_cubit.dart';

class PayRateState extends Equatable {
  final FormStatus status;
  final GMRate rate;
  final List<PayRate> items;
  final PayRate newPayRate;
  final String? message;

  factory PayRateState.initial({
    required List<PayRate> payRates,
    required GMRate rate,
    required String? message,
    required newPayRate,
  }) {
    return PayRateState(
      status: FormStatus.initial,
      items: payRates,
      message: message,
      rate: rate,
        newPayRate:newPayRate,
    );
  }

  @override
  List<Object?> get props => [rate, status];

  const PayRateState({
    required this.status,
    required this.rate,
    required this.items,
    required this.newPayRate,
    this.message,
  });

  PayRateState copyWith({
    FormStatus? status,
    GMRate? rate,
    List<PayRate>? items,
    PayRate? newPayRate,
    String? message,
  }) {
    return PayRateState(
      status: status ?? this.status,
      rate: rate ?? this.rate,
      items: items ?? this.items,
      newPayRate: newPayRate ?? this.newPayRate,
      message: message ?? this.message,
    );
  }
}
