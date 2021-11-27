part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();
  @override
  List<Object> get props => [];
}

class MenuInitial extends MenuState {

}
class MenuLoading extends MenuState {

}
class MenuLoadedAdd extends MenuState {
  final List<DataSatuan> satuan;
  final Status status;
  final String errMessage;

  const MenuLoadedAdd(this.status, {this.errMessage='', required this.satuan});
  @override
  List<Object> get props => [status,satuan,errMessage];
  MenuLoadedAdd copyWith({List<DataSatuan>? satuan, Status? status, String? errMessage})=>
      MenuLoadedAdd(status??this.status, satuan: satuan??this.satuan,errMessage: errMessage??this.errMessage);
}
class MenuLoaded extends MenuState{
  final List<DataMenu> menu;

  MenuLoaded(this.menu);

}
class MenuFailure extends MenuState {
  final String message;

  MenuFailure(this.message);
}
