import 'package:flutter/material.dart';

import '../../routers/application.dart';

const searchList = [
  {"name":"大禹","id":"19"},
  {"name":"欧冶子","id":"20"},
  {"name":"越王勾践","id":"21"},
  {"name":"范蠡","id":"22"},
  {"name":"文种","id":"23"},
  {"name":"西施","id":"24"},
  {"name":"郑吉","id":"25"},
  {"name":"郑弘","id":"26"},
  {"name":"王充","id":"27"},
  {"name":"孟尝","id":"28"},
  {"name":"马臻","id":"29"},
  {"name":"曹娥","id":"30"},
  {"name":"曹娥","id":"31"},
  {"name":"魏伯阳","id":"32"},
  {"name":"赵晔","id":"33"},
  {"name":"谢平","id":"34"},
  {"name":"嵇康","id":"35"},
  {"name":"贺循","id":"36"},
  {"name":"王羲之","id":"37"},
  {"name":"支遁","id":"38"},
  {"name":"谢安","id":"39"},
  {"name":"戴逵","id":"40"},
  {"name":"谢灵运","id":"41"},
  {"name":"慧皎","id":"42"},
  {"name":"贺知章","id":"43"},
  {"name":"秦系","id":"44"},
  {"name":"王叔文","id":"45"},
  {"name":"杜衍","id":"46"},
  {"name":"李光","id":"47"},
  {"name":"陆游","id":"48"},
  {"name":"汪纲","id":"49"},
  {"name":"王冕","id":"50"},
  {"name":"杨维桢","id":"51"},
  {"name":"马欢","id":"52"},
  {"name":"戴琥","id":"53"},
  {"name":"王守仁","id":"54"},
  {"name":"沈炼","id":"55"},
  {"name":"汤绍恩","id":"56"},
  {"name":"徐渭","id":"57"},
  {"name":"姚长子","id":"58"},
  {"name":"张介宾","id":"59"},
  {"name":"朱燮元","id":"60"},
  {"name":"刘光复","id":"61"},
  {"name":"王思任","id":"62"},
  {"name":"刘宗周","id":"63"},
  {"name":"余煌","id":"64"},
  {"name":"倪元璐","id":"65"},
  {"name":"张岱","id":"66"},
  {"name":"陈洪绶","id":"67"},
  {"name":"祁彪佳","id":"68"},
  {"name":"姚启圣","id":"69"},
  {"name":"吴兴祚","id":"70"},
  {"name":"何煟","id":"71"},
  {"name":"章学诚","id":"72"},
  {"name":"葛云飞","id":"73"},
  {"name":"赵之谦","id":"74"},
  {"name":"李慈铭","id":"75"},
  {"name":"平步青","id":"76"},
  {"name":"徐树兰","id":"77"},
  {"name":"任颐","id":"78"},
  {"name":"蔡元培","id":"79"},
  {"name":"杜亚泉","id":"80"},
  {"name":"徐锡麟","id":"81"},
  {"name":"秋瑾","id":"82"},
  {"name":"陶成章","id":"83"},
  {"name":"陈半丁","id":"84"},
  {"name":"蔡东藩","id":"85"},
  {"name":"经亨颐","id":"86"},
  {"name":"刘大白","id":"87"},
  {"name":"鲁迅","id":"88"},
  {"name":"邵力子","id":"89"},
  {"name":"马寅初","id":"90"},
  {"name":"许寿裳","id":"91"},
  {"name":"马一浮","id":"92"},
  {"name":"陈仪","id":"93"},
  {"name":"马叙伦","id":"94"},
  {"name":"夏丏尊","id":"95"},
  {"name":"章锡琛","id":"96"},
  {"name":"竺可桢","id":"97"},
  {"name":"陈鹤琴","id":"98"},
  {"name":"范文澜","id":"99"},
  {"name":"陈建功","id":"100"},
  {"name":"孙越崎","id":"101"},
  {"name":"胡愈之","id":"102"},
  {"name":"吴觉农","id":"103"},
  {"name":"朱自清","id":"104"},
  {"name":"周恩来","id":"105"},
  {"name":"王一飞","id":"106"},
  {"name":"俞秀松","id":"107"},
  {"name":"梁柏台","id":"108"},
  {"name":"任光","id":"109"},
  {"name":"俞大绂","id":"110"},
  {"name":"赵忠尧","id":"111"},
  {"name":"柯灵","id":"112"},
  {"name":"董希文","id":"113"},
  
];

const recentSuggest = [];
class searchBarDelegate extends SearchDelegate<String>{
  //初始化加载
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: ()=>query="",
      )
    ];
  }
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: ()=>close(context, null),
    );
  }
  @override
  Widget buildResults(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double height=size.height;
    double width=size.width;

    return Container(
      width: width*0.2,
      height: height*0.1,
      child: Card(
        color: Colors.grey,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {

  

      final suggestionList = query.isEmpty
            ? recentSuggest
            : searchList.where((input) => input["name"].contains(query)).toList();

      return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context,index) => ListTile(
          title: InkWell(
            onTap: (){
              String id=suggestionList[index]['id'];
              Application.router.navigateTo(context, "/cele?id=${id}");
            },
            child: RichText(
              text: TextSpan(
                text: suggestionList[index]["name"].substring(0, query.length),
                style: TextStyle(
                    color:  Colors.grey),
                children:[
                  TextSpan(
                    text: suggestionList[index]["name"].substring(query.length),
                    style: TextStyle(
                      color: Colors.grey
                    )
                  )
                ]
              )
          ),
          )
        ),
      );
    
    
    
  }
}


// Future fuzzy_request(name)async{
//   Response response;
//   response=await fuzzyQuery(name);
//   return response;
// }


              