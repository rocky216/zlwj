import 'package:gcwyzlwj/redux/crmt/action.dart';
import 'package:gcwyzlwj/redux/crmt/state.dart';

CrmtState crmtReducer(CrmtState state, action){
  if( action is CrmtFeeAction ){
    return CrmtState(fee: action.fee);
  }
  if(action is CrmtExpendAction){
    return CrmtState(expend: action.expend);
  }
  if(action is CrmtIncomeAction){
    return CrmtState(income: action.income);
  }
  if(action is CrmtExamerrAction){
    return CrmtState(examerr: action.examerr);
  }
  if(action is CrmtExamexpendAction){
    return CrmtState(examexpend:action.examexpend);
  }
  if(action is CrmtExamincomeAction){
    return CrmtState(examincome:action.examincome);
  }

  // if( action is CrmtFeeAction ){
  //   return CrmtState(fee: action.fee, expend: state.expend, income: state.income, examerr: state.examerr, examexpend:state.examexpend, examincome:state.examincome);
  // }
  // if(action is CrmtExpendAction){
  //   return CrmtState(expend: action.expend, fee: state.fee, income: state.income, examerr: state.examerr, examexpend:state.examexpend, examincome:state.examincome);
  // }
  // if(action is CrmtIncomeAction){
  //   return CrmtState(income: action.income, expend: state.expend, fee: state.fee, examerr: state.examerr, examexpend:state.examexpend, examincome:state.examincome);
  // }
  // if(action is CrmtExamerrAction){
  //   return CrmtState(examerr: action.examerr, income: state.income, expend: state.expend, fee: state.fee, examexpend:state.examexpend, examincome:state.examincome);
  // }
  // if(action is CrmtExamexpendAction){
  //   return CrmtState(examexpend:action.examexpend, examerr: state.examerr, income: state.income, expend: state.expend, fee: state.fee, examincome:state.examincome );
  // }
  // if(action is CrmtExamincomeAction){
  //   return CrmtState(examincome:action.examincome, examexpend:state.examexpend, examerr: state.examerr, income: state.income, expend: state.expend, fee: state.fee);
  // }
  
  return CrmtState();
}