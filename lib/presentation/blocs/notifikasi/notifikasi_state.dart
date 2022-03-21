part of 'notifikasi_bloc.dart';

abstract class NotifikasiState extends Equatable {
  const NotifikasiState();
  @override
  List<Object> get props => [];
}

class NotifikasiInitial extends NotifikasiState {

}
class NotifikasiLoading extends NotifikasiState {

}
class NotifikasiLoaded extends NotifikasiState {
  final List<DataNotifikasi> data;

  NotifikasiLoaded(this.data);
}
class NotifikasiFailure extends NotifikasiState {
  final String message;

  NotifikasiFailure(this.message);
}
