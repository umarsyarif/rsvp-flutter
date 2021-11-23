part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {

}
class LoginLoading extends LoginState {

}
class LoginSuccess extends LoginState {
  final String role;

  const LoginSuccess(this.role);
}
class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message);
}
