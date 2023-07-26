import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/law_enforcement_list/controllers/law_enforcement_list_state.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_list_response.dart';
import 'package:db_atom/src/features/law_enforcement_list/services/law_enforcement_list_services.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LawEnforcementListCubit extends Cubit<LawEnforcementListState> {
  final LawEnforcementListServices lawEnforcementListServices;

  LawEnforcementListCubit({
    required this.lawEnforcementListServices,
  }) : super(
          LawEnforcementListState(
            lawEnforcementListModel: LawEnforcementListResponse(),
            stateType: LawEnforcementListStateType.initial,
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
          await lawEnforcementListServices.getLawEnforcementList(
              startPosition, maximumRecords, userId);

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        if (startPosition != '0') {
          dismissLoadingDialog(context);
        }
      });
      emit(
        state.copyWith(
          lawEnforcementListModel: foundListModelResponse,
          stateType: LawEnforcementListStateType.success,
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
            stateType: LawEnforcementListStateType.failure,
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
  Future<LawEnforcementDetails?> getLawEnforcementById(
      int articleId, BuildContext context) async {
    try {
      LawEnforcementDetails foundArticleDetailsResponse =
          await lawEnforcementListServices.getLawEnforcementById(articleId);
      emit(
        state.copyWith(
          lawEnforcementDetails: foundArticleDetailsResponse,
          stateType: LawEnforcementListStateType.success,
        ),
      );
      return foundArticleDetailsResponse;
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
