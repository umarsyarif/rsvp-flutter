import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/models/riwayat_poin_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/repositories/order_repository.dart';
import 'package:kopiek_resto/domain/usecases/usecase.dart';

@lazySingleton
class GetRiwayatPoin extends UseCase<List<DataRiwayatPoin>,String>{
  final OrderRepository _repository;
  GetRiwayatPoin(this._repository);
  @override
  Future<Either<AppError, List<DataRiwayatPoin>>> call(String params)async {
    return await _repository.getRiwayatPoin(params);
  }

}