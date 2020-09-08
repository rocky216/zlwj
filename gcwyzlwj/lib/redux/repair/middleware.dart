import 'package:flutter/cupertino.dart';
import 'package:gcwyzlwj/redux/export.dart';
import 'package:gcwyzlwj/redux/repair/action.dart';
import 'package:gcwyzlwj/utils/http.dart';
import 'package:redux_thunk/redux_thunk.dart';


ThunkAction<IndexState> getPersonRepair(context, {@required params, next}){
  return (Store<IndexState> store) async {
    try{
      Map map = store.state.repair.person;
      var data = await NetHttp.request("/api/app/property/repair/userReapir", context, params: params);
      
      if(map == null || params["current"]==1){
        store.dispatch( PersonRepairAction(data) );
      }else{
        map["list"].addAll(data["list"]);
        store.dispatch(PersonRepairAction(map));
      }
      
    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getToRepair(context, {@required params, next, bool}){
  return (Store<IndexState> store) async {
    try{
      Map map = store.state.repair.torepair;
      var data = await NetHttp.request("/api/app/property/repair/allRepair", context, params: params);
      
      if(map == null || params["current"]==1){
        store.dispatch( ToRepairAction(data) );
      }else{
        map["list"].addAll(data["list"]);
        store.dispatch(ToRepairAction(map));
      }
      
    }catch(e){
      print(e);
    }
    
  };
}


