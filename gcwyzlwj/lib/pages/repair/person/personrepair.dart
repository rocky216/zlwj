import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyEmpty.dart';
import 'package:gcwyzlwj/components/MyStoreList.dart';
import 'package:gcwyzlwj/components/MyTag.dart';
import 'package:gcwyzlwj/redux/export.dart';

class PersonRepairPage extends StatefulWidget {
  final String type;
  PersonRepairPage({Key key, this.type}) : super(key: key);

  @override
  _PersonRepairPageState createState() => _PersonRepairPageState();
}

class _PersonRepairPageState extends State<PersonRepairPage> {

  initial(current, {type="userProcessing"}) async {
    StoreProvider.of<IndexState>(context).dispatch( getPersonRepair(context, params: {
      "current": current,
      "pageSize": "7",
      "type": widget.type
    }) );
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
        converter: (store)=>store.state.repair.person,
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
                  Navigator.of(context).pushNamed("/repair/persondetail", arguments: dataList[index]);
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