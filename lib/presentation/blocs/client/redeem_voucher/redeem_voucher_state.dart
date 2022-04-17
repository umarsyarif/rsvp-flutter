part of 'redeem_voucher_bloc.dart';

abstract class RedeemVoucherState extends Equatable {
  const RedeemVoucherState();
  @override
  List<Object?> get props => [];
}

class RedeemVoucherInitial extends RedeemVoucherState {

}
class RedeemVoucherLoading extends RedeemVoucherState {

}
class RedeemVoucherLoaded extends RedeemVoucherState {
  final Status status;
  final List<DataVoucher> data;
  final DataVoucher? claimed;

  const RedeemVoucherLoaded(this.status, this.data, this.claimed);
  @override
  List<Object?> get props => [status,data,claimed];
  RedeemVoucherLoaded copyWith({Status? status, List<DataVoucher>? data, DataVoucher? claimed})=>
      RedeemVoucherLoaded(status??this.status, data??this.data, claimed??this.claimed);
}
class RedeemVoucherFailure extends RedeemVoucherState {
  final String message;
  const RedeemVoucherFailure(this.message);
}
