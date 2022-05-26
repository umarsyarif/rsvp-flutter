part of 'konfigurasi_bloc.dart';

enum SeatCapacity  {none,available,full}

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
  final SeatCapacity seatCapacity;

  const KonfigurasiLoaded(this.data, {this.status = Status.loaded,this
      .errMessage = '',this.seatCapacity = SeatCapacity.none});
  @override
  List<Object> get props => [data,status,errMessage,seatCapacity];
  KonfigurasiLoaded copyWith(
      {DataKonfigurasi? data, Status? status, String? errMessage,
        SeatCapacity? seatCapacity})=>
      KonfigurasiLoaded(data??this.data,status: status??this.status,
        errMessage: errMessage??this.errMessage,seatCapacity:
          seatCapacity??this.seatCapacity);

}class KonfigurasiFailure extends KonfigurasiState {
  final String message;

  const KonfigurasiFailure(this.message);
}

