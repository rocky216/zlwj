import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyEmpty.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/redux/export.dart';

class MailList extends StatefulWidget {
  MailList({Key key}) : super(key: key);

  @override
  _MailListState createState() => _MailListState();
}

class _MailListState extends State<MailList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        leading: Container(margin: EdgeInsets.only(left: 20.0),),
        title: Text("通讯录"),
      ),
      body: Container(
        child: StoreConnector<IndexState, List>(
          onInit: (Store store){
            if(store.state.app.mail==null){
              store.dispatch( getMailList(context, params: {}) );
            }
            
          },
          converter: (store)=>store.state.app.mail,
          builder: (BuildContext context, state){
            return state==null? MyEmpty()
            :Container(
              child: ListView.separated(
                itemBuilder: (BuildContext context, index){
                  return Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(state[index]["heName"]),
                        ),
                        Container(
                          child: Column(
                            children: (state[index]["list"] as List).map((f){
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Color(0xFFeeeeee),
                                  backgroundImage: f["headUrl"].isNotEmpty?NetworkImage(f["headUrl"]):null,
                                ),
                                title: Text(f["phone"], style: TextStyle(fontSize: 14.0),),
                                subtitle: Text(f["name"], style: TextStyle(fontSize: 14.0),),
                                onTap: (){

                                },
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  );
                }, 
                separatorBuilder: (BuildContext context, index){
                  return Container(
                    height: 3.0, color: Color(0xFFeeeeee),);
                }, 
                itemCount: state.length
              ),
            );
          },),
      ),
    );
  }
}