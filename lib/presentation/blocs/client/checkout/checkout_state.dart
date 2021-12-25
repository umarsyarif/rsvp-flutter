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
class CheckoutSuccess extends CheckoutState {
  final String id;

  CheckoutSuccess(this.id);


}
class CheckoutFailure extends CheckoutState {
  final String message;

  const CheckoutFailure(this.message);
}
