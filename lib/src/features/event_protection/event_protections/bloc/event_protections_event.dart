part of 'event_protections_bloc.dart';


abstract class EventProtectionsEvent extends Equatable {
  const EventProtectionsEvent();
  @override
  List<Object?> get props => [];
}

class FetchData extends EventProtectionsEvent{

  final int startPos;
  final int maxPos;

  const FetchData({required this.startPos, required this.maxPos});
}
