import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/common/constants/enums.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/voucher_params.dart';
import 'package:kopiek_resto/domain/usecases/data-master/update_voucher.dart';
import 'package:kopiek_resto/domain/usecases/data-master/upload_file.dart';
import 'package:kopiek_resto/presentation/blocs/loading/loading_bloc.dart';

part 'update_voucher_event.dart';
part 'update_voucher_state.dart';

@injectable
class UpdateVoucherBloc extends Bloc<UpdateVoucherEvent, UpdateVoucherState> {
  final LoadingBloc loading;
  final UpdateVoucher updateVoucher;
  final UploadFile uploadFile;
  UpdateVoucherBloc(this.loading, this.updateVoucher, this.uploadFile) : super(UpdateVoucherInitial()) {
    on<UpdateDataVoucherEvent>((event, emit) async {
      loading.add(StartLoading());
        if(!event.params.foto.contains('https')){
          FormData params = FormData();
          params.files.add(MapEntry('foto', MultipartFile.fromFileSync(event.params.foto,filename: 'menu-${DateTime.now()}.jpg',)));
          final eithUpload = await uploadFile.call(params);
          if(eithUpload.isLeft()){
            emit(const UpdateVoucherFailure('Terjadi kesalahan upload file'));
          }else{
            event.params.foto = eithUpload.toOption().toNullable()!;
            final eith = await updateVoucher.call(event.params);
            eith.fold((l) => emit(UpdateVoucherFailure(l.message)), (r) =>emit(UpdateVoucherCreated()));
          }
        }else{
          final eith = await updateVoucher.call(event.params);
          eith.fold((l) => emit(UpdateVoucherFailure(l.message)), (r) =>emit(UpdateVoucherCreated()));
        }
      loading.add(FinishLoading());
    });
  }
}
