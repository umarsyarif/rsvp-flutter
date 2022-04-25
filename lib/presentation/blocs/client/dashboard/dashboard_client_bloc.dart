import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/login_model.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/get_detail_user.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_all_voucher.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_menu.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_notifikasi_user.dart';

part 'dashboard_client_event.dart';
part 'dashboard_client_state.dart';

@injectable
class DashboardClientBloc extends Bloc<DashboardClientEvent, DashboardClientState> {
  final GetAllVoucher voucher;
  final GetDetailUser user;
  final GetMenu getMenu;
  final GetNotifikasiUser notifikasi;

  DashboardClientBloc(this.voucher, this.user, this.notifikasi, this.getMenu) : super(DashboardClientInitial()) {
    on<FetchDashboardClientEvent>((event, emit) async {
      emit(DashboardClientLoading());
      final eith = await voucher.call('1');
      final eithMenu = await getMenu.call('1');
      final eithUser = await user.call(NoParams());
      User userData = eithUser.toOption().toNullable()!;
      final eithNotif = await notifikasi.call(userData.id);
      if(eithNotif.isLeft()||eithMenu.isLeft()){
        emit(const DashboardClientFailure('Terjadi kesalahan'));
      }else {
        List<DataMenu> dataMenu = eithMenu.toOption().toNullable()!;
        dataMenu = dataMenu.map((e){
          e.harga = (e.harga - ((e.diskon*e.harga)/100)).ceil();
          return e;
        }).toList();
        final notif = eithNotif.toOption().toNullable()!.where((element) => element.seen==0).length;
        eith.fold((l) => emit(DashboardClientFailure(l.message)),
            (r) => emit(DashboardClientLoaded(r,userData,notif,dataMenu.where((element) => element.tipe=='makanan').toList(),dataMenu.where((element) => element.tipe=='minuman').toList())));
      }
    });
  }
}
