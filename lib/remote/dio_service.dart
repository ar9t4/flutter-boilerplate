import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/model/data/remote/user.dart';
import 'package:flutter_boilerplate/remote/end_points.dart';
import 'package:flutter_boilerplate/storage/secure_storage.dart';

class DioService {
  static final DioService _instance = DioService._internal();

  late Dio _dio;
  Dio get dio => _dio;
  bool _isRefreshing = false;
  void Function(User)? onTokenRefreshed;

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
        connectTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60));
    _dio = Dio(baseOptions);
    // add interceptors
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: _onRequest, onError: _onError));
    // recommended to add log interceptor at the end
    if (kDebugMode) {
      _dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await SecureStorage().getAccessToken();
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<void> _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['Authorization'] == null) {
      options.headers = await _getHeaders();
    }
    return handler.next(options);
  }

  Future<void> _onError(
      DioException err, ErrorInterceptorHandler handler) async {
    final refreshToken = await SecureStorage().getRefreshToken();
    final is401 = err.response?.statusCode == 401;
    if (is401 && refreshToken != null) {
      if (_isRefreshing) {
        // if already refreshing, wait until refresh completes
        while (_isRefreshing) {
          await Future.delayed(const Duration(seconds: 1));
        }
        try {
          // after refresh done, retry with new token
          final retryResponse = await _retryRequest(err.requestOptions);
          return handler.resolve(retryResponse);
        } catch (e) {
          return handler.reject(err);
        }
      }
      try {
        _isRefreshing = true;
        // seprate dio instance to avoid intercepters deadlock
        final refreshDio = Dio(BaseOptions(baseUrl: _dio.options.baseUrl));
        final response = await refreshDio
            .post(EndPoints.refreshToken, data: {'refreshToken': refreshToken});
        if (response.statusCode == 200) {
          final user = User.fromJson(response.data["data"]);
          // save updated user in secure storage to update access and refresh tokens
          await SecureStorage().saveUser(user);
          onTokenRefreshed?.call(user);
          // retry the original request
          final cloneRequest = await _retryRequest(err.requestOptions);
          return handler.resolve(cloneRequest);
        } else {
          // failed to refresh token, force logout, logout is handled in showErrorDialog
          // of BaseState based on 401 in error parameter
          return handler.reject(err);
        }
      } catch (e) {
        return handler.reject(err);
      } finally {
        _isRefreshing = false;
      }
    } else {
      return handler.next(err);
    }
  }

  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    // update access token in requestOptions
    final updatedAccessToken = await SecureStorage().getAccessToken();
    final updatedRefreshToken = await SecureStorage().getRefreshToken();
    final updatedHeaders = Map<String, dynamic>.from(requestOptions.headers);
    // update access token
    updatedHeaders['Authorization'] = 'Bearer $updatedAccessToken';
    final data = requestOptions.data;
    // update refresh token if requestOptions.data has that key
    if (data is Map && data.containsKey('refreshToken')) {
      requestOptions.data['refreshToken'] = updatedRefreshToken;
    }
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      extra: requestOptions.extra,
    );
    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<T> request<T>({
    required String path,
    required String method,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
    required Function(dynamic) parser,
  }) async {
    try {
      // default delay for smooth data states (loading, data and error) transition
      await Future.delayed(Duration(seconds: 1));
      // default + auth headers
      final authHeaders = await _getHeaders();
      // merge incoming headers (if any) with auth headers
      final mergedHeaders = {
        ...authHeaders,
        if (headers != null) ...headers,
      };
      final isMultipart = data is FormData;
      if (isMultipart) {
        mergedHeaders.remove('Content-Type');
      }
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method, headers: mergedHeaders),
      );
      return parser(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw AppNetworkException(
          message: e.toString(), statusCode: -1, responseData: data);
    }
  }

  AppNetworkException _handleDioError(DioException e) {
    final statusCode = e.response?.statusCode ?? -1;
    final data = e.response?.data;
    String message = "";
    if (data is Map<String, dynamic>) {
      message = (e.response?.data["error"] is String
              ? e.response?.data["error"]
              : (e.response?.data["error"] as Map<String, dynamic>? ??
                      e.response?.data["errors"] as Map<String, dynamic>?)
                  ?.values
                  .cast<List>()
                  .expand((list) => list)
                  .cast<String>()
                  .toList()
                  .first) ??
          e.response?.data["message"] ??
          "";
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = "Request timed out. Please try again.";
        break;
      case DioExceptionType.sendTimeout:
        message = "Request timed out. Please try again.";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Request timed out. Please try again.";
        break;
      case DioExceptionType.badResponse:
        if (message.isEmpty) {
          message = "Server is not reachable. Please try again later.";
        }
        break;
      case DioExceptionType.connectionError:
        if (e.error is SocketException) {
          message = "No internet connection.";
        } else {
          message = "Network error occurred.";
        }
        break;
      case DioExceptionType.cancel:
        message = "Request was cancelled.";
        break;
      case DioExceptionType.unknown:
        message = "An unknown error occurred.";
        break;
      default:
        message = "An unknown error occurred.";
        break;
    }
    return AppNetworkException(
        message: message, statusCode: statusCode, responseData: data);
  }
}

class AppNetworkException implements Exception {
  final String message;
  final int statusCode;
  final dynamic responseData;

  AppNetworkException(
      {required this.message,
      required this.statusCode,
      required this.responseData});

  @override
  String toString() => 'AppNetworkException($message)';
}
