import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_flutter/core/utils/constant.dart';
import 'package:note_app_flutter/core/utils/messages.dart';
import 'package:note_app_flutter/features/user/controllers/text_field_controller.dart';
import 'package:note_app_flutter/features/user/screens/login.dart';
import 'package:note_app_flutter/features/user/screens/register.dart';
import 'package:note_app_flutter/global/widgets/custom_app_bar.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});


  @override
  Widget build(BuildContext context) {
    // int val=Get.arguments;
    Map<String,dynamic> data=Get.arguments;
    int val=data['index']??1;
    bool isFirst=data['first']??true;
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          child: GetBuilder<TextFieldController>(
            builder: (controller) {
              if(val!=-1){
                controller.chnagePage(val,isFirst);
              }
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(Messages.wlc,
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold)),
                    const Text(
                        Messages.wlcMsg,
                        style: TextStyle(color: Constants.colorGreyText)),
                    const SizedBox(height: 20),
                    CustomSlidingSegmentedControl(
                      fixedWidth: 150,
                      initialValue:val!=-1?val:1,
                      children: const {1: Text(Messages.login), 2: Text(Messages.register)},
                      onValueChanged: (value) {
                        val=-1;
                        controller.chnagePage(value,false);
                      },
                      decoration: BoxDecoration(
                          color: Constants.colorGrey,
                          borderRadius: BorderRadius.circular(10)),
                      thumbDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            offset: const Offset(
                              0.0,
                              2.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.login
                        ? const SizedBox(height: 50)
                        : const SizedBox(height: 10),
                    controller.login ? const LoginScreen() : Register()
                  ]);
            },
          ),
        ),
      ),
    );
  }
}
