part of 'incident_management_bloc.dart';

abstract class IncidentManagementsEvent extends Equatable {
  const IncidentManagementsEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends IncidentManagementsEvent {
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

class InitializeValues extends IncidentManagementsEvent {
  const InitializeValues();
}

class RefreshList extends IncidentManagementsEvent {
  const RefreshList();
}
