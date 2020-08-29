import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyBetweeItem.dart';
import 'package:gcwyzlwj/components/MyCard.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';

class CrmtFeeDetail extends StatefulWidget {
  final arguments;
  CrmtFeeDetail({Key key, this.arguments}) : super(key: key);

  @override
  _CrmtFeeDetailState createState() => _CrmtFeeDetailState();
}

class _CrmtFeeDetailState extends State<CrmtFeeDetail> {

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
    List chargeList = detail["faPropertyCostsOrderDetails"];
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
                    MyBetweeItem(title: "缴费时间区间",value: detail["paymentRange"],),
                    MyBetweeItem(title: "创建时间",value: detail["buildTime"],),
                    MyBetweeItem(title: "建筑面积",value: detail["houseArea"].toString(),),
                    MyBetweeItem(title: "房屋类型",value: detail["elevatorHouseStr"],),
                  ],
                ),
              ),
              MyCard(
                title: Text("收费详情", style: TextStyle(fontWeight: FontWeight.w600),),
                child: Column(
                  children: chargeList.map((f){
                    return MyBetweeItem(title: f["detailsName"],value: f["trueFee"].toString(),);
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
              detail["faOrderException"] == null?Container()
              :MyCard(
                title: Text("审核信息", style: TextStyle(fontWeight: FontWeight.w600),),
                child: Column(
                  children: <Widget>[
                    MyBetweeItem(title: "异常类型",value: detail["faOrderException"]["updateFeeStr"]??"",),
                    MyCard(
                      title: Text("异常说明", style: TextStyle(color: Color(0xFF666666)),),
                      extra: Text(detail["submitInfo"]??"", style: TextStyle(fontSize: 12)),
                      child: Text(detail["faOrderException"]["exceptionInfo"]??"",),
                    ),
                    MyCard(
                      title: Text("审核说明", style: TextStyle(color: Color(0xFF666666)),),
                      extra: Text(detail["examineInfo"]??"", style: TextStyle(fontSize: 12)),
                      child: Text(detail["faOrderException"]["checkInfo"]??""),
                    ),
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