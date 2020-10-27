import 'package:flutter/material.dart';

class MySimpleStoreList extends StatefulWidget {
  final Function getRefresh;
  final params;
  final List data;
  final Function itemBuilder;

  MySimpleStoreList({Key key, @required this.getRefresh, @required this.data, @required this.itemBuilder,
  this.params}) : super(key: key);

  @override
  _MySimpleStoreListState createState() => _MySimpleStoreListState();
}

class _MySimpleStoreListState extends State<MySimpleStoreList> {
  ScrollController _controller = ScrollController();


  @override
  Widget build(BuildContext context) {
    return widget.data==null? Container()
      :Container(
       child: RefreshIndicator( 
          onRefresh: () async {
            widget.getRefresh();
          },
          child: ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _controller,
              itemBuilder: (BuildContext context, int index){
                
                return widget.itemBuilder(index);
                
              },
              separatorBuilder: (BuildContext context, int index){
                return Container(height: 5.0, color: Color(0xFFdddddd),);
              },
              itemCount: widget.data.length
          ),  
        ),
    );
  }
}