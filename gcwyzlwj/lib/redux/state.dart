import 'package:gcwyzlwj/redux/app/state.dart';
import 'package:gcwyzlwj/redux/crmt/state.dart';
import 'package:gcwyzlwj/redux/daily/state.dart';
import 'package:gcwyzlwj/redux/repair/state.dart';

class IndexState {
  
  AppState app;
  CrmtState crmt;
  DailyState daily;
  RepairState repair;

  IndexState(this.app, this.crmt, this.daily, this.repair);

  factory IndexState.initial(){
    return IndexState(
      AppState.initial(),
      CrmtState.initial(),
      DailyState.initial(),
      RepairState.initial()
    );
  }

}

