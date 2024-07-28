import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/data/models/user.dart';
import 'package:note_app_flutter/data/repositories/user_repositorie.dart';
import 'package:note_app_flutter/routes/routes_names.dart';

import '../../../core/utils/localStorage/shared_pref_manager.dart';

class UserController extends GetxController {
  UserRepositorie userRepositorie = UserRepositorie();

  Future<void> login(String email, String password) async {
    final bool exist = await userRepositorie.login(email, password);
    if (exist) {
      Get.offAllNamed(RoutesNames.appHome);
    } else {
      dialog("Error","email or password incorrect",(){
        Get.back();
      });
    }
  }

  Future<void> register(User user)async{
    final bool create=await userRepositorie.register(user);
    if(create) {
      dialog("Succes","account create succesfly",(){
        Get.toNamed("/pageHome",arguments: 1);
        Get.back();
      });
    } else {
      dialog("Error","account not create",(){
        Get.back();
      });
    }
  }

  Future<void> logout()async{
    try{
      final bool log=await userRepositorie.logout();
      if(log){
        userRepositorie.tokenManager.clearToken();
        bool clear = await Get.find<SharedPrefManager>().clear();
        print(clear);
        update();
        Get.offAllNamed(RoutesNames.pageHome,arguments: const {"index":1,"first":true});
      }
    }catch(e){
      throw "Error $e";
    }
  }

  dialog(String title,String msg,ontap){
    Get.defaultDialog(
        title: title,
        content: Text(msg),
        cancel: TextButton(
            onPressed:ontap,
            child: const Text("Ok"))
    );
  }
}
