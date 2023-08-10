import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/controllers/day_passlist_state.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_item_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/models/day_passlist_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/services/day_passlist_services.dart';

import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayPassListCubit extends Cubit<DayPassListState> {
  final DayPassListServices passListServices;

  DayPassListCubit({
    required this.passListServices,
  }) : super(
          DayPassListState(
            foundListModel: DayPassListResponse(),
            stateType: DayPassListStateType.initial,
          ),
        );

  // Found Article list API call
  Future<void> getFoundList(
      String startPosition, String maximumRecords, String userId,String passtype, BuildContext context) async {
    if (startPosition == '0') {
      emit(state.copyWith(stateType: DayPassListStateType.loading));
    }
    try {
      DayPassListResponse foundListModelResponse = await passListServices.getpassFoundArticleList(startPosition, maximumRecords, userId,passtype);
         
           SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          if (startPosition != '0')
          {
             dismissLoadingDialog(context);
          }
        });
      emit(
        state.copyWith(
          foundListModel: foundListModelResponse,
          stateType: DayPassListStateType.success,
        ),
      );
    } catch (e) {
      print(e);
       if (startPosition != '0')
          {
             dismissLoadingDialog(context);
          }
      if (startPosition == '0') {
        emit(
          state.copyWith(
            errorMessage: Constants.errorText,
            stateType: DayPassListStateType.failure,
          ),
        );
         SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
         Utils.dynamicAlert(context, Constants.errorText, Constants.addarticletype,Constants.errorText);
      });
      }
    }
  }

  //pass Found Article detials by Id API call
  Future<DayPassListItemResponse?>getpassArticleById(int articleId,BuildContext context) async {
    try {
      DayPassListItemResponse foundArticleDetailsResponse =
          await passListServices.getpassArticleById(articleId);
      emit(
        state.copyWith(
          foundArticleDetails: foundArticleDetailsResponse,
          stateType:DayPassListStateType.success,
        ),
      );
      return foundArticleDetailsResponse;
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: DayPassListStateType.failure,
        ),
      );
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
         Utils.dynamicAlert(context, Constants.errorText, 'Edit Pass Management',Constants.errorText);
      });
    }
    return null;
  }
}
