part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props =>[];
}
class StartLogin extends AuthEvent{
}
class AppStart extends AuthEvent{}
