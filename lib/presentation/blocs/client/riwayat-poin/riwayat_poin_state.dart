part of 'riwayat_poin_bloc.dart';

abstract class RiwayatPoinState extends Equatable {
  const RiwayatPoinState();
  @override
  List<Object> get props => [];
}

class RiwayatPoinInitial extends RiwayatPoinState {

}
class RiwayatPoinLoading extends RiwayatPoinState {

}
class RiwayatPoinLoaded extends RiwayatPoinState {
  final List<DataRiwayatPoin> data;
  final int poin;
  const RiwayatPoinLoaded(this.data, this.poin);

}
class RiwayatPoinFailure extends RiwayatPoinState {
  final String message;

  RiwayatPoinFailure(this.message);
}
