import 'dart:convert';

import 'package:get/get.dart';
import 'package:note_app_flutter/core/services/api_service.dart';
import 'package:note_app_flutter/core/utils/localStorage/shared_pref_manager.dart';
import 'package:note_app_flutter/data/models/category.dart';

class CategoryRespositorie{
  SharedPrefManager sharedPrefManager=Get.find<SharedPrefManager>();
  // ApiServices apiServices=ApiServices();
  ApiServices apiServices = Get.find<ApiServices>();


  Future<List<Category>> getCategory()async{
    List<Category> listCategory=[];
      final response=await apiServices.httpGet("getCategories");
      if(response.statusCode==200){
        List<dynamic> data=jsonDecode(response.body);
        sharedPrefManager.saveString("dataCategory",jsonEncode(data));
        listCategory.addAll(
            data.map((e) => Category.fromJson(e)).toList()
        );
      }
    return listCategory;
  }

  Future<List<Category>> cashCategoryList()async{
    List<Category> listCash=[];
    String? cashData=sharedPrefManager.getString("dataCategory")??"";
    if(cashData.isNotEmpty){
      List<dynamic> cashCategory=jsonDecode(cashData);
      listCash.addAll(cashCategory.map((e) => Category.fromJson(e)).toList());
      return listCash;
    }
    else{
      return await getCategory().timeout(Duration(seconds: 3));
    }
  }
  
  Future<bool> addCategory(String categoryName) async {
    var response=await apiServices.httpPost("createCategory", {
      "nameCat":categoryName
    });
    if(response.statusCode==200){
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> deleteCategory(int id)async{
    var response=await apiServices.httpDelete("category/$id");
    print(response.statusCode);
    if(response.statusCode==200){
      return true;
    }
    else {
      return false;
    }
  }

}