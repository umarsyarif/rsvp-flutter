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
  final Status status;
  final String errMessage;
  const MenuLoaded(this.menu, this.status, this.errMessage);
  @override
  List<Object> get props => [status,menu,errMessage];
  MenuLoaded copyWith({List<DataMenu>? menu, Status? status, String? errMessage})=>
      MenuLoaded( menu??this.menu,status??this.status,errMessage??this.errMessage);

}
class MenuFailure extends MenuState {
  final String message;

  MenuFailure(this.message);
}
