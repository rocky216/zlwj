import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MyList.dart';

class InspectPage extends StatefulWidget {
  InspectPage({Key key}) : super(key: key);

  @override
  _InspectPageState createState() => _InspectPageState();
}

class _InspectPageState extends State<InspectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "资产巡查",
      ),
      body: MyList(
        url: "/api/app/owner/myJournal/assetsCheck", 
        itemBuilder: (dataList, i){
          return ListTile(
            contentPadding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
            leading: ClipRRect(
              child: Container(
                height: 100.0, width: 80.0,
                decoration: BoxDecoration(
                  color: Color(0xFFeeeeee) 
                ),
                child: dataList[i]["sysAttachment"]==null? Icon(Icons.image, size: 30.0, color: Colors.grey,)
                  :Image.network(dataList[i]["sysAttachment"]["dowloadHttpUrl"], height: 100.0, width: 80.0, fit: BoxFit.fill),
              ),
            ),
            title: Text(dataList[i]["assetsName"]+dataList[i]["assetsCode"], overflow: TextOverflow.ellipsis, maxLines: 1,),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dataList[i]["checkInfo"], overflow: TextOverflow.ellipsis, maxLines: 2,),
                Text('巡查人：'+dataList[i]["checkUserName"]),
                Text('巡查时间：'+dataList[i]["buildTime"]),
              ],
            ),
            onTap: (){
              Navigator.of(context).pushNamed("/inspect/detail", arguments: dataList[i]);
            },
          );
        }
      ),
    );
  }
}