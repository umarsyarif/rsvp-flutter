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
  final bool isReview;
  final Status status;
  final String errMessage;
  final String idUser;
  const OrderLoaded(this.data, this.start, this.end,{this.isReview = false,
    this.status = Status.loaded,this.errMessage = '',required this.idUser});
  @override
  List<Object> get props => [data,start,end,isReview,status,errMessage];
  OrderLoaded copyWith({List<DataOrder>? data,String? start, String? end,
    bool? isReview, Status? status, String? errMessage})=>OrderLoaded
    (data??this.data, start??this.start, end??this.end,isReview:
  isReview??this.isReview,status: status??this.status,errMessage:
  errMessage??this.errMessage,idUser: idUser);
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
