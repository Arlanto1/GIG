part of 'sst_incident_bloc.dart';

abstract class SstIncidentEvent extends Equatable {
  const SstIncidentEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends SstIncidentEvent {
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

class InitializeValues extends SstIncidentEvent {
  const InitializeValues();
}

class RefreshList extends SstIncidentEvent {
  const RefreshList();
}

class SendReminderEmail extends SstIncidentEvent {
  final int id;
  const SendReminderEmail({required this.id});
}
