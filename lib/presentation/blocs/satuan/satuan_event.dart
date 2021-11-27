part of 'satuan_bloc.dart';

abstract class SatuanEvent extends Equatable {
  const SatuanEvent();
  @override
  List<Object> get props => [];
}

class AddSatuan extends SatuanEvent{
  final SatuanParams params;
  const AddSatuan(this.params);
}
class FetchSatuanEvent extends SatuanEvent{}

