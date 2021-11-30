import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/data/models/satuan_model.dart';
import 'package:kopiek_resto/domain/entities/menu_params.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_menu.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_satuan.dart';
import 'package:kopiek_resto/domain/usecases/data-master/post_menu.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'menu_event.dart';
part 'menu_state.dart';

@injectable
class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final LoadingBloc loading;
  final GetSatuan satuan;
  final PostMenu menu;
  final GetMenu dataMenu;
  MenuBloc(this.loading, this.satuan, this.menu, this.dataMenu) : super(MenuInitial()) {
    on<FetchSatuan>((event, emit) async{
      emit(MenuLoading());
      final eith = await satuan.call(NoParams());
      eith.fold((l) => emit(MenuFailure(l.message)), (r) => emit(MenuLoadedAdd(Status.loaded, satuan: r)));
    });
    on<AddMenuEvent>((event,emit)async{
      loading.add(StartLoading());
      final currentState = state;
      if(currentState is MenuLoadedAdd){
        FormData form = FormData();
        form.files.add(MapEntry('foto', MultipartFile.fromFileSync(event.params.foto,filename: 'menu-${DateTime.now()}.jpg',)));
        form.fields.add(MapEntry('nama', event.params.nama));
        form.fields.add(MapEntry('harga', event.params.harga.toString()));
        form.fields.add(MapEntry('diskon', event.params.diskon.toString()));
        form.fields.add(MapEntry('id_satuan', event.params.idSatuan));
        form.fields.add(MapEntry('tipe', event.params.tipe));
        form.fields.add(MapEntry('stok', event.params.stok.toString()));
        final eith = await menu.call(form);
        eith.fold((l) => currentState.copyWith(status: Status.failure,errMessage: l.message), (r) => currentState.copyWith(status: Status.success));
      }
      loading.add(FinishLoading());
    });
    on<FetchMenuEvent>((event,emit)async{
      emit(MenuLoading());
      final eith = await dataMenu.call(NoParams());
      eith.fold((l) => emit(MenuFailure(l.message)), (r) => emit(MenuLoaded(r)));
    });
  }
}
