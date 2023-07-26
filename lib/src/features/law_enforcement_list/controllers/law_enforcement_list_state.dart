// Created by Ramesh
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_list_response.dart';
import 'package:equatable/equatable.dart';

enum LawEnforcementListStateType {
  initial,
  loading,
  success,
  failure,
}

class LawEnforcementListState extends Equatable {
  LawEnforcementListResponse? lawEnforcementListModel;
  LawEnforcementDetails? lawEnforcementDetails;
  final String? errorMessage;
  late final LawEnforcementListStateType stateType;

  LawEnforcementListState({
    this.lawEnforcementListModel,
    this.lawEnforcementDetails,
    required this.stateType,
    this.errorMessage,
  });

  LawEnforcementListState copyWith({
    LawEnforcementListResponse? lawEnforcementListModel,
    LawEnforcementDetails? lawEnforcementDetails,
    String? errorMessage,
    LawEnforcementListStateType? stateType,
  }) {
    return LawEnforcementListState(
      lawEnforcementListModel: lawEnforcementListModel ?? this.lawEnforcementListModel,
      lawEnforcementDetails: lawEnforcementDetails ?? this.lawEnforcementDetails,
      errorMessage: errorMessage ?? this.errorMessage,
      stateType: stateType ?? this.stateType,
    );
  }

  @override
  List<Object?> get props => [
        lawEnforcementListModel,
        lawEnforcementDetails,
        errorMessage,
        stateType,
      ];
}
