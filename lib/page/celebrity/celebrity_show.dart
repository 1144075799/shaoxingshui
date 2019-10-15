import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../service/service_method.dart';
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io';
import '../../routers/application.dart';
import 'package:provide/provide.dart';
import '../../provide/btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class celebrityShow extends StatefulWidget {

  String id;

  celebrityShow({Key key,this.id}) : super(key: key);

  _celebrityShowState createState() => _celebrityShowState();
}

enum TtsState { playing, stopped }

class _celebrityShowState extends State<celebrityShow> {

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


    return Scaffold(
      body: FutureBuilder(
        future: _celebrityShow(widget.id,context),
        builder: (context,snapshot){
          if(snapshot.hasData){
            
            var data=json.decode(snapshot.data.toString());
            var celebrityData=data['data'];
            String title=celebrityData[0]['title'];
            String file_content=celebrityData[0]['file_content'];
            String pic_url=celebrityData[0]['pic_url'];

            _newVoiceText=file_content;           //获取文本信息

            return Provide<BtnProvide>(
              builder: (context,child,val){
                
                return Stack(
                  children: <Widget>[
                    GestureDetector(

                      onTap: (){
                        Application.router.pop(context);
                      },

                      child: Container(
                        width: width*0.9,
                        height: height,
                        margin: EdgeInsets.fromLTRB(width*0.05, height*0.1, 0, height*0.1),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                            border:Border.all(
                              color: Colors.black12
                            )
                          ),
                        child: ListView(
                          shrinkWrap: true, 								//解决无限高度问题
                          physics: new NeverScrollableScrollPhysics(),		//禁用滑动事件
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: height*0.05),
                              child: Center(
                                child: Text(
                                  '${title}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: height*0.025),
                              height: height*0.7,
                              child: ListView(
                                children: <Widget>[
                                  Text('${file_content}')
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: height*0.1,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: width*0.7,
                              child: btnSection(),
                            ),
                            Container(
                              width: width*0.3,
                              child: InkWell(
                                onTap: (){
                                  Future<String> userToken = get();
                                  userToken.then((String userToken)async{
                                    print(userToken);
                                    print(widget.id);
                                    print(title);
                                    print(pic_url);
                                    Response response;
                                    response=await likeFamousRequest(userToken,widget.id,title,pic_url);
                                    int code=response.data['code'];
                                    if(code==1){
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('成功关注该名人'),
                                        )
                                      );
                                    }else{
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('已经关注过该名人'),
                                        )
                                      );
                                    }
                                  });
                                },
                                child: Center(
                                  child: Icon(Icons.favorite),
                                )
                              ),
                            )
                          ],
                        )
                      ),
                    )
                  ],
                );
              });
          }else{
            return Container(
              child: Center(
                child: Text('数据加载中'),
              ),
            );
          }
        }
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

Future _celebrityShow(id,context) async {
  Response response;
  Provide.value<BtnProvide>(context).changeOff(0);
  response=await celebrityShowRequest(id);
  return response;
}

Future<String> get() async {
  var userToken;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken = await prefs.getString('userToken');
  return userToken;
}



  
