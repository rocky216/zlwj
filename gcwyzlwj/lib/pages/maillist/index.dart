import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyEmpty.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:url_launcher/url_launcher.dart';

class MailList extends StatefulWidget {
  MailList({Key key}) : super(key: key);

  @override
  _MailListState createState() => _MailListState();
}

class _MailListState extends State<MailList> {
  List data;

  handlenSearch(v){
    var store  = StoreProvider.of<IndexState>(context);
    List list = store.state.app.mail;
    var arr = list.where( (o){
      return o["name"].indexOf(v)>-1;
    }).toList();
    
    setState(() {
      this.data = arr;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        leading: Container(margin: EdgeInsets.only(left: 20.0),),
        title: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFdddddd)),
                    borderRadius: BorderRadius.all( Radius.circular(20.0) )
                  ),
                  width: 300,
                  height: 40.0,
                  child: TextField(
                    style: TextStyle(fontSize: 14.0),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      icon: Icon(Icons.search),
                      hintText: "输入姓名~",
                      hintStyle: TextStyle(fontSize: 14.0),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0x0cdddddd))),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0x0cdddddd))),
                    ),
                    onChanged: (v){
                      handlenSearch(v);
                    },
                  )
                )
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
            : data==null? 
            Container(
              child: ListView.separated(
                itemBuilder: (BuildContext context, index){
                  return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person, color: state[index]["headUrl"].isNotEmpty?Color(0x0cdddddd):Colors.grey,),
                        backgroundColor: Color(0xFFeeeeee),
                        backgroundImage: state[index]["headUrl"].isNotEmpty?NetworkImage(state[index]["headUrl"]):null,
                      ),
                      title: Text(state[index]["phone"], style: TextStyle(fontSize: 14.0),),
                      subtitle: Text(state[index]["name"], style: TextStyle(fontSize: 14.0),),
                      onTap: () async {
                        var url = "tel:${state[index]['phone']}";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    );
                }, 
                separatorBuilder: (BuildContext context, index){
                  return Container(
                    height: 3.0, color: Color(0xFFeeeeee),);
                }, 
                itemCount: state.length
              ),
            )
            :Container(
              child: ListView.separated(
                itemBuilder: (BuildContext context, index){
                  return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.person, color: data[index]["headUrl"].isNotEmpty?Color(0x0cdddddd):Colors.grey,),
                        backgroundColor: Color(0xFFeeeeee),
                        backgroundImage: data[index]["headUrl"].isNotEmpty?NetworkImage(data[index]["headUrl"]):null,
                      ),
                      title: Text(data[index]["phone"], style: TextStyle(fontSize: 14.0),),
                      subtitle: Text(data[index]["name"], style: TextStyle(fontSize: 14.0),),
                      onTap: () async {
                        var url = "tel:${data[index]['phone']}";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    );
                }, 
                separatorBuilder: (BuildContext context, index){
                  return Container(
                    height: 3.0, color: Color(0xFFeeeeee),);
                }, 
                itemCount: data.length
              ),
            );
          },),
      ),
    );
  }
}