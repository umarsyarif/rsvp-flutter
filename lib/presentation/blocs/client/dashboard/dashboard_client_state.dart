part of 'dashboard_client_bloc.dart';

abstract class DashboardClientState extends Equatable {
  const DashboardClientState();
  @override
  List<Object> get props => [];
}

class DashboardClientInitial extends DashboardClientState {

}
class DashboardClientLoading extends DashboardClientState {

}
class DashboardClientLoaded extends DashboardClientState {
  final List<DataVoucher> data;
  final User user;
  final int notifikasi;

  const DashboardClientLoaded(this.data, this.user, this.notifikasi);
}
class DashboardClientFailure extends DashboardClientState {
  final String message;

  const DashboardClientFailure(this.message);
}
