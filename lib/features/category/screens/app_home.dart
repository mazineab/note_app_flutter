
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note_app_flutter/core/utils/constant.dart';
import 'package:note_app_flutter/data/models/category.dart';
import 'package:note_app_flutter/data/models/note.dart';
import 'package:note_app_flutter/features/category/controllers/category_controller.dart';
import '../../user/controllers/user_controller.dart';


class AppHome extends StatelessWidget {
  AppHome({super.key});

  UserController userController = Get.find<UserController>();

  var categoris=[
    Category(nameCategory: "Home"),
    Category(nameCategory:"Work"),
    Category(nameCategory: "ChatGpt"),
    Category(nameCategory: "English"),
    Category(nameCategory: "daily"),
    Category(nameCategory: "Passwords"),
    Category(nameCategory: "links"),
  ];

  var listNotes=[
    Note(name: "Lyom",nameCategory: "Home",content: "Lyom ghnsaliw nch2lah"),
    Note(name: "ghda",nameCategory: "Home",content: "nfi9o m3a 8:00 nreglo mytkal"),
    Note(name: "project Note",nameCategory: "Work",content: "had note app mzl fuha errors"),
    Note(name: "writing",nameCategory: "English",content: "khsni nbda nregl writing bch ndevlope my english"),
    Note(name: "gpt",nameCategory: "ChatGpt",content: "khsna gpt 4+"),
    Note(name: "fb",nameCategory: "Passwords",content: "Mazine@123"),
  ];

  String selectedCategory = 'Home';

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.colorGrey,
        title: const Text("Memo", style: TextStyle(color:Constants.colorBlue,fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                userController.logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: GetBuilder<CategoryController>(
        init: CategoryController(),
        builder: (controller){
          List<Note> listFilter=listNotes.where((element) => element.nameCategory==selectedCategory).toList();
          return Container(
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 30),
                Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoris.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                            child: Container(
                              width: 80,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Constants.colorBlue.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Center(
                                child: Text(categoris[index].nameCategory!,
                                    style: const TextStyle(fontWeight:FontWeight.bold,color:Colors.white)
                                    ,textAlign: TextAlign.center),
                              ),
                            ),
                            onTap:(){
                              print("OKK");
                              selectedCategory=categoris[index].nameCategory!;
                              controller.update();
                            }
                        );
                      }
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView.builder(
                        itemCount: listFilter.length,
                        itemBuilder: (context,index){
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20,vertical:10),
                            decoration: BoxDecoration(
                              color: Constants.colorGrey,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: ListTile(
                              leading: Icon(Icons.edit_note_outlined,color: Constants.colorBlue,),
                              title: Text(listFilter[index].name!,
                                style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                              subtitle:Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text(listFilter[index].content!,style: TextStyle(fontSize: 18,color:Constants.colorGreyText)),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: const Text("2024/12/03",style: TextStyle(color:Constants.colorGreyText)),
                                            ),
                                          decoration: BoxDecoration(
                                            color: Constants.colorBlue.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                        ),
                                        const SizedBox(width:10),
                                        Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(listFilter[index].nameCategory!,style: const TextStyle(color:Constants.colorGreyText)),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Constants.colorBlue.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    )
                )
              ],
            ),
          );
        },

      ),
    );;
  }
}
