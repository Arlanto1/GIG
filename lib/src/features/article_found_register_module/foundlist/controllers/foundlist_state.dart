// Created by Ramesh
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:equatable/equatable.dart';

enum FoundListStateType {
  initial,
  loading,
  success,
  failure,
}

class FoundListState extends Equatable {
  FoundListModel? foundListModel;
  FoundListArticleDetails? foundArticleDetails;
  final String? errorMessage;
  late final FoundListStateType stateType;

  FoundListState({
    this.foundListModel,
    this.foundArticleDetails,
    required this.stateType,
    this.errorMessage,
  });

  FoundListState copyWith({
    FoundListModel? foundListModel,
    FoundListArticleDetails? foundArticleDetails,
    String? errorMessage,
    FoundListStateType? stateType,
  }) {
    return FoundListState(
      foundListModel: foundListModel ?? this.foundListModel,
      foundArticleDetails: foundArticleDetails ?? this.foundArticleDetails,
      errorMessage: errorMessage ?? this.errorMessage,
      stateType: stateType ?? this.stateType,
    );
  }

  @override
  List<Object?> get props => [
        foundListModel,
        foundArticleDetails,
        errorMessage,
        stateType,
      ];
}
