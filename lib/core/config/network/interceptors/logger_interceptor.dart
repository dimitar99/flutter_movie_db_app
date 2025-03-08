import 'dart:developer';

import 'package:dio/dio.dart';

class LoggerInterceptor implements Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('[DioError] - ${err.response?.statusCode} ${err.response?.statusMessage} -- ${err.requestOptions.path}');
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('[DioRequest] - [${options.method}] ${options.baseUrl + options.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('[DioResponse] - [${response.statusCode}] ${response.statusMessage} - ${response.data}');
    handler.next(response);
  }
}
