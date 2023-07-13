import 'dart:convert';
import 'dart:io';

import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/configurations/prod_config.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:http/http.dart' as http;

class FoundListServices {
  Future<FoundListModel> getFoundArticleList(String startPosition, String maximumRecords,String userId) async {
    await Future.delayed(Duration(seconds: 3));

    //final endpoint = ProdConfig().apiHost;
     final endpoint = Environment().config.apiHost;
    final url =
        Uri.parse('$endpoint/getArticleFound?startPos=$startPosition&maxResults=$maximumRecords&userId=$userId');
        print(url);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        try {
        return FoundListModel.fromJson(json.decode(response.body));
        }
        catch(e)
        {
          print(e);
          return FoundListModel();
        }
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }

  Future<FoundListArticleDetails> getArticleById(int articleId) async {
    await Future.delayed(Duration(seconds: 3));

    final endpoint = ProdConfig().apiHost;
    final url = Uri.parse('$endpoint/getFoundById/$articleId');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return FoundListArticleDetails.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }
}
