import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyPullLoad.dart';
import 'package:gcyzzlwj/utils/http.dart';

class MyList extends StatefulWidget {
  final itemBuilder;
  final url;
  final Map<String, dynamic> params;
  MyList({Key key, @required this.url, @required this.itemBuilder, this.params}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  ScrollController _scrollController = ScrollController(); 
  int _current = 1;
  bool bBtn = true;
  Map info;

  @override
  void initState() { 
    super.initState();
    this.initial(_current);
    this.getMore();
  }

  initial(current, {callback}) async {
    var params = {"current":current};
    if(widget.params != null){
      params.addAll(widget.params);
    }
    var data = await NetHttp.request(widget.url, context, params:params);
    if(data != null){
      setState(() {
        if(current>1 && this.info != null){
          data["list"].insertAll(0, info["list"]);
        }
        this.info = data;
      });
    }
  }

  getMore() async {
    
    _scrollController.addListener((){
      
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        if(this.info["list"].length >= this.info["total"]) {
          return;
        }
        this._current +=1;
        
        this.initial(this._current);
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.info==null?Container()
    :RefreshIndicator(
      onRefresh: ()async{
        // this.info["list"].clear();
        this.initial(1);
        setState(() {
          this._current = 1;
        });
        return null;
      },
      child: ListView.separated(
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index){
          if(index == this.info["list"].length){
            return MyPullLoad(data: this.info);
          }
          return widget.itemBuilder( this.info["list"], index);
        }, 
        separatorBuilder: (context, index){
          return Container(height: 1.0, color: Color(0xFFeeeeee));
        }, 
        itemCount: this.info["list"].length+1,
        controller: _scrollController,
      ),
    );
  }
}