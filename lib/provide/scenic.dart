import 'package:flutter/material.dart';

class ScenicProvide with ChangeNotifier{
  int instructions=0;
  int isShow=0;

  changeInstructions(val){
    instructions=val;
    notifyListeners();
  }

  changeShow(val){
    isShow=val;
    notifyListeners();
  }

}