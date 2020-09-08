import 'package:flutter/material.dart';
import 'package:timeline/model/timeline_model.dart';
import 'package:timeline/timeline.dart';

class MyTimeLine extends StatelessWidget {
  List<Map> list = [];
  double heigth;
  MyTimeLine({Key key,@required this.list, this.heigth}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.heigth??150.0,
      child: Stack(
        children: <Widget>[
          TimelineComponent(
              timelineList: list.map((f){
                return TimelineModel(
                    description: f["des"],
                    title: f["title"]
                  );
                }).toList(),
              )
        ],
      ),
    );
  }
}