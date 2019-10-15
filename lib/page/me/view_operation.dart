import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/me.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/service_method.dart';

class viewOperation extends StatefulWidget {

  List list;
  int index;
  String id;

  viewOperation({Key key,this.list,this.index,this.id}) : super(key: key);

  _viewOperationState createState() => _viewOperationState();
}

class _viewOperationState extends State<viewOperation> with SingleTickerProviderStateMixin{
  
   //动画控制器
  Animation<double> tween;
  AnimationController controller;

  

   /*初始化状态*/
  initState() {
    super.initState();

    /*创建动画控制类对象*/
    controller = new AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this);

    /*创建补间对象*/
    tween = new Tween(begin: 0.0, end: 1.0)
        .animate(controller)    //返回Animation对象
      ..addListener(() {        //添加监听
        setState(() {
         // print(tween.value);   //打印补间插值
        
      });
    });
    // controller.reverse();       //执行动画
  }
  
  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;
    double height=size.height;

    return Provide<MeProvide>(
      builder: (context,child,val){
        return Container(
          child: Container(
            height: height*0.1,
            width: width,
            margin: EdgeInsets.fromLTRB(width-width*controller.value, 35, 0, 0),
            child:FutureBuilder(
              future: showOperation(controller,context),
              builder: (context,snapshot){
                return ListView(
                  //布局方式----水平布局
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    //空白处点击之后，可以缩进控制页面
                    InkWell(
                      onTap: (){
                        Provide.value<MeProvide>(context).changAgain(0);     //可以再次打开
                        controller.reverse();
                      },
                      child: Container(
                        width: width*0.7,
                        color: Color.fromRGBO(255, 255, 255, 0),
                        child: null
                      ),
                    ),
                   
                    InkWell(
                      onTap: (){
                        Scaffold.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(milliseconds: 1500),
                              content: InkWell(
                                onTap: (){
                                  print('取消删除');
                                  Provide.value<MeProvide>(context).changAgain(0);
                                  controller.reverse();
                                },
                                child: Text('取消'),
                              ),
                              action: SnackBarAction(
                                label: '确定',
                                onPressed: (){
                                    Future<String> userToken = get();
                                    userToken.then((String userToken)async{
                                      print(widget.id);
                                      deleteListView(userToken,widget.id);
                                    });
                                    widget.list.removeAt(widget.index);
                                    Provide.value<MeProvide>(context).changAgain(0);
                                    controller.reverse();
                                },
                              ),
                            )
                          );
                      },
                      child: Container(
                        width: width*0.3,
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            '删除',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        );
      });
  }
}

Future showOperation(controller,context){
  if(Provide.value<MeProvide>(context).openAgain==1){                
    controller.forward();
  }
}

Future<String> get() async {
  var userToken;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = await prefs.getString('userToken');
  return userToken;
}