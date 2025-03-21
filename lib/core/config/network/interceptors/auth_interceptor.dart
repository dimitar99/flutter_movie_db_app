import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_movie_db_app/core/config/env/env_constants.dart';

class AuthInterceptor implements Interceptor {
  AuthInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[HttpHeaders.authorizationHeader] = 'Bearer ${Environment.apiToken}';
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
