import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyInput.dart';
import 'package:gcwyzlwj/components/MyScrollView.dart';
import 'package:gcwyzlwj/components/MyTag.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:gcwyzlwj/utils/index.dart';
import 'package:timeline/model/timeline_model.dart';
import 'package:timeline/timeline.dart';

class NewDetailPage extends StatefulWidget {
  final arguments;
  NewDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _NewDetailPageState createState() => _NewDetailPageState();
}

class _NewDetailPageState extends State<NewDetailPage> {
  Map data;
  List imgUrls=[];
  String endInfo;
  

  @override
  void initState() { 
    super.initState();
    this.initial();
  }
  

  initial() async {
    var data = await NetHttp.request("/api/app/property/repair/newsEnter", context, params: {
      "heId": widget.arguments["heId"],
      "id": widget.arguments["id"],
      "repairId": widget.arguments["linkId"],
    });
    if(data != null){
      setState(() {
        this.data = data;
        this.imgUrls = data["imgEndUrls"];
      });
    }
  }

  submit() async {
    var data = await NetHttp.request("/api/app/property/repair/end", context, method: "post", params: {
      "id": this.data["id"],
      "endInfo": this.endInfo,
      "imgUrls": this.imgUrls.join(","),
    });
    if(data != null){
      showToast("操作成功！");
      Navigator.of(context).pop();
    }
  }

  myAdd(){
    return Container(
      child: MaterialButton(
        onPressed: () async{
          FocusScope.of(context).requestFocus(FocusNode());
          var url = await uploadImg("image");
            imgUrls.add(url);
            setState(() {
              imgUrls = imgUrls;
            });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Container(
            width: 60.0,
            height: 60.0,
            color: Colors.grey,
            child: Icon(Icons.add, color: Colors.white, size: 30,),
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
            store.dispatch(getChangeNewsStatus(widget.arguments["id"]));
          },
          converter: (store)=>store.state.app.news,
          builder: (BuildContext context, state){
            return data==null?Container()
              :Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[ 
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Text(data["repairName"], style: TextStyle(fontSize: 20.0),),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Wrap(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            child: MyTag(text: data["processingStateStr"], bg: Colors.orange,),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            child: MyTag(text: data["submitTypeStr"], bg: Colors.blue,),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            child: MyTag(text: data["repairTypeName"], bg: Colors.blue,),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5.0),
                            child: MyTag(text: data["buildTime"], bg: Colors.blue,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(data["repairInfo"]),
                    ),
                    Container(
                      child: Column(
                        children: (data["imgSubUrls"] as List).map((f){
                          return Image.network(f, fit: BoxFit.fill,);
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    data["processingState"]=="1" || data["processingState"]=="2"?Container(
                      child: Column(
                        children: <Widget>[
                          MyInput(label: Text("分配人："), child: Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text(data["processingUserName"]+data["processingTime"]),
                          ),),
                          MyInput(label: Text("说明："), child: Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text(data["processingInfo"]),
                          ),),
                          MyInput(label: Text("受理人："), child: Container(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text(data["endUserName"]),
                          ),),
                          data["processingState"]=="1"?
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
                            child: Text(data["endInfo"]),
                          ),
                          data["processingState"]=="1"?
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
                              }).toList(),
                            ),
                          ),
                          data["processingState"]=="2"?Container()
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