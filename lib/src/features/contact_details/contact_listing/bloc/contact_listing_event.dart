part of 'contact_listing_bloc.dart';

abstract class ContactListingEvent extends Equatable {
  const ContactListingEvent();

  @override
  List<Object?> get props => [];
}

class FetchData extends ContactListingEvent {
  final int id;
  final int type;
  final int startPos;
  final int maxPos;

  const FetchData({
    required this.id,
    required this.type,
    required this.startPos,
    required this.maxPos,
  });
}

class InitializeValues extends ContactListingEvent {
  const InitializeValues();
}
