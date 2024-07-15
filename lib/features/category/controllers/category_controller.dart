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
    final allCategory=await categoryRespositorie.getCategory();
    print(allCategory);
    if(allCategory!=null){
      listCategory.assignAll(allCategory);
    }
  }

  Future<void> getAllNotes(int id)async{
    final allNotes=await noteRespositorie.getNotesOf(id);
    if(allNotes!=null){
      listNotes.assignAll(allNotes);
    }
    update();
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


// Note(name: "Lyom",nameCategory: "Home",content: "Lyom ghnsaliw nch2lah"),
// Note(name: "ghda",nameCategory: "Home",content: "nfi9o m3a 8:00 nreglo mytkal"),
// Note(name: "project Note",nameCategory: "Work",content: "had note app mzl fuha errors"),
// Note(name: "writing",nameCategory: "English",content: "khsni nbda nregl writing bch ndevlope my english"),
// Note(name: "gpt",nameCategory: "ChatGpt",content: "khsna gpt 4+"),
// Note(name: "fb",nameCategory: "Passwords",content: "Mazine@123"),