import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/konfigurasi_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/logout.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_konfigurasi.dart';

part 'konfigurasi_event.dart';
part 'konfigurasi_state.dart';

@injectable
class KonfigurasiBloc extends Bloc<KonfigurasiEvent, KonfigurasiState> {
  final GetKonfigurasi konfigurasi;
  final Logout logout;
  KonfigurasiBloc(this.konfigurasi, this.logout) : super(KonfigurasiInitial()) {
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
  }
}
