part of 'event_protections_bloc.dart';

abstract class EventProtectionsEvent extends Equatable {
  const EventProtectionsEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends EventProtectionsEvent {
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

class InitializeValuesEP extends EventProtectionsEvent {
  const InitializeValuesEP();
}

class RefreshList extends EventProtectionsEvent {
  const RefreshList();
}
