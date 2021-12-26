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

  const DashboardClientLoaded(this.data);
}
class DashboardClientFailure extends DashboardClientState {
  final String message;

  const DashboardClientFailure(this.message);
}
