import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TextFieldController extends GetxController{

  bool focusNm=false;
  bool focusEml=false;
  bool focusPhone=false;
  bool focusPassword=false;
  late FocusNode focusNodeName;
  late FocusNode focusNodeEml;
  late FocusNode focusNodePhone;
  late FocusNode focusNodePassword;

  late TextEditingController edNm;
  late TextEditingController edEmail;
  late TextEditingController edPh;
  late TextEditingController edPassword;



  bool obscure=true;

  @override
  void onInit() {
    super.onInit();
    init();
    edNm=TextEditingController();
    edEmail=TextEditingController();
    edPh=TextEditingController();
    edPassword=TextEditingController();

  }

  void init(){
    focusNodeName=FocusNode();
    focusNodeEml=FocusNode();
    focusNodePhone=FocusNode();
    focusNodePassword=FocusNode();
    final list=[focusNodeName,focusNodeEml,focusNodePhone,focusNodePassword];
    list.forEach((element) {
      element.addListener(() {
        if(element.hasFocus){
          onTapField(element);
        }
        else{
          onTapField(element);
        }
      });
    });
  }

  void onTapField(FocusNode fcs){
    if(fcs==focusNodeName){
      focusNm=!focusNm;
    }
    if(fcs==focusNodeEml){
      focusEml=!focusEml;
    }
    if(fcs==focusNodePhone){
      focusPhone=!focusPhone;
    }
    if(fcs==focusNodePassword){
      focusPassword=!focusPassword;
    }
    update();
  }

  void changeObscure(){
    obscure=!obscure;
    update();
  }

  bool login=true;
  void chnagePage(int value,bool isFirst){
    if(value==2){
      login=false;
    }
    else if(value==1){
      login=true;
    }
    if(!isFirst){
      clearFocus();
    }

    update();
  }

  void clearFocus() {
    focusNodeName.unfocus();
    focusNodeEml.unfocus();
    focusNodePhone.unfocus();
    focusNodePassword.unfocus();
  }





}