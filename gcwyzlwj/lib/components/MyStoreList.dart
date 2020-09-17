import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyPullLoad.dart';

class MyStoreList extends StatefulWidget {
  final Map data;
  final Function itemBuilder;
  final Function getMore;
  final  first;

  MyStoreList({Key key, @required this.data, @required this.getMore, @required this.itemBuilder, this.first}) : super(key: key);

  @override
  _MyStoreListState createState() => _MyStoreListState();
}

class _MyStoreListState extends State<MyStoreList> {
  ScrollController _controller = ScrollController();
  bool bBtn=true;

  @override
  void initState() { 
    super.initState();
    this.getMore();
  }

  getMore(){
    // if(widget.data["total"] == widget.data["list"].length) {
    //   setState(() {
    //     this.bBtn=false;
    //   });
    // }
    _controller.addListener((){
      if(_controller.position.pixels == _controller.position.maxScrollExtent){
        
        if(widget.data["total"] <= widget.data["list"].length) {
          setState(() {
            this.bBtn=false;
          });
          return;
        }
        widget.getMore(widget.data["current"]+1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
       child: RefreshIndicator( 
          onRefresh: () async {
            widget.getMore(1);
          },
          child: ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _controller,
              itemBuilder: (BuildContext context, int index){
                if(index == widget.data["list"].length+(widget.first != null?1:0)){
                  
                  return MyPullLoad(dataList: widget.data["list"], bBtn: widget.data["total"] == widget.data["list"].length);
                }
                
                if(widget.first != null && index==0){
                  return widget.first;
                }else{
                  return widget.itemBuilder(index);
                }
                
              },
              separatorBuilder: (BuildContext context, int index){
                return Container(height: 5.0, color: Color(0xFFdddddd),);
              },
              itemCount: widget.data["list"].length+(widget.first != null?2:1)
          ),  
        ),
    );
  }
}