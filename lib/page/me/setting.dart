import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/service_method.dart';
import '../../routers/application.dart';
import 'package:image_picker/image_picker.dart';



class settingPage extends StatefulWidget {
  settingPage({Key key}) : super(key: key);

  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {

    File _image;

    Future getImage() async {
      _image = await ImagePicker.pickImage(source: ImageSource.gallery);
      
       _upLoadImage(_image);
     

     
    }
  
  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高
   

    return FutureBuilder(
      future: getUseInfo(),
      builder: (context,snapshot){
          if(snapshot.hasData){
            
            var data=json.decode(snapshot.data.toString());
            var userData=data['data']; 
            String nickname=userData['nickname'];
            String nicknameData=nickname==null?'绍兴说':nickname;
            String sign=userData['sign'];
             String signData=sign==null?'欢迎来到绍兴说':sign;
            String fileName=userData['fileName'];

            print(userData);

            return Scaffold(
              appBar: AppBar(backgroundColor: Color.fromRGBO(255, 255, 255, 1),),
              body: Container(
                height: height,
                child: ListView(
                  shrinkWrap: true, 								//解决无限高度问题
                  physics: new NeverScrollableScrollPhysics(),		//禁用滑动事件
                  children: <Widget>[
                    InkWell(
                      onTap:(){
                       
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: height*0.03),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: width*0.02),
                              width: width*0.3,
                              child: Text(
                                '头像',
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                            ),
                            Container(
                              width: width*0.6,
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage:NetworkImage( 'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3601287579,3282745842&fm=26&gp=0.jpg')
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: (){
                        Application.router.navigateTo(context, "/set_name");
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: height*0.03),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: width*0.02),
                              width: width*0.3,
                              child: Text(
                                '昵称',
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                            ),
                            Container(
                              width: width*0.6,
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${nicknameData}',
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: (){
                        Application.router.navigateTo(context, "/set_sgin");
                      },
                      child:Container(
                        margin: EdgeInsets.only(top: height*0.03),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: width*0.02),
                              width: width*0.3,
                              child: Text(
                                '个性签名',
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                            ),
                            Container(
                              width: width*0.6,
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${signData}',
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Container(
                      child: Center(
                        child: Container(
                          width: width*0.5,
                          height: height*0.08,
                          child: InkWell(
                            onTap: ()async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.remove('userToken');
                              Application.router.navigateTo(context, "/reg",clearStack: true);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:Border.all(
                                  color: Colors.black12
                                ),
                                color: Colors.grey.shade200
                              ),
                              child: Center(
                                child: Text('退出登录'),
                              ),
                            ),
                          ),
                        ),
                      ),                      
                    )
                  ],
                ),
              )
            );
          }else{
            return Container(
              child: Center(
                child: null,
              ),
            );
          }
      }
    );
    
    
  }
}

 _upLoadImage(File image) async {
   String userToken;
   SharedPreferences prefs = await SharedPreferences.getInstance();
   userToken = await prefs.getString('userToken');
   print(userToken);
}

Future getUseInfo()async{
   Response response;
   String userToken;
   SharedPreferences prefs = await SharedPreferences.getInstance();
   userToken = await prefs.getString('userToken');
   print(userToken);
   response=await getUserInfo(userToken);
   return response;  
}






