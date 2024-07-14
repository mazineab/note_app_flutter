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
      var data=jsonDecode(response.body);
      listCategory.assignAll(
        data
      );
    }
    return listCategory;
  }
}