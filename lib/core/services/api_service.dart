import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:note_app_flutter/core/utils/constant.dart';
class ApiServices{
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



  Map<String,String> buildHeaders(){
    final headers={
      "Content-Type":"application/json"
    };
    return headers;
  }
}