import 'package:get/get.dart';
import 'package:note_app_flutter/data/models/category.dart';
import 'package:note_app_flutter/data/models/note.dart';
import 'package:note_app_flutter/data/repositories/category_repositorie.dart';

import '../../../data/repositories/user_repositorie.dart';

class CategoryController extends GetxController{
  CategoryRespositorie categoryRespositorie  =CategoryRespositorie();
  List<Category> listCategory=<Category>[].obs;

  List<Note> listNotes=<Note>[].obs;



  Future<void> getAllCategory()async{
    final allCategory=await categoryRespositorie.getCategory();
    print(allCategory);
    if(allCategory!=null){
      listCategory.assignAll(allCategory);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategory();
  }

}