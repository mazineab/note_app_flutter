import 'dart:convert';

import 'package:get/get.dart';
import 'package:note_app_flutter/core/services/api_service.dart';
import 'package:note_app_flutter/core/services/tokenManager.dart';
import 'package:note_app_flutter/core/utils/localStorage/shared_pref_manager.dart';
import 'package:note_app_flutter/data/models/user.dart';

class UserRepositorie{
  final apiService=ApiServices();
  TokenManager tokenManager = Get.find();


  Future<bool> login(String email,String password)async{
    final response=await apiService.httpPost("loginUser",
        {
          "email":email,
          "password":password
      }
    );
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      await tokenManager.saveToken(data["token"]);
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> register(User user)async{
    final response=await apiService.httpPost("createUser",
      {
        'name':user.name,
        'email':user.email,
        'phoneNumber':user.phoneNumber,
        'password':user.password
      }
    );
    print(user.toJson());
    print(response.statusCode);
    if(response.statusCode==201){
      return true;
    }
    else{
      return false;
    }
  }
}