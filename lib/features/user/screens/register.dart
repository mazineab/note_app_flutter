import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:note_app_flutter/core/utils/messages.dart';
import 'package:note_app_flutter/data/models/user.dart';
import 'package:note_app_flutter/features/user/controllers/user_controller.dart';

import '../../../core/utils/constant.dart';
import '../../../global/widgets/custom_button.dart';
import '../../../global/widgets/custom_text_field.dart';
import '../../../global/widgets/custome_text_field_password.dart';
import '../controllers/text_field_controller.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userControlle) {
        return GetBuilder<TextFieldController>(
          builder: (controller) {
            return Column(
              children: [
                const SizedBox(height: 20),
                CustomTextField(
                  cont: controller.edNm,
                  text: Messages.username,
                  colorFocus: controller.focusNm,
                  iconData: Icons.person,
                  focusNode: controller.focusNodeName,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  cont: controller.edEmail,
                  text: Messages.email,
                  colorFocus: controller.focusEml,
                  iconData: Icons.email,
                  focusNode: controller.focusNodeEml,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  cont: controller.edPh,
                  text: Messages.phNbr,
                  iconData: Icons.phone,
                  colorFocus: controller.focusPhone,
                  focusNode: controller.focusNodePhone,
                ),
                const SizedBox(height: 10),
                CustomTextFieldPassword(
                  cont: controller.edPassword,
                  text: Messages.password,
                  colorFocus: controller.focusPassword,
                  iconData: Icons.lock,
                  obscure: controller.obscure,
                  focusNode: controller.focusNodePassword,
                  onPressedIcon: () {
                    controller.changeObscure();
                  },
                ),
                const SizedBox(height: 10),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                        text: Messages.signup,
                        colorBg: Constants.colorBlue,
                        colorText: Constants.colorwhite,
                        onPressed: () {

                          final User user = User(
                          name: controller.edNm.text,
                          email: controller.edEmail.text,
                            phoneNumber: controller.edPh.text,
                          password: controller.edPassword.text,
                          );
                          userControlle.register(user);
                        }))
              ],
            );
          },
        );
      },
    );
  }
}
