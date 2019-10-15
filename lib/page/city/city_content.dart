import 'package:flutter/material.dart';
import '../../service/service_method.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../routers/application.dart';


class cityContent extends StatefulWidget {

  String city_type;
  String image_url;

  cityContent({Key key,this.city_type,this.image_url}) : super(key: key);
  

  _cityContentState createState() => _cityContentState();
}

class _cityContentState extends State<cityContent> with SingleTickerProviderStateMixin{

  Animation<double> tween;
  AnimationController controller;

  /*初始化状态*/
  initState() {
    super.initState();

    /*创建动画控制类对象*/
    controller = new AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this);

    /*创建补间对象*/
    tween = new Tween(begin: 0.0, end: 1.0)
        .animate(controller)    //返回Animation对象
      ..addListener(() {        //添加监听
        setState(() {
          // print(tween.value);   //打印补间插值
        });
      });
    
  }

  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高

    return FutureBuilder(
      future: request(widget.city_type),
      builder: (context,snapshot){
        if(snapshot.hasData){
          controller.forward();       //执行动画
          var data=json.decode(snapshot.data.toString());
          var cityData=data['data'];
          List<Map> citySub=(cityData['subTitleList'] as List).cast();
          

          return Scaffold(
              
              body: Container(
              color: Colors.grey.shade200,
              child: ListView(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child:Image.asset('images/city${widget.image_url}.jpg',fit: BoxFit.fill,),
                      ),
                      GestureDetector(

                        onTap: (){
                          Application.router.pop(context);
                        },

                        child: Container(
                          width: width*0.9,
                          height: height,
                          // margin: EdgeInsets.only(top: 230),
                          margin: EdgeInsets.fromLTRB(width*0.1* controller.value, height*0.3 * controller.value, width*0.1* controller.value, 0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(50* controller.value),
                            border:Border.all(
                              color: Colors.black12
                            )
                          ),
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(width*0.05, height*0.05, width*0.05, 0),
                                    child: Text(
                                      '${cityData['cityName']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.only(top: 20),
                                    margin: EdgeInsets.fromLTRB(width*0.05, height*0.02, width*0.05, 0),
                                    child: Text(
                                      '${cityData['cityContent']}',
                                    ),
                                  ),
                                
                                  ListView.builder(
                                    shrinkWrap: true, 								//解决无限高度问题
                                    physics: new NeverScrollableScrollPhysics(),		//禁用滑动事件
                                    itemCount:3,
                                    itemBuilder: (context,index){
                                      return _littleContext(citySub[index]['smallTitle'],citySub[index]['smallTitleContent'],height,width);
                                    },
                                  ),
                                  
                                ],
                              ),
                            ],
                          )
                        ),
                      )
                    ],
                  ),
                ],
              )
            ),
          );
        }else{
          return Scaffold(
              body: Container(
              child: Center(
                child: Text('正在请求中'),
              ),
            ),
          );
        }
      },
    );
    

    
  }
}

Widget _littleContext(title,cityContext,height,width){
  return Column(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top:height*0.01 ),
        child: Text(
          '${title}',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.w500
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(width*0.01,height*0.02, width*0.01, 0),
        child: Text('${cityContext}'),
      ),
    ],
  );
}


//请求方法
Future request(city_type)async{
  Response response;
  response=await cityRequest(city_type);
  return response;
}