import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyInput.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/components/MyTag.dart';
import 'package:gcwyzlwj/components/MyUploadImg.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';
import 'package:smart_select/smart_select.dart';
import 'package:timeline/model/timeline_model.dart';
import 'package:timeline/timeline.dart';

class RepairDetailPage extends StatefulWidget {
  final arguments;
  RepairDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _RepairDetailPageState createState() => _RepairDetailPageState();
}

class _RepairDetailPageState extends State<RepairDetailPage> {
  List persons=[];
  List imgUrls=[];
  String endInfo;
  String endUserId;
  String processingInfo;
  

  @override
  void initState() { 
    super.initState();
    this.getPersons();
  }
  
  getPersons() async {
    var data = await NetHttp.request("/api/app/property/repair/branch", context, params: {
      "heId": widget.arguments["heId"]
    });
    if(data != null){
      setState(() {
        this.persons = data;
      });
    }
  }

  toDistribution() async {
    String endUserName;
    if(this.endUserId!= null){
      var obj = persons.where((o)=>o["id"].toString()==this.endUserId).toList();
      endUserName = obj[0]["name"];
    }
    var data = await NetHttp.request("/api/app/property/repair/distribution", context, method: "post", params: {
      "id": widget.arguments["id"],
      "processingInfo": this.processingInfo,
      "endUserId": this.endUserId,
      "endUserName": endUserName
    });
    if(data != null){
      showToast("操作成功！");
      Navigator.of(context).pop();
    }
  }

  submit() async {
    var data = await NetHttp.request("/api/app/property/repair/end", context, method: "post", params: {
      "id": widget.arguments["id"],
      "endInfo": this.endInfo,
      "imgUrls": this.imgUrls.join(","),
    });
    if(data != null){
      showToast("操作成功！");
      Navigator.of(context).pop();
      StoreProvider.of<IndexState>(context).dispatch( getToRepair(context, params: {
        "current": 1,
        "type": widget.arguments["type"]
      }));
    }
  }

  myAdd(){
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: MyUploadImg(
        next: (url){
          imgUrls.add(url);
          setState(() {
            imgUrls = imgUrls;
          });
        },
        child: Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Container(
              width: 60.0,
              height: 60.0,
              color: Color(0xFFdddddd),
              child: Icon(Icons.add, color: Colors.grey, size: 30,),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: Text("详情"),
      ),
      body: MyScrollView(
        child: StoreConnector<IndexState, Map>(
          onDispose: (Store store){
            
            
          },
          converter: (store)=>store.state.app.news,
          builder: (BuildContext context, state){
            return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[ 
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Text(widget.arguments["repairName"], style: TextStyle(fontSize: 20.0),),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Wrap(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            child: MyTag(text: widget.arguments["processingStateStr"], bg: Colors.orange,),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            child: MyTag(text: widget.arguments["submitTypeStr"], bg: Colors.blue,),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            child: MyTag(text: widget.arguments["repairTypeName"], bg: Colors.blue,),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            child: MyTag(text: widget.arguments["buildTime"], bg: Colors.blue,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(widget.arguments["repairInfo"]),
                    ),
                    Container(
                      child: Wrap(
                        children: (widget.arguments["imgSubUrls"] as List).map((f){
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue)
                            ),
                            margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed("/showimg", arguments: {"img": f});
                              },
                              child: Image.network(f, fit: BoxFit.cover, width: 105.0, height: 200.0,),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    widget.arguments["processingState"]=="0"?
                    Container(
                      child: Column(
                        children: <Widget>[
                          SmartSelect<String>.single(
                            title: '分配至',
                            placeholder: "请选择分配人",
                            value: endUserId,
                            options: persons.map((f){
                              return SmartSelectOption<String>(value: f["id"].toString(), title: f["name"]);
                            }).toList(),
                            onChange: (val){
                              print(val);
                              setState((){
                                endUserId = val;
                              });
                            }
                          ),
                          MyInput(label: Text("分配说明：", style: TextStyle(fontSize: 14.0),), hintText: "分配说明~",
                            maxLines: 3, padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            onChange: (v){
                              setState(() {
                                this.processingInfo = v;
                              });
                            },
                          ),
                          MyInput(label: Text(""), 
                              child: Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: RaisedButton(
                                  color: Colors.blue,
                                  onPressed: (){
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    toDistribution();
                                  }, 
                                child: Text("分配工单", style: TextStyle(color: Colors.white),),
                              ),
                              ),
                          )
                        ],
                      ),
                    ):Container(),

                    widget.arguments["processingState"]=="1" || widget.arguments["processingState"]=="2"?Container(
                      child: Column(
                        children: <Widget>[
                          MyInput(label: Text("分配人："), child: Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text(widget.arguments["processingUserName"]+widget.arguments["processingTime"]),
                          ),),
                          MyInput(label: Text("说明："), child: Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text(widget.arguments["processingInfo"]),
                          ),),
                          MyInput(label: Text("受理人："), child: Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text(widget.arguments["endUserName"]),
                          ),),
                          widget.arguments["processingState"]=="1"?
                          MyInput(hintText: "完结说明~", 
                            label: Text("完结说明：", style: TextStyle(fontSize: 14.0),), maxLines: 3, padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            onChange: (v){
                              setState(() {
                                endInfo = v;
                              });
                            },  
                          )
                          :MyInput(hintText: "完结说明~", 
                            label: Text("完结说明：", style: TextStyle(fontSize: 14.0),), padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text(widget.arguments["endInfo"]),
                          ),
                          widget.arguments["processingState"]=="1"?
                          MyInput(label: Text("上传图片：", style: TextStyle(fontSize: 14.0),),
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Wrap(
                              children: imgUrls.map((f){
                                return Container(
                                  margin: EdgeInsets.fromLTRB(10.0, 0, 0, 10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: Container(
                                      width: 60.0,
                                      height: 60.0,
                                      color: Colors.grey,
                                      child: Image.network(f, fit: BoxFit.cover),
                                    ),
                                  ),
                                );
                              }).toList()
                              ..add(myAdd()),
                            ),
                          )
                          :MyInput(label: Text("上传图片：", style: TextStyle(fontSize: 14.0),),
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Wrap(
                              children: (widget.arguments["imgEndUrls"] as List).map((f){
                                return Container(
                                  margin: EdgeInsets.fromLTRB(10.0, 0, 0, 10.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: Container(
                                      width: 60.0,
                                      height: 60.0,
                                      color: Colors.grey,
                                      child: Image.network(f, fit: BoxFit.cover),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          widget.arguments["processingState"]=="2" || widget.arguments["isAcceptance"]==0?Container()
                          :MyInput(label: Text(""), 
                              child: Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: RaisedButton(
                                  color: Colors.blue,
                                  onPressed: (){
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    submit();
                                  }, 
                                child: Text("完结工单", style: TextStyle(color: Colors.white),),
                              ),
                              ),
                          )
                        ],
                      ),
                    ):Container(),
                  ],
                ),
              );
          }
        )
      ),
    );
  }
}