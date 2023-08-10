// Created by Ramesh

import 'package:db_atom/src/features/passmanagement/daypassregister/models/day_pass_info_response_model.dart';
import 'package:equatable/equatable.dart';

enum DayPassInfoStateType {
  initial,
  loading,
  success,
  failure,
}

class DayPassInfoState extends Equatable {
  DayPassInfoResponseModel? foundListModel;

  // DayPassListItemResponse? foundArticleDetails;
  final String? errorMessage;
  late final DayPassInfoStateType stateType;

  DayPassInfoState({
    this.foundListModel,
    // this.foundArticleDetails,
    required this.stateType,
    this.errorMessage,
  });

  DayPassInfoState copyWith({
    DayPassInfoResponseModel? foundListModel,
    //DayPassListItemResponse? foundArticleDetails,
    String? errorMessage,
    DayPassInfoStateType? stateType,
  }) {
    return DayPassInfoState(
      foundListModel: foundListModel ?? this.foundListModel,
      //foundArticleDetails: foundArticleDetails ?? this.foundArticleDetails,
      errorMessage: errorMessage ?? this.errorMessage,
      stateType: stateType ?? this.stateType,
    );
  }

  @override
  List<Object?> get props => [
        foundListModel,
        // foundArticleDetails,
        errorMessage,
        stateType,
      ];
}
