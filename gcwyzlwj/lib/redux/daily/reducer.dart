import 'package:gcwyzlwj/redux/daily/action.dart';
import 'package:gcwyzlwj/redux/daily/state.dart';

DailyState dailyReducer(DailyState state, action){

  if( action is DailyRecordAction ){
    return DailyState(record: action.record);
  }
  if(action is DailyInspectAction){
    return DailyState(inspect: action.inspect);
  }

  return DailyState();

}