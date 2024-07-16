
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note_app_flutter/core/utils/constant.dart';
import 'package:note_app_flutter/data/models/category.dart';
import 'package:note_app_flutter/data/models/note.dart';
import 'package:note_app_flutter/features/category/controllers/category_controller.dart';
import 'package:note_app_flutter/routes/routes_names.dart';
import '../../user/controllers/user_controller.dart';


class AppHome extends StatelessWidget {
  AppHome({super.key});

  UserController userController = Get.find<UserController>();
  CategoryController categoryController=Get.put(CategoryController());

  String selectedCategory = '';
  TextEditingController contoldialog=TextEditingController();

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
        // init: CategoryController(),
        builder: (controller){
          var categoris=controller.listCategory;
          List<Note> listFilter=controller.listNotes;
          selectedCategory=controller.selectedCategory;

          return SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoris.length,
                      itemBuilder: (context,index){
                        bool isSelected = selectedCategory == categoris[index].nameCat!;
                        return GestureDetector(
                            child: Container(
                              width: 80,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: isSelected?Constants.colorBlue:Constants.colorBlue.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Center(
                                child: Text(categoris[index].nameCat!,
                                    style: const TextStyle(fontWeight:FontWeight.bold,color:Colors.white)
                                    ,textAlign: TextAlign.center),
                              ),
                            ),
                            onTap:(){
                              selectedCategory=categoris[index].nameCat!;
                              controller.clickedCategory(categoris[index].id!);
                            },
                        );
                      }
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView.builder(
                        itemCount: listFilter.length,
                        itemBuilder: (context,index){
                          return customeCardNote(
                              listFilter[index].name!,
                              listFilter[index].content!,
                            listFilter[index].parseTime(),
                              selectedCategory,

                          );
                        }
                    )
                )
              ],
            ),
          );
        },
      ),

      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.add),
          foregroundColor: Colors.white,
          backgroundColor: Constants.colorBlue,
        ),
        closeButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.close),
          foregroundColor: Colors.white,
          backgroundColor: Constants.colorBlue,
        ),

        children: [
          FloatingActionButton.small(
            backgroundColor: Constants.colorBlue,
            foregroundColor: Constants.colorwhite,
            heroTag: null,
            child: const Icon(Icons.note_add_outlined),
            onPressed: () {
              Get.toNamed(RoutesNames.addNotePage);
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Constants.colorBlue,
            foregroundColor: Constants.colorwhite,
            child: const Icon(Icons.add_chart_outlined),
            onPressed: () {
              dialogCat(context,(){
                categoryController.createCategory(contoldialog.text);
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      ),
    );
  }


  Future dialogCat(BuildContext context,onTap) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: contoldialog,
                decoration: InputDecoration(
                  label: Text("name category"),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Constants.colorBlue),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed:onTap,
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }



  Widget customeCardNote(String title,String content,parse,String category){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical:10),
      decoration: BoxDecoration(
          color: Constants.colorGrey,
          borderRadius: BorderRadius.circular(15)
      ),
      child: ListTile(
        leading: const Icon(Icons.edit_note_outlined,color: Constants.colorBlue),
        // title: Text(listFilter[index].name!,
        title: Text(title,
          style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
        subtitle:Container(
          // margin: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(content,
                  style: const TextStyle(fontSize: 18,color:Constants.colorGreyText)),
              const SizedBox(height: 10),
              Container(
                margin:const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Constants.colorBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                            parse,
                            style: const TextStyle(color:Constants.colorBlue)),
                      ),
                    ),
                    const SizedBox(width:10),
                    Container(
                      decoration: BoxDecoration(
                          color: Constants.colorBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(selectedCategory,style: const TextStyle(color:Constants.colorBlue)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
