import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/pages/record/billbox/balance.dart';
import 'package:gcyzzlwj/pages/record/billbox/integral.dart';

class BillRecordPage extends StatefulWidget {
  BillRecordPage({Key key}) : super(key: key);

  @override
  _BillRecordPageState createState() => _BillRecordPageState();
}

class _BillRecordPageState extends State<BillRecordPage> with TickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() { 
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
    _controller.addListener((){
      if(_controller.index == 1 && _controller.indexIsChanging){
      }
    });
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: MyHeader(
        
        title: "账单记录",
        controller: this._controller,
        tabs: [
          Tab(text: "余额账单",),
          Tab(text: "积分账单",),
        ],
      ),
      body: TabBarView(
        controller: this._controller,
        children: [
          BalanceBillRecord(),
          IntegralBillRecord()
        ])
    );
  }
}