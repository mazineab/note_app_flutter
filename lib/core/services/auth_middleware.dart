import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/core/services/tokenManager.dart';
import 'package:note_app_flutter/routes/routes_names.dart';

class AuthMiddleware extends GetMiddleware{

  TokenManager tokenManager=Get.find<TokenManager>();

  @override
  RouteSettings? redirect(String? route) {
    final bool exist=tokenManager.isValidToken();
    if(exist){
      return RouteSettings(name:RoutesNames.appHome);
    }
    return null;
  }
}