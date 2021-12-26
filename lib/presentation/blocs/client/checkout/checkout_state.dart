part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
  @override
  List<Object> get props => [];
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
  const CheckoutLoaded(this.data, this.status, this.user, {this.errMessage='',this.id=''});
  @override
  List<Object> get props => [data,status,errMessage,id,user];
  CheckoutLoaded copyWith({List<DataVoucher>? data, Status? status, String? errMessage,String? id, User? user})=>
      CheckoutLoaded(data??this.data, status??this.status,user??this.user,errMessage: errMessage??this.errMessage,id: id??this.id);

}
class CheckoutFailure extends CheckoutState {
  final String message;

  const CheckoutFailure(this.message);
}
class CheckoutSuccess extends CheckoutState {
  final String id;

  CheckoutSuccess(this.id);


}
