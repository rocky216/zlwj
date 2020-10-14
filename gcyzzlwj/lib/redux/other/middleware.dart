import 'package:gcyzzlwj/redux/export.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<IndexState> getCleanList(context, {params, next}){
  return (Store<IndexState> store) async {
    try{
      var map = store.state.other.clean; 
      var data = await NetHttp.request("/api/app/owner/myJournal/myRepair", context, params: params);
      
      if(map == null || params["current"]==1 ){
        store.dispatch(CleanAction(data));
      }else{
        data["list"].insertAll(0,map["list"]);
        store.dispatch(CleanAction(data));
      }

    }catch(e){
      print(e);
    }
  };
}