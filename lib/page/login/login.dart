import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../routers/application.dart';
import '../../provide/login.dart';
import 'package:provide/provide.dart';
import '../../service/service_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  loginPage({Key key}) : super(key: key);

  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

    //用户名控制器
    TextEditingController userNameController = TextEditingController();

    //密码控制器
    TextEditingController passWordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高

    return Scaffold(
      body: Provide<LoginProvide>(                                            //使用状态管理者
        builder: (context,child,val){
          return Container(
            height: height,
              child: ListView(
              physics: new NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(width*0.05, height*0.1, 0, 0),
                  child: Text(
                    '欢迎您登录绍兴说',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                ),
                Container(
                  width: width*0.1,
                  margin: EdgeInsets.fromLTRB(width*0.1, height*0.12, width*0.1, 0),
                  child: TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      hintText:'账号: ' ,
                      helperText: '账号不能少于6位'
                    ),
                    onChanged: (val){
                      Provide.value<LoginProvide>(context).changeloginUser(val);
                    },
                  ),
                ),
                Container(
                  width: width*0.1,
                  margin:  EdgeInsets.fromLTRB(width*0.1, height*0.06, width*0.1, 0),
                  child: TextField(
                    controller: passWordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintText:'密码: ' 
                    ),
                    obscureText:true,
                    onChanged: (val){
                      Provide.value<LoginProvide>(context).changeloginPass(val);
                    },
                  ),
                ),
                InkWell(
                  onTap: ()async{
                    Response response;
                    response=await registerRequest(Provide.value<LoginProvide>(context).loginUser,Provide.value<LoginProvide>(context).loginPass);
                    
                    if(response.data['code']==1){
                      Application.router.navigateTo(context, "/reg",replace: true);
                    }else{
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response.data['msg']),
                          action: SnackBarAction(
                            label: '重新输入',
                            onPressed: (){
                                  userNameController.text="";
                                  passWordController.text="";
                            },
                          ),
                        )
                      );
                    }
                  },
                  child: Container(
                    width: width*0.08,
                    height: height*0.06,
                    margin: EdgeInsets.fromLTRB(width*0.25, height*0.1, width*0.25, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border:Border.all(
                          color: Colors.black12
                        ),
                        color: Colors.grey.shade200
                      ),
                    child:Center(
                      child: InkWell(
                        child: Text(
                          '注册',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ),
                  ),
                )
                
              ],
            ),
          );
        }),
      
    );
  }
}


