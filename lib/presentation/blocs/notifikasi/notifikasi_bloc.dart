import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/extension/preferences_helper.dart';
import 'package:kopiek_resto/data/models/login_model.dart';
import 'package:kopiek_resto/data/models/notifikasi_model.dart';
import 'package:kopiek_resto/di/get_it.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/get_detail_user.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_notifikasi_user.dart';

part 'notifikasi_event.dart';
part 'notifikasi_state.dart';

@injectable
class NotifikasiBloc extends Bloc<NotifikasiEvent, NotifikasiState> {
  final GetNotifikasiUser getNotifikasiUser;
  final GetDetailUser getDetailUser;
  NotifikasiBloc(this.getNotifikasiUser, this.getDetailUser) : super(NotifikasiInitial()) {
    on<FetchNotifikasiEvent>((event, emit)async {
      emit(NotifikasiLoading());
      final eithUser = await getDetailUser.call(NoParams());
      late User user;
      eithUser.fold((l) => null, (r){
        user = r;
      });
      final eith = await getNotifikasiUser.call(user.id);
      eith.fold((l) => emit(NotifikasiFailure(l.message)), (r) => emit(NotifikasiLoaded(r)));
    });
  }
}
