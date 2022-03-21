part of 'notifikasi_bloc.dart';

abstract class NotifikasiEvent extends Equatable {
  const NotifikasiEvent();
  @override
  List<Object> get props => [];
}
class FetchNotifikasiEvent extends NotifikasiEvent{}
class ReadNotifikasi extends NotifikasiEvent{}
