import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/utils/constant.dart';

class CustomTextFieldPassword extends StatelessWidget{
  TextEditingController cont;
  String? text;
  bool colorFocus;
  bool obscure;
  IconData? iconData;
  FocusNode focusNode;
  VoidCallback onPressedIcon;

  CustomTextFieldPassword({required this.cont,required this.text,required this.colorFocus,required this.obscure,required this.onPressedIcon,required this.iconData,required this.focusNode});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: cont,
        focusNode: focusNode,
        obscureText: obscure,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: (){
                onPressedIcon();
              },
              icon: Icon(obscure?Icons.visibility_off:Icons.visibility)
          ),
            prefixIcon: Icon(iconData,color:colorFocus?Constants.colorBlue:Colors.black,),
            label:Text(text??"",style: TextStyle(color:colorFocus?Constants.colorBlue:Colors.black)),
            focusedBorder:OutlineInputBorder(
              borderSide:BorderSide(color:colorFocus?Constants.colorBlue:Colors.black,width:1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
      ),
    );
  }

}