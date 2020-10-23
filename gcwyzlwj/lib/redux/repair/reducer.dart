import 'package:gcwyzlwj/redux/repair/action.dart';
import 'package:gcwyzlwj/redux/repair/state.dart';


RepairState repairReducer(RepairState state, action){
  if(action is PersonRepairAction){
    
    return RepairState(person: action.person);
  }
  if(action is ToRepairAction){
    return RepairState(torepair: action.torepair);
  }
  return state;
}