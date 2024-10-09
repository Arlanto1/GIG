part of 'ticketing_system_bloc.dart';

abstract class TicketingSystemEvent extends Equatable {
  const TicketingSystemEvent();

  @override
  List<Object?> get props => [];
}

class FetchTicketingSystemData extends TicketingSystemEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchTicketingSystemData(
      {required this.startPos,
        required this.maxPos,
        required this.newSearch,
        required this.filters});
}

class InitializeValues extends TicketingSystemEvent {
  const InitializeValues();
}

class RefreshList extends TicketingSystemEvent {
  const RefreshList();
}
