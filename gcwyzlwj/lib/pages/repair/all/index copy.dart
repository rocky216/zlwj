import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyTabBarHeader.dart';

class AllRepair extends StatefulWidget {
  AllRepair({Key key}) : super(key: key);

  @override
  _AllRepairState createState() => _AllRepairState();
}

class _AllRepairState extends State<AllRepair> with TickerProviderStateMixin{
  TabController _controller;

  @override
  void initState() { 
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    _controller.addListener((){
      if(_controller.index == 1 && _controller.indexIsChanging){
        print(1212);
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyTabBarHeader(
          controller: _controller,
          title: Text("data", style: TextStyle(color: Color(0xFF666666), fontSize: 16.0),), 
          tabs:[
            Tab(
              text: "热门",
            ),
            Tab(
              text: "推荐",
            ),
            Tab(
              text: "推荐",
            ),
          ],
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            Container(
              child: ListView.separated(itemBuilder: (context, index){
                return Text("asa");
              }, separatorBuilder: (context, index){
                return Container(height: 2.0,);
              }, itemCount: 3),
            ),
            Center(child: Text('自行车')),
            Center(child: Text('自行车1')),
          ]),
      );
  }
}