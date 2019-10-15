import 'package:flutter/material.dart';
import './city/city_page.dart';
import './me/me.dart';
import './scenic/scenic_view.dart';
import './celebrity/celebrity.dart';


class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon:Container(
        height: 30,
        child: Image.asset('images/first.png'),
      ),
      activeIcon: Container(
        height: 30,
        child: Image.asset('images/first_act.png'),
      ),
      title: Text('名城')
    ),
    BottomNavigationBarItem(
      icon:Container(
        height: 30,
        child: Image.asset('images/second.png'),
      ),
      activeIcon: Container(
        height: 30,
        child: Image.asset('images/second_act.png'),
      ),
      title: Text('名人')
    ),
    BottomNavigationBarItem(
      icon:Container(
        height: 30,
        child: Image.asset('images/third.png'),
      ),
      activeIcon: Container(
        height: 30,
        child: Image.asset('images/third_act.png'),
      ),
      title: Text('景区')
    ),
    BottomNavigationBarItem(
      icon:Container(
        height: 30,
        child: Image.asset('images/fourth.png'),
      ),
      activeIcon: Container(
        height: 30,
        child: Image.asset('images/fourth_act.png'),
      ),
      title: Text('我的')
    ),
  ];

  
  //导入页面
  final List tabBodies = [
    CityPage(),
    celebrity(),
    scenicPage(),
    mePage()
  ];

  //定义索引 当前页面的选项
  int currentIndex= 0;
  var currentPage ;

  //初始化
  @override
  void initState() {
   currentPage=tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;
    double height=size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,                   //获取当前索引
        currentIndex: currentIndex,                           //导入底部导航
        items:bottomTabs,                                     //实现点击切换
        onTap: (index){
          setState(() {
           currentIndex=index;
           currentPage =tabBodies[currentIndex]; 
          });
        },
      ),
      body: currentPage,
    );
  }
}