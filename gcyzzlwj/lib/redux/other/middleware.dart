import 'package:gcyzzlwj/redux/export.dart';
import 'package:gcyzzlwj/utils/http.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<IndexState> getCleanList(context, {params, next}){
  return (Store<IndexState> store) async {
    try{
      var map = store.state.other.clean; 
      var data = await NetHttp.request("/api/app/owner/myJournal/heRepair", context, params: params, isloading: false);
      
      if(map == null || params["current"]==1 || params["current"]=="1" ){
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

ThunkAction<IndexState> getCardList(context, {params, next}){
  return (Store<IndexState> store) async {
    try{
      var data = await NetHttp.request("/api/app/owner/my/cardInfo", context, params: {});
      if(data != null){
        store.dispatch( CardAction(data) );
      }
    }catch(e){
      print(e);
    }
  };
}

ThunkAction<IndexState> getFamilyList(context, {params, next}){
  return (Store<IndexState> store) async {
    try{
      var data = await NetHttp.request("/api/app/owner/my/familyMember", context, params: {});
      if(data != null){
        store.dispatch( FamilyAction(data) );
      }
    }catch(e){
      print(e);
    }
  };
}