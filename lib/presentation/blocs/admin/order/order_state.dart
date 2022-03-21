part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {

}
class OrderLoading extends OrderState {

}
class OrderLoaded extends OrderState {
  final List<DataOrder> data;
  final String start,end;
  const OrderLoaded(this.data, this.start, this.end);
}
class OrderDetailLoaded extends OrderState{
  final DataOrder data;
  final Status status;
  final String errMessage;
  final User user;
  @override
  List<Object> get props => [data,status,errMessage,user];
  const OrderDetailLoaded(this.data, this.status,  this.user, {this.errMessage=''});
  OrderDetailLoaded copyWith({DataOrder? data,Status? status,String? errMessage,User? user})=>
      OrderDetailLoaded(data??this.data, status??this.status, user??this.user,errMessage: errMessage??this.errMessage);
}
class OrderFailure extends OrderState {
  final String message;

  const OrderFailure(this.message);
}
