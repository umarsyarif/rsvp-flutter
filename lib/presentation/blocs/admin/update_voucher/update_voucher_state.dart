part of 'update_voucher_bloc.dart';

abstract class UpdateVoucherState extends Equatable {
  const UpdateVoucherState();
  @override
  List<Object> get props => [];
}

class UpdateVoucherInitial extends UpdateVoucherState {

}
class UpdateVoucherLoading extends UpdateVoucherState {

}
class UpdateVoucherCreated extends UpdateVoucherState {

}
class UpdateVoucherFailure extends UpdateVoucherState {
  final String message;

  const UpdateVoucherFailure(this.message);
}
