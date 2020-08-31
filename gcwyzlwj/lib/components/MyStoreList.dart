import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyPullLoad.dart';

class MyStoreList extends StatefulWidget {
  final Map data;
  final Function itemBuilder;
  final Function getMore;

  MyStoreList({Key key, @required this.data, @required this.getMore, @required this.itemBuilder}) : super(key: key);

  @override
  _MyStoreListState createState() => _MyStoreListState();
}

class _MyStoreListState extends State<MyStoreList> {
  ScrollController _controller = ScrollController();
  int _current=1;
  bool bBtn=true;

  @override
  void initState() { 
    super.initState();
    this.getMore();
  }

  getMore(){
    if(widget.data["total"] == widget.data["list"].length) {
      setState(() {
        this.bBtn=false;
      });
      return;
    }
    _controller.addListener((){
      if(this.bBtn && _controller.position.pixels == _controller.position.maxScrollExtent){
        if(widget.data["total"] == widget.data["list"].length) {
          setState(() {
            this.bBtn=false;
          });
          return;
        }
        this._current += 1;
        widget.getMore(this._current);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: ListView.separated(
         controller: _controller,
          itemBuilder: (BuildContext context, int index){
            if(index == widget.data["list"].length){
              return MyPullLoad(dataList: widget.data["list"], bBtn: this.bBtn);
            }
            return widget.itemBuilder(index);
          },
          separatorBuilder: (BuildContext context, int index){
            return Container(height: 5.0, color: Color(0xFFdddddd),);
          },
          itemCount: widget.data["list"].length+1
       ),
    );
  }
}