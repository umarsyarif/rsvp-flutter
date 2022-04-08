part of 'voucher_bloc.dart';

abstract class VoucherEvent extends Equatable {
  const VoucherEvent();
  @override
  List<Object> get props => [];
}
class CreateVoucherEvent extends VoucherEvent{
  final VoucherParams params;

  const CreateVoucherEvent(this.params);
}
class FetchAllVoucherEvent extends VoucherEvent{}
class UpdateVoucherEvent extends VoucherEvent{
  final UpdateActiveMenuParams params;

  const UpdateVoucherEvent(this.params);
}
