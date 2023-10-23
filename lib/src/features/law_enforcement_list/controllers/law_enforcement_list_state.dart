// Created by Ramesh
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_list_response.dart';
import 'package:equatable/equatable.dart';

import '../../../enums/form_status.dart';


class LawEnforcementListState extends Equatable {
  LawEnforcementListResponse? lawEnforcementListModel;
  LawEnforcementDetails? lawEnforcementDetails;
  final String? errorMessage;
  late final FormStatus stateType;

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
    FormStatus? stateType,
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
