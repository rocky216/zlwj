
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcyzzlwj/components/MyCard.dart';
import 'package:gcyzzlwj/components/MyHeader.dart';
import 'package:gcyzzlwj/components/MySimpleList.dart';
import 'package:gcyzzlwj/components/MySimpleStoreList.dart';
import 'package:gcyzzlwj/redux/export.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:gcyzzlwj/utils/index.dart';

class UserFamilyPage extends StatefulWidget {
  UserFamilyPage({Key key}) : super(key: key);

  @override
  _UserFamilyPageState createState() => _UserFamilyPageState();
}

class _UserFamilyPageState extends State<UserFamilyPage> {

  @override
  void initState() { 
    super.initState();
    
  }

  initial(){
    StoreProvider.of<IndexState>(context).dispatch( getFamilyList(context) );
  }

  delete(item, f) async {
    var data = await NetHttp.request("/api/app/owner/my/deleteMember", context, method: "post", params: {
      "id": item["id"].toString(),
      "type": item["type"]=="1"?"house":"shops",
      "ownerId": f["id"].toString()
    });
    if(data != null){
      showToast("删除成功！");
      StoreProvider.of<IndexState>(context).dispatch( getFamilyList(context) );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyHeader(
        title: "家庭成员",
      ),
      body: StoreConnector<IndexState, List>(
        onInit: (store){
          store.dispatch( getFamilyList(context) );
          
        },
        converter: (store)=>store.state.other.family,
        builder: (context, state){
          return MySimpleStoreList(
            getRefresh: (){
              this.initial();
            }, 
            data: state, 
            itemBuilder: (i){
              return Column(
                children: [
                  Container(
                    child: MyCard(
                      title: Text(state[i]["heAssetsCode"]),
                      extra: state[i]["isModify"]==1?FlatButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed("/user/addfamily", arguments: state[i]);
                        },
                        child: Text("添加成员", style: TextStyle(color: Colors.blue),),
                      ):null,
                      child: Column(
                        children: (state[i]["heOwnersList"] as List).map((f) => 
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text("${f["name"]}(${f["filiationStr"]})"),
                            trailing: state[i]["isModify"]==1 && f["isChange"] == 0?
                              GestureDetector(
                              onTap: (){
                                confirmDialog(context, title: Text("是否删除?"), ok: (){
                                  this.delete(state[i], f);
                                });
                              },
                              child: Icon(Icons.delete_outline),
                            ):null,
                          )
                        ).toList(),
                      ),
                      
                    ),
                    
                  )
                ],
              );
            }
          );
        },
      ),
    );
  }
}