import 'package:flutter/material.dart';


class MeProvide with ChangeNotifier{
  String name;
  String sgin;
  int operationArea=-1;                           //控制是否打开操作区域
  int openAgain=0;                                //控制是否可以再次打开


  //刷新
  refresh(){
    notifyListeners();
  }
  


  isOpen(val){                            //设置那个是打开的
    operationArea=val;
    notifyListeners();
  }

  changAgain(val){
    openAgain=val;
    notifyListeners();
  }

  changeName(val){
    name=val;
    notifyListeners();
  }

  changeSgin(val){
    sgin=val;
    notifyListeners();
  }
}