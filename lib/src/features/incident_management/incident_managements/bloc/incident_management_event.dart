part of 'incident_management_bloc.dart';


abstract class IncidentManagementsEvent extends Equatable {
  const IncidentManagementsEvent();
  @override
  List<Object?> get props => [];
}

class FetchData extends IncidentManagementsEvent{

  final int startPos;
  final int maxPos;

  const FetchData({required this.startPos, required this.maxPos});
}
