import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/core/services/tokenManager.dart';

class AuthMiddleware extends GetMiddleware{

  TokenManager tokenManager=Get.find<TokenManager>();

  @override
  RouteSettings? redirect(String? route) {
    final bool exist=tokenManager.isValidToken();
    if(exist){
      return RouteSettings(name:"/noteHome");
    }
    return null;
  }
}