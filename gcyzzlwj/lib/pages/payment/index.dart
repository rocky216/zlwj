import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyList.dart';
import 'package:gcyzzlwj/components/MySimpleList.dart';

class UserPayment extends StatefulWidget {
  UserPayment({Key key}) : super(key: key);

  @override
  _UserPaymentState createState() => _UserPaymentState();
}

class _UserPaymentState extends State<UserPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "物业费缴费记录",
      ),
      body: MyList(
        url: "/api/app/owner/my/myPropertyList", 
        itemBuilder: (dataList, i){
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("订单号:${dataList[i]['orderNo']}"),
                Row(
                  children: [
                    Text("金额："),
                    Text("￥${dataList[i]['orderTrueFee']}", style: TextStyle(color: Colors.red),)
                  ],
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("缴费时间：${dataList[i]['paymentRange']}"),
                Text("${dataList[i]['houPropertyStr']}"),
              ],
            ),
            trailing: Icon(Icons.chevron_right, size: 30.0,),
            onTap: (){
              Navigator.of(context).pushNamed("/user/payment/detail", arguments: dataList[i]);
            },
          );
        }
      ),
    );
  }
}