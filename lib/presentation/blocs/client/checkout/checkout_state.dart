part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {

}
class CheckoutLoading extends CheckoutState {

}
class CheckoutLoaded extends CheckoutState {
  final List<DataVoucher> data;
  final Status status;
  final String errMessage;
  final String id;
  final User user;
  final int? idVoucher;
  final int poin;
  const CheckoutLoaded(this.data, this.status, this.user, this.poin,  {this.errMessage='',this.id='',this.idVoucher,});
  @override
  List<Object?> get props => [data,status,errMessage,id,poin,user,idVoucher];
  CheckoutLoaded copyWith({List<DataVoucher>? data,int? poin ,Status? status, String? errMessage,String? id, User? user,int? idVoucher})=>
      CheckoutLoaded(data??this.data, status??this.status,user??this.user,poin??this.poin,errMessage: errMessage??this.errMessage,id: id??this.id,idVoucher: idVoucher??this.idVoucher);

}
class CheckoutFailure extends CheckoutState {
  final String message;

  const CheckoutFailure(this.message);
}
class CheckoutSuccess extends CheckoutState {
  final String id;

  CheckoutSuccess(this.id);


}
