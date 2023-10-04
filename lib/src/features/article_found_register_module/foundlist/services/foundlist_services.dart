import 'package:db_atom/src/appservices/app_service_handler.dart';
import 'package:db_atom/src/configurations/base_api_service.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:flutter/material.dart';

import '../../../../configurations/environment_config.dart';


class Apis {
  static final String baseUrl = Environment().config.apiHost;

  static final String _getArticle = '$baseUrl/getFoundById';

}

class FoundListServices {
  //   Future<dynamic> globalGetServiceCall(String url,BuildContext context,)
  // {
  //   return AppServices().get(url, context);
  // }

  Future<FoundListModel> getFoundArticleList(String startPosition,
      String maximumRecords, String userId, BuildContext context) async {
    // await Future.delayed(Duration(seconds: 3));

    var value = await AppServicesHandler().globalGetServiceCall(
        '/getArticleFound?startPos=$startPosition&maxResults=$maximumRecords&userId=$userId',
        context);

    return FoundListModel.fromJson(value);
  }

  Future<FoundListArticleDetails> getArticleById(
      int articleId, BuildContext context) async {
    // await Future.delayed(Duration(seconds: 3));
    final String url = '${Apis._getArticle}/$articleId';
    final response = await BaseApiService().getRequest(
      url: url,
      isAuthenticated: false
    );
    // var value = await BaseApiService()
    //     .getRequest(url: '/getFoundById/$articleId');

    return FoundListArticleDetails.fromJson(response);
  }
}
