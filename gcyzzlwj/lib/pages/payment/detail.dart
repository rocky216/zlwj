import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyBetweeItem.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/utils/http.dart';

class UserPaymentDetail extends StatefulWidget {
  final arguments;
  UserPaymentDetail({Key key, this.arguments}) : super(key: key);

  @override
  _UserPaymentDetailState createState() => _UserPaymentDetailState();
}

class _UserPaymentDetailState extends State<UserPaymentDetail> {
  Map detail;

  @override
  void initState() { 
    super.initState();
    this.initial();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/owner/my/propertyDetails", context, params: {
      "id": widget.arguments["id"].toString(),
    });
    if(data != null){
      setState(() {
        this.detail = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "详情",
      ),
      body: MyScrollView(
        child:  this.detail== null? Container()
        :Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    MyBetweeItem(
                      title: "资产",
                      value: this.detail["houPropertyStr"],
                    ),
                    MyBetweeItem(
                      title: "建筑面积",
                      value: this.detail["houseArea"].toString()+'平方',
                    ),
                    MyBetweeItem(
                      title: "类型",
                      value: this.detail["type"],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFeeeeee)
                ),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 20.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('缴费时间：'+this.detail["paymentRange"]),
                    SizedBox(height: 10.0,),
                    Column(
                      children: (this.detail["faPropertyCostsOrderDetails"] as List).map((f) => 
                        MyBetweeItem(
                          title: f["detailsName"],
                          value: f["trueFee"].toString()+'元',
                        ),
                      ).toList(),
                    ),
                    Column(
                      children: (this.detail["faPropertyCostsOrderActives"] as List).map((f) => 
                        MyBetweeItem(
                          title: f["activeName"],
                          value: f["moneyReward"].toString()+'元',
                        ),
                      ).toList(),
                    ),
                    SizedBox(height: 30.0,),
                    MyBetweeItem(
                      title: "",
                      value: '合计金额：'+this.detail["orderTrueFee"].toString(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}