part of 'contact_record_bloc.dart';

class ContactRecordState extends Equatable {
  final List<ContactRecord>? items;
  final bool hasReachedMax;
  final FormStatus status;
  final List<Organisation> ranks;
  final String? message;
  final ContactsListModel? model;

  const ContactRecordState({
    this.message,
    this.items = const <ContactRecord>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    required this.ranks,
    this.model,
  });

  ContactRecordState copyWith({
    List<ContactRecord>? items,
    bool? hasReachedMax,
    FormStatus? status,
    List<Organisation>? ranks,
    String? message,
    ContactsListModel? model,
  }) {
    return ContactRecordState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      ranks: ranks ?? this.ranks,
      message: message ?? this.message,
      model: model ?? this.model,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
