import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kopiek_resto/data/data_sources/auth_local_data_source.dart';
import 'package:kopiek_resto/data/data_sources/auth_remote_data_source.dart';
import 'package:kopiek_resto/data/models/login_model.dart';
import 'package:kopiek_resto/data/models/notifikasi_model.dart';
import 'package:kopiek_resto/data/models/voucher_model.dart';
import 'package:kopiek_resto/domain/entities/app_error.dart';
import 'package:kopiek_resto/domain/entities/login_params.dart';
import 'package:kopiek_resto/domain/entities/register_params.dart';
import 'package:kopiek_resto/domain/repositories/auth_repository.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _localDataSource;
  AuthRepositoryImpl(this._remote, this._localDataSource);
  @override
  Future<Either<AppError, String>> login(LoginParams params) async{
    try {
      LoginModel model = await _remote.login(params.toJson);
      await _localDataSource.saveSession(model.user,model.token);
      OneSignal.shared.sendTag('idUser', model.user.id);
      return  Right(model.user.role);
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
  Future<Either<AppError, bool>> checkSession()async {
    try {
      bool model = await _localDataSource.checkLogin();
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
  Future<Either<AppError, User>> getDetailUser() async{
    try {
      User model = await _localDataSource.getDetailUser();
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
  Future<Either<AppError, bool>> register(RegisterParams params) async{
    try {
      bool model = await _remote.register(params.toJson());
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
  Future<Either<AppError, bool>> logout()async {
    try {
      bool model = await _localDataSource.logout();
      Map <String,dynamic> osKeys = await OneSignal.shared.getTags();
      OneSignal.shared.deleteTags(osKeys.keys.toList());
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
  Future<Either<AppError, List<DataNotifikasi>>> getNotifikasiUser(int params)async {
    try {
      NotifikasiModel model = await _remote.getNotifikasiUser(params);
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
      return const Left(AppError(AppErrorType.database, message: 'Terjadi kesalahan server'));
    }
  }

  @override
  Future<Either<AppError, int>> getPoinPengguna(int params)async {
    try {
      int model = await _remote.getUserPoin(params);
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
  Future<Either<AppError, DataVoucher?>> getRedeemedVoucher() async {
    try {
      DataVoucher? model = await _localDataSource.getRedeemedVoucher();
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
  Future<Either<AppError, bool>> saveRedeemedVoucher(DataVoucher params) async {
    try {
      bool model = await _localDataSource.saveRedeemedVoucher(params.toJson());
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