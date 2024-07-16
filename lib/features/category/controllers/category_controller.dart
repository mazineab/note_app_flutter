import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/data/models/category.dart';
import 'package:note_app_flutter/data/models/note.dart';
import 'package:note_app_flutter/data/repositories/category_repositorie.dart';
import 'package:note_app_flutter/data/repositories/note_repositorie.dart';

class CategoryController extends GetxController{
  CategoryRespositorie categoryRespositorie  =CategoryRespositorie();
  NoteRespositorie noteRespositorie=NoteRespositorie();
  List<Category> listCategory=<Category>[].obs;

  List<Note> listNotes=<Note>[].obs;



  Future<void> getAllCategory()async{
    final allCategory=await categoryRespositorie.cashCategoryList();
    print(allCategory);
    if(allCategory!=null){
      listCategory.assignAll(allCategory);
    }
  }

  Future<void> getCategoryOnline() async {
    final allCategory=await categoryRespositorie.getCategory();
    print(allCategory);
    if(allCategory!=null){
      listCategory.assignAll(allCategory);
    }
    update();
  }

  Future<void> createCategory(String nameCategory)async{
    final bool add=await categoryRespositorie.addCategory(nameCategory);
    if(add){
      getCategoryOnline();
      alertCategory("info","Successfly add category",(){Get.back();});
    }
    else{
      alertCategory("error","error in adding category",(){Get.back();});
    }
  }



  Future<void> getAllNotes(int id)async{
    final allNotes=await noteRespositorie.cashNoteList(id);
    if(allNotes!=null){
      listNotes.assignAll(allNotes);
    }
    update();
  }

  Future<void> removeCategory(int id)async{
    final bool removeCat=await categoryRespositorie.deleteCategory(id);
    if(removeCat){
      alertCategory("info","Succesfly delete category",(){Get.back();});
      getCategoryOnline();
    }
    else{
      alertCategory("error","error delete category",(){Get.back();});
    }
  }


  Future<void> getNoteOnline(int id)async{
    final allNotes=await noteRespositorie.getNotesOf(id);
    if(allNotes.isNotEmpty){
      listNotes.assignAll(allNotes);
    }
    update();
  }

  Future<void> deleteNote(int id,int category_id)async{
    final delete=await noteRespositorie.deleteNote(id);
    if(delete){
      alertCategory("info","Succesfly delete note",(){Get.back();});
      getNoteOnline(category_id);
    }
    else{
      alertCategory("error","error delete note",(){Get.back();});
    }
  }

  void clickedCategory(int id){
    listNotes.clear();
    getAllNotes(id);
    update();
  }

  @override
  void onInit() async{
    super.onInit();
    await getAllCategory();
    if(listCategory.isNotEmpty){
      clickedCategory(listCategory[0].id!);
    }
  }
}

void alertCategory(String title,content,tap){
  Get.defaultDialog(
    title: title,
    content: Text(content),
    cancel: TextButton(onPressed:tap, child:Text("Ok"))
  );
}
