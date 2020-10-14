
import 'package:gcyzzlwj/redux/other/action.dart';
import 'package:gcyzzlwj/redux/other/state.dart';

OtherState otherReducer(OtherState state, action){
  if(action is CleanAction){
    return OtherState(clean: action.clean);
  }

  return state;
}