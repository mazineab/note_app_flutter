import 'dart:convert';

import 'package:get/get.dart';
import 'package:note_app_flutter/core/services/api_service.dart';
import 'package:note_app_flutter/data/models/category.dart';

class CategoryRespositorie{
  ApiServices apiServices=ApiServices();
  Future<List<Category>> getCategory()async{
    final response=await apiServices.httpGet("getCategories");
    List<Category> listCategory=[];
    if(response.statusCode==200){
      List<dynamic> data=jsonDecode(response.body);
      print(data);
      listCategory.addAll(
        data.map((e) => Category.fromJson(e)).toList()
      );
    }
    return listCategory;
  }
}