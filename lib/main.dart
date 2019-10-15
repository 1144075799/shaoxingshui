import 'package:flutter/material.dart';
import './page/intro_page.dart';
import 'package:flutter/services.dart';
import './routers/routers.dart';
import './routers/application.dart';
import 'package:fluro/fluro.dart';
import 'package:provide/provide.dart';
import './provide/scenic.dart';
import './provide/login.dart';
import './provide/btn.dart';
import './provide/me.dart';


void main(){
  ///
  /// 强制竖屏
  /// 
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  var providers=Providers();
  var scenicProvide=ScenicProvide();
  var loginProvide=LoginProvide();
  var btnProvide=BtnProvide();
  var meProvide=MeProvide();

  providers
  ..provide(Provider<ScenicProvide>.value(scenicProvide))
  ..provide(Provider<ScenicProvide>.value(scenicProvide))
  ..provide(Provider<LoginProvide>.value(loginProvide))
  ..provide(Provider<BtnProvide>.value(btnProvide))
  ..provide(Provider<MeProvide>.value(meProvide))
  ;

  runApp(ProviderNode(child: MyApp(),providers: providers,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

     //配置路由参数
    final router=Router();
    Routes.configureRoutes(router);
    Application.router=router;

    return MaterialApp(
      title: 'SingleScreen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        platform: TargetPlatform.iOS,
        primaryColor: Colors.grey
      ),
      home: IntroPage(),
    );
  }
}
