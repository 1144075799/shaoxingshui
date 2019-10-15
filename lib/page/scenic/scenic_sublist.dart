import 'package:flutter/material.dart';
import '../../routers/application.dart';


class scenicSubList extends StatefulWidget {

  List subViewList;

  scenicSubList({Key key,this.subViewList}) : super(key: key);

  _scenicSubListState createState() => _scenicSubListState();
}

class _scenicSubListState extends State<scenicSubList> with SingleTickerProviderStateMixin {

  //动画控制器
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
         
      });
    });

    controller.forward();       //执行动画
    
  }

  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高

    

    return Positioned(
      bottom: 0,
      child: Container(
        height: height*0.4*controller.value,
        width: width,
        color: Colors.white,
        child: ListView(
          shrinkWrap: true, 								//解决无限高度问题
		      physics: new NeverScrollableScrollPhysics(),		//禁用滑动事件
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: width*0.01),
              child: Text(
                '猜你喜欢',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
            Container(
              height: height*0.3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.subViewList.length,
                itemBuilder: (contexy,index){
                  return InkWell(
                    onTap: (){
                      // print('${widget.subViewList[index]["id"]}');
                      String id=widget.subViewList[index]["id"].toString();
                      Application.router.navigateTo(context, "/scenicSub?id=${id}");
                    },
                    child: Container(
                      margin: EdgeInsets.all(width*0.01),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: width*0.4,
                            height: height*0.2,
                            child: Image.network('${widget.subViewList[index]["pic_url"][0]["picUrl"]}'),
                          ),
                          Center(
                            child: Text(
                              '${widget.subViewList[index]["title"]}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        )
      ),
    );
  }
}