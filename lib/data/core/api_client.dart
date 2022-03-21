import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:kopiek_resto/data/core/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  late final Dio dio;
  ApiClient({required this.dio}) {
    debugPrint('init dio');
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) =>
            requestInterceptor(options, handler)));

  }

  dynamic requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint(options.path);
    if (!options.path.contains('login')||!options.path.contains('register')) {
      //remove the auxiliary header
      options.headers.remove("requiresToken");
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      String? token = '';
      token = sharedPreferences.getString("token");
      options.headers.addAll({"Authorization": "Bearer $token"});
      debugPrint(token);
    }
    return handler.next(options);
  }

  dynamic get(String path) async {
    String url =
        ApiConstants.baseUrl + path;
    final response = await dio.get(url);
    return jsonDecode(jsonEncode(response.data));
  }

  dynamic post(String path, var data) async {
    String url = ApiConstants.baseUrl + path;
    final response = await dio.post(url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
        data: jsonEncode(data));
    debugPrint(jsonEncode(data));
    return jsonDecode(jsonEncode(response.data));

  }
  dynamic patch(String path, var data) async {
    String url = ApiConstants.baseUrl + path;
    final response = await dio.patch(url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
        data: jsonEncode(data));
    debugPrint(jsonEncode(data));
    return jsonDecode(jsonEncode(response.data));

  }
  dynamic postFormData(String path, FormData data) async {
    String url = ApiConstants.baseUrl + path;
    final response = await dio.post(url,
        options: Options(headers: {
          // 'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
        data: data);

    return jsonDecode(jsonEncode(response.data));

  }
}
