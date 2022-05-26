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
class UbahProfilRestoranEvent extends KonfigurasiEvent{
  final String profil;
  final String linkGmaps;

  const UbahProfilRestoranEvent(this.profil, this.linkGmaps);
}
class UbahKapasitasRestoranEvent extends KonfigurasiEvent{
  final int kapasitasRestoran;

  const UbahKapasitasRestoranEvent(this.kapasitasRestoran);
}
class CheckSeatEvent extends KonfigurasiEvent{
  final String date;
  final String jumlahOrang;

  const CheckSeatEvent(this.date, this.jumlahOrang);
}