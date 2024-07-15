import 'dart:convert';

import 'package:get/get.dart';
import 'package:note_app_flutter/core/services/api_service.dart';
import 'package:note_app_flutter/core/utils/localStorage/shared_pref_manager.dart';
import 'package:note_app_flutter/data/models/category.dart';

class CategoryRespositorie{
  SharedPrefManager sharedPrefManager=Get.find<SharedPrefManager>();
  ApiServices apiServices=ApiServices();


  Future<List<Category>> getCategory()async{
    List<Category> listCategory=[];
    List<Category> listCash=[];
    String? cashData=sharedPrefManager.getString("dataCategory")??"";
    if(cashData.isNotEmpty){
      List<dynamic> cashCategory=jsonDecode(cashData);
      listCash.addAll(cashCategory.map((e) => Category.fromJson(e)).toList());
      return listCash;
    }
    else{
      final response=await apiServices.httpGet("getCategories");
      if(response.statusCode==200){
        List<dynamic> data=jsonDecode(response.body);
        if(data.isNotEmpty){
          sharedPrefManager.saveString("dataCategory",jsonEncode(data));
        }
        listCategory.addAll(
            data.map((e) => Category.fromJson(e)).toList()
        );
      }
    }
    return listCategory;
  }
}