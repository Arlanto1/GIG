import 'package:db_atom/src/enums/form_status.dart';
import 'package:equatable/equatable.dart';

import '../models/day_passlist_model.dart';

class DayPassListState extends Equatable {
  final DayPassListResponse? foundListModel;
  final PassManagementModel? foundArticleDetails;
  final String? errorMessage;
  final FormStatus stateType;

  const DayPassListState({
    this.foundListModel,
    this.foundArticleDetails,
    required this.stateType,
    this.errorMessage,
  });

  DayPassListState copyWith({
    DayPassListResponse? foundListModel,
    PassManagementModel? foundArticleDetails,
    String? errorMessage,
    FormStatus? stateType,
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
