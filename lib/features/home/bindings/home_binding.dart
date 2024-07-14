import 'package:get/get.dart';
import 'package:note_app_flutter/features/home/controllers/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}