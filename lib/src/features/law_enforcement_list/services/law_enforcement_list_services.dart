import 'dart:convert';
import 'dart:io';

import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/configurations/prod_config.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_list_response.dart';
import 'package:http/http.dart' as http;

class LawEnforcementListServices {
  Future<LawEnforcementListResponse> getLawEnforcementList(String startPosition, String maximumRecords,String userId) async {
    await Future.delayed(const Duration(seconds: 1));

    //final endpoint = ProdConfig().apiHost;
     final endpoint = Environment().config.apiHost;
    final url =
        Uri.parse('$endpoint/getLawEnfrcmntList?startPos=$startPosition&maxResults=$maximumRecords&userId=$userId');
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
        return LawEnforcementListResponse.fromJson(json.decode(response.body));
        }
        catch(e)
        {
          print('error response ${e}');
          return LawEnforcementListResponse();
        }
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
    
  }

  Future<LawEnforcementDetails> getLawEnforcementById(int lawEnforcementId) async {
    await Future.delayed(const Duration(seconds: 2));

    final endpoint = Environment().config.apiHost;
    final url = Uri.parse('$endpoint/getLawEnfrcmnt/$lawEnforcementId');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return LawEnforcementDetails.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } on SocketException {
      throw json.decode('{"errorMessage":"Network Lost"}');
    }
  }
}
