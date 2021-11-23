part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}
class StartLogin extends LoginEvent{
  final LoginParams params;

  StartLogin(this.params);
}
