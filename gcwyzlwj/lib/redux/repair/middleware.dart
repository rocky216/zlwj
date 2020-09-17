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
        data["list"].insertAll(0,map["list"]);
        store.dispatch(PersonRepairAction(data));
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
        data["list"].insertAll(0,map["list"]);
        store.dispatch(ToRepairAction(data));
      }
      
    }catch(e){
      print(e);
    }
    
  };
}


