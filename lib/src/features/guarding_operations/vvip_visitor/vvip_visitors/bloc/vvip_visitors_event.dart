part of 'vvip_visitors_bloc.dart';

abstract class VVIPVisitorsEvent extends Equatable {
  const VVIPVisitorsEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends VVIPVisitorsEvent {
  final int startPos;
  final int maxPos;

  const FetchData({required this.startPos, required this.maxPos});
}
class InitializeValues extends VVIPVisitorsEvent {
  const InitializeValues();
}
