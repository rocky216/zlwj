import 'package:gcwyzlwj/redux/app/reducer.dart';
import 'package:gcwyzlwj/redux/crmt/reducer.dart';
import 'package:gcwyzlwj/redux/daily/reducer.dart';
import 'package:gcwyzlwj/redux/repair/reducer.dart';
import 'package:gcwyzlwj/redux/state.dart';

IndexState reducers(IndexState state, action){
  return IndexState(
    appReducer(state.app, action),
    crmtReducer(state.crmt, action),
    dailyReducer(state.daily, action),
    repairReducer(state.repair, action)
  );
}