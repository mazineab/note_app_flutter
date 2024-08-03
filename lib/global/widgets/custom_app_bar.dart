import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/core/utils/messages.dart';

import '../../core/utils/constant.dart';
import '../../features/user/controllers/user_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Constants.colorGrey,
      title: const Text(Messages.Memo, style: TextStyle(color:Constants.colorBlue,fontWeight: FontWeight.bold)),
      actions: [
        IconButton(
            onPressed: () {
              userController.logout();
            },
            icon: const Icon(Icons.logout))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}