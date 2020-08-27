import 'package:gcwyzlwj/redux/crmt/action.dart';
import 'package:gcwyzlwj/redux/crmt/state.dart';

CrmtState crmtReducer(CrmtState state, action){
  if( action is CrmtFeeAction ){
    return CrmtState(fee: action.fee, expend: state.expend, income: state.income, examerr: state.examerr,);
  }
  if(action is CrmtExpendAction){
    return CrmtState(expend: action.expend, fee: state.fee, income: state.income, examerr: state.examerr);
  }
  if(action is CrmtIncomeAction){
    return CrmtState(income: action.income, expend: state.expend, fee: state.fee, examerr: state.examerr);
  }
  if(action is CrmtExamerrAction){
    return CrmtState(examerr: action.examerr, income: state.income, expend: state.expend, fee: state.fee);
  }
  
  return state;
}