part of 'pay_rate_bloc.dart';

abstract class PayRateEvent extends Equatable {
  const PayRateEvent();
  @override
  List<Object?> get props => [];
}


class FetchList extends PayRateEvent{

  final int startPos;
  final int maxPos;

  const FetchList({required this.startPos, required this.maxPos});
}
