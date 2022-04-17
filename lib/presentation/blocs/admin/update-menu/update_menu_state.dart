part of 'update_menu_bloc.dart';

abstract class UpdateMenuState extends Equatable {
  const UpdateMenuState();
  @override
  List<Object> get props => [];
}

class UpdateMenuInitial extends UpdateMenuState {

}
class UpdateMenuLoading extends UpdateMenuState{}

class UpdateMenuFailure extends UpdateMenuState{
  final String message;

  const UpdateMenuFailure(this.message);

}
class UpdateMenuLoaded extends UpdateMenuState{
  final List<DataSatuan> satuan;
  final Status status;
  final String errMessage;

  const UpdateMenuLoaded(this.status, {this.errMessage='', required this.satuan});
  @override
  List<Object> get props => [status,satuan,errMessage];
  UpdateMenuLoaded copyWith({List<DataSatuan>? satuan, Status? status, String? errMessage})=>
      UpdateMenuLoaded(status??this.status, satuan: satuan??this.satuan,errMessage: errMessage??this.errMessage);
}
