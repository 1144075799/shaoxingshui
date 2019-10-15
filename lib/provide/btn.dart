import 'package:flutter/material.dart';


class BtnProvide with ChangeNotifier{
  int showOff=0;


  changeOff(val){
    showOff=val;
    notifyListeners();
  }
}