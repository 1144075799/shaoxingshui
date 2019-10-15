import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routers/application.dart';
import '../../service/service_method.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class mePage extends StatefulWidget {
  mePage({Key key}) : super(key: key);

  _mePageState createState() => _mePageState();
}

class _mePageState extends State<mePage> {

  File _image;

 

  Future getImage() async {
    int length;
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    await image.length().then((val)=>{
      length=val
    });

    setState(() {
      _image = image;
      
    
      print(length);

      String path=_image.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
     
      print(name);
      print(suffix);

    });
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

          

          return Scaffold(
     
            body: Container(
              height: height,
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true, 								//解决无限高度问题
                children: <Widget>[
                  Container(
                    height: height*0.3,
                    width: width,
                    decoration:BoxDecoration(
                      // color: Color.fromRGBO(144, 144, 144, 1),
                      image: DecorationImage(
                        image: AssetImage('images/me.jpg'),fit: BoxFit.fill
                      )
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: width*0.1),
                          child: InkWell(
                            // onTap: getImage,
                            onTap: (){
                              print('点击头像');
                            },
                            child: CircleAvatar(
                              radius: width*0.1,
                              backgroundImage: showImage(_image,fileName),
                            )
                          ),
                        ),
                        Container(
                          
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: width*0.3,
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: height*0.12),
                                child: Text(
                                  
                                  '${nicknameData}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                              Container(
                                width: width*0.3,
                                margin: EdgeInsets.only(top:height*0.01),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${signData}',
                                  overflow:TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Colors.white,
                                    
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(width*0.20, height*0.01, 0, 0),
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: (){
                                Application.router.navigateTo(context, "/set");
                              },
                              child: Icon(Icons.settings),
                            ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(width*0.05, height*0.03, 0, 0),
                    child: Text(
                      '我的关注',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: (){
                      Future<String> userToken = get();
                      userToken.then((String userToken)async{
                        print(userToken);
                        Application.router.navigateTo(context, "/love_famous?userToken=${userToken}");
                      });
                    },
                    child: Container(
                      width: width,
                      height: height*0.1,
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: width*0.05),
                              width: width*0.6,
                              child: Text(
                                '名人',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15
                                ),
                              ),
                            ),
                            Container(
                              width: width*0.3,
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.arrow_forward_ios),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Future<String> userToken = get();
                      userToken.then((String userToken)async{
                        print(userToken);
                        Application.router.navigateTo(context, "/love_view?userToken=${userToken}");
                      });
                    },
                    child: Container(
                      width: width,
                      height: height*0.1,
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: width*0.05),
                              width: width*0.6,
                              child: Text(
                                '景区',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15
                                ),
                              ),
                            ),
                            Container(
                              width: width*0.3,
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.arrow_forward_ios),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.fromLTRB(width*0.05, height*0.01, 0, 0),
                    child: Text(
                      '我的服务',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    width: width,
                    height: height*0.1,
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: width*0.05),
                            width: width*0.6,
                            child: Text(
                              '帮助与反馈',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 15
                              ),
                            ),
                          ),
                          Container(
                            width: width*0.3,
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_forward_ios),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    width: width,
                    height: height*0.1,
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: width*0.05),
                            width: width*0.6,
                            child: Text(
                              '客服中心',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 15
                              ),
                            ),
                          ),
                          Container(
                            width: width*0.3,
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_forward_ios),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          );
        }else{
          return Container(
            child: Text('数据请求中'),
          );
        }
      }
    );
    
  }
}

ImageProvider showImage(_image,fileName){
  if(_image==null){
    return NetworkImage( 'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3601287579,3282745842&fm=26&gp=0.jpg');
  }else{
    return FileImage(_image);
  }
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

Future<String> get() async {
  var userToken;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = await prefs.getString('userToken');
  return userToken;
}


