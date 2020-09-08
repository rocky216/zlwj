import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyEmpty.dart';
import 'package:gcwyzlwj/components/MyStoreList.dart';
import 'package:gcwyzlwj/components/MyTag.dart';
import 'package:gcwyzlwj/redux/export.dart';

class ToRepair extends StatefulWidget {
  final String type;
  ToRepair({Key key, this.type}) : super(key: key);

  @override
  _ToRepairState createState() => _ToRepairState();
}

class _ToRepairState extends State<ToRepair> {
  int _current=1;

  @override
  void initState() { 
    super.initState();
  }

  initial(current){
    StoreProvider.of<IndexState>(context).dispatch( getToRepair(context, params: {
      "current": current,
      "type": widget.type
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreConnector<IndexState, Map>(
        // onInit: (Store store){
        //   initial(1);
        // },
        // onDispose: (Store store){
        //   store.dispatch( ToRepairAction(null) );
        // },
        converter: (store)=>store.state.repair.torepair,
        builder: (BuildContext context, state){
          return state == null || state.isEmpty?MyEmpty()
          :MyStoreList(
            data: state, 
            getMore: (current){
              initial(current);
            }, 
            itemBuilder: (index){
              List dataList = state["list"];
              return ListTile(
                onTap: (){
                  dataList[index]["type"] = widget.type;
                  Navigator.of(context).pushNamed("/repair/alldetail", arguments: dataList[index]);
                },
                leading: Image.network(dataList[index]["img"], width: 80, fit: BoxFit.cover,),
                title: Text(dataList[index]["repairName"], overflow: TextOverflow.ellipsis, maxLines: 1,),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(dataList[index]["repairInfo"], overflow: TextOverflow.ellipsis, maxLines: 2,),
                    Wrap(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 5.0, bottom: 3.0),
                          child: MyTag(text: dataList[index]["submitTypeStr"], bg: Colors.blue,ghost: true,),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child: MyTag(text: dataList[index]["repairTypeName"], bg: Colors.blue,ghost: true,),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(right: 5.0),
                        //   child: MyTag(text: dataList[index]["buildTime"], bg: Colors.blue,ghost: true,),
                        // ),
                      ],
                    )
                  ],
                ),
              );
            }
          );
        }, 
      )
    );
  }
}