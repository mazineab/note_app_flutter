import 'package:get/get.dart';

class HomeController extends GetxController{


  toRegister(){
    Get.toNamed("/pageHome",arguments: 1);
  }
  toLogin(){
    Get.toNamed("/pageHome",arguments: 2);
  }
}