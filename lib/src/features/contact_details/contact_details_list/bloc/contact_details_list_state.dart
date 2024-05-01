part of 'contact_details_list_bloc.dart';

class ContactDetailsListState extends Equatable {
  final List<ContactDetailModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final CdUiLabels? labels;
  final String? message;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final ExtraProperties? extraProperties;

  const ContactDetailsListState({
    this.items = const <ContactDetailModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.labels,
    this.message,
    this.locations,
    this.commonFilters,
    this.extraProperties,
  });

  ContactDetailsListState copyWith({
    List<ContactDetailModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    CdUiLabels? labels,
    String? message,
    CommonFilters? commonFilters,
    Locations? locations,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    ExtraProperties? extraProperties,
  }) {
    return ContactDetailsListState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      labels: labels ?? this.labels,
      message: message ?? this.message,
      locations: locations ?? this.locations,
      commonFilters: commonFilters ?? this.commonFilters,
      extraProperties: extraProperties ?? this.extraProperties,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
