import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyCard.dart';
import 'package:gcwyzlwj/components/MyEmpty.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyStoreList.dart';
import 'package:gcwyzlwj/redux/crmt/middleware.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/index.dart';

class CrmtExamincome extends StatefulWidget {
  final arguments;

  CrmtExamincome({Key key, this.arguments}) : super(key: key);

  @override
  _CrmtExamincomeState createState() => _CrmtExamincomeState();
}

class _CrmtExamincomeState extends State<CrmtExamincome> {
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

  initial(current){
    StoreProvider.of<IndexState>(context).dispatch( getExamincomeOrder(context, params: {
      "current": current,
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
      ),
      body: StoreConnector<IndexState, Map>(
        onInit: (Store store){
          initial(1);
        },
        onDispose: (Store store){
          store.dispatch( getExamincomeData({}, clear: true) );
        },
        converter: (store)=>store.state.crmt.examincome, 
        builder: (BuildContext context, state){
          return state == null || state.isEmpty?MyEmpty()
            :MyStoreList(
              data: state, 
              getMore: (current){
                initial(current);
              }, 
              itemBuilder: (int index){
                List dataList=state["list"];
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: (){
                      Navigator.of(context).pushNamed("/crmt/examincome/detail", arguments: dataList[index]);
                    },
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
                          width: 290.0,
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
                                padding: EdgeInsets.fromLTRB(0, 3.0, 0, 3.0),
                                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFdddddd)))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(dataList[index]["orderTitle"].toString(), style: TextStyle(color: Color(0xFF666666)),),
                                    Text("￥${dataList[index]["orderTrueFee"]}", style: TextStyle(color: Colors.red),)
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(dataList[index]["updateFeeStatusStr"].toString(), style: TextStyle(color: Color(0xFF666666)),),
                                    Text("审核收入", style: TextStyle(color: Colors.red, fontSize: 12),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            );
        }
      ),
    );
  }
}