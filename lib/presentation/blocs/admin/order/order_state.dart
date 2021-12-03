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

  const OrderLoaded(this.data);
}
class OrderDetailLoaded extends OrderState{
  final DataOrder data;

  const OrderDetailLoaded(this.data);
}
class OrderFailure extends OrderState {
  final String message;

  const OrderFailure(this.message);
}
