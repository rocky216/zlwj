import 'package:flutter/material.dart';
import 'package:gcwyzlwj/components/MyEmpty.dart';
import 'package:gcwyzlwj/components/MyHeader.dart';
import 'package:gcwyzlwj/components/MyStoreList.dart';
import 'package:gcwyzlwj/components/MyTag.dart';
import 'package:gcwyzlwj/redux/export.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  initial(current){
    StoreProvider.of<IndexState>(context).dispatch( getNews(context, params: {
      "current": current,
    }) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        goback: false,
        title: Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Text("我的消息"),
        ),
      ),
      body: Container(
        child: StoreConnector<IndexState, Map>(
          onInit: (Store store){
            if(store.state.app.news==null){
              initial(1);
            }
          },
          converter: (Store store)=>store.state.app.news,
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
                  // contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  onTap: (){
                    if(dataList[index]["msgType"] == "checkOrder"){
                      Navigator.of(context).pushNamed("/news/feedetail", arguments: dataList[index]);
                    }else if(dataList[index]["msgType"] == "checkExpend"){
                      Navigator.of(context).pushNamed("/news/expenddetail", arguments: dataList[index]);
                    }else if( dataList[index]["msgType"] == "checkPay" ){
                      Navigator.of(context).pushNamed("/news/incomedetail", arguments: dataList[index]);
                    }
                    else{
                      Navigator.of(context).pushNamed("/news/detail", arguments: dataList[index]);
                    }
                    
                  },
                  trailing: dataList[index]["isRead"]==0
                  ?Container(
                    width: 20.0,
                    child: const Icon(IconData(0xe6ee, fontFamily: "AntdIcons"), size: 20.0, color: Colors.orange,),
                  )
                  :Container(
                    width: 20.0,
                    child: const Icon(IconData(0xe6ee, fontFamily: "AntdIcons"), size: 20.0, color: Colors.blue,),
                  ),
                  title: Text(dataList[index]["msgTitle"], overflow: TextOverflow.ellipsis, maxLines: 1,),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(dataList[index]["msgInfo"], overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyle(fontSize: 14.0),),
                      Container(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Wrap(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 5.0),
                              child: MyTag(text: dataList[index]["heName"], ghost: true, bg: Colors.blue,),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 5.0),
                              child: MyTag(text: dataList[index]["strMsgType"], ghost: true, bg: Colors.blue,),
                            ),
                            
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            );
          }, 
        ),
      ),
    );
  }
}