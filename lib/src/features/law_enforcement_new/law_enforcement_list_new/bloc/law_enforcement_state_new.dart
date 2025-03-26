

part of 'law_enforcement_bloc_new.dart';

class LawEnforcementNewState extends Equatable {
  final List<LawEnforcementModelNew> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final User? loggedInUser;
  final String? message;
  final LeoUiLabels? labels;
  final ExtraProperties? extraProperties;
  final LawEnforcementModelNew? model;

  const LawEnforcementNewState({
    this.items = const <LawEnforcementModelNew>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.locations,
    this.commonFilters,
    this.loggedInUser,
    this.labels,
    this.extraProperties,
    this.model,
  });

  LawEnforcementNewState copyWith({
    List<LawEnforcementModelNew>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    User? loggedInUser,
    LeoUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return LawEnforcementNewState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
      loggedInUser: loggedInUser ?? this.loggedInUser,
      labels: labels ?? this.labels,
      extraProperties: extraProperties ?? this.extraProperties,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
