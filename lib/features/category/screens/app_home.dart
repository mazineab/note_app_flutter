import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/core/utils/constant.dart';
import 'package:note_app_flutter/core/utils/messages.dart';
import 'package:note_app_flutter/data/models/note.dart';
import 'package:note_app_flutter/features/category/controllers/category_controller.dart';
import 'package:note_app_flutter/global/widgets/custom_app_bar.dart';
import 'package:note_app_flutter/routes/routes_names.dart';
import '../../../data/models/category.dart';
import '../../user/controllers/user_controller.dart';

class AppHome extends StatelessWidget {
  AppHome({super.key});

  UserController userController = Get.find<UserController>();
  CategoryController categoryController = Get.put(CategoryController());


  TextEditingController contoldialog = TextEditingController();

  Future<void> refresh()async{
    int id=categoryController.listCategory.firstWhere((element) => element.nameCat==categoryController.selectedCategory.value).id!;
    await categoryController.getAll(id);
    return Future.delayed(Duration(seconds:1));
  }
  List<Category> categories=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: GetBuilder<CategoryController>(
        builder: (controller) {
          categories.assignAll(controller.listCategory);
          List<Note> listFilter = controller.listNotes;
          if(controller.messageEmptyCategory.value.isNotEmpty){
            return Center(child: Text(controller.messageEmptyCategory.value));
          }
          else{
            return SizedBox(
              width: double.infinity,
              child: RefreshIndicator(
                onRefresh:refresh,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          if (controller.selectedCategory.value.isEmpty && categories.isNotEmpty) {
                            controller.selectedCategory.value = categories[0].nameCat!;
                          }
                          bool isSelected = controller.selectedCategory.value == categories[index].nameCat!;
                          return GestureDetector(
                            child: Container(
                              width: 80,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: isSelected
                                      ? Constants.colorBlue
                                      : Constants.colorBlue.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(categories[index].nameCat!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            onTap: () {
                              controller.selectedCategory.value = categories[index].nameCat!;
                              controller.clickedCategory(categories[index].id!);
                            },
                            onLongPress: () {
                              dialogAsk(context,
                                  Messages.wntDltCat, () {
                                    categoryController.removeCategory(categories[index].id!);
                                    Get.back();
                                  });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx((){
                      if(controller.isloading.value) {
                        return const Expanded(child: Center(child: CircularProgressIndicator()));
                      }
                      else if(controller.message.value.isNotEmpty){
                        return Expanded(child: Center(child:Text(controller.message.value)));
                      }
                      else{
                        return Expanded(
                            child: ListView.builder(
                                itemCount: listFilter.length,
                                itemBuilder: (context, index) {
                                  return customeCardNote(
                                      listFilter[index].name!,
                                      listFilter[index].content!,
                                      listFilter[index].parseTime(),
                                      noteId: listFilter[index].id!,
                                      categoryId: listFilter[index].category_id!,
                                      categoryController: controller,
                                      onTap:(){
                                        Get.toNamed(RoutesNames.noteDetail,
                                            arguments:{
                                              "name":listFilter[index].name!,
                                              "content":listFilter[index].content!,
                                            }
                                        );
                                      }
                                  );
                                }));
                      }


                    })

                  ],
                ),
              ),
            );
          }

        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.up,
        childrenAnimation: ExpandableFabAnimation.none,
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
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Constants.colorBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(Messages.createNt,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  )),
              const SizedBox(width: 5),
              FloatingActionButton.small(
                backgroundColor: Constants.colorBlue,
                foregroundColor: Constants.colorwhite,
                heroTag: null,
                child: const Icon(Icons.note_add_outlined),
                onPressed: () {
                  Get.toNamed(RoutesNames.addNotePage);
                },
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Constants.colorBlue,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(Messages.createCat,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  )),
              const SizedBox(height: 20),
              FloatingActionButton.small(
                heroTag: null,
                backgroundColor: Constants.colorBlue,
                foregroundColor: Constants.colorwhite,
                child: const Icon(Icons.add_chart_outlined),
                onPressed: (){

                  dialogCat(context, (){
                    categoryController.createCategory(contoldialog.text);
                    categoryController.getCategoryOnline().then((_){
                      categories.assignAll(categoryController.getOnline());
                      categoryController.update();
                    });
                    contoldialog.text="";
                    Get.back();
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Future dialogCat(BuildContext context, onTap) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(Messages.createCat),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: contoldialog,
                decoration: InputDecoration(
                    label: const Text(Messages.catName),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Constants.colorBlue),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(Messages.cancel),
            ),
            TextButton(
              onPressed: onTap,
              child: Text(Messages.add),
            ),
          ],
        );
      },
    );
  }

  Future dialogAsk(context, content, onTap) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(Messages.request),
            content: Text("$content"),
            actions: [
              TextButton(
                child: Text(Messages.no),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(onPressed: onTap, child: Text(Messages.yes))
            ],
          );
        });
  }
  
  Future dialogEdit(context,name,content,id,categoryId,CategoryController controller){
    controller.edTitle.value.text=name;
    controller.edContent.value.text=content;
    return showDialog(context: context, builder: (context)=>
        AlertDialog(
          title: const Text(Messages.edtNt),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: controller.edTitle.value,
                ),
                TextField(
                  controller: controller.edContent.value,
                  minLines: 1,
                  maxLines: 10,
                )
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  controller.editNote(id,controller.edTitle.value.text,controller.edContent.value.text, categoryId);
                  Get.back();
                },
                child: const Text(Messages.svChng)
            ),
            TextButton(
                onPressed: (){
                  Get.back();
                },
                child: const Text(Messages.cancel)
            )
          ],
        )
    );
  }

  Widget customeCardNote(String title, String content, parse,
      {required int noteId, required int categoryId,required CategoryController categoryController,required onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Constants.colorGrey, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        onTap: onTap,
        trailing: PopupMenuButton(
          iconColor: Constants.colorBlue,
          color: Constants.colorwhite,
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: Messages.edit,
                child: Text(Messages.edit, style: TextStyle(color: Constants.colorBlue)),
              ),
              const PopupMenuItem(
                value: Messages.remove,
                child: Text(Messages.remove, style: TextStyle(color:Constants.colorBlue)),
              )
            ];
          },
          onSelected: (value) {
            if (value == Messages.edit) {
              dialogEdit(Get.context, title, content,noteId,categoryId,categoryController);
            }
            if (value == Messages.remove) {
              dialogAsk(Get.context,Messages.wntDltNt,(){
                categoryController.deleteNote(noteId, categoryId);
                Get.back();
              });
            }
          },
        ),
        title: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(content,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 18, color: Constants.colorGreyText)),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Constants.colorBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(parse,
                            style: const TextStyle(color: Constants.colorBlue)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Constants.colorBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(categoryController.selectedCategory.value,
                            style: const TextStyle(color: Constants.colorBlue)),
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
