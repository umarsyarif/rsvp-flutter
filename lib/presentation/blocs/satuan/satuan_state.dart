part of 'satuan_bloc.dart';

abstract class SatuanState extends Equatable {
  const SatuanState();
  @override
  List<Object> get props => [];
}

class SatuanInitial extends SatuanState {

}
class SatuanLoading extends SatuanState {

}
class SatuanLoaded extends SatuanState {
  final Status status;
  final List<DataSatuan> data;
  final String errMessage;

  const SatuanLoaded(this.status, this.data, {this.errMessage=''});
  @override
  List<Object> get props => [status,data,errMessage];
  SatuanLoaded copyWith({Status? status, List<DataSatuan>? data,String? errMessage})=>
      SatuanLoaded(status??this.status, data??this.data,errMessage: errMessage??this.errMessage);

}
class SatuanFailure extends SatuanState {
  final String message;

  const SatuanFailure(this.message);
}
