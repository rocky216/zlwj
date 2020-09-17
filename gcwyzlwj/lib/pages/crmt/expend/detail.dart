import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyBetweeItem.dart';
import 'package:gcwyzlwj/components/MyCard.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';

class CrmtExpendDetail extends StatefulWidget {
  final arguments;
  CrmtExpendDetail({Key key, this.arguments}) : super(key: key);

  @override
  _CrmtExpendDetailState createState() => _CrmtExpendDetailState();
}

class _CrmtExpendDetailState extends State<CrmtExpendDetail> {

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
    List chargeList = detail["faOtherExpendDescs"];
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
                    MyBetweeItem(title: "提交信息",value: detail["submitInfo"],),
                  ],
                ),
              ),
              MyCard(
                title: Text("收支详情", style: TextStyle(fontWeight: FontWeight.w600),),
                child: Column(
                  children: chargeList.map((f){
                    return MyBetweeItem(title: f["feeName"],value: f["feeMoney"].toString(),);
                  }).toList()
                  ..add(
                    MyBetweeItem(title: "",value: "合计：${detail["orderTrueFee"].toString()}",),
                  )
                ),
              ),
              detail["reviewer"] == null?Container()
              :MyCard(
                title: Text("审核信息", style: TextStyle(fontWeight: FontWeight.w600),),
                child: Column(
                  children: <Widget>[
                    MyCard(
                      title: Text("审核说明", style: TextStyle(color: Color(0xFF666666)),),
                      extra: Text(detail["examineInfo"]??"", style: TextStyle(fontSize: 12)),
                      child: Text(detail["remark"]??""),
                    ),
                  ],
                )
              ),
              Column(
                children: (detail["enclosures"] as List).map((f){
                  return Image.network(f, fit: BoxFit.cover,);
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}