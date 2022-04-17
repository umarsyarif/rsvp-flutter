import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/data/models/satuan_model.dart';
import 'package:kopiek_resto/domain/entities/menu_params.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_satuan.dart';
import 'package:kopiek_resto/domain/usecases/data-master/update_menu.dart';
import 'package:kopiek_resto/domain/usecases/data-master/upload_file.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'update_menu_event.dart';
part 'update_menu_state.dart';

@injectable
class UpdateMenuBloc extends Bloc<UpdateMenuEvent, UpdateMenuState> {
  final UpdateMenu updateMenu;
  final UploadFile uploadFile;
  final GetSatuan satuan;
  final LoadingBloc loading;
  UpdateMenuBloc(this.updateMenu, this.uploadFile, this.satuan, this.loading) : super(UpdateMenuInitial()) {
    on<FetchUpdateMenuEvent>((event, emit) async {
      emit(UpdateMenuLoading());
      final eith = await satuan.call(NoParams());
      eith.fold((l) => emit(UpdateMenuFailure(l.message)), (r) => emit(UpdateMenuLoaded(Status.loaded, satuan: r)));
    });
    on<PostUpdateMenuEvent>((event,emit)async{
      loading.add(StartLoading());
      final currentState = state;
      if(currentState is UpdateMenuLoaded){
        if(!event.params.foto.contains('https')){
          FormData params = FormData();
          params.files.add(MapEntry('foto', MultipartFile.fromFileSync(event.params.foto,filename: 'menu-${DateTime.now()}.jpg',)));
          final eithUpload = await uploadFile.call(params);
          if(eithUpload.isLeft()){
            emit(currentState.copyWith(status: Status.failure,errMessage: 'Terjadi kesalahan upload file'));
          }else{
            event.params.foto = eithUpload.toOption().toNullable()!;
            final eith = await updateMenu.call(event.params);
            eith.fold((l) => emit(currentState.copyWith(status: Status.failure,errMessage: l.message)), (r) =>emit( currentState.copyWith(status: Status.success)));
          }
        }else{
          final eith = await updateMenu.call(event.params);
          eith.fold((l) => emit(currentState.copyWith(status: Status.failure,errMessage: l.message)), (r) =>emit( currentState.copyWith(status: Status.success)));
        }
      }
      loading.add(FinishLoading());
    });
  }
}
