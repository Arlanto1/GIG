part of 'law_enforcement_list_bloc.dart';

class LawEnforcementListState extends Equatable {
  final List<LawEnforcementListElement> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final String? message;


  const LawEnforcementListState(
      {this.items = const <LawEnforcementListElement>[],
      this.hasReachedMax = false,
        this.message,
        this.locations,
        this.commonFilters,
      this.status = FormStatus.initial});

  LawEnforcementListState copyWith({
    List<LawEnforcementListElement>? todos,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
  }) {
    return LawEnforcementListState(
      items: todos ?? items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
