import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drag_scale/flutter_drag_scale.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';


class MyShowImage extends StatefulWidget {
  final arguments;
  MyShowImage({Key key, this.arguments}) : super(key: key);

  @override
  _MyShowImageState createState() => _MyShowImageState();
}

class _MyShowImageState extends State<MyShowImage> {
  int w;
  int h;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getImgInfo();
  }

  getImgInfo(){
    Image image = Image.network(widget.arguments["img"] ?? '');
    Completer<ui.Image> completer = new Completer<ui.Image>();
    image.image.resolve(ImageConfiguration()).addListener( ImageStreamListener( 
      ( ImageInfo info, bool _ ){
        print(info.image.height);
        setState(() {
          this.w = info.image.width;
          this.h = info.image.height;
        });
      }
     ) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "查看大图",
      ),
      body: MyScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.width/this.w*this.h,
          child: DragScaleContainer(
            doubleTapStillScale: true,
            child: Image.network(widget.arguments["img"], width: double.infinity, fit: BoxFit.fill,),
          ),
          
        ),
      )
    );
  }
}