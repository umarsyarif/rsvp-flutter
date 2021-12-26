import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/no_params.dart';
import 'package:kopiek_resto/domain/entities/voucher_params.dart';
import 'package:kopiek_resto/domain/usecases/data-master/get_all_voucher.dart';
import 'package:kopiek_resto/domain/usecases/data-master/post_voucher.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'voucher_event.dart';
part 'voucher_state.dart';

@injectable
class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  final LoadingBloc loading;
  final PostVoucher voucher;
  final GetAllVoucher allVoucher;
  VoucherBloc(this.loading, this.voucher, this.allVoucher) : super(VoucherInitial()) {
    on<FetchAllVoucherEvent>((event,emit)async{
      emit(VoucherLoading());
      final eith = await allVoucher.call(NoParams());
      eith.fold((l) => emit(VoucherFailure(l.message)), (r) => emit(VoucherLoaded(r)));
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
  }
}
