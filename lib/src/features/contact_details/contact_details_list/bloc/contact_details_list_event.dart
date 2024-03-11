part of 'contact_details_list_bloc.dart';

abstract class ContactDetailsListEvent extends Equatable {
  const ContactDetailsListEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends ContactDetailsListEvent {
  final int startPos;
  final int maxPos;
  final bool newSearch;
  final BaseFilterModel filters;

  const FetchData({required this.startPos, required this.maxPos,required this.newSearch, required this.filters});
}

class InitializeValuesCD extends ContactDetailsListEvent {
  const InitializeValuesCD();
}

class RefreshList extends ContactDetailsListEvent {
  const RefreshList();
}
