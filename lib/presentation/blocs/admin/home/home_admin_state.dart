part of 'home_admin_bloc.dart';

abstract class HomeAdminState extends Equatable {
  const HomeAdminState();
  @override
  List<Object> get props => [];
}

class HomeAdminInitial extends HomeAdminState {

}
class HomeAdminLoading extends HomeAdminState {

}
class HomeAdminLoaded extends HomeAdminState {
  final int proses,paid,selesai;

  const HomeAdminLoaded(this.proses, this.paid, this.selesai);
}
class HomeAdminFailure extends HomeAdminState {
  final String message;

  const HomeAdminFailure(this.message);
}
class HomeAdminLogout extends HomeAdminState {

}
