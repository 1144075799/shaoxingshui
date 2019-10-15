import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';
import 'package:image_picker/image_picker.dart';

//名城接口
Future cityRequest(city_type)async{
  try{
    Response response;
    Dio dio=new Dio();
    response=await dio.get('${servicePath['cityPort']}?city_type=$city_type');
    // print('请求到的数据:+$response');
    return response;
  }catch(e){
    return print('ERROR:=====>${e}');
  }
}

//父景区接口
Future scenicRequest()async{
  try{
    Response response;
    Dio dio=new Dio();
    response=await dio.post('${servicePath['scenicPort']}');
    return response;
  }catch(e){
    return print('ERRO:======》${e}');
  }
}

//单个父景区的接口
Future scenicPatRequest(id)async{
  try{
    Response response;
    Dio dio=new Dio();
    response=await dio.get('${servicePath['scenicPar']}?id=$id');
    return response;
  }catch(e){
    print('ERROR:=====》${e}');
  }
}


Future scenicSubRequest(id)async{
  try{
    Response response;
    Dio dio=new Dio();
    response=await dio.get('${servicePath['scenicSub']}?id=$id');
    // print('请求到的数据${response}');
    return response;
  }catch(e){
    print('ERROR:=====》${e}');
  }
}

//根据父景区id查找子景区
Future scenicChildRequest(id)async{
  try{
    Response response;
    Dio dio=new Dio();
    response=await dio.get('${servicePath['scenicChild']}?id=$id');
    return response;
  }catch(e){
    print('ERROR=======>${e}');
  }
}

//获取名人的接口
Future celebrityRequest(page_num,page_size)async{
  try{
    Response response;
    Dio dio=Dio();
    response=await dio.get('${servicePath['celebrityPort']}?page_num=$page_num&page_size=$page_size');
    return response;
  }catch(e){
    
    return null;
  }
}

//获取单个名人的接口
Future celebrityShowRequest(id)async{
   try{
    Response response;
    Dio dio=Dio();
    response=await dio.get('${servicePath['celebrityShow']}?famousId=$id');
    return response;
  }catch(e){
    print('ERROR=======>${e}');
  }
}

//模糊查找
Future fuzzyQuery(name)async{
  try{
    Response response;
    Dio dio=Dio();
    response=await dio.get('${servicePath['fuzzyQuery']}?word=$name');
    // print('请求到的数据${response}');
    return response;
  }catch(e){
    print('ERROR====>${e}');
  }
}

//登录注册请求
Future registerRequest(userName,password)async{
  try{
    print('开始注册请求数据');
    print(password);
    Response response;
    Dio dio=new Dio();
    var data={"user_name":userName,"pwd":password};
    response=await dio.post("${servicePath['registerPort']}",queryParameters:data);
    print('得到的数据:${response}');
    return response;
  }catch(e){
    return print('ERRO:======》${e}');
  }
}

Future loginRequest(userName,password)async{
  try{
    print('开始登录请求数据');
    print(password);
    Response response;
    Dio dio=new Dio();
    var data={"user_name":userName,"pwd":password};
    print(servicePath['loginPort']);
    print(data);
    response=await dio.post("${servicePath['loginPort']}",queryParameters:data);
    print('请求中的:${response}');
    return response;
  }catch(e){
    return print('ERRO:======》${e}');
  }
}

//关注景区接口
Future likeViewRequest(token,id,title,image_url)async{
  try{
    print('开始请求接口');
    Response response;
    Dio dio=new Dio();
    // var data={"view_id":id,"token":token,"view_title":title,"picture_url":image_url};
    String id_url=id.toString();
    String url="${servicePath['likeView']}/"+id_url+'?token=${token}&view_title=${title}&picture_url=${image_url}';
    print(url);
    response=await dio.post(url);
    return response;
  }catch(e){
    return print('ERROR:======》${e}');
  }
}

//获取用户喜欢的景区
Future getListView(token)async{
  try{
     print('开始请求接口');
      Response response;
      Dio dio=new Dio();
      response=await dio.get('${servicePath['getListView']}?token=$token');
      return response;
  }catch(e){
    return print('ERROR:=====>${e}');
  }
}

//关注名人接口
Future likeFamousRequest(token,id,title,image_url)async{
  try{
    print('开始请求接口');
    Response response;
    Dio dio=new Dio();
    // var data={"view_id":id,"token":token,"view_title":title,"picture_url":image_url};
    String id_url=id.toString();
    String url="${servicePath['likefamous']}/"+id_url+'?token=${token}&famous_title=${title}&picture_url=${image_url}';
    print(url);
    response=await dio.post(url);
    print('获取名人的数据:${response}');
    return response;
  }catch(e){
    return print('ERROR:======》${e}');
  }
}
//删除用户关注的名人
Future deleteListFamous(token,id)async{
   try{
      print('开始请求删除关注名人接口');
      Response response;
      Dio dio=new Dio();
      // print('地址:${servicePath['deleteListFamous']}/'+id+'?token=$token');
      response=await dio.post('${servicePath['deleteListFamous']}/'+id+'?token=$token');
     
      return response;
  }catch(e){
    return print('ERROR:=====>${e}');
  }
}

//获取用户喜欢的名人
Future getListFamous(token)async{
  try{
     print('开始请求接口');
      Response response;
      Dio dio=new Dio();
      response=await dio.get('${servicePath['getListFanous']}?token=$token');
      return response;
  }catch(e){
    return print('ERROR:=====>${e}');
  }
}

//删除用户关注的景区
Future deleteListView(token,id)async{
   try{
      print('开始请求接口');
      Response response;
      Dio dio=new Dio();
      // print('地址:${servicePath['deleteListFamous']}/'+id+'?token=$token');
      response=await dio.post('${servicePath['deleteListView']}/'+id+'?token=$token');
     
      return response;
  }catch(e){
    return print('ERROR:=====>${e}');
  }
}

Future getUserInfo(token)async{
  try{
     print('开始请求接口');
      Response response;
      Dio dio=new Dio();
      response=await dio.get('${servicePath['getUserInfo']}?token=$token');
      print(response);
      return response;
  }catch(e){
    return print('ERROR:=====>${e}');
  }
}

Future setUserName(token,name)async{
  try{
      print('开始请求接口');
      Response response;
      Dio dio=new Dio();
      response=await dio.post('${servicePath['setUserInfo']}?token=$token&nickname=$name');
     
      return response;
  }catch(e){
    return print('ERROR:=====>${e}');
  }
}

Future setUserSgin(token,sgin)async{
  try{
      print('开始请求接口');
      Response response;
      Dio dio=new Dio();
      response=await dio.post('${servicePath['setUserInfo']}?token=$token&sgin=$sgin');
     
      return response;
  }catch(e){
    return print('ERROR:=====>${e}');
  }
}






