part of 'redeem_voucher_bloc.dart';

abstract class RedeemVoucherEvent extends Equatable {
  const RedeemVoucherEvent();
  @override
  List<Object> get props => [];
}
class FetchRedeemVoucherEvent extends RedeemVoucherEvent{}
class SaveRedeemVoucherEvent extends RedeemVoucherEvent{
  final DataVoucher data;

  const SaveRedeemVoucherEvent(this.data);
}
