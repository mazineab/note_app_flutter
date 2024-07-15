import 'dart:convert';

import 'package:get/get.dart';
import 'package:note_app_flutter/core/services/api_service.dart';
import 'package:note_app_flutter/core/utils/localStorage/shared_pref_manager.dart';
import 'package:note_app_flutter/data/models/note.dart';

class NoteRespositorie extends GetxController{
  SharedPrefManager sharedPrefManager=Get.find<SharedPrefManager>();
  ApiServices apiServices=ApiServices();

  Future<List<Note>> getNotesOf(int id)async{
    List<Note> listNotes=[];
    List<Note> listCashe=[];

    String? cashData=sharedPrefManager.getString("Note$id")??"";
    if(cashData.isNotEmpty){
      List<dynamic> cashNote=jsonDecode(cashData);
      listCashe.addAll(cashNote.map((e) => Note.fromJson(e)).toList());
      return listCashe;
    }
    else {
      final response=await apiServices.httpGet("getNotes?category_id=$id");
      if(response.statusCode==200){
        List<dynamic> data=jsonDecode(response.body);
        if(data.isNotEmpty){
          sharedPrefManager.saveString("Note$id", jsonEncode(data));
        }
        print(data);
        listNotes.addAll(
            data.map((e) => Note.fromJson(e)).toList()
        );
      }
    }
      return listNotes;
  }
}