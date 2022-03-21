import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/auth/logout.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_menu.dart';
import 'package:kopiek_resto/domain/usecases/order/count_order.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'home_admin_event.dart';
part 'home_admin_state.dart';

@injectable
class HomeAdminBloc extends Bloc<HomeAdminEvent, HomeAdminState> {
  final Logout logout;
  final LoadingBloc loadingBloc;
  final CountOrder count;
  late int proses,paid,selesai;
  final GetMenu dataMenu;
  HomeAdminBloc(this.logout, this.loadingBloc, this.count, this.dataMenu) : super(HomeAdminInitial()) {
    on<FetchHomeAdmin>((event, emit) async{
      emit(HomeAdminLoading());
      final eithProses = await count.call('diproses');
      final eithPaid = await count.call('selesai');
      final eithSelesai = await count.call('sudah bayar');
      if(eithProses.isLeft()||eithPaid.isLeft()||eithSelesai.isLeft()){
        emit(const HomeAdminFailure('Terjadi kesalahan, coba lagi'));
      }else{
        eithProses.fold((l) => null, (r){
          proses = r;
        });
        eithPaid.fold((l) => null, (r){
          paid = r;
        });
        eithSelesai.fold((l) => null, (r){
          selesai = r;
        });
        final eithMenu = await dataMenu.call(NoParams());
        eithMenu.fold((l) => emit(HomeAdminFailure(l.message)), (r){
          emit(HomeAdminLoaded(proses, paid, selesai,r.where((element) => element.tipe=='makanan').toList(),r.where((element) => element.tipe=='minuman').toList()));
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
