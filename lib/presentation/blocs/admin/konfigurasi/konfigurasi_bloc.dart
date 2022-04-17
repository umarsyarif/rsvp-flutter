import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/data/models/konfigurasi_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/logout.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_konfigurasi.dart';
import 'package:kopiek_resto/domain/usecases/data-master/update_konfigurasi.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'konfigurasi_event.dart';
part 'konfigurasi_state.dart';

@injectable
class KonfigurasiBloc extends Bloc<KonfigurasiEvent, KonfigurasiState> {
  final GetKonfigurasi konfigurasi;
  final Logout logout;
  final LoadingBloc loadingBloc;
  final UpdateKonfigurasi updateKonfigurasi;
  KonfigurasiBloc(this.konfigurasi, this.logout, this.loadingBloc, this.updateKonfigurasi) : super(KonfigurasiInitial()) {
    on<FetchKonfigurasiEvent>((event, emit) async {
      emit(KonfigurasiLoading());
      final eith = await konfigurasi.call(NoParams());
      eith.fold((l) => emit(KonfigurasiFailure(l.message)), (r) => emit(KonfigurasiLoaded(r)));
    });
    on<LogoutEvent>((event, emit) async {
      emit(KonfigurasiLoading());
      final eith = await logout.call(NoParams());
      eith.fold((l) => emit(KonfigurasiFailure(l.message)), (r) => emit(KonfigurasiLogout()));
    });
    on<UbahKonfigurasiEvent>((event,emit) async {
      final currentState = state;
      if(currentState is KonfigurasiLoaded){
        emit(currentState.copyWith(status: Status.loading));
        loadingBloc.add(StartLoading());
        final eith = await updateKonfigurasi.call({
          'id':1,
          'buka':event.jamBuka+':00',
          'tutup':event.jamTutup+':00',
        });
        eith.fold((l) => emit(currentState.copyWith(status: Status.failure,errMessage: l.message)), (r) => emit(currentState.copyWith(status: Status.success)));
        loadingBloc.add(FinishLoading());
      }
    });
    on<UbahProfilRestoranEvent>((event,emit)async{
      final currentState = state;
      if(currentState is KonfigurasiLoaded){
        emit(currentState.copyWith(status: Status.loading));
        loadingBloc.add(StartLoading());
        final eith = await updateKonfigurasi.call({
          'id':1,
          'profil':event.profil,
          'link_gmaps':event.linkGmaps,
        });
        eith.fold((l) => emit(currentState.copyWith(status: Status.failure,errMessage: l.message)), (r) => emit(currentState.copyWith(status: Status.success)));
        loadingBloc.add(FinishLoading());
      }
    });
  }
}
