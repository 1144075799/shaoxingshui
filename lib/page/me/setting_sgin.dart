import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/me.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/service_method.dart';
import '../../routers/application.dart';

class settingSgin extends StatefulWidget {
  settingSgin({Key key}) : super(key: key);

  _settingSginState createState() => _settingSginState();
}

class _settingSginState extends State<settingSgin> {
  @override
  Widget build(BuildContext context) {

     final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高

    return Scaffold(
      appBar: AppBar(
        title: Text('修改个性签名'),
        actions: <Widget>[
          Container(
            width: width*0.1,
            alignment: Alignment.center,
            child: InkWell(
              onTap: ()async{
                print(Provide.value<MeProvide>(context).sgin);
                Response response;
                String userToken;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                userToken = await prefs.getString('userToken');
                response=await setUserSgin(userToken,Provide.value<MeProvide>(context).sgin);
               
                if(response.data['code']==1){
                  Application.router.pop(context);
                }
                
              },
              child: Text(
                '完成',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              ),
            )
          )
        ],
      ),
      body: Provide<MeProvide>(                                            //使用状态管理者
        builder: (context,child,val){
          return ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5),
                child:  Row(
                  children: <Widget>[
                    Container(
                      width: width*0.2,
                      child: Text('个性签名:'),
                    ),
                    Container(
                      width: width*0.6,
                      child: TextField(
                        onChanged: (val){
                          Provide.value<MeProvide>(context).changeSgin(val);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        })
    );
  }
}