part of 'sst_incident_bloc.dart';


abstract class SstIncidentEvent extends Equatable {
  const SstIncidentEvent();
  @override
  List<Object?> get props => [];
}

class FetchData extends SstIncidentEvent{

  final int startPos;
  final int maxPos;

  const FetchData({required this.startPos, required this.maxPos});
}
