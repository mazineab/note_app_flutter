
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/data/repositories/note_repositorie.dart';

class AddNoteController extends GetxController{

  NoteRespositorie noteRespositorie=Get.put(NoteRespositorie());

  Future<void> createNote(String title,String content,int category_id)async{
    bool add=await noteRespositorie.createNote(title, content, category_id);
    if(add){
      alertNote("info","Succsefly add note",(){Get.back();});
    }
    else{
      alertNote("error","error add note",(){Get.back();});
    }

  }

  void alertNote(String title,content,tap){
    Get.defaultDialog(
        title: title,
        content: Text(content),
        cancel: TextButton(onPressed: (){tap;}, child:Text("Ok"))
    );
  }
}