part of 'material_movement_bloc.dart';

class MaterialMovementState extends Equatable {
  final List<MaterialMovementModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final List<Organisation>? regions;
  final List<Organisation>? statuses;
  final User? loggedInUser;
  final String? message;

  const MaterialMovementState({
    this.items = const <MaterialMovementModel>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.message,
    this.locations,
    this.regions,
    this.statuses,
    this.loggedInUser,
  });

  MaterialMovementState copyWith({
    List<MaterialMovementModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    User? loggedInUser,
  }) {
    return MaterialMovementState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      regions: regions ?? this.regions,
      statuses: statuses ?? this.statuses,
      locations: locations ?? this.locations,
      loggedInUser: loggedInUser ?? this.loggedInUser,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
