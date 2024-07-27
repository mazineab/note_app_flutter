import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/core/utils/constant.dart';
import 'package:note_app_flutter/data/models/note.dart';
import 'package:note_app_flutter/features/category/controllers/category_controller.dart';
import 'package:note_app_flutter/routes/routes_names.dart';
import '../../user/controllers/user_controller.dart';

class AppHome extends StatelessWidget {
  AppHome({super.key});

  UserController userController = Get.find<UserController>();
  CategoryController categoryController = Get.put(CategoryController());

  String selectedCategory = "";
  TextEditingController contoldialog = TextEditingController();

  Future<void> refresh()async{
    int id=categoryController.listCategory.firstWhere((element) => element.nameCat==selectedCategory).id!;
    await categoryController.getAll(id);
    return Future.delayed(Duration(seconds:1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.colorGrey,
        title: const Text("Memo",
            style: TextStyle(
                color: Constants.colorBlue, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                userController.logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: GetBuilder<CategoryController>(
        builder: (controller) {
      var categories = controller.listCategory;
          List<Note> listFilter = controller.listNotes;
          return SizedBox(
            width: double.infinity,
            child: RefreshIndicator(
              onRefresh:refresh,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        if (selectedCategory.isEmpty && categories.isNotEmpty) {
                          selectedCategory = categories[0].nameCat!;
                        }
                        bool isSelected =
                            selectedCategory == categories[index].nameCat!;
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
                            selectedCategory = categories[index].nameCat!;
                            controller.clickedCategory(categories[index].id!);
                          },
                          onLongPress: () {
                            dialogAsk(context,
                                "Do you want to remove this category?", () {
                                  categoryController.removeCategory(categories[index].id!);
                                  Get.back();
                                });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                      child: ListView.builder(
                          itemCount: listFilter.length,
                          itemBuilder: (context, index) {
                            return customeCardNote(
                                listFilter[index].name!,
                                listFilter[index].content!,
                                listFilter[index].parseTime(),
                                noteId: listFilter[index].id!,
                                categoryId: listFilter[index].category_id!);
                          }))
                ],
              ),
            ),
          );
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
                    child: Text("add Note",
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
                    child: Text("add category",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  )),
              const SizedBox(height: 20),
              FloatingActionButton.small(
                heroTag: null,
                backgroundColor: Constants.colorBlue,
                foregroundColor: Constants.colorwhite,
                child: const Icon(Icons.add_chart_outlined),
                onPressed: () {
                  dialogCat(context, () {
                    categoryController.createCategory(contoldialog.text);
                    Navigator.of(context).pop();
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
          title: const Text('Create Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: contoldialog,
                decoration: InputDecoration(
                    label: Text("name category"),
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
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: onTap,
              child: Text('Add'),
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
            title: Text("Request"),
            content: Text("$content"),
            actions: [
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(onPressed: onTap, child: Text("Yes"))
            ],
          );
        });
  }

  Widget customeCardNote(String title, String content, parse,
      {required int noteId, required int categoryId}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Constants.colorGrey, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        trailing: PopupMenuButton(
          iconColor: Constants.colorBlue,
          color: Constants.colorBlue.withOpacity(0.5),
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: "Edit",
                child: Text("Edit", style: TextStyle(color: Colors.white)),
              ),
              const PopupMenuItem(
                value: "Remove",
                child: Text("Remove", style: TextStyle(color: Colors.white)),
              )
            ];
          },
          onSelected: (value) {
            if (value == "Edit") {
              print("OKK Edit");
            }
            if (value == "Remove") {
              dialogAsk(Get.context,"do you want to remove this note",(){
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
                        child: Text(selectedCategory,
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
