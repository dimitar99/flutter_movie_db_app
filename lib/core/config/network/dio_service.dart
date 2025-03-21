import 'package:dio/dio.dart';
import 'package:flutter_movie_db_app/core/config/env/env_constants.dart';
import 'package:flutter_movie_db_app/core/config/network/interceptors/auth_interceptor.dart';
import 'package:flutter_movie_db_app/core/config/network/interceptors/logger_interceptor.dart';

class DioService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: Environment.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
    ),
  )..interceptors.addAll([AuthInterceptor(), LoggerInterceptor()]);
}
