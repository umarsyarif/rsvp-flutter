part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState{}
class AuthSuccess extends AuthState{}
class AuthAuthenticated extends AuthState{
  final String role;

  const AuthAuthenticated(this.role);
}
class AuthUnauthenticated extends AuthState{}
