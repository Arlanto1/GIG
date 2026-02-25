part of 'material_items_bloc.dart';
class MaterialItemsState extends Equatable {
  final List<MaterialMovementItem>? items;
  final bool hasReachedMax;
  final FormStatus status;
  final List<Organisation>? units;
  // final Map<String, dynamic>? staffCategoriesValues;
  final String? message;
  final SlaUiLabels? labels;

  const MaterialItemsState({
    this.message,
    this.items = const <MaterialMovementItem>[],
    this.hasReachedMax = false,
    this.status = FormStatus.initial,
    this.units,
    // this.staffCategoriesValues,
    this.labels,
  });

  MaterialItemsState copyWith({
    List<MaterialMovementItem>? items,
    bool? hasReachedMax,
    FormStatus? status,
    List<Organisation>? units,
    // Map<String, dynamic>? staffCategoriesValues,
    String? message,
    SlaUiLabels? labels,
  }) {
    return MaterialItemsState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      units:
      units ?? this.units,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [items, hasReachedMax, status, units];
}
 