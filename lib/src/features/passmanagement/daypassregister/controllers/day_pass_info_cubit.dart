import 'package:db_atom/main_DEV.dart';
import 'package:db_atom/src/common_widgets/spinnerdialog.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/controllers/day_pass_info_state.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/models/day_pass_info_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassregister/services/day_pass_info_services.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayPassInfoCubit extends Cubit<DayPassInfoState> {
  final DayPassInfoServices passListServices;

  DayPassInfoCubit({
    required this.passListServices,
  }) : super(
          DayPassInfoState(
            foundListModel: DayPassInfoResponse(),
            stateType: DayPassInfoStateType.initial,
          ),
        );

  // Found Article list API call
  Future<void> getPassMngtList(String startPosition, String maximumRecords,
      String userId, String passtype, BuildContext context) async {
    if (startPosition == '0') {
      emit(state.copyWith(stateType: DayPassInfoStateType.loading));
    }
    try {
      DayPassInfoResponse foundListModelResponse =
          await passListServices.getpassinfoFoundArticleList(
              startPosition, maximumRecords, userId, passtype);

      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        if (startPosition != '0') {
          dismissLoadingDialog(context);
        }
      });
      emit(
        state.copyWith(
          foundListModel: foundListModelResponse,
          stateType: DayPassInfoStateType.success,
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
            stateType: DayPassInfoStateType.failure,
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
// Future<DayPassListItemResponse?>getpassArticleById(int articleId,BuildContext context) async {
//   try {
//     DayPassListItemResponse foundArticleDetailsResponse =
//         await passListServices.getpassArticleById(articleId);
//     emit(
//       state.copyWith(
//         foundArticleDetails: foundArticleDetailsResponse,
//         stateType:DayPassListStateType.success,
//       ),
//     );
//     return foundArticleDetailsResponse;
//   } catch (e) {
//     // emit(
//     //   state.copyWith(
//     //     errorMessage: Constants.errorText,
//     //     stateType: FoundListStateType.failure,
//     //   ),
//     // );
//     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//        Utils.dynamicAlert(context, Constants.errorText, Constants.addarticletype,Constants.errorText);
//     });
//   }
//   return null;
// }
}
