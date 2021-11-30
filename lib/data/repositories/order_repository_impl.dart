import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/data_sources/order_remote_data_source.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/pucrhase_order_params.dart';
import 'package:kopiek_resto/domain/repositories/order_repository.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository{
  final OrderRemoteDataSource _dataSource;

  OrderRepositoryImpl(this._dataSource);
  @override
  Future<Either<AppError, bool>> postOrder(PurchaseOrderParams params)async {
    try {
      bool model = await _dataSource.postOrder(params.toJson());
      return  Right(model);
    } on SocketException {
      return const Left(AppError(AppErrorType.network,
          message: 'Gagal menghubungkan ke server, cek koneksi internet anda'));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        return const Left(AppError(AppErrorType.network,
            message: 'Gagal menghubungkan ke server, cek koneksi internet anda'));
      }
      return Left(
          AppError(AppErrorType.api, message: e.response?.data['message'] ?? 'Terjadi kesalahan server'));
    } on Exception {
      return const Left(AppError(AppErrorType.database, message: 'Terjadi kesalahan server'));
    }
  }
}