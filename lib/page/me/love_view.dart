import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../service/service_method.dart';
import 'dart:convert';
import '../../routers/application.dart';
import 'package:provide/provide.dart';
import '../../provide/me.dart';
import './view_operation.dart';
import 'package:left_scroll_actions/left_scroll_actions.dart';


class loveView extends StatefulWidget {

  String userToken;

  loveView({Key key,this.userToken}) : super(key: key);

  _loveViewState createState() => _loveViewState();
}

class _loveViewState extends State<loveView> {
  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高

    return FutureBuilder(
      future: getLoveView(widget.userToken),
      builder: (context,snapshot){
        if(snapshot.hasData){
          var data=json.decode(snapshot.data.toString());
          var loveData=data['data']; 
          List loveList=(loveData as List).cast();
          print(loveList);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade300,
              title: Text('关注的景点'),
              leading:InkWell(
                onTap: (){
                  Application.router.pop(context);
                },
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Provide<MeProvide>(
            builder: (context,child,val){
              return Container(
              height: height,
              child: ListView.builder(
                itemCount: loveList.length,
                itemBuilder: (context,index){
                  return item(loveList,index,height,width,context);
                  },
                )
              );
            }),
            
          );
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


Widget item(loveList,index,height,width,context){
  return Container(
      margin: EdgeInsets.only(top: height*0.01),
      height: height*0.2,
      child: Column(
        children: <Widget>[
          LeftScroll(
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    width: width*0.4,
                    child: Image.network(loveList[index]['pictureUrl'],fit: BoxFit.fill,),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: width*0.1),
                    child: Center(
                      child: Text(
                        loveList[index]['viewTitile'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:20 
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            buttons: <Widget>[
              LeftScrollItem(
                text: '删除',
                color: Colors.red,
                onTap: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 1500),
                      content: InkWell(
                        onTap: (){
                          print('取消删除');
                        },
                        child: Text('取消'),
                      ),
                      action: SnackBarAction(
                        label: '确定',
                        onPressed: (){
                            Future<String> userToken = get();
                            String id=loveList[index]['id'].toString();
                            userToken.then((String userToken)async{
                              deleteListView(userToken,id);
                            });
                           loveList.removeAt(index);
                           Provide.value<MeProvide>(context).refresh();
                        },
                      ),
                    )
                  );
                },
              ),
            ],
            onTap: (){
               String id=loveList[index]['viewId'].toString();
               Application.router.navigateTo(context, "/scenicPar?id=${id}");
            },
          ),
          
          Divider()
        ],
      )
    );
}

Future getLoveView(token)async{
  Response response;
  response=await getListView(token);
  return response;
}

//控制操作区域是否打开
Widget operationArea(context,index,loveList){
  String id=loveList[index]['id'].toString();
  if(Provide.value<MeProvide>(context).operationArea==index){
    return viewOperation(list:loveList,index:index,id:id);
  }else{
    return Container(
      child: null,
    );
  }
}