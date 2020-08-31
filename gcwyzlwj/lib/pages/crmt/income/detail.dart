import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyBetweeItem.dart';
import 'package:gcwyzlwj/components/MyCard.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';

class CrmtIncomeDetail extends StatefulWidget {
  final arguments;
  CrmtIncomeDetail({Key key, this.arguments}) : super(key: key);

  @override
  _CrmtIncomeDetailState createState() => _CrmtIncomeDetailState();
}

class _CrmtIncomeDetailState extends State<CrmtIncomeDetail> {

  String getStatus(int status){
    String statuStr="";

    switch(status){
      case 0:
        statuStr="正常";
        break;
      case 1:
        statuStr="待审核";
        break;
      case 2:
        statuStr="通过";
        break;
      case 3:
        statuStr="驳回";
        break;
      case 4:
        statuStr="关闭";
        break;
    }

    return statuStr;
  }

  @override
  Widget build(BuildContext context) {
    var detail = widget.arguments;
    List chargeList = detail["faOtherOrderDescs"];
    return Scaffold(
      appBar: MyHeader(
        title: Text("${detail["code"]} ${detail["partner"]}"),
      ),
      body: MyScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    MyBetweeItem(title: "订单号",value: detail["orderNo"],),
                    MyBetweeItem(title: "状态",value: getStatus(detail["orderStatus"]),),
                    MyBetweeItem(title: "创建时间",value: detail["buildTime"],),
                    MyBetweeItem(title: "收费标题",value: detail["orderTitle"],),
                  ],
                ),
              ),
              MyCard(
                title: Text("收费详情", style: TextStyle(fontWeight: FontWeight.w600),),
                child: Column(
                  children: chargeList.map((f){
                    return MyBetweeItem(title: f["feeName"],value: f["feeMoney"].toString(),);
                  }).toList()
                  ..add(
                    MyBetweeItem(title: "",value: "合计：${detail["orderTrueFee"].toString()}",),
                  )
                ),
              ),
              MyCard(
                title: Text("打印信息", style: TextStyle(fontWeight: FontWeight.w600),),
                child: Column(
                  children: <Widget>[
                    MyBetweeItem(title: "打印人",value: detail["printUserStr"]??"暂无",),
                    MyBetweeItem(title: "打印次数",value: detail["printCount"].toString(),),
                    MyBetweeItem(title: "打印时间",value: detail["printTime"]??"",),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}