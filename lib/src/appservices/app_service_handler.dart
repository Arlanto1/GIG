

import 'package:db_atom/src/appservices/app_services.dart';
import 'package:flutter/material.dart';

class AppServicesHandler {
   
    Future<dynamic> globalGetServiceCall(String url,BuildContext context)
  {
    return AppServices().get(url, context);
  }
    Future<dynamic> globalpopupGetServiceCall(String url,BuildContext context,)
  {
    return AppServices().popupget(url, context);
  }
  Future<dynamic> globalPostServiceCall(String url,BuildContext context,Object? body)
  {
    return AppServices().post(url, context,body);
  }

}