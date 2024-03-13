import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/remote/end_points.dart';

class DioService {
  static final DioService _instance = DioService._internal();

  late Dio _dio;
  Dio get dio => _dio;

  factory DioService() {
    return _instance;
  }

  DioService._internal() {
    _init();
  }

  void _init() {
    // configure dio with default options
    final baseOptions = BaseOptions(
        baseUrl: EndPoints.baseUrl,
        contentType: EndPoints.contentType,
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10));
    _dio = Dio(baseOptions);
    // add interceptors
    _dio.interceptors.add(CustomInterceptors());
    // recommended to add log interceptor at the end
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(requestBody: false, responseBody: false));
    }
  }
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
