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

  Future<void> getNoteOnline(int id)async{
    final allNotes=await noteRespositorie.getNotesOf(id);
    if(allNotes.isNotEmpty){
      listNotes.assignAll(allNotes);
    }
    update();
  }

  String selectedCategory="";

  void clickedCategory(int id){
    listNotes.clear();
    getAllNotes(id);
    update();
  }

  @override
  void onInit() async{
    super.onInit();
    await getAllCategory();
    selectedCategory=listCategory[0].nameCat!;
    if(listCategory.isNotEmpty){
      clickedCategory(listCategory[0].id!);
    }
  }
}

void alertCategory(String title,content,tap){
  Get.defaultDialog(
    title: title,
    content: Text(content),
    cancel: TextButton(onPressed: (){tap;}, child:Text("Ok"))
  );
}


// Note(name: "Lyom",nameCategory: "Home",content: "Lyom ghnsaliw nch2lah"),
// Note(name: "ghda",nameCategory: "Home",content: "nfi9o m3a 8:00 nreglo mytkal"),
// Note(name: "project Note",nameCategory: "Work",content: "had note app mzl fuha errors"),
// Note(name: "writing",nameCategory: "English",content: "khsni nbda nregl writing bch ndevlope my english"),
// Note(name: "gpt",nameCategory: "ChatGpt",content: "khsna gpt 4+"),
// Note(name: "fb",nameCategory: "Passwords",content: "Mazine@123"),