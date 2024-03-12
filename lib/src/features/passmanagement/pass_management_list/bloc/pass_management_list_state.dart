part of 'pass_management_list_bloc.dart';

class PassManagementListState extends Equatable {
  final List<PassManagementModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final User? loggedInUser;
  final String? message;
  final PMUiLabels? labels;

  const PassManagementListState({
    this.items = const <PassManagementModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.locations,
    this.commonFilters,
    this.loggedInUser,
    this.labels,
  });

  PassManagementListState copyWith({
    List<PassManagementModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    User? loggedInUser,
    PMUiLabels? labels,
  }) {
    return PassManagementListState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
      loggedInUser: loggedInUser ?? this.loggedInUser,
      labels: labels ?? this.labels,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
