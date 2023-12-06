import 'dart:developer';

import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/controllers/foundlist_state.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/services/foundlist_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoundListCubit extends Cubit<FoundListState> {
  final FoundListServices foundListServices;

  FoundListCubit({
    required this.foundListServices,
  }) : super(
          FoundListState(
            foundListModel: FoundListModel(),
            stateType: FoundListStateType.initial,
          ),
        );

  // Found Article list API call
  Future<void> getFoundList(String startPosition, String maximumRecords,
      String userId, BuildContext context) async {
    if (startPosition == '0') {
      emit(state.copyWith(stateType: FoundListStateType.loading));
    }
    try {
      FoundListModel foundListModelResponse =
          await foundListServices.getFoundArticleList(
              startPosition: startPosition,
              maximumRecords: maximumRecords,
              userId: userId,
              context: context);

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        // if (startPosition != '0')
        // {
        //    dismissLoadingDialog(context);
        // }
      });
      emit(
        state.copyWith(
          foundListModel: foundListModelResponse,
          stateType: FoundListStateType.success,
        ),
      );
    } catch (e) {
      log('$e');
      if (startPosition == '0') {
        emit(
          state.copyWith(
            errorMessage: Constants.errorText,
            stateType: FoundListStateType.failure,
          ),
        );
      }
    }
  }

  // Found Article detials by Id API call
  Future<FoundListArticleDetails?> getArticleById(
      int articleId, BuildContext context) async {
    try {
      FoundListArticleDetails foundArticleDetailsResponse =
          await foundListServices.getArticleById(articleId, context);
      emit(
        state.copyWith(
          foundArticleDetails: foundArticleDetailsResponse,
          stateType: FoundListStateType.success,
        ),
      );
      return foundArticleDetailsResponse;
    } catch (e) {}
    return null;
  }
}
