import 'dart:io';
import '../../../data/network/interceptors/dio_interceptors_auth.dart';
import 'package:dio/dio.dart';
import 'package:glutton/glutton.dart';

import '../Exceptions/api_exception.dart';
import '../../../models/User.dart';

class AuthRepository {
  Dio _dio = dioInterceptorAuth();


  Future auth(String email, String password) async {
    try {

      final response = await _dio.post('auth/token', data: {
        'email': email,
        'password': password,
      });

      saveToken(response.data['token']);
      return true;
    } on DioError catch (e) {
      Future.error({});

      ApiException(e.response);
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    try {
      await _dio.post('auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });

      return true;
    } on DioError catch (e) {
      Future.error({});

      ApiException(e.response);
      return false;
    }
  }

  Future getMe() async {
    final String token = await Glutton.vomit('token_sanctum');
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer ' + token;
    }

    try {
      final response = await _dio.get('auth/me');

      return User.fromJson(response.data['data']);
    } on DioError catch (e) {
      Future.error({});

      ApiException(e.response);
    }
  }

  Future logout() async {
    final String token = await Glutton.vomit('token_sanctum');
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer ' + token;
    }

    try {
      await _dio.post('auth/logout');
    } on DioError catch (e) {
      Future.error({});

      ApiException(e.response);
    }

    await deleteToken();
  }

  Future saveToken(String token) async {
    return await Glutton.eat('token_sanctum', token);
  }

  Future deleteToken() async {
    await Glutton.digest('token_sanctum');
  }
}
