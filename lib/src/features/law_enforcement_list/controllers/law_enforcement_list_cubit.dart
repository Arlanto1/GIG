import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/law_enforcement_list/controllers/law_enforcement_list_state.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_list_response.dart';
import 'package:db_atom/src/features/lawenforcement/services/law_enforcement_services.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../enums/form_status.dart';

class LawEnforcementListCubit extends Cubit<LawEnforcementListState> {
  final LawEnforcementServices services;

  LawEnforcementListCubit({
    required this.services,
  }) : super(
          LawEnforcementListState(
            lawEnforcementListModel: LawEnforcementListResponse(),
            stateType: FormStatus.initial,
          ),
        );

  // Found Article list API call
  Future<void> getLawEnforcementList(String startPosition,
      String maximumRecords, String userId, BuildContext context) async {
    // if (startPosition == '0') {
    //   emit(state.copyWith(stateType: LawEnforcementListStateType.loading));
    // }
    try {
      LawEnforcementListResponse foundListModelResponse =
          await services.getList(
              startPosition: startPosition,
              maximumRecords: maximumRecords,
              userId: userId,
              context: context);

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        if (startPosition != '0') {
          dismissLoadingDialog(context);
        }
      });
      emit(
        state.copyWith(
          lawEnforcementListModel: foundListModelResponse,
          stateType: FormStatus.success,
        ),
      );
    } catch (e) {
      print(e);
      if (startPosition != '0') {
        dismissLoadingDialog(context);
      }
      if (startPosition == '0') {
        emit(
          state.copyWith(
            errorMessage: Constants.errorText,
            stateType: FormStatus.failure,
          ),
        );
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Utils.dynamicAlert(context, Constants.errorText,
              Constants.addarticletype, Constants.errorText);
        });
      }
    }
  }

  // Found Article detials by Id API call
  Future<LawEnforcementDetails?> getById(
      int id, BuildContext context) async {
    try {
      LawEnforcementDetails model =
          await services.getById(id, context);
      emit(
        state.copyWith(
          lawEnforcementDetails: model,
          stateType: FormStatus.success,
        ),
      );
      return model;
    } catch (e) {
      // emit(
      //   state.copyWith(
      //     errorMessage: Constants.errorText,
      //     stateType: FoundListStateType.failure,
      //   ),
      // );
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.dynamicAlert(context, Constants.errorText,
            Constants.addarticletype, Constants.errorText);
      });
    }
    return null;
  }
}
