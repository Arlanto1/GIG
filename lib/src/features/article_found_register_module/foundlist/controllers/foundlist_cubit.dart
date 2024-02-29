import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/services/foundlist_services.dart';

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
          );

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        // if (startPosition != '0')
        // {
        //    dismissLoadingDialog(context);
        // }
      });

      if (foundListModelResponse.items.isEmptyOrNull) {
        if (int.tryParse(startPosition)! > 0) {
          return;
        }
      }

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

  Future<void>refreshList(String startPosition, String maximumRecords,
      ) async {
    try {
      FoundListModel foundListModelResponse =
      await foundListServices.getFoundArticleList(
          startPosition: startPosition,
          maximumRecords: maximumRecords,
          );

      return emit(
        state.copyWith(
          foundListModel: foundListModelResponse,
          stateType: FoundListStateType.success,
        ),
      );
    } on Exception {
      return emit(state.copyWith(stateType: FoundListStateType.failure));
    }
  }
}
