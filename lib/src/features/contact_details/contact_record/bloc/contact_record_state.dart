part of 'contact_record_bloc.dart';

class ContactRecordState extends Equatable {
  final List<Contact>? items;
  final bool hasReachedMax;
  final FormStatus status;
  final List<BaseUser>? users;
  final String? message;

  const ContactRecordState({
    this.message,
    this.items = const <Contact>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.users,
  });

  ContactRecordState copyWith({
    List<Contact>? items,
    bool? hasReachedMax,
    FormStatus? status,
    List<BaseUser>? users,
    String? message,
  }) {
    return ContactRecordState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      users: users ?? this.users,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
