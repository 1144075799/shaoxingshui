import 'package:flutter/material.dart';
import './scenic_content.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:async';
import '../../service/service_method.dart';
import 'package:provide/provide.dart';
import '../../provide/scenic.dart';

class scenicPage extends StatefulWidget {
  scenicPage({Key key}) : super(key: key);

  _scenicPageState createState() => _scenicPageState();
}

class _scenicPageState extends State<scenicPage> {

  List<Map> scenicList;
  
 

  Widget _pageItemBuilder(context,index){
    String title=scenicList[index]['title'];
    List image_url=scenicList[index]['pic_url'];
    String fileContent=scenicList[index]['fileContent'];
    int id=scenicList[index]['id'];
    return scenicContent(title: title,image_url:image_url,fileContent:fileContent,id:id);
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高
    

    
    
    return  FutureBuilder(
      future: scenic_request(),
      builder: (context,snapshot){
        if(snapshot.hasData){

           var data=json.decode(snapshot.data.toString());
           var scenicData=data['data']; 
           scenicList=(scenicData as List).cast();


          return  Provide<ScenicProvide>(
          builder: (context,child,val){
            return Stack(
              children: <Widget>[
                PageView.builder(
                  itemCount: scenicList.length,
                  itemBuilder: _pageItemBuilder,
                  controller: PageController(
                    initialPage: Provide.value<ScenicProvide>(context).instructions
                  ),
                  onPageChanged: (index){
                    // print(index);
                    Provide.value<ScenicProvide>(context).changeInstructions(index);
                  },
                ),
                Positioned(
                  bottom: height*0.01,
                  child:Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: width*0.4),
                            width: width*0.02,
                            height: height*0.02,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Provide.value<ScenicProvide>(context).instructions==0?Colors.blue:Colors.white
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width*0.05),
                            width: width*0.02,
                            height: height*0.02,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Provide.value<ScenicProvide>(context).instructions!=0&&Provide.value<ScenicProvide>(context).instructions!=scenicList.length-1?Colors.blue:Colors.white
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width*0.05),
                            width: width*0.02,
                            height: height*0.02,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Provide.value<ScenicProvide>(context).instructions==scenicList.length-1?Colors.blue:Colors.white
                            ),
                          )
                        ],
                      ),
                    )
                  )
                )
              ],
            );
          });
        }else{
          return Scaffold(
            body: Container(
              child: Center(
                child: Text('无数据'),
              ),
            ),
          );
        }
      },
    );
    
  }
}

Future scenic_request()async{
  Response response;
  response=await scenicRequest();
  return response;
}