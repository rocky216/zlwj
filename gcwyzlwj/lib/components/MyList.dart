import 'package:flutter/material.dart';
import 'package:gcwyzlwj/utils/http.dart';
import './MyPullLoad.dart';

class MyList extends StatefulWidget {
  final itemBuilder;
  final url;
  final Map<String, dynamic> params;
  MyList({Key key, this.itemBuilder, this.url, this.params}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  ScrollController _scrollController = ScrollController(); 
  int _current = 1;
  bool bBtn = true;
  List dataList = [];
  int sumPage = 1;

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
      if(callback!=null){
        callback();
      }
      setState(() {
        this.dataList.addAll(data["list"]);
        if(this.sumPage == data["sumPage"]){
          this.bBtn = false;
        }else{
          this.sumPage = data["sumPage"];
        }
        
        
      });
    }
  }

  getMore() async {
    
    _scrollController.addListener((){
      
      if(this.bBtn==true && _scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        if(this.sumPage == this._current) {
          setState(() {
            this.bBtn=false;
          });
          return;
        }
        this._current +=1;
        
        this.initial(this._current, callback: (){
          this.bBtn=true;
        });
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        print("object");
        this.dataList.clear();
        this._current = 1;
        this.initial(this._current);
        setState(() {
          this._current = 1;
          this.bBtn = true;
        });
        return null;
      },
      child: ListView.separated(
        itemBuilder: (context, index){
          if(index == this.dataList.length){
            return MyPullLoad(dataList: this.dataList, bBtn: this.bBtn);
          }
          return widget.itemBuilder( this.dataList, index);
        }, 
        separatorBuilder: (context, index){
            return Container(height: 1.0, color: Color(0xFFeeeeee));
        }, 
        itemCount: this.dataList.length+1,
        controller: _scrollController,
      ),
    );
  }
}