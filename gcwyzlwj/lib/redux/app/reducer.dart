import 'package:gcwyzlwj/redux/app/action.dart';
import 'package:gcwyzlwj/redux/app/state.dart';

AppState appReducer( AppState state, action ){

  if(action is UserInfoAction){
    return AppState(user: action.user, mail: state.mail, news: state.news,);
  }

  if(action is MailListAction){
    return AppState(mail: action.mail, user: state.user, news: state.news,);
  }

  if(action is NewsListAction){
    return AppState(news: action.news, mail: state.mail, user: state.user);
  }

  return AppState();
}