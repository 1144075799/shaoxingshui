import 'package:flutter/material.dart';
import 'dart:convert';


class LoginProvide with ChangeNotifier{
  String loginUser="";                      //注册时的用户名
  String loginPass="";                      //注册时的密码
  String regUser="";                        //登录时的用户名
  String regPass="";                        //登陆时的密码

  changeloginUser(val){
    loginUser=val;
    notifyListeners();
  }

  changeloginPass(val){
    loginPass=val;
    loginPass=base64Encode(utf8.encode(loginPass)).toString();
    notifyListeners();
  }

  changeregUser(val){
    regUser=val;
    notifyListeners();
  }

  changeregPass(val){
    regPass=val;
    regPass=base64Encode(utf8.encode(regPass)).toString();
    notifyListeners();
  }
}