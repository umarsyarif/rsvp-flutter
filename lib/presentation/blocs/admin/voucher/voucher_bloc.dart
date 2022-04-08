import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/entities/update_menu_params.dart';
import 'package:kopiek_resto/domain/entities/voucher_params.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_all_voucher.dart';
import 'package:kopiek_resto/domain/usecases/data-master/post_voucher.dart';
import 'package:kopiek_resto/domain/usecases/data-master/set_active_voucher.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'voucher_event.dart';
part 'voucher_state.dart';

@injectable
class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  final LoadingBloc loading;
  final PostVoucher voucher;
  final GetAllVoucher allVoucher;
  final SetActiveVoucher setActiveVoucher;
  VoucherBloc(this.loading, this.voucher, this.allVoucher, this.setActiveVoucher) : super(VoucherInitial()) {
    on<FetchAllVoucherEvent>((event,emit)async{
      emit(VoucherLoading());
      final eith = await allVoucher.call('');
      eith.fold((l) => emit(VoucherFailure(l.message)), (r) => emit(VoucherLoaded(r,Status.loaded,'')));
    });
    on<CreateVoucherEvent>((event, emit) async{
      loading.add(StartLoading());
        FormData form = FormData();
        form.files.add(MapEntry('foto', MultipartFile.fromFileSync(event.params.foto,filename: 'menu-${DateTime.now()}.jpg',)));
        form.fields.add(MapEntry('label', event.params.label));
        form.fields.add(MapEntry('diskon', event.params.diskon.toString()));
        final eith = await voucher.call(form);
        eith.fold((l) => emit(VoucherFailure(l.message)), (r) => emit(VoucherCreated()));

      loading.add(FinishLoading());
    });
    on<UpdateVoucherEvent>((event,emit)async{
      final currentState = state;
      if(currentState is VoucherLoaded){
        loading.add(StartLoading());
        final eith = await setActiveVoucher.call(event.params);
        eith.fold((l) => emit(currentState.copyWith(status: Status.failure,errMessage: l.message)), (r) => emit(currentState.copyWith(status: Status.success)));
        loading.add(FinishLoading());
        add(FetchAllVoucherEvent());
      }
    });
  }
}
