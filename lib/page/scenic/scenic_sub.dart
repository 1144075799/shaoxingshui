import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:provide/provide.dart';
import '../../provide/scenic.dart';
import '../../routers/application.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './scenic_btn.dart';
import '../../service/service_method.dart';

class scenicSub extends StatefulWidget {

  String id;

  scenicSub({Key key,this.id}) : super(key: key);

  _scenicSubState createState() => _scenicSubState();
}

class _scenicSubState extends State<scenicSub> {
  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高


    return Scaffold(
      body:FutureBuilder(
        future: scenic_request(widget.id),
        builder: (context,snapshot){
          if(snapshot.hasData){

            var data=json.decode(snapshot.data.toString());
            var scenicData=data['data']; 
            List scenicList=(scenicData as List).cast();
            String title=scenicList[0]['title'];
            List image_url=scenicList[0]['pic_url'];

            List subViewList=[];
     
            String fileContent=scenicList[0]['fileContent'];

           

            return Scaffold(
              body: Provide<ScenicProvide>(
              builder: (context,child,val){
                return Stack(
                  children: <Widget>[
                    GestureDetector(

                      onTap: (){
                        Application.router.pop(context);
                      },

                      

                      child: Container(
                        height: height,
                        margin: EdgeInsets.fromLTRB(width*0.05, height*0.05, width*0.05,  height*0.1),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                          border:Border.all(
                            color: Colors.black12
                          )
                        ),
                        child: ListView(
                          shrinkWrap: true, 								//解决无限高度问题
                          physics: new NeverScrollableScrollPhysics(),		//禁用滑动事件
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: height*0.01),
                              height: height*0.3,
                              width: width,
                              child: Swiper(
                                itemBuilder: (BuildContext context,int index){
                                  return Image.network("${image_url[index]['picUrl']}",fit: BoxFit.fill,);
                                },
                                itemCount: image_url.length,
                                pagination: SwiperPagination(),
                                autoplay: true,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: height*0.05),
                              child: Center(
                                child: Text(
                                  '${title}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: height*0.48,
                              margin: EdgeInsets.fromLTRB(width*0.05, height*0.05, width*0.05, 0),
                              child: ListView(
                                children: <Widget>[
                                  Text('${fileContent}'),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    buttonShow(context,title,subViewList,fileContent,),
                  ],
                );
              }),
            );
          }else{
            return Container(
              child: Text('数据请求中'),
            );
          }
        }
      )
    );
  }
}

Future scenic_request(id)async{
  Response response;
  response=await scenicSubRequest(id);
  return response;
}

Widget buttonShow(context,title,subViewList,fileContent){
  return scenicBtn(title: title,subViewList: subViewList,fileContent:fileContent);
}