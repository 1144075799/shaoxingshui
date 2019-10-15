import 'dart:ui';
import '../../routers/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class CityPage extends StatelessWidget {
  const CityPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高

    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('绍兴说'),),
        body: ListView(
          children: <Widget>[
            _choose_model('古城',2,1,context,width,height),
            Divider(),
            _choose_model('水城',1,2,context,width,height),
            Divider(),
            _choose_model('名城',3,3,context,width,height)
          ],
        )
      )
    );
  }

  Widget _choose_model(hint,imgUrl,index,context,width,height){
    return Container(
      height: height*0.35,
      child: Stack(
        children: <Widget>[
          ConstrainedBox(                                     //约束盒子组件，添加额外的限制条件到 child上。
              constraints: const BoxConstraints.expand(),       //限制条件，可扩展的。
              child: Image.asset('images/city${imgUrl}.jpg'),           //背景图片
          ),
          showhint(hint,index,context,imgUrl,width,height)
        ],
      ),
    );
  }

  //导航的提示
  Widget showhint(hint,index,context,imgUrl,width,height){
    return Container(
      width: width,
      height: height*0.45,
      color: Color.fromRGBO(255, 255, 255, 0.8),
      //decoration: BoxDecoration(color: Colors.grey),
      child: Center(
        child: InkWell(
          onTap: (){
            int city_index=index-1;
            Application.router.navigateTo(context, "/city?message=$city_index&image_url=$imgUrl");
          },
          child:Center(
            child: Text(
              '${hint}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Colors.black
              ),
            ),
          )
        )
      ),
    );
  }
}