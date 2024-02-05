import 'dart:developer';

import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/controllers/day_passlist_state.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/day_passlist_model.dart';
import '../services/day_passlist_services.dart';

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
  Future<void> getList(
    String startPosition,
    String maximumRecords,
    String userId,
    String passType,
    BuildContext context,
  ) async {
    // if (startPosition == '0') {
    //   emit(state.copyWith(stateType: DayPassListStateType.loading));
    // }
    try {
      DayPassListResponse foundListModelResponse =
          await passListServices.getList(
        startPosition: startPosition,
        maximumRecords: maximumRecords,
        userId: userId,
        passType: passType,
      );
      log('value-----------------foundListModelResponse---${foundListModelResponse.totalCount}----');
      log('value-----------------foundListModelResponse-length--${foundListModelResponse.items?.length}----');

      //    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //   if (startPosition != '0')
      //   {
      //      dismissLoadingDialog(context);
      //   }
      // });
      emit(
        state.copyWith(
          foundListModel: foundListModelResponse,
          stateType: DayPassListStateType.success,
        ),
      );
    } catch (e) {
      log('$e');
      //  if (startPosition != '0')
      //     {
      //        dismissLoadingDialog(context);
      //     }
      if (startPosition == '0') {
        emit(
          state.copyWith(
            errorMessage: Constants.errorText,
            stateType: DayPassListStateType.failure,
          ),
        );
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Utils.dynamicAlert(context, Constants.errorText,
              Constants.addarticletype, Constants.errorText);
        });
      }
    }
  }

  //pass Found Article detials by Id API call
  Future<DayPassListElement?> getpassArticleById(
      int articleId, BuildContext context) async {
    try {
      DayPassListElement foundArticleDetailsResponse =
          await passListServices.getById(articleId, context);
      emit(
        state.copyWith(
          foundArticleDetails: foundArticleDetailsResponse,
          stateType: DayPassListStateType.success,
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
        Utils.dynamicAlert(context, Constants.errorText, 'Edit Pass Management',
            Constants.errorText);
      });
    }
    return null;
  }
}
