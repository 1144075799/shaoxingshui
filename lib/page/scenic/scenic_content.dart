import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../routers/application.dart';


class scenicContent extends StatefulWidget {
  String title;
  List image_url;
  String fileContent;
  int id;

  scenicContent({Key key,this.title,this.image_url,this.fileContent,this.id}) : super(key: key);

  _scenicContentState createState() => _scenicContentState();
}

class _scenicContentState extends State<scenicContent> {
  
  @override
  Widget build(BuildContext context) {

    final size=MediaQuery.of(context).size;
    double width=size.width;                    //获取设备的宽
    double height=size.height;                  //获取设备的高
    
    return Scaffold(
      body:  Container(
          height: height*0.9,
          width: width*0.9,
          margin: EdgeInsets.fromLTRB(width*0.05, height*0.05, width*0.05, 0),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
            border:Border.all(
              color: Colors.black12
            )
          ),
          child: GestureDetector(

            onTap: (){
              String id=widget.id.toString();
              Application.router.navigateTo(context, "/scenicPar?id=${id}");
              // print(widget.id);
            },

            child: Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: height*0.02),
                  height: height*0.3,
                  width: width,
                  child:Image.network("${widget.image_url[0]['picUrl']}",fit: BoxFit.fill,)
                ),
                Container(
                  margin: EdgeInsets.only(top: height*0.01),
                  child: Center(
                    child: Text(
                      '${widget.title}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20
                      ),
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.only(top: height*0.01),
                  child: Center(
                    child: Text(
                      '景区概况',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(width*0.1, height*0.01, width*0.1, 0),
                  child:Center(
                        child: Text(
                          '${widget.fileContent}',
                          overflow:TextOverflow.ellipsis,
                          maxLines: 10,
                        ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, height*0.02, width*0.04, 0),
                  alignment: Alignment.topRight,
                  child: Text(
                    '点击查看详情',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12
                    ),
                  ),
                )
              ],
            ),
          )
        ),
    );
  }
}

