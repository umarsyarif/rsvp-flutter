import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/data/models/satuan_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/entities/satuan_params.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_satuan.dart';
import 'package:kopiek_resto/domain/usecases/data-master/post_satuan.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'satuan_event.dart';
part 'satuan_state.dart';

@injectable
class SatuanBloc extends Bloc<SatuanEvent, SatuanState> {
  final PostSatuan satuan;
  final GetSatuan getSatuan;
  final LoadingBloc loadingBloc;
  SatuanBloc(this.satuan, this.loadingBloc, this.getSatuan) : super(SatuanInitial()) {
    on<AddSatuan>((event, emit) async{
      loadingBloc.add(StartLoading());
      final currentState = state;
      if(currentState is SatuanLoaded){
        final eith = await satuan.call(event.params);
        eith.fold((l) => emit(currentState.copyWith(status: Status.failure,errMessage: l.message)), (r) => emit(currentState.copyWith(status: Status.success)));
      }
      loadingBloc.add(FinishLoading());
    });
    on<FetchSatuanEvent>((event,emit)async{
      emit(SatuanLoading());
      final eith = await getSatuan.call(NoParams());
      eith.fold((l) => emit(SatuanFailure(l.message)), (r) => emit(SatuanLoaded(Status.loaded, r)));
    });
  }
}
