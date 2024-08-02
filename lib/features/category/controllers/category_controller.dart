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
  var listCategory=<Category>[].obs;
  var listNotes=<Note>[].obs;

  var isloading = true.obs;
  var message="".obs;
  var selectedCategory = "".obs;


  Future<void> getAllCategory()async{
    final allCategory=await categoryRespositorie.cashCategoryList();
    if(allCategory.isNotEmpty){
      listCategory.assignAll(allCategory);
    }
    else{
      messageEmptyCategory.value="Start to create category and note by click in button +";
    }
    update();
  }

  Future<void> getCategoryOnline() async {
    final allCategory=await categoryRespositorie.getCategory();
    if(allCategory.isNotEmpty){
      listCategory.assignAll(allCategory);
    }
    else{
      messageEmptyCategory.value="Start to create category and note by click in button +";
    }
    print(listCategory);
    update();
  }

  getOnline(){
    return listCategory;
  }

  Future<void> createCategory(String nameCategory)async{
    final bool add=await categoryRespositorie.addCategory(nameCategory);
    if(add){
      // await getCategoryOnline();
      alertCategory("info","Successfly add category",() async {
        Get.back();
        messageEmptyCategory.value="";
        clickedCategory(listCategory.first.id!);
        update();
      });
    }
    else{
      alertCategory("error","error in adding category",(){Get.back();});
    }
    update();
  }


  Future<void> getAll(int id)async{
    await getCategoryOnline();
    await getNoteOnline(id);
  }


  Future<void> getAllNotes(int id)async{
      isloading.value = true;
      try {
        List<Note> allNotes = await noteRespositorie.cashNoteList(id);
        if (allNotes.isNotEmpty) {
          listNotes.assignAll(allNotes);
          message.value = "";
        } else {
          message.value = "This category is empty. Create one note.";
        }
      } catch (e) {
        message.value = "An error occurred while fetching notes.";
      } finally {
        isloading.value = false;
        update();
      }
  }

  Future<void> removeCategory(int id)async{
    final bool removeCat=await categoryRespositorie.deleteCategory(id);
    if(removeCat){
      alertCategory("info","Succesfly delete category",(){Get.back();});
      await getAll(id);
      if(listCategory.isEmpty){
        messageEmptyCategory.value="Start to create category and note by click in button +";
      }
      else{
        clickedCategory(listCategory.first.id!);
        selectedCategory.value=listCategory.first.nameCat!;
      }
    }
    else{
      alertCategory("error","error delete category",(){Get.back();});
    }
  }


  Future<void> getNoteOnline(int id)async{
    try{
      final allNotes=await noteRespositorie.getNotesOf(id);
      if(allNotes.isNotEmpty){
        listNotes.assignAll(allNotes);
      }
      else{
        message.value="this category is empty create one note";
      }
    }catch(e){
      message.value="Error ocurent charging notes of this category";
    }
    isloading.value=false;
    update();
  }

  Future<void> deleteNote(int id,int category_id)async{
    final delete=await noteRespositorie.deleteNote(id);
    if(delete){
      alertCategory("info","Succesfly delete note",(){Get.back();});
      getNoteOnline(category_id);
      if(listCategory.isEmpty){
        messageEmptyCategory.value="Start to create category and note by click in button +";
      }
    }
    else{
      alertCategory("error","error delete note",(){Get.back();});
    }
    update();
  }

  var edTitle=TextEditingController().obs;
  var edContent=TextEditingController().obs;
  Future<void> editNote(int id,String name,String content,int category_id)async{
    final edit=await noteRespositorie.editNote(
        {
          "id":id,
          "name":name,
          "content":content,
        }
    );
    if(edit){
      alertCategory("info","Succesfly editing note",(){Get.back();});
      await getNoteOnline(category_id);
    }
    else{
      alertCategory("error","error editing note",(){Get.back();});
    }
  }



  var messageEmptyCategory="".obs;
  void clickedCategory(int id){
    listNotes.clear();
    if(listCategory.isNotEmpty){
      getAllNotes(id);
    }
    update();
  }

  void gitAfterAdd(int id){
    listNotes.clear();
    getNoteOnline(id);
    update();
  }

  @override
  void onInit() async{
    super.onInit();
    await getAllCategory();
    if(listCategory.isNotEmpty){
      clickedCategory(listCategory[0].id!);
    }
    else{
      messageEmptyCategory.value="Start to create category and note by click in button +";
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
