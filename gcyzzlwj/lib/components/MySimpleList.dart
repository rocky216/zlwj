import 'package:flutter/material.dart';
import 'package:gcyzzlwj/utils/http.dart';

class MySimpleList extends StatefulWidget {
  final params;
  final String url;
  final Function itemBuilder;
  MySimpleList({Key key, this.params, @required this.url, @required this.itemBuilder}) : super(key: key);

  @override
  _MySimpleListState createState() => _MySimpleListState();
}

class _MySimpleListState extends State<MySimpleList> {
  ScrollController _scrollController = ScrollController(); 
  List info;

  @override
  void initState() { 
    super.initState();
    this.initial();
  }

  initial() async {
    var data = await NetHttp.request(widget.url, context, params:widget.params??{});
    if(data != null){
      setState(() {
        this.info = data;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return this.info==null?Container()
      :RefreshIndicator(
        onRefresh: ()async{
          this.info.clear();
          this.initial();
          return null;
        },
        child: ListView.separated(
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return widget.itemBuilder( this.info, index);
          }, 
          separatorBuilder: (context, index){
            return Container(height: 1.0, color: Color(0xFFeeeeee));
          }, 
          itemCount: this.info.length,
          controller: _scrollController,
        ),
      );
    }
}