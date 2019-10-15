import 'package:fluro/fluro.dart';
import '../page/city/city_content.dart';
import '../page/index_page.dart';
import '../page/scenic/scenic_show.dart';
import '../page/login/register.dart';
import '../page/login/login.dart';
import '../page/celebrity/celebrity_show.dart';
import '../page/scenic/scenic_sub.dart';
import '../page/me/love_view.dart';
import '../page/me/setting.dart';
import '../page/me/love_famous.dart';
import '../page/me/setting_name.dart';
import '../page/me/setting_sgin.dart';



Handler rootHandler=Handler(                             //控制器
  handlerFunc: (context,params)=>HomePage(),
);  

Handler registerHandler=Handler(                             //控制器
  handlerFunc: (context,params)=>registerPage(),
);  

Handler loginHandler=Handler(                             //控制器
  handlerFunc: (context,params)=>loginPage(),
);  


Handler cityHandler=Handler(                             //控制器
  handlerFunc: (context,Map<String,List<String>> params){
    String city_type=params['message'].first;
    String image_url=params['image_url'].first;
    return cityContent(city_type:city_type,image_url:image_url);
  }
);

Handler scenicParRootHandler=Handler(                             //控制器
  handlerFunc: (context,Map<String,List<String>> params){
    String id=params['id'].first;
    return scenicShow(id:id);
  }
); 

Handler scenicSubHandler=Handler(                             //控制器
  handlerFunc: (context,Map<String,List<String>> params){
    String id=params['id'].first;
    return scenicSub(id:id);
  }
); 

Handler celebrityHandler=Handler(                             //控制器
  handlerFunc: (context,Map<String,List<String>> params){
    String id=params['id'].first;
    return celebrityShow(id:id);
  }
); 

Handler loveViewHandler=Handler(                             //控制器
  handlerFunc: (context,Map<String,List<String>> params){
    String userToken=params['userToken'].first;
    return loveView(userToken:userToken);
  }
); 

Handler loveFamousHandler=Handler(                             //控制器
  handlerFunc: (context,Map<String,List<String>> params){
    String userToken=params['userToken'].first;
    return loveFamous(userToken:userToken);
  }
);

Handler settingHandler=Handler(                             //控制器
  handlerFunc: (context,Map<String,List<String>> params){
    // String userToken=params['userToken'].first;
    return settingPage();
  }
); 

Handler setNameHandler=Handler(                             //控制器
  handlerFunc: (context,Map<String,List<String>> params){
    return settingName();
  }
); 

Handler setSginHandler=Handler(                             //控制器
  handlerFunc: (context,Map<String,List<String>> params){
    return settingSgin();
  }
); 



  








