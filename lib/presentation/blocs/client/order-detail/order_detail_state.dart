part of 'order_detail_bloc.dart';

abstract class OrderDetailState extends Equatable {
  const OrderDetailState();
  @override
  List<Object> get props => [];
}

class OrderDetailInitial extends OrderDetailState {

}
class OrderDetailLoading extends OrderDetailState {

}
class OrderDetailLoaded extends OrderDetailState {
  final List<QuantityOrderParams> makanan;
  final List<QuantityOrderParams> minuman;
  final Status status;
  final String errMessage;
  final User user;

  const OrderDetailLoaded(this.makanan,this.minuman, this.status, this.user, {this.errMessage=''});
  @override
  List<Object> get props => [makanan,minuman, status, errMessage,user];

  OrderDetailLoaded copyWith({List<QuantityOrderParams>? makanan,List<QuantityOrderParams>? minuman ,Status? status, String? errMessage})=>
      OrderDetailLoaded(makanan??this.makanan,minuman??this.minuman, status??this.status,user,errMessage: errMessage??this.errMessage);

}
class OrderDetailFailure extends OrderDetailState {
  final String message;
  const OrderDetailFailure(this.message);
}

