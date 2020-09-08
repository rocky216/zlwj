import 'package:flutter/cupertino.dart';
import 'package:gcwyzlwj/redux/app/action.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<IndexState> getMailList(context, {@required params, next}){
  return (Store<IndexState> store) async {
    try{
      var data = await NetHttp.request("/api/app/property/message/selectLinkman", context, params: {});
      store.dispatch(MailListAction(data));
    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getUsers(context, {@required params, next}){
  return (Store<IndexState> store) async {
    try{
      var data = await NetHttp.request("/api/app/property/message/userInfo", context, params: {});
      store.dispatch(UserInfoAction(data));
    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getNews(context, {@required params, next}){
  return (Store<IndexState> store) async {
    try{
      var map = store.state.app.news;
      var data = await NetHttp.request("/api/app/property/ManagMessage/selectManagMessage", context, params:params);
      
      if(map == null || params["current"]==1){
        store.dispatch( NewsListAction(data) );
      }else{
        map["list"].addAll(data["list"]);
        store.dispatch(NewsListAction(map));
      }
    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getChangeNewsStatus(id){
  return (Store<IndexState> store) async {
    try{
      var map = store.state.app.news;
      if(map!= null){
        int index = (map["list"] as List).indexWhere((o)=>o["id"]==id);
        map["list"][index]["isRead"] = 1;
        store.dispatch(NewsListAction(map));
      }
    }catch(e){
      print(e);
    }
  };
}
