import 'package:equatable/equatable.dart';

import '../models/day_passlist_model.dart';

enum DayPassListStateType {
  initial,
  loading,
  success,
  failure,
}

class DayPassListState extends Equatable {
  final DayPassListResponse? foundListModel;
  final DayPassListElement? foundArticleDetails;
  final String? errorMessage;
  final DayPassListStateType stateType;

  const DayPassListState({
    this.foundListModel,
    this.foundArticleDetails,
    required this.stateType,
    this.errorMessage,
  });

  DayPassListState copyWith({
    DayPassListResponse? foundListModel,
    DayPassListElement? foundArticleDetails,
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
