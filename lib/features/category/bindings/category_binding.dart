import 'package:get/get.dart';
import 'package:note_app_flutter/data/repositories/category_repositorie.dart';
import 'package:note_app_flutter/data/repositories/note_repositorie.dart';

class CategoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CategoryRespositorie());
    Get.put(NoteRespositorie());
  }

}