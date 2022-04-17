import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/voucher_params.dart';
import 'package:kopiek_resto/domain/repositories/data_master_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class UpdateVoucher extends UseCase<bool,VoucherParams>{
  final DataMasterRepository _repository;

  UpdateVoucher(this._repository);
  @override
  Future<Either<AppError, bool>> call(VoucherParams params) async {
    return await _repository.updateVoucher(params);
  }

}