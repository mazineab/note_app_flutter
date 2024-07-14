import 'package:get/get.dart';
import 'package:note_app_flutter/routes/routes_names.dart';

class HomeController extends GetxController{


  toRegister(){
    Get.toNamed(RoutesNames.pageHome,arguments: 1);
  }
  toLogin(){
    Get.toNamed(RoutesNames.pageHome,arguments: 2);
  }
}