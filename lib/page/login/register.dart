import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../routers/application.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../provide/login.dart';
import 'package:provide/provide.dart';
import 'package:dio/dio.dart';
import '../../service/service_method.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../index_page.dart';

class registerPage extends StatefulWidget {
  registerPage({Key key}) : super(key: key);

  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {

  //用户名控制器
  TextEditingController userNameController = TextEditingController();

  //密码控制器
  TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高

    Future<String> userToken = get();
    userToken.then((String userToken)async{
      print('登录页面的token:${userToken}');
        if(userToken!=null){
          Application.router.navigateTo(context, "/",replace: true);
        }
      
    });

    return Scaffold(
      body: Provide<LoginProvide>(                                            //使用状态管理者
        builder: (context,child,val){
          return  Container(
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
                      hintText:'账号: ' 
                    ),
                    onChanged: (val){
                      Provide.value<LoginProvide>(context).changeregUser(val);
                    },
                  ),
                ),
                Container(
                  width: width*0.1,
                  margin: EdgeInsets.fromLTRB(width*0.1, height*0.06, width*0.1, 0),
                  child: TextField(
                    controller: passWordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      hintText:'密码: ',
                      
                    ),
                    onChanged: (val){
                      Provide.value<LoginProvide>(context).changeregPass(val);
                    },
                    obscureText:true
                  ),
                ),
                InkWell(
                  onTap: ()async{
                    Response response;
                    response=await loginRequest(Provide.value<LoginProvide>(context).regUser,Provide.value<LoginProvide>(context).regPass);
                    print(response.data);
                    if(response.data['code']==1){
                      String token=response.data['data']['token'];
                      String nickname=response.data['data']['usr']['nickname'];
                      String sign=response.data['data']['usr']['sign'];
                      String fileName=response.data['data']['usr']['fileName'];
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      //本地存储一些信息
                      prefs.setString('userToken', token);
                      prefs.setString('nickname', nickname);
                      prefs.setString('sign', sign);
                      prefs.setString('fileName', fileName);
                      //页面直接跳转
                      Application.router.navigateTo(context, "/",replace: true);
                    }else{
                      print('执行这步了');
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
                          '登陆',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.fromLTRB(width*0.4, height*0.1, 0, 0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('功能暂时为开放'),
                            )
                          );
                        },
                        child: Icon(FontAwesomeIcons.qq),
                      ),
                      
                      Container(
                        margin: EdgeInsets.only(left: width*0.1),
                        child:InkWell(
                          onTap: (){
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('功能暂时为开放'),
                              )
                            );
                          },
                          child:  Icon(FontAwesomeIcons.weixin),
                        )
                      )
                    ],
                  ),
                ),
                Divider(),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        Application.router.navigateTo(context, "/log");
                      },
                      child: Text(
                        '没有账号，请先注册',
                      ),
                    ),
                  )
                )

              ],
            ),
          );
        })
    );
  }
}


//获取token
Future<String> get() async {
  var userToken;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = await prefs.getString('userToken');
  return userToken;
}
