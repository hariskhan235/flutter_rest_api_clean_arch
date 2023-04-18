abstract class LoginUserStates {
  LoginUserStates();
}

class LoginInitialState extends LoginUserStates {}

class LoginErrorState extends LoginUserStates {
  final String message;
  LoginErrorState(this.message);
}

class LoggedInState extends LoginUserStates {
  final dynamic value;

  LoggedInState(this.value);
}
