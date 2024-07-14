
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../user/controllers/user_controller.dart';


class AppHome extends StatelessWidget {
  AppHome({super.key});

  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Memo", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () {
                userController.logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            // ButtonsTabBar(
            //     // backgroundColor: Colors.red,
            //     tabs: [
            //       Tab(
            //         text: "Home",
            //       ),
            //       Tab(
            //         text: "ChatGpt",
            //       ),
            //       Tab(
            //         text: "Work",
            //       ),
            //       Tab(
            //         text: "English",
            //       ),
            //       Tab(
            //         text: "Programming",
            //       ),
            //       Tab(
            //         text: "Link",
            //       ),
            //     ]
            // )
          ],
        ),
      ),
    );;
  }
}
