part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {

}
class AccountLoading extends AccountState {

}
class AccountLoaded extends AccountState {
  final User user;

  const AccountLoaded(this.user);

}
class AccountFailure extends AccountState {

}
class AccountLogout extends AccountState{}
