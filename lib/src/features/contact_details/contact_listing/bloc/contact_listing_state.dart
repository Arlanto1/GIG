part of 'contact_listing_bloc.dart';

class ContactListingState extends Equatable {
  final List<ContactDetailModel> items;
  final bool hasReachedMax;
  final FormStatus status;

  const ContactListingState(
      {this.items = const <ContactDetailModel>[],
      this.hasReachedMax = false,
      this.status = FormStatus.initial});

  ContactListingState copyWith({
    List<ContactDetailModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
  }) {
    return ContactListingState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
