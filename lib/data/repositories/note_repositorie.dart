import 'dart:convert';

import 'package:get/get.dart';
import 'package:note_app_flutter/core/services/api_service.dart';
import 'package:note_app_flutter/core/utils/localStorage/shared_pref_manager.dart';
import 'package:note_app_flutter/data/models/note.dart';

class NoteRespositorie extends GetxController {
  SharedPrefManager sharedPrefManager = Get.find<SharedPrefManager>();
  ApiServices apiServices = ApiServices();

  Future<List<Note>> getNotesOf(int id) async {
    List<Note> listNotes = [];
    final response = await apiServices.httpGet("getNotes?category_id=$id");
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        sharedPrefManager.saveString("Note$id", jsonEncode(data));
      }
      print(data);
      listNotes.addAll(data.map((e) => Note.fromJson(e)).toList());
    }
    return listNotes;
  }

  Future<List<Note>> cashNoteList(int id) async {
    List<Note> listCashe = [];
    String? cashData = sharedPrefManager.getString("Note$id") ?? "";
    if (cashData.isNotEmpty) {
      List<dynamic> cashNote = jsonDecode(cashData);
      listCashe.addAll(cashNote.map((e) => Note.fromJson(e)).toList());
      return listCashe;
    } else {
      return await getNotesOf(id);
    }
  }

  Future<bool> createNote(String title, String content, int category_id) async {
    var response = await apiServices.httpPost("createNote",
        {"category_id": category_id, "name": title, "content": content});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteNote(int id)async{
    var response=await apiServices.httpDelete("note/$id");
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }
  
  Future<bool> editNote(Map<String,dynamic> body)async{
    var response=await apiServices.httpPut("editNote",body);
    if(response.statusCode==200){
      return true;
    }
    else{
      return false;
    }
  }
}
