import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyList.dart';
import 'package:gcyzzlwj/utils/index.dart';

class PileOrderListPage extends StatefulWidget {
  PileOrderListPage({Key key}) : super(key: key);

  @override
  _PileOrderListPageState createState() => _PileOrderListPageState();
}

class _PileOrderListPageState extends State<PileOrderListPage> {
  

  Widget getStatus(str){
    switch(str){
      case "0":
        return Text("等待充电", style: TextStyle(color: Colors.orange),);
      case "1":
        return Text("充电中", style: TextStyle(color: Colors.blue),);
      case "2":
        return Text("充电完成", style: TextStyle(color: Colors.green),);
      case "3":
        return Text("充电失败", style: TextStyle(color: Colors.red),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "充电订单",
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        child: MyList(
          url: "/api/app/owner/power/myOrder", 
          itemBuilder: (dataList, i){
            return Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    border: dataList.length-1==i?null:Border(left: BorderSide(color: Colors.blue, width: 2.0))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("订单编号:${dataList[i]['orderNo']}"),
                      Text("设备信息:${dataList[i]['deviceName']}${int.parse(dataList[i]['port'])+1}端口"),
                      Row(
                        children: [
                          Text("订单状态:"),
                          this.getStatus(dataList[i]['orderStatus'])
                        ],
                      ),
                      Text("开始时间:${dataList[i]['startTime']}"),
                      Text("结束时间:${dataList[i]['endTime']??'暂无'}"),
                      Text("订单信息:${dataList[i]['unitFee']}元${dataList[i]['unitMin']}分钟"),
                      Text("扣款信息:${dataList[i]['orderStr']}"),
                      Row(
                        children: [
                          Text("结束信息:"),
                          endStatus(dataList[i]['endStatus'])
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -1,
                  left: 15,
                  child: Icon(Icons.lens, color: Colors.blue, size: 13.0,),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Text(dataList[i]['buildTime'].substring(0,10), style: TextStyle(color: Colors.blue),),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}