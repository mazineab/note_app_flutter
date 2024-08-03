import 'package:get/get.dart';
import 'package:note_app_flutter/routes/routes_names.dart';

class HomeController extends GetxController{

  toRegister(){
    Get.toNamed(RoutesNames.pageHome,arguments:{"index":1,"first":true});
  }
  toLogin(){
    Get.toNamed(RoutesNames.pageHome,arguments: {"index":1,"first":true});
  }
}