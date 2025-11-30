
import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/models/ai_chat_model.dart';
import 'package:db_atom/src/features/arlanto_ai_chat_assistance/models/requestModel/ai_chat_request.dart';
import 'package:db_atom/src/features/article_found/models/requestModels/article_found_request.dart';

class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getList = '$baseUrl/aai/api/aaiRestService/getPrompt';
  static final String _getById = '$baseUrl/aai/api/aaiRestService/getPromptById?';
  static final String _create = '$baseUrl/aai/api/aaiRestService/sendPrompt';
}

class AiChatService {
  final endpoint = Environment().config.apiHost;

  //
  // Future<ArticleFoundResponseModel> getListWithFilters({
  //   required String startPosition,
  //   required String maximumRecords,
  //   required BaseFilterModel filters,
  // }) async {
  //   String url =
  //       '${Apis._getList}?startPos=$startPosition&maxResults=$maximumRecords';
  //   var response = await BaseApiService().postRequest(
  //     requestedData: filters.toJson(),
  //     isAuthenticated: true,
  //     url: url,
  //   );
  //   return ArticleFoundResponseModel.fromJson(response);
  // }
  Future<AIResponseModel> getList() async {
    final url = "https://api.uat.dbatom.com/aai/api/aaiRestService/getPrompt";

    final response = await BaseApiService().getRequest(
      url: url,
      isAuthenticated: true,
    );

    return AIResponseModel.fromJson(response);
  }


  Future<AiChatModel> getById(int id) async {
    final String url = 'https://api.uat.dbatom.com/aai/api/aaiRestService/getPromptById?id=82$id';
    final response = await BaseApiService().getRequest(
      url: url,
      isAuthenticated: true,
    );
    return AiChatModel.fromJson(response);
  }

  Future<AiChatResponseAnswerModel> createAiChat({
    required AiChatRequestModel body,
  }) async {
    final String url = "https://api.uat.dbatom.com/aai/api/aaiRestService/sendPrompt";

    final response = await BaseApiService().postRequest(
      url: url,
      requestedData: body.toJson(),
    );

    return AiChatResponseAnswerModel.fromJson(response);
  }
}