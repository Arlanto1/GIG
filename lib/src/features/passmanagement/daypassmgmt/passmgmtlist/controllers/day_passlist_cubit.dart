import 'dart:developer';

import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/passmgmtlist/controllers/day_passlist_state.dart';
import 'package:db_atom/src/models/base_filter_model.dart';
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
            stateType: FormStatus.initial,
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
    if (startPosition == '0') {
      emit(state.copyWith(stateType: FormStatus.loading));
    }
    try {
      DayPassListResponse foundListModelResponse =
          await passListServices.getListWithFilters(
        startPosition: startPosition,
        maximumRecords: maximumRecords,
        passType: passType,
        filters: BaseFilterModel(),
      );
      //    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //   if (startPosition != '0')
      //   {
      //      dismissLoadingDialog(context);
      //   }
      // });
      emit(
        state.copyWith(
          foundListModel: foundListModelResponse,
          stateType: FormStatus.success,
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

  //pass Found Article detials by Id API call
  Future<PassManagementModel?> getpassArticleById(
      int articleId, BuildContext context) async {
    try {
      PassManagementModel foundArticleDetailsResponse =
          await passListServices.getById(articleId, context);
      emit(
        state.copyWith(
          foundArticleDetails: foundArticleDetailsResponse,
          stateType: FormStatus.success,
        ),
      );
      return foundArticleDetailsResponse;
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: Constants.errorText,
          stateType: FormStatus.failure,
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
