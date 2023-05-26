abstract class UserState {}

// Initial, Success, Error, Loading
class InitialUserState extends UserState {}

class SuccessUserState extends UserState {
  final bool login;
  SuccessUserState(this.login);
}

class LoadingUserState extends UserState {}

class ErrorUserState extends UserState {
  final String message;

  ErrorUserState(this.message);
}
