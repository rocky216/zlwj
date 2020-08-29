import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyCard.dart';
import 'package:gcwyzlwj/components/MyEmpty.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/redux/crmt/middleware.dart';
import 'package:gcwyzlwj/redux/crmt/state.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/index.dart';

class CrmtList extends StatefulWidget {
  final arguments;

  CrmtList({Key key, this.arguments}) : super(key: key);

  @override
  _CrmtListState createState() => _CrmtListState();
}

class _CrmtListState extends State<CrmtList> {
  String heName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getHe();
  }

  getHe() async {
    Map userInfo = await getUserInfo();
    if(userInfo != null){
      setState(() {
        heName = userInfo["nowHe"]["name"];
      });
    }
  }

  getStatics(Map state){
    return MyCard(
      title: Row(children: <Widget>[
        Icon(Icons.filter, size: 14.0, color: Color(0xFFf59a23),),
        Text("订单统计", style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFf59a23)),)
      ],),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("正常${state["normal"]}单 待审核${state["reviewed"]}单 异常${state["abnormal"]}单 关闭${state["close"]}单"),
          Text("正常订单合计:￥${state["sumMoney"]}")
        ],
      ),
    );
  }

  initial(date){
    StoreProvider.of<IndexState>(context).dispatch( getFeeOrder(context, params: {
      "pageSize": 10,
      "current": 1,
      "time": "$date 23:59:59"
    }) );
  }

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
    print(widget.arguments);
    return Scaffold(
      appBar: MyHeader(
        title: Row(children: <Widget>[heName != null?Text(heName, style: TextStyle(color: Color(0xFF02a7f0)),):Container(),
          Text(widget.arguments["name"])],),
        actions: Container(
          width: 60.0,
          child: FlatButton(onPressed: () async {
            DateTime d = await showDatePicker(context: context, initialDate: DateTime.now(), 
              firstDate: new DateTime.now().subtract(new Duration(days: 365)), // 减 365 天
              lastDate: new DateTime.now().add(new Duration(days: 365)),
            );
            if(d != null){{
              String date = d.toString().substring(0,10);
              initial(date);
            }}
            
          }, child: Icon(Icons.date_range, color: Colors.blue,)),
        ),
      ),
      body: StoreConnector<IndexState, Map>(
        onInit: (Store store){
          DateTime d = new DateTime.now();
          String date = d.toString().substring(0,10);
          initial(date);
        },
        converter: (store)=>store.state.crmt.fee, 
        builder: (BuildContext context, state){
          return state == null || state.isEmpty?MyEmpty()
          :ListView.separated(
            itemBuilder: (BuildContext context, int index){
              List dataList=state["data"]["list"];
              return index==0? getStatics(state): 
              Container(
                padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                child: MaterialButton(
                  padding: EdgeInsets.all(0),
                  onPressed: (){
                    Navigator.of(context).pushNamed("/crmt/fee/detail", arguments: dataList[index-1]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 40.0,
                        child: Column(
                          children: <Widget>[
                            this.getStatus(dataList[index-1]),
                            Container(
                              margin: EdgeInsets.only(top:5.0),
                              decoration: BoxDecoration(border: Border.all(color: Color(0xFFf54123)), 
                              borderRadius: BorderRadius.all(Radius.circular(2))),
                              child: Text(dataList[index-1]["type"], style: TextStyle(color: Color(0xFFf54123), fontSize: 12),),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 280.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 3.0),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFdddddd)))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(dataList[index-1]["orderNo"], style: TextStyle(fontWeight: FontWeight.w600),),
                                  Text(dataList[index-1]["buildTime"].substring(11), style: TextStyle(color: Color(0xFF666666)),)
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 3.0, 0, 3.0),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFdddddd)))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(dataList[index-1]["code"], style: TextStyle(color: Color(0xFF666666))),
                                  Text(dataList[index-1]["partner"], style: TextStyle(color: Color(0xFF666666)))
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(dataList[index-1]["paymentRange"], style: TextStyle(color: Color(0xFF666666)),),
                                  Text("￥${dataList[index-1]["orderTrueFee"]}", style: TextStyle(color: Colors.red),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),),
              );
            }, 
            separatorBuilder: (BuildContext context, int index){
              return Container(height: 5.0, color: Color(0xFFdddddd),);
            }, 
            itemCount: state["data"]["list"].length+1);
        }
      ),
    );
  }
}