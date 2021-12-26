part of 'dashboard_client_bloc.dart';

abstract class DashboardClientEvent extends Equatable {
  const DashboardClientEvent();
  @override
  List<Object> get props => [];
}
class FetchDashboardClientEvent extends DashboardClientEvent{}
