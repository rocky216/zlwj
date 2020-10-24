import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MySimpleStoreList.dart';
import 'package:gcyzzlwj/redux/export.dart';

class CardPage extends StatefulWidget {
  CardPage({Key key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "一卡通",
      ),
      body: StoreConnector<IndexState, List>(
        onInit: (Store store){
          store.dispatch(getCardList(context));
        },
        converter: (store)=>store.state.other.card,
        builder: (BuildContext context, state){
          
          return MySimpleStoreList(
            getRefresh: (){
              StoreProvider.of<IndexState>(context).dispatch( getCardList(context) );
            }, 
            data: state, 
            itemBuilder: (i){
              return ListTile(
                onTap: (){
                  Navigator.of(context).pushNamed("/iser/card/edit", arguments: state[i]);
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state[i]["heCarStr"]),
                    Text('IC：'+state[i]["icNumber"], style: TextStyle(color: Color(0xFF777777), fontSize: 16.0),),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state[i]["cardName"]),
                    Text('ID：'+state[i]["idNumber"], style: TextStyle(color: Color(0xFF777777), fontSize: 16.0)),
                  ],
                ),
                trailing: Icon(Icons.chevron_right),
              );
            }
          );
        }, 
      ),
    );
  }
}