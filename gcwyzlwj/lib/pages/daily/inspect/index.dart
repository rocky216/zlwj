import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyCard.dart';
import 'package:gcwyzlwj/components/MyEmpty.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyStoreList.dart';
import 'package:gcwyzlwj/redux/daily/action.dart';
import 'package:gcwyzlwj/redux/export.dart';

class DailyInspect extends StatefulWidget {
  DailyInspect({Key key}) : super(key: key);

  @override
  _DailyInspectState createState() => _DailyInspectState();
}

class _DailyInspectState extends State<DailyInspect> {
  String date = new DateTime.now().toString().substring(0,10);

  initial(current, date){
    StoreProvider.of<IndexState>(context).dispatch( getInspects(context, params: {
      "current": current,
      "time": "$date 23:59:59",
      "pageSize": "10"
    }) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        isHe: true,
        title: Text("空置房巡查"),
        actions: Row(
          children: <Widget>[
            Container(
              width: 50.0,
              child: MaterialButton(child: Icon(Icons.add, color: Colors.blue, size: 26,),onPressed: (){
                Navigator.of(context).pushNamed("/daily/inspect/add");
              },),
            ),
            Container(
              width: 60.0,
              child: FlatButton(onPressed: () async {
                DateTime d = await showDatePicker(context: context, initialDate: DateTime.now(), 
                  firstDate: new DateTime.now().subtract(new Duration(days: 365)), // 减 365 天
                  lastDate: new DateTime.now().add(new Duration(days: 365)),
                );
                if(d != null){
                  String date = d.toString().substring(0,10);
                  initial(1, date);
                  setState(() {
                    date=date;
                  });
                }
                
              }, child: Icon(Icons.date_range, color: Colors.blue,)),
            )
          ],
        ),
      ),
      body: StoreConnector<IndexState, Map>(
        onInit: (Store store){
          initial(1, date);
        },
        onDispose: (Store store){
          store.dispatch( DailyInspectAction(null) );
        },
        converter: (store)=>store.state.daily.inspect,
        builder: (BuildContext context, state){
          return state == null || state.isEmpty?MyEmpty()
          :MyStoreList(
            data: state, 
            getMore: (current){
              initial(current, date);
            }, 
            itemBuilder: (index){
              List dataList = state["list"];
              return Container(
                child: ListTile(
                  title: Text(dataList[index]["assetsCode"]),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(dataList[index]["checkInfo"]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(dataList[index]["checkUserName"]),
                          Text(dataList[index]["checkTime"]?.substring(0,10))
                        ],
                      )
                    ],
                  ),
                  dense: false,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      child: Image.network(dataList[index]["imgUrl"], fit: BoxFit.cover,width: 60.0,height: 80.0,),
                    ),
                  )
                ),
              );
            });
        }, ),
    );
  }
}