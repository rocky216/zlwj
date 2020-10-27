import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyList.dart';

class RepairRecordPage extends StatefulWidget {
  RepairRecordPage({Key key}) : super(key: key);

  @override
  _RepairRecordPageState createState() => _RepairRecordPageState();
}

class _RepairRecordPageState extends State<RepairRecordPage> {

  handlenStatus(str){
    Color color = Colors.red;
    String text = "";
    if(str.toString()=="0"){
      color=Colors.red;
      text="待处理";
    }else if(str.toString()=="1"){
      color=Colors.orange;
      text="待处中";
    }else {
      color=Theme.of(context).primaryColor;
      text="已处理";
    }
    return Container(
      padding: EdgeInsets.fromLTRB(3.0, 0, 3.0, 0),
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all( Radius.circular(3.0) )),
      child: Text(text, style: TextStyle(color: Colors.white),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "报修记录",
      ),
      body: MyList(
        url: "/api/app/owner/myJournal/myRepair", 
        itemBuilder: (dataList, i){
          return Container(
            child: MaterialButton(
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                ClipRRect(
                  child: Container(
                    height: 80.0, width: 80.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFeeeeee) 
                    ),
                    child: dataList[i]["img"]==""|| dataList[i]["img"].isEmpty  ? Icon(Icons.image, size: 30.0, color: Colors.grey,)
                      :Image.network(dataList[i]["img"], height: 80.0, width: 80.0, fit: BoxFit.fill),
                  ),
                ),
                
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  width: MediaQuery.of(context).size.width-120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(dataList[i]["repairName"], maxLines: 1, overflow: TextOverflow.ellipsis, 
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),)
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(dataList[i]["repairInfo"], maxLines: 1, overflow: TextOverflow.ellipsis, 
                            style: TextStyle(color: Color(0xFF666666))),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            this.handlenStatus(dataList[i]["processingState"]),
                            Text(dataList[i]["processingUserName"]),
                          ],
                        ),
                        Text(dataList[i]["buildTime"]!=null?dataList[i]["buildTime"].substring(0,11):"", style: TextStyle(color: Color(0xFF999999)),),
                      ],
                    )
                  ],),
                )
              ],),
              onPressed: (){
                Navigator.of(context).pushNamed("/clean/detail", arguments: dataList[i]);
              },
            ),
          );
        }
      ),
    );
  }
}