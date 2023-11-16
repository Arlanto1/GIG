part of 'contact_listing_bloc.dart';

class ContactListingState extends Equatable {
  final List<ContactsListModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final List<BaseUser>? users;

  const ContactListingState({
    this.items = const <ContactsListModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.users,
  });

  ContactListingState copyWith({
    List<ContactsListModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    List<BaseUser>? users,
  }) {
    return ContactListingState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
