part of 'konfigurasi_bloc.dart';

abstract class KonfigurasiState extends Equatable {
  const KonfigurasiState();
  @override
  List<Object> get props => [];
}

class KonfigurasiInitial extends KonfigurasiState {

}
class KonfigurasiLoading extends KonfigurasiState {

}
class KonfigurasiLoaded extends KonfigurasiState {
  final DataKonfigurasi data;

  const KonfigurasiLoaded(this.data);

}class KonfigurasiFailure extends KonfigurasiState {
  final String message;

  const KonfigurasiFailure(this.message);
}

