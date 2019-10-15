import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:provide/provide.dart';
import '../../provide/scenic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../service/service_method.dart';

class scenicBtn extends StatefulWidget {

  String title;
  List subViewList;
  String fileContent;
  int id;
  String image_url;

  scenicBtn({Key key,this.title,this.subViewList,this.fileContent,this.id,this.image_url}) : super(key: key);

  _scenicBtnState createState() => _scenicBtnState();
}

enum TtsState { playing, stopped }

class _scenicBtnState extends State<scenicBtn> {

  //语音报告的参数
  FlutterTts flutterTts;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;

  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;


 


  @override
  void initState() { 
    super.initState();
    initTts();

    
  }
  
  initTts() {
    flutterTts = FlutterTts();

    if (Platform.isAndroid) {
      flutterTts.ttsInitHandler(() {
        _getLanguages();
        _getVoices();
      });
    } else if (Platform.isIOS) {
      _getLanguages();
      _getVoices();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }


  Future _getVoices() async {
    voices = await flutterTts.getVoices;
    if (voices != null) setState(() => voices);
  }

  Future _speak() async {
    var result = await flutterTts.speak(_newVoiceText);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高
    _newVoiceText=widget.fileContent;           //获取文本信息
    int id=widget.id;
    String image_url=widget.image_url;
    String title=widget.title;


    return  Positioned(
      bottom: 0,
      child: Container(
        height: height*0.1,
        width: width,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: width*0.05),
              width: width*0.15,
              child:isSub(widget.subViewList.length,context,width),
              
            ),
            Container(
              width: width*0.4,
              child: btnSection(),
            ),
            Container(
              width: width*0.15,
              child: InkWell(
                onTap: (){
                  _launchURL(widget.title);
                },
                child: Icon(Icons.place,size: 30,),
              )
            ),
            Container(
              width: width*0.2,
              child: InkWell(
                onTap: (){
                  Future<String> userToken = get();
                  userToken.then((String userToken)async{
                    print(userToken);
                    print(id);
                    print(title);
                    print(image_url);
                    Response response;
                    response=await likeViewRequest(userToken,id,title,image_url);
                    int code=response.data['code'];
                    if(code==1){
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('成功关注该景区'),
                        )
                      );
                    }else{
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('已经关注过该景区'),
                        )
                      );
                    }
                  });
                  
                },
                child: Icon(Icons.favorite),
              ),
            )
          ],
        ),
      ),
    );
  }
   Widget btnSection() => Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _buildButtonColumn(
            Colors.black, Icons.volume_up, _speak),
        _buildButtonColumn(
            Colors.black, Icons.volume_off,  _stop)
      ]
    )
  );

  Column _buildButtonColumn(Color color, IconData icon, Function func) {
      return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(icon,size: 30),
            color: color,
            onPressed: () => func()
        ),
      ]
    );
  }
  
}

_launchURL(title) async {
  String url = 'androidamap://keywordNavi?sourceApplication=softname&keyword=$title&style=2';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget isSub(length,context,width){
  if(length==0){
    return Container(
      child: null,
    );
  }else{
    return InkWell(
      onTap: (){
        Provide.value<ScenicProvide>(context).changeShow(1);
      },
      child: Image.asset('images/view.png',width: width*0.01,)
    );
  }
}

Future<String> get() async {
  var userToken;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = await prefs.getString('userToken');
  return userToken;
}
