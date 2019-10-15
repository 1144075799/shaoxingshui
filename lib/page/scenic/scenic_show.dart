import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import '../../service/service_method.dart';
import 'dart:convert';
import './scenic_btn.dart';
import './scenic_sublist.dart';
import '../../routers/application.dart';
import 'package:provide/provide.dart';
import '../../provide/scenic.dart';
import 'dart:async';


class scenicShow extends StatefulWidget {
  String id;

  scenicShow({Key key,this.id}) : super(key: key);

  _scenicShowState createState() => _scenicShowState();
}



class _scenicShowState extends State<scenicShow> with SingleTickerProviderStateMixin{

  
  

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
            int id=scenicList[0]['id'];
            // print(id);
            String title=scenicList[0]['title'];
            List image_url=scenicList[0]['pic_url'];
            String imge_url=image_url[0]['picUrl'];
            List subViewList=scenicList[0]['subViewList'];
            
            String fileContent=scenicList[0]['fileContent'];

            
           

            return Scaffold(
              body: Provide<ScenicProvide>(
              builder: (context,child,val){
                return Stack(
                  children: <Widget>[
                    GestureDetector(

                      onTap: (){
                        if(Provide.value<ScenicProvide>(context).isShow==0){
                          Application.router.pop(context);
                        }else{
                          Provide.value<ScenicProvide>(context).changeShow(0);
                        }
                        
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
                    buttonShow(context,title,subViewList,fileContent,id,imge_url),
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
  response=await scenicPatRequest(id);
  return response;
}


Future childSenic(id)async{
   Response response;
   response=await scenicChildRequest(id);
   return response;
}

Widget buttonShow(context,title,subViewList,fileContent,id,imge_url){
  if(Provide.value<ScenicProvide>(context).isShow==0){
    return scenicBtn(title: title,subViewList: subViewList,fileContent:fileContent,id: id,image_url: imge_url,);
  }else{
    return scenicSubList(subViewList:subViewList);
  }
}










 