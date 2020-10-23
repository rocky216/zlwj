import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gcyzzlwj/components/MyCard.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyScrollView.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';

class DisHallDetailPage extends StatefulWidget {
  final arguments;

  DisHallDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _DisHallDetailPageState createState() => _DisHallDetailPageState();
}

class _DisHallDetailPageState extends State<DisHallDetailPage> {
  Map detail={};
  List houselist = [];
  List voteOptions = [];
  int singleCount = 1;
  List aleadyVote = [];
  

  @override
  void initState() { 
    super.initState();
    this.getDetail();
  }

  getDetail() async {
    var data = await NetHttp.request("/api/app/owner/theme/info", context, params: {
      "id": widget.arguments["id"].toString()
    });
   
    if(data != null){
      setState(() {
        this.detail = data;
        this.voteOptions = data["voteOptionsList"];
        this.houselist = data["heOwnersHouseNo"];
        this.singleCount = data["singleCount"];
        this.aleadyVote = data["heOwnersHouseYes"];
      });
    }
  }

  checkItemBtn(String key, var item){
    if(key=="voteOptions"){
      int index = getIndexOf(this.voteOptions, "id", item["id"]);
      var newList = this.voteOptions.where((item)=>item["isSelect"]==true);
      if(newList.length==this.singleCount) {
        setState(() {
          this.voteOptions[index]["isSelect"] = false;
        });
      }else{
        setState(() {
          this.voteOptions[index]["isSelect"] = this.voteOptions[index]["isSelect"]==true?false:true;
        });
      }
      
    }else if(key=="houselist"){
      this.houselist.forEach((v){
        if(v["id"]==item["id"]){
          v["isSelect"]=true;
        }else{
          v["isSelect"]=false;
        }
      });
      setState(() {
        this.houselist = this.houselist;
      });
    }
  }

  getOptionsIds(){
    List arr = [];
    this.voteOptions.forEach((f){
      if(f["isSelect"]==true){
        arr.add(f["id"]);
      }
    });
    return arr.join(",");
  }
  getHousesInfo(){
    var house = this.houselist.where((item)=>item["isSelect"]==true).toList();
    return {
      "buildId": house[0]["buildingId"].toString(),
      "unitId": house[0]["unitId"].toString(),
      "houseId": house[0]["houseId"].toString(),
    };
  }

  handlenSubmit() async {
    String optionIds = this.getOptionsIds();
    Map houses = this.getHousesInfo();
    if(optionIds=="" ){
      showToast("请选择投票选项和房间！");
      return;
    }
    houses["optionIds"] = optionIds;
    houses["themeId"] = widget.arguments["id"].toString();
    
    var data = await NetHttp.request("/api/app/owner/theme/startVoteTheme", context, method: "post", params: houses);
    if(data != null){
      showToast("投票成功！");
      this.getDetail();
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(title: "议事堂详情",),
      body: MyScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Text(this.detail.isNotEmpty?this.detail["themeName"]:"", 
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),),
            ),
            Text(this.detail.isNotEmpty?this.detail["buildTime"]:"", style: TextStyle(color: Color(0xFF666666)),),
            Html(
              data: this.detail.isNotEmpty?this.detail["themeText"]:"",
            ),
            SizedBox(height: 30.0),
            this.detail.isNotEmpty?
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: <Widget>[
                  Text("总投票数量${this.detail['countAll']}"),
                ],
              ),
            ):Text(""),
            this.aleadyVote.isEmpty?Text(""):
            Column(
              children: this.aleadyVote.map((f){
                List voteRecordList = f["voteRecordList"];
                return MyCard(
                  title: Text(f["houseName"]),
                  child: Row(
                    children: voteRecordList.map((f){
                      return Padding(child: Text(f["voteOptions"]["optionsName"]),padding: EdgeInsets.only(right: 10.0),);
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            this.houselist.isNotEmpty?
            Column(
              children: <Widget>[
                MyCard(
                  title: Text("投票选项"),
                  child: Container(
                    child: Column(
                      children: this.voteOptions.map((f){
                        return Container(
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      f["optionsImgUrl"]==""?Text(""):Image.network(f["optionsImgUrl"], 
                                        width: 60.0, height: 60.0, fit: BoxFit.fill),
                                      Text(f["optionsName"])
                                    ],
                                  ),
                                ),
                                f["isSelect"]==true?Icon(Icons.check, color: Theme.of(context).primaryColor):Text("")
                                
                              ],
                            ),
                            onPressed: (){
                              this.checkItemBtn("voteOptions",f);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                MyCard(
                  title: Text("房屋列表"),
                  child: Container(
                    width: double.infinity,
                    child: Wrap(
                      children: this.houselist.map((f){
                        return Container(
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(f["houseName"]),
                                f["isSelect"]==true?Icon(Icons.check, color: Theme.of(context).primaryColor,):Text("")
                                
                              ],
                            ),
                            onPressed: (){
                              this.checkItemBtn("houselist",f);
                            },
                          ),
                        );
                      }).toList()
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("提交", style: TextStyle(color: Colors.white)),
                    onPressed: (){
                      this.handlenSubmit();
                    },
                  ),
                )
              ],
            ):Text("")
            
          ],
        ),
      ),
    );
  }
}