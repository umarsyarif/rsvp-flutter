import 'package:dio/dio.dart';
import 'package:glutton/glutton.dart';

import '../../../constants/api.dart';

Dio dio = new Dio();

Dio dioInterceptor() {
  dio.options.baseUrl = API_URL;
  dio.options.connectTimeout = API_CONNECTION_TIMEOUT;
  dio.options.receiveTimeout = API_RECEIVE_TIMEOUT;

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        dio.options.headers['Accept'] = 'application/json';

        final String token = await Glutton.vomit('token_sanctum');

        if (token != null) {
          dio.options.headers['Authorization'] = 'Bearer ' + token;
        }

        return options;
      },
    ),
  );

  return dio;
}
