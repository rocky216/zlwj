import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyBetweeItem.dart';
import 'package:gcwyzlwj/components/MyCard.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/redux/crmt/middleware.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';

class NewFeeDetailPage extends StatefulWidget {
  final arguments;
  NewFeeDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _NewFeeDetailPageState createState() => _NewFeeDetailPageState();
}

class _NewFeeDetailPageState extends State<NewFeeDetailPage> {
  String checkInfo;
  Map detail;

  @override
  void initState() { 
    super.initState();
    this.initial();
  }

  initial() async {
    var data = await NetHttp.request("/api/app/property/propertyOrder/newsEnter", context, params: {
      "id": widget.arguments["id"],
      "propertyId": widget.arguments["linkId"],
      "heId": widget.arguments["heId"],
    });
    if(data != null){
      setState(() {
        this.detail = data;
      });
    }
  }

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

  submit(status) async {
    var data = await NetHttp.request("/api/app/property/propertyOrder/checkOrderException", context, method: "post", 
              params: {
                "id": this.detail["id"],
                "orderType": "propertyOrder",
                "checkInfo": checkInfo,
                "checkStatus": status,
              });
    if(data != null){
      showToast("提交成功");
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: MyHeader(
        title: detail==null?Container() : Text("${detail["code"]} ${detail["partner"]}"),
      ),
      body: MyScrollView(
        child: detail==null?Container() 
          :StoreConnector<IndexState, AppState>(
            onDispose: (Store store){
              store.dispatch(getChangeNewsStatus(widget.arguments["id"]));
            },
            converter: (store)=>store.state.app,
            builder: (BuildContext context, state){
              return Container(
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
                        children: (detail["faPropertyCostsOrderDetails"] as List).map((f){
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
                          detail["orderStatus"]==1?
                          MyCard(
                            title: Text("审核说明", style: TextStyle(color: Color(0xFF666666)),),
                            extra: Text(detail["examineInfo"]??"", style: TextStyle(fontSize: 12)),
                            child: Container(
                              child: TextField(
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: "输入审核说明~",
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                ),
                                onChanged: (v){
                                  setState(() {
                                    checkInfo=v;
                                  });
                                },
                              ),
                            ),
                          )
                          :MyCard(
                            title: Text("审核说明", style: TextStyle(color: Color(0xFF666666)),),
                            extra: Text(detail["examineInfo"]??"", style: TextStyle(fontSize: 12)),
                            child: Container(
                              child: Text(detail["faOrderException"]["checkInfo"]),
                            ),
                          ),
                          detail["orderStatus"]==1?
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                
                                RaisedButton(
                                  color: Colors.red,
                                  child: Text("驳回", style: TextStyle(color: Colors.white),),
                                  onPressed: (){
                                    submit("no");
                                  },),
                                RaisedButton(
                                  color: Colors.blue,
                                  child: Text("通过", style: TextStyle(color: Colors.white),),
                                  onPressed: (){
                                    submit("yes");
                                  },),
                              ],
                            ),
                          ): Container()
                        ],
                      )
                    ),
                  ],
                ),
              );
            }
          ),
      ),
    );
  }
}