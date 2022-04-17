import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/data_sources/satuan_remote_data_source.dart';
import 'package:kopiek_resto/data/models/konfigurasi_model.dart';
import 'package:kopiek_resto/data/models/menu_model.dart';
import 'package:kopiek_resto/data/models/satuan_model.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/menu_params.dart';
import 'package:kopiek_resto/domain/entities/satuan_params.dart';
import 'package:kopiek_resto/domain/entities/update_menu_params.dart';
import 'package:kopiek_resto/domain/entities/update_stok_params.dart';
import 'package:kopiek_resto/domain/entities/voucher_params.dart';
import 'package:kopiek_resto/domain/repositories/data_master_repository.dart';

@LazySingleton(as: DataMasterRepository)
class DataMasterRepositoryImpl implements DataMasterRepository{
  final SatuanRemoteDataSource _remoteDataSource;

  DataMasterRepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<AppError, bool>> postSatuan(SatuanParams params)async {
    try {
      bool model = await _remoteDataSource.postSatuan(params.toJson());
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
  Future<Either<AppError, List<DataSatuan>>> getSatuan() async{
    try {
      SatuanModel model = await _remoteDataSource.getSatuan();
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
  Future<Either<AppError, bool>> postMenu(FormData data)async {
    try {
      bool model = await _remoteDataSource.postMenu(data);
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
  Future<Either<AppError, List<DataMenu>>> getMenu(String params) async{
    try {
      MenuModel model = await _remoteDataSource.getMenu(params);
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
  Future<Either<AppError, DataKonfigurasi>> getKonfigurasi() async{
    try {
      KonfigurasiModel model = await _remoteDataSource.getKonfigurasi();
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
  Future<Either<AppError, bool>> postVoucher(FormData data)async {
    try {
      bool model = await _remoteDataSource.postVoucher(data);
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
  Future<Either<AppError, List<DataVoucher>>> getAllVoucher(String params) async {
    try {
      List<DataVoucher> model = await _remoteDataSource.getAllVoucher(params);
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
  Future<Either<AppError, bool>> updateKonfigurasi(Map<String, dynamic> params)async {
    try {
      bool model = await _remoteDataSource.updateKonfigurasi(params);
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
  Future<Either<AppError, bool>> updateNotifikasi(int params)async {
    try {
      bool model = await _remoteDataSource.updateNotifikasi(params);
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
  Future<Either<AppError, bool>> setActvieMenu(UpdateActiveMenuParams params)async {
    try {
      bool model = await _remoteDataSource.updateMenu(params.toJson());
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
  Future<Either<AppError, bool>> setActiveVoucher(UpdateActiveMenuParams params) async {
    try {
      bool model = await _remoteDataSource.updateVoucher(params.toJson());
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
  Future<Either<AppError, bool>> updateStokMenu(UpdateStokParams params) async {
    try {
      bool model = await _remoteDataSource.updateStokMenu(params.toJson());
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
  Future<Either<AppError, bool>> updateMenu(MenuParams params) async {
    try {
      bool model = await _remoteDataSource.updateMenu(params.toJson());
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
  Future<Either<AppError, String>> uploadFile(FormData data) async {
    try {
      String model = await _remoteDataSource.uploadFile(data);
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
  Future<Either<AppError, bool>> updateVoucher(VoucherParams params) async {
    try {
      bool model = await _remoteDataSource.updateVoucher(params.toJson());
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