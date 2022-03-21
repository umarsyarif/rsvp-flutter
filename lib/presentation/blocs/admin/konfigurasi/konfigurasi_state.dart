part of 'konfigurasi_bloc.dart';

abstract class KonfigurasiState extends Equatable {
  const KonfigurasiState();
  @override
  List<Object> get props => [];
}

class KonfigurasiInitial extends KonfigurasiState {

}
class KonfigurasiLogout extends KonfigurasiState {

}
class KonfigurasiLoading extends KonfigurasiState {

}
class KonfigurasiLoaded extends KonfigurasiState {
  final DataKonfigurasi data;
  final Status status;
  final String errMessage;

  const KonfigurasiLoaded(this.data, {this.status = Status.loaded,this.errMessage = ''});
  @override
  List<Object> get props => [data,status,errMessage];
  KonfigurasiLoaded copyWith(
      {DataKonfigurasi? data, Status? status, String? errMessage})=>
      KonfigurasiLoaded(data??this.data,status: status??this.status,errMessage: errMessage??this.errMessage);

}class KonfigurasiFailure extends KonfigurasiState {
  final String message;

  const KonfigurasiFailure(this.message);
}

