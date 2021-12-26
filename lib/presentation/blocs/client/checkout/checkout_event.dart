part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();
  @override
  List<Object> get props => [];
}
class PostCheckout extends CheckoutEvent{
  final PurchaseOrderParams params;

  PostCheckout(this.params);
}
class FetchChekcoutEvent extends CheckoutEvent{}
