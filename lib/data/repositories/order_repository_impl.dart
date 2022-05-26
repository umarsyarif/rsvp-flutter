import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/data_sources/order_remote_data_source.dart';
import 'package:kopiek_resto/data/models/order_model.dart';
import 'package:kopiek_resto/data/models/rating_model.dart';
import 'package:kopiek_resto/data/models/riwayat_poin_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/check_seat_params.dart';
import 'package:kopiek_resto/domain/entities/list_order_params.dart';
import 'package:kopiek_resto/domain/entities/pucrhase_order_params.dart';
import 'package:kopiek_resto/domain/entities/rating_params.dart';
import 'package:kopiek_resto/domain/entities/update_status_params.dart';
import 'package:kopiek_resto/domain/repositories/order_repository.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository{
  final OrderRemoteDataSource _dataSource;

  OrderRepositoryImpl(this._dataSource);
  @override
  Future<Either<AppError, String>> postOrder(PurchaseOrderParams params)async {
    try {
      String model = await _dataSource.postOrder(params.toJson());
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

  @override
  Future<Either<AppError, List<DataOrder>>> getAllOrder(ListOrderParams params)async {
    try {
      List<DataOrder> model = await _dataSource.getAllMenu(params);
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
      return const Left(AppError(AppErrorType.api, message: 'Terjadi kesalahan server'));
    }
  }

  @override
  Future<Either<AppError, DataOrder>> getDetailOrder(int id)async {
    try {
      DataOrder model = await _dataSource.getDetailMenu(id);
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
      return const Left(AppError(AppErrorType.api, message: 'Terjadi kesalahan server'));
    }
  }

  @override
  Future<Either<AppError, bool>> updateStatus(UpdateStatusParams params)async {
    try {
      bool model = await _dataSource.updateStatus(params.toJson());
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
      return const Left(AppError(AppErrorType.api, message: 'Terjadi kesalahan server'));
    }
  }

  @override
  Future<Either<AppError, List<DataRiwayatPoin>>> getRiwayatPoin(String idPengguna)async {
    try {
      List<DataRiwayatPoin> model = await _dataSource.getRiwayatPoin(idPengguna);
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
      return const Left(AppError(AppErrorType.api, message: 'Terjadi kesalahan server'));
    }
  }

  @override
  Future<Either<AppError, int>> getCountOrder(String status)async {
    try {
      int model = await _dataSource.getCountOrder(status);
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
      return const Left(AppError(AppErrorType.api, message: 'Terjadi kesalahan server'));
    }
  }

  @override
  Future<Either<AppError, bool>> checkRating(int idUser) async {
    try {
      bool model = await _dataSource.checkRating(idUser);
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
      return const Left(AppError(AppErrorType.api, message: 'Terjadi kesalahan server'));
    }
  }

  @override
  Future<Either<AppError, bool>> postRating(RatingParams params) async {
    try {
      bool model = await _dataSource.postRating(params.json);
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
      return const Left(AppError(AppErrorType.api, message: 'Terjadi kesalahan server'));
    }
  }

  @override
  Future<Either<AppError, List<DataRating>>> getAllRating() async {
    try {
      final model = await _dataSource.getAllRating();
      return  Right(model.data);
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
      return const Left(AppError(AppErrorType.api, message: 'Terjadi kesalahan server'));
    }
  }

  @override
  Future<Either<AppError, bool>> checkSeat(CheckSeatParams params)async {
    try {
      final model = await _dataSource.checkSeat(params.json);
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
      return const Left(AppError(AppErrorType.api, message: 'Terjadi kesalahan server'));
    }
  }
}