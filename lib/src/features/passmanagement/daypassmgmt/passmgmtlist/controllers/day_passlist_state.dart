// Created by Ramesh


import 'package:equatable/equatable.dart';

import '../models/day_passlist_item_model.dart';

enum DayPassListStateType {
  initial,
  loading,
  success,
  failure,
}

class DayPassListState extends Equatable {
  DayPassListResponse? foundListModel;
  DayPassListItemResponse? foundArticleDetails;
  final String? errorMessage;
  late final DayPassListStateType stateType;

  DayPassListState({
    this.foundListModel,
    this.foundArticleDetails,
    required this.stateType,
    this.errorMessage,
  });

  DayPassListState copyWith({
    DayPassListResponse? foundListModel,
    DayPassListItemResponse? foundArticleDetails,
    String? errorMessage,
    DayPassListStateType? stateType,
  }) {
    return DayPassListState(
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
