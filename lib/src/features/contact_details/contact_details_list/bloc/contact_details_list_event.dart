part of 'contact_details_list_bloc.dart';

abstract class ContactDetailsListEvent extends Equatable {
  const ContactDetailsListEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends ContactDetailsListEvent {
  final int startPos;
  final int maxPos;

  const FetchData({required this.startPos, required this.maxPos});
}
class InitializeValues extends ContactDetailsListEvent {
  const InitializeValues();
}