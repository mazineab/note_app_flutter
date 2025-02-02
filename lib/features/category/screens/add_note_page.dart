import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/core/utils/messages.dart';
import 'package:note_app_flutter/features/category/controllers/add_note_controller.dart';
import 'package:note_app_flutter/features/category/controllers/category_controller.dart';
import 'package:note_app_flutter/global/widgets/custom_button.dart';
import 'package:note_app_flutter/global/widgets/custom_app_bar.dart';

import '../../../core/utils/constant.dart';

class AddNotePage extends StatelessWidget {
   AddNotePage({super.key});


  CategoryController categoryController=Get.put(CategoryController());
  AddNoteController addNoteController=Get.put(AddNoteController());

  TextEditingController textName=TextEditingController();
  TextEditingController textContent=TextEditingController();
  String? category;

  @override
  Widget build(BuildContext context) {
    var lisCategory=categoryController.listCategory;
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 30),
              const Text(Messages.enterNote,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                decoration:const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Constants.colorBlue)
                  )
                ) ,
                  hint: const Text(Messages.chooseCat),
                  items: lisCategory.map((e){
                    return DropdownMenuItem(
                      value: e.nameCat,
                      child: Text("${e.nameCat}"),
                    );
                  }).toList(),
                  onChanged: (e){
                    category=e;
                  }
              ),
              const SizedBox(height: 20),
              TextField(
                controller: textName,
                decoration: const InputDecoration(
                  label: Text(Messages.nameNote),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Constants.colorBlue)
                  )
                ),
              ),const SizedBox(height: 20),
              Container(
                child: TextField(
                  controller: textContent,
                  maxLines: 9,
                  decoration: const InputDecoration(
                    hintText: Messages.enterNoteCont,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Constants.colorBlue)
                      )
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              CustomButton(text:Messages.save,colorText:Constants.colorwhite,
                colorBg: Constants.colorBlue,
                onPressed: (){
                int id=lisCategory.firstWhere((element) => element.nameCat==category).id ?? -1;
                  addNoteController.createNote(
                      textName.text,
                      textContent.text,
                      id
                  );
                  categoryController.gitAfterAdd(id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
