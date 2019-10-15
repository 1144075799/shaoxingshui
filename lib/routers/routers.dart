import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';


//总配置
class Routes{
  static String root='/';                             //根目录
  static String register='/reg';                      //登录路由
  static String login='/log';                         //注册路由
  static String cityRoot='/city';                     //城市路由
  static String scenicParRoot='/scenicPar';           //父景点
  static String scenicSub='/scenicSub';               //子景点
  static String celebrity='/cele';                    //名人
  static String loveView='/love_view';                //关注的景区
  static String loveFamous='/love_famous';            //关注的名人
  static String setting='/set';                       //设置
  static String setName='/set_name';                   //修改名字
  static String setSgin='/set_sgin';                   //修改名字



  static void configureRoutes(Router router){
    router.notFoundHandler=new Handler(                                   //找不到路由的时候
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('ERROR======>ROUTE WAS NOT FOUND!!!!');
      }
    );

    //配置路由
    router.define(root,handler: rootHandler);
    router.define(cityRoot,handler: cityHandler);
    router.define(register,handler: registerHandler);
    router.define(login,handler: loginHandler);
    router.define(scenicParRoot,handler: scenicParRootHandler);
    router.define(celebrity,handler: celebrityHandler);
    router.define(scenicSub,handler: scenicSubHandler);
    router.define(loveView,handler: loveViewHandler);
    router.define(loveFamous,handler: loveFamousHandler);
    router.define(setting,handler: settingHandler);
    router.define(setName,handler: setNameHandler);
    router.define(setSgin,handler: setSginHandler);
    

  }

}