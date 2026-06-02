import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/training_module/models/requestModel/training_module_request.dart';

import '../models/requestModel/training_items_model_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost1;

  static final String _getTrainingModuleList = '$baseUrl/getClassRoomTrainingList';
  static  final String _getTrainingModuleById = '$baseUrl/getClassRoomTraining';
  static final String _getTrainingItemsListById = '$baseUrl/getTrainingItemList';

}

class TrainingModuleServices {

  Future<TrainingModuleResponseModel> getClassRoomTrainingList() async {
    final String url = Apis._getTrainingModuleList;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return TrainingModuleResponseModel.fromJson(response);
  }


  Future<TrainingModel> getClassRoomTrainingById(String id) async {
    final String url = "${Apis._getTrainingModuleById}/$id";
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return TrainingModel.fromJson(response);
  }

  Future<TrainingItemsResponseModel> getTrainingItemsById(String id) async {
    final String url = "${Apis._getTrainingItemsListById}/$id";
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return TrainingItemsResponseModel.fromJson(response);
  }


  // Future<List<TrainingItemsModel>> getTrainingItemsById({
  //   required String id,
  // }) async {
  //   String url = '${Apis._getTrainingItemsListById}/$id';
  //   var response = await BaseApiService().getRequest(
  //     isAuthenticated: true,
  //     url: url,
  //   );
  //   return List<TrainingItemsModel>.from(
  //       response.map((x) => TrainingItemsModel.fromJson(x)));
  // }


}
