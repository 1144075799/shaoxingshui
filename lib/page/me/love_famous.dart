import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../routers/application.dart';
import '../../service/service_method.dart';
import 'package:provide/provide.dart';
import '../../provide/me.dart';
import './famous_operation.dart';
import 'package:left_scroll_actions/left_scroll_actions.dart';

class loveFamous extends StatefulWidget {

  String userToken;

  loveFamous({Key key,this.userToken}) : super(key: key);

  _loveFamousState createState() => _loveFamousState();
}

class _loveFamousState extends State<loveFamous> {
  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高

    return FutureBuilder(
      future: getLoveFamous(widget.userToken),
      builder: (context,snapshot){
        if(snapshot.hasData){
          var data=json.decode(snapshot.data.toString());
          var loveData=data['data']; 
          List famousList=(loveData as List).cast();
          print(famousList);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade300,
              title: Text('关注的名人'),
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
                  itemCount: famousList.length,
                  itemBuilder: (context,index){
                    return _item(famousList,index,context,height,width);
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


Future getLoveFamous(token)async{
  Response response;
  response=await getListFamous(token);
  return response;
}

Widget _item(List famousList,index,context,height,width){
  return Container(
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
                  height: height*0.15,
                  child: Image.network(famousList[index]['pictureUrl'],fit: BoxFit.fill,),
                ),
                Container(
                  margin: EdgeInsets.only(left:  width*0.1),
                  child: Center(
                    child: Text(
                      famousList[index]['famousTitile'],
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
                          String id=famousList[index]['id'].toString();
                          userToken.then((String userToken)async{
                            deleteListFamous(userToken,id);
                          });
                          famousList.removeAt(index);
                          Provide.value<MeProvide>(context).refresh();
                      },
                    ),
                  )
                );
              },
            ),
          ],
          onTap: (){
            String id=famousList[index]['famousId'].toString();
            Application.router.navigateTo(context, "/cele?id=${id}");
          },
        ),
        
        Divider()
      ],
    )
  );
}
