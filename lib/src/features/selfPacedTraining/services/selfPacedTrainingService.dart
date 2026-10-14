
import 'package:db_atom/index.dart';

import '../models/selfPacedTrainingModel.dart';
class Apis {
  static final String baseUrl = Environment().config.apiHost1;

  static final String _getSelfPacedTrainingModuleList = '$baseUrl/getSelfPacedTrainingList';
  static  final String _getSelfPacedTrainingModuleById = '$baseUrl/getSelfPacedTrainingById';
  static final String _getTrainingItemsListById = '$baseUrl/getTrainingItemList';

}

class SelfPacedTrainingService{

  // Future<SelfPacedTrainingModuleResponseModel> getSelfPacedTrainingList(
  // {required String startPosition,
  //     required String maximumRecords}
  //     ) async {
  //   final String url = '${Apis._getSelfPacedTrainingModuleList}&startPos=$startPosition&maxResults=$maximumRecords';;
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //   return SelfPacedTrainingModuleResponseModel.fromJson(response);
  // }
  Future<SelfPacedTrainingModuleResponseModel> getSelfPacedTrainingList() async {
    final String url = Apis._getSelfPacedTrainingModuleList;
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return SelfPacedTrainingModuleResponseModel.fromJson(response);
  }

  Future<SelfPacedTrainingModel> getSelfPacedTrainingById(String id) async {
    final String url = "${Apis._getSelfPacedTrainingModuleById}/$id";
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return SelfPacedTrainingModel.fromJson(response);
  }
  //
  // Future<TrainingItemsResponseModel> getTrainingItemsById(String id) async {
  //   final String url = "${Apis._getTrainingItemsListById}/$id";
  //   final response = await BaseApiService().getRequest(
  //     url: url,
  //   );
  //   return TrainingItemsResponseModel.fromJson(response);
  // }

}
