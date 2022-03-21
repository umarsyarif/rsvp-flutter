part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
  @override
  List<Object> get props => [];
}
class FetchOrderEvent extends OrderEvent{
  final String status;
  final String start;
  final String end;

  const FetchOrderEvent(this.status, {this.start = '', this.end = ''});
}
class FetchDetailOrderEvent extends OrderEvent{
  final int id;

  const FetchDetailOrderEvent(this.id);
}
class UpdateStatusOrderEvent extends OrderEvent{
  final UpdateStatusParams params;

  const UpdateStatusOrderEvent(this.params);
}
