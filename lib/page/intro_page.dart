import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import '../routers/application.dart';


class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset('images/intro.png',fit: BoxFit.cover,)
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conutDown();
  }

  void conutDown(){     								//倒计时
    var _duration=Duration(seconds: 3);
    Future.delayed(_duration,newPage);					//跳转到新的页面中
  }

  void newPage(){
    Application.router.navigateTo(context, "/reg",replace: true);
  }
}
