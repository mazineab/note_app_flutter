import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  String? text;
  Color? colorText,colorBg;
  VoidCallback? onPressed;
  CustomButton({super.key, required this.text,this.colorText,this.colorBg,this.onPressed});
  @override
  Widget build(BuildContext context) {
      return Container(
        width: double.infinity,
        height: 55,
        margin:const EdgeInsets.symmetric(horizontal:35),
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(colorBg),
              shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            onPressed:onPressed,
            child: Text(text!,style: TextStyle(color:colorText,fontWeight: FontWeight.bold))),
      );
    }
}