import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyCard.dart';
import 'package:gcwyzlwj/components/MyEmpty.dart';

class CrmtCommon extends StatelessWidget {
  final state;
  final String part5;
  final String part7;
  
  const CrmtCommon({
    Key key, 
    @required this.state,
    @required this.part5,
              this.part7
    }) : super(key: key);


  Widget getStatus(Map item){
    String statuStr="";
    Widget icon=Container();

    switch(item["orderStatus"]){
      case 0:
        statuStr="正常";
        icon = Icon(Icons.check_circle, color: Colors.green,);
        break;
      case 1:
        statuStr="待审核";
        icon = Icon(Icons.error_outline, color: Color((0xFFe4a50f)),);
        break;
      case 2:
        statuStr="通过";
        icon = Icon(Icons.check_circle_outline, color: Colors.green,);
        break;
      case 3:
        statuStr="驳回";
        icon = Icon(Icons.error, color: Colors.red,);
        break;
      case 4:
        statuStr="关闭";
        icon = Icon(Icons.cancel, color: Colors.red,);
        break;
    }

    return Container(
      child: Column(
        children: <Widget>[
          icon,
          Text(statuStr, style: TextStyle(fontSize: 10),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
              itemBuilder: (BuildContext context, int index){
                List dataList=state["list"];
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 40.0,
                        child: Column(
                          children: <Widget>[
                            this.getStatus(dataList[index]),
                            Container(
                              margin: EdgeInsets.only(top:5.0),
                              decoration: BoxDecoration(border: Border.all(color: Color(0xFFf54123)),
                              borderRadius: BorderRadius.all(Radius.circular(2))),
                              child: Text(dataList[index]["type"], style: TextStyle(color: Color(0xFFf54123), fontSize: 12),),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 320.0,
                        padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 3.0),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFdddddd)))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(dataList[index]["orderNo"], style: TextStyle(fontWeight: FontWeight.w600),),
                                  Text(dataList[index]["buildTime"].substring(11), style: TextStyle(color: Color(0xFF666666)),)
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 3.0, 0, 3.0),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFdddddd)))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(dataList[index]["code"], style: TextStyle(color: Color(0xFF666666))),
                                  Text(dataList[index]["partner"], style: TextStyle(color: Color(0xFF666666)))
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFdddddd)))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(dataList[index][this.part5].toString(), style: TextStyle(color: Color(0xFF666666)),),
                                  Text("￥${dataList[index]["orderTrueFee"]}", style: TextStyle(color: Colors.red),)
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(dataList[index][this.part5].toString(), style: TextStyle(color: Color(0xFF666666)),),
                                  Text("￥${dataList[index]["orderTrueFee"]}", style: TextStyle(color: Colors.red),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }, 
              separatorBuilder: (BuildContext context, int index){
                return Container(height: 5.0, color: Color(0xFFdddddd),);
              }, 
              itemCount: state["list"].length);
  }
}