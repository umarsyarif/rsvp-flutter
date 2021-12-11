import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/login_model.dart';
import 'package:kopiek_resto/data/models/riwayat_poin_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/get_detail_user.dart';
import 'package:kopiek_resto/domain/usecases/client/get_riwayat_poin.dart';

part 'riwayat_poin_event.dart';
part 'riwayat_poin_state.dart';

@injectable
class RiwayatPoinBloc extends Bloc<RiwayatPoinEvent, RiwayatPoinState> {
  final GetRiwayatPoin riwayatPoin;
  final GetDetailUser user;
  RiwayatPoinBloc(this.riwayatPoin, this.user) : super(RiwayatPoinInitial()) {
    on<FetchRiwayatPoinEvent>((event, emit) async {
      emit(RiwayatPoinLoading());
      final eithUser = await user.call(NoParams());
      late User userData;
      eithUser.fold((l) => null, (r) {
        userData = r;
      });
      final eith = await riwayatPoin.call(userData.id.toString());
      eith.fold((l) => emit(RiwayatPoinFailure(l.message)), (r) => emit(RiwayatPoinLoaded(r)));
    });
  }
}
