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
      "pageSize":"10"
    }) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
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
                  onTap: (){
                    Navigator.of(context).pushNamed("/news/detail", arguments: dataList[index]);
                  },
                  trailing: Container(
                    width: 20.0,
                    child: Icon(IconData(0xe6ee, fontFamily: "AntdIcons"), size: 20.0, 
                      color: dataList[index]["isRead"]==0?Colors.orange:Colors.blue,),
                  ),
                  title: Text(dataList[index]["msgTitle"], overflow: TextOverflow.ellipsis, maxLines: 1,),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(dataList[index]["msgInfo"], overflow: TextOverflow.ellipsis, maxLines: 2,),
                      Container(
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