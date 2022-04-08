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
  final Status status;
  final String errMessage;

  const VoucherLoaded(this.data, this.status, this.errMessage);
  @override
  List<Object> get props => [data,status,errMessage];

  VoucherLoaded copyWith({List<DataVoucher>? data,Status? status,String? errMessage})=>
      VoucherLoaded(data??this.data, status??this.status, errMessage??this.errMessage);

}
class VoucherCreated extends VoucherState {

}
class VoucherFailure extends VoucherState {
  final String message;

  const VoucherFailure(this.message);
}
