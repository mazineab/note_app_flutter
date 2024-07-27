import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:note_app_flutter/core/services/tokenManager.dart';
import 'package:note_app_flutter/core/utils/constant.dart';
class ApiServices{
  TokenManager tokenManager=Get.find<TokenManager>();
  Future<http.Response> httpGet(String endPoint)async{
    final response=await http.get(
        Uri.parse("${Constants.link}/$endPoint"),
        headers: buildHeaders(),
    );
    return response;
  }

  Future<http.Response> httpPost(String endPoint,body) async{
    final response=await http.post(
      Uri.parse("${Constants.link}/$endPoint"),
      headers: buildHeaders(),
      body:jsonEncode(body),
    );
    return response;
  }

  Future<http.Response> httpPut(String endPoint,body)async{
    final response=await http.put(
        Uri.parse("${Constants.link}/$endPoint"),
        headers: buildHeaders(),
        body:jsonEncode(body)
    );
    return response;
  }
  
  Future<http.Response> httpDelete(String endPoint)async{
    final response=await http.delete(
      Uri.parse("${Constants.link}/$endPoint"),
      headers: buildHeaders(),
    );
    return response;
  }



  Map<String,String> buildHeaders(){
    final headers={
      "Content-Type":"application/json"
    };
    if(tokenManager.isValidToken()){
      String token=tokenManager.token!;
      headers['Authorization']="Bearer $token";
    }
    return headers;
  }
}