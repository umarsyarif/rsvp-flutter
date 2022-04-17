part of 'update_voucher_bloc.dart';

abstract class UpdateVoucherEvent extends Equatable {
  const UpdateVoucherEvent();
  @override
  List<Object> get props => [];
}
class UpdateDataVoucherEvent extends UpdateVoucherEvent{
  final VoucherParams params;

  const UpdateDataVoucherEvent(this.params);
}
