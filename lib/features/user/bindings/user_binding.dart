import 'package:get/get.dart';
import 'package:note_app_flutter/data/repositories/user_repositorie.dart';
import 'package:note_app_flutter/features/user/controllers/text_field_controller.dart';
import 'package:note_app_flutter/features/user/controllers/user_controller.dart';

class UserBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(UserRepositorie());
    Get.put(TextFieldController());
    Get.put(UserController());
  }

}