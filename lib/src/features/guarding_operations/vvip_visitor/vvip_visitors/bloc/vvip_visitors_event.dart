part of 'vvip_visitors_bloc.dart';

abstract class VVIPVisitorsEvent extends Equatable {
  const VVIPVisitorsEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends VVIPVisitorsEvent {
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

class InitializeValues extends VVIPVisitorsEvent {
  const InitializeValues();
}

class RefreshList extends VVIPVisitorsEvent {
  const RefreshList();
}
