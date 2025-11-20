

part of 'visitor_pass_management_list_bloc.dart';


class VisitorPassManagementListState extends Equatable {
  final List<VisitorPassManagementModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final User? loggedInUser;
  final String? message;
  final PMUiLabels? labels;
  final ExtraProperties? extraProperties;
  final VisitorPassManagementModel? model;
  final DisplayMenu? displayMenu;

  const VisitorPassManagementListState({
    this.items = const <VisitorPassManagementModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.locations,
    this.commonFilters,
    this.loggedInUser,
    this.labels,
    this.extraProperties,
    this.model,
    this.displayMenu,
  });

  VisitorPassManagementListState copyWith({
    List<VisitorPassManagementModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    User? loggedInUser,
    PMUiLabels? labels,
    ExtraProperties? extraProperties,
  }) {
    return VisitorPassManagementListState(
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
