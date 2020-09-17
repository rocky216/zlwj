import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyTabBarHeader.dart';
import 'package:gcwyzlwj/pages/repair/person/personrepair.dart';
import 'package:gcwyzlwj/redux/export.dart';

class PersonRepair extends StatefulWidget {
  PersonRepair({Key key}) : super(key: key);

  @override
  _PersonRepairState createState() => _PersonRepairState();
}

class _PersonRepairState extends State<PersonRepair> with TickerProviderStateMixin{
  TabController _controller;
  String type;


  @override
  void initState() { 
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener((){
      if(_controller.index == 0 ){
        initial(1);
      }else if(_controller.index == 1 ){
        initial(1, type: "userAll");
      }
    });
  }

  initial(current, {type="userProcessing"}) async {
    this.type=type;
    StoreProvider.of<IndexState>(context).dispatch( getPersonRepair(context, params: {
      "current": current,
      "type": type
    }) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTabBarHeader(
        title: Text("我的报修", style: TextStyle(color: Color(0xFF666666), fontSize: 16.0),),
        actions: MaterialButton(onPressed: (){
          Navigator.of(context).pushNamed("/repair/person/add",  arguments: {"type": type});
        }, child: Text("创建报修", style: TextStyle(color: Colors.blue, fontSize: 14.0),),),
        tabs: [
          Tab(text: "受理中",),
          Tab(text: "全部报修",),
        ], controller: _controller,
      ),
      body: StoreConnector<IndexState, Map>(
        onInit: (Store store){
          initial(1);
        },
        converter: (Store store)=>store.state.repair.person,
        builder: (BuildContext context, state){
          
          return TabBarView(
            controller: _controller,
            children: <Widget>[
              PersonRepairPage(type: "userProcessing",),
              PersonRepairPage(type: "userAll",),
            ],
          );
        }, 
      ),
      
    );
  }
}
