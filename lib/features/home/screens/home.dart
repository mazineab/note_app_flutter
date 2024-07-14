import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/core/utils/constant.dart';
import 'package:note_app_flutter/features/home/controllers/home_controller.dart';

import '../../../global/widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,width: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Constants.imageNote))
              ),
            ),
            const SizedBox(height:20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: const Text("Save your notes online and locally without worrying about losing them.",
                style: TextStyle(fontSize: 30),textAlign:TextAlign.center,),
            ),const SizedBox(height: 60),
            GetBuilder<HomeController>(
                builder:(controller){
                  return CustomButton(
                      text: "register",colorText: Constants.colorwhite,colorBg: Constants.colorBlue,
                    onPressed:(){
                      controller.toLogin();
                    },
                  );
                }
            ),
            const SizedBox(height:20),
            GetBuilder<HomeController>(
                builder:(controller){
                  return CustomButton(text: "Login",colorText: Constants.colorBlue,colorBg: Constants.colorwhite,
                    onPressed:(){
                      controller.toRegister();
                    },
                  );
                }
            )
          ],
        ),
      ),
    );
  }

}
