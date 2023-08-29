import 'dart:convert';
import 'dart:io';

import 'package:db_atom/src/appservices/app_service_handler.dart';
import 'package:db_atom/src/appservices/app_services.dart';
import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoundListServices {
   
  //   Future<dynamic> globalGetServiceCall(String url,BuildContext context,)
  // {
  //   return AppServices().get(url, context);
  // }

  Future<FoundListModel> getFoundArticleList(String startPosition, String maximumRecords,String userId,BuildContext context) async {
    // await Future.delayed(Duration(seconds: 3));

   var value  = await AppServicesHandler().globalGetServiceCall('/getArticleFound?startPos=$startPosition&maxResults=$maximumRecords&userId=$userId',context);

   return  FoundListModel.fromJson(value);
    
  }

  Future<FoundListArticleDetails> getArticleById(int articleId,BuildContext context) async {
    // await Future.delayed(Duration(seconds: 3));

    var value  = await  AppServicesHandler().globalGetServiceCall('/getFoundById/$articleId',context);

   return  FoundListArticleDetails.fromJson(value);
   }
}
