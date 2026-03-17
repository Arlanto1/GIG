part of 'transport_medical_list_bloc.dart';

abstract class TransportMedicalEvent extends Equatable {
  const TransportMedicalEvent();

  @override
  List<Object?> get props => [];
}

class FetchTMData extends TransportMedicalEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchTMData(
      {required this.startPos,
        required this.maxPos,
        required this.newSearch,
        required this.filters});
}

class InitializeValuesTM extends TransportMedicalEvent {
  const InitializeValuesTM();
}

class RefreshList extends TransportMedicalEvent {
  const RefreshList();
}
