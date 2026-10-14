
part of 'parking_list_bloc.dart';

abstract class ParkingListEvent extends Equatable{
  const ParkingListEvent();

  @override
  List<Object?> get props => [];
}

class FetchParkingData extends ParkingListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;
  final String? eventId;

  const FetchParkingData(
      {required this.startPos,
        required this.maxPos,
        required this.newSearch,
        required this.filters, this.eventId} );
}

class InitializeValuesParking extends ParkingListEvent{
  const InitializeValuesParking();
}

class RefreshParkingList extends ParkingListEvent{
  const RefreshParkingList();
}
