part of 'voucher_bloc.dart';

abstract class VoucherState extends Equatable {
  const VoucherState();
  @override
  List<Object> get props => [];
}

class VoucherInitial extends VoucherState {

}
class VoucherLoading extends VoucherState {

}
class VoucherLoaded extends VoucherState {
  final List<DataVoucher> data;

  VoucherLoaded(this.data);
}
class VoucherCreated extends VoucherState {

}
class VoucherFailure extends VoucherState {
  final String message;

  const VoucherFailure(this.message);
}
