import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/core/utils/constant.dart';
import 'package:note_app_flutter/global/widgets/custome_app_bar.dart';

class NoteDetails extends StatelessWidget {
  const NoteDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> data=Get.arguments;
    return Scaffold(
      appBar: CustomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(data['name'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Constants.colorBlue),),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Divider(height: 1,color: Constants.colorBlue,),
            ),const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              child: Text(data['content'],style: TextStyle(fontSize: 20),),
            )
          ],
        ),
      ),
    );
  }
}
