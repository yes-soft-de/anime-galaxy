class AuthState {}

class AuthStateSuccess extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateCodeSent extends AuthState {}

class AuthStateError extends AuthState {
  String errorMsg;
  AuthStateError(this.errorMsg);
}

class AuthStateInit extends AuthState {}

//-----------------------
class LoginStateSuccess extends AuthState {}


class LoginStateError extends AuthState {}

class LoginStateInit extends AuthState {}

//------------------------
class RegisterStateSuccess extends AuthState {}


class RegisterStateError extends AuthState { }

class RegisterStateInit extends AuthState {}
