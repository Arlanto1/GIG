part of 'material_movement_bloc.dart';

class MaterialMovementState extends Equatable {
  final List<MaterialMovementModel> items;
  final bool hasReachedMax;
  final FormStatus status;
  final Locations? locations;
  final CommonFilters? commonFilters;
  final User? loggedInUser;
  final String? message;
  final MmUiLabels? labels;
  final ExtraProperties? extraProperties;
  final MaterialMovementModel? model;
  final DisplayMenu? displayMenu;
  final ApprovalModel? approvalModel;
  final int? selectedId;
  // final int? objectId;

  const MaterialMovementState({
    this.items = const <MaterialMovementModel>[],
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
    this.approvalModel,
    this.selectedId,
    // this.objectId,
  });

  MaterialMovementState copyWith({
    List<MaterialMovementModel>? items,
    bool? hasReachedMax,
    FormStatus? status,
    String? message,
    Locations? locations,
    CommonFilters? commonFilters,
    List<Organisation>? regions,
    List<Organisation>? statuses,
    User? loggedInUser,
    MmUiLabels? labels,
    ExtraProperties? extraProperties,
    ApprovalModel? approvalModel,
    int? selectedId,
    // int? objectId,
  }) {
    return MaterialMovementState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      message: message ?? this.message,
      commonFilters: commonFilters ?? this.commonFilters,
      locations: locations ?? this.locations,
      loggedInUser: loggedInUser ?? this.loggedInUser,
      labels: labels ?? this.labels,
      extraProperties: extraProperties ?? this.extraProperties,
        approvalModel:approvalModel??this.approvalModel,
        selectedId:selectedId??this.selectedId,
        // objectId:objectId??this.objectId,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax, status];
}
