import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:note_app_flutter/features/user/controllers/user_controller.dart';

import '../../../core/utils/constant.dart';
import '../../../global/widgets/custom_button.dart';
import '../../../global/widgets/custom_text_field.dart';
import '../../../global/widgets/custome_text_field_password.dart';
import '../controllers/text_field_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextFieldController>(
      builder: (controller){
        return GetBuilder<UserController>(
            builder:(userController){
          return Column(
            children: [
              const SizedBox(height: 20),
              CustomTextField(
                cont: controller.edEmail,
                text: "email",
                colorFocus:controller.focusEml,
                iconData: Icons.email,
                focusNode: controller.focusNodeEml,
              ),const SizedBox(height: 30),
              CustomTextFieldPassword(
                cont: controller.edPassword,
                text: "password",
                colorFocus:controller.focusPassword,
                iconData: Icons.lock,
                obscure: controller.obscure,
                focusNode: controller.focusNodePassword, onPressedIcon: () {controller.changeObscure(); },
              ),const SizedBox(height: 20),
              Container(
                  margin:const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(text:"Singin",colorBg: Constants.colorBlue,
                    colorText: Constants.colorwhite,
                    onPressed:(){
                      userController.login(
                          controller.edEmail.text,
                          controller.edPassword.text
                      );
                    },)
              )
            ],
          );
        });
      }
    );
  }
}
