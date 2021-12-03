part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
  @override
  List<Object> get props => [];
}
class FetchOrderEvent extends OrderEvent{}
class FetchDetailOrderEvent extends OrderEvent{
  final int id;

  const FetchDetailOrderEvent(this.id);
}
