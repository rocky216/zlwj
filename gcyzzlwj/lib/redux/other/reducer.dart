
import 'package:gcyzzlwj/redux/other/action.dart';
import 'package:gcyzzlwj/redux/other/state.dart';

OtherState otherReducer(OtherState state, action){
  if(action is CleanAction){
    return OtherState(clean: action.clean, card: state.card, family: state.family);
  }
  if(action is CardAction){
    return OtherState(card: action.card, clean: state.clean, family: state.family);
  }

  if( action is FamilyAction ){
    return OtherState(family: action.family, clean: state.clean, card: state.card);
  }

  return OtherState();
}