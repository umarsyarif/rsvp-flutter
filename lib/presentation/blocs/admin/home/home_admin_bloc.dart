import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/login_model.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/get_detail_user.dart';
import 'package:kopiek_resto/domain/usecases/auth/logout.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_all_voucher.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_menu.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_notifikasi_user.dart';
import 'package:kopiek_resto/domain/usecases/order/count_order.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'home_admin_event.dart';
part 'home_admin_state.dart';

@injectable
class HomeAdminBloc extends Bloc<HomeAdminEvent, HomeAdminState> {
  final Logout logout;
  final LoadingBloc loadingBloc;
  final CountOrder count;
  final GetAllVoucher getAllVoucher;
  late int proses,paid,selesai,notifikasi;
  late List<DataVoucher> voucher;
  final GetNotifikasiUser getNotifikasiUser;
  final GetMenu dataMenu;
  final GetDetailUser getDetailUser;
  HomeAdminBloc(this.logout, this.loadingBloc, this.count, this.dataMenu, this.getNotifikasiUser, this.getDetailUser, this.getAllVoucher) : super(HomeAdminInitial()) {
    on<FetchHomeAdmin>((event, emit) async{
      emit(HomeAdminLoading());
      final eithProses = await count.call('diproses');
      final eithPaid = await count.call('sudah bayar');
      final eithUser = await getDetailUser.call(NoParams());
      final eithVoucher = await getAllVoucher.call('');
      late User user;
      eithUser.fold((l) => null, (r){
        user = r;
      });
      final eithNotifikasi = await getNotifikasiUser.call(user.id);
      if(eithProses.isLeft()||eithPaid.isLeft()||eithNotifikasi.isLeft()||eithVoucher.isLeft()){
        emit(const HomeAdminFailure('Terjadi kesalahan, coba lagi'));
      }else{
        eithProses.fold((l) => null, (r){
          proses = r;
        });
        eithPaid.fold((l) => null, (r){
          paid = r;
        });
        notifikasi = eithNotifikasi.toOption().toNullable()!.where((element) => element.seen==0).length;
        voucher = eithVoucher.toOption().toNullable()!;
        final eithMenu = await dataMenu.call('');
        eithMenu.fold((l) => emit(HomeAdminFailure(l.message)), (r){
          emit(HomeAdminLoaded(proses, paid,notifikasi,r.where((element) => element.tipe=='makanan').toList(),r.where((element) => element.tipe=='minuman').toList(),voucher));
        });
      }
    });
    on<LogoutEvent>((event, emit) async{
      loadingBloc.add(StartLoading());
      final eith = await logout.call(NoParams());
      eith.fold((l) => null, (r) => emit(HomeAdminLogout()));
      loadingBloc.add(FinishLoading());
    });
  }
}
