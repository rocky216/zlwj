class AppState {
  List mail;
  Map user;
  Map news;

  AppState({this.user, this.mail, this.news});

  factory AppState.initial(){
    return AppState();
  }
}