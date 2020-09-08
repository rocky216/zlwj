import 'package:flutter/cupertino.dart';
import 'package:gcwyzlwj/redux/daily/action.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<IndexState> getMyPatrol(context, {@required params, next}){
  return (Store<IndexState> store) async {
    try{
      var data = await NetHttp.request("/api/app/property/ppPatrolRecord/", context, params: params);
      store.dispatch( DailyRecordAction(data) );
    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getInspects(context, {@required params, next}){
  return (Store<IndexState> store) async {
    try{
      var map = store.state.daily.inspect;
      var data = await NetHttp.request("/api/app/property/patrol/listPage", context, params: params);
      if(map == null || params["current"]==1){
        store.dispatch(DailyInspectAction(data));
      }else{
        map["list"].addAll(data["list"]);
        store.dispatch(DailyInspectAction(map));
      }
    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> addInspects(Map obj){
  return (Store<IndexState> store) async {
    try{
      var map = store.state.daily.inspect;
      if(map == null){
        map={"current":1, "total": 1, "list": [obj]};
        store.dispatch(DailyInspectAction(map));
      }else{
        map["list"].insert(0, obj);
        map["total"]=map["total"]+1;
        store.dispatch(DailyInspectAction(map));
      }
    }catch(e){
      print(e);
    }
  };
}