part of 'contact_details_list_bloc.dart';

class ContactDetailsListState extends Equatable {
  final List<ContactDetailModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final CdUiLabels? labels;

  const ContactDetailsListState({
    this.items = const <ContactDetailModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
  });

  ContactDetailsListState copyWith({
    List<ContactDetailModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    CdUiLabels? labels,
  }) {
    return ContactDetailsListState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      labels: labels ?? this.labels,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
