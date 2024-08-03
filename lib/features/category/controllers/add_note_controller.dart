
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/data/repositories/note_repositorie.dart';
import 'package:note_app_flutter/features/category/controllers/category_controller.dart';

import '../../../core/utils/messages.dart';

class AddNoteController extends GetxController{

  NoteRespositorie noteRespositorie=Get.find<NoteRespositorie>();
  CategoryController categoryController=Get.find<CategoryController>();

  Future<void> createNote(String title,String content,int category_id)async{
    bool add=await noteRespositorie.createNote(title, content, category_id);
    if(add){
      alertNote(Messages.success,Messages.successAddNote,(){
        categoryController.message.value="";
        Get.back();
        Future.delayed(const Duration(milliseconds: 500),(){
        Get.back();
        });
      });
    }
    else{
      alertNote(Messages.error,Messages.failAddNote,(){Get.back();});
    }
    update();
  }

  void alertNote(String title,content,tap){
    Get.defaultDialog(
        title: title,
        content: Text(content),
        cancel: TextButton(onPressed:tap, child:Text(Messages.ok))
    );
  }
}