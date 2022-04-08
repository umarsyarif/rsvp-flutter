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
  final int proses,paid,notifikasi;
  final List<DataMenu> dataMakanan;
  final List<DataMenu> dataMinuman;
  final List<DataVoucher> dataVoucher;
  const HomeAdminLoaded(this.proses, this.paid,this.notifikasi,this.dataMakanan,this.dataMinuman, this.dataVoucher);
}
class HomeAdminFailure extends HomeAdminState {
  final String message;

  const HomeAdminFailure(this.message);
}
class HomeAdminLogout extends HomeAdminState {

}
