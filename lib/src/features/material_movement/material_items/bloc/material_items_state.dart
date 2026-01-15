// part of 'material_items_bloc.dart';
//
// class MaterialItemsState extends Equatable {
//   final List<MaterialDetails>? items;
//   final bool hasReachedMax;
//   final FormStatus status;
//   final String? message;
//   final VVIPUiLabels? labels;
//   final DisplayMenu? displayMenu;
//
//
//   const MaterialItemsState({
//     this.message,
//     this.items = const <MaterialDetails>[],
//     this.hasReachedMax = false,
//     this.status = FormStatus.initial,
//     this.labels,
//     this.displayMenu
//   });
//
//   MaterialItemsState copyWith({
//     List<MaterialDetails>? items,
//     bool? hasReachedMax,
//     FormStatus? status,
//     String? message,
//     VVIPUiLabels? labels,
//   }) {
//     return MaterialItemsState(
//       items: items ?? this.items,
//       hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//       status: status ?? this.status,
//       message: message ?? this.message,
//       labels: labels ?? this.labels,
//     );
//   }
//
//   @override
//   List<Object?> get props => [items, hasReachedMax, status];
// }
