part of 'home_admin_bloc.dart';

abstract class HomeAdminState extends Equatable {
  const HomeAdminState();
  @override
  List<Object> get props => [];
}

class HomeAdminInitial extends HomeAdminState {

}
class HomeAdminLogout extends HomeAdminState {

}
