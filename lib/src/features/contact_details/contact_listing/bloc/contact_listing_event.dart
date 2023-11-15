part of 'contact_listing_bloc.dart';

abstract class ContactListingEvent extends Equatable {
  const ContactListingEvent();
  @override
  List<Object?> get props => [];
}

class FetchData extends ContactListingEvent{

  final int startPos;
  final int maxPos;

  const FetchData({required this.startPos, required this.maxPos});
}

