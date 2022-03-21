part of 'konfigurasi_bloc.dart';

abstract class KonfigurasiEvent extends Equatable {
  const KonfigurasiEvent();
  @override
  List<Object> get props => [];
}
class FetchKonfigurasiEvent extends KonfigurasiEvent{}
class LogoutEvent extends KonfigurasiEvent{}
class UbahKonfigurasiEvent extends KonfigurasiEvent{
  final String jamBuka;
  final String jamTutup;

  const UbahKonfigurasiEvent(this.jamBuka, this.jamTutup);
}