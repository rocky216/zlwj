import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyTabBarHeader.dart';
import 'package:gcwyzlwj/pages/repair/all/torepair.dart';
import 'package:gcwyzlwj/redux/export.dart';

class AllRepair extends StatefulWidget implements AutomaticKeepAliveClientMixin{
  AllRepair({Key key}) : super(key: key);

  @override
  _AllRepairState createState() => _AllRepairState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  @override
  // TODO: implement context
  BuildContext get context => null;

  @override
  void deactivate() {
    // TODO: implement deactivate
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  }

  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  // TODO: implement mounted
  bool get mounted => null;

  @override
  void reassemble() {
    // TODO: implement reassemble
  }

  @override
  void setState(fn) {
    // TODO: implement setState
  }

  @override
  void updateKeepAlive() {
    // TODO: implement updateKeepAlive
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  // TODO: implement widget
  StatefulWidget get widget => null;
}

class _AllRepairState extends State<AllRepair> with TickerProviderStateMixin{
  TabController _controller;

  @override
  void initState() { 
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    _controller.addListener((){
      
      if(_controller.index == 0 ){
        initial(1);
      }else if(_controller.index == 1 ){
        initial(1, type: "processing");
      }else if(_controller.index == 2 ){
        initial(1, type: "already");
      }
    });
  }

  initial(current, {type="pending"}){
    StoreProvider.of<IndexState>(context).dispatch( getToRepair(context, params: {
      "current": current,
      "type": type
    }));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyTabBarHeader(
          controller: _controller,
          title: Text("全部报修", style: TextStyle(color: Color(0xFF666666), fontSize: 16.0),), 
          tabs:[
            Tab(
              text: "待分配",
            ),
            Tab(
              text: "受理中",
            ),
            Tab(
              text: "已完结",
            ),
          ],
        ),
        body: StoreConnector<IndexState, Map>(
          onInit: (Store store){
            initial(1);
          },
          converter: (store)=>store.state.repair.torepair,
          builder: (BuildContext context, state){
            return TabBarView(
              controller: _controller,
              children: [
                ToRepair(type: "pending",),
                ToRepair(type: "processing"),
                ToRepair(type: "already",),
              ]);
          }, 
        ),
      );
  }
}